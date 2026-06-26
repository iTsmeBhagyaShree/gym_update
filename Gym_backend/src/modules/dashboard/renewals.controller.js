import { pool } from "../../config/db.js";

export const getSuperAdminRenewals = async (req, res, next) => {
  try {
    const today = new Date();
    today.setHours(0, 0, 0, 0);

    const nextWeek = new Date(today);
    nextWeek.setDate(today.getDate() + 7);

    // Format dates for MySQL
    const todayStr = today.toISOString().slice(0, 19).replace('T', ' ');
    const nextWeekStr = nextWeek.toISOString().slice(0, 19).replace('T', ' ');

    // 1️⃣ Upcoming Renewals (license expiring in next 7 days)
    // roleId = 2 represents Gym Owners/Admins
    const [upcoming] = await pool.query(
      `SELECT 
        id, fullName, email, phone, gymName, subscriptionPlan, licenseExpiryDate, isTrial 
       FROM user 
       WHERE roleId = 2 
         AND licenseExpiryDate >= ? 
         AND licenseExpiryDate <= ?
       ORDER BY licenseExpiryDate ASC`,
      [todayStr, nextWeekStr]
    );

    // 2️⃣ Inactive / Expired Renewals (license expired)
    const [expired] = await pool.query(
      `SELECT 
        id, fullName, email, phone, gymName, subscriptionPlan, licenseExpiryDate, isTrial 
       FROM user 
       WHERE roleId = 2 
         AND licenseExpiryDate < ?
       ORDER BY licenseExpiryDate DESC`,
      [todayStr]
    );

    res.json({
      success: true,
      data: {
        upcomingRenewals: upcoming,
        expiredRenewals: expired
      }
    });
  } catch (err) {
    next(err);
  }
};
