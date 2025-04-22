// import { validationResult } from "express-validator";
// import { controllerHandler } from "../../Utils/ControllerHandler.js";
// import { ErrorResponse } from "../../Utils/Error.js";
// import { STATUS_CODES } from "../../../constant.js";
// import { employeeCreateServices } from "../../Services/Employee/Employee.Auth.Services.js";
// import { SuccessResponse } from "../../Utils/Success.js";
// import fs from "fs";
// import { employeeStatusChange, employeeUpdateServices, getEmployeeServices } from "../../Services/Combine/Employee.Combine.Services.js";

// // export const combineEmployeeAddController = controllerHandler(async (req, res) => {
// //     // Validate the request
// //     const errors = validationResult(req);
// //     if (!errors.isEmpty()) {
// //         console.log(errors);
// //         throw new ErrorResponse(STATUS_CODES.BAD_REQUEST, 'Validation failed', errors.array());
// //     }

// //     let imagePath = req.file?.path;
// //     let imageUrl, biometricToken;
// //     let data = req.body;

// //     try {
// //         // Check if employee is already registered
// //         const organizationExist = await employeeCreateServices.finaOrganization(req.body);
// //         if (!organizationExist) {
// //             console.log("Organization not found");
// //             throw new ErrorResponse(STATUS_CODES.NOT_FOUND, 'Organization not found');
// //         }

// //         // Check if employee is already registered
// //         const existingUser = await employeeCreateServices.findExistingUser(req.body);
// //         if (existingUser) {
// //             throw new ErrorResponse(STATUS_CODES.CONFLICT, 'Employee already registered');
// //         }

// //         if (imagePath) {
// //             console.log("Uploading image to Cloudinary...");
// //             imageUrl = imagePath;
// //             // imageUrl = await uploadOnCloudinary(imagePath);

// //             console.log("Generating face biometric token...");
// //             biometricToken = "Token hold"
// //             // const { faceToken } = await faceRegistration(imageUrl);
// //             // biometricToken = faceToken;

// //             data = { ...data, biometricToken, imageUrl };
// //         }

// //         // Create Employee
// //         const { userResponse, tokens } = await employeeCreateServices.createEmployee(data);

// //         // Return response
// //         return res.status(STATUS_CODES.CREATED)
// //             .json(new SuccessResponse(STATUS_CODES.CREATED, 'Employee created successfully', {
// //                 user: userResponse, tokens
// //             }).toJson());

// //     } catch (err) {
// //         console.error("Error creating employee:", err.message);
// //         throw err instanceof ErrorResponse ? err : new ErrorResponse(STATUS_CODES.INTERNAL_SERVER_ERROR, 'Failed to create employee');
// //     } finally {
// //         // Cleanup uploaded file if it exists
// //         if (imagePath && fs.existsSync(imagePath)) {
// //             // fs.unlinkSync(imagePath);
// //         }
// //     }
// // });




// export const combineEmployeeStatusChange = controllerHandler(async (req, res) => {
//     // Validate the request
//     const errors = validationResult(req);
//     if (!errors.isEmpty()) {
//         console.log(errors);
//         throw new ErrorResponse(STATUS_CODES.BAD_REQUEST, 'Validation failed', errors.array());
//     }

//     const adminId = req.user._id

//     console.log(req.query);
//     const dataObject = {
//         ...req.body,
//         adminId
//     }

//     const {employees} = await employeeStatusChange(dataObject)
//     // console.log(employees)
//     return res.status(STATUS_CODES.OK)
//         .json(new SuccessResponse(STATUS_CODES.OK, 'Employee Read successfully', {user : employees}).toJson());
// })



// export const combineEmployeeUpdate = controllerHandler(async (req, res)=>{
//     // Validate the request
//     const errors = validationResult(req);
//     if (!errors.isEmpty()) {
//         console.log(errors);
//         throw new ErrorResponse(STATUS_CODES.BAD_REQUEST, 'Validation failed', errors.array());
//     }

//     // TODO: NOTE if want to update the employee data by employee then the req.user?._id and
//     // then check other the request come from employee or admin

//     const adminId = req.user._id

//     console.log(req.query);
//     const dataObject = {
//         ...req.body,
//         adminId
//     }

//     const {employees} = await employeeUpdateServices(dataObject)

//     // console.log(employees)
//     return res.status(STATUS_CODES.OK)
//         .json(new SuccessResponse(STATUS_CODES.OK, 'Employee Read successfully', {user : employees}).toJson());
  
// })



// export const combineEmployeeGetController = controllerHandler(async (req, res) => {

//     const adminId = req.user._id
//     const errors = validationResult(req);
//     if (!errors.isEmpty()) {
//         console.log(errors);
//         throw new ErrorResponse(STATUS_CODES.BAD_REQUEST, 'Validation failed', errors.array());
//     }

//     console.log(req.query);
//     const dataObject = {
//         ...req.query,
//         adminId
//     }

//     const {employees} = await getEmployeeServices(dataObject)
//     // console.log(employees)
//     return res.status(STATUS_CODES.OK)
//         .json(new SuccessResponse(STATUS_CODES.OK, 'Employee Read successfully', {user : employees}).toJson());
// })



// export const employeeFaceRegisteration = controllerHandler(async (req, res) => {
//     // Validate the request
//     const errors = validationResult(req);
//     if (!errors.isEmpty()) {
//         console.log(errors);
//         throw new ErrorResponse(STATUS_CODES.BAD_REQUEST, 'Validation failed', errors.array());
//     }

//     let imagePath = req.file?.path;
//     let imageUrl, biometricToken;
//     let data = req.body;

//     try {
//         // Check if employee is already registered
//         const existingUser = await employeeCreateServices.findExistingUser(req.body);
//         if (existingUser) {
//             throw new ErrorResponse(STATUS_CODES.CONFLICT, 'Employee already registered');
//         }

//         if (imagePath) {
//             console.log("Uploading image to Cloudinary...");
//             imageUrl = "https://res.cloudinary.com/dqjz4xv5g/image/upload/v1698231234/employee/employee_1.jpg";
//             // imageUrl = await uploadOnCloudinary(imagePath);

//             console.log("Generating face biometric token...");
//             biometricToken = "headfggfasdajgsda-sadan"
//             // const { faceToken } = await faceRegistration(imageUrl);
//             // biometricToken = faceToken;

//             data = { ...data, biometricToken, imageUrl };
//         }

//         // Create Employee
//         const { userResponse, tokens } = await employeeCreateServices.createEmployee(data);

//         // Return response
//         return res.status(STATUS_CODES.CREATED)
//             .json(new SuccessResponse(STATUS_CODES.CREATED, 'Employee created successfully', {
//                 user: userResponse, tokens
//             }).toJson());

//     } catch (err) {
//         console.error("Error creating employee:", err.message);
//         throw err instanceof ErrorResponse ? err : new ErrorResponse(STATUS_CODES.INTERNAL_SERVER_ERROR, 'Failed to create employee');
//     } finally {
//         // Cleanup uploaded file if it exists
//         if (imagePath && fs.existsSync(imagePath)) {
//             fs.unlinkSync(imagePath);
//         }
//     }
// })