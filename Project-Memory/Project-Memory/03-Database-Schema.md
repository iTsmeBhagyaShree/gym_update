# 03 - Database Schema
**Project:** SaaS Gym Management System  
**Database Engine:** MySQL  
**ORM Tool:** Prisma ORM  
**Last Updated:** 2026-06-13

---

## Database Overview
The database name is `gym_new_db` (configured via `DATABASE_URL` in `.env`). It contains **47 tables** (updated 2026-06-13) representing the SaaS platform, multi-branch gym structure, CRM, member attendance, health tracking, diet logs, staff shifts, messaging credit system, marketing campaigns, editable landing page settings, and global configuration values.

---

## All Tables (47 Total - Updated 2026-06-13)

```text
alert, app_settings, booking, booking_requests, branch, classschedule, classtype, 
demo_requests, dietmeal, dietplan, dietplanassignment, expense, global_settings, group_class_bookings, 
housekeepingattendance, housekeepingschedule, landing_page_cms, leads, marketing_campaigns, 
member, member_health_log, member_plan_assignment, memberattendance, memberplan, 
membership_renewal_requests, notificationlog, payment, plan, product, pt_bookings, 
purchase, role, salary, saas_payments, session, shifts, staff, staffattendance, 
stockmovement, tasks, unified_bookings, used_qr_nonces, user, whatsapp_credit_transactions, 
workoutexercise, workoutplan, workoutplanassignment
```

---

## Core Tables Documentation

### 1. `user` (All login accounts for Superadmin, Admin/Owner, Trainers, Staff)
Holds credentials and basic profile details for users.

| Column | Type | Nullable | Description |
|--------|------|----------|-------------|
| `id` | Int (PK) | No | Auto-incrementing identifier |
| `fullName` | String | No | User's full name |
| `email` | String | No | Login email (unique key) |
| `password` | String | No | Bcrypt-hashed password |
| `phone` | String | Yes | Contact number |
| `roleId` | Int (FK) | No | Reference to `role.id` |
| `branchId` | Int (FK) | Yes | Reference to `branch.id` |
| `status` | String | Yes | Account status (e.g. ACTIVE, INACTIVE) |
| `gymName` | String | Yes | SaaS tenant gym name |
| `whatsappPlan` | String | No | Default `Basic` (Basic, Standard, Premium) |
| `licenseExpiryDate` | DateTime | Yes | Subscription expiry date for gym owner |
| `licenseKey` | String | Yes | SaaS subscription license key |

---

### 2. `member` (Gym customers/members details)
Linked to `user` and `branch`. Contains membership status, join date, and links to health records.

| Column | Type | Nullable | Description |
|--------|------|----------|-------------|
| `id` | Int (PK) | No | Auto-incrementing identifier |
| `userId` | Int (FK) | Yes | Linked user login account id |
| `adminId` | Int | No | ID of the Admin/Owner |
| `fullName` | String | No | Member's full name |
| `email` | String | Yes | Email address (unique key) |
| `phone` | String | No | Contact number |
| `gender` | String | Yes | Gender |
| `joinDate` | DateTime | No | System registration date |
| `branchId` | Int (FK) | Yes | Reference to `branch.id` |
| `membershipFrom`| DateTime | Yes | Current membership start date |
| `membershipTo` | DateTime | Yes | Current membership end date |
| `status` | String | No | `ACTIVE` or `INACTIVE` |
| `planId` | Int | Yes | Active membership plan ID |
| `goal` | String | Yes | Member's fitness goal (choices: Weight Loss, Weight Gain, Body Building, or custom manual entry) |

---

### 3. `saas_payments` (SaaS Subscription Management)
Logs plan purchases and transaction histories for Gym Owners.

| Column | Type | Nullable | Description |
|--------|------|----------|-------------|
| `id` | Int (PK) | No | Auto-incrementing identifier |
| `adminId` | Int (FK) | No | Reference to `user.id` (Gym Owner) |
| `amount` | Float | No | Payment amount (e.g. 8999) |
| `planType` | String | No | Basic / Standard / Premium |
| `paymentStatus`| String | No | success / failed / pending |
| `transactionId`| String | Yes | UPI reference or transaction ID |
| `paymentDate` | DateTime | No | Timestamp of the transaction |
| `expiryDate` | DateTime | No | Expiry date of active license |
| `createdAt` | DateTime | No | Default `now()` |

---

### 4. `demo_requests` (Landing Page Demo Inquiries)
Tracks demo request submissions from landing page.

| Column | Type | Nullable | Description |
|--------|------|----------|-------------|
| `id` | Int (PK) | No | Auto-incrementing identifier |
| `email` | String | No | Email address |
| `phone` | String | No | Contact number |
| `status` | String | No | Default `pending` (pending / contacted) |
| `createdAt` | DateTime | No | Default `now()` |

---

### 5. `member_health_log` (BMI and physical check records)
Stores measurements to display a progress graph. (Updated on 2026-06-13 to support Physical Assessment & Nutrition module).

| Column | Type | Nullable | Description |
|--------|------|----------|-------------|
| `id` | Int (PK) | No | Auto-incrementing identifier |
| `memberId` | Int (FK) | No | Reference to `member.id` |
| `trainerId` | Int (FK) | Yes | Reference to `staff.id` (recording trainer) |
| `height` | Decimal(5,2) | No | Height in centimeters |
| `weight` | Decimal(5,2) | No | Weight in kilograms |
| `bmi` | Decimal(5,2) | No | Calculated Body Mass Index |
| `status` | String | No | Underweight / Normal / Overweight / Obese |
| `neck_cm` | Decimal(4,1) | Yes | Neck tape measurement (added 2026-06-13) |
| `waist_cm`| Decimal(4,1) | Yes | Waist tape measurement (added 2026-06-13) |
| `hip_cm` | Decimal(4,1) | Yes | Hip tape measurement (mandatory for females, added 2026-06-13) |
| `resting_hr`| Int | Yes | Resting Heart Rate in BPM (added 2026-06-13) |
| `activity_level`| Enum | Yes | sedentary, light, moderate, active (added 2026-06-13) |
| `fitness_goal` | Enum | Yes | fat_loss, maintenance, muscle_gain (added 2026-06-13) |
| `notes` | Text | Yes | Trainer notes (added 2026-06-13) |
| `dietChart` | Text | Yes | Quick text/notes for diet plan (added 2026-06-13) |
| `recordedAt` | DateTime | No | Date and time recorded (default `now()`) |


---

### 6. `memberattendance` (QR and manual attendance check-ins)
Tracks coordinates and devices to prevent fraud.

| Column | Type | Nullable | Description |
|--------|------|----------|-------------|
| `id` | Int (PK) | No | Auto-incrementing identifier |
| `memberId` | Int | Yes | Reference to `member.id` |
| `branchId` | Int | Yes | Reference to `branch.id` |
| `checkIn` | DateTime | No | Check-in timestamp |
| `checkOut` | DateTime | Yes | Check-out timestamp |
| `status` | String(20) | Yes | e.g. Present, Absent |
| `mode` | String(20) | Yes | e.g. QR, Manual |
| `latitude` | Decimal(10,8) | Yes | GPS latitude coordinate |
| `longitude`| Decimal(11,8) | Yes | GPS longitude coordinate |
| `deviceId` | String(191) | Yes | Member's device fingerprint/id |
| `ipAddress`| String(45) | Yes | Source IP address |

---

### 7. `leads` (CRM inquiry records)
Tracks lead status, assignment, and details.

| Column | Type | Nullable | Description |
|--------|------|----------|-------------|
| `id` | Int (PK) | No | Auto-incrementing identifier |
| `adminId` | Int (FK) | No | Reference to `user.id` |
| `fullName` | String | No | Lead's name |
| `phone` | String | No | Contact number |
| `source` | String | No | Default `Landing Page` |
| `status` | String | No | e.g. New, Contacted, Converted |
| `assignedToStaffId` | Int (FK)| Yes| Reference to `staff.id` |
| `notes` | Text | Yes | Inquiries or follow-up notes |
| `createdAt` | DateTime | No | Maps registration timestamp |

---

### 8. `branch` (Multi-branch gym details)
Geofencing settings are stored here.

| Column | Type | Nullable | Description |
|--------|------|----------|-------------|
| `id` | Int (PK) | No | Auto-incrementing identifier |
| `name` | String | No | Branch location name |
| `address` | String | Yes | Location address |
| `status` | Enum | No | `ACTIVE` or `INACTIVE` |
| `adminId` | Int (FK) | Yes | Admin/Owner user reference |
| `attendanceRadiusMeters`| Int | No | Default `50` (Allowed geofence boundary) |

---

### 9. `whatsapp_credit_transactions` (WhatsApp Message Credit Purchase Logs - Added 2026-06-13)
Logs transaction details of credits purchased by Gym Owners (Admins).

| Column | Type | Nullable | Description |
|--------|------|----------|-------------|
| `id` | Int (PK) | No | Auto-incrementing identifier |
| `adminId` | Int (FK) | No | Reference to `user.id` (Gym Owner) |
| `creditsPurchased`| Int | No | Number of message credits purchased |
| `amountPaid` | Double | No | Purchase price paid |
| `paymentStatus` | String | No | success / failed / pending |
| `transactionId` | String | Yes | Transaction transaction/reference ID |
| `createdAt` | DateTime | No | Creation timestamp (default `now()`) |

---

### 10. `marketing_campaigns` (Bulk Message Marketing Campaigns - Added 2026-06-13)
Tracks marketing campaign blasts sent to CRM leads.

| Column | Type | Nullable | Description |
|--------|------|----------|-------------|
| `id` | Int (PK) | No | Auto-incrementing identifier |
| `adminId` | Int (FK) | No | Reference to `user.id` (Gym Owner) |
| `campaignName` | String | No | Name of campaign |
| `templateMessage`| Text | No | Body text of message sent |
| `channel` | String | No | WhatsApp / Email |
| `recipientCount` | Int | No | Number of recipients targeted |
| `status` | String | No | status flag (default `pending`) |
| `scheduledAt` | DateTime | Yes | Scheduled date and time |
| `createdAt` | DateTime | No | Creation timestamp (default `now()`) |

---

### 11. `landing_page_cms` (Dynamic Landing Page Settings - Added 2026-06-13)
Stores theme features and styling text configured via Admin Settings.

| Column | Type | Nullable | Description |
|--------|------|----------|-------------|
| `id` | Int (PK) | No | Auto-incrementing identifier |
| `adminId` | Int (FK) | No | Reference to `user.id` (Gym Owner) |
| `heroTitle` | String | Yes | Main banner landing page header text |
| `heroSubtitle` | String | Yes | Sub-text displayed below title |
| `bannerUrl` | String | Yes | Image URL of active main banner |
| `featuresJson` | Text | Yes | JSON text format representing features list |
| `testimonialsJson`| Text | Yes | JSON text format representing active reviews |
| `createdAt` | DateTime | No | Creation timestamp (default `now()`) |
| `updatedAt` | DateTime | No | Update timestamp |

---

### 12. `global_settings` (Platform-Wide Super Admin Configurations - Added 2026-06-13)
Stores system-wide key-value preferences like active communication channels.

| Column | Type | Nullable | Description |
|--------|------|----------|-------------|
| `key_name` | String (PK) | No | Unique settings key identifier (e.g. `welcome_note_channel`) |
| `value_data`| Text | No | JSON-stringified settings values (e.g. `["EMAIL", "WHATSAPP"]`) |
| `updatedAt` | DateTime | No | Automatic update timestamp |