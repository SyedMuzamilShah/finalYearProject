import { Router } from "express";
import { faceRegisterController } from "../Controllers/Combine/Face.Controller.js";
import { combineEmployeeAddController, combineEmployeeGetController, combineEmployeeStatusChange } from "../Controllers/Combine/Employee.Controller.js";
import { validateEmployeeGetRoutes, validateEmployeeRoutes } from "../Utils/Validators/Combine/Employee.Validation.js";
import { upload } from "../Middlewares/Multer.Middleware.js";
import { officerJwtDecode } from "../Middlewares/Officer.Middleware.js";
import { validateEmployeeStatusChangeRoutes } from "../Utils/Validators/Employee.Validation.js";
const combineRoutes = Router();

export { combineRoutes };


combineRoutes.route('/add/employee').post(
    upload.single('image'),
    validateEmployeeRoutes, combineEmployeeAddController)
combineRoutes.route('/get/employee').get(
    officerJwtDecode,
    validateEmployeeGetRoutes, combineEmployeeGetController
)


combineRoutes.route('/employee/status-change').post(officerJwtDecode, validateEmployeeStatusChangeRoutes, combineEmployeeStatusChange)


combineRoutes.route('/add/face').get(faceRegisterController)




// Admin Create
// Admin Login
// Admin Logout
// Admin Token-refresh
// Admin Password-change
// Admin forget-password
// Admin Profile-get
// Admin Profile-update
// --------------------------
// Admin Organization-create
// Admin Organization-update
// Admin Organization-delete
// Admin Organization-get
// --------------------------
// Admin Employee-add
// Admin Employee-update
// Admin Employee-get
// Admin Employee-picture-to-process [accept-for-token, reject-for-token] / `Not sure yet!`
// Admin Employee-status-change [blocked, unblocked, verified, rejected]
// --------------------------
// Admin Task-create
// Admin Task-update
// Admin Task-delete
// Admin Task-get
// --------------------------
// Admin Assign-task
// Admin Assign-task-verfied
// Admin Deassign-task

// Employee Create
// Employee Login
// Employee Logout
// Employee Token-refresh
// Employee Password-change
// Employee forget-password
// Employee Profile-get
// Employee Profile-update
// -------------------------
// Employee upload-picture
// Employee picture-accepted? for token
// Employee View-assign-task
// Employee submit-task
// Employee View-task-status
// Employee Get-assigned-task
// Employee Get-completed-task
// Employee Get-rejected-



// // Admin Authentication & Profile
// app.post('/admin/login', adminController.login);
// app.post('/admin/logout', adminController.logout);
// app.post('/admin/token-refresh', adminController.tokenRefresh);
// app.put('/admin/password-change', adminController.passwordChange);
// app.post('/admin/forget-password', adminController.forgetPassword);
// app.get('/admin/profile', adminController.getProfile);
// app.put('/admin/profile', adminController.updateProfile);


// // Admin Organization Management
// app.post('/admin/organization', adminOrganizationController.create);
// app.put('/admin/organization/:id', adminOrganizationController.update);
// app.delete('/admin/organization/:id', adminOrganizationController.delete);
// app.get('/admin/organization', adminOrganizationController.getAll);
// app.get('/admin/organization/:id', adminOrganizationController.getById);


// // Admin Employee Management
// app.post('/admin/employee', adminEmployeeController.add);
// app.put('/admin/employee/:id', adminEmployeeController.update);
// app.get('/admin/employee/:id', adminEmployeeController.get);
// app.get('/admin/employees', adminEmployeeController.getAll);
// app.post('/admin/employee/picture-process', adminEmployeeController.processPicture);
// app.put('/admin/employee/:id/status', adminEmployeeController.changeStatus); // blocked, unblocked, verified, rejected


// // Admin Task Management
// app.post('/admin/task', adminTaskController.create);
// app.put('/admin/task/:id', adminTaskController.update);
// app.delete('/admin/task/:id', adminTaskController.delete);
// app.get('/admin/task', adminTaskController.getAll);
// app.get('/admin/task/:id', adminTaskController.getById);

// // Admin Assign Task
// app.post('/admin/assign-task', adminTaskController.assignTask);
// app.put('/admin/assign-task/:id/verify', adminTaskController.verifyAssignedTask);



// // Employee Authentication & Profile
// app.post('/employee', employeeController.create);  // Employee Create
// app.post('/employee/login', employeeController.login);
// app.post('/employee/logout', employeeController.logout);
// app.post('/employee/token-refresh', employeeController.tokenRefresh);
// app.put('/employee/password-change', employeeController.passwordChange);
// app.post('/employee/forget-password', employeeController.forgetPassword);
// app.get('/employee/profile', employeeController.getProfile);
// app.put('/employee/profile', employeeController.updateProfile);


// // Employee Picture Management
// app.post('/employee/upload-picture', employeeController.uploadPicture);
// app.post('/employee/picture-accepted', employeeController.acceptPictureForToken);


// // Employee Task Management
// app.get('/employee/assign-task', employeeController.viewAssignedTask);
// app.post('/employee/submit-task', employeeController.submitTask);
// app.get('/employee/task-status/:id', employeeController.viewTaskStatus);
// app.get('/employee/get-assigned-task', employeeController.getAssignedTask);
// app.get('/employee/get-completed-task', employeeController.getCompletedTask);
// app.get('/employee/get-rejected-task', employeeController.getRejectedTask);

// // Admin and Employee combined functionality
// app.post('/admin/employee/picture-process', adminEmployeeController.processPicture);
