import { Router } from "express";
import { ejsLoginView, ejsRegisterView } from "../ejsViews/superAdminViews.js";
import { loginController, registerationController } from "../ejsControllers/superAdminController.js";
const ejsRoutes = Router();

// Views
ejsRoutes
  .route("/view/register")
  .get(ejsRegisterView);

ejsRoutes
.route("/view/login")
.get(ejsLoginView);



// Controller
ejsRoutes.route("/register/controller").get(
  registerationController)

ejsRoutes.route("/login/controller").get(
  loginController)

export { ejsRoutes };


// Admin
// Authentication
// 1. Login
// 2. Register
// 3. Forget Password
// 4. Change Password
// 5. Profile
// 6. Token Refresh
// 7. Logout


// Organization
// 1. Create Organization
// 2. Get Organization
// 3. Delete Organization
// 4. Update Organization
// 5. Get Organization by ID

// Employee
// 1. Create Employee
// 2. Get Employees
// 3. Get Employee by ID
// 4. Update Employee
// 5. Delete Employee
// 6. Employee Status Change (Blocked, Unblocked, Verified, Rejected)
// 7. Employee Picture to Process (Accept for Token, Reject for Token)
// 8. Employee Status Change (Blocked, Unblocked, Verified, Rejected)
// 9. Employee registerd request [Accept, Reject]


// Task
// 1. Create Task
// 2. Get Tasks
// 3. Get Task by ID
// 4. Update Task
// 5. Delete Task
// 6. Assign Task
// 7. Verify Task
// 8. Deassign Task
// 9. Task Status Change (Pending, Completed, Rejected, verified, unverified)


// Employee
// Authentication
// 1. Login
// 2. Register [Admin will accept or reject]
// 3. Forget Password
// 4. Change Password
// 5. Profile
// 6. Token Refresh
// 7. Logout
// 8. Employee picture upload for token, upload agian if error come

// Task
// 1. View Assigned Task
// 2. Submit Task
// 3. View Task Status
// 4. Get Assigned Task
// 5. Get Completed Task
// 6. Get Rejected Task
// 7. Get Verified Task
// 8. Get Unverified Task
// 9. Get Pending Task
// 10. Get Completed Task


