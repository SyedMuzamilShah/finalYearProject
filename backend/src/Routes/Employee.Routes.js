import { Router } from "express";
import { upload } from "../Middlewares/Multer.Middleware.js";
import { validateHandler } from "../Utils/ValidateHandler.js";
import { employeeJWTDecode } from "../Middlewares/EmployeeJwt.Middleware.js";
import { validateEmployeeAssignTaskReadRoute, validateEmployeeChangePasswordRoutes, validateEmployeeCompleteTaskRoute, validateEmployeeForgetPasswordRoutes, validateEmployeeGetRoutes, validateEmployeeImageUploadRoute, validateEmployeeLoginRoutes, validateEmployeeRegisterRoutes } from "../Utils/Validators/Employee.Validation.js";
import { employeeChangePasswordController, employeeForgotPasswordController, employeeImageUploadController, employeeLoginController, employeeLogoutController, employeeRegisterController } from "../Controllers/Employee/Employee.Controllers.js";
import { completedTask } from "../Controllers/Admin/Task.Controllers.js";
import { employeeAssignedTaskRead, employeeCompletedTaskController } from "../Controllers/Employee/EmployeeManagment.Controllers.js"

const employeeRoutes = Router();

// ----------------------- Employee Auths Routes -----------------------
employeeRoutes.route("/auth/register")
  .post(upload.single('image'), validateEmployeeRegisterRoutes, validateHandler, employeeRegisterController);

employeeRoutes.route("/auth/login")
  .post(validateEmployeeLoginRoutes, employeeLoginController);

employeeRoutes.route("/auth/forget-password")
  .post(validateEmployeeForgetPasswordRoutes, employeeForgotPasswordController);

employeeRoutes.route("/auth/logout")
  .post(employeeJWTDecode, employeeLogoutController);

employeeRoutes.route("/auth/change-password")
  .post(validateEmployeeChangePasswordRoutes, employeeJWTDecode, employeeChangePasswordController);

employeeRoutes.route("/upload-image")
  .post(employeeJWTDecode, upload.single('image'), validateEmployeeImageUploadRoute, validateHandler, employeeImageUploadController)




// ----------------------- Employee Task Management Routes -----------------------
employeeRoutes.route("/task/get")
  .get(employeeJWTDecode, (req, res, next) => res.send("Employees Get"))

employeeRoutes.route("/task/assign-task-read")
  .get(employeeJWTDecode, validateEmployeeAssignTaskReadRoute, validateHandler, employeeAssignedTaskRead)


employeeRoutes.route("/task/completed")
  .patch(
    employeeJWTDecode,
    upload.single('image'),
    (req,res,next)=> {
      req.body = {
        taskAssignmentId : req.body.taskAssignmentId,
        location : {
          type : req.body.location.type,
          coordinates : JSON.parse(req.body.location.coordinates),
          address: req.body.location.address
        }
      }
      next()
    },
    validateEmployeeCompleteTaskRoute,
    validateHandler,
    employeeCompletedTaskController
  );



export { employeeRoutes };
