import { controllerHandler } from "../Utils/ControllerHandler.js";

export const ejsRegisterView = controllerHandler(async (req, res) => {
    res.render('register.ejs')
  });

  export const ejsLoginView = controllerHandler(async (req, res) => {
    res.render('login.ejs')
  });