import { STATUS_CODES } from "../../../constant.js";
import { controllerHandler } from "../../Utils/ControllerHandler.js";
import { validationResult } from 'express-validator';
import { ErrorResponse } from "../../Utils/Error.js";
import { employeeLoginServices, employeeLogOutServices } from "../../Services/Employee/Employee.Auth.Services.js";
import { SuccessResponse } from "../../Utils/Success.js";






export const employeeLoginController = controllerHandler(async (req, res) => {
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
  const { userResponse, tokens } = await employeeLoginServices(req.body);

  // Return success response
  res.status(STATUS_CODES.OK).json(
    new SuccessResponse(
      STATUS_CODES.OK,
      'Login successful',
      { user: userResponse, tokens: tokens }
    ).toJson()
  );
});



export const employeeLogoutController = controllerHandler(async (req, res) => {
  const userId = req.user._id; // Assuming the user ID is available in `req.user`
  // Call the logout service
  const logout = await employeeLogOutServices(userId);

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





export const employeeForgotPasswordController = controllerHandler(async (req, res) => { });

export const employeeChangePasswordController = controllerHandler(async (req, res) => { });