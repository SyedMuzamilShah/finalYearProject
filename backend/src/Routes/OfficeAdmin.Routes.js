import { Router } from "express";
import { registerationController, loginController, logoutController, forgotPasswordController, changePasswordController } from "../Controllers/Office/Admin.Controllers.js";
import { validateAdminLoginRoutes, validateAdminRegisterRoutes } from "../Utils/Validators/Admin.Validation.js";
import { officerJwtDecode } from "../Middlewares/Officer.Middleware.js";
import { registerOrganizationController } from "../Controllers/Organization/Organization.Controllers.js"
import { taskAssignController, taskCreateController } from "../Controllers/Task/Task.Controllers.js";
import { employeeRegisterationController } from "../Controllers/Employee/Employee.Controllers.js"
const officerRoutes = Router();

// ----------------------- Officer Auths Routes -----------------------
officerRoutes.route('/auth/register').post(validateAdminRegisterRoutes, registerationController)
officerRoutes.route('/auth/login').post(validateAdminLoginRoutes, loginController)
officerRoutes.route('/auth/logout').post(officerJwtDecode, logoutController)
officerRoutes.route('/auth/forget-password').post( forgotPasswordController)
officerRoutes.route('/auth/change-password').post( changePasswordController)



// Create Organization
officerRoutes.route('/organization/register').post(officerJwtDecode, registerOrganizationController)

// Create Employee
officerRoutes.route('/organization/employee/create').post(officerJwtDecode, employeeRegisterationController)

// Create Task
officerRoutes.route('/organization/task/create').post(officerJwtDecode, taskCreateController)

officerRoutes.route('/organization/task/assign').post(officerJwtDecode, taskAssignController)


// officerRoutes.route('/admin/edit-organization').post((req, res) => {})
// officerRoutes.route('/admin/delete-organization').post((req, res) => {})
// officerRoutes.route('/admin/activate-organization').post((req, res) => {})
// officerRoutes.route('/admin/deactivate-organization').post((req, res) => {})
// officerRoutes.route('/admin/organization-list').post((req, res) => {})
// officerRoutes.route('/admin/organization-details').post((req, res) => {})
// officerRoutes.route('/admin/organization-employees').post((req, res) => {})
// officerRoutes.route('/admin/organization-employee-details').post((req, res) => {})
// officerRoutes.route('/admin/organization-employee-delete').post((req, res) => {})
// officerRoutes.route('/admin/organization-employee-edit').post((req, res) => {})
// officerRoutes.route('/admin/organization-employee-activate').post((req, res) => {})



export { officerRoutes }