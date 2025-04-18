import { STATUS_CODES } from "../../../constant.js";
import { controllerHandler } from "../../Utils/ControllerHandler.js";
import { validationResult } from 'express-validator';
import { ErrorResponse } from "../../Utils/Error.js";
import { employeeModel } from "../../Models/Employee.Model.js";
import { EmployeeCreateServices } from "../../Services/Employee.Services.js";
import { SuccessResponse } from "../../Utils/Success.js";
import { uploadOnCloudinary } from "../../Utils/UploadImageClodinary.js";
import { faceRegistration } from "../../Utils/FaceBioHandler.js";

const employeeRegisterationController = controllerHandler(async (req, res) => {

  // Validate the request body data is valid
  const errors = validationResult(req);

  // if not then throw an error
  if (!errors.isEmpty()) {
    throw new ErrorResponse(STATUS_CODES.BAD_REQUEST, errors.array())
  }

  try {
    const image = req.file?.path;
    let imageUrl;
    let data;
    if (image) {
      console.log("Uploading on cloudinary...")
      imageUrl = await uploadOnCloudinary(image)

      const {faceToken} = await faceRegistration(imageUrl)
      
      data = {...red.body, biometricToken : faceToken, imageUrl}
    }else{
      data = req.body
    }

    // Create User
    const employee = await EmployeeCreateServices(data)

    // return response
    return res.status(STATUS_CODES.CREATED)
      .json(new SuccessResponse(
        STATUS_CODES.CREATED,
        'employee created successfully', { employee: employee }).toJson());
    res.json({success : "Success Message"});
  } catch (err) {
    if (err instanceof ErrorResponse) {
      throw err;
    }
    console.log(err.message);
    throw new ErrorResponse(STATUS_CODES.INTERNAL_SERVER_ERROR, 'employee creating field')
  }

});

const loginController = controllerHandler(async (req, res) => { });

const logoutController = controllerHandler(async (req, res) => {

  // get the user id which as been decoded using the middleware
  const userId = req.user._id;

  // find the user in database and remove the refresh token from the database
  const user = await employeeModel.findByIdAndUpdate(
    userId,
    {
      $unset: { refreshToken: "" }
    }
  )

  // if user is not found, mean the user Id is invalid so, throw an error
  if (!user) {
    throw new ErrorResponse(STATUS_CODES.NOT_FOUND, "User not found")
  }

  res.send("Logged out")
});

const forgotPasswordController = controllerHandler(async (req, res) => { });

const changePasswordController = controllerHandler(async (req, res) => { });


export {
  employeeRegisterationController,
  loginController,
  logoutController,
  changePasswordController,
  forgotPasswordController,
};
