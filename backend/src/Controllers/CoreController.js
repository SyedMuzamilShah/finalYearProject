import { validationResult } from "express-validator";
import { controllerHandler } from "../Utils/ControllerHandler.js";
import { ErrorResponse } from "../Utils/Error.js"
import { generateUniqueId } from "../Utils/GenerteId.js";
import { SuccessResponse } from "../Utils/Success.js"
import { STATUS_CODES } from "../../constant.js"
import { organizationModel } from "../Models/Organization.Model.js";
export const uniqueIdGenerator = controllerHandler(async (req, res) => {
    const hash = generateUniqueId()

    res.status(STATUS_CODES.SUCCESS).json(new SuccessResponse(STATUS_CODES.SUCCESS, 'Success', hash).toJson())
})


export const confirmUserSelectedId = controllerHandler(async (req, res) => {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
            throw new ErrorResponse(STATUS_CODES.BAD_REQUEST, errors.array()).toJson()
    }
    const uniqueId = req.body;
    const isPresent = await organizationModel.find({ uniqueName: uniqueId })


    if (isPresent) {
        const generateUniqueId = generateUniqueId()
        throw new ErrorResponse(STATUS_CODES.BAD_REQUEST, 'Id already in use place select an other', undefined, generateUniqueId).toJson()
    }
    res.status(STATUS_CODES.SUCCESS).json(new SuccessResponse(STATUS_CODES.SUCCESS, 'Success', undefined, undefined).toJson())
});