import mongoose, { Schema, model } from "mongoose";

const taskAssignmentStatus = {

    ASSIGNED: "ASSIGNED",
    INPROGRESS: "INPROGRESS",
    COMPLETED: "COMPLETED",
    VERIFIED: "VERIFIED",
    REJECTED: "REJECTED"
};


const taskAssignmentSchema = new Schema(
    {
        taskId: {
            type: mongoose.Types.ObjectId,
            ref: 'task',
            required: true
        },
        employeeId: {
            type: mongoose.Types.ObjectId,
            ref: 'employee',
            required: true
        },
        assignedBy: {
            type: mongoose.Types.ObjectId,
            ref: 'Admin',
            required: true
        },

        status: {
            type: String,
            enum: Object.values(taskAssignmentStatus),
            default: taskAssignmentStatus.ASSIGNED,
            // lowercase: true,
        },
        deadline: {
            type: Date
        }
    }, {
    timestamps: true
}
)


export const taskAssignmentModel = model('taskAssignment', taskAssignmentSchema)