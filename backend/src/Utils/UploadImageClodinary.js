import {v2 as cloudinary} from "cloudinary"
import fs from "fs"


const cloudConfiger = () => {
    cloudinary.config({ 
        cloud_name: process.env.CLOUDINARY_CLOUD_NAME, 
        api_key: process.env.CLOUDINARY_API_KEY, 
        api_secret: process.env.CLOUDINARY_API_SECRET 
    });
}

export const uploadOnCloudinary = async (localImagePath) => {
    cloudConfiger()
    try {
        if (!localImagePath) return null
        //upload the file on cloudinary
        const response = await cloudinary.uploader.upload(localImagePath, {
            resource_type: "auto"
        })
        // file has been uploaded successfull
        //console.log("file is uploaded on cloudinary ", response.url);
        // fs.unlinkSync(localImagePath)
        return response.url;

    } catch (error) {
        // fs.unlinkSync(localImagePath) // remove the locally saved temporary file as the upload operation got failed
        return null;
    }
}
