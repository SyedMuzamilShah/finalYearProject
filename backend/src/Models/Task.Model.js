import mongoose from "mongoose";

const TaskStatus = {
  CREATED: "CREATED",
  ASSIGNED: "ASSIGNED",
  COMPLETED: "COMPLETED",
  VERIFIED: "VERIFIED",
};


const taskSchema = new mongoose.Schema(
  {
    // employeeId: {
    //   type: mongoose.Types.ObjectId,
    //   ref: "employee",
    // },
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
    // address: {
    //   type: mongoose.Types.ObjectId,
    //   ref: "address",
    // },
    location: {
      type: { type: String, default: "Point" },
      coordinates: [Number]  // [longitude, latitude]
    },

    status: {
      type: String,
      enum: Object.values(TaskStatus),
      default: TaskStatus.CREATED,
      // lowercase: true,
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