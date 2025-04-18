import axios from 'axios';
import FormData from 'form-data';
import { ErrorResponse } from './Error.js';

// API credentials
const getApiCredentials = () => ({
    api_key: process.env.FACE_PLUS_API_KEY,
    api_secret: process.env.FACE_PLUS_API_SECRET,
});

// Helper function to create form data and headers
const createFormData = (data) => {
    console.log(data);
    const form = new FormData();
    Object.entries(data).forEach(([key, value]) => form.append(key, value));
    return { form, headers: { ...form.getHeaders() } };
};

// General function for making API requests
const makeApiRequest = async (url, data, action) => {
    const credentials = getApiCredentials();
    const { form, headers } = createFormData({ ...credentials, ...data });
    try {
        console.log(`${action} in progress...`);
        const response = await axios.post(url, form, { headers });
        console.log(`${action} completed`);
        return { data: response.data, status: response.status };
    } catch (error) {
        console.error(`Error during ${action}:`, error.response?.data || error.message);
        // Return a meaningful error message
        throw new ErrorResponse(
            error.response?.status || 500, 
            error.response?.data?.error_message || 'An unexpected error occurred',
        )
    }
};

// Register a face by detecting it in an image
export const faceRegistration = async (imageUrl) => {
    const result = await makeApiRequest(
        'https://api-us.faceplusplus.com/facepp/v3/detect',
        { image_url: imageUrl },
        'Face Registration'
    );
    if (result.error) {
        return result; // Return the error if the request failed
    }
    return { ...result, faceToken: result.data.faces?.[0]?.face_token };
};

// Verify a face by comparing a face_token with an image URL
export const faceVerification = async (faceToken, imageUrl) => {
    const result = await makeApiRequest(
        'https://api-us.faceplusplus.com/facepp/v3/compare',
        { face_token1: faceToken, image_url2: imageUrl },
        'Face Verification'
    );
    return result;
};

// Delete a registered face using its face_token
export const deleteFace = async (faceToken) => {
    const result = await makeApiRequest(
        'https://api-us.faceplusplus.com/facepp/v3/face/delete',
        { face_token: faceToken },
        'Face Deletion'
    );
    return result;
};