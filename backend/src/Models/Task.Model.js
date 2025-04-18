import mongoose from "mongoose";

const taskSchema = new mongoose.Schema(
  {
    employeeId: {
      type: mongoose.Types.ObjectId,
      ref: "employee",
    },
    organizationId: {
      type: mongoose.Types.ObjectId,
      ref: "organization",
      required: true, // Ensure organizationId is provided
    },
    adminId: {
      type: mongoose.Types.ObjectId,
      ref: "admin",
      required: true, // Ensure adminId is provided
    },
    title: {
      type: String,
      required: true, // Ensure title is provided
      trim: true, // Remove extra spaces
    },
    description: {
      type: String,
      trim: true, // Remove extra spaces
    },
    dueDate: {
      type: Date, // Corrected from DataTime to Date
      required: true, // Ensure dueDate is provided
    },
    address: {
      type: mongoose.Types.ObjectId,
      ref: "address",
    },
    status: {
      type: String,
      enum: ["CREATED", "ASSIGNED", "COMPLETED", "FAILED", "IN PROGRESS", "REJECT", "VERIFIED"], // Corrected FAILED spelling
      default: "CREATED", // Default status is PENDING
    },
  },
  {
    timestamps: true, // Adds createdAt and updatedAt fields
  }
);

// Add indexes for frequently queried fields
// taskSchema.index({ employeeId: 1 });
// taskSchema.index({ organizationId: 1 });
// taskSchema.index({ status: 1 });

export const taskModel = mongoose.model("task", taskSchema);