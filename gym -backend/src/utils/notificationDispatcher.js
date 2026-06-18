import { pool } from "../config/db.js";
import nodemailer from "nodemailer";
import { sendWhatsAppMessage } from "./whatsappHelper.js";

/**
 * Get active channels for a notification category
 * @param {string} category - "welcome_note" | "invoice" | "templates"
 * @returns {Promise<string[]>} Array of enabled channels, e.g. ["EMAIL", "WHATSAPP"]
 */
export const getGlobalNotificationChannels = async (category) => {
  try {
    const keyName = `${category}_channel`;
    const [rows] = await pool.query(
      "SELECT value_data FROM global_settings WHERE key_name = ?",
      [keyName]
    );

    if (rows.length === 0) {
      return ["EMAIL"]; // fallback default
    }

    return JSON.parse(rows[0].value_data);
  } catch (err) {
    console.error(`Error reading global notification settings for ${category}:`, err.message);
    return ["EMAIL"]; // fallback default on error
  }
};

/**
 * Smart Notification Dispatcher
 * Dispatches notifications to active channels set by the Super Admin
 */
export const dispatchNotification = async ({
  category,
  toEmail,
  toPhone,
  toUserId,
  memberId,
  subject = "Gym Alert",
  message,
  customChannels, // NEW: Support manual channels selection (e.g. for broadcasts)
}) => {
  if (!message) {
    console.warn("⚠️ Notification Dispatcher: Message is empty. Skipping dispatch.");
    return { success: false, reason: "Message is empty" };
  }

  const activeChannels = customChannels || await getGlobalNotificationChannels(category);
  console.log(`📣 Dispatching '${category}' notification. Active channels:`, activeChannels);

  const results = {
    category,
    channels: activeChannels,
    email: null,
    whatsapp: null,
    inApp: null,
  };

  // 1. Send Email Notification
  if (activeChannels.includes("EMAIL") && toEmail) {
    try {
      const transporter = nodemailer.createTransport({
        host: process.env.SMTP_HOST,
        port: Number(process.env.SMTP_PORT) || 587,
        secure: false,
        auth: { user: process.env.SMTP_USER, pass: process.env.SMTP_PASS },
      });

      await transporter.sendMail({
        from: process.env.MAIL_FROM || "no-reply@gym.com",
        to: toEmail,
        subject,
        text: message,
      });

      // Log in notificationlog table
      await pool.query(
        `INSERT INTO notificationLog (type, \`to\`, message, memberId, status)
         VALUES (?, ?, ?, ?, ?)`,
        ["EMAIL", toEmail, message, memberId || null, "SENT"]
      );

      results.email = { success: true };
      console.log(`✉️ Email notification sent to ${toEmail}`);
    } catch (err) {
      console.error(`❌ Email notification failed for ${toEmail}:`, err.message);
      results.email = { success: false, error: err.message };
      // Log failure in notificationlog
      try {
        await pool.query(
          `INSERT INTO notificationLog (type, \`to\`, message, memberId, status)
           VALUES (?, ?, ?, ?, ?)`,
          ["EMAIL", toEmail, message, memberId || null, "FAILED"]
        );
      } catch (e) {
        console.error("Failed to log email failure to DB:", e.message);
      }
    }
  }

  // 2. Send WhatsApp Notification
  if (activeChannels.includes("WHATSAPP") && toPhone) {
    try {
      const cleanPhone = toPhone.trim().replace("+", "");
      const isSent = await sendWhatsAppMessage(cleanPhone, message);

      // Log in notificationlog table
      await pool.query(
        `INSERT INTO notificationLog (type, \`to\`, message, memberId, status)
         VALUES (?, ?, ?, ?, ?)`,
        ["WHATSAPP", cleanPhone, message, memberId || null, isSent ? "SENT" : "FAILED"]
      );

      results.whatsapp = { success: isSent };
      console.log(`💬 WhatsApp notification triggered to ${cleanPhone} (Status: ${isSent ? 'Sent' : 'Failed'})`);
    } catch (err) {
      console.error(`❌ WhatsApp notification failed for ${toPhone}:`, err.message);
      results.whatsapp = { success: false, error: err.message };
    }
  }

  // 3. Send In-App / App Push Notification
  if (activeChannels.includes("APP_PUSH") && toUserId) {
    try {
      // Create an IN-APP notification in database (read by the user's notification list)
      await pool.query(
        `INSERT INTO notificationLog (type, \`to\`, message, memberId, status)
         VALUES (?, ?, ?, ?, ?)`,
        ["IN-APP", toUserId.toString(), message, memberId || null, "UNREAD"]
      );
      
      results.inApp = { success: true };
      console.log(`📱 App Push/In-App notification logged for User ID ${toUserId}`);
    } catch (err) {
      console.error(`❌ App Push notification failed for User ID ${toUserId}:`, err.message);
      results.inApp = { success: false, error: err.message };
    }
  }

  return { success: true, results };
};
