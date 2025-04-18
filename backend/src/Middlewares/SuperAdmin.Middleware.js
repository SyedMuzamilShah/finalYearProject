import { controllerHandler } from '../Utils/ControllerHandler.js'
import { ErrorResponse } from '../Utils/Error.js'
import { STATUS_CODES } from '../../constant.js'
import jwt from 'jsonwebtoken'
import { superUserModel } from "../models/SuperUser.Model.js"


export const superAdminJwtDecode = controllerHandler(async (req, _, next)=> {
    try {
        // Get access token from web cookies | frontend header 
        const token = req.cookies?.accessToken || req.header("Authorization")?.replace("Bearer ", "")

        // if access token is not present then throw an error
        if (!token) throw new ErrorResponse(STATUS_CODES.UNAUTHORIZED, "Access token is required")

        // decode the access token
        const decode = jwt.verify(token, process.env.ACCESS_TOKEN_SECRET_KEY, (error, decode)=> {

            // if error occurs then throw an error
            if (error){
                if (error.name === 'TokenExpiredError') throw new ErrorResponse(STATUS_CODES.UNAUTHORIZED, "Access token expired")
                else throw new ErrorResponse(STATUS_CODES.UNAUTHORIZED, "Invalid token")
            }

            // return the decode token
            return decode;
        })

        // find the user _id in database and get whole user document
        const user = await superUserModel.findById(decode?._id)

        // if user not found then throw an error
        if (!user) throw new ErrorResponse(STATUS_CODES.UNAUTHORIZED, "User not found")

        // add new field in request object
        req.user = user

        // move forward
        next()
    } catch (e){

        // if error occurs then throw an error first access happend message | code if not then add own message | code
        throw new ErrorResponse(
            error.statusCode || STATUS_CODES.UNAUTHORIZED,
            error.message || "Unauthorized access"
        );
    }
})