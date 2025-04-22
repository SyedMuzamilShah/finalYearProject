import { STATUS_CODES } from "../../../../constant.js";
import { adminModel } from "../../../Models/Admin.Model.js";
import { ErrorResponse } from "../../../Utils/Error.js";

/**
 * Service to get admin profile
 * @param {String} userId - ID of the user to fetch
 * @returns {Object} - User profile data
 */
export const adminProfileService = async (userId) => {
    try {
        // Find user excluding sensitive fields
        const user = await adminModel.findById(userId)
            .select('-password -__v -refreshToken')
            .lean();

        if (!user) {
            throw new ErrorResponse(
                STATUS_CODES.NOT_FOUND,
                'User not found'
            );
        }

        return { user };
    } catch (err) {
        // Preserve custom errors, wrap others
        if (err instanceof ErrorResponse) {
            throw err;
        }
        throw new ErrorResponse(
            STATUS_CODES.INTERNAL_SERVER_ERROR,
            'Failed to fetch profile'
        );
    }
};