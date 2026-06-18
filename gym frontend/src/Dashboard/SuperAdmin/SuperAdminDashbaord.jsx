import React, { useState, useEffect } from "react";
import axiosInstance from "../../Api/axiosInstance";
import {
  BarChart,
  Bar,
  XAxis,
  YAxis,
  CartesianGrid,
  Tooltip,
  ResponsiveContainer,
  Legend,
  Cell,
} from "recharts";
import {
  FaArrowUp,
  FaArrowDown,
  FaRupeeSign,
  FaBullseye,
  FaUserTie,
  FaChartBar,
  FaTrophy,
  FaFilter,
} from "react-icons/fa";

/* ─────────────────────────────────────────
   Responsive hook
───────────────────────────────────────── */
function useWindowWidth() {
  const [w, setW] = useState(
    typeof window !== "undefined" ? window.innerWidth : 1024
  );
  useEffect(() => {
    const fn = () => setW(window.innerWidth);
    window.addEventListener("resize", fn);
    return () => window.removeEventListener("resize", fn);
  }, []);
  return w;
}

/* ─────────────────────────────────────────
   Helpers
───────────────────────────────────────── */
function fmtINR(n) {
  if (n == null) return "₹0";
  if (n >= 10000000) return `₹${(n / 10000000).toFixed(2)}Cr`;
  if (n >= 100000) return `₹${(n / 100000).toFixed(1)}L`;
  if (n >= 1000) return `₹${(n / 1000).toFixed(1)}k`;
  return `₹${Number(n).toLocaleString("en-IN")}`;
}
function fmtINRFull(n) {
  if (n == null) return "₹0";
  return "₹" + Number(n).toLocaleString("en-IN");
}
function pct(a, b) {
  if (!b || b === 0) return 0;
  return Math.round((a / b) * 100);
}

/* ─────────────────────────────────────────
   Custom Bar Chart Tooltip
───────────────────────────────────────── */
const BarTooltip = ({ active, payload, label }) => {
  if (!active || !payload?.length) return null;
  return (
    <div
      style={{
        background: "#1e293b",
        borderRadius: "10px",
        padding: "12px 16px",
        boxShadow: "0 8px 24px rgba(0,0,0,0.25)",
        fontSize: "12px",
        color: "#fff",
        minWidth: "160px",
      }}
    >
      <p style={{ margin: "0 0 8px", fontWeight: "700", color: "#94a3b8", fontSize: "11px" }}>
        DAY {label}
      </p>
      {payload.map((entry, i) => (
        <div
          key={i}
          style={{
            display: "flex",
            justifyContent: "space-between",
            gap: "16px",
            margin: "3px 0",
          }}
        >
          <span style={{ color: entry.fill, fontWeight: "600" }}>{entry.name}</span>
          <span style={{ fontWeight: "700" }}>{fmtINR(entry.value)}</span>
        </div>
      ))}
    </div>
  );
};

/* ─────────────────────────────────────────
   KPI Card Component
───────────────────────────────────────── */
function KpiCard({ label, value, subValue, delta, positive, icon: Icon, accent, isMobile }) {
  return (
    <div
      style={{
        background: "#fff",
        borderRadius: "14px",
        padding: isMobile ? "14px" : "18px 20px",
        boxShadow: "0 2px 16px rgba(0,0,0,0.07)",
        border: `1px solid #f0f2f5`,
        borderLeft: `4px solid ${accent}`,
        display: "flex",
        flexDirection: "column",
        gap: "8px",
        position: "relative",
        overflow: "hidden",
      }}
    >
      {/* Background icon watermark */}
      <div
        style={{
          position: "absolute",
          right: "14px",
          top: "50%",
          transform: "translateY(-50%)",
          opacity: 0.06,
        }}
      >
        <Icon size={52} color={accent} />
      </div>

      {/* Label */}
      <span
        style={{
          fontSize: "11px",
          fontWeight: "700",
          color: "#94a3b8",
          textTransform: "uppercase",
          letterSpacing: "0.8px",
        }}
      >
        {label}
      </span>

      {/* Primary Value */}
      <div
        style={{
          fontSize: isMobile ? "20px" : "26px",
          fontWeight: "800",
          color: "#0f172a",
          lineHeight: 1.1,
          letterSpacing: "-0.5px",
        }}
      >
        {value}
      </div>

      {/* Delta badge + sub-value */}
      <div style={{ display: "flex", alignItems: "center", gap: "8px", flexWrap: "wrap" }}>
        <span
          style={{
            display: "inline-flex",
            alignItems: "center",
            gap: "3px",
            fontSize: "12px",
            fontWeight: "700",
            color: positive ? "#16a34a" : "#dc2626",
            background: positive ? "#f0fdf4" : "#fef2f2",
            borderRadius: "20px",
            padding: "2px 8px",
          }}
        >
          {positive ? <FaArrowUp size={9} /> : <FaArrowDown size={9} />}
          {Math.abs(delta)}%
        </span>
        {subValue && (
          <span style={{ fontSize: "11px", color: "#94a3b8", fontWeight: "500" }}>
            {subValue}
          </span>
        )}
      </div>
    </div>
  );
}

/* ─────────────────────────────────────────
   Main Dashboard
───────────────────────────────────────── */
export default function DashboardHomePage() {
  const windowWidth = useWindowWidth();
  const isMobile = windowWidth < 768;
  const isTablet = windowWidth >= 768 && windowWidth < 1024;

  // Chart height responsive
  const chartHeight =
    windowWidth < 480 ? 240 :
    windowWidth < 768 ? 280 :
    windowWidth < 1024 ? 320 : 360;

  const [dashboardData, setDashboardData] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const [selectedBranch, setSelectedBranch] = useState("all");

  useEffect(() => {
    const fetch = async () => {
      setLoading(true);
      try {
        const url =
          selectedBranch === "all"
            ? "dashboard/dashboard"
            : `dashboard/dashboard?branchId=${selectedBranch}`;
        const res = await axiosInstance.get(url);
        if (res.data?.success) setDashboardData(res.data.data);
        else setError("Failed to load dashboard data.");
      } catch (e) {
        setError("An error occurred while fetching data.");
      } finally {
        setLoading(false);
      }
    };
    fetch();
  }, [selectedBranch]);

  /* ── Loading ── */
  if (loading && !dashboardData) {
    return (
      <div
        style={{
          display: "flex",
          flexDirection: "column",
          alignItems: "center",
          justifyContent: "center",
          height: "300px",
          gap: "14px",
          color: "#64748b",
        }}
      >
        <div
          style={{
            width: "36px",
            height: "36px",
            border: "3px solid #e2e8f0",
            borderTop: "3px solid #3b82f6",
            borderRadius: "50%",
            animation: "spin 0.8s linear infinite",
          }}
        />
        <span style={{ fontSize: "14px", fontWeight: "500" }}>Loading analytics...</span>
        <style>{`@keyframes spin { to { transform: rotate(360deg); } }`}</style>
      </div>
    );
  }

  /* ── Error ── */
  if (error) {
    return (
      <div
        style={{
          margin: "16px",
          padding: "16px 20px",
          background: "#fef2f2",
          border: "1px solid #fecaca",
          borderRadius: "12px",
          color: "#dc2626",
          fontSize: "13px",
          fontWeight: "500",
        }}
      >
        ⚠️ {error}
      </div>
    );
  }

  if (!dashboardData) return null;

  /* ─── Data prep ─── */
  const branchList = dashboardData.branchLeaderboard.map((b) => ({
    id: b.branchId || b.branchName,
    name: b.branchName || b.branch,
  }));

  const totalRevenue = dashboardData.totalRevenue ?? 0;
  const monthlyRevenue = dashboardData.monthlyRevenue ?? 0;
  const totalAdmins = dashboardData.totalAdmins ?? 0;
  const newAdmins = dashboardData.newAdmins ?? 0;

  // Compute target achievement %
  const revenueArr = dashboardData.revenueVsTarget?.revenue ?? [];
  const targetArr = dashboardData.revenueVsTarget?.target ?? [];
  const totalActual = revenueArr.reduce((s, v) => s + (v ?? 0), 0);
  const totalTarget = targetArr.reduce((s, v) => s + (v ?? 0), 0);
  const targetAchievement = pct(totalActual, totalTarget);

  /* ── KPI cards ── */
  const kpis = [
    {
      label: "Total Revenue",
      value: fmtINR(totalRevenue),
      subValue: fmtINRFull(totalRevenue),
      delta: 12,
      positive: true,
      icon: FaRupeeSign,
      accent: "#3b82f6",
    },
    {
      label: "Monthly Revenue",
      value: fmtINR(monthlyRevenue),
      subValue: "This month",
      delta: 9,
      positive: true,
      icon: FaChartBar,
      accent: "#10b981",
    },
    {
      label: "Target Achievement",
      value: `${targetAchievement}%`,
      subValue: totalTarget > 0 ? `of ${fmtINR(totalTarget)}` : "No target set",
      delta: targetAchievement >= 80 ? targetAchievement - 70 : 80 - targetAchievement,
      positive: targetAchievement >= 80,
      icon: FaBullseye,
      accent: targetAchievement >= 80 ? "#10b981" : "#f59e0b",
    },
    {
      label: "Total Admins",
      value: totalAdmins,
      subValue: `${newAdmins} new this month`,
      delta: 8,
      positive: true,
      icon: FaUserTie,
      accent: "#8b5cf6",
    },
  ];

  /* ── Bar chart data ── */
  const days = dashboardData.revenueVsTarget?.days ?? [];
  const barData = days.map((d, i) => ({
    d,
    revenue: revenueArr[i] ?? 0,
    target: targetArr[i] ?? 0,
  }));

  /* ── Leaderboard ── */
  const leaderboard = dashboardData.branchLeaderboard.map((b) => ({
    branch: b.branchName,
    revenue: b.revenue,
    newMembers: b.newMembers,
  }));

  const chartTitle =
    selectedBranch === "all"
      ? "Revenue vs Target — Grouped Bar"
      : `Revenue vs Target — ${branchList.find((b) => b.id === selectedBranch)?.name || selectedBranch}`;

  /* ─────────── RENDER ─────────── */
  return (
    <>
      <style>{`
        /* Google Font */
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap');

        .powerbi-dash * { box-sizing: border-box; font-family: 'Inter', 'Segoe UI', sans-serif; }

        /* KPI grid */
        .pbi-kpi-grid {
          display: grid;
          grid-template-columns: repeat(2, 1fr);
          gap: 12px;
          margin-bottom: 20px;
        }
        @media (min-width: 1024px) {
          .pbi-kpi-grid { grid-template-columns: repeat(4, 1fr); gap: 16px; }
        }

        /* Charts row */
        .pbi-charts-row {
          display: grid;
          grid-template-columns: 1fr;
          gap: 16px;
          margin-bottom: 20px;
        }
        @media (min-width: 900px) {
          .pbi-charts-row { grid-template-columns: 3fr 2fr; }
        }

        /* Leaderboard table rows hover */
        .pbi-table-row:hover { background: #f8faff !important; }

        /* Achievement bar animation */
        .pbi-achieve-bar {
          height: 6px;
          border-radius: 4px;
          background: #e2e8f0;
          overflow: hidden;
          margin-top: 4px;
        }
        .pbi-achieve-fill {
          height: 100%;
          border-radius: 4px;
          transition: width 0.8s ease;
        }
      `}</style>

      <div
        className="powerbi-dash"
        style={{
          padding: isMobile ? "12px" : "20px",
          maxWidth: "1300px",
          margin: "0 auto",
        }}
      >

        {/* ── Header ── */}
        <div
          style={{
            display: "flex",
            alignItems: isMobile ? "flex-start" : "center",
            justifyContent: "space-between",
            flexDirection: isMobile ? "column" : "row",
            gap: "12px",
            marginBottom: "20px",
          }}
        >
          <div>
            <h2
              style={{
                fontSize: isMobile ? "20px" : "24px",
                fontWeight: "800",
                color: "#0f172a",
                margin: 0,
                letterSpacing: "-0.5px",
              }}
            >
              Analytics Dashboard
            </h2>
            <p style={{ fontSize: "13px", color: "#64748b", margin: "4px 0 0", fontWeight: "500" }}>
              Super Admin · Business Overview
            </p>
          </div>

          {/* Branch Filter */}
          <div
            style={{
              display: "flex",
              alignItems: "center",
              gap: "8px",
              background: "#f8fafc",
              border: "1px solid #e2e8f0",
              borderRadius: "10px",
              padding: "6px 10px",
            }}
          >
            <FaFilter size={11} color="#64748b" />
            <select
              style={{
                border: "none",
                background: "transparent",
                fontSize: "13px",
                color: "#0f172a",
                fontWeight: "600",
                cursor: "pointer",
                outline: "none",
                minWidth: "120px",
              }}
              value={selectedBranch}
              onChange={(e) => setSelectedBranch(e.target.value)}
            >
              <option value="all">All Branches</option>
              {branchList.map((b) => (
                <option key={b.id} value={b.id}>{b.name}</option>
              ))}
            </select>
          </div>
        </div>

        {/* ── KPI Cards ── */}
        <div className="pbi-kpi-grid">
          {kpis.map((k, i) => (
            <KpiCard key={i} {...k} isMobile={isMobile} />
          ))}
        </div>

        {/* ── Charts Row ── */}
        <div className="pbi-charts-row">

          {/* ── Grouped Bar Chart ── */}
          <div
            style={{
              background: "#fff",
              borderRadius: "16px",
              boxShadow: "0 2px 20px rgba(0,0,0,0.07)",
              border: "1px solid #f0f2f5",
              overflow: "hidden",
            }}
          >
            {/* Card header */}
            <div
              style={{
                padding: "16px 20px 12px",
                borderBottom: "1px solid #f1f5f9",
                display: "flex",
                alignItems: "center",
                justifyContent: "space-between",
                flexWrap: "wrap",
                gap: "8px",
              }}
            >
              <div style={{ display: "flex", alignItems: "center", gap: "10px" }}>
                <div
                  style={{
                    width: "32px",
                    height: "32px",
                    borderRadius: "8px",
                    background: "linear-gradient(135deg, #3b82f6, #1d4ed8)",
                    display: "flex",
                    alignItems: "center",
                    justifyContent: "center",
                    flexShrink: 0,
                  }}
                >
                  <FaChartBar size={14} color="#fff" />
                </div>
                <div>
                  <h3
                    style={{
                      fontSize: "14px",
                      fontWeight: "700",
                      color: "#0f172a",
                      margin: 0,
                    }}
                  >
                    {chartTitle}
                  </h3>
                  <span style={{ fontSize: "11px", color: "#94a3b8", fontWeight: "500" }}>
                    Daily performance · current period
                  </span>
                </div>
              </div>

              {/* Achievement pill */}
              <div
                style={{
                  display: "flex",
                  alignItems: "center",
                  gap: "6px",
                  background: targetAchievement >= 80 ? "#f0fdf4" : "#fffbeb",
                  border: `1px solid ${targetAchievement >= 80 ? "#bbf7d0" : "#fde68a"}`,
                  borderRadius: "20px",
                  padding: "4px 12px",
                  fontSize: "12px",
                  fontWeight: "700",
                  color: targetAchievement >= 80 ? "#16a34a" : "#d97706",
                }}
              >
                <FaBullseye size={10} />
                {targetAchievement}% achieved
              </div>
            </div>

            {/* Chart — wrapper MUST have explicit height for ResponsiveContainer to measure */}
            <div style={{ width: "100%", height: `${chartHeight}px`, padding: "12px 4px 0" }}>
              <ResponsiveContainer width="100%" height="100%">
                <BarChart
                  data={barData}
                  margin={{
                    top: 10,
                    right: 16,
                    left: isMobile ? 4 : 10,
                    bottom: 20,
                  }}
                  barCategoryGap="30%"
                  barGap={3}
                >
                  <CartesianGrid
                    strokeDasharray="3 3"
                    stroke="#f1f5f9"
                    vertical={false}
                  />
                  <XAxis
                    dataKey="d"
                    tick={{ fontSize: isMobile ? 9 : 11, fill: "#94a3b8", fontWeight: "600" }}
                    axisLine={{ stroke: "#e2e8f0" }}
                    tickLine={false}
                    interval="preserveStartEnd"
                    minTickGap={isMobile ? 20 : 14}
                  />
                  <YAxis
                    tick={{ fontSize: isMobile ? 9 : 11, fill: "#94a3b8", fontWeight: "600" }}
                    axisLine={false}
                    tickLine={false}
                    width={65}
                    domain={[0, "auto"]}
                    tickFormatter={(v) => {
                      if (v >= 100000) return `₹${(v / 100000).toFixed(1)}L`;
                      if (v >= 1000) return `₹${(v / 1000).toFixed(0)}k`;
                      return `₹${v}`;
                    }}
                  />
                  <Tooltip content={<BarTooltip />} cursor={{ fill: "rgba(59,130,246,0.05)" }} />
                  <Bar
                    dataKey="revenue"
                    name="Actual Revenue"
                    fill="#3b82f6"
                    radius={[4, 4, 0, 0]}
                    maxBarSize={isMobile ? 16 : 28}
                  />
                  <Bar
                    dataKey="target"
                    name="Target Revenue"
                    fill="#cbd5e1"
                    radius={[4, 4, 0, 0]}
                    maxBarSize={isMobile ? 16 : 28}
                  />
                </BarChart>
              </ResponsiveContainer>
            </div>

            {/* Legend rendered as HTML outside the SVG — never steals chart height */}
            <div
              style={{
                display: "flex",
                alignItems: "center",
                justifyContent: "center",
                gap: "20px",
                padding: "10px 16px 14px",
                flexWrap: "wrap",
              }}
            >
              {[
                { color: "#3b82f6", label: "Actual Revenue" },
                { color: "#cbd5e1", label: "Target Revenue" },
              ].map((item) => (
                <div
                  key={item.label}
                  style={{ display: "flex", alignItems: "center", gap: "6px" }}
                >
                  <div
                    style={{
                      width: "10px",
                      height: "10px",
                      borderRadius: "2px",
                      background: item.color,
                      flexShrink: 0,
                    }}
                  />
                  <span
                    style={{
                      fontSize: "11px",
                      fontWeight: "600",
                      color: "#64748b",
                    }}
                  >
                    {item.label}
                  </span>
                </div>
              ))}
            </div>
          </div>

          {/* ── Branch Leaderboard ── */}
          <div
            style={{
              background: "#fff",
              borderRadius: "16px",
              boxShadow: "0 2px 20px rgba(0,0,0,0.07)",
              border: "1px solid #f0f2f5",
              overflow: "hidden",
              display: "flex",
              flexDirection: "column",
            }}
          >
            {/* Header */}
            <div
              style={{
                padding: "16px 20px 12px",
                borderBottom: "1px solid #f1f5f9",
                display: "flex",
                alignItems: "center",
                gap: "10px",
              }}
            >
              <div
                style={{
                  width: "32px",
                  height: "32px",
                  borderRadius: "8px",
                  background: "linear-gradient(135deg, #f59e0b, #d97706)",
                  display: "flex",
                  alignItems: "center",
                  justifyContent: "center",
                  flexShrink: 0,
                }}
              >
                <FaTrophy size={14} color="#fff" />
              </div>
              <div>
                <h3 style={{ fontSize: "14px", fontWeight: "700", color: "#0f172a", margin: 0 }}>
                  Branch Leaderboard
                </h3>
                <span style={{ fontSize: "11px", color: "#94a3b8", fontWeight: "500" }}>
                  Performance ranking
                </span>
              </div>
            </div>

            {/* Table */}
            <div style={{ overflowY: "auto", flex: 1, maxHeight: `${chartHeight + 44}px` }}>
              {leaderboard.length === 0 ? (
                <div
                  style={{
                    display: "flex",
                    alignItems: "center",
                    justifyContent: "center",
                    height: "120px",
                    color: "#94a3b8",
                    fontSize: "13px",
                    fontWeight: "500",
                  }}
                >
                  No branch data available
                </div>
              ) : (
                leaderboard.map((r, i) => {
                  const bn = r.branch || r.branchName;
                  const isSelected = selectedBranch !== "all" && bn === selectedBranch;
                  const medal = i === 0 ? "🥇" : i === 1 ? "🥈" : i === 2 ? "🥉" : null;
                  const topRevenue = leaderboard[0]?.revenue || 1;
                  const barPct = Math.round((r.revenue / topRevenue) * 100);

                  return (
                    <div
                      key={i}
                      className="pbi-table-row"
                      style={{
                        padding: "12px 20px",
                        borderBottom: "1px solid #f8fafc",
                        background: isSelected ? "#eff6ff" : "transparent",
                        transition: "background 0.2s",
                      }}
                    >
                      <div
                        style={{
                          display: "flex",
                          alignItems: "center",
                          justifyContent: "space-between",
                          marginBottom: "6px",
                        }}
                      >
                        <div style={{ display: "flex", alignItems: "center", gap: "10px" }}>
                          <span style={{ fontSize: "16px", width: "24px" }}>
                            {medal || (
                              <span
                                style={{
                                  fontSize: "11px",
                                  fontWeight: "700",
                                  color: "#94a3b8",
                                  display: "inline-block",
                                  textAlign: "center",
                                  width: "20px",
                                }}
                              >
                                #{i + 1}
                              </span>
                            )}
                          </span>
                          <span
                            style={{
                              fontSize: "13px",
                              fontWeight: "700",
                              color: "#0f172a",
                            }}
                          >
                            {bn}
                          </span>
                        </div>
                        <div style={{ textAlign: "right" }}>
                          <div
                            style={{
                              fontSize: "13px",
                              fontWeight: "800",
                              color: "#16a34a",
                            }}
                          >
                            {fmtINR(r.revenue)}
                          </div>
                          <div
                            style={{
                              fontSize: "11px",
                              color: "#94a3b8",
                              fontWeight: "500",
                              marginTop: "1px",
                            }}
                          >
                            {r.newMembers} new members
                          </div>
                        </div>
                      </div>
                      {/* Revenue bar indicator */}
                      <div className="pbi-achieve-bar">
                        <div
                          className="pbi-achieve-fill"
                          style={{
                            width: `${barPct}%`,
                            background:
                              i === 0
                                ? "linear-gradient(90deg,#f59e0b,#fbbf24)"
                                : i === 1
                                ? "linear-gradient(90deg,#94a3b8,#cbd5e1)"
                                : "linear-gradient(90deg,#3b82f6,#60a5fa)",
                          }}
                        />
                      </div>
                    </div>
                  );
                })
              )}
            </div>
          </div>
        </div>

        {/* ── Summary footer strip ── */}
        <div
          style={{
            background: "linear-gradient(135deg, #0f172a 0%, #1e293b 100%)",
            borderRadius: "14px",
            padding: isMobile ? "14px 16px" : "16px 24px",
            display: "flex",
            alignItems: "center",
            justifyContent: "space-between",
            flexWrap: "wrap",
            gap: "12px",
          }}
        >
          {[
            { label: "Total Revenue", value: fmtINR(totalRevenue) },
            { label: "Monthly", value: fmtINR(monthlyRevenue) },
            { label: "Achievement", value: `${targetAchievement}%` },
            { label: "Admins", value: totalAdmins },
          ].map((item, i) => (
            <div key={i} style={{ textAlign: "center" }}>
              <div
                style={{
                  fontSize: isMobile ? "16px" : "20px",
                  fontWeight: "800",
                  color: "#fff",
                  letterSpacing: "-0.5px",
                }}
              >
                {item.value}
              </div>
              <div style={{ fontSize: "11px", color: "#64748b", fontWeight: "600", marginTop: "2px" }}>
                {item.label}
              </div>
            </div>
          ))}
        </div>
      </div>
    </>
  );
}