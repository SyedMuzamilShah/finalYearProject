import { validationResult } from "express-validator";
import { ErrorResponse } from "./Error.js";
import { STATUS_CODES } from "../../constant.js";


export const validateHandler = (req, res, next) => {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
        console.log(errors);
        throw new ErrorResponse(STATUS_CODES.BAD_REQUEST, 'Validation failed', errors.array());
    }
    next()
}