import mongoose, { Schema, model } from "mongoose";

const historyLogSchema = new Schema(
  {
    visitedEmployeeId : {
        type: mongoose.Types.ObjectId,
        ref: "employee"
    },

    address : {
        type: mongoose.Types.ObjectId,
        ref: "address"
    },

    status: {
        type: String,
        enum: ["PENDING", "COMPLETED"]
    },

    taskId: {
        type: mongoose.Types.ObjectId,
        ref: "task"
    }
  },

  {
    timestamps: true,
  }
);

export const historyLogModel = model("history", historyLogSchema);
