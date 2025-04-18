import multer from "multer";
import fs from "fs";

// Ensure the destination folder exists
const ensureFolderExists = (folderPath) => {
  if (!fs.existsSync(folderPath)) {
    fs.mkdirSync(folderPath, { recursive: true });
  }
};

const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    const folderPath = "./public/temp";
    ensureFolderExists(folderPath); // Ensure the folder exists
    cb(null, folderPath);
  },
  filename: function (req, file, cb) {
    cb(null, file.originalname);
  },
});

export const upload = multer({
  storage,
});