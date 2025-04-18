import { Router } from "express";
import { employeeJWTDecode } from "../Middlewares/EmployeeJwt.Middleware.js";
import {
  validateEmployeeChangePasswordRoutes,
  validateEmployeeForgetPasswordRoutes,
  validateEmployeeLoginRoutes,
  validateEmployeeRegisterRoutes,
} from "../Utils/Validators/Employee.Validation.js";

// import {
//   changePasswordController,
//   forgotPasswordController,
//   loginController,
//   logoutController,
//   employeeRegisterationController,
// } from "../Controllers/Employee/Employee.Controllers.js";
import { upload } from "../Middlewares/Multer.Middleware.js";
import { combineEmployeeAddController } from "../Controllers/Combine/Employee.Controller.js";
import { employeeChangePasswordController, employeeForgotPasswordController, employeeLoginController } from "../Controllers/Employee/Employee.Controllers.js";

const employeeRoutes = Router();

// ----------------------- Employee Auths Routes -----------------------
employeeRoutes
  .route("/auth/register")
  .post(validateEmployeeRegisterRoutes, upload.single('image'), combineEmployeeAddController);

employeeRoutes
  .route("/auth/login")
  .post(
    validateEmployeeLoginRoutes, employeeLoginController);

employeeRoutes
  .route("/auth/forget-password")
  .post(validateEmployeeForgetPasswordRoutes, employeeForgotPasswordController);

employeeRoutes
  .route("/auth/logout")
  .post(employeeJWTDecode, employeeForgotPasswordController);

employeeRoutes
  .route("/auth/change-password")
  .post(
    validateEmployeeChangePasswordRoutes,
    employeeJWTDecode,
    employeeChangePasswordController
  );


employeeRoutes.route("/employee/upload-image").post((req, res) => {})
employeeRoutes.route("/employee/complete-task").post((req, res) => {})



employeeRoutes.get("/", (req, res) => {
  res.json({ message: "Employee Routes" });
});
export { employeeRoutes };
