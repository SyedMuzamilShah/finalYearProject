import { STATUS_CODES } from "../../constant.js";
import { addressModel } from "../Models/Address.Model.js";
import { ErrorResponse } from "../Utils/Error.js";

export const addressCreateServices = async (addressObject) => {
    const { address, city, country, latitude, longitude} = addressObject;
    try {
        const addr = await addressModel.create({
            name : address,
            city,
            country,
            location : {
                type: 'Point',
                coordinates: [latitude, longitude]
            }
        })

        return addr;
    } catch (err) {
        // Log the error for debugging
        console.error('Get profile service error:', err);

        // Re-throw custom errors
        if (err instanceof ErrorResponse) {
            throw err;
        }

        // Throw a generic error for unexpected issues
        throw new ErrorResponse(
            STATUS_CODES.INTERNAL_SERVER_ERROR,
            'Profile retrieval failed due to an unexpected error'
        );
    }
};