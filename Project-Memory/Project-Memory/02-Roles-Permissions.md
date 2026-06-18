# 02 - Roles & Permissions
**Project:** SaaS Gym Management System  
**Last Updated:** 2026-06-08

---

## Roles in Database (`role` table)

| ID | Role Name | Display Name | Description |
|----|-----------|-------------|-------------|
| 1 | Superadmin | Super Admin | System Owner. Manages gyms, subscriptions, global leads, and platform settings. |
| 1.1| Sub-Admin | Super Admin Assistant | Custom RBAC. Access is strictly controlled via permissions checklist by Super Admin. |
| 2 | Admin | Gym Owner / Admin | Gym Owner. Manages branches, plans, billing, managers, staff, and landing page. |
| 3 | trainer | Trainer (Generic) | Legacy trainer role. |
| 4 | member | Member / Customer | Gym members. View own plans, check-ins, health logs, and diet charts. |
| 5 | personaltrainer | Personal Trainer | PT. Assigns workout/diet plans to personal clients, records BMI and health logs. |
| 6 | generaltrainer | General Trainer | GT. Manages group classes and records member check-ins. |
| 7 | receptionist | Receptionist / Sales Staff | Front Desk. Manages lead registration, walk-in inquiries, and member check-ins. |
| 8 | housekeeping | House Keeping Staff | Cleanliness tracking, shifts, and attendance verification. |

---

## Permissions Matrix

| Feature / Module | Superadmin | Admin (Gym Owner) | Receptionist (Sales Staff) | Personal Trainer | General Trainer | Member | HouseKeeping |
|-----------------|:----------:|:-----------------:|:--------------------------:|:----------------:|:---------------:|:------:|:------------:|
| **DASHBOARD** | | | | | | | |
| View System Dashboard | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| **MEMBERS** | | | | | | | |
| View All Members | ✅ | ✅ | ✅ | ❌ | ❌ | ❌ | ❌ |
| Add/Edit Member | ✅ | ✅ | ✅ | ❌ | ❌ | ❌ | ❌ |
| Delete Member | ✅ | ✅ | ❌ | ❌ | ❌ | ❌ | ❌ |
| **LEADS / CRM** | | | | | | | |
| View Lead List | ✅ | ✅ | ✅ (Only Assigned Leads) | ❌ | ❌ | ❌ | ❌ |
| Add/Edit Lead | ✅ | ✅ | ✅ | ❌ | ❌ | ❌ | ❌ |
| Assign Lead to Staff | ❌ | ✅ | ✅ | ❌ | ❌ | ❌ | ❌ |
| Convert Lead to Member | ❌ | ✅ | ✅ | ❌ | ❌ | ❌ | ❌ |
| **ATTENDANCE** | | | | | | | |
| QR Code Check-in (Own) | ❌ | ❌ | ❌ | ❌ | ❌ | ✅ | ❌ |
| Mark Manual Attendance | ❌ | ✅ | ✅ | ❌ | ❌ | ❌ | ❌ |
| View Attendance History | ✅ | ✅ | ✅ | ❌ | ❌ | ✅ | ❌ |
| **HEALTH & BMI** | | | | | | | |
| Record BMI & Health Log | ❌ | ✅ | ❌ | ✅ | ✅ | ❌ | ❌ |
| View Own Health Logs | ❌ | ❌ | ❌ | ❌ | ❌ | ✅ | ❌ |
| View All Health Logs | ❌ | ✅ | ❌ | ✅ | ✅ | ❌ | ❌ |
| **DIET & FOOD CHART** | | | | | | | |
| Create Diet Plan | ❌ | ✅ | ❌ | ✅ | ✅ | ❌ | ❌ |
| View Assigned Diet | ❌ | ❌ | ❌ | ❌ | ❌ | ✅ | ❌ |
| **SYSTEM SETTINGS** | | | | | | | |
| Edit Gym Landing Page | ❌ | ✅ | ❌ | ❌ | ❌ | ❌ | ❌ |
| Manage Branch Details | ❌ | ✅ | ❌ | ❌ | ❌ | ❌ | ❌ |
| View SaaS Billing Info | ❌ | ✅ | ❌ | ❌ | ❌ | ❌ | ❌ |

---

## CRM Lead Division Access Rules (New Meeting Requirements)
- **Role Restriction:** The "Receptionist / Sales Staff" (Sales Agent) must have a restricted sidebar view. Sidebar menus for plans, billing, and settings will be hidden when a user with this role logs in.
- **Lead Isolation:**
  - Sales agents can only query and view leads that are explicitly assigned to them in the database (`leads.assignedToStaffId = staff.id` of the logged-in sales agent).
  - The Super Admin or Gym Owner has the overall view to distribute/allocate total leads among different agents.

---

## Super Admin RBAC (Sub-Admin Permissions)
- **Goal:** Allow Super Admin to securely delegate tasks without exposing financial data or full control.
- **Role:** Sub-Admin / Super Admin Assistant.
- **Logic:** 
  - Sub-Admins have a `permissions` array or JSON column in the database.
  - Super Admin can check/uncheck available modules (e.g., Dashboard, Leads, Plans, Branches, Payments).
  - Sub-Admin sees ONLY the menus ticked in their permissions checklist. Access to unchecked routes is blocked at the frontend and backend levels.