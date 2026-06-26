import { Router } from "express";
import { verifyToken } from "../../middlewares/auth.js";
import {
  getAutomationSettings,
  updateAutomationSettings,
  getMessageTemplates,
  updateMessageTemplate
} from "./automation.controller.js";

const router = Router();

// Only Superadmin can manage automation settings and templates
router.get("/settings", verifyToken(["Superadmin"]), getAutomationSettings);
router.put("/settings", verifyToken(["Superadmin"]), updateAutomationSettings);

router.get("/templates", verifyToken(["Superadmin"]), getMessageTemplates);
router.put("/templates/:id", verifyToken(["Superadmin"]), updateMessageTemplate);

export default router;
