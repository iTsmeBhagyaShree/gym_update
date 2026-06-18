import { Router } from 'express';
import * as assessmentController from './assessment.controller.js';

const router = Router();

// POST /api/v1/assessments
router.post('/', assessmentController.createAssessment);

// GET /api/v1/assessments/member/:id/latest
router.get('/member/:id/latest', assessmentController.getLatestAssessment);

// GET /api/v1/assessments/member/:id/history
router.get('/member/:id/history', assessmentController.getAssessmentHistory);

export default router;
