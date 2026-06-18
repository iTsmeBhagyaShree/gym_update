# 10 - Deployment Guide
**Project:** SaaS Gym Management System  
**Environments:** Development (Local), Production (Railway + Netlify)  
**Last Updated:** 2026-06-08

---

## 1. Local Development Setup

### Backend (Node.js + Express)
1. Navigate to `/Backend`.
2. Create a `.env` file containing local configurations:
   ```env
   PORT=5000
   DATABASE_URL="mysql://root:password@localhost:3306/gym_new_db"
   JWT_SECRET="your_jwt_secret_key"
   ```
3. Run `npm install` to load dependencies.
4. Run `npx prisma generate` to build client types.
5. Launch development server with `npm run dev`.

### Frontend (React + Vite)
1. Navigate to `/Frontend`.
2. Create a `.env` file containing the backend URL:
   ```env
   VITE_API_URL="http://localhost:5000"
   ```
3. Run `npm install` and launch with `npm run dev`.

---

## 2. Production Deployment

### Database & Backend on Railway.app
Railway.app hosts both the MySQL database instance and the Node.js API application.

1. **Deploy MySQL Service:**
   - Spin up a MySQL database service container in the Railway workspace.
   - Note the connection string variables (host, port, user, password, database).
2. **Deploy Backend Service:**
   - Connect the git repository `/Backend` folder to a new Web Service.
   - Bind environment variables:
     - `DATABASE_URL`: Set to the Railway MySQL connection string.
     - `JWT_SECRET`: Generate a secure random hash.
     - `PORT`: Set to `5000` (or leave default, Railway binds automatically).
3. **Run Prisma Migrations:**
   - Execute deployment scripts that trigger `npx prisma db push` to synchronize table definitions.

### Frontend on Netlify
Netlify hosts the compiled static React SPA.

1. **Build Settings:**
   - **Repository Subdirectory:** `Frontend`
   - **Build Command:** `npm run build`
   - **Publish Directory:** `dist`
2. **Environment Variables:**
   - `VITE_API_URL`: Set to the live Railway API URL (e.g. `https://gym-backend-production.up.railway.app`).
3. **Redirects Configuration:**
   - Create a `_redirects` file in the publish directory to handle React Router client-side routes:
     ```text
     /*   /index.html   200
     ```

---

## 3. Post-Deployment Verification
- Try registering a test member from the client dashboard.
- Verify that coordinates and device checking work correctly.
- Check database record creation using phpMyAdmin or Prisma Studio.