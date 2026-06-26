export const validateAssessmentInputs = (data) => {
  const errors = [];
  const requiredFields = [
    'age_at_assessment', 'gender_at_assessment', 'weight_kg', 'height_cm', 
    'neck_cm', 'waist_cm', 'resting_hr', 'activity_level', 'fitness_goal'
  ];

  requiredFields.forEach(field => {
    if (data[field] === undefined || data[field] === null) {
      errors.push(`Missing required field: ${field}`);
    }
  });

  if (errors.length > 0) return { isValid: false, errors };

  // Gender & Hip validation
  const gender = data.gender_at_assessment.toLowerCase();
  if (gender !== 'male' && gender !== 'female') {
    errors.push("gender_at_assessment must be 'male' or 'female'");
  }
  
  if (gender === 'female' && (data.hip_cm === undefined || data.hip_cm === null)) {
    errors.push("hip_cm is strictly required for female assessments (US Navy Formula requirement)");
  }

  // Boundary validations
  if (data.age_at_assessment < 10 || data.age_at_assessment > 120) errors.push("Age out of reasonable bounds (10-120)");
  if (data.weight_kg < 30 || data.weight_kg > 300) errors.push("Weight out of reasonable bounds (30-300kg)");
  if (data.height_cm < 100 || data.height_cm > 250) errors.push("Height out of reasonable bounds (100-250cm)");
  if (data.resting_hr < 30 || data.resting_hr > 200) errors.push("Resting HR out of reasonable bounds (30-200)");
  if (data.neck_cm < 20 || data.neck_cm > 80) errors.push("Neck circumference out of reasonable bounds");
  if (data.waist_cm < 40 || data.waist_cm > 200) errors.push("Waist circumference out of reasonable bounds");
  
  if (data.hip_cm !== undefined && data.hip_cm !== null) {
    if (data.hip_cm < 50 || data.hip_cm > 200) errors.push("Hip circumference out of reasonable bounds");
  }

  // Enum validations
  const validActivities = ['sedentary', 'light', 'moderate', 'active'];
  if (!validActivities.includes(data.activity_level)) {
    errors.push(`activity_level must be one of: ${validActivities.join(', ')}`);
  }

  const validGoals = ['fat_loss', 'maintenance', 'muscle_gain'];
  if (!validGoals.includes(data.fitness_goal)) {
    errors.push(`fitness_goal must be one of: ${validGoals.join(', ')}`);
  }
  
  // Zero Division Pre-Checks
  if (data.height_cm === 0) errors.push("Height cannot be zero.");

  // Logarithmic bounds check (US Navy Formula constraints)
  if (gender === 'male' && (data.waist_cm - data.neck_cm) <= 0) {
    errors.push("Waist circumference must be greater than neck circumference for male BF% calculations.");
  }
  if (gender === 'female' && (data.waist_cm + data.hip_cm - data.neck_cm) <= 0) {
    errors.push("Waist + Hip circumference must be greater than neck circumference for female BF% calculations.");
  }

  return { isValid: errors.length === 0, errors };
};
