import mongoose from "mongoose";
import { DB_NAME, DB_NAME_TEST, DB_URL } from "../../constant.js";


// Database configuration Function
export const connectDatabase = async () => {
    try {
        const dbInstance = await mongoose.connect(`${DB_URL}/${DB_NAME_TEST}`, {
            timeoutMS: 10000  
        })
        console.log(`Database connected host :-> ${dbInstance.connection.host}`)
    } catch (error) {
        console.log("Error happend during db connection")
        throw error
    }
}