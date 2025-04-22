// import { STATUS_CODES } from "../../constant.js";
// import { officeAdminModel } from "../Models/Admin.Model.js";
// import { ErrorResponse } from "../Utils/Error.js";
// import jwt from 'jsonwebtoken';

// export const adminRefreshTokenService = async (dataObject) => {
//     const { refreshToken } = dataObject;
//     let decode;
    
//     try {
//         // Verify the refresh token using our secret key
//         decode = jwt.verify(refreshToken, process.env.REFRESH_TOKEN_SECRET_KEY);
//     } catch (error) {
//         // Handle specific JWT errors with appropriate messages
//         if (error.name === 'TokenExpiredError') {
//             throw new ErrorResponse(STATUS_CODES.UNAUTHORIZED, "Refresh token expired");
//         } else {
//             throw new ErrorResponse(STATUS_CODES.UNAUTHORIZED, "Invalid refresh token");
//         }
//     }

//     // Find user associated with the token
//     const user = await officeAdminModel.findById(decode._id);

//     // Validate user existence and token match
//     if (!user) {
//         throw new ErrorResponse(STATUS_CODES.UNAUTHORIZED, "User not found");
//     }
    
//     if (user.refreshToken !== refreshToken) {
//         throw new ErrorResponse(STATUS_CODES.UNAUTHORIZED, "Refresh token mismatch");
//     }

//     // Generate new tokens
//     const accessToken = user.generateAccessToken();
//     const newRefreshToken = user.generateRefreshToken();

//     // Update the refresh token in database
//     user.refreshToken = newRefreshToken;
//     await user.save();

//     return {
//         tokens: {
//             accessToken, 
//             refreshToken: newRefreshToken
//         }
//     };
// };



// export const adminRegisterService = async (dataObject) => {
//     const { name, userName, email, password, phoneNumber } = dataObject;
//     // Start a Mongoose session for transactions
//     console.log("Starting 0")
//     const session = await officeAdminModel.startSession();
//     console.log("Starting 1")
//     session.startTransaction();
//     console.log("Starting 2")
//     try {
//         console.log("Starting 3")
//         // Check if email is already registered
//         const existingUser = await officeAdminModel.findOne({ email }).lean();
//         console.log("Starting 4")
//         if (existingUser) {
//             throw new ErrorResponse(
//                 STATUS_CODES.CONFLICT,
//                 'Email already registered'
//             );
//         }

//         // Create a new user instance
//         const user = new officeAdminModel({
//             name,
//             userName,
//             email,
//             password,
//             phoneNumber,
//         });

//         // Save the user within the transaction
//         await user.save();

//         // Generate tokens using the created user's _id
//         const access = user.generateAccessToken();
//         const refresh = user.generateRefreshToken();

//         user.refreshToken = refresh;
//         await user.save();

//         // Commit the transaction if everything succeeds
//         await session.commitTransaction();
//         session.endSession();

//         // Prepare response
//         const tokens = { accessToken: access, refreshToken: refresh };
//         const userResponse = user.toObject();
//         delete userResponse.password;
//         delete userResponse.__v;
//         delete userResponse.refreshToken;

//         return { user : userResponse, tokens }

//     } catch (err) {
//         // Roll back the transaction if any operation fails
//         await session.abortTransaction();
//         session.endSession();
//         throw new ErrorResponse(400, err.message)
//     }
// }

// export const adminProfileService = async (userId) => {
//     try {
//         // Find the user by ID
//         const user = await officeAdminModel.findById(userId);
//         if (!user) {
//             throw new ErrorResponse(
//                 STATUS_CODES.NOT_FOUND,
//                 'User not found'
//             );
//         }

//         // Prepare the response
//         const userResponse = user.toObject();
//         delete userResponse.password;
//         delete userResponse.__v;
//         delete userResponse.refreshToken;

//         return {user : userResponse};
//     } catch (err) {
//         // Log the error for debugging
//         console.error('Get profile service error:', err);

//         // Re-throw custom errors
//         if (err instanceof ErrorResponse) {
//             throw err;
//         }

//         // Throw a generic error for unexpected issues
//         throw new ErrorResponse(
//             STATUS_CODES.INTERNAL_SERVER_ERROR,
//             'Profile retrieval failed due to an unexpected error'
//         );
//     }
// };


// export const adminLoginService = async (dataObject) => {
//     // Get data from frontend
//     const { userName, email, password } = dataObject;
//     try {
//         // Find the user by email
//         const user = await officeAdminModel.findOne({ email }).select('+password');
//         console.log(user);
//         if (!user) {
//             throw new ErrorResponse(
//                 STATUS_CODES.NOT_FOUND,
//                 'Email is not registered'
//             );
//         }

//         // Validate the password
//         const isPasswordValid = await user.isPasswordValid(password);
//         if (!isPasswordValid) {
//             throw new ErrorResponse(
//                 STATUS_CODES.NOT_FOUND,
//                 'Invalid email address or password'
//             );
//         }

//         // Generate tokens
//         const access = await user.generateAccessToken();
//         const refresh = await user.generateRefreshToken();

//         // Save the refresh token in the database (hashed)
//         user.refreshToken = refresh
//         await user.save();

//         // Prepare the response
//         const userResponse = user.toObject();
//         delete userResponse.password;
//         delete userResponse.__v;
//         delete userResponse.refreshToken;

//         return { user : userResponse, tokens: { accessToken: access, refreshToken: refresh } };
//     } catch (err) {
//         // Log the error for debugging
//         // console.error('Login service error:', err);
//         throw err;
//     }
// };


// export const adminLogoutService = async (userId) => {
//     try {
//         // Find the user by ID and remove the refresh token
//         const user = await officeAdminModel.findByIdAndUpdate(userId, {
//             $set: { refreshToken: null }
//         }, { new: true });

//         if (!user) {
//             throw new ErrorResponse(
//                 STATUS_CODES.NOT_FOUND,
//                 'User not found'
//             );
//         }

//         return true;
//     } catch (err) {
//         // Log the error for debugging
//         console.error('Logout service error:', err);

//         // Re-throw custom errors
//         if (err instanceof ErrorResponse) {
//             throw err;
//         }

//         // Throw a generic error for unexpected issues
//         throw new ErrorResponse(
//             STATUS_CODES.INTERNAL_SERVER_ERROR,
//             'Logout failed due to an unexpected error'
//         );
//     }
// };


// export const adminChangePasswordService = async (dataObject) => {
//     const { userId, oldPassword, newPassword } = dataObject;
//     try {
//         // Find the user by ID
//         const user = await officeAdminModel.findById(userId).select('+password');
//         if (!user) {
//             throw new ErrorResponse(
//                 STATUS_CODES.NOT_FOUND,
//                 'User not found'
//             );
//         }

//         // Validate the old password
//         const isPasswordValid = await user.isPasswordValid(oldPassword);
//         if (!isPasswordValid) {
//             throw new ErrorResponse(
//                 STATUS_CODES.BAD_REQUEST,
//                 'Old password is not valid'
//             );
//         }

//         // Update the password
//         user.password = newPassword;
//         await user.save(); // This will trigger the pre-save hook to hash the password

//         // Prepare the response
//         const userResponse = user.toObject();
//         delete userResponse.password;
//         delete userResponse.__v;
//         delete userResponse.refreshToken;

//         return { user : userResponse };
//     } catch (err) {
//         // Log the error for debugging
//         console.error('Change password service error:', err);

//         // Re-throw custom errors
//         if (err instanceof ErrorResponse) {
//             throw err;
//         }

//         // Throw a generic error for unexpected issues
//         throw new ErrorResponse(
//             STATUS_CODES.INTERNAL_SERVER_ERROR,
//             'Password change failed due to an unexpected error'
//         );
//     }
// };