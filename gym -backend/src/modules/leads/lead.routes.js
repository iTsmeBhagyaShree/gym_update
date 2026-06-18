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

const router = Router();

// Create a new lead
router.post("/", addLead);

// Bulk allocate unassigned leads to a staff member (Admin only)
router.post("/bulk-allocate", bulkAllocateLeads);

// Get all leads globally for Super Admin
router.get("/superadmin/all", getSuperAdminLeads);

// Get all leads for an admin (Admin/owner view)
router.get("/admin/:adminId", getAllLeads);

// Get lead distribution summary across staff (Admin only)
router.get("/distribution/:adminId", getLeadDistribution);

// Get only assigned leads for a specific staff/sales agent (Clash-Free CRM)
router.get("/staff/:staffId", getLeadsByStaff);

// Update a lead
router.put("/:id", updateLead);

// Delete a lead
router.delete("/:id", deleteLead);

export default router;
