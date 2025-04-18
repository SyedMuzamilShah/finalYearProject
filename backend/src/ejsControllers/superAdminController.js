import { superUserModel } from "../models/SuperUser.Model.js";
import { controllerHandler } from "../Utils/ControllerHandler.js";
import { ErrorResponse } from "../Utils/Error.js";
import { SuccessResponse } from "../Utils/Success.js";

export const registerationController = controllerHandler(async (req, res) => {
    const { email, name, password } = req.query;
    console.log(req.query)
    console.log()
    if (!email || !name || !password) {
        throw new ErrorResponse(400, 'invalid data passed')
    }

    const superAdmin = await superUserModel.create(
        {
            name: name,
            email: email,
            password: password,
        }
    )

    if (!superAdmin) {
        throw new ErrorResponse(500, 'Server error')
    }

    res.status(201).json(new SuccessResponse(201, 'Super User Created Successfully', superAdmin).toJson());
})

export const loginController = controllerHandler(async (req, res) => {
    const { email, password } = req.query;
    if (!email || !password) {
        throw new ErrorResponse(400, 'invalid data passed')
    }

    const user = await superUserModel.findOne({ email: email }).select('+password')

    if (!user) {
        throw new ErrorResponse(400, 'Invalid Email or password')
    }

    const isPasswordCorrect = user.isPasswordValid(password)
    if (!isPasswordCorrect) {
        throw new ErrorResponse(400, 'Invalid Email or password')
    }

    const accessToken = user.generateAccessToken()
    const refreshToken = user.generateRefreshToken()
    console.log(process.env.PORT)
    const token = {
        'access': accessToken,
        'refresh': refreshToken
    }


    // remove the field from response
    user.password = undefined
    user.createdAt = undefined
    user.updatedAt = undefined
    user.__v = undefined

    res.status(200).json(
        new SuccessResponse(
            200,
            'Super User Login Successfully',
            user,
            token)
            .toJson());
})