import { Router } from "express";
import { changePasswordController, forgotPasswordController, loginController, logoutController, registerationController } from "../Controllers/SuperAdmin/SuperAdmin.Controllers.js";


const superAdminRoutes = Router();

// ----------------------- SuperUser Auths Routes -----------------------
superAdminRoutes.route('/auth/register').post( registerationController)
superAdminRoutes.route('/auth/login').post( loginController)
superAdminRoutes.route('/auth/logout').post( logoutController)
superAdminRoutes.route('/auth/forget-password').post( forgotPasswordController)
superAdminRoutes.route('/auth/change-password').post( changePasswordController)



export { superAdminRoutes }