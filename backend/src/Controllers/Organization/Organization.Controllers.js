import { validationResult } from "express-validator";
import { STATUS_CODES } from "../../../constant.js";
import { controllerHandler } from "../../Utils/ControllerHandler.js";
import { ErrorResponse } from "../../Utils/Error.js";
import { organizationCreateServices } from "../../Services/Organization.Services.js";
import { SuccessResponse } from "../../Utils/Success.js";
import { decodeAddress } from "../../Utils/AddressConverter.js";
import { addressCreateServices } from "../../Services/Address.Services.js"
export const registerOrganizationController = controllerHandler(async (req, res) => {
    const adminId = req.user._id;
    // validate the request
    const errors = validationResult(req);

    // if not then throw an error
    if (!errors.isEmpty()) {
        throw new ErrorResponse(STATUS_CODES.BAD_REQUEST, 'validation faild', errors.array())
    }

    let dataObject = { adminId, ...req.body }

    const address = req.body.address
    const response = await decodeAddress(address)
    if (response.error) {
        throw new ErrorResponse(STATUS_CODES.BAD_REQUEST, response.error)
    }
    
    const locationData = {...response[0], address}
    const addressModelObject = await addressCreateServices(locationData)

    dataObject.address = addressModelObject._id
    const organization = await organizationCreateServices(dataObject)

    // return response
    return res.status(STATUS_CODES.CREATED)
        .json(new SuccessResponse(
            STATUS_CODES.CREATED,
            'organization created successfully', { organization: organization }).toJson());
})