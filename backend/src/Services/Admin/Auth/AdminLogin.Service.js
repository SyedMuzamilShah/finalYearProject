import { STATUS_CODES } from "../../../../constant.js";
import { adminModel } from "../../../Models/Admin.Model.js";
import { ErrorResponse } from "../../../Utils/Error.js";


/**
 * Service to handle admin login
 * @param {Object} dataObject - Contains login credentials
 * @returns {Object} - User info and auth tokens
 */
export const adminLoginService = async (dataObject) => {
    const { email, password } = dataObject;
    
    try {
        // Find user including password field for validation
        const user = await adminModel.findOne({ email })
            .select('+password')
            .exec();

        if (!user) {
            throw new ErrorResponse(
                STATUS_CODES.UNAUTHORIZED,
                'Invalid credentials' // Generic message for security
            );
        }

        // Validate password
        const isPasswordValid = await user.isPasswordValid(password);
        if (!isPasswordValid) {
            throw new ErrorResponse(
                STATUS_CODES.UNAUTHORIZED,
                'Invalid credentials'
            );
        }

        // Generate new tokens
        const accessToken = user.generateAccessToken();
        const refreshToken = user.generateRefreshToken();

        // Store refresh token
        user.refreshToken = refreshToken;
        await user.save();

        // Prepare clean response
        const userResponse = user.toObject();
        delete userResponse.password;
        delete userResponse.__v;
        delete userResponse.refreshToken;

        return { 
            user: userResponse, 
            tokens: { 
                accessToken, 
                refreshToken 
            } 
        };
    } catch (err) {
        // Preserve existing error types
        throw err;
    }
};