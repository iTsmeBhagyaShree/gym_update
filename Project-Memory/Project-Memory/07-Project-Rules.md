# 07 - Project Rules
**Project:** SaaS Gym Management System  
**Document Level:** Development Guidelines & Conventions  
**Last Updated:** 2026-06-08

---

## 1. Technical Implementation Guidelines
- **Core Technology:** Use standard HTML structures and React JSX.
- **Styling:** Use Vanilla CSS. Do not inject TailwindCSS classes unless explicitly requested. Custom layout structures must leverage defined variables in `index.css`.
- **Framework Upgrades:** Maintain Vite configuration structure. Do not introduce arbitrary loaders without testing local compile scripts first.

---

## 2. Coding & API Conventions
- **Variable Naming:** Use `camelCase` for variable and function names. Use `camelCase` for database columns matching standard Prisma definitions.
- **Error Handling:** All controller methods in the backend must be wrapped in `try/catch` blocks. Database errors must return formatted JSON responses instead of raw SQL dumps.
  ```json
  {
    "success": false,
    "message": "Friendly explanation of what failed"
  }
  ```
- **JWT Middleware Injection:** Any backend routes that access or modify records must invoke the `authenticateToken` middleware.

---

## 3. Data Isolation & Tenant Rules (SaaS Security)
- **Branch Level Separation:** Every database query that lists members, plans, staff, or settings must explicitly filter by `branchId` or `adminId` fetched from `req.user`.
- **Superadmin Boundary:** The Superadmin is the only role allowed to query across different gyms/branches. Other accounts must never bypass the tenant isolation logic.

---

## 4. Database Schema Policy
- **Prisma Schema Single Source:** Do not run manual `ALTER TABLE` commands directly in phpMyAdmin without documenting them in `schema.prisma`.
- **Migration Sync:** Ensure any schema adjustments are fully verified using `prisma generate` and tested locally with `npx prisma db push` to guarantee models sync.

---

## 5. Git & Workspace Best Practices
- **Untracked File Risk:** Documentation files and configuration credentials are untracked in git. Avoid running commands like `git clean -fd` or performing destructive `git reset --hard` resets without making local backup files.
- **Commit Strategy:** Keep commit descriptions short and clear (e.g. `feat: add gps verification to checkin`).
- **Pruning Node Modules:** If cleanups are needed, delete only the `node_modules` folder and rerun `npm install` instead of wiping untracked markdown logs.