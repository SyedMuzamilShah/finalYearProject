import { validationResult } from "express-validator";
import { STATUS_CODES } from "../../../constant.js";
import { controllerHandler } from "../../Utils/ControllerHandler.js"
import { ErrorResponse } from "../../Utils/Error.js";
import { taskAssignService, taskCompleteService, taskCreateServices } from "../../Services/Task.Services.js";
import { SuccessResponse } from "../../Utils/Success.js";
import { decodeAddress } from "../../Utils/AddressConverter.js";
import { addressCreateServices } from "../../Services/Address.Services.js";

export const taskCreateController = controllerHandler(async (req, res) => {
  const adminId = req.user._id;


  const errors = validationResult(req);
  // if not then throw an error
  if (!errors.isEmpty()) {
    throw new ErrorResponse(STATUS_CODES.BAD_REQUEST, 'validation faild', errors.array())
  }
  let dataObject = { adminId, ...req.body }
  const address = req.body.address
  const response = await decodeAddress(address)
  if (response.error) {
          throw new ErrorResponse(STATUS_CODES.BAD_REQUEST, response.error)
  }

  const locationData = {...response[0], address}
  const addressModelObject = await addressCreateServices(locationData)

  dataObject.address = addressModelObject._id
  const task = await taskCreateServices(dataObject)
  return res.status(STATUS_CODES.CREATED)
    .json(new SuccessResponse(
      STATUS_CODES.CREATED,
      'task created successfully', { task: task }).toJson());
})

export const taskAssignController = controllerHandler(async (req, res) => {
  const adminId = req.user._id;
  
  const errors = validationResult(req);
  // if not then throw an error
  if (!errors.isEmpty()) {
    throw new ErrorResponse(STATUS_CODES.BAD_REQUEST, 'validation faild', errors.array())
  }

  const dataObject = {...req.body, adminId}
  const task = await taskAssignService(dataObject)
  return res.status(STATUS_CODES.OK)
    .json(new SuccessResponse(
      STATUS_CODES.OK,
      'Assign successFully', { task: task }).toJson());

})









export const assignTask = controllerHandler(async (req, res) => {
  const adminId = req.user._id;

  const errors = validationResult(req);

  // if not then throw an error
  if (!errors.isEmpty()) {
    throw new ErrorResponse(STATUS_CODES.BAD_REQUEST, 'validation faild', errors.array())
  }


  try {
    // Create User
    const task = await taskAssignService(req.body)

    // return response
    return res.status(STATUS_CODES.CREATED)
      .json(new SuccessResponse(
        STATUS_CODES.CREATED,
        'task created successfully', { task: task }).toJson());
  } catch (err) {
    if (err instanceof ErrorResponse) {
      throw err;
    }
    throw new ErrorResponse(STATUS_CODES.INTERNAL_SERVER_ERROR, 'task creating field')
  }


})



export const completedTask = controllerHandler(async (req, res) => {
  // const taskId = req.params.id;
  // const adminId = req.user._id;
  const employeeId = req.user._id;

  try {
    const data = { ...req.body, employeeId }
    // Create User
    const task = await taskCompleteService(data)

    // return response
    return res.status(STATUS_CODES.CREATED)
      .json(new SuccessResponse(
        STATUS_CODES.CREATED,
        'task completed successfully', { task: task }).toJson());
  } catch (err) {
    if (err instanceof ErrorResponse) {
      throw err;
    }
    throw new ErrorResponse(STATUS_CODES.INTERNAL_SERVER_ERROR, 'task completing field')
  }
})