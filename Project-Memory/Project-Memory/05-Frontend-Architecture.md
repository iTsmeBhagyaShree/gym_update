# 05 - Frontend Architecture
**Project:** SaaS Gym Management System  
**Framework:** React + Vite  
**Routing Library:** React Router DOM (v6)  
**Last Updated:** 2026-06-08

---

## Technical Stack
- **Frontend Build Tool:** Vite (fast compilation and hot reloading)
- **UI Logic:** Functional components with React hooks (`useState`, `useEffect`, `useContext`)
- **Charting & Metrics:** Apache ECharts (`echarts` and `echarts-for-react`)
- **CSS Styling:** Modern CSS layout techniques (CSS Variables, Flexbox, Grid)

---

## Directory Structure (`src/`)

```
src/
├── Api/              # Axios instance and API call services
├── Auth/             # Login, Signup, ForgotPassword components
├── Components/       # Reusable components (ProtectedRoute, ErrorBoundary)
├── Dashboard/        # Role-based dashboards
│   ├── Admin/        # Settings, Branch Management, Super Admin panels
│   ├── Manager/      # Member CRUD, Staff, Reports, Lead Management
│   ├── PersonalTrainer/ # DietBuilder, TrainerHealthLog, client list
│   └── Member/       # Member profile, MyDietPlan, Attendance history
├── Layout/           # Shell components (Navbar, Sidebar)
├── assets/           # Images, logo SVGs, static files
├── utils/            # Helper functions (date formatters, token checkers)
├── App.jsx           # Global routes definition
└── main.jsx          # Root entry point
```

---

## Routing Architecture (`App.jsx`)
- **Stateless Router:** Uses `BrowserRouter` wrapping `Routes` and nested `Route` hooks.
- **Dynamic Access Control:** Route paths are protected using the `<ProtectedRoute>` component.
  ```jsx
  <Route 
    path="/admin/branches" 
    element={
      <ProtectedRoute allowedRoles={["ADMIN", "SUPERADMIN"]}>
        <SuperAdminBranches />
      </ProtectedRoute>
    } 
  />
  ```

---

## Navigation Shell (`Sidebar.jsx` & `Navbar.jsx`)
- **Role Detection:** Reading `localStorage.getItem("userRole")` on initial render.
- **Sidebar Menu Array:** A dynamic data object `allMenus` contains sidebar links, icons (using React Lucide icons), and routing paths mapped to each user role.
- **Collapse Mode:** Sidebar includes a responsive toggler to change between collapsed icon-only layout and expanded text-menu labels.
- **Notification Indicator:** A bell icon in the navbar queries pending member registration notifications or trainer alerts.