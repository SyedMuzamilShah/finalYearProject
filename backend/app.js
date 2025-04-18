import express from 'express';
import dotenv from 'dotenv'
const app = express();

// middleware to activate the app/server public folder to access them in our all app
app.use(express.static('./public'))

// for ejs used
app.set('view engine', 'ejs');

// Help to get and read json data
app.use(express.json())
app.use(express.urlencoded({ extended: true }));


// Configure `.env` to access any where
dotenv.config({
    path: './.env'
})


const muzamilone = 'https://res.cloudinary.com/dr7jshiux/image/upload/v1741833163/Screenshot_2025-03-13_073215_eq2sba.png'
const muzamiltwo = 'https://res.cloudinary.com/dr7jshiux/image/upload/v1741833162/Screenshot_2025-03-13_073158_syb4kc.png'
const unknow = 'https://res.cloudinary.com/dr7jshiux/image/upload/v1741833162/Screenshot_2025-03-11_221933_qokjnv.png'
const unknowtwo = 'https://res.cloudinary.com/dr7jshiux/image/upload/v1741833162/Screenshot_2025-03-06_163543_qnejpm.png'
const imageUrl = 'https://images.unsplash.com/photo-1567538482802-b29e69d2b0b4?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D';
// View engine configuration


// Routes import
import { superAdminRoutes } from './src/Routes/SuperAdmin.Routes.js';
import { employeeRoutes } from './src/Routes/Employee.Routes.js';
import { officerRoutes } from './src/Routes/OfficeAdmin.Routes.js';
import { STATUS_CODES } from './constant.js';
import { ejsRoutes } from './src/Routes/Ejs.Routes.js';


import { coreRoute } from './src/Routes/Core.Routes.js';

// Routes middleware define redirect to specified routef
app.use('/api/v1/superadmin', superAdminRoutes)
app.use('/api/v1/employee', employeeRoutes)
app.use('/api/v1/admin', officerRoutes)
app.use('/api/v1/unique', coreRoute)

app.use('/api/v1/ejs', ejsRoutes)


const faceToke = '4a13277ed09c210d0089b581f31c1747'
// app.get('/testing', async (req, res) => {
//     // const data = {
//     //     'access sec' : process.env.ACCESS_TOKEN_SECRET_KEY,
//     //     'access time' : process.env.ACCESS_TOKEN_SECRET_TIME,
//     //     'cloud name' : process.env.CLOUDINARY_CLOUD_NAME,
//     //     'cloud key' : process.env.CLOUDINARY_API_KEY,
//     //     'cloud sec' : process.env.CLOUDINARY_API_SECRET,
//     //     'face key' : process.env.FACE_PLUS_API_KEY,
//     //     'face sec' : process.env.FACE_PLUS_API_SECRET
//     // }

//     try {
//         // var response = await faceVerification(faceToke, unknow)
//         var response = await faceRegistration(imageUrl)
//         if (response.status != 200){
//             throw response
//         }
//         res.send(response)

//     }catch(err) {
//         if (err instanceof ErrorResponse) {
//             return res.status(err.statusCode).json(err.toJson())
//         }
//         console.error(`Error Log Last Middleware:\n\t\t ${err.message}`)
    
//         return res.status(STATUS_CODES.SERVER_ERROR)
//             .json({ statusCode: STATUS_CODES.SERVER_ERROR, message: 'some thing went wrong' })
//     }
//     // var response = await deleteFace("31398285a406123fc16ccb69a997c40e")
//     // var response = await faceRegistration('31398285a406123fc16ccb69a997c40e', unknow)
// })
app.get('/testing', async (req, res) =>{
    // const create = await testingModel.create({name: 'muzamil'})
    // res.send(create)
    await sendVerificationEmail('syed.m.shah7878@gmail.com', 'tokencan be passing')
    res.send("Verification....")
})

app.get('/', async (req, res) =>{
    res.send('index')
})
app.get('/verify/:id', async (req, res) =>{
    console.log(req.params.id)
    console.log(req.query.name)
    res.send('Ok go to app the registration is successfully done')
})











import { ErrorResponse } from './src/Utils/Error.js';
import { deleteFace, faceRegistration, faceVerification } from './src/Utils/FaceBioHandler.js';
import { testingModel } from './src/Models/Testing.Model.js';
import { sendVerificationEmail } from './src/Utils/TokenSender.js';
// import { faceRegistration, faceVerification } from './src/utils/faceVerification.js';
// middleware to send the error message from server to backend
app.use((err, _, res, next) => {

    if (err instanceof ErrorResponse) {
        return res.status(err.statusCode).json(err.toJson())
    }
    console.error(`Error Log Last Middleware:\n\t\t ${err.message}`)

    return res.status(STATUS_CODES.SERVER_ERROR)
        .json({ statusCode: STATUS_CODES.SERVER_ERROR, message: 'some thing went wrong' })
})
 

export { app }
