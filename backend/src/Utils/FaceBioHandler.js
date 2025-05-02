import axios from 'axios';
import FormData from 'form-data';
import { ErrorResponse } from './Error.js';
import fs from "fs"
// Fetch and validate API credentials
const getApiCredentials = () => {
    const api_key = process.env.FACE_PLUS_API_KEY;
    const api_secret = process.env.FACE_PLUS_API_SECRET;

    if (!api_key || !api_secret) {
        throw new ErrorResponse(500, "Missing Face++ API credentials.");
    }

    return { api_key, api_secret };
};

// Helper function to create form data
const createFormData = (data) => {
    const form = new FormData();
    Object.entries(data).forEach(([key, value]) => form.append(key, value));
    return { form, headers: form.getHeaders() };
};

// General function for making API requests
const makeApiRequest = async (url, data, action) => {
    try {
        const credentials = getApiCredentials();
        const { form, headers } = createFormData({ ...credentials, ...data });

        const response = await axios.post(url, form, { headers });

        console.log(`[${action}] Success:`, response.data);
        // console.log(response.data)
        return response.data;
    } catch (error) {
        const status = error.response?.status || 500;
        const message = error.response?.data?.error_message || error.message || "Unknown error occurred";
        
        console.error(`[${action}] Failed - Status: ${status}, Message: ${message}`);
        throw new ErrorResponse(status, message);
    }
};

// Register a face by detecting it in an image
export const faceRegistration = async (imageUrl) => {
    const data = await makeApiRequest(
        'https://api-us.faceplusplus.com/facepp/v3/detect',
        { image_url: imageUrl },
        'Face Registration'
    );

    const faceToken = data.faces?.[0]?.face_token;
    if (!faceToken) throw new ErrorResponse(400, "No face detected in the image.");

    return { faceToken, data };
};

// Verify a face by comparing a face_token with an image URL
export const faceVerification = async (faceToken, localImage) => {
    // Create read stream

    const imageStream = fs.createReadStream(localImage);

    return makeApiRequest(
        'https://api-us.faceplusplus.com/facepp/v3/compare',
        { face_token1: faceToken, image_file2: imageStream },
        'Face Verification'
    );
};

// Delete a registered face using its face_token
export const deleteFace = async (faceToken) => {
    return makeApiRequest(
        'https://api-us.faceplusplus.com/facepp/v3/face/delete',
        { face_token: faceToken },
        'Face Deletion'
    );
};


export const registerLocalImage = async ( localImage ) => {
    // Create read stream
    const imageStream = fs.createReadStream(localImage);

    try {
        const data = await makeApiRequest(
            'https://api-us.faceplusplus.com/facepp/v3/detect',
            { image_file : imageStream},
            'Face Registration Local'
        );
    
        const faceToken = data.faces?.[0]?.face_token;
        if (!faceToken) throw new ErrorResponse(400, "No face detected in the image.");
    
        return { faceToken, data };
    } catch (err) {
     throw err   
    }

}