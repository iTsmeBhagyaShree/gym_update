import { Router } from "express";
import {
  addLead,
  getAllLeads,
  updateLead,
  deleteLead,
  getSuperAdminLeads,
  getLeadsByStaff,
  bulkAllocateLeads,
  getLeadDistribution,
} from "./lead.controller.js";
import { verifyToken } from "../../middlewares/auth.js";

const router = Router();

// Create a new lead
router.post("/", verifyToken(["Superadmin", "Admin", "receptionist", "sales_agent"]), addLead);

// Bulk allocate unassigned leads to a staff member (Admin only)
router.post("/bulk-allocate", verifyToken(["Superadmin", "Admin"]), bulkAllocateLeads);

// Get all leads globally for Super Admin
router.get("/superadmin/all", verifyToken(["Superadmin"]), getSuperAdminLeads);

// Get all leads for an admin (Admin/owner view)
router.get("/admin/:adminId", verifyToken(["Superadmin", "Admin", "receptionist"]), getAllLeads);

// Get lead distribution summary across staff (Admin only)
router.get("/distribution/:adminId", verifyToken(["Superadmin", "Admin"]), getLeadDistribution);

// Get only assigned leads for a specific staff/sales agent (Clash-Free CRM)
router.get("/staff/:staffId", verifyToken(["Superadmin", "Admin", "sales_agent", "receptionist"]), getLeadsByStaff);

// Update a lead
router.put("/:id", verifyToken(["Superadmin", "Admin", "receptionist", "sales_agent"]), updateLead);

// Delete a lead
router.delete("/:id", verifyToken(["Superadmin", "Admin", "receptionist"]), deleteLead);

export default router;
