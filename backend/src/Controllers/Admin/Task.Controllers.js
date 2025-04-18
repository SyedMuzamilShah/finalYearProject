import { validationResult } from "express-validator";
import { STATUS_CODES } from "../../../constant.js";
import { controllerHandler } from "../../Utils/ControllerHandler.js";
import { ErrorResponse } from "../../Utils/Error.js";
import {
  getTasksWithAssignments,
  taskAssignService,
  taskCompleteService,
  taskCreateServices,
  taskStatusChangeServices,
  taskVerifiedServices
} from "../../Services/Task.Services.js";
import { SuccessResponse } from "../../Utils/Success.js";

export const taskCreateController = controllerHandler(async (req, res) => {
  const adminId = req.user._id;

  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    throw new ErrorResponse(STATUS_CODES.BAD_REQUEST, 'Validation failed', errors.array());
  }

  const dataObject = { adminId, ...req.body };
  const task = await taskCreateServices(dataObject);

  return res.status(STATUS_CODES.CREATED)
    .json(new SuccessResponse(STATUS_CODES.CREATED, 'Task created successfully', { task }).toJson());
});

export const taskAssignController = controllerHandler(async (req, res) => {
  const adminId = req.user._id;

  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    throw new ErrorResponse(STATUS_CODES.BAD_REQUEST, 'Validation failed', errors.array());
  }

  const dataObject = { ...req.body, ...req.query, adminId };
  const task = await taskAssignService(dataObject);

  return res.status(STATUS_CODES.OK)
    .json(new SuccessResponse(STATUS_CODES.OK, 'Task assigned successfully', { task }).toJson());
});

export const taskVerifiedController = controllerHandler(async (req, res) => {
  const adminId = req.user._id;

  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    throw new ErrorResponse(STATUS_CODES.BAD_REQUEST, 'Validation failed', errors.array());
  }

  const dataObject = { ...req.body, ...req.query, adminId };
  const { taskAssignments, message } = await taskVerifiedServices(dataObject);

  return res.status(STATUS_CODES.OK)
    .json(new SuccessResponse(
      STATUS_CODES.OK,
      message || 'Task verified successfully',
      { taskAssignments }
    ).toJson());
});

export const taskStatusChangeController = controllerHandler(async (req, res) => {
  const adminId = req.user._id;

  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    throw new ErrorResponse(STATUS_CODES.BAD_REQUEST, 'Validation failed', errors.array());
  }

  const dataObject = { ...req.body, ...req.query, adminId };
  const { taskAssignments } = await taskStatusChangeServices(dataObject);

  return res.status(STATUS_CODES.OK)
    .json(new SuccessResponse(
      STATUS_CODES.OK,
      'Task status changed successfully',
      { taskAssignments }
    ).toJson());
});

export const assignTask = controllerHandler(async (req, res) => {
  const adminId = req.user._id;

  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    throw new ErrorResponse(STATUS_CODES.BAD_REQUEST, 'Validation failed', errors.array());
  }

  try {
    const task = await taskAssignService(req.body);
    return res.status(STATUS_CODES.CREATED)
      .json(new SuccessResponse(
        STATUS_CODES.CREATED,
        'Task assigned successfully',
        { task }
      ).toJson());
  } catch (err) {
    if (err instanceof ErrorResponse) {
      throw err;
    }
    throw new ErrorResponse(STATUS_CODES.INTERNAL_SERVER_ERROR, 'Failed to assign task');
  }
});

export const taskReadController = controllerHandler(async (req, res) => {
  const adminId = req.user._id;
  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    throw new ErrorResponse(STATUS_CODES.BAD_REQUEST, 'Validation failed', errors.array());
  }

  const dataObject = { ...req.query, adminId };

  try {
    const tasks = await getTasksWithAssignments(dataObject);
    return res.status(STATUS_CODES.OK)
      .json(new SuccessResponse(
        STATUS_CODES.OK,
        'Tasks fetched successfully',
        { tasks }
      ).toJson());
  } catch (error) {
    return res.status(error.statusCode || STATUS_CODES.INTERNAL_SERVER_ERROR)
      .json({ message: error.message });
  }
});



export const completedTask = controllerHandler(async (req, res) => {
  const employeeId = req.user._id;
  const data = { ...req.body, employeeId };

  try {
    const result = await taskCompleteService(data);
    return res.status(STATUS_CODES.CREATED).json(
      new SuccessResponse(
        STATUS_CODES.CREATED,
        'Task completed successfully',
        result
      ).toJson()
    );
  } catch (err) {
    if (err instanceof ErrorResponse) {
      throw err;
    }
    throw new ErrorResponse(STATUS_CODES.INTERNAL_SERVER_ERROR, 'Failed to complete task');
  }
});

