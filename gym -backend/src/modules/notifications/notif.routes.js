import { Router } from "express";
import { verifyToken } from "../../middlewares/auth.js";
import { 
  sendNotification, 
  getUserNotifications, 
  markAsRead,
  broadcastAnnouncement,
  getBroadcastHistory
} from "./notif.controller.js";

const router = Router();

router.post(
  "/send",
  verifyToken(["Admin", "Superadmin", "Staff"]),
  sendNotification
);

router.get(
  "/user/:userId",
  getUserNotifications
);

router.put(
  "/read/:id",
  markAsRead
);

// --- Broadcast Routes for Super Admin ---
router.post(
  "/broadcast",
  verifyToken(["Superadmin"]),
  broadcastAnnouncement
);

router.get(
  "/broadcast/history",
  verifyToken(["Superadmin", "Subadmin"]),
  getBroadcastHistory
);

export default router;
