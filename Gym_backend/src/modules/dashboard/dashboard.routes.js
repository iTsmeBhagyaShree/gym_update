import { Router } from "express";
import { getDashboardData,getSuperAdminDashboard,getSalesDashboard, getSuperAdminCRMStats } from "./dashboard.controller.js";
import { getSuperAdminRenewals } from "./renewals.controller.js";
import { verifyToken } from "../../middlewares/auth.js";

const router = Router();

router.get("/dashboard", verifyToken(["Superadmin"]), getSuperAdminDashboard);
router.get("/crm-stats", verifyToken(["Superadmin", "Subadmin"]), getSuperAdminCRMStats);
router.get("/sales-dashboard", verifyToken(["Superadmin", "Admin", "sales_agent"]), getSalesDashboard);
router.get("/renewals", verifyToken(["Superadmin", "Subadmin"]), getSuperAdminRenewals);
router.get("/", verifyToken(["Superadmin", "Admin"]), getDashboardData);

export default router;
