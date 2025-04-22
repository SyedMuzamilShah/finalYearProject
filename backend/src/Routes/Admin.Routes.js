import { Router } from "express";
import { adminJwtDecode } from "../Middlewares/Admin.Middleware.js";
import { upload } from "../Middlewares/Multer.Middleware.js";
import { validateHandler } from "../Utils/ValidateHandler.js"
import { validateOrganizationEditRoute, validateOrganizationRoutes } from "../Utils/Validators/Organization.Validation.js";
import { validateAdminLoginRoutes, validateAdminRefreshTokenRoutes, validateAdminRegisterRoutes } from "../Utils/Validators/Admin.Validation.js";
import { adminCreateOrganization, adminDeleteOrganization, adminEditOrganizationController, adminGetAllOrganization } from "../Controllers/Admin/Organization.Controllers.js"
import { taskAssignController, taskCreateController, taskDeleteController, taskReadController, taskStatusChangeController, taskUpdateController, taskVerifiedController } from "../Controllers/Admin/Task.Controllers.js";
import { adminRegisterController, adminLoginController, adminProfileController, adminForgotPasswordController, adminChangePasswordController, adminRefreshToken, adminLogoutController } from "../Controllers/Admin/Admin.Controllers.js";
import { validateTaskAssignRoute, validateTaskCreationRoute, validateTaskDeleteRoute, validateTaskGetRoute, validateTaskStatusChangeRoute, validateTaskUpdateRoute, validateTaskVerifiedRoute } from "../Utils/Validators/Task.Validation.js";
import { validateEmployeeAllowPictureRoutes, validateEmployeeDeleteRoutes, validateEmployeeEditRoutes, validateEmployeeGetRoutes, validateEmployeeRegisterRoutes, validateEmployeeRoleChangeRoute, validateEmployeeStatusChangeRoutes } from "../Utils/Validators/Employee.Validation.js";
import { employeeAddControllerForAdmin, employeeBasicUpdateControllerForAdmin, employeeDeleteControllerForAdmin, employeeGetControllerForAdmin, employeeImageAllowControllerForAdmin, employeeRoleChangeControllerForAdmin, employeeStatusChangeControllerForAdmin, employeeUpdateToGetherControllerForAdmin } from "../Controllers/Admin/AdminEmployee.Controllers.js"
const adminRoutes = Router();

// ----------------------- Admin Auth Route -----------------------
adminRoutes.route('/auth/register')
    .post(validateAdminRegisterRoutes, validateHandler, adminRegisterController)

adminRoutes.route('/auth/login')
    .post(validateAdminLoginRoutes, validateHandler, adminLoginController)

adminRoutes.route('/auth/logout')
    .post(adminJwtDecode, adminLogoutController)

adminRoutes.route('/auth/user/profile')
    .get(adminJwtDecode, validateHandler, adminProfileController)

adminRoutes.route('/auth/token')
    .post(validateAdminRefreshTokenRoutes, validateHandler, adminRefreshToken)

adminRoutes.route('/auth/user/forget-password')
    .post(adminForgotPasswordController)

adminRoutes.route('/auth/user/change-password')
    .post(adminChangePasswordController)


// ----------------------- Admin Organization Route -----------------------
adminRoutes.route('/organization/register').post(
    adminJwtDecode, validateOrganizationRoutes, validateHandler, adminCreateOrganization)

adminRoutes.route('/organization/get').get(
    adminJwtDecode, adminGetAllOrganization)

adminRoutes.route('/organization/delete').delete(
    adminJwtDecode, adminDeleteOrganization)

adminRoutes.route('/organization/edit').post(
    adminJwtDecode, validateOrganizationEditRoute, validateHandler, adminEditOrganizationController
)


// ----------------------- Admin Employee Route -----------------------
adminRoutes.route('/employee/create')
    .post(adminJwtDecode, upload.single('image'), validateEmployeeRegisterRoutes, validateHandler, employeeAddControllerForAdmin);

adminRoutes.route('/employee/get')
    .get(adminJwtDecode, validateEmployeeGetRoutes, validateHandler, employeeGetControllerForAdmin);

adminRoutes.route('/employee/edit')
    .patch(adminJwtDecode, validateEmployeeEditRoutes, validateHandler, employeeBasicUpdateControllerForAdmin);

adminRoutes.route('/employee/delete')
    .delete(adminJwtDecode, validateEmployeeDeleteRoutes, validateHandler, employeeDeleteControllerForAdmin);

adminRoutes.route('/employee/allow-picture')
    .patch(adminJwtDecode, validateEmployeeAllowPictureRoutes, validateHandler, employeeImageAllowControllerForAdmin);

adminRoutes.route('/employee/status-change')
    .post(adminJwtDecode, validateEmployeeStatusChangeRoutes, validateHandler, employeeStatusChangeControllerForAdmin);

adminRoutes.route('/employee/role-change')
    .post(adminJwtDecode, validateEmployeeRoleChangeRoute, validateHandler, employeeRoleChangeControllerForAdmin);

adminRoutes.route('/employee/update-data')
    .patch(adminJwtDecode, validateEmployeeEditRoutes, validateHandler, employeeUpdateToGetherControllerForAdmin)


// ----------------------- Admin Task Route -----------------------
adminRoutes.route('/task/create')
    .post(adminJwtDecode, validateTaskCreationRoute, validateHandler, taskCreateController)

adminRoutes.route('/task/get')
    .get(adminJwtDecode, validateTaskGetRoute, validateHandler, taskReadController)
    
adminRoutes.route('/task/update')
    .patch(adminJwtDecode, validateTaskUpdateRoute, validateHandler, taskUpdateController)
    
adminRoutes.route('/task/delete')
    .delete(adminJwtDecode, validateTaskDeleteRoute, validateHandler, taskDeleteController)

adminRoutes.route('/task/assign')
    .post(adminJwtDecode, validateTaskAssignRoute, validateHandler, taskAssignController)

adminRoutes.route('/task/verified')
    .patch(adminJwtDecode, validateTaskVerifiedRoute, validateHandler, taskVerifiedController)

adminRoutes.route('/task/status-change')
    .patch(adminJwtDecode, validateTaskStatusChangeRoute, validateHandler, taskStatusChangeController)




// Create Employee
// adminRoutes.route('/organization/employee/create').post(adminJwtDecode, validateEmployeeRegisterRoutes, upload.single('image'), combineEmployeeAddController)
// adminRoutes.route('/organization/employee/get').get(adminJwtDecode, validateEmployeeRegisterRoutes, combineEmployeeAddController)
// adminRoutes.route('/organization/employee/status-change').post(adminJwtDecode, validateEmployeeStatusChangeRoutes, combineEmployeeAddController)



// adminRoutes.route('/admin/activate-organization').post((req, res) => {})
// adminRoutes.route('/admin/deactivate-organization').post((req, res) => {})
// adminRoutes.route('/admin/organization-details').post((req, res) => {})
// adminRoutes.route('/admin/organization-employee-details').post((req, res) => {})
    
export { adminRoutes }