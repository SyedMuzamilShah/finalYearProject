import { STATUS_CODES } from "../../../../constant.js";
import { adminModel } from "../../../Models/Admin.Model.js";
import { ErrorResponse } from "../../../Utils/Error.js";


/**
 * Service to handle admin logout
 * @param {String} userId - ID of the user logging out
 * @returns {Boolean} - Success status
 */
export const adminLogoutService = async (userId) => {
    try {
        // Clear refresh token
        const result = await adminModel.findByIdAndUpdate(
            userId,
            { $set: { refreshToken: null } },
            { new: true }
        );

        if (!result) {
            throw new ErrorResponse(
                STATUS_CODES.NOT_FOUND,
                'User not found'
            );
        }

        return true;
    } catch (err) {
        if (err instanceof ErrorResponse) {
            throw err;
        }
        throw new ErrorResponse(
            STATUS_CODES.INTERNAL_SERVER_ERROR,
            'Logout failed'
        );
    }
};