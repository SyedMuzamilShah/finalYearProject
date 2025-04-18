import { controllerHandler } from "../../Utils/ControllerHandler.js";

const registerationController = controllerHandler(async (req, res) => {

    // get data from frontend
    const {name, email, password } = req.body;
    
});

const loginController = controllerHandler(async (req, res) => {});

const logoutController = controllerHandler(async (req, res) => {});

const forgotPasswordController = controllerHandler(async (req, res) => {});

const changePasswordController = controllerHandler(async (req, res) => {});


export {
  registerationController,
  loginController,
  logoutController,
  changePasswordController,
  forgotPasswordController,
};
