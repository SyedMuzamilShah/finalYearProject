import { Router } from "express";

import { adminJwtDecode } from "../Middlewares/Admin.Middleware.js";
import { upload } from "../Middlewares/Multer.Middleware.js";
import { validateHandler } from "../Utils/ValidateHandler.js"
import { validateOrganizationEditRoute, validateOrganizationRoutes } from "../Utils/Validators/Organization.Validation.js";
import { validateAdminChangePasswordRoutes, validateAdminForgetPasswordRoutes, validateAdminLoginRoutes, validateAdminRefreshTokenRoutes, validateAdminRegisterRoutes } from "../Utils/Validators/Admin.Validation.js";
import { adminCreateOrganization, adminDeleteOrganization, adminEditOrganizationController, adminGetAllOrganization } from "../Controllers/Admin/Organization.Controllers.js"
import { taskAssignController, taskCreateController, taskDeleteController, taskReadController, taskStatusChangeController, taskUpdateController, taskVerifiedController } from "../Controllers/Admin/Task.Controllers.js";
import { adminRegisterController, adminLoginController, adminProfileController, adminForgotPasswordController, adminChangePasswordController, adminRefreshToken, adminLogoutController } from "../Controllers/Admin/Admin.Controllers.js";
import { validateTaskAssignRoute, validateTaskCreationRoute, validateTaskDeleteRoute, validateTaskGetRoute, validateTaskStatusChangeRoute, validateTaskUpdateRoute, validateTaskVerifiedRoute } from "../Utils/Validators/Task.Validation.js";
import { validateEmployeeAllowPictureRoutes, validateEmployeeDeleteRoutes, validateEmployeeEditRoutes, validateEmployeeGetRoutes, validateEmployeeRegisterRoutes, validateEmployeeRoleChangeRoute, validateEmployeeStatusChangeRoutes } from "../Utils/Validators/Employee.Validation.js";
import { employeeAddControllerForAdmin, employeeBasicUpdateControllerForAdmin, employeeDeleteControllerForAdmin, employeeGetControllerForAdmin, employeeImageAllowControllerForAdmin, employeeRoleChangeControllerForAdmin, employeeStatusChangeControllerForAdmin, employeeUpdateToGetherControllerForAdmin } from "../Controllers/Admin/AdminEmployee.Controllers.js"
const adminRoutes = Router();
// ----------------------- Admin Authentication Routes -----------------------

/**
 * Register a new admin
 * @body : Required [userName, name, email, password], Optional [phoneNumber]
 * @returns: 201 Created with user data and tokens
 */
adminRoutes.route('/auth/register')
  .post(validateAdminRegisterRoutes, validateHandler, adminRegisterController);

/**
 * Admin login
 * @body : Required [userName, email, password]
 * @returns: 200 OK with user data and tokens
 */
adminRoutes.route('/auth/login')
  .post(validateAdminLoginRoutes, validateHandler, adminLoginController);

/**
 * Admin logout
 * @headers : Requires token
 * @returns: 204 No Content
 */
adminRoutes.route('/auth/logout')
  .post(adminJwtDecode, adminLogoutController);

/**
 * Get admin profile
 * @headers : Requires token
 * @returns: 200 OK with user data
 */
adminRoutes.route('/auth/user/profile')
  .get(adminJwtDecode, validateHandler, adminProfileController);

/**
 * Refresh access token
 * @body : Required [refreshToken]
 * @returns: 200 OK with new tokens
 */
adminRoutes.route('/auth/token')
  .post(validateAdminRefreshTokenRoutes, validateHandler, adminRefreshToken);

/**
 * Change admin password
 * @headers : Requires token
 * @body : Required [oldPassword, newPassword]
 * @returns: 204 No Content
 */
adminRoutes.route('/auth/change-password')
  .post(adminJwtDecode, validateAdminChangePasswordRoutes, validateHandler, adminChangePasswordController);

/**
 * Request password reset (Not implemented)
 * @body : Required [email]
 * @returns: 204 No Content
 */
adminRoutes.route('/auth/forget-password')
  .post(validateAdminForgetPasswordRoutes, adminForgotPasswordController);


// ----------------------- Organization Management -----------------------

/**
 * Register a new organization
 * @headers : Requires token
 * @body : Required [name, email, phoneNumber, website, address]
 * @returns: 201 Created with organization data
 */
adminRoutes.route('/organization/register')
  .post(adminJwtDecode, validateOrganizationRoutes, validateHandler, adminCreateOrganization);

/**
 * Get all organizations
 * @headers : Requires token
 * @returns: 200 OK with list of organizations
 */
adminRoutes.route('/organization/get')
  .get(adminJwtDecode, adminGetAllOrganization);

/**
 * Delete an organization
 * @headers : Requires token
 * @returns: 204 No Content
 */
adminRoutes.route('/organization/delete')
  .delete(adminJwtDecode, adminDeleteOrganization);

/**
 * Edit an existing organization
 * @headers : Requires token
 * @body : Required [organizationId], Optional [name, email, phoneNumber, website, address]
 * @returns: 200 OK with updated organization data
 */
adminRoutes.route('/organization/edit')
  .post(adminJwtDecode, validateOrganizationEditRoute, validateHandler, adminEditOrganizationController);

// ----------------------- Employee Management -----------------------

/**
 * Create a new employee (image upload supported)
 * @headers : Requires token
 * @body : Required [organizationId, userName, email, password, role], Optional [name, phoneNumber, imageUrl]
 * @returns: 201 Created with user data tokens null for admin
 */
adminRoutes.route('/employee/create')
  .post(adminJwtDecode, upload.single('image'), validateEmployeeRegisterRoutes, validateHandler, employeeAddControllerForAdmin);

/**
 * Get all employees
 * @headers : Requires token
 * @query : Required [organizationId], Optional [status, employeeId, isEmailVerified, role, search, imageAcceptedForToken]
 * @returns: 200 OK with list of user
 */
adminRoutes.route('/employee/get')
  .get(adminJwtDecode, validateEmployeeGetRoutes, validateHandler, employeeGetControllerForAdmin);

/**
 * Edit an existing employee
 * @headers : Requires token
 * @body : Required [organizationId, employeeId], Optional [name, phoneNumber]
 * @returns: 200 OK with updated user data
 */
adminRoutes.route('/employee/edit')
  .patch(adminJwtDecode, validateEmployeeEditRoutes, validateHandler, employeeBasicUpdateControllerForAdmin);


/**
 * Delete an employee
 * @headers : Requires token
 * @body : Required [employeeId]
 * @returns: 204 No Content
 */
adminRoutes.route('/employee/delete')
  .delete(adminJwtDecode, validateEmployeeDeleteRoutes, validateHandler, employeeDeleteControllerForAdmin);

/**
 * Allow or block employee picture uploads
 * @headers : Requires token
 * @body : Required [employeeId]
 * @returns: 204 No Content
 */
adminRoutes.route('/employee/allow-picture')
  .patch(adminJwtDecode, validateEmployeeAllowPictureRoutes, validateHandler, employeeImageAllowControllerForAdmin);

/**
 * Change employee status (e.g., active/inactive)
 * @headers : Requires token
 * @body : Required [employeeId, status = VERIFIED / PENDING / REJECTED / BLOCKED]
 * @returns: 204 No Content
 */
adminRoutes.route('/employee/status-change')
  .post(adminJwtDecode, validateEmployeeStatusChangeRoutes, validateHandler, employeeStatusChangeControllerForAdmin);

/**
 * Change employee role
 * @headers : Requires token
 * @body : Required [employeeId, role = GUEST / SERVANT / MANAGER / BLOCKED]
 * @returns: 204 No Content
 */
adminRoutes.route('/employee/role-change')
  .post(adminJwtDecode, validateEmployeeRoleChangeRoute, validateHandler, employeeRoleChangeControllerForAdmin);

/**
 * Update multiple employee fields together
 * @headers : Requires token
 * @body : Required [employeeId], optional [role, status, name, uploadNewImage = boolean, phoneNumber]
 * @returns: 200 OK with updated user data
 */
adminRoutes.route('/employee/update-data')
  .patch(adminJwtDecode, validateEmployeeEditRoutes, validateHandler, employeeUpdateToGetherControllerForAdmin);

// ----------------------- Task Management -----------------------

/**
 * Create a new task
 * @headers : Requires token
 * @body : Required [title, organizationId, description, location, dueDate]
 * @returns: 201 Created with task data
 */
adminRoutes.route('/task/create')
  .post(adminJwtDecode, validateTaskCreationRoute, validateHandler, taskCreateController);

/**
 * Get tasks by organization
 * @headers : Requires token
 * @query : Required [organizationId], optional [status, search]
 * @returns: 200 OK with list of tasks
 */
adminRoutes.route('/task/get')
  .get(adminJwtDecode, validateTaskGetRoute, validateHandler, taskReadController);

/**
 * Update a task
 * @headers : Requires token
 * @body : Required [taskId], Optional [title, name, description, status, dueDate, location]
 * @returns: 200 OK with updated task data
 */
adminRoutes.route('/task/update')
  .patch(adminJwtDecode, validateTaskUpdateRoute, validateHandler, taskUpdateController);

/**
 * Delete a task
 * @headers : Requires token
 * @query : Required [taskId]
 * @returns: 204 No Content
 */
adminRoutes.route('/task/delete')
  .delete(adminJwtDecode, validateTaskDeleteRoute, validateHandler, taskDeleteController);

/**
 * Assign a task to employees
 * @headers : Requires token
 * @body : Required [taskId, employeesId], Optional [deadline]
 * @returns: 200 OK with task assignment data
 */
adminRoutes.route('/task/assign')
  .post(adminJwtDecode, validateTaskAssignRoute, validateHandler, taskAssignController);

/**
 * Mark a task as verified
 * @headers : Requires token
 * @body : Required [taskId, employeesId[employeeId]]
 * @returns: 200 OK with task assignment data
 */
adminRoutes.route('/task/verified')
  .patch(adminJwtDecode, validateTaskVerifiedRoute, validateHandler, taskVerifiedController);

/**
 * @headers : Requires token
 * @body : Required [taskId, employeesId[employeeId]]
 * @returns: 200 OK with task taskAssignments
 */
adminRoutes.route('/task/status-change')
  .patch(adminJwtDecode, validateTaskStatusChangeRoute, validateHandler, taskStatusChangeController);

export { adminRoutes }