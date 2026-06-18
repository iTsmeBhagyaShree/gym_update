import express from "express";
import {
  createSubAdmin,
  getAllSubAdmins,
  updateSubAdmin,
  deleteSubAdmin
} from "./subadmin.controller.js";

const router = express.Router();

router.post("/", createSubAdmin);
router.get("/", getAllSubAdmins);
router.put("/:id", updateSubAdmin);
router.delete("/:id", deleteSubAdmin);

export default router;
