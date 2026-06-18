import { pool } from "../../config/db.js"; // make sure it's a mysql2/promise pool
import nodemailer from "nodemailer";
import { dispatchNotification } from "../../utils/notificationDispatcher.js";

/**
 * Send notification using MySQL pool
 * @param {Object} params
 * @param {"EMAIL"|"WHATSAPP"|"SMS"} params.type
 * @param {string} params.to
 * @param {string} params.message
 * @param {number} [params.memberId]
 */
export const sendNotificationService = async ({ type, to, message, memberId }) => {
  // Log notification with PENDING status
  const [logResult] = await pool.query(
    `INSERT INTO notificationLog (type, \`to\`, message, memberId, status)
     VALUES (?, ?, ?, ?, ?)`,
    [type, to, message, memberId || null, "PENDING"]
  );
  const logId = logResult.insertId;

  try {
    if (type === "EMAIL") {
      const transporter = nodemailer.createTransport({
        host: process.env.SMTP_HOST,
        port: Number(process.env.SMTP_PORT) || 587,
        secure: false,
        auth: { user: process.env.SMTP_USER, pass: process.env.SMTP_PASS },
      });

      await transporter.sendMail({
        from: process.env.MAIL_FROM,
        to,
        subject: "Gym Notification",
        text: message,
      });

      // Update log as SENT
      await pool.query(
        `UPDATE notificationLog SET status = ? WHERE id = ?`,
        ["SENT", logId]
      );
    }

    // WHATSAPP / SMS placeholders
    // if (type === "WHATSAPP") { ... }
    // if (type === "SMS") { ... }

    return { id: logId, type, to, message, memberId, status: "SENT" };
  } catch (err) {
    // Update log as FAILED
    await pool.query(
      `UPDATE notificationLog SET status = ?, error = ? WHERE id = ?`,
      ["FAILED", err.message, logId]
    );
    throw new Error("Notification sending failed: " + err.message);
  }
};

export const getUserNotificationsService = async (userId) => {
  const [rows] = await pool.query(
    `SELECT * FROM notificationlog 
     WHERE \`to\` = ? AND type = 'IN-APP' AND status = 'UNREAD'
     ORDER BY createdAt DESC LIMIT 20`,
    [userId.toString()]
  );
  return rows;
};

export const markAsReadService = async (id) => {
  await pool.query(
    `UPDATE notificationlog SET status = 'READ' WHERE id = ?`,
    [id]
  );
  return true;
};

// --- Broadcast Services for Super Admin ---

export const broadcastAnnouncementService = async ({
  subject,
  message,
  channels,
  targetRoles,
  sentBy
}) => {
  // 1. Fetch target users who are active and match target roles
  const [users] = await pool.query(
    `SELECT id, fullName, email, phone 
     FROM user 
     WHERE roleId IN (?) AND status = 'Active'`,
    [targetRoles]
  );

  console.log(`📣 Broadcasting announcement to ${users.length} target users...`);

  // 2. Save announcement to history table
  await pool.query(
    `INSERT INTO announcement (subject, message, channels, targetRoles, sentBy) 
     VALUES (?, ?, ?, ?, ?)`,
    [
      subject,
      message,
      JSON.stringify(channels),
      JSON.stringify(targetRoles),
      sentBy || null
    ]
  );

  let successCount = 0;
  let failCount = 0;

  // 3. Dispatch notifications asynchronously for each target user
  for (const user of users) {
    try {
      dispatchNotification({
        category: "announcement",
        toEmail: user.email,
        toPhone: user.phone,
        toUserId: user.id,
        subject,
        message,
        customChannels: channels
      }).catch(err => console.error(`❌ Async dispatch error for user ${user.id}:`, err.message));
      
      successCount++;
    } catch (err) {
      console.error(`❌ Failed to initiate broadcast for user ${user.id}:`, err.message);
      failCount++;
    }
  }

  return {
    totalTargeted: users.length,
    successCount,
    failCount
  };
};

export const getBroadcastHistoryService = async () => {
  const [rows] = await pool.query(
    `SELECT a.*, u.fullName AS senderName 
     FROM announcement a
     LEFT JOIN user u ON u.id = a.sentBy
     ORDER BY a.id DESC`
  );
  
  return rows.map(r => ({
    ...r,
    channels: JSON.parse(r.channels),
    targetRoles: JSON.parse(r.targetRoles)
  }));
};
