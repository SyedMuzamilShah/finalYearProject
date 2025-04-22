import { STATUS_CODES } from "../../../constant.js";
import { controllerHandler } from "../../Utils/ControllerHandler.js";
import { ErrorResponse } from "../../Utils/Error.js";
import { SuccessResponse } from "../../Utils/Success.js";
import { validationResult } from "express-validator";
import { adminRegisterService } from "../../Services/Admin/Auth/AdminRegister.Service.js";
import { adminLoginService } from "../../Services/Admin/Auth/AdminLogin.Service.js";
import { adminLogoutService } from "../../Services/Admin/Auth/AdminLogout.Service.js";
import { adminChangePasswordService } from "../../Services/Admin/Auth/AdminChangePassword.Service.js";
import { adminProfileService } from "../../Services/Admin/Auth/AdminProfile.Service.js";
import { adminRefreshTokenService } from "../../Services/Admin/Auth/AdminRefreshToken.Service.js";
import { adminForgotPasswordService } from "../../Services/Admin/Auth/AdminForgetPassword.Service.js";

export const adminRegisterController = controllerHandler(async (req, res) => {
  
  const { user, tokens } = await adminRegisterService(req.body)

  // return response
  return res.status(STATUS_CODES.CREATED)
    .json(new SuccessResponse(
      STATUS_CODES.CREATED,
      'User created successfully', { user , tokens }).toJson());
});

export const adminLoginController = controllerHandler(async (req, res) => {

  // Call the login service
  const { user, tokens } = await adminLoginService(req.body);

  // Return success response
  res.status(STATUS_CODES.OK).json(
    new SuccessResponse(
      STATUS_CODES.OK,
      'Login successful',
      { user: user, tokens: tokens }
    ).toJson()
  );
});

export const adminLogoutController = controllerHandler(async (req, res) => {
  const userId = req.user._id; // Assuming the user ID is available in `req.user`
  // Call the logout service
  const logout = await adminLogoutService(userId);

  if (logout) {
    // Return success response
    return res.status(STATUS_CODES.OK).json(
      new SuccessResponse(
        STATUS_CODES.OK,
        'Logout successful',
        undefined
      ).toJson()
    );
  }
});

export const adminForgotPasswordController = controllerHandler(async (req, res) => {});

export const adminChangePasswordController = controllerHandler(async (req, res) => {
  // Validate the request
  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    throw new ErrorResponse(
      STATUS_CODES.BAD_REQUEST,
      'Validation failed',
      errors.array()
    );
  }

  // Get data from frontend
  const userId = req.user._id;
  const dataObject = { userId, ...req.body }

  try {
    // Call the change password service
    const {user} = await adminChangePasswordService(dataObject);

    // Return success response
    return res.status(STATUS_CODES.OK).json(
      new SuccessResponse(
        STATUS_CODES.OK,
        'Password changed successfully',
        { user }
      ).toJson()
    );
  } catch (err) {
    // Handle specific errors
    if (err instanceof ErrorResponse) {
      throw err;
    }

    // Handle unexpected errors
    throw new ErrorResponse(
      STATUS_CODES.INTERNAL_SERVER_ERROR,
      'Password change failed due to an unexpected error'
    );
  }
});

export const adminProfileController = controllerHandler(async (req, res) => {
  const userId = req.user._id; // Assuming the user ID is available in `req.user`

  try {
    // Call the get profile service
    const { user } = await adminProfileService(userId);

    // Return success response
    return res.status(STATUS_CODES.OK).json(
      new SuccessResponse(
        STATUS_CODES.OK,
        'Profile fetched successfully',
        { user }
      ).toJson()
    );
  } catch (err) {
    // Handle specific errors
    if (err instanceof ErrorResponse) {
      throw err;
    }

    // Handle unexpected errors
    throw new ErrorResponse(
      STATUS_CODES.INTERNAL_SERVER_ERROR,
      'Failed to fetch profile due to an unexpected error'
    );
  }
});

export const adminRefreshToken = controllerHandler(async (req, res) => {
  const {tokens} = await adminRefreshTokenService(req.body)

  console.log(tokens)

  return res.status(STATUS_CODES.OK).json(
    new SuccessResponse(
      STATUS_CODES.OK,
      'token refreshed',
      { tokens: tokens }
    ).toJson()
  );
})