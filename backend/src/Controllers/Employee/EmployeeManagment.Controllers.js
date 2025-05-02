import { STATUS_CODES } from "../../../constant.js";
import { taskAssignmentValidateMethod } from "../../Models/TaskAssignment.Model.js";
import { employeeAssignTaskReadService } from "../../Services/Employee/Employee.Services.js";
import { taskCompleteService } from "../../Services/Task.Services.js";
import { controllerHandler } from "../../Utils/ControllerHandler.js";
import { deleteImage } from "../../Utils/DeleteImageFromLocalServer.js";
import { SuccessResponse } from "../../Utils/Success.js";
import path from 'path';
export const employeeAssignedTaskRead = controllerHandler(async (req, res) => {
    const employeeId = req.user._id;

    const dataObject = {employeeId, ...req.body, ...req.query}
    const {task} = await employeeAssignTaskReadService(dataObject)

    res.status(STATUS_CODES.OK).json(new SuccessResponse(STATUS_CODES.OK, "Task read", task).toJson())
})



export const employeeCompletedTaskController = controllerHandler(async (req, res) => {
  const employeeId = req.user._id;
  let imageUrl;
  if (req.file?.path){
    imageUrl = req.file?.path
  }
  console.log(imageUrl)
  const dataObject = { ...req.body, employeeId, ...req.query, imageUrl };

  // const result = await taskCompleteService(dataObject);
  const { method, taskAssignment} =  await taskCompleteService(dataObject);
  if (method == taskAssignmentValidateMethod.AUTO){
    deleteImage(imageUrl) // delete image from local database
  }

  
  return res.status(STATUS_CODES.OK).json(
    new SuccessResponse(
      STATUS_CODES.OK,
      'Task completed successfully',
      taskAssignment
    ).toJson()
  );
});
