
import { STATUS_CODES } from "../../constant.js";
import { taskModel } from "../Models/Task.Model.js";
import { ErrorResponse } from "../Utils/Error.js"

export const taskCreateServices = async (dataObject) => {
    try {
        // Destructure the input data
        const {employeeId, title, description, organizationId, adminId, address, dueDate } = dataObject;
        // Create a new task
        const newTask = new taskModel({
            employeeId, // may pass or not
            organizationId,
            adminId,
            title,
            description,
            dueDate: new Date(dueDate), // Ensure dueDate is a valid Date object
            address: address, // Assuming 'location' maps to the 'address' field in the schema
            status: "CREATED", // Default status
        });

        // Save the task to the database
        const task = await newTask.save();

        // Return the created task
        return { task };
    } catch (error) {
        // Handle errors
        console.error("Error in taskAssignService:", error.message);
        return {
            success: false,
            message: error.message || "Failed to assign task",
            data: null,
        };
    }
};

export const taskUpdateService = async (dataObject) => {
    const {taskId} = dataObject;
    try {
        const task = await taskModel.findById(taskId);
        if (!task){
            throw new ErrorResponse(STATUS_CODES.NOT_FOUND, "Task not found");
        }

        Object.keys(dataObject).forEach((key) => {
            task[key] = dataObject[key];
        })
        await task.save();

        return { task }
    } catch (err) {
        throw new ErrorResponse(STATUS_CODES.NOT_FOUND, err.message);
    }
}

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
}

export const taskDeleteService = async (dataObject) => {
    const {taskId}  = dataObject;

    try {
        const response = await taskModel.findByIdAndDelete(taskId)
        return true;
    } catch (err) {
        throw new ErrorResponse(500, 'enexpented error happend')
    } 
}

export const taskAssignService = async (dataObject) => {
    const {employeeId, taskId} = dataObject;
    // find tasks
    // check karo ke kis ko assign hn
    // agr cooresponding user ko already assigned hai to error throw karo
    // agr nahi hai to assign kardo
    // employee ko FCM ya socket se notify kardo
    // return success message
    try {
        const task = await taskModel.findById(taskId);
        if (!task){
            throw new ErrorResponse(404, "Task not found");
        }
        if (task.employeeId == employeeId){
            throw new ErrorResponse(400, "Task already assigned to an employee");
        }

        task.employeeId = employeeId;
        task.status = "ASSIGNED"
        await task.save();

        return { task }
    } catch (err) {
        throw new ErrorResponse(400, err.message);
    }
}

export const taskDeAssignServices = async (dataObject) => {
    try {
        const {employeeId, taskId} = dataObject;

        const task = await taskModel.findById(taskId);
        if (!task){
            throw new ErrorResponse(404, "Task not found");
        }

        if (!task.employeeId){
            throw new ErrorResponse(400, "Task not assigned to an employee");
        }

        
        task.employeeId = null;
        await task.save();

        return { task }
    } catch (err) {
        throw new ErrorResponse(400, err.message);
    }
}
// export const task 
export const taskCompleteService = async (dataObject) => {
    const {employeeId, imageUrl, lat, lng, taskId, organizationId} = dataObject;
    
};