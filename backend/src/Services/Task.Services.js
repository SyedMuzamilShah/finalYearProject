import { STATUS_CODES } from "../../constant.js";
import { employeeModel } from "../Models/Employee.Model.js";
import { organizationModel } from "../Models/Organization.Model.js";
import { taskModel } from "../Models/Task.Model.js";
import { taskAssignmentModel, taskAssignmentStatus, taskAssignmentValidateMethod } from "../Models/TaskAssignment.Model.js";
import { ErrorResponse } from "../Utils/Error.js";
import { faceVerification } from "../Utils/FaceBioHandler.js";
import { calculateDistance, getDistanceInMeters } from "../Utils/Distance_Calculator.js"
import { isValidObjectId } from "mongoose";
import path from "path"
import { handleFaceVerification, setSubmissionInfo, validateEmployee, validateTask, validateTaskAssignment, verifyLocation } from "./TaskFunction/TaskCompletion.Method.js";
const handleDatabaseError = (error) => {
    console.error("Database error:", error.message);
    throw new ErrorResponse(500, error.message ?? "An unexpected database error occurred");
};

export const taskCreateServices = async (dataObject) => {
    try {
        const {
            adminId,
            title,
            description,
            organizationId,
            aroundDistanceMeter,
            location,
            dueDate,
        } = dataObject;

        let query
        query = isValidObjectId(organizationId)
            ? { _id: organizationId, createdBy: adminId }
            : { organizationId, createdBy: adminId };

        // 🔍 Check if organization exists
        const org = await organizationModel.findOne(query);

        if (!org) throw new ErrorResponse(400, 'Organization not found');

        // ✅ Check for duplicate task
        const existingTask = await taskModel.findOne({
            title,
            description,
            organizationId: org._id,
            location,
            dueDate: new Date(dueDate),
        });
        if (existingTask) {
            throw new ErrorResponse(400, 'A task with this title and due date already exists for this organization');
        }

        const taskData = {
            organizationId: org._id,
            adminId,
            title,
            description,
            dueDate: new Date(dueDate),
            status: "CREATED",
        };

        if (location) {
            taskData.location = location;
        }
        if (aroundDistanceMeter) {
            taskData.aroundDistanceMeter = aroundDistanceMeter;
        }

        const newTask = new taskModel(taskData);
        const task = await newTask.save();

        return { task };
    } catch (error) {
        handleDatabaseError(error);
    }
};

export const taskUpdateService = async (dataObject) => {
    try {
        const { taskId } = dataObject;
        const task = await taskModel.findById(taskId);
        if (!task) {
            throw new ErrorResponse(STATUS_CODES.NOT_FOUND, "Task not found");
        }

        const allowedFields = ['title', 'name', 'description', 'status', 'dueDate', 'location'];

        for (const key of allowedFields) {
            if (dataObject[key] !== undefined) {
                task[key] = dataObject[key];
            }
        }
        await task.save();
        console.log(task)
        return { task };
    } catch (err) {
        throw new ErrorResponse(STATUS_CODES.NOT_FOUND, err.message);
    }
};

export const taskReadService = async () => {
    try {
        const tasks = await taskModel.find();
        return { tasks };
    } catch (error) {
        console.error("Error in taskReadService:", error.message);
        return {
            success: false,
            message: error.message || "Failed to fetch tasks",
            data: null,
        };
    }
};

export const taskDeleteService = async (dataObject) => {
    try {
        const { taskId } = dataObject;

        const response = await taskModel.findByIdAndDelete(taskId);
        // taskModel.deleteMany

        // if task is deleted then delete all the task from task assignment model
        // if the task is deleted then it will be deleted from that corresponding assignment employees
        await taskAssignmentModel.deleteMany({ taskId: taskId });

        if (!response) throw new ErrorResponse(STATUS_CODES.NOT_FOUND, "Task not found");
        return true;
    } catch (err) {
        throw new ErrorResponse(500, err.message ?? 'Unexpected error occurred');
    }
};

export const taskAssignService = async (dataObject) => {
    let { employeesId, taskId, adminId, deadline } = dataObject;
    if (!Array.isArray(employeesId)) {
        employeesId = [employeesId];
    }

    try {
        console.log(dataObject)
        const task = await taskModel.findById(taskId);
        if (!task) throw new ErrorResponse(404, "Task not found");

        const alreadyAssigned = [];
        const newAssignments = [];

        for (const employee of employeesId) {
            const { employeeId, pictureAllowed, faceVerification } = employee;

            const employeeExists = await employeeModel.findOne({
                _id: employeeId,
                organizationId: task.organizationId,
            });

            if (!employeeExists) {
                throw new ErrorResponse(404, `Employee with ID ${employeeId} not found`);
            }

            const exists = await taskAssignmentModel.findOne({ taskId, employeeId });
            if (exists) {
                alreadyAssigned.push(employeeId);
                continue;
            }

            const assignment = await taskAssignmentModel.create({
                assignedBy: adminId,
                employeeId,
                taskId,
                deadline: deadline ?? task.dueDate,
                allowPicture: pictureAllowed,
                faceVerification : faceVerification
            });

            newAssignments.push(assignment);
        }


        if (newAssignments.length > 0) {
            task.status = "ASSIGNED";
            await task.save();
        }

        return {
            assignments: newAssignments,
            alreadyAssigned,
        };
    } catch (err) {
        throw new ErrorResponse(400, err.message);
    }
};

export const taskDeAssignServices = async (dataObject) => {
    try {
        const { employeeId, taskId } = dataObject;
        const task = await taskModel.findById(taskId);
        if (!task) throw new ErrorResponse(404, "Task not found");

        const assignment = await taskAssignmentModel.findOne({ taskId, employeeId });
        if (!assignment) throw new ErrorResponse(400, "Task not assigned to this employee");

        await taskAssignmentModel.findByIdAndDelete(assignment._id);

        task.status = "CREATED"; // Revert the task status back to "CREATED"
        await task.save();

        return { task };
    } catch (err) {
        throw new ErrorResponse(400, err.message);
    }
};

export const taskVerifiedServices = async (dataObject) => {
    try {
        let { employeesId, taskId } = dataObject;
        if (!Array.isArray(employeesId)) {
            employeesId = [employeesId];
        }

        const taskAssignments = await taskAssignmentModel.find({
            taskId,
            employeeId: { $in: employeesId },
        });

        if (taskAssignments.length === 0) {
            throw new ErrorResponse(404, "No task assignments found for given employee(s)");
        }

        const updatedAssignments = [];

        for (const assignment of taskAssignments) {
            if (assignment.status === "VERIFIED") {
                continue;
            }

            assignment.status = "VERIFIED";
            await assignment.save();
            updatedAssignments.push(assignment);
        }

        return {
            taskAssignments: updatedAssignments,
            message: `${updatedAssignments.length} assignment(s) marked as VERIFIED`,
        };
    } catch (err) {
        throw new ErrorResponse(400, err.message);
    }
};

export const taskStatusChangeServices = async (dataObject) => {
    try {
        let { employeesId, taskId, status } = dataObject;
        if (!Array.isArray(employeesId)) {
            employeesId = [employeesId];
        }

        const taskAssignments = await taskAssignmentModel.find({
            taskId,
            employeeId: { $in: employeesId },
        });

        if (taskAssignments.length === 0) {
            throw new ErrorResponse(404, "No task assignments found for given employee(s)");
        }

        const updatedAssignments = [];
        for (const assignment of taskAssignments) {
            assignment.status = status.toUpperCase();
            await assignment.save();
            updatedAssignments.push(assignment);
        }

        return { taskAssignments: updatedAssignments };
    } catch (err) {
        throw new ErrorResponse(400, err.message);
    }
};


export const getTasksWithAssignments = async (dataObject) => {
    const { adminId, organizationId, status, search } = dataObject;
    console.log(dataObject)
    try {
        const isorganizationExistsOrg = await organizationModel.findById({ _id: organizationId, createdBy: adminId })
        if (!isorganizationExistsOrg) {
            throw new ErrorResponse(STATUS_CODES.NOT_FOUND, "Organization not found");
        }

        // const taskExists = await taskModel.findOne({ organizationId, adminId : adminId });
        // if (!taskExists) {
        //     throw new ErrorResponse(STATUS_CODES.NOT_FOUND, "task not found");
        // }

        let query = {
            organizationId,
            adminId
        };

        if (status && status.toUpperCase() !== "ALL") {
            query.status = status.toUpperCase();
        }

        if (search) {
            query.$or = [
                { title: { $regex: search, $options: "i" } },
                { description: { $regex: search, $options: "i" } }
            ];
        }

        const tasks = await taskModel.find(query).lean();
        const taskIds = tasks.map((task) => task._id);

        const assignments = await taskAssignmentModel.find({
            taskId: { $in: taskIds }
        }).lean();

        const taskAssignmentsMap = assignments.reduce((acc, assignment) => {
            const taskIdStr = assignment.taskId.toString();
            if (!acc[taskIdStr]) acc[taskIdStr] = [];
            acc[taskIdStr].push(assignment.employeeId);
            return acc;
        }, {});

        const tasksWithAssignment = tasks.map((task) => ({
            ...task,
            assignment: taskAssignmentsMap[task._id.toString()] || []
        }));

        return { tasks: tasksWithAssignment };
    } catch (error) {
        console.error("Error fetching tasks:", error);

        if (error.name === "CastError") {
            throw new ErrorResponse(
                STATUS_CODES.BAD_REQUEST,
                `Invalid ID format: ${error.message}`
            );
        }

        throw new ErrorResponse(
            error.statusCode ?? STATUS_CODES.INTERNAL_SERVER_ERROR,
            `${error.message}`
        );
    }
};

export const taskCompleteService = async (dataObject) => {
    const { employeeId, imageUrl, location, organizationId, taskAssignmentId } = dataObject;

    // 1. Validate task assignment
    const taskAssignment = await validateTaskAssignment(employeeId, taskAssignmentId);
    
    // 2. Validate employee
    const employee = await validateEmployee(employeeId);
    
    // 3. Get and validate task details
    const task = await validateTask(taskAssignment.taskId);
    
    // 4. Set submission info
    const { isLate } = setSubmissionInfo(taskAssignment, task.deadline);
    
    // 5. Verify location
    await verifyLocation(task.location, location, task.aroundDistanceMeter);
    
    // 6. Handle face verification if required
    if (taskAssignment.faceVerification) {
        return await handleFaceVerification(taskAssignment, employee, imageUrl, isLate);
    }

    
    // 7. If no face verification required, mark as verified
    taskAssignment.status = taskAssignmentStatus.VERIFIED;
    taskAssignment.validateMethod = taskAssignmentValidateMethod.AUTO;
    
    await taskAssignment.save();
    return {
        method: taskAssignment.validateMethod,
        taskAssignment: taskAssignment
    };
};