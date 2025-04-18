import { STATUS_CODES } from "../../constant.js";
import { officeAdminModel } from "../Models/Admin.Model.js";
import { organizationModel } from "../Models/Organization.Model.js";
import { ErrorResponse } from "../Utils/Error.js";

export const organizationCreateServices = async (dataObject) => {
    // get user data from user request
    const { adminId, name, phoneNumber, address, website, email, organizationNumber } = dataObject

    try {
        // Check if email is already registered
        const existingOrganization = await organizationModel.findOne({
            $or: [{ email }, { uniqueName: organizationNumber }]
        }).lean();
        if (existingOrganization) {
            throw new ErrorResponse(
                STATUS_CODES.CONFLICT,
                'Organization already registered'
            );
        }

        // Create a new user instance
        const organization = await organizationModel.create({
            name: name,
            email: email,
            phoneNumber, phoneNumber,
            website: website,
            address: address,
            createdBy: adminId,
        });


        const _organization = organization.toObject();
        delete _organization.__v;

        return _organization

    } catch (err) {
        throw new ErrorResponse(500, err.message)
    }
}


export const officeAdminLoginServices = async (email, password) => {
    try {
        // Find the user by email
        const user = await officeAdminModel.findOne({ email }).select('+password');
        if (!user) {
            throw new ErrorResponse(
                STATUS_CODES.UNAUTHORIZED,
                'Invalid email address or password'
            );
        }

        // Validate the password
        const isPasswordValid = await user.isPasswordValid(password);
        if (!isPasswordValid) {
            throw new ErrorResponse(
                STATUS_CODES.UNAUTHORIZED,
                'Invalid email address or password'
            );
        }

        // Generate tokens
        const access = user.generateAccessToken();
        const refresh = user.generateRefreshToken();

        // Save the refresh token in the database (hashed)
        user.refreshToken = await bcrypt.hash(refresh, 10);
        await user.save();

        // Prepare the response
        const userResponse = user.toObject();
        delete userResponse.password;
        delete userResponse.__v;
        delete userResponse.refreshToken;

        return { userResponse, tokens: { accessToken: access, refreshToken: refresh } };
    } catch (err) {
        // Log the error for debugging
        console.error('Login service error:', err);
        throw err;
    }
};


export const officeAdminLogOutServices = async (userId) => {
    try {
        // Find the user by ID
        const user = await officeAdminModel.findById(userId);
        if (!user) {
            throw new ErrorResponse(
                STATUS_CODES.NOT_FOUND,
                'User not found'
            );
        }

        // Remove the refresh token
        user.refreshToken = undefined;
        await user.save();

        return true;
    } catch (err) {
        // Log the error for debugging
        console.error('Logout service error:', err);

        // Re-throw custom errors
        if (err instanceof ErrorResponse) {
            throw err;
        }

        // Throw a generic error for unexpected issues
        throw new ErrorResponse(
            STATUS_CODES.INTERNAL_SERVER_ERROR,
            'Logout failed due to an unexpected error'
        );
    }
};

export const officeAdminChangePasswordServices = async (userId, oldPassword, newPassword) => {
    try {
        // Find the user by ID
        const user = await officeAdminModel.findById(userId).select('+password');
        if (!user) {
            throw new ErrorResponse(
                STATUS_CODES.NOT_FOUND,
                'User not found'
            );
        }

        // Validate the old password
        const isPasswordValid = await user.isPasswordValid(oldPassword);
        if (!isPasswordValid) {
            throw new ErrorResponse(
                STATUS_CODES.BAD_REQUEST,
                'Old password is not valid'
            );
        }

        // Update the password
        user.password = newPassword;
        await user.save(); // This will trigger the pre-save hook to hash the password

        // Prepare the response
        const userResponse = user.toObject();
        delete userResponse.password;
        delete userResponse.__v;
        delete userResponse.refreshToken;

        return userResponse;
    } catch (err) {
        // Log the error for debugging
        console.error('Change password service error:', err);

        // Re-throw custom errors
        if (err instanceof ErrorResponse) {
            throw err;
        }

        // Throw a generic error for unexpected issues
        throw new ErrorResponse(
            STATUS_CODES.INTERNAL_SERVER_ERROR,
            'Password change failed due to an unexpected error'
        );
    }
};