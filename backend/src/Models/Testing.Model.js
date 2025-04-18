import mongoose, {Schema, model} from "mongoose";
import { nanoid } from "nanoid";

const testingSchema = new Schema(
    {
        // _id: {
        //     type: String,
        //     default: () => `EMP-${nanoid(6).toUpperCase()}`, // e.g., EMP-7s4X9z
        //     unique: true, // Enforce uniqueness
        // },
        name: {
            type: String
        },
    }
)
export const testingModel = model('test', testingSchema)