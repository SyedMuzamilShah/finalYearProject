import { STATUS_CODES } from "../../constant.js";
import { officeAdminModel } from "../Models/Admin.Model.js";
import { organizationModel } from "../Models/Organization.Model.js";
import { ErrorResponse } from "../Utils/Error.js";

export const organizationIsRegisterd = async (dataObject) => {
    const { email, organizationNumber } = dataObject;
    try {
        const query = [{ email }]; // Always include email in the search criteria
        console.log(organizationNumber)
        if (organizationNumber) {
            query.push({ uniqueName: organizationNumber }); // Add organizationNumber only if it exists
        }

        // Check if email or organizationNumber is already registered
        const existingOrganization = await organizationModel.findOne({
            $or: query
        }).lean();

        if (existingOrganization){
            return true;
        }else {
            return false;
        }
        // if (existingOrganization) {
        //     throw new ErrorResponse(
        //         STATUS_CODES.CONFLICT,
        //         'Organization already registered'
        //     );
        // }
        
    } catch (err) {
        // console.log(err.message)
        throw err
    }
}


export const organizationCreateServices = async (dataObject) => {
    console.log("Testing..... @gmail.com")
    // get user data from user request
    const { adminId, name, phoneNumber, address, website, email, organizationNumber } = dataObject
    try {

        const query = [{ email }]; // Always include email in the search criteria

        if (organizationNumber) {
            query.push({ uniqueName: organizationNumber }); // Add organizationNumber only if it exists
        }

        // Check if email or organizationNumber is already registered
        const existingOrganization = await organizationModel.findOne({
            $or: query
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
        throw err
    }
}

export const deleteOrganization = async (dataObject) => {

    const { adminId, id, organizationId } = dataObject;

    try {
        // Construct query dynamically
        let query = { createdBy: adminId };

        if (organizationId) {
            query.organizationId = organizationId;
        } else if (id) {
            query._id = id;
        }

        // Use constructed query for deletion
        const organization = await organizationModel.findOneAndDelete(query);
        
        if (!organization) {
            throw new ErrorResponse(
                STATUS_CODES.BAD_REQUEST,
                'No matching organization found'
            );
        }

        return { success: true, organization };
    } catch (error) {
        console.error("Error deleting organization:", error.message);
        throw error
    }
};


export const getAllOrganization = async (dataObject) => {
    console.log("dataObject")
    console.log(dataObject)

    const { adminId, id, organizationId } = dataObject;

    try {
        // Dynamically construct the query
        let query = { createdBy: adminId }; // Always include adminId

        if (organizationId) {
            query.organizationId = organizationId;
        } else if (id) {
            query._id = id;
        }
        // Fetch organization based on constructed query
        const organization = await organizationModel.find(query);
        // console.log(organization)
        return { organization }
    } catch (error) {
        if (error.name == 'CastError'){
            throw new ErrorResponse(
                STATUS_CODES.BAD_REQUEST,
                error.message
            );
        }
        throw new ErrorResponse(
            STATUS_CODES.BAD_REQUEST,
            `"Error fetching organization:", ${error.message}`
        );
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