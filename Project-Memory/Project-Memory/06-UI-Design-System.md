# 06 - UI Design System
**Project:** SaaS Gym Management System  
**Styling Method:** Plain Vanilla CSS  
**Last Updated:** 2026-06-08

---

## Design Philosophy
The UI is styled using a modern, dark-themed dashboard look. It utilizes crisp layouts, glassmorphism card overlays, clear active states, and custom transitions to present information premium and clutter-free.

---

## Global Design Tokens (CSS Variables)

Defined in `src/index.css`:

```css
:root {
  /* Colors */
  --primary-color: #ff5e3a;      /* Energetic Orange */
  --primary-hover: #e04f2d;
  --bg-dark-900: #0d0e12;        /* Pure Dark BG */
  --bg-dark-800: #161821;        /* Cards & Sidebar */
  --bg-dark-700: #212433;        /* Inputs & Highlights */
  --text-white: #ffffff;
  --text-muted: #8d92ad;         /* Secondary Labels */
  
  /* Status Colors */
  --status-success: #10b981;     /* Active Members, Converted Leads */
  --status-warning: #f59e0b;     /* Pending Approvals */
  --status-danger: #ef4444;      /* Unpaid, Inactive */
  
  /* Borders & Shadows */
  --border-color: rgba(255, 255, 255, 0.08);
  --shadow-lg: 0 10px 30px rgba(0, 0, 0, 0.5);
  --radius-lg: 12px;
  --radius-sm: 6px;
  
  /* Transitions */
  --transition-smooth: all 0.3s ease;
}
```

---

## Typography
- **Core Font Family:** Google Fonts Inter / Outfit.
- **Font Weights:** Light (300), Regular (400), Medium (500), SemiBold (600), Bold (700).
- **Line Heights:** Configured relative to size to avoid wrapping issues in headings.

---

## Core Components Styles

### 1. Cards (Glassmorphism Effect)
Used for dashboard stats cards and CRM metric counts:
- Dark background (`var(--bg-dark-800)`) with a subtle 1px border.
- Border-radius: `var(--radius-lg)`.
- Clickable cards scale up slightly on hover (`transform: translateY(-4px)`) and display an outline border.

### 2. Action Buttons
- **Primary:** Bright energetic orange (`var(--primary-color)`) with white text and smooth hover translation.
- **Outline:** Transparent background with 1px border, changing opacity and color on hover.

### 3. Lead Tables
- Styled with thin borders, clean headers in mute purple/gray, and status badges.
- Status badges use background opacity: e.g. `.badge-success` uses `rgba(16, 185, 129, 0.15)` background and `var(--status-success)` text.

### 4. Micro-Animations & Transitions
- Fade-in animations for charts and metrics lists.
- Ripple click feedback on sidebar selection items.
- Pulsing green indicator for active attendance scans/GPS search logs.