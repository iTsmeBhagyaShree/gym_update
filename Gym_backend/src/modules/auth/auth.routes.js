import { Router } from "express";
import {
  getDashboardStats,
  register,
  login,
  getUserById,
  updateUser,
  deleteUser,
  getAdmins,
  loginMember,
  changePasswordController,
  getAdminDashboard
} from "./auth.controller.js";
import { verifyToken } from "../../middlewares/auth.js";

const router = Router();

router.post("/register", register);
router.post("/login", login);
router.post("/login-member", loginMember);
router.post("/logout", (req, res) => res.json({ success: true, message: "Logged out successfully" }));

router.get("/user/:id", verifyToken(), getUserById);
router.put("/user/:id", verifyToken(), updateUser);
router.delete("/user/:id", verifyToken(["Superadmin", "Admin"]), deleteUser);
router.get("/admins", verifyToken(["Superadmin"]), getAdmins);
router.get("/dashboard", verifyToken(["Superadmin"]), getDashboardStats);
router.put("/changepassword", verifyToken(), changePasswordController);
router.get("/admindashboard/:id", verifyToken(["Superadmin", "Admin"]), getAdminDashboard);

export default router;
