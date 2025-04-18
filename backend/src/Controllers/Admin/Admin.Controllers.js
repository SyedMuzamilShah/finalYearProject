import { STATUS_CODES } from "../../../constant.js";
import { controllerHandler } from "../../Utils/ControllerHandler.js";
import { ErrorResponse } from "../../Utils/Error.js";
import { SuccessResponse } from "../../Utils/Success.js";
import { getAdminProfileService, officeAdminChangePasswordServices, officeAdminCreateServices, officeAdminLoginServices, officeAdminLogOutServices, refreshTokenServices } from "../../Services/Admin.Services.js"
import { validationResult } from "express-validator";
export const registerationController = controllerHandler(async (req, res) => {
  console.log(req.body)
  // validate the request
  const errors = validationResult(req);
  // if not then throw an error
  if (!errors.isEmpty()) {
    throw new ErrorResponse(STATUS_CODES.BAD_REQUEST, 'validation faild', errors.array())
  }

  const { userResponse, tokens } = await officeAdminCreateServices(req.body)

  // return response
  return res.status(STATUS_CODES.CREATED)
    .json(new SuccessResponse(
      STATUS_CODES.CREATED,
      'user created successfully', { user: userResponse, tokens: tokens }).toJson());
});

export const loginController = controllerHandler(async (req, res) => {
  // Validate the request
  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    throw new ErrorResponse(
      STATUS_CODES.BAD_REQUEST,
      'Validation failed',
      errors.array()
    );
  }

  // Call the login service
  const { userResponse, tokens } = await officeAdminLoginServices(req.body);

  // Return success response
  res.status(STATUS_CODES.OK).json(
    new SuccessResponse(
      STATUS_CODES.OK,
      'Login successful',
      { user: userResponse, tokens: tokens }
    ).toJson()
  );
});

export const logoutController = controllerHandler(async (req, res) => {
  const userId = req.user._id; // Assuming the user ID is available in `req.user`
  // Call the logout service
  const logout = await officeAdminLogOutServices(userId);

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

export const forgotPasswordController = controllerHandler(async (req, res) => { });


export const changePasswordController = controllerHandler(async (req, res) => {
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
    const user = await officeAdminChangePasswordServices(dataObject);

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

export const getAdminProfileController = controllerHandler(async (req, res) => {
  const userId = req.user._id; // Assuming the user ID is available in `req.user`

  try {
    // Call the get profile service
    const user = await getAdminProfileService(userId);

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

export const refreshToken = controllerHandler(async (req, res) => {
  console.log("RefreshToken Controller")
  // validate the request
  const errors = validationResult(req);
  // if not then throw an error
  if (!errors.isEmpty()) {
    throw new ErrorResponse(STATUS_CODES.BAD_REQUEST, 'RefreshToken required', errors.array())
  }

  const tokens = await refreshTokenServices(req.body)

  console.log(tokens)

  return res.status(STATUS_CODES.OK).json(
    new SuccessResponse(
      STATUS_CODES.OK,
      'token refreshed',
      { tokens: tokens }
    ).toJson()
  );
})