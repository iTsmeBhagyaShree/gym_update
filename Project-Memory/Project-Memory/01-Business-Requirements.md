# 01 — Business Requirements
**Project:** SaaS Gym Management System  
**Client:** Mr. Raj Shekhar  
**Company:** Kiaan Technology  
**Last Updated:** 2026-06-08

---

## Project Overview
A fully customized SaaS-based Gym Management Platform that allows gym owners to manage members, staff, leads, attendance, fitness tracking, and communication from a single centralized system. Multi-branch, multi-gym, scalable architecture.

---

## Modules Required (Client Requirement)

### 1. User & Access Management ✅ DONE
- Email-based registration and login system
- Role-based access control (8 roles: Superadmin, Admin/Owner, trainer, member, personaltrainer, generaltrainer, receptionist, housekeeping)
- Admin and Super Admin dashboard access

### 2. Fitness & Health Tracking ⚠️ PARTIAL
- BMI calculation system (Underweight / Normal / Overweight / Obese)
- 15-day health monitoring system
- Automated notification for progress tracking
- Personal food chart (diet plan) per member
- Trainer reminder for diet plan update

### 3. WhatsApp Communication System ❌ PENDING
- Integrated WhatsApp messaging (Meta/Twilio API)
- **Basic Plan:** Reports and informational messages only (no WhatsApp)
- **Standard Plan:** WhatsApp messaging enabled
- **Premium Plan:** Auto reminders, payment notifications, marketing messages (extra charges)

### 4. CRM & Lead Management ⚠️ PARTIAL
- Complete CRM dashboard for Super Admin (Master CRM — PENDING)
- Lead tracking and management system ✅
- Lead assignment to trainers and sales staff ✅
- Performance and conversion tracking ❌ PENDING

### 5. Attendance & Tracking ⚠️ PARTIAL
- Member attendance system ✅
- QR Code based check-in ✅
- Anti-screenshot / Nonce security ✅
- GPS Location-based tracking ✅ (Done 2026-06-05)
- Device ID lock ✅ (Done 2026-06-05)

### 6. Food Chart System ⚠️ PARTIAL
- Dynamic Diet Builder for Trainers ✅ (Done)
- Member view of assigned diet plan ✅
- Update tracking ✅
- Reminder system ❌ PENDING (15-day cron)

### 7. Landing Page (Editable) ❌ PENDING
- Fully editable landing page
- Admin-controlled content management (banners, text, plans)
- Easy updates for gym owners

### 8. Email Data Backup System ❌ PENDING
- Automated email backup (all gym data)
- Secure recovery system

### 9. Mobile Applications ❌ PENDING
- Android App (WebView-based)
- iOS App (WebView-based)
- Deploy on Google Play Store & Apple App Store

### 10. Hosting & Licensing
- Hosting: Railway.app (initial), scalable to AWS/GCP
- Full software license to gym owner
- Multi-branch SaaS ready architecture

### 11. Support & Training
- Complete video-based training for system usage
- 2 years technical support (bug fixing)
- 5% minor changes policy during development

---

## New Requirements (Added 2026-06-08 from Meeting Script)

### A. Demo Request Alerts
- On the landing page, a "Request Demo" form allows users to submit their email/phone.
- Triggers an email to the Super Admin.
- Triggers automatic WhatsApp alerts to both the Super Admin and the client who requested the demo.

### B. Subscription Online Purchase & Auto-Activation
- Gym owners can purchase a plan (Basic/Standard/Premium) on the website.
- Successful payment automatically activates and registers the Gym Owner's account without requiring manual Super Admin approval.
- Auto-reminders are sent out 7 days and 3 days before the subscription expires.

### C. Excel Data Migration
- Allow Gym Owners to migrate/import their existing database of members directly using Excel/CSV spreadsheets.

### D. Clash-Free Lead Allocation
- Super Admin can distribute total CRM leads to different Sales agents.
- Sales agents have restricted sidebar access (showing only CRM/Leads, hiding billing, settings, etc.).
- Sales agents can only see and call leads assigned to them to prevent conflict.

### E. Custom Goal Field
- Member registration includes a "Goal" field with choices: Weight Loss, Weight Gain, Body Building, and a custom text field for manual entry.

---

## User Journeys

### Member Journey
1. Member registers via email → Gets member role
2. Logs into Member Dashboard
3. Views membership plan, diet chart, BMI log
4. Scans Admin's QR Code for attendance (GPS verified)
5. Gets WhatsApp notifications for fees, diet updates

### Receptionist / Sales Staff Journey
1. Logs into Sales/Receptionist Dashboard (restricted access to CRM)
2. Adds walk-in inquiry as a Lead, or views assigned leads
3. Follows up with leads → Converts lead to Member
4. Marks attendance manually if needed

### Admin (Gym Owner) Journey
1. Logs into Admin Dashboard
2. Manages staff, members, branches
3. Creates Global QR Code for gym
4. Views reports (attendance, revenue, leads)
5. Sets GPS location for branch (attendance security)
6. Controls landing page details (text, plans, banner)

### Super Admin Journey
1. Logs into Super Admin Dashboard
2. Creates/manages Gym Owners (Admins)
3. Sets plans & pricing for SaaS subscriptions
4. Views ALL gyms' leads, members, payments
5. Controls the entire SaaS platform

---

## Complete Feature Requirements (Updated: 2026-06-13)

This section compiles the audited 38 features required for the complete Gym ERP SaaS solution, including inputs from Mr. Raj Shekhar and the physical assessment specifications.

### Core ERP & SaaS Platform Features

#### 1. User Registration / Signup System
- **Feature:** Allows Gym Owners, Receptionists, Trainers, and other staff to register themselves and create their user profiles.
- **Third Party API:** ❌ No

#### 2. Role-Based Access Control (RBAC)
- **Feature:** Gym Owner can customize permissions for staff roles (Receptionist, Trainer, General Trainer, Personal Trainer, Housekeeping) to control who can add/edit members, view payments, access reports, or assign workouts/diets.
- **Third Party API:** ❌ No

#### 3. Super Admin Panel
- **Feature:** Super Admin manages all registered gyms, gym owners, SaaS subscriptions, platform payments, global CRM leads, system-wide announcements, and feature toggles.
- **Third Party API:** ❌ No

#### 4. Gym Owner Registration Management
- **Feature:** Automatically sends Welcome Notification, subscription plan details, invoices, payment reminders, and Super Admin announcements to Gym Owners.
- **Third Party API:** ✅ SMTP API (Email), ✅ WhatsApp Business API, ✅ Firebase Notification API

#### 5. Super Admin Announcement Module
- **Feature:** Super Admin can broadcast offers, updates, notices, and announcements to all registered gyms and users.
- **Channels:** Email, WhatsApp, App push notification.
- **Third Party API:** ✅ SMTP, ✅ WhatsApp API, ✅ Firebase FCM

#### 6. Gym Leads Management (CRM)
- **Feature:** 
  - **Super Admin/Owner:** Add leads, assign leads, filter and search lead dashboard. Block duplicate lead entry using mobile number check.
  - **Sales Person:** Access restricted to CRM leads page only; can only view and edit leads explicitly assigned to them.
- **Third Party API:** ❌ No

#### 7. Bulk Marketing Campaign System
- **Feature:** Launch mass marketing campaigns to leads (offers, discounts, trials, events, packages) with support for message templates, scheduling, and delivery status tracking.
- **Third Party API:** ✅ WhatsApp Business API, ✅ SMTP Email API

#### 8. Notification Management System
- **Feature:** Central system supporting App, Web, Email, and WhatsApp notifications. Super Admin settings control which channels are enabled for each type of notification.
- **Third Party API:** ✅ Firebase FCM, ✅ SMTP, ✅ WhatsApp API

#### 9. WhatsApp Message Credit System
- **Feature:** Gym Owners buy WhatsApp message credits. Track total, used, and remaining credits. Low credit alerts, and automatic disabling of WhatsApp notifications when credits hit zero.
- **Third Party API:** ✅ WhatsApp Business API, ✅ Razorpay/Cashfree/Stripe (Payment gateway)

#### 10. Subscription Plan Management
- **Feature:** 
  - **Basic Plan:** ERP core features (App/Web notifications only).
  - **Growth Plan:** Adds Email, WhatsApp, and Credits.
  - **Premium Plan:** Adds Custom Branding and License.
  - **Super Admin:** Enable/disable specific features per plan.
- **Third Party API:** ✅ Razorpay / Cashfree / Stripe

#### 11. Free Trial System
- **Feature:** Set trial duration, trigger automatic trials upon signup, send trial expiry warnings and grace period alerts, deactivate account on trial expiry, and auto-activate upon plan purchase.
- **Third Party API:** ✅ WhatsApp API, ✅ SMTP Email

#### 12. Payment Gateway Integration
- **Feature:** Process subscription payments, generate invoices, track payment transaction histories, and execute payment verification.
- **Third Party API:** ✅ Razorpay / Cashfree / Stripe

#### 13. Multi-Branch & Gym Management
- **Feature:** Gym Owners can manage multiple branches, switch branches in the dashboard header, and view separate reports, members, and staff per branch.
- **Third Party API:** ❌ No

#### 14. Member Registration System
- **Feature:** Add member profiles (Name, Phone, Age, Gender, Goal, Assigned Trainer).
- **Goals:** Fat Loss, Muscle Gain, Maintenance, Professional Bodybuilding.
- **Third Party API:** ❌ No

#### 15. Trainer Assignment System
- **Feature:** Assign Personal Trainer (PT), General Trainer (GT), or Group Trainer to a member.
- **Third Party API:** ❌ No

---

### Physical Assessment & Nutrition Module (Formula-Based)

#### 16. Body Assessment Module (Inputs & Core Calculations)
- **Feature:** Capture inputs: Weight, Height, Age, Gender, Neck circumference, Waist circumference, Hip circumference (mandatory for females, optional for males), and Resting Heart Rate.
- **Calculations:** System processes inputs sequentially through the algorithmic engine.
- **Third Party API:** ❌ No

#### 17. BMI Calculation Engine
- **Feature:** Calculate BMI: `weight_kg / (height_cm / 100)^2` and classify status (Underweight, Normal, Overweight, Obese).
- **Third Party API:** ❌ No

#### 18. BMR Calculation (Mifflin-St Jeor)
- **Feature:** Calculate minimum daily calories based on gender-specific calculations to establish the metabolic floor.
- **Third Party API:** ❌ No

#### 19. TDEE Calculation
- **Feature:** Multiply BMR by activity multipliers (sedentary, light, moderate, active) to find equilibrium maintenance calories.
- **Third Party API:** ❌ No

#### 20. Target Calories System
- **Feature:** Calculate target calories:
  - **Fat Loss:** TDEE - 500 kcal
  - **Maintenance:** TDEE kcal
  - **Muscle Gain:** TDEE + 350 kcal
- **Third Party API:** ❌ No

#### 21. Nutrition / Macro Blueprint
- **Feature:** Calculate exact grams split:
  - **Protein:** 2.2g per kg of Lean Body Mass (LBM).
  - **Fat:** Exactly 25% of Target Calories.
  - **Carbs:** Remaining calories.
- **Third Party API:** ❌ No

#### 22. Target Heart Rate Training Zones (Karvonen Method)
- **Feature:** Max Heart Rate (`220 - age`), Heart Rate Reserve (`Max_HR - resting_hr`), and target aerobic zones:
  - **Fat Burn Low:** `(HRR * 0.60) + resting_hr`
  - **Fat Burn High:** `(HRR * 0.70) + resting_hr`
  - **Cardio Range:** From Fat Burn High to `(HRR * 0.80) + resting_hr`
- **Third Party API:** ❌ No

#### 23. Fitness Assessment Dashboard
- **Feature:** Displays calculated metrics across 4 visual cards on the member evaluation screen:
  - **Card A (Vital Composition):** Weight, Body Fat %, Lean Body Mass (LBM), BMI status badge, and Waist-to-Hip Ratio (WHR).
  - **Card B (Energy Threshold):** BMR, TDEE, and Target Calories.
  - **Card C (Macronutrient split):** Segmented chart showing percentages and grams of Protein, Carbs, and Fats.
  - **Card D (Cardiovascular Guidance):** Programmatic advisory text showing Karvonen heart rate zones.
- **Third Party API:** ❌ No

#### 24. 15-Day / Monthly Measurement Reminder
- **Feature:** Send automated reminders to members to update their body measurements, BMI log, and progress.
- **Third Party API:** ✅ WhatsApp API, ✅ SMTP, ✅ Firebase Notification

#### 25. Progress Tracking
- **Feature:** Compare previous vs current physical metrics (Weight, BF%, LBM, BMI) on a visual progress graph.
- **Third Party API:** ❌ No

#### 26. Automated Progress Messages
- **Feature:** Generate motivational messages, achievement callouts, or suggestion logs based on comparison results.
- **Third Party API:** ✅ WhatsApp API, ✅ SMTP

---

### Workout, Diet & Gym Operations

#### 27. Workout Plan Management
- **Feature:** Trainers assign workouts, exercises, sets, reps, and routines to members.
- **Third Party API:** ❌ No

#### 28. Diet Plan Management
- **Feature:** Trainers build and assign customized meals/diet plans to members.
- **Third Party API:** ❌ No

#### 29. Attendance Management & Scoring
- **Feature:** Record attendance percentage and display colored score status:
  - **90% - 100%:** Excellent (Green)
  - **75% - 89%:** Good (Amber)
  - **60% - 74%:** Average
  - **40% - 59%:** Risk (Red)
  - **Below 40%:** Vulnerable (Red)
- **Third Party API:** ❌ No

#### 30. Attendance Alert System
- **Feature:** Trigger alerts when a member is absent for consecutive intervals (3 days, 7 days, 15 days, 30 days).
- **Third Party API:** ✅ WhatsApp API, ✅ SMTP, ✅ Firebase

#### 31. Leaderboard System
- **Feature:** Separate rankings for member categories (Fat Loss, Muscle Gain, Maintenance) based on BF% changes and LBM gains to foster competition.
- **Third Party API:** ❌ No

#### 32. Inventory Management
- **Feature:** Manage gym equipment, counts, purchase dates, maintenance status, and stock levels.
- **Third Party API:** ❌ No

#### 33. Equipment Request System
- **Feature:** Member/Trainer submits requests for specific accessories/equipments; Admin approves/rejects them.
- **Third Party API:** ✅ Firebase FCM (WhatsApp optional)

#### 34. Data Export System
- **Feature:** Export reports, member logs, payments, attendance history, and inventory to CSV and Excel formats.
- **Third Party API:** ❌ No

#### 35. Data Backup System
- **Feature:** Securely backup database structures and logs to Google Drive or Gmail.
- **Third Party API:** ✅ Google Drive API

#### 36. Public Health Calculator
- **Feature:** A public widget on the website landing page where visitors enter weight, height, and age to view their BMI and basic health benchmarks.
- **Third Party API:** ❌ No

#### 37. Invoice System
- **Feature:** Auto-generate invoices on membership assignments, download/print receipts, and email payment vouchers.
- **Third Party API:** ✅ SMTP, ✅ Payment Gateway

#### 38. App/Web Push Notification Engine
- **Feature:** Deliver real-time notifications for payments, reminders, and alerts.
- **Third Party API:** ✅ Firebase Cloud Messaging (FCM)

