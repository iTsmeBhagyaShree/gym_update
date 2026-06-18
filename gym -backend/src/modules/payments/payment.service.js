import { pool } from "../../config/db.js";
import { dispatchNotification } from "../../utils/notificationDispatcher.js";

// --- Invoice generator ---
function generateInvoiceNo() {
  return "INV-" + Date.now() + "-" + Math.floor(Math.random() * 999);
}

// --- RECORD PAYMENT ---
export const recordPaymentService = async (data) => {
  const { memberId, planId, amount } = data;

  // Verify member exists
  const [[member]] = await pool.query(
    "SELECT * FROM member WHERE id = ?",
    [memberId]
  );
  if (!member) throw { status: 404, message: "Member not found" };

  // Verify plan exists
  const [[plan]] = await pool.query(
    "SELECT * FROM plan WHERE id = ?",
    [planId]
  );
  if (!plan) throw { status: 404, message: "Plan not found" };

  // Insert payment
  const [result] = await pool.query(
    `INSERT INTO payment (memberId, planId, amount, invoiceNo) 
     VALUES (?, ?, ?, ?)`,
    [memberId, planId, amount, generateInvoiceNo()]
  );

  // Trigger global notification dispatch based on Super Admin configurations
  const receiptMsg = `Hi ${member.fullName}, \n\nThank you for your payment of Rs.${amount} for the ${plan.name} plan. \n\nYour membership is now active. Enjoy your workout! 💪\n\nRegards,\nGym Management`;
  
  dispatchNotification({
    category: "invoice",
    toEmail: member.email,
    toPhone: member.phone,
    toUserId: member.userId,
    memberId: member.id,
    subject: `Payment Receipt - ${plan.name}`,
    message: receiptMsg,
  }).catch(err => console.error("Error dispatching payment notification:", err.message));

  return {
    id: result.insertId,
    member,
    plan,
    amount,
    invoiceNo: generateInvoiceNo(),
  };
};

// --- PAYMENT HISTORY FOR MEMBER ---
export const paymentHistoryService = async (memberId) => {
  const [rows] = await pool.query(
    `SELECT p.*, pl.name AS planName, pl.price AS planPrice
     FROM payment p
     LEFT JOIN plan pl ON p.planId = pl.id
     WHERE p.memberId = ?
     ORDER BY p.id DESC`,
    [memberId]
  );
  return rows;
};

// --- ALL PAYMENTS BY ADMIN/BRANCH ---
export const allPaymentsService = async (adminId, branchId) => {
  let query = `SELECT p.*, m.fullName AS memberName, pl.name AS planName, pl.price AS planPrice
     FROM payment p
     LEFT JOIN member m ON p.memberId = m.id
     LEFT JOIN plan pl ON p.planId = pl.id
     WHERE m.adminId = ?`;
     
  const params = [adminId];
  
  if (branchId && branchId !== 'all' && branchId !== '') {
    query += ` AND m.branchId = ?`;
    params.push(branchId);
  }
  
  query += ` ORDER BY p.id DESC`;

  const [rows] = await pool.query(query, params);
  return rows;
};
