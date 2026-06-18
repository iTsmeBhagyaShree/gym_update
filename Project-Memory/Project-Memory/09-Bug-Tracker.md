# 09 - Bug Tracker
**Project:** SaaS Gym Management System  
**Tracking Level:** Active Issues & Fixed Logs  
**Last Updated:** 2026-06-13

---

## Resolved Issues

### 1. MySQL Connection Refused (ECONNREFUSED) in Cron Jobs
- **Symptom:** The PT member expiry auto-complete cron failed on start due to MySQL server connection not being established yet.
- **Cause:** Cron jobs were starting immediately during application boot before the pool connection handshake was completed.
- **Fix:** Added a connection verification block that delays starting background crons until the DB pool verifies it can run a query:
  ```javascript
  // Verify pool availability before cron launch
  db.query('SELECT 1')
    .then(() => startCronJobs())
    .catch(err => logger.error("DB check failed, delaying cron start"));
  ```
- **Status:** ✅ Resolved.

---

### 2. Super Admin Staff Leaderboard "No Data" Mismatch
- **Symptom:** The top-performing staff panel returned a blank list `[]` when no leads were explicitly assigned to staff members.
- **Cause:** SQL query utilized an `INNER JOIN` between `user` and `leads` tables, hiding staff accounts with 0 lead assignments.
- **Fix:** Modified the query in `dashboard.service.js` to use a `LEFT JOIN` on leads, grouping by staff ID. This displays all registered staff members with their active lead stats (showing 0 if none are assigned).
- **Status:** ✅ Resolved.

---

### 3. Member Health Log Table Collation Error
- **Symptom:** Database threw decimal validation exceptions when storing user height/weight.
- **Cause:** Table schema defined fields using low-precision floats, failing on floating decimal roundings during BMI processing.
- **Fix:** Migrated columns to use `Decimal(5,2)` in Prisma schema, forcing standard precision constraints.
- **Status:** ✅ Resolved.

---

### 4. Kiosk Scan Nonce Expiry Lockouts
- **Symptom:** Members checking in synchronously sometimes experienced timeout errors, causing check-in failures.
- **Cause:** Nonce checking was blocking database threads during peak scanning hours.
- **Fix:** Added a cleanup query that removes expired nonces (older than 10 minutes) on database idle times.
- **Status:** ✅ Resolved.

---

### 5. Lead Creation 500 Internal Server Error
- **Symptom:** Saving a new lead returned a 500 status code and failed in the UI.
- **Cause:** 
  1. The frontend select dropdown for staff assignments used `staff.id` and `staff.role` which were `undefined` (the backend list returned `staffId` and `roleId`). This resulted in sending `"undefined"` as the string value for `assignedToStaffId` to the backend.
  2. The backend database insert query failed because it did not sanitize empty or invalid strings (like `"undefined"`) for foreign key / integer fields like `assignedToStaffId` and `branchId`, triggering a MySQL constraint failure.
- **Fix:** 
  1. Updated `Leads.jsx` to correctly map staff select options using `staff.staffId` and resolve the role name using `staff.roleId`.
  2. Updated `lead.service.js` to parse and sanitize input values like `assignedToStaffId`, `branchId`, and `followUpDate` to `null` if they are empty or `"undefined"`, preventing foreign key constraint crashes on both creation and update endpoints.
- **Status:** ✅ Resolved.

---

### 6. Sub-Admin Permissions Empty / Double-Stringification Bug
- **Symptom:** Sub-admin user permissions checklist selections would not display as badges in the "Manage Sub-Admins" table (column was empty) and sidebar menus did not restrict properly.
- **Cause:** The frontend stringified the permissions array as a JSON string when appending to formPayload, and the backend service did `JSON.stringify` on the already-stringified string again. This resulted in double-stringified JSON (`'"[\\"Dashboard\\"]"'`) in MySQL. `JSON.parse` on get only parsed it once, returning a string instead of an array.
- **Fix:** 
  1. Created a database fix script (`fix-permissions.js`) to clean existing sub-admin permissions in the database.
  2. Modified backend `subadmin.service.js` to process and parse incoming permissions if they are already JSON stringified.
  3. Updated backend `auth.service.js` and frontend `Sidebar.jsx` to robustly parse the permissions JSON string twice if it's double-stringified, ensuring the app handles any legacy data formats gracefully.
  4. Added route-level path guarding for `SUBADMIN` users in `ProtectedRoute.jsx` to redirect them if they manually type an unauthorized URL.
- **Status:** ✅ Resolved (2026-06-13).

---

### 7. Sidebar Links Casing Mismatch (Blank Screen on Specific Menus)
- **Symptom:** Clicking specific menus (like "Create Plan", "Classes Schedule" for Gym Owner, or "Attendance", "QR Check-in" for General Trainer) resulted in a completely blank screen.
- **Cause:** React Router is case-sensitive. The sidebar links used a different casing style (e.g. `/admin/createplan`, `/admin/classesSchedule`) compared to the router paths in `App.jsx` (e.g. `/admin/CreatePlan`, `/admin/ClassesSchedule`), causing "No route matched" and blank screen rendering.
- **Fix:** Duplicated the routes in `App.jsx` with lowercase and mixed-case structures (aliases) to match the sidebar targets.
- **Status:** ✅ Resolved (2026-06-13).

---

### 8. Image Cropper Error when Cropping Staff/Trainer Profile Picture
- **Symptom:** Selecting a profile picture in the "Add/Edit Staff" modal and clicking "Apply Crop" resulted in a popup alert saying: "Error cropping image. Please try again."
- **Cause:** 
  1. Mismatched callback argument: `ImageCropper` returns a structured `{ blob, url }` object, but `handleCropComplete` in `ManageStaff.jsx` expected a raw `Blob`. Passing the object directly to `new File([croppedImageBlob], ...)` and `URL.createObjectURL(croppedImageBlob)` threw a `TypeError` (since `createObjectURL` requires a `Blob` or `MediaSource`), which was caught and triggered the cropper's error alert.
  2. The `createImage` helper in `ImageCropper.jsx` unconditionally set `crossOrigin = "anonymous"`, which can cause image loading failures for local data and object (blob) URLs in some browsers.
- **Fix:** 
  1. Updated `handleCropComplete` in `ManageStaff.jsx` to correctly destructure `const { blob, url } = croppedImageData` and use the actual blob and pre-created URL properly.
  2. Modified `createImage` in `ImageCropper.jsx` to conditionally set `crossOrigin = "anonymous"` only if the URL is a remote resource (i.e. does not start with `data:` or `blob:`).
- **Status:** ✅ Resolved (2026-06-13).