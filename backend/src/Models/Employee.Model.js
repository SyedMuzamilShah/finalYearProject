import mongoose, { Schema, model } from "mongoose";
import bcrypt from "bcrypt";
import jwt from "jsonwebtoken";
import { nanoid } from "nanoid";

const EmployeeStatus = {
  VERIFIED: "VERIFIED",
  PENDING: "PENDING",
  REJECTED: "REJECTED",
  BLOCKED: "BLOCKED",
};

const employeeSchema = new Schema(
  {
    employeeId: {
      type: String,
      default: () => `EMP-${nanoid(6).toUpperCase()}`, // e.g., EMP-7S4X9Z
      unique: true, // Enforce uniqueness
    },
    userName: {
      type: String,
      required: true,
      unique: true,
      lowercase: true,
    },
    name: {
      type: String,
    },
    email: {
      type: String,
      required: true,
      unique: true,
      lowercase: true,
    },
    isEmailVerified: { type: Boolean, default: false },
    imageUrl : {
      type: String
    },


    password: {
      type: String,
      select : false
    },

    // biometricToken: {
    //     type: mongoose.Types.ObjectId,
    //     ref: "biometrictoken"
    // },
    biometricToken: {
        type: String
    },
    phoneNumber: {
      type: String,
    },

    role: {
        type: String,
        lowercase: true,
    },

    organizationId: {
      type: String,
      ref: "organization.organizationId",
      required: true,
    },

    status: {
      type: String,
      enum: Object.values(EmployeeStatus), // Enforce enum values
      default: EmployeeStatus.PENDING,
      // lowercase: true,
    },
  },

  {
    timestamps: true,
  }
);



// Pre save hook to hash the password before saving the officer Schema Object
employeeSchema.pre("save", async function (next) {

  // If the password is not modified, then skip this step
  if (!this.isModified("password")) return next();

  // Hash the password
  this.password = await bcrypt.hash(this.password, 10);

  // Move to the next middleware
  next();
});

// Method to check if the password is valid
employeeSchema.methods.isPasswordValid = async function (password) {

  // Compare the password with the hashed password
  return await bcrypt.compare(password, this.password);
};

// Method to generate the access token
employeeSchema.methods.generateAccessToken = function () {

  // use the user schema object _id to generate the access token with the secret key and the expiry time
  return jwt.sign({ _id: this._id }, process.env.ACCESS_TOKEN_SECRET_KEY, {
    expiresIn: process.env.ACCESS_TOKEN_SECRET_TIME,
  });
};

// Method to generate the refresh token
employeeSchema.methods.generateRefreshToken = function () {

  // use the user schema object _id to generate the refresh token with the secret key and the expiry time
  return jwt.sign({ _id: this._id }, process.env.REFRESH_TOKEN_SECRET_KEY, {
    expiresIn: process.env.REFRESH_TOKEN_SECRET_TIME,
  });
};




export const employeeModel = model("employee", employeeSchema);
