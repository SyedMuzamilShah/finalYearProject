import mongoose, {Schema, model} from "mongoose";


const addressSchema = new Schema(
    {
        name: {
            type: String
        },
        city: {
            type: String
        },

        country: {
            type: String
        },

        location: {
            type: {
                type: String,
                enum: ['Point'],
            },
            coordinates: {
                type: [Number],
                minlength : 2,
                maxlength : 2,
            },
        },
    
    }
)


export const addressModel = model('address', addressSchema)