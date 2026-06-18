# 04 - API Architecture
**Project:** SaaS Gym Management System  
**Framework:** Node.js + Express.js  
**Database Connector:** Prisma client  
**Last Updated:** 2026-06-08

---

## Architecture Overview
The backend API is designed as a RESTful server. It handles authentication, data management for each tenant branch, CRM lead actions, attendance coordinates validation, and background CRON services.

---

## Authentication & Authorization
- **Token Mechanism:** Stateless JSON Web Token (JWT) is sent in the request header (`Authorization: Bearer <token>`).
- **Middlewares:**
  - `authenticateToken`: Parses and verifies JWT validity, attaching `req.user` details (id, role, branchId, adminId) to request.
  - `authorizeRoles([...AllowedRoles])`: Verifies if `req.user.role` matches the expected access privileges, returning `403 Forbidden` if not.

---

## Route Prefix Configuration

| Module | Route Prefix | Purpose |
|--------|--------------|---------|
| **Auth** | `/api/auth` | Login, signup, password reset, and token verification. |
| **Branches** | `/api/branches` | Manage multi-branch coordinates and radius thresholds. |
| **Members** | `/api/members` | Full CRUD, plan assignments, health records, and diet links. |
| **Leads** | `/api/leads` | Lead generation, assignment, conversion, and performance logs. |
| **Attendance** | `/api/attendance` | QR check-ins, manual check-ins, and geolocation validation. |
| **Diet** | `/api/diet` | Trainers create meal structures, member views assigned plan. |

---

## Geofencing & QR Validation Core Logic

### 1. GPS Location Check (`/api/attendance/scan-qr`)
During a mobile QR scan check-in, the client sends coordinates (`latitude` and `longitude`). The API validates:
```javascript
// Calculate distance between member and branch GPS
const distance = calculateHaversineDistance(
  memberLat, memberLng,
  branchLat, branchLng
);

if (distance > branch.attendanceRadiusMeters) {
  return res.status(400).json({
    success: false,
    message: "Out of allowed boundary range. Check-in rejected."
  });
}
```

### 2. Anti-Screenshot & Replay Check (Nonce)
To prevent members from sharing static QR code screenshots:
- A new QR nonce token is generated every few seconds and shown on the kiosk.
- The member scans the QR code containing the nonce.
- The API checks if the nonce has already been used in the `used_qr_nonces` table.
- If used, the request is rejected as a duplicate scan.
- If unused, the nonce is stored, and check-in succeeds.

### 3. Device ID Lock
Upon first login/scan, a member's browser fingerprint/device UUID is recorded in the `deviceId` column of their user profile. Subsequent QR scans must match this stored `deviceId` to prevent login sharing.

---

## Excel Data Migration API Endpoints

### 1. Import Members (`POST /api/members/import`)
- **Headers:** `Content-Type: multipart/form-data`
- **Body parameters:**
  - `file`: The Excel (`.xlsx` / `.xls`) or CSV file containing member rows.
  - `adminId`: ID of the admin importing the members.
  - `branchId` (optional): ID of the branch to assign the members to.
- **Process:** Parses the file using `xlsx`, maps plans, inserts user and member records, and logs any skipped duplicates.
- **Response:**
  ```json
  {
    "success": true,
    "message": "Import process completed",
    "successCount": 42,
    "skippedCount": 3,
    "skippedList": [
      { "name": "John Doe", "phone": "9999999999", "reason": "Phone already exists" }
    ]
  }
  ```

### 2. Download Sample Template (`GET /api/members/import/template`)
- **Response:** Serves an Excel template sheet download with standard headers: `Full Name`, `Phone`, `Email`, `Gender`, `Address`, `Plan Name`, `Goal`, `Date Of Birth`.