import mongoose, { Schema, model } from "mongoose";

const biometricTokenSchema = new Schema(
  {
    employeeId: {
      type: mongoose.Types.ObjectId,
      ref: 'employee'
    },
    organizationId: {
      type: mongoose.Types.ObjectId,
      ref: 'organization'
    },
    imageToken: {
      type: String
    },
    imageUrl: {
      type: String
    }
  },
  {
    timestamps: true,
  }
);

export const biometricTokenModel = model("biometrictoken", biometricTokenSchema);
