import { Router } from "express";
import {
  createPlan,
  listPlans,
  updatePlan,
  deletePlan,
  getPlansByBranch
} from "./plan.controller.js";
import { verifyToken } from "../../middlewares/auth.js";

const router = Router();

// Only Superadmin and Admin can manage plans
router.post(
  "/create",
  verifyToken(["Superadmin", "Admin"]),
  createPlan
);

router.get(
  "/",
  verifyToken(["Superadmin", "Admin", "Staff", "Member"]),
  listPlans
);

router.get(
  "/branch/:branchId",
  verifyToken(["Superadmin", "Admin", "Staff", "Member"]),
  getPlansByBranch
);

router.put(
  "/update/:id",
  verifyToken(["Superadmin", "Admin"]),
  updatePlan
);

router.delete(
  "/delete/:id",
  verifyToken(["Superadmin", "Admin"]),
  deletePlan
);

export default router;
