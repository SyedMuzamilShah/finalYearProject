import mongoose, { Schema, model } from "mongoose";
import bcrypt from "bcrypt";
import jwt from "jsonwebtoken"
const superUserSchema = new Schema(
  {
    name: {
      type: String,
    },

    email: {
      type: String,
    },

    password: {
      type: String,
      select: false
    },

    // status: {
    //   type: String,
    //   enum: ["ACTIVE", "PENDING", "VERIFIED", "REJECTED", "RETRY"],
    // },
  },

  {
    timestamps: true,
  }
);

// Pre save hook to hash the password before saving the officer Schema Object
superUserSchema.pre("save", async function (next) {

  // If the password is not modified, then skip this step
  if (!this.isModified("password")) return next();
  
  // Hash the password
  this.password = await bcrypt.hash(this.password, 10);

  // Move to the next middleware
  next();
});

// Method to check if the password is valid
superUserSchema.methods.isPasswordValid = async function (password) {

  // Compare the password with the hashed password
  return await bcrypt.compare(password, this.password);
};

// Method to generate the access token
superUserSchema.methods.generateAccessToken = function () {

  // use the user schema object _id to generate the access token with the secret key and the expiry time
  return jwt.sign({ _id: this._id }, process.env.ACCESS_TOKEN_SECRET_KEY, {
    expiresIn: process.env.ACCESS_TOKEN_SECRET_TIME,
  });
};

// Method to generate the refresh token
superUserSchema.methods.generateRefreshToken = function () {

  // use the user schema object _id to generate the refresh token with the secret key and the expiry time
  return jwt.sign({ _id: this._id }, process.env.REFRESH_TOKEN_SECRET_KEY, {
    expiresIn: process.env.REFRESH_TOKEN_SECRET_TIME,
  });
};

// Export the Super user model
export const superUserModel = model("superuser", superUserSchema);
