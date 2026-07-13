import { v2 as cloudinary } from "cloudinary";
import fs from "fs";
import dotenv from "dotenv";
dotenv.config();

cloudinary.config({
  cloud_name: process.env.CLOUDINARY_CLOUD_NAME,
  api_key: process.env.CLOUDINARY_API_KEY,
  api_secret: process.env.CLOUDINARY_API_SECRET,
});

export const uploadToCloudinary = async (file, folder) => {
  try {
    // Handle single file or file array
    const fileObj = Array.isArray(file) ? file[0] : file;

    const isImage = fileObj.mimetype.startsWith("image/");
    const isPdf = fileObj.mimetype === "application/pdf" || fileObj.name?.toLowerCase().endsWith(".pdf");
    const resourceType = (isImage || isPdf) ? "image" : "raw";

    const uploadOptions = {
      folder,
      resource_type: resourceType,
    };
    if (isPdf) {
      uploadOptions.format = "pdf";
    }

    const upload = await cloudinary.uploader.upload(fileObj.tempFilePath, uploadOptions);

    // delete temp file after upload
    if (fileObj.tempFilePath && fs.existsSync(fileObj.tempFilePath)) {
      fs.unlinkSync(fileObj.tempFilePath);
    }

    return upload.secure_url;
  } catch (err) {
    console.log("Cloudinary error =>", err);
    try { fs.writeFileSync('cloudinary-error.log', JSON.stringify(err, null, 2)); } catch (e) {}
    return null;
  }
};

export const deleteFromCloudinary = async (publicId) => {
  if (!publicId) return;
  try {
    await cloudinary.uploader.destroy(publicId);
    console.log(`Cloudinary image deleted: ${publicId}`);
  } catch (error) {
    console.error("Cloudinary delete error:", error);
  }
};

export default cloudinary;
