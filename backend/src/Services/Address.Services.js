import { STATUS_CODES } from "../../constant.js";
import { addressModel } from "../Models/Address.Model.js";
import { ErrorResponse } from "../Utils/Error.js";




export const addressCreateServices = async (addressObject) => {
    //// That type response come
    // {
    //     latitude: 30.199,
    //     longitude: 67.00971,
    //     country: 'Pakistan',
    //     city: undefined,
    //     state: 'Balochistān',
    //     zipcode: undefined,
    //     streetName: undefined,
    //     streetNumber: undefined,
    //     countryCode: 'pk',
    //     county: undefined,
    //     extra: { confidence: 7, confidenceKM: 5 },
    //     provider: 'opencage',
    //     address: 'pattal road quetta'
    // }

    const { address, city, country, latitude, longitude} = addressObject;
    console.log(address)
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