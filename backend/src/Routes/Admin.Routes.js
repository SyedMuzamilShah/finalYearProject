import { Router } from "express";
import { registerationController, loginController, logoutController, forgotPasswordController, changePasswordController, getAdminProfileController, refreshToken } from "../Controllers/Admin/Admin.Controllers.js";
import { validateAdminLoginRoutes, validateAdminRefreshTokenRoutes, validateAdminRegisterRoutes } from "../Utils/Validators/Admin.Validation.js";
import { officerJwtDecode } from "../Middlewares/Officer.Middleware.js";
import { delteAdminOrganization, getAllAdminOrganization, registerOrganizationController } from "../Controllers/Admin/Organization.Controllers.js"
import { taskAssignController, taskCreateController, taskReadController, taskStatusChangeController, taskVerifiedController } from "../Controllers/Admin/Task.Controllers.js";
import { validateOrganizationRoutes } from "../Utils/Validators/Organization.Validation.js";
import { validateEmployeeRegisterRoutes, validateEmployeeStatusChangeRoutes } from "../Utils/Validators/Employee.Validation.js";
import { upload } from "../Middlewares/Multer.Middleware.js";
import { combineEmployeeAddController } from "../Controllers/Combine/Employee.Controller.js";
import { validateTaskAssignRoute, validateTaskCreationRoute, validateTaskVerifiedRoute } from "../Utils/Validators/Task.Validation.js";
const adminRoutes = Router();

// ----------------------- Officer Auths Routes -----------------------
// ✅
adminRoutes.route('/auth/register')
    .post(validateAdminRegisterRoutes, registerationController)
// ✅
adminRoutes.route('/auth/login')
    .post(validateAdminLoginRoutes, loginController)
// ✅
adminRoutes.route('/auth/logout').post(
    officerJwtDecode, logoutController)
// ✅
adminRoutes.route('/auth/user/profile').get(officerJwtDecode, getAdminProfileController)
// ✅
adminRoutes.route('/auth/token').post(
    validateAdminRefreshTokenRoutes, refreshToken)


adminRoutes.route('/auth/user/forget-password').post(forgotPasswordController)
adminRoutes.route('/auth/user/change-password').post(changePasswordController)







// Create Organization
// ✅
adminRoutes.route('/organization/register').post(
    officerJwtDecode, validateOrganizationRoutes, registerOrganizationController)

// ✅
adminRoutes.route('/organization/get').get(officerJwtDecode, getAllAdminOrganization)

// ✅
adminRoutes.route('/organization/delete').delete(
    officerJwtDecode, delteAdminOrganization)



// Create Employee
adminRoutes.route('/organization/employee/create').post(officerJwtDecode, validateEmployeeRegisterRoutes, upload.single('image'), combineEmployeeAddController)
adminRoutes.route('/organization/employee/status-change').post(officerJwtDecode, validateEmployeeStatusChangeRoutes, combineEmployeeAddController)



// Create Task
adminRoutes.route('/organization/task/create').post(
    officerJwtDecode, 
    validateTaskCreationRoute, 
    taskCreateController)

adminRoutes.route('/organization/task/read').get(officerJwtDecode, taskReadController)
adminRoutes.route('/organization/task/assign').post(
    officerJwtDecode, validateTaskAssignRoute, taskAssignController)
adminRoutes.route('/organization/task/verified').get(
    (req,res,next)=>{
        console.log('task verified route hit')
        console.log(req.query)
        next()
    },
    officerJwtDecode, validateTaskVerifiedRoute, taskVerifiedController)
adminRoutes.route('/organization/task/status-change').get(officerJwtDecode, taskStatusChangeController)


// adminRoutes.route('/admin/edit-organization').post((req, res) => {})
// adminRoutes.route('/admin/delete-organization').post((req, res) => {})
// adminRoutes.route('/admin/activate-organization').post((req, res) => {})
// adminRoutes.route('/admin/deactivate-organization').post((req, res) => {})
// adminRoutes.route('/admin/organization-list').post((req, res) => {})
// adminRoutes.route('/admin/organization-details').post((req, res) => {})
// adminRoutes.route('/admin/organization-employees').post((req, res) => {})
// adminRoutes.route('/admin/organization-employee-details').post((req, res) => {})
// adminRoutes.route('/admin/organization-employee-delete').post((req, res) => {})
// adminRoutes.route('/admin/organization-employee-edit').post((req, res) => {})
// adminRoutes.route('/admin/organization-employee-activate').post((req, res) => {})



export { adminRoutes }