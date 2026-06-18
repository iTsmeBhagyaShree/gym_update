import { 
  sendNotificationService, 
  getUserNotificationsService, 
  markAsReadService,
  broadcastAnnouncementService,
  getBroadcastHistoryService
} from "./notif.service.js";

export const sendNotification = async (req, res, next) => {
  try {
    const log = await sendNotificationService(req.body);
    res.json({ success: true, log });
  } catch (err) {
    next(err);
  }
};

export const getUserNotifications = async (req, res, next) => {
  try {
    const { userId } = req.params;
    const notifications = await getUserNotificationsService(userId);
    res.json({ success: true, notifications });
  } catch (err) {
    next(err);
  }
};

export const markAsRead = async (req, res, next) => {
  try {
    const { id } = req.params;
    await markAsReadService(id);
    res.json({ success: true, message: "Notification marked as read" });
  } catch (err) {
    next(err);
  }
};

export const broadcastAnnouncement = async (req, res, next) => {
  try {
    const { subject, message, channels, targetRoles } = req.body;
    
    if (!subject || !message || !channels || !Array.isArray(channels)) {
      return res.status(400).json({
        success: false,
        message: "subject, message, and channels (array) are required",
      });
    }

    const result = await broadcastAnnouncementService({
      subject,
      message,
      channels,
      targetRoles: targetRoles || [2], // Default to Admin/Owner
      sentBy: req.user?.id || null
    });

    res.json({
      success: true,
      message: "Announcement broadcasted successfully",
      result
    });
  } catch (err) {
    next(err);
  }
};

export const getBroadcastHistory = async (req, res, next) => {
  try {
    const history = await getBroadcastHistoryService();
    res.json({ success: true, history });
  } catch (err) {
    next(err);
  }
};
