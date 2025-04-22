import { STATUS_CODES } from "../../../../constant.js";
import { adminModel } from "../../../Models/Admin.Model.js";
import { ErrorResponse } from "../../../Utils/Error.js";
import jwt from 'jsonwebtoken';


export const adminRefreshTokenService = async (dataObject) => {
    const { refreshToken } = dataObject;
    let decode;
    
    try {
        // Verify the refresh token using our secret key
        decode = jwt.verify(refreshToken, process.env.REFRESH_TOKEN_SECRET_KEY);
    } catch (error) {
        // Handle specific JWT errors with appropriate messages
        if (error.name === 'TokenExpiredError') {
            throw new ErrorResponse(STATUS_CODES.UNAUTHORIZED, "Refresh token expired");
        } else {
            throw new ErrorResponse(STATUS_CODES.UNAUTHORIZED, "Invalid refresh token");
        }
    }

    // Find user associated with the token
    const user = await adminModel.findById(decode._id);

    // Validate user existence and token match
    if (!user) {
        throw new ErrorResponse(STATUS_CODES.UNAUTHORIZED, "User not found");
    }
    
    if (user.refreshToken !== refreshToken) {
        throw new ErrorResponse(STATUS_CODES.UNAUTHORIZED, "Refresh token mismatch");
    }

    // Generate new tokens
    const accessToken = user.generateAccessToken();
    const newRefreshToken = user.generateRefreshToken();

    // Update the refresh token in database
    user.refreshToken = newRefreshToken;
    await user.save();

    return {
        tokens: {
            accessToken, 
            refreshToken: newRefreshToken
        }
    };
};