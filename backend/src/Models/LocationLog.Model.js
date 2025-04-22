import mongoose, { Schema, model } from "mongoose";

const locationSchema = new Schema(
  {
    employeeId: {
      type: mongoose.Types.ObjectId,
      ref: "employee",
    },

    address: {
      type: mongoose.Types.ObjectId,
      ref: "address",
    },

    bioMetricType: {
      type: String,
      enum: ["FACED", "FINGERPRINT"]
    },

    status: {
      type: String,
      enum: ["PENDING", "VERIFIED", "CANCELLED", "REJECTED", "RETRY"],
      default: "PENDING"
    },

    task: {
      type: mongoose.Types.ObjectId,
      ref: "taskAssignment",
    },
  },

  {
    timestamps: true,
  }
);

export const locationModel = model("organization", locationSchema);
