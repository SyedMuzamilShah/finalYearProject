
import { STATUS_CODES } from "../../../constant.js";
import { controllerHandler } from "../../Utils/ControllerHandler.js";
import { ErrorResponse } from "../../Utils/Error.js";
import { deleteOrganization, getAllOrganization, organizationCreateServices, organizationIsRegisterd } from "../../Services/Organization.Services.js";
import { SuccessResponse } from "../../Utils/Success.js";
import { decodeAddress } from "../../Utils/AddressConverter.js";
import { addressCreateServices } from "../../Services/Address.Services.js"
import { validationResult } from "express-validator";
export const registerOrganizationController = controllerHandler(async (req, res) => {
    const adminId = req.user._id;
    // validate the request
    const errors = validationResult(req);

    // if not then throw an error
    if (!errors.isEmpty()) {
        throw new ErrorResponse(STATUS_CODES.BAD_REQUEST, 'validation faild', errors.array())
    }

    let dataObject = { adminId, ...req.body }
    try {
        var isRegisterd = await organizationIsRegisterd(dataObject)
    }catch (err){
        throw new ErrorResponse(
            STATUS_CODES.INTERNAL_SERVER_ERROR,
            'Internel server error please try again'
        );
    }
    if (isRegisterd) {
        throw new ErrorResponse(
            STATUS_CODES.CONFLICT,
            'With That Email Organization is already registerd'
        );
    }

    const address = req.body.address
    const response = await decodeAddress(address)

    if (response.error) {
        throw new ErrorResponse(STATUS_CODES.BAD_REQUEST, response.error)
    }

    // const locationData = { ...response[0], address }
    // const addressModelObject = await addressCreateServices(locationData)

    // dataObject.address = addressModelObject._id
    dataObject.address = "67da450365ab8a16a9ef9649"

    const organization = await organizationCreateServices(dataObject)

    // return response
    return res.status(STATUS_CODES.CREATED)
        .json(new SuccessResponse(
            STATUS_CODES.CREATED,
            'organization created successfully', { organization: organization }).toJson());
})

export const getAllAdminOrganization = controllerHandler(async (req, res) => {
    const adminId = req.user._id;
    // validate the request

    const errors = validationResult(req);

    // if not then throw an error
    if (!errors.isEmpty()) {
        throw new ErrorResponse(STATUS_CODES.BAD_REQUEST, 'validation faild', errors.array())
    }

    let dataObject = { adminId, ...req.body, ...req.query }

    const { organization } = await getAllOrganization(dataObject)
    console.log(organization)
    // return response
    return res.status(STATUS_CODES.OK)
        .json(new SuccessResponse(
            STATUS_CODES.OK,
            'organization get Successfully', { organization: organization }).toJson());
})


export const delteAdminOrganization = controllerHandler(async (req, res) => {
    const adminId = req.user._id;
    // validate the request

    const errors = validationResult(req);

    // if not then throw an error
    if (!errors.isEmpty()) {
        throw new ErrorResponse(STATUS_CODES.BAD_REQUEST, 'validation faild', errors.array())
    }

    let dataObject = { adminId, ...req.query }

    const { organization } = await deleteOrganization(dataObject)
    // return response
    return res.status(STATUS_CODES.SUCCESS_NO_RESPONSE)
        .json(new SuccessResponse(
            STATUS_CODES.SUCCESS_NO_RESPONSE,
            'organization delete Successfully', { organization: organization }).toJson());
})