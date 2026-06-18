import { Router } from "express";
// import { verifyToken } from "../../middlewares/auth.js";
import { getDashboardData,getSuperAdminDashboard,getSalesDashboard, getSuperAdminCRMStats } from "./dashboard.controller.js";

const router = Router();
router.get("/dashboard", getSuperAdminDashboard);
router.get("/crm-stats", getSuperAdminCRMStats);
router.get("/sales-dashboard", getSalesDashboard)
router.get("/",  getDashboardData);

export default router;
