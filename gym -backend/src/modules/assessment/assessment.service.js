import { PrismaClient } from '@prisma/client';
import { AssessmentEngine } from './assessment.engine.js';
import { validateAssessmentInputs } from './assessment.validator.js';
import { LeaderboardEngine } from '../leaderboard/leaderboard.engine.js';

const prisma = new PrismaClient();
const engine = new AssessmentEngine();

export const createAssessment = async (data, createdBy) => {
  // Validate Inputs
  const validation = validateAssessmentInputs(data);
  if (!validation.isValid) {
    const error = new Error('Validation Failed');
    error.status = 400;
    error.details = validation.errors;
    throw error;
  }

  // Check if member exists
  const member = await prisma.member.findUnique({ where: { id: data.memberId } });
  if (!member) {
    const error = new Error('Member not found');
    error.status = 404;
    throw error;
  }

  // Calculate Metrics
  const calculated = engine.calculateAll(data);
  
  // Leaderboard Calculation
  const baselineAssessment = await prisma.member_assessments.findFirst({
    where: { memberId: data.memberId, is_baseline: true }
  });

  const demographic_multiplier = LeaderboardEngine.getDemographicMultiplier(data.age_at_assessment, data.gender_at_assessment);
  
  const is_baseline = !baselineAssessment;
  const baseline_bf = baselineAssessment ? Number(baselineAssessment.body_fat_percentage) : calculated.metrics.body_fat_percentage;
  const baseline_lbm = baselineAssessment ? Number(baselineAssessment.lean_body_mass) : calculated.metrics.lean_body_mass;

  const final_leaderboard_score = LeaderboardEngine.calculateScore({
    fitness_goal: data.fitness_goal,
    baseline_bf: baseline_bf,
    current_bf: calculated.metrics.body_fat_percentage,
    baseline_lbm: baseline_lbm,
    current_lbm: calculated.metrics.lean_body_mass,
    demographic_multiplier: demographic_multiplier
  });

  // Map to DB
  const newAssessment = await prisma.member_assessments.create({
    data: {
      memberId: data.memberId,
      createdBy: createdBy || 1,
      engine_version: engine.config.ENGINE_VERSION,
      config_snapshot: engine.config,
      
      // Inputs
      age_at_assessment: data.age_at_assessment,
      gender_at_assessment: data.gender_at_assessment,
      weight_kg: data.weight_kg,
      height_cm: data.height_cm,
      neck_cm: data.neck_cm,
      waist_cm: data.waist_cm,
      hip_cm: data.hip_cm,
      resting_hr: data.resting_hr,
      activity_level: data.activity_level,
      fitness_goal: data.fitness_goal,
      
      // Output Metrics
      bmi: calculated.metrics.bmi,
      body_fat_percentage: calculated.metrics.body_fat_percentage,
      lean_body_mass: calculated.metrics.lean_body_mass,
      ideal_body_weight: calculated.metrics.ideal_body_weight,
      waist_to_hip_ratio: calculated.metrics.waist_to_hip_ratio,
      bmr: calculated.metrics.bmr,
      tdee: calculated.metrics.tdee,
      target_calories: calculated.metrics.target_calories,
      
      // Macros
      protein_grams: calculated.macros.protein_grams,
      fat_grams: calculated.macros.fat_grams,
      carb_grams: calculated.macros.carb_grams,
      
      // Leaderboard Data
      is_baseline: is_baseline,
      baseline_bf_percent: baseline_bf,
      baseline_lbm: baseline_lbm,
      demographic_multiplier: demographic_multiplier,
      final_leaderboard_score: final_leaderboard_score,

      // Dashboard metadata
      metrics_output: calculated.dashboard_data
    }
  });

  return formatAssessmentDTO(newAssessment);
};

export const getLatestAssessment = async (memberId) => {
  const assessment = await prisma.member_assessments.findFirst({
    where: { memberId: parseInt(memberId) },
    orderBy: { assessment_date: 'desc' }
  });

  if (!assessment) {
    const error = new Error('No assessments found for this member');
    error.status = 404;
    throw error;
  }

  return formatAssessmentDTO(assessment);
};

export const getAssessmentHistory = async (memberId) => {
  const assessments = await prisma.member_assessments.findMany({
    where: { memberId: parseInt(memberId) },
    orderBy: { assessment_date: 'asc' }
  });

  return assessments.map(formatAssessmentDTO);
};

const formatAssessmentDTO = (assessment) => {
  return {
    id: assessment.id,
    memberId: assessment.memberId,
    assessment_date: assessment.assessment_date,
    engine_version: assessment.engine_version,
    inputs: {
      age_at_assessment: assessment.age_at_assessment,
      gender_at_assessment: assessment.gender_at_assessment,
      weight_kg: Number(assessment.weight_kg),
      height_cm: Number(assessment.height_cm),
      neck_cm: Number(assessment.neck_cm),
      waist_cm: Number(assessment.waist_cm),
      hip_cm: assessment.hip_cm ? Number(assessment.hip_cm) : null,
      resting_hr: assessment.resting_hr,
      activity_level: assessment.activity_level,
      fitness_goal: assessment.fitness_goal
    },
    metrics: {
      bmi: Number(assessment.bmi),
      body_fat_percentage: Number(assessment.body_fat_percentage),
      lean_body_mass: Number(assessment.lean_body_mass),
      ideal_body_weight: Number(assessment.ideal_body_weight),
      waist_to_hip_ratio: assessment.waist_to_hip_ratio ? Number(assessment.waist_to_hip_ratio) : null,
      bmr: Number(assessment.bmr),
      tdee: Number(assessment.tdee),
      target_calories: assessment.target_calories
    },
    macros: {
      protein_grams: assessment.protein_grams,
      fat_grams: assessment.fat_grams,
      carb_grams: assessment.carb_grams
    },
    dashboard_data: assessment.metrics_output,
    audit: {
      createdBy: assessment.createdBy,
      createdAt: assessment.createdAt
    }
  };
};
