import bcrypt from "bcryptjs";
import { pool } from "./src/config/db.js";

async function resetPassword() {
  try {
    const hash = await bcrypt.hash("123456", 10);
    await pool.query("UPDATE user SET password = ? WHERE email = ?", [hash, "generaltrainer1@gym.com"]);
    console.log("Password reset successfully to 123456");
    process.exit(0);
  } catch (err) {
    console.error(err);
    process.exit(1);
  }
}

resetPassword();
