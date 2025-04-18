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
