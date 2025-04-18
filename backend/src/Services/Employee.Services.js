import { STATUS_CODES } from "../../constant.js";
import { employeeModel } from "../Models/Employee.Model.js";
import { biometricTokenModel } from "../Models/EmployeeBiometric.Model.js";
import { ErrorResponse } from "../Utils/Error.js";

export const EmployeeCreateServices = async (dataObject) => {
    
    const { email, name, password, role, phoneNumber, organizationId, biometricTokenId, imageUrl } = dataObject;

    try {
        // Check if employee is already registered
        const existingUser = await employeeModel.findOne({
            $or: [{ email }]
        }).lean();

        if (existingUser) {
            throw new ErrorResponse(
                STATUS_CODES.CONFLICT,
                'Employee already registered'
            );
        }

        // Create a new employee instance
        const employee = new employeeModel({
            imageUrl,
            name,
            email,
            password,
            biometricTokenId,
            phoneNumber,
            role,
            organizationId
        });

        // Save the employee within the transaction
        await employee.save();

        // Generate tokens
        const access = employee.generateAccessToken();
        const refresh = employee.generateRefreshToken();

        // Save tokens to the employee document
        employee.refreshToken = refresh;
        await employee.save();

        // Prepare response
        const tokens = { accessToken: access, refreshToken: refresh };
        const userResponse = employee.toObject();
        delete userResponse.password;
        delete userResponse.__v;
        delete userResponse.refreshToken;

        return { userResponse, tokens };

    } catch (err) {
        throw new ErrorResponse(500, err.message)
    }
};

export const faceRegistrationServices = async (dataObject) => {
    const { imageUrl, faceToken, userId } = dataObject;

    const session = await employeeModel.startSession();
    session.startTransaction();

    try {
        // Find the employee by userId
        const employee = await employeeModel.findOne({ _id: userId }).session(session);

        if (!employee) {
            throw new ErrorResponse(
                STATUS_CODES.NOT_FOUND,
                'Employee not found'
            );
        }

        // Create or update biometric token for face registration
        const biometricToken = await biometricTokenModel.findOneAndUpdate(
            { employeeId: userId },
            { imageToken: faceToken, imageUrl },
            { upsert: true, new: true, session }
        );

        // Update employee's biometricToken reference
        employee.biometricToken = biometricToken._id;
        await employee.save({ session });

        // Commit the transaction
        await session.commitTransaction();
        session.endSession();

        return { message: 'Face registration successful', biometricToken };

    } catch (err) {
        // Roll back the transaction on error
        await session.abortTransaction();
        session.endSession();
        throw err;
    }
};

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