import { pool } from "../../config/db.js";

/**
 * Add a new lead
 */
export const addLeadService = async (data) => {
  const { adminId, branchId, fullName, email, phone, gender, source = "Walk-in", status = "New", notes, followUpDate, assignedToStaffId } = data;

  if (!adminId || !fullName || !phone) {
    throw { status: 400, message: "adminId, fullName, and phone are required" };
  }

  const parsedAdminId = parseInt(adminId);
  const parsedBranchId = (branchId && branchId !== "undefined" && branchId !== "null" && branchId !== "") ? parseInt(branchId) : null;
  const parsedStaffId = (assignedToStaffId && assignedToStaffId !== "undefined" && assignedToStaffId !== "null" && assignedToStaffId !== "") ? parseInt(assignedToStaffId) : null;
  const parsedFollowUpDate = (followUpDate && followUpDate !== "undefined" && followUpDate !== "null" && followUpDate !== "") ? followUpDate : null;

  const [result] = await pool.query(
    `INSERT INTO leads (adminId, branchId, fullName, email, phone, gender, source, status, assignedToStaffId, notes, followUpDate, createdAt, updatedAt)
     VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, NOW(), NOW())`,
    [
      parsedAdminId,
      parsedBranchId,
      fullName,
      email || null,
      phone,
      gender || null,
      source,
      status,
      parsedStaffId,
      notes || null,
      parsedFollowUpDate
    ]
  );

  return {
    id: result.insertId,
    adminId: parsedAdminId,
    fullName,
    email,
    phone,
    gender,
    source,
    status,
    notes,
  };
};

/**
 * Get all leads for a specific admin (gym owner)
 */
export const getAllLeadsService = async (adminId) => {
  const [rows] = await pool.query(
    `SELECT * FROM leads WHERE adminId = ? ORDER BY createdAt DESC`,
    [adminId]
  );
  return rows;
};

/**
 * Get all leads for superadmin (global CRM)
 */
export const getSuperAdminLeadsService = async () => {
  const [rows] = await pool.query(
    `SELECT leads.*, user.fullName as adminName, user.gymName as gymName, branch.name as branchName 
     FROM leads 
     LEFT JOIN user ON leads.adminId = user.id 
     LEFT JOIN branch ON leads.branchId = branch.id
     ORDER BY leads.createdAt DESC`
  );
  return rows;
};

/**
 * Update a lead (status, notes, etc.)
 */
export const updateLeadService = async (id, data) => {
  const { status, notes, fullName, email, phone, gender, followUpDate, source, assignedToStaffId } = data;

  // Fetch existing
  const [[existing]] = await pool.query("SELECT * FROM leads WHERE id = ?", [id]);
  if (!existing) {
    throw { status: 404, message: "Lead not found" };
  }

  let parsedStaffId = existing.assignedToStaffId;
  if (assignedToStaffId !== undefined) {
    parsedStaffId = (assignedToStaffId && assignedToStaffId !== "undefined" && assignedToStaffId !== "null" && assignedToStaffId !== "") ? parseInt(assignedToStaffId) : null;
  }

  let parsedFollowUpDate = existing.followUpDate;
  if (followUpDate !== undefined) {
    parsedFollowUpDate = (followUpDate && followUpDate !== "undefined" && followUpDate !== "null" && followUpDate !== "") ? followUpDate : null;
  }

  await pool.query(
    `UPDATE leads SET 
      fullName = COALESCE(?, fullName),
      email = COALESCE(?, email),
      phone = COALESCE(?, phone),
      gender = COALESCE(?, gender),
      source = COALESCE(?, source),
      status = COALESCE(?, status),
      assignedToStaffId = ?,
      notes = COALESCE(?, notes),
      followUpDate = ?,
      updatedAt = NOW()
     WHERE id = ?`,
    [
      fullName !== undefined ? fullName : null, 
      email !== undefined ? email : null, 
      phone !== undefined ? phone : null, 
      gender !== undefined ? gender : null, 
      source !== undefined ? source : null, 
      status !== undefined ? status : null, 
      parsedStaffId, 
      notes !== undefined ? notes : null, 
      parsedFollowUpDate, 
      id
    ]
  );

  const [[updatedLead]] = await pool.query("SELECT * FROM leads WHERE id = ?", [id]);
  return updatedLead;
};

/**
 * Delete a lead
 */
export const deleteLeadService = async (id) => {
  const [result] = await pool.query("DELETE FROM leads WHERE id = ?", [id]);
  if (result.affectedRows === 0) {
    throw { status: 404, message: "Lead not found" };
  }
  return true;
};

/**
 * Get leads assigned to a specific staff member (Sales Agent view)
 * Sales agents can ONLY see their own assigned leads - Clash-Free CRM
 */
export const getLeadsByStaffService = async (staffId) => {
  const parsedStaffId = parseInt(staffId);
  if (!parsedStaffId) {
    throw { status: 400, message: "staffId is required" };
  }

  const [rows] = await pool.query(
    `SELECT leads.*, 
            user.fullName as assignedStaffName
     FROM leads
     LEFT JOIN staff ON leads.assignedToStaffId = staff.id
     LEFT JOIN user ON staff.userId = user.id
     WHERE leads.assignedToStaffId = ?
     ORDER BY leads.createdAt DESC`,
    [parsedStaffId]
  );
  return rows;
};

/**
 * Bulk allocate unassigned leads to a staff member (Admin feature)
 * Takes N unassigned leads and assigns them to one staff member
 */
export const bulkAllocateLeadsService = async ({ adminId, staffId, count }) => {
  const parsedAdminId = parseInt(adminId);
  const parsedStaffId = parseInt(staffId);
  const parsedCount = parseInt(count);

  if (!parsedAdminId || !parsedStaffId || !parsedCount) {
    throw { status: 400, message: "adminId, staffId, and count are required" };
  }
  if (parsedCount < 1 || parsedCount > 10000) {
    throw { status: 400, message: "count must be between 1 and 10000" };
  }

  // Fetch unassigned leads for this admin
  const [unassigned] = await pool.query(
    `SELECT id FROM leads 
     WHERE adminId = ? AND (assignedToStaffId IS NULL OR assignedToStaffId = 0)
     ORDER BY createdAt ASC
     LIMIT ?`,
    [parsedAdminId, parsedCount]
  );

  if (unassigned.length === 0) {
    throw { status: 404, message: "No unassigned leads available to allocate" };
  }

  const leadIds = unassigned.map(l => l.id);

  // Bulk update - assign all fetched leads to the staff member
  await pool.query(
    `UPDATE leads SET assignedToStaffId = ?, updatedAt = NOW() WHERE id IN (?)`,
    [parsedStaffId, leadIds]
  );

  return {
    allocatedCount: leadIds.length,
    staffId: parsedStaffId,
    leadIds,
  };
};

/**
 * Get summary of lead distribution across staff members (Admin dashboard view)
 */
export const getLeadDistributionService = async (adminId) => {
  const [rows] = await pool.query(
    `SELECT 
       s.id as staffId,
       u.fullName as staffName,
       COUNT(l.id) as totalAssigned,
       SUM(CASE WHEN l.status = 'Converted' THEN 1 ELSE 0 END) as converted,
       SUM(CASE WHEN l.status = 'New' THEN 1 ELSE 0 END) as newLeads,
       SUM(CASE WHEN l.status = 'In Progress' THEN 1 ELSE 0 END) as inProgress
     FROM staff s
     JOIN user u ON s.userId = u.id
     LEFT JOIN leads l ON l.assignedToStaffId = s.id AND l.adminId = ?
     WHERE s.adminId = ?
     GROUP BY s.id, u.fullName
     ORDER BY totalAssigned DESC`,
    [adminId, adminId]
  );

  const [[unassignedRow]] = await pool.query(
    `SELECT COUNT(*) as unassignedCount FROM leads WHERE adminId = ? AND (assignedToStaffId IS NULL OR assignedToStaffId = 0)`,
    [adminId]
  );

  return {
    staffDistribution: rows,
    unassignedCount: unassignedRow.unassignedCount || 0,
  };
};
