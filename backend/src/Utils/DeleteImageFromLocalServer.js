import fs from "fs";
import path from "path";

export const deleteImage = (imagePath) => {
    const basePath = path.join(process.cwd(), "public", "temp");
    const imageFileName = path.basename(imagePath);
    const completePath = path.join(basePath, imageFileName);

    try {
        if (fs.existsSync(completePath)) {
            fs.unlinkSync(completePath);
            console.log(`Deleted image: ${completePath}`);
        } else {
            console.warn(`File not found: ${completePath}`);
        }
    } catch (error) {
        console.error(`Error deleting image at ${completePath}:`, error);
    }
};
