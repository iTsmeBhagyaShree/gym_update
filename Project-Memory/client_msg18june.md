LEADERBOARD ARCHITECTURE SPECIFICATION
Normalized Demographic Scoring & Multiplier Framework
1. CORE ARCHITECTURE OVERVIEW
The system segregates standings dynamically based on the member's designated fitness_goal. Members
operate exclusively within their chosen tracks to maintain situational relevance. To ensure fairness across diverse
body styles, age cohorts, and biological sexes, the engine overlays raw algorithmic tracking values with a
scientifically verified demographic multiplier curve.
Key Structural Parameters:
Partitioning: Independent dashboard pipelines run for Fat Loss, Muscle Gain, and Maintenance.
Sorting Logic: High-to-low positioning based entirely on the final_leaderboard_score.
Multi-tier Limits: Fat Loss and Muscle Gain normalization targets feature a maximum scaling cap of 2.00. The
Maintenance pipeline maintains a rigid operational ceiling of exactly 100.
2. MASTER DEMOGRAPHIC MULTIPLIER MATRIX
The system engine queries the database birthdate and gender records to automatically isolate the correct multiplier
from the matrix below before pushing calculation objects into ranking arrays.
•
•
•
GymCatalyst Engine V2 • System Architecture Specification Page 1 of 4
Age
Bracket
Male
Multiplier
Female
Multiplier
Physiological Grounding & System Buffers
Under 18 0.95 1.06 Adolescent growth-surge metabolic correction handicap.
18 – 29 1.00 (Base) 1.12
Standard population control baseline. Accounts for female
essential lipid bounds.
30 – 35 1.04 1.16
BMR deceleration inflection phase (Calculated ~1.3% linear
decay).
36 – 40 1.09 1.22 Sarcopenia protection boundary factor.
41 – 45 1.15 1.29 Endocrine drift correction and structural fat retention offset.
46 – 50 1.22 1.37 Advanced metabolic slowdown progression parameter.
51 – 55 1.30 1.46 Proteolytic synthesis drop mitigation index.
56 – 60 1.39 1.56 Musculoskeletal tissue resistance preservation scaling.
61+ 1.50 1.68
Maximum compensation setting for advanced age homeostasis
variance.
3. FINALIZED LEADERBOARD NORMALIZED FORMULAS
Track 1: Fat Loss Leaderboard (fitness_goal = 'fat_loss')
Measures demographic-weighted percentage improvements across Body Fat Percentage (BF%) intervals.
Raw Fat Loss Score = ((Baseline BF% − Current BF%) ÷ Baseline BF%) × 100
Final Leaderboard Score = Raw Fat Loss Score × Multiplier
EXECUTION EXAMPLE
Member Profile: Female, 38 years old (Multiplier = 1.22)
Assessments: Baseline BF% = 35% | Current BF% = 28%
Raw Output: ((35 - 28) ÷ 35) × 100 = 20.00
Final Calculated Score: 20.00 × 1.22 = 24.40 Points
Track 2: Muscle Gain Leaderboard (fitness_goal = 'muscle_gain')
Tracks relative progression loops focusing entirely on absolute Lean Body Mass (LBM) increments.
GymCatalyst Engine V2 • System Architecture Specification Page 2 of 4
Raw Muscle Gain Score = ((Current LBM − Baseline LBM) ÷ Baseline LBM) × 100
Final Leaderboard Score = Raw Muscle Gain Score × Multiplier
EXECUTION EXAMPLE
Member Profile: Male, 52 years old (Multiplier = 1.30)
Assessments: Baseline LBM = 60 kg | Current LBM = 66 kg
Raw Output: ((66 - 60) ÷ 60) × 100 = 10.00
Final Calculated Score: 10.00 × 1.30 = 13.00 Points
Track 3: Maintenance Leaderboard (fitness_goal = 'maintenance')
Scores homeostatic retention. To maintain a strict system ceiling of 100, the demographic multiplier inversely
impacts the cumulative metric variance (the deviation penalty) rather than inflating the final output points directly.
Raw Variance (Penalty) = ABS(Current BF% − Baseline BF%) + ABS(Current LBM −
Baseline LBM)
Final Leaderboard Score = 100 − (Raw Variance × (2 − Multiplier))
EXECUTION EXAMPLE
Member Profile: Female, 48 years old (Multiplier = 1.37 → Penalty Buffer = 0.63)
Assessments: Baseline BF% = 18%, Current BF% = 19% | Baseline LBM = 65kg, Current LBM = 64kg
Raw Variance Calculation: ABS(19 - 18) + ABS(64 - 65) = 1 + 1 = 2.00
Final Calculated Score: 100 - (2.00 × 0.63) = 100 - 1.26 = 98.74 Points
4. DATABASE SCHEMA UPGRADES
To support execution loops within data warehouses, map these precise parameters to your structural backend
objects:
baseline_bf_percent (DECIMAL) / current_bf_percent (DECIMAL)
baseline_lbm (DECIMAL) / current_lbm (DECIMAL)
member_age (INTEGER) / member_sex (VARCHAR)
demographic_multiplier (DECIMAL) - Evaluated via lookup rules.
final_leaderboard_score (DECIMAL) - Core indexed execution column for ranking loops.
•
•
•
•
•
GymCatalyst Engine V2 • System Architecture Specification Page 3 of 4
5. BACKEND ENGINE SCRIPT IMPLEMENTATION
/**
 * GymCatalyst Engine Pipeline - Normalization Scoring
 */
function processMemberLeaderboardScore(member) {
 let rawScore = 0;
 let finalScore = 0;
 if (member.fitness_goal === 'fat_loss') {
 rawScore = ((member.baseline_bf - member.current_bf) / member.baseline_bf) * 100;
 finalScore = rawScore * member.demographic_multiplier;
 } else if (member.fitness_goal === 'muscle_gain') {
 rawScore = ((member.current_lbm - member.baseline_lbm) / member.baseline_lbm) * 100;
 finalScore = rawScore * member.demographic_multiplier;
 } else if (member.fitness_goal === 'maintenance') {
 let bfVariance = Math.abs(member.current_bf - member.baseline_bf);
 let lbmVariance = Math.abs(member.current_lbm - member.baseline_lbm);
 let totalVariance = bfVariance + lbmVariance;
 // Apply inverse multiplier buffer to protect scores against metabolic biological drift
 let bufferFactor = 2.0 - member.demographic_multiplier;
 finalScore = 100.0 - (totalVariance * bufferFactor);
 }
 // Bind to object storage rounded cleanly for database efficiency
 return parseFloat(finalScore.toFixed(2));
}
GymCatalyst Engine V2 • System Architecture Specification Page 4 of 4

Gym ERP Blueprint
BACKEND ENGINE & TECHNICAL SPECIFICATIONS: PHYSICAL ASSESSMENT &
NUTRITION MODULE
This technical document provides a production-ready system specification for implementing a comprehensive
Physical Assessment and Nutrition Module within a Gym ERP from scratch. It defines the structural
dependencies, precise algorithmic logic using standard gym metrics (no laboratory tests required), database
schema definitions, and visual dashboard layouts.
1. Architectural System Flow & Dependencies
To avoid mathematical reference errors, calculations must execute in a strict sequential pipeline. Several metrics
depend entirely on the outputs calculated in preceding stages:
Onboarding Inputs: System collects basic demographic data (Age, Gender) and primary physiological
baselines (Weight, Height, Resting Heart Rate).
Base Metrics Matrix: The system computes standalone benchmarks: Body Mass Index (BMI), Basal
Metabolic Rate (BMR), and Ideal Body Weight (IBW).
Circumference Processing: Utilizing tape measurements, the engine computes the Waist-to-Hip Ratio
(WHR) and derives the Body Fat Percentage (BF%) via non-invasive regression formulas.
Body Composition Extraction: Lean Body Mass (LBM) is calculated directly by combining the total Body
Weight and the calculated Body Fat Percentage.
Energy Expenditure Matrix: Total Daily Energy Expenditure (TDEE) and target daily caloric boundaries
are established based on the member's lifestyle multipliers and fitness targets.
Nutritional Allocation & Target Cardiovascular Zones: The macro split (Protein, Fats, Carbs in grams) is
dynamically configured, and target heart rate brackets are derived.
2. Database Schema Specification
Your development team must establish a relational database table (e.g., member_assessments ) capable of
collecting and storing the following structured attributes for every progress log entry:
1.
2.
3.
4.
5.
6.
Gym ERP Blueprint • Confidential Page 1 of 6
Field Name Data Type Validation / Constraints UI / Physical Source Context
member_id Foreign Key Must resolve to primary keys of
main member table.
Automated session state context.
assessment_date Date Default: Current Timestamp. System generated entry record date.
gender Enum ['male', 'female'] Retrieved from standard member
metadata.
age Integer Minimum: 10 | Maximum: 100
(years)
Calculated dynamically or profile input.
weight_kg Decimal (5,2) Minimum: 30.00 | Maximum:
250.00
Standard medical weight scale reading.
height_cm Decimal (5,2) Minimum: 100.00 | Maximum:
250.00
Stadiometer or height-rod reading.
neck_cm Decimal (4,1) Minimum: 20.0 | Maximum: 60.0 Anthropometric tape line (just under
larynx).
waist_cm Decimal (4,1) Minimum: 40.0 | Maximum: 180.0 Anthropometric tape line (horizontal at
navel level).
hip_cm Decimal (4,1) Nullable for Men; Required for
Women.
Anthropometric tape line (widest gluteal
span).
resting_hr Integer Minimum: 40 | Maximum: 120
(BPM)
Manual pulse count or pulse oximeter
device.
activity_level Enum ['sedentary', 'light',
'moderate', 'active']
Dropdown option representing weekly
baseline activity.
fitness_goal Enum ['fat_loss',
'maintenance',
'muscle_gain']
Dropdown option dictating energy delta
application.
3. Algorithmic Processing Engine Equations
The backend logic processing service must run the data attributes through the following deterministic pipelines
sequentially, mapping internal variable names appropriately:
Metric 1: Body Mass Index (BMI)
BMI = weight_kg / (height_cm / 100)²
System Risk Classification Status Flags:
BMI < 18.5 → Flag Status: "Underweight" (Triggers safety warnings for hypertrophy priority)
BMI ≥ 18.5 AND BMI < 25.0 → Flag Status: "Normal"
BMI ≥ 25.0 AND BMI < 30.0 → Flag Status: "Overweight"
BMI ≥ 30.0 → Flag Status: "Obese" (Triggers high joint-impact training alerts)
•
•
•
•
Gym ERP Blueprint • Confidential Page 2 of 6
Metric 2: Basal Metabolic Rate (BMR) - Mifflin-St Jeor Engine
Evaluate conditionally based on gender attribute:
If gender == 'male': BMR = (10 × weight_kg) + (6.25 × height_cm) - (5 × age) + 5
If gender == 'female': BMR = (10 × weight_kg) + (6.25 × height_cm) - (5 × age) - 161
Significance: Establishes the metabolic floor. Absolute minimum caloric energy required to sustain life at total rest. Critical for
system boundary controls to ensure active nutrition plans never fall below this value.
Metric 3: Total Daily Energy Expenditure (TDEE)
Map activity_level variable to hardcoded numeric scale multipliers:
'sedentary' → 1.200 | 'light' → 1.375 | 'moderate' → 1.550 | 'active' → 1.725
TDEE = BMR × Multiplier
Significance: Establishes equilibrium energy balance (Maintenance calories). Eating exactly this number maintains current
weight.
Metric 4: Target Calorie Budgeting
Evaluate variable fitness_goal against the calculated TDEE baseline to inject adjustments:
If fitness_goal == 'fat_loss': Target Calories = TDEE - 500
If fitness_goal == 'maintenance': Target Calories = TDEE
If fitness_goal == 'muscle_gain': Target Calories = TDEE + 350
Metric 5: Body Fat Percentage (BF%) - US Navy Circumference Methodology
Compute using base-10 logarithmic scaling functions ( log10 ) on tape parameters:
If gender == 'male': BF% = 86.010 × log10(waist_cm - neck_cm) - 70.041 × log10(height_cm) + 36.76
If gender == 'female': BF% = 163.205 × log10(waist_cm + hip_cm - neck_cm) - 97.684 × log10(height_cm)
- 78.387
Significance: Differentiates fat tissue from lean skeletal mass. Eliminates inaccuracies caused by standard weight metrics in
highly muscular or detrained individuals.
Metric 6: Lean Body Mass (LBM)
LBM = weight_kg × (1 - (BF% / 100))
Significance: Determines total non-adipose weight (muscles, skeletal system, organs). Acts as the foundational variable dictating
systemic protein breakdown metrics.
Gym ERP Blueprint • Confidential Page 3 of 6
Metric 7: Macronutrient Allocation Split Engine
Process sequentially based on total Target Calories and structural calculated LBM parameters:
1. Protein Split: Allocate 2.2 grams per kilogram of LBM.
Protein_Grams = LBM × 2.2
Protein_Calories = Protein_Grams × 4
2. Lipids/Fat Split: Allocate exactly 25% of the total Target Calories daily allocation.
Fat_Calories = Target Calories × 0.25
Fat_Grams = Fat_Calories / 9
3. Carbohydrates Split: Allocate the remaining mathematical balances to energy inputs.
Carb_Calories = Target Calories - (Protein_Calories + Fat_Calories)
Carb_Grams = Carb_Calories / 4
Metric 8: Ideal Body Weight (IBW) - Devine Clinical Standard
Inches_Over_60 = ((height_cm / 2.54) - 60)
If gender == 'male': IBW = 50.0 + (2.3 × Inches_Over_60)
If gender == 'female': IBW = 45.5 + (2.3 × Inches_Over_60)
Significance: Establishes an objective healthy weight baseline normalized against structural skeletal scale lengths. Grounding
point for expectations during goal setting.
Metric 9: Waist-to-Hip Ratio (WHR)
If gender == 'male' AND hip_cm == Null: WHR = Null
Else: WHR = waist_cm / hip_cm
Significance: Direct diagnostic metric flag for visceral fat clustering. Values > 0.90 for men or > 0.85 for women indicate appleshaped fat distribution and elevated cardiovascular health risks.
Metric 10: Target Heart Rate Training Zones (Karvonen Method)
Max_HR = 220 - age
HR_Reserve (HRR) = Max_HR - resting_hr
Target Aerobic Intensity Brackets:
Fat Burn Bounds Low (60% exertion): (HRR × 0.60) + resting_hr
Fat Burn Bounds High (70% exertion): (HRR × 0.70) + resting_hr
Cardio Endurance Range (70%-80% exertion): From Fat Burn High Target to ((HRR × 0.80) + resting_hr)
Developer Technical Note: Ensure proper input parameter constraints exist within the codebase to prevent divisions by
zero or negative logarithmic parameters. In instances where male data inputs exclude hip_cm, handle the WHR variable
gracefully by outputting Null or N/A on the user interface screens rather than fracturing calculation execution blocks.
•
•
•
Gym ERP Blueprint • Confidential Page 4 of 6
4. UI/UX Dashboard Layout & Wireframe Component Maps
Instruct your frontend engineers to divide the compiled data calculations across 4 clean visual interface cards on
the member evaluation viewport:
COMPONENT A: VITAL STRUCTURAL COMPOSITION BLOCK
Provides an immediate overview of body structure indicators. Muscle-to-fat changes must take visual priority
over pure weight changes.
Primary Large Numeric Displays: Total Scale Weight ( weight_kg ), calculated Body Fat percentage
( BF% ), and total structural Lean Body Mass ( LBM ).
Context Label Indicators: Display calculated BMI values accompanied by color-coded indicator badges
representing risk levels (Green: Normal, Amber: Overweight, Red: Obese) alongside WHR results.
COMPONENT B: ENERGY THRESHOLD ANALYTICS ENGINE
Highlights systemic energy baselines, defining the member's daily metabolic boundary limits clearly.
Primary Base Value: Display BMR as the absolute structural minimum daily caloric floor line.
Actionable Threshold Data: Display TDEE explicitly labeled as "Maintenance Calories (Equilibrium
Balance)", and frame the calculated Target Calories as a primary metric highlighted as the "Active
Daily Energy Budget Allocation".
COMPONENT C: MACRONUTRIENT MACRO BLUEPRINT PANEL
Converts target energy allocations into real-world daily nutritional goals for the client.
Visual Component Display: Use a segmented progress bar or structural chart representing total daily
energy allocation percentages.
Data Point Fields:
• Protein: Grams calculated displayed clearly, captioned with: "Target allocation for skeletal muscle
structure preservation/growth."
• Carbohydrates: Grams calculated, captioned with: "Daily baseline glycolytic performance energy."
• Fats: Grams calculated, captioned with: "Essential lipid intake block supporting foundational hormonal
health and joint longevity."
•
•
•
•
•
•
Gym ERP Blueprint • Confidential Page 5 of 6
COMPONENT D: PROGRAMMATIC CARDIOVASCULAR TARGET GUIDANCE CARD
Translates heart rate formulas into clear parameters that can be easily applied to standard gym equipment
interfaces (treadmills, spin bikes, ellipticals).
Automated Advisory Text Field: Generate structured guidance copy block layout matching:
"Maintain working heart rate activity outputs bounded between [Fat Burn Low] BPM and [Fat Burn High]
BPM during continuous metabolic conditioning routines to maximize fat oxidation efficiently. Transition into
the aerobic training bracket of [Fat Burn High] to [Cardio High] BPM to increase cardiovascular stamina
and threshold performance parameters."
•
Gym ERP Blueprint • Confidential Page 6 of 6