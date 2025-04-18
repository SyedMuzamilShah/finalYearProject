import { Router } from "express";
import { employeeJWTDecode } from "../Middlewares/EmployeeJwt.Middleware.js";
import {
  validateEmployeeChangePasswordRoutes,
  validateEmployeeForgetPasswordRoutes,
  validateEmployeeLoginRoutes,
  validateEmployeeRegisterRoutes,
} from "../Utils/Validators/Employee.Validation.js";

import {
  changePasswordController,
  forgotPasswordController,
  loginController,
  logoutController,
  employeeRegisterationController,
} from "../Controllers/Employee/Employee.Controllers.js";
import { upload } from "../Middlewares/Multer.Middleware.js";

const employeeRoutes = Router();

// ----------------------- Employee Auths Routes -----------------------
employeeRoutes
  .route("/auth/register")
  .post(validateEmployeeRegisterRoutes, upload.single('image'), employeeRegisterationController);

employeeRoutes
  .route("/auth/login")
  .post(validateEmployeeLoginRoutes, loginController);

employeeRoutes
  .route("/auth/forget-password")
  .post(validateEmployeeForgetPasswordRoutes, forgotPasswordController);

employeeRoutes
  .route("/auth/logout")
  .post(employeeJWTDecode, logoutController);

employeeRoutes
  .route("/auth/change-password")
  .post(
    validateEmployeeChangePasswordRoutes,
    employeeJWTDecode,
    changePasswordController
  );


employeeRoutes.route("/employee/upload-image").post((req, res) => {})
employeeRoutes.route("/employee/complete-task").post((req, res) => {})



employeeRoutes.get("/", (req, res) => {
  res.json({ message: "Employee Routes" });
});
export { employeeRoutes };
