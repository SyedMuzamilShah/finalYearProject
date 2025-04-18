import mongoose, { Schema, model } from "mongoose";
import { nanoid } from "nanoid";

const organizationSchema = new Schema(
  {
    organizationId: {
      type: String,
      default: () => `ORG-${nanoid(6).toUpperCase()}`, // e.g., EMP-7S4X9Z
      unique: true, // Enforce uniqueness
    },
    name: {
      type: String,
    },
    email: {
      type: String,
    },

    phoneNumber: {
      type: String,
    },
    website: {
      type: String,
    },

    address: {
      type: mongoose.Types.ObjectId,
      ref: "address",
    },

    createdBy: {
      type: mongoose.Types.ObjectId,
      ref: "admin|officer",
    },
  },

  {
    timestamps: true,
  }
);


export const organizationModel = model('organization', organizationSchema)
