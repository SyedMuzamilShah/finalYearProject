import { STATUS_CODES } from "../../constant.js";
import { employeeModel } from "../Models/Employee.Model.js";
import { organizationModel } from "../Models/Organization.Model.js";
import { taskModel } from "../Models/Task.Model.js";
import { taskAssignmentModel } from "../Models/TaskAssignment.Model.js";
import { ErrorResponse } from "../Utils/Error.js";
import { faceVerification } from "../Utils/FaceBioHandler.js";
import {getDistanceInMeters } from "../Utils/Distance_Calculator.js"

const handleDatabaseError = (error) => {
    console.error("Database error:", error.message);
    throw new ErrorResponse(500, "An unexpected database error occurred");
};

export const taskCreateServices = async (dataObject) => {
    try {
        const {
            title,
            description,
            organizationId,
            adminId,
            location,
            dueDate,
        } = dataObject;

        // 🔍 Check if organization exists
        const org = await organizationModel.findOne({
            $or: [{ _id: organizationId }, { organizationId }],
        });
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

        Object.assign(task, dataObject);
        await task.save();

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
        await taskAssignmentModel.deleteMany({taskId: taskId});

        if (!response) throw new ErrorResponse(STATUS_CODES.NOT_FOUND, "Task not found");
        return true;
    } catch (err) {
        throw new ErrorResponse(500, 'Unexpected error occurred');
    }
};

export const taskAssignService = async (dataObject) => {
    let { employeesId, taskId, adminId, deadline } = dataObject;
    if (!Array.isArray(employeesId)) {
        employeesId = [employeesId];
    }

    try {
        const task = await taskModel.findById(taskId);
        if (!task) throw new ErrorResponse(404, "Task not found");

        const alreadyAssigned = [];
        const newAssignments = [];

        for (const employeeId of employeesId) {
            const employeeExists = await employeeModel.findById(employeeId);
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

    try {
        let query = {};
        if (organizationId) query.organizationId = organizationId;
        if (status && status.toUpperCase() !== "ALL") {
            query.status = status.toUpperCase();
        }
        if (search) {
            query.$or = [
                { title: { $regex: search, $options: 'i' } },
                { description: { $regex: search, $options: 'i' } },
            ];
        }

        const tasks = await taskModel.find(query).lean();
        const taskIds = tasks.map((task) => task._id);

        const assignments = await taskAssignmentModel.find({
            taskId: { $in: taskIds },
        }).lean();

        const taskAssignmentsMap = assignments.reduce((acc, assignment) => {
            const tId = assignment.taskId.toString();
            if (!acc[tId]) acc[tId] = [];
            acc[tId].push(assignment.employeeId);
            return acc;
        }, {});

        const tasksWithAssignment = tasks.map((task) => ({
            ...task,
            assignment: taskAssignmentsMap[task._id.toString()] || [],
        }));

        return { tasks: tasksWithAssignment };
    } catch (error) {
        console.error("Error fetching tasks:", error);

        if (error.name === "CastError") {
            throw new ErrorResponse(STATUS_CODES.BAD_REQUEST, `Invalid ID format: ${error.message}`);
        }

        throw new ErrorResponse(STATUS_CODES.INTERNAL_SERVER_ERROR, `Error fetching tasks: ${error.message}`);
    }
};

// Define this limit in meters (e.g., 1000 for 1 km)
const MAX_DISTANCE_METERS = 1000;




// That will called by employee
export const taskCompleteService = async (dataObject) => {
    const { employeeId, imageUrl, lat, lng, taskId, organizationId } = dataObject;

    // 1. Get the Task
    const task = await taskModel.findById(taskId);
    if (!task) throw new ErrorResponse(404, "Task not found");

    // 2. Get Task Assignment
    const assignment = await taskAssignmentModel.findOne({ taskId, employeeId });
    if (!assignment) throw new ErrorResponse(403, "Task not assigned to this employee");

    const employee = await employeeModel.findById(employeeId);

    // 3. Face Verification
    // const registeredFaceToken = assignment.faceToken;
    const registeredFaceToken = employee.biometricToken;
    if (!registeredFaceToken) throw new ErrorResponse(400, "No registered face for verification");

    const faceVerificationResult = await faceVerification(registeredFaceToken, imageUrl);
    const isSamePerson = faceVerificationResult.confidence > 80; // You can adjust the confidence threshold

    if (!isSamePerson) {
        throw new ErrorResponse(401, "Face does not match the registered identity.");
    }

    // 4. Location Verification
    const taskCoordinates = task.location?.coordinates; // Assuming [lng, lat] format (GeoJSON)

    let isLocationVerified = false;
    if (taskCoordinates && lat && lng) {
        const taskLat = taskCoordinates[1];
        const taskLng = taskCoordinates[0];
        const distance = getDistanceInMeters(taskLat, taskLng, lat, lng);

        if (distance <= MAX_DISTANCE_METERS) {
            isLocationVerified = true;
        }
    }

    // 5. Check if admin allows completion from wrong location
    const allowOutsideCompletion = task.allowOutsideLocation || false; // Boolean field in task model

    if (!isLocationVerified && !allowOutsideCompletion) {
        throw new ErrorResponse(403, "Location is not within the allowed area for this task.");
    }

    // 6. Update Task and Assignment
    task.status = "COMPLETED";
    await task.save();

    assignment.completedAt = new Date();
    assignment.imageUrl = imageUrl;
    assignment.isLocationVerified = isLocationVerified;
    await assignment.save();

    return { task, assignment };
};
