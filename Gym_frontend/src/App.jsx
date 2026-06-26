import { Route, Routes, useLocation, useParams, Navigate } from "react-router-dom";
import "./App.css";
import { useState, useEffect } from "react";
import * as echarts from "echarts";

import Navbar from "./Layout/Navbar";
import Login from "./Auth/Login";
import Signup from "./Auth/Signup";
import ForgotPassword from "./Auth/ForgotPassword";
import Sidebar from "./Layout/Sidebar";
import ProtectedRoute from "./Components/ProtectedRoute";
import ErrorBoundary from "./Components/ErrorBoundary";
// import DepartmentOKRs from "./Component/Okrs-management/Departement/DepartmentOKRs";
import AdminDashbaord from "./Dashboard/Admin/AdminDashbaord";
import MemberManagement from "./Dashboard/Manager/MemberManagement";
import StaffManagement from "./Dashboard//Manager/StaffManagement";
import ClassScheduling from "./Dashboard/Manager/ClassScheduling";
import Reports from "./Dashboard/Manager/Reports";
import Communication from "./Dashboard/Manager/Communication";
import Dashboard from "./Dashboard/Manager/Dashboard";



import Campaigns from "./Dashboard/Admin/Marketing/Campaigns";
import SuperAdminBranches from "./Dashboard/Admin/SuperAdminBranches";
import EmailsSms from "./Dashboard/Admin/Marketing/EmailsSms";
import ManageMembers from "./Dashboard/Admin/Members/ManageMembers";
import QrCodeAttendance from "./Dashboard/Admin/Members/QrCodeAttendance";
import WalkInRegistration from "./Dashboard/Admin/Members/WalkInRegistration";
import Membership from "./Dashboard/Admin/Payments/Membership";

import SalesReport from "./Dashboard/Admin/Reports/SalesReport";
import ManageStaff from "./Dashboard/Admin/Staff/ManageStaff";
import RolesPermissions from "./Dashboard/Admin/Staff/RolesPermissions";
import StaffAttendance from "./Dashboard/Admin/Staff/StaffAttendance";
import DutyRoster from "./Dashboard/Admin/Staff/DutyRoster";
import SalaryCalculator from "./Dashboard/Admin/Staff/SalaryCalculator";
import HouseKeepingDashboard from "./Dashboard/HouseKeeping/HouseKeepingDashboard";
import GeneralTrainerDashboard from "./Dashboard/GeneralTrainer/GeneralTrainerDashboard";
import GeneralQrCheckin from "./Dashboard/GeneralTrainer/GeneralQrCheckin";
import MemberDashboard from "./Dashboard/Member/MemberDashboard";
import Account from "./Dashboard/Member/Account";
// import MemberBooking from "./Dashboard/Member/MemberBooking";
import MemberQrCheckin from "./Dashboard/Member/MemberQrCheckin";
import ClassSchedule from "./Dashboard/Member/ClassSchedule";
import Report from "./Dashboard/GeneralTrainer/Report"

import AttendanceHistory from "./Dashboard/Member/AttendanceHistory";

import ReceptionistDashboard from "./Dashboard/Receptionist/ReceptionistDashboard";
import NewReceptionistDashboard from "./Dashboard/Receptionist/NewReceptionistDashboard";


// import PersonalTrainerAssignedMembers from "./Dashboard/PersonalTrainer/PersonalTrainerAssignedMembers";

import PersonalTrainerMessages from "./Dashboard/PersonalTrainer/PersonalTrainerMessages";
import PersonalTrainerGroupClasses from "./Dashboard/PersonalTrainer/PersonalTrainerGroupClasses";

import PersonalTrainerDashboard from "./Dashboard/PersonalTrainer/PersonalTrainerDashboard";
import PersonalTrainerQrCheckin from "./Dashboard/PersonalTrainer/PersonsalTrainerQrCheckin"

import Attendance from "./Dashboard/GeneralTrainer/Attendance";
// import MemberInteraction from "./Dashboard/GeneralTrainer/MemberInteraction";
import DailyScedule from "./Dashboard/GeneralTrainer/DailyScedule";

import HouseKeepingDutyRoster from "./Dashboard/HouseKeeping/HouseKeepingDutyRoster";
import HouseKeepingAttendance from "./Dashboard/HouseKeeping/HouseKeepingAttendance";
import HouseKeepingTaskChecklist from "./Dashboard/HouseKeeping/HouseKeepingTaskChecklist";
import HouseKeepingNotifications from "./Dashboard/HouseKeeping/HouseKeepingNotifications";
import HouseKeepingQrCheckin from "./Dashboard/HouseKeeping/HouseKeepingQrCheckin";
// import HouseKeepingDutyRosters from "./Dashboard/HouseKeeping/HouseKeepingQDutyRoster";
import ReceptionistWalkinMember from "./Dashboard/Receptionist/ReceptionistWalkinMember"
import ReceptionistMembershipSignups from "./Dashboard/Receptionist/ReceptionistMembershipSignups";
import HousekeepingShiftView from "./Dashboard/HouseKeeping/HousekeepingShiftView";
import HousekeepingTask from "./Dashboard/HouseKeeping/HousekeepingTask";

import ReceptionistQrCheckin from "./Dashboard/Receptionist/ReceptionistQrCheckin";
import ReceptionistQRCode from "./Dashboard/Receptionist/ReceptionistQRCode";
import ReceptionistPaymentCollection from "./Dashboard/Receptionist/ReceptionistPaymentCollection"
import ReceptionistBookGroupClasses from "./Dashboard/Receptionist/ReceptionistBookGroupClasses"
import BranchManagement from "./Dashboard/Admin/Settings/BranchManagement";
import RoleManagement from "./Dashboard/Admin/Settings/RoleManagement";




import SuperAdminOwner from "./Dashboard/SuperAdmin/SuperAdminAdmin";
import Plans from "./Dashboard/SuperAdmin/Plans";
// import Marketing from "./Dashboard/SuperAdmin/Marketing";
// import Staff from "./Dashboard/SuperAdmin/People/Staff";
// import Members from "./Dashboard/SuperAdmin/People/Members";
// import Invoices from "./Dashboard/SuperAdmin/Payments/Invoices";
import Payments from "./Dashboard/SuperAdmin/Payments";
// import Request from "./Dashboard/SuperAdmin/Request";
import Request from "./Dashboard/SuperAdmin/Requestplan";
import ManageSubAdmins from "./Dashboard/SuperAdmin/ManageSubAdmins";
import Announcements from "./Dashboard/SuperAdmin/Announcements";






// import RazorpayReports from "./Dashboard/SuperAdmin/Payments/RazorpayReports";
// import SalesReports from "./Dashboard/SuperAdmin/Reports/SalesReports";
// import MembershipReports from "./Dashboard/SuperAdmin/Reports/Membershipreports";
// import AttendanceReports from "./Dashboard/SuperAdmin/Reports/AttendanceReports";
import Groups from "./Dashboard/Admin/Groups";
import ClassesSchedule from "./Dashboard/Admin/ClassesSchedule";
import AttendanceReport from "./Dashboard/Admin/Reports/AttendanceReport";
import LendingPage from "./Website/LendingPage";
import PersonalTrainerSessionBookings from "./Dashboard/Admin/Bookings/PersonalTrainerSessionBookings";
import CreatePlan from "./Dashboard/Admin/CreatePlan";
import ViewPlan from "./Dashboard/Member/ViewPlan";
import PersonalPlansBookings from "./Dashboard/PersonalTrainer/PersonalPlansBookings";
import GroupPlansBookings from "./Dashboard/GeneralTrainer/GroupPlansBookings";

// new import 
import AdminMember from "./Dashboard/Admin/AdminMember";
import PersonalTraining from "./Dashboard/Admin/Bookings/PersonalTraining";
import QrCheckin from "./Dashboard/Admin/qrcheckin";
import Setting from "./Dashboard/SuperAdmin/Setting";
import DashboardHomePage from "./Dashboard/SuperAdmin/SuperAdminDashbaord";
import ShiftManagement from "./Dashboard/Admin/ShiftMangamenet";
import AdminTaskManagement from "./Dashboard/Admin/AdminTaskManagement";
import PersonalAttendance from "./Dashboard/PersonalTrainer/PersonalAttendance";
import AdminSetting from "./Dashboard/Admin/AdminSetting";
import AdminMySubscription from "./Dashboard/Admin/AdminMySubscription";
import DynamicPage from "./Layout/DynamicPage";
import RequestPlan from "./Dashboard/Member/RequestsPlan";
import PersonalTrainerClassesSchedule from "./Dashboard/PersonalTrainer/PersonalTrainerClassesSchedule";
import GeneralClassesSchedule from "./Dashboard/GeneralTrainer/GeneralClassesSchedule";
import PersonalSessionBooking from "./Dashboard/PersonalTrainer/PersonalSessionBooking";
import GeneralSessionBooking from "./Dashboard/GeneralTrainer/GeneralSessionBooking";
import PersonsalTrainerShiftManagement from "./Dashboard/PersonalTrainer/PersonsalTrainerShiftManagement";
import GeneralTrainerShiftManagement from "./Dashboard/GeneralTrainer/GeneralTrainerShiftManagement";
import HouseKeepingShiftManagement from "./Dashboard/HouseKeeping/HouseKeepingShiftManagement";
import MemberAttendance from "./Dashboard/Member/MemberAttendance";
import ReportsAttendance from "./Dashboard/Receptionist/ReportsAttendance";
import ReportsClasses from "./Dashboard/Receptionist/ReportsClasses";
import PersonsalReportsClasses from "./Dashboard/PersonalTrainer/PersonsalReportsClasses";
import ReceptionistHouseKeepingAttendanceCheckOut from "./Dashboard/Receptionist/ReceptionistHouseKeepingAttendanceCheckOut";
import MemberAllPlans from "./Dashboard/Member/MemberAllPlans";
import Leads from "./Dashboard/Receptionist/Leads";
import MemberHealthLog from "./Dashboard/Member/MemberHealthLog";
import MemberLeaderboard from "./Dashboard/Member/MemberLeaderboard";
import TrainerHealthLog from "./Dashboard/PersonalTrainer/TrainerHealthLog";
import DietBuilder from "./Dashboard/PersonalTrainer/DietBuilder";
import MyDietPlan from "./Dashboard/Member/MyDietPlan";
import TrainerAssessmentForm from "./Components/Assessment/TrainerAssessmentForm";
import BodybuilderAssessmentForm from "./Components/Assessment/BodybuilderAssessmentForm";
import MemberAssessmentDashboard from "./Components/Assessment/MemberAssessmentDashboard";
import ClientAssessmentList from "./Components/Assessment/ClientAssessmentList";
import InventoryManagement from "./Dashboard/Admin/Inventory/InventoryManagement";
import AttendanceAlerts from "./Dashboard/Admin/AttendanceAlerts";
import AdminAnnouncements from "./Dashboard/Admin/AdminAnnouncements";
import WorkoutBuilder from "./Dashboard/PersonalTrainer/WorkoutBuilder";
import MemberWorkoutLog from "./Dashboard/Member/MemberWorkoutLog";
import AnnouncementsList from "./Components/AnnouncementsList";
import AutomationSettings from "./Dashboard/SuperAdmin/AutomationSettings";
import NotificationCredits from "./Dashboard/Admin/NotificationCredits";

// Wrapper to extract memberId from URL params
const MemberAssessmentWrapper = () => {
  const { memberId } = useParams();
  return <MemberAssessmentDashboard memberId={parseInt(memberId)} />;
};

function App() {
  const [isSidebarCollapsed, setIsSidebarCollapsed] = useState(false);

  useEffect(() => {
    const checkIfMobile = () => window.innerWidth <= 768;
    if (checkIfMobile()) {
      setIsSidebarCollapsed(true);
    }
  }, []);

  const toggleSidebar = () => {
    setIsSidebarCollapsed((prev) => !prev);
  };

  const location = useLocation();

  const isDynamicPage =
    /^\/[^\/]+\/\d+$/.test(location.pathname) ||  // /gym/90
    /^\/\d+$/.test(location.pathname);             // /90

  const hideLayout =
    location.pathname === "/" ||
    location.pathname === "/login" ||
    location.pathname === "/signup" ||
    location.pathname === "/forgot-password" ||
    isDynamicPage;



  return (
    <>
      {hideLayout ? (
        <Routes>
          <Route path="/login" element={<Login />} />
          <Route path="/signup" element={<Signup />} />
          <Route path="/forgot-password" element={<ForgotPassword />} />
          <Route path="/" element={<LendingPage />} />
          <Route path="/:slug/:adminId" element={<DynamicPage />} />
          <Route path="/:adminId" element={<DynamicPage />} />
        </Routes>
      ) : (
        <>
          <Navbar toggleSidebar={toggleSidebar} />
          <div className="main-content">
            <Sidebar
              collapsed={isSidebarCollapsed}
              setCollapsed={setIsSidebarCollapsed}
            />
            <div
              className={`right-side-content ${isSidebarCollapsed ? "collapsed" : ""
                }`}
            >
              <ErrorBoundary>
                <Routes>

                  <Route path="/superadmin/dashboard" element={<ProtectedRoute allowedRoles={["SUPERADMIN", "SUBADMIN"]}><DashboardHomePage /></ProtectedRoute>} />
                  <Route path="/superadmin/Admin" element={<ProtectedRoute allowedRoles={["SUPERADMIN", "SUBADMIN"]}><SuperAdminOwner /></ProtectedRoute>} />
                  <Route path="/superadmin/Plans&Pricing" element={<ProtectedRoute allowedRoles={["SUPERADMIN", "SUBADMIN"]}><Plans /></ProtectedRoute>} />
                  <Route path="superadmin/payments" element={<ProtectedRoute allowedRoles={["SUPERADMIN", "SUBADMIN"]}><Payments /></ProtectedRoute>} />
                  <Route path="/superadmin/setting" element={<ProtectedRoute allowedRoles={["SUPERADMIN", "SUBADMIN"]}><Setting /></ProtectedRoute>} />
                  <Route path="/superadmin/request-plan" element={<ProtectedRoute allowedRoles={["SUPERADMIN", "SUBADMIN"]}><Request /></ProtectedRoute>} />
                  <Route path="/superadmin/subadmins" element={<ProtectedRoute allowedRoles={["SUPERADMIN", "SUBADMIN"]}><ManageSubAdmins /></ProtectedRoute>} />
                  <Route path="/superadmin/announcements" element={<ProtectedRoute allowedRoles={["SUPERADMIN", "SUBADMIN"]}><Announcements /></ProtectedRoute>} />
                  <Route path="/superadmin/automation-settings" element={<ProtectedRoute allowedRoles={["SUPERADMIN"]}><AutomationSettings /></ProtectedRoute>} />
                  <Route path="/admin/dashboard" element={<ProtectedRoute allowedRoles={["ADMIN", "SUPERADMIN"]}><AdminDashbaord /></ProtectedRoute>} />
                  <Route path="/admin/admindashboard" element={<ProtectedRoute allowedRoles={["ADMIN", "SUPERADMIN"]}><AdminDashbaord /></ProtectedRoute>} />
                  <Route path="/admin/notification-credits" element={<ProtectedRoute allowedRoles={["ADMIN", "SUPERADMIN"]}><NotificationCredits /></ProtectedRoute>} />
                  <Route path="/admin/group" element={<ProtectedRoute allowedRoles={["ADMIN", "SUPERADMIN"]}><Groups /></ProtectedRoute>} />
                  <Route path="/admin/CreatePlan" element={<ProtectedRoute allowedRoles={["ADMIN", "SUPERADMIN"]}><CreatePlan /></ProtectedRoute>} />
                  <Route path="/admin/createplan" element={<ProtectedRoute allowedRoles={["ADMIN", "SUPERADMIN"]}><CreatePlan /></ProtectedRoute>} />

                  {/* admin dahsboard */}
                  <Route path="/admin/admin-dashboard" element={<ProtectedRoute allowedRoles={["ADMIN", "SUPERADMIN"]}><AdminDashbaord /></ProtectedRoute>} />
                  <Route path="/admin/qrcheckin" element={<ProtectedRoute allowedRoles={["ADMIN", "SUPERADMIN"]}><QrCheckin /></ProtectedRoute>} />
                  <Route path="/admin/AdminMember" element={<ProtectedRoute allowedRoles={["ADMIN", "SUPERADMIN", "GENERALTRAINER", "PERSONALTRAINER", "SALES_AGENT"]}><AdminMember /></ProtectedRoute>} />
                  <Route path="/admin/member-assessment/:memberId" element={<ProtectedRoute allowedRoles={["ADMIN", "SUPERADMIN"]}><MemberAssessmentWrapper /></ProtectedRoute>} />

                  {/* booking */}
                  <Route path="/admin/booking/attendance" element={<ProtectedRoute allowedRoles={["ADMIN", "SUPERADMIN"]}><AttendanceReport /></ProtectedRoute>} />
                  <Route path="/admin/booking/personal-training" element={<ProtectedRoute allowedRoles={["ADMIN", "SUPERADMIN"]}><PersonalTraining /></ProtectedRoute>} />
                  <Route path="/admin/AdminBranches" element={<ProtectedRoute allowedRoles={["ADMIN", "SUPERADMIN", "SUBADMIN"]}><SuperAdminBranches /></ProtectedRoute>} />
                  <Route path="/admin/ClassesSchedule" element={<ProtectedRoute allowedRoles={["ADMIN", "SUPERADMIN"]}><ClassesSchedule /></ProtectedRoute>} />
                  <Route path="/admin/classesSchedule" element={<ProtectedRoute allowedRoles={["ADMIN", "SUPERADMIN"]}><ClassesSchedule /></ProtectedRoute>} />
                  <Route path="/admin/bookings" element={<ProtectedRoute allowedRoles={["ADMIN", "SUPERADMIN"]}><PersonalTrainerSessionBookings /></ProtectedRoute>} />

                  {/* Marketibg */}
                  <Route path="/marketing/campaigns" element={<ProtectedRoute allowedRoles={["ADMIN", "SUPERADMIN"]}><Campaigns /></ProtectedRoute>} />
                  <Route path="/marketing/email-sms" element={<ProtectedRoute allowedRoles={["ADMIN", "SUPERADMIN"]}><EmailsSms /></ProtectedRoute>} />

                  {/* Members */}
                  <Route path="/admin/members/manage-members" element={<ProtectedRoute allowedRoles={["ADMIN", "SUPERADMIN"]}><ManageMembers /></ProtectedRoute>} />
                  <Route path="/admin/members/qr-code-attendance" element={<ProtectedRoute allowedRoles={["ADMIN", "SUPERADMIN", "RECEPTIONIST"]}><QrCodeAttendance /></ProtectedRoute>} />
                  <Route path="/admin/members/walk-in-registration" element={<ProtectedRoute allowedRoles={["ADMIN", "SUPERADMIN", "RECEPTIONIST"]}><WalkInRegistration /></ProtectedRoute>} />

                  {/* Payments Routes */}
                  <Route path="/admin/payments/membership" element={<ProtectedRoute allowedRoles={["ADMIN", "SUPERADMIN"]}><Membership /></ProtectedRoute>} />

                  {/* Reports  */}
                  <Route path="/admin/reports/sales" element={<ProtectedRoute allowedRoles={["ADMIN", "SUPERADMIN", "MANAGER"]}><SalesReport /></ProtectedRoute>} />
                  <Route path="/admin/reports/AttendanceReport" element={<ProtectedRoute allowedRoles={["ADMIN", "SUPERADMIN", "MANAGER"]}><AttendanceReport /></ProtectedRoute>} />

                  {/* Staff Routes */}
                  <Route path="/admin/staff/manage-staff" element={<ProtectedRoute allowedRoles={["ADMIN", "SUPERADMIN"]}><ManageStaff /></ProtectedRoute>} />
                  <Route path="/admin/staff/roles-permissions" element={<ProtectedRoute allowedRoles={["ADMIN", "SUPERADMIN"]}><RolesPermissions /></ProtectedRoute>} />
                  <Route path="/admin/staff/attendance" element={<ProtectedRoute allowedRoles={["ADMIN", "SUPERADMIN"]}><StaffAttendance /></ProtectedRoute>} />
                  <Route path="/admin/staff/duty-roster" element={<ProtectedRoute allowedRoles={["ADMIN", "SUPERADMIN"]}><DutyRoster /></ProtectedRoute>} />
                  <Route path="/staff/salary-calculator" element={<ProtectedRoute allowedRoles={["ADMIN", "SUPERADMIN", "RECEPTIONIST"]}><SalaryCalculator /></ProtectedRoute>} />
                  <Route path="/admin/shift-managment" element={<ProtectedRoute allowedRoles={["ADMIN", "SUPERADMIN"]}><ShiftManagement /></ProtectedRoute>} />
                  <Route path="/admin/task-managment" element={<ProtectedRoute allowedRoles={["ADMIN", "SUPERADMIN"]}><AdminTaskManagement /></ProtectedRoute>} />
                  <Route path="/admin/inventory" element={<ProtectedRoute allowedRoles={["ADMIN", "SUPERADMIN", "MANAGER", "GENERALTRAINER", "PERSONALTRAINER", "SALES_AGENT"]}><InventoryManagement /></ProtectedRoute>} />
                  <Route path="/admin/at-risk-members" element={<ProtectedRoute allowedRoles={["ADMIN", "SUPERADMIN", "MANAGER", "SALES_AGENT"]}><AttendanceAlerts /></ProtectedRoute>} />
                  <Route path="/admin/announcements" element={<ProtectedRoute allowedRoles={["ADMIN", "SUPERADMIN", "MANAGER"]}><AdminAnnouncements /></ProtectedRoute>} />
                  {/* setting routes */}
                  <Route path="/admin/settings/BranchManagement" element={<ProtectedRoute allowedRoles={["ADMIN", "SUPERADMIN"]}><BranchManagement /></ProtectedRoute>} />
                  <Route path="/admin/settings/RoleManagement" element={<ProtectedRoute allowedRoles={["ADMIN", "SUPERADMIN"]}><RoleManagement /></ProtectedRoute>} />
                  <Route path="/admin/my-subscription" element={<ProtectedRoute allowedRoles={["ADMIN", "SUPERADMIN"]}><AdminMySubscription /></ProtectedRoute>} />
                  <Route path="/admin/settings" element={<ProtectedRoute allowedRoles={["ADMIN", "SUPERADMIN"]}><AdminSetting /></ProtectedRoute>} />

                  {/* admin dahsboard end */}

                  {/* Manager Dashbaord */}
                  <Route path="/manager/dashboard" element={<ProtectedRoute allowedRoles={["MANAGER", "ADMIN", "SUPERADMIN"]}><Dashboard /></ProtectedRoute>} />
                  <Route path="/manager/members" element={<ProtectedRoute allowedRoles={["MANAGER", "ADMIN", "SUPERADMIN"]}><MemberManagement /></ProtectedRoute>} />
                  {/* <Route path="/manager/membership-plan" element={<MembershipPlans />} /> */}
                  <Route path="/manager/duty-roster" element={<ProtectedRoute allowedRoles={["MANAGER", "ADMIN", "SUPERADMIN"]}><StaffManagement /></ProtectedRoute>} />
                  <Route path="/manager/class-schedule" element={<ProtectedRoute allowedRoles={["MANAGER", "ADMIN", "SUPERADMIN"]}><ClassScheduling /></ProtectedRoute>} />
                  <Route path="/manager/reports" element={<ProtectedRoute allowedRoles={["MANAGER", "ADMIN", "SUPERADMIN"]}><Reports /></ProtectedRoute>} />
                  <Route path="/manager/communication" element={<ProtectedRoute allowedRoles={["MANAGER", "ADMIN", "SUPERADMIN"]}><Communication /></ProtectedRoute>} />
                  <Route path="/housekeeping/dashboard" element={<ProtectedRoute allowedRoles={["HOUSEKEEPING", "ADMIN", "SUPERADMIN"]}><HouseKeepingDashboard /></ProtectedRoute>} />

                  <Route path="/generaltrainer/dashboard" element={<ProtectedRoute allowedRoles={["GENERALTRAINER", "ADMIN", "SUPERADMIN"]}><GeneralTrainerDashboard /></ProtectedRoute>} />
                  <Route path="/generaltrainer/health-log" element={<ProtectedRoute allowedRoles={["GENERALTRAINER", "ADMIN", "SUPERADMIN"]}><TrainerHealthLog /></ProtectedRoute>} />
                  <Route path="/generaltrainer/diet-builder" element={<ProtectedRoute allowedRoles={["GENERALTRAINER", "ADMIN", "SUPERADMIN"]}><DietBuilder /></ProtectedRoute>} />
                  <Route path="/generaltrainer/workout-builder" element={<ProtectedRoute allowedRoles={["GENERALTRAINER", "ADMIN", "SUPERADMIN"]}><WorkoutBuilder /></ProtectedRoute>} />
                  <Route path="/generaltrainer/classesschedule" element={<ProtectedRoute allowedRoles={["GENERALTRAINER", "ADMIN", "SUPERADMIN"]}><GeneralClassesSchedule /></ProtectedRoute>} />
                  <Route path="/generaltrainer/bookings" element={<ProtectedRoute allowedRoles={["GENERALTRAINER", "ADMIN", "SUPERADMIN"]}><GeneralSessionBooking /></ProtectedRoute>} />
                  <Route path="/GeneralTrainer/attendance" element={<ProtectedRoute allowedRoles={["GENERALTRAINER", "ADMIN", "SUPERADMIN"]}><Attendance /></ProtectedRoute>} />
                  <Route path="/generaltrainer/attendance" element={<ProtectedRoute allowedRoles={["GENERALTRAINER", "ADMIN", "SUPERADMIN"]}><Attendance /></ProtectedRoute>} />
                  <Route path="/GeneralTrainer/shift-managment" element={<ProtectedRoute allowedRoles={["GENERALTRAINER", "ADMIN", "SUPERADMIN"]}><GeneralTrainerShiftManagement /></ProtectedRoute>} />
                  {/* <Route path="/GeneralTrainer/MemberInteraction" element={<MemberInteraction />} /> */}
                  <Route path="/GeneralTrainer/qrcheckin" element={<ProtectedRoute allowedRoles={["GENERALTRAINER", "ADMIN", "SUPERADMIN"]}><GeneralQrCheckin /></ProtectedRoute>} />
                  <Route path="/generaltrainer/qrcheckin" element={<ProtectedRoute allowedRoles={["GENERALTRAINER", "ADMIN", "SUPERADMIN"]}><GeneralQrCheckin /></ProtectedRoute>} />
                  <Route path="/GeneralTrainer/Reports" element={<ProtectedRoute allowedRoles={["GENERALTRAINER", "ADMIN", "SUPERADMIN"]}><Report /></ProtectedRoute>} />
                  <Route path="/generaltrainer/Reports" element={<ProtectedRoute allowedRoles={["GENERALTRAINER", "ADMIN", "SUPERADMIN"]}><Report /></ProtectedRoute>} />
                  <Route path="/GeneralTrainer/DailyScedule" element={<ProtectedRoute allowedRoles={["GENERALTRAINER", "ADMIN", "SUPERADMIN"]}><DailyScedule /></ProtectedRoute>} />
                  <Route path="/GeneralTrainer/GroupPlansBookings" element={<ProtectedRoute allowedRoles={["GENERALTRAINER", "ADMIN", "SUPERADMIN"]}><GroupPlansBookings /></ProtectedRoute>} />
                  <Route path="/generaltrainer/groupplansbookings" element={<ProtectedRoute allowedRoles={["GENERALTRAINER", "ADMIN", "SUPERADMIN"]}><GroupPlansBookings /></ProtectedRoute>} />

                  <Route path="/member/dashboard" element={<ProtectedRoute allowedRoles={["MEMBER", "ADMIN"]}><MemberDashboard /></ProtectedRoute>} />
                  <Route path="/member/assessment-dashboard" element={<ProtectedRoute allowedRoles={["MEMBER", "ADMIN"]}><MemberAssessmentDashboard memberId={146} /></ProtectedRoute>} />
                  <Route path="/member/health-log" element={<ProtectedRoute allowedRoles={["MEMBER", "ADMIN"]}><MemberHealthLog /></ProtectedRoute>} />
                  <Route path="/member/leaderboard" element={<ProtectedRoute allowedRoles={["MEMBER", "ADMIN"]}><MemberLeaderboard /></ProtectedRoute>} />
                  <Route path="/leaderboard" element={<ProtectedRoute allowedRoles={["MEMBER", "ADMIN", "SUPERADMIN", "PERSONALTRAINER", "GENERALTRAINER", "MANAGER"]}><MemberLeaderboard /></ProtectedRoute>} />
                  <Route path="/member/my-diet" element={<ProtectedRoute allowedRoles={["MEMBER", "ADMIN"]}><MyDietPlan /></ProtectedRoute>} />
                  <Route path="/member/my-workouts" element={<ProtectedRoute allowedRoles={["MEMBER", "ADMIN"]}><MemberWorkoutLog /></ProtectedRoute>} />
                  <Route path="/account" element={<ProtectedRoute><Account /></ProtectedRoute>} />
                  <Route path="/member/classschedule" element={<ProtectedRoute allowedRoles={["MEMBER", "ADMIN"]}><ClassSchedule /></ProtectedRoute>} />
                  <Route path="/member/attendance-history" element={<ProtectedRoute allowedRoles={["MEMBER", "ADMIN"]}><AttendanceHistory /></ProtectedRoute>} />
                  <Route path="/member/qrcheckin" element={<ProtectedRoute allowedRoles={["MEMBER", "ADMIN"]}><MemberQrCheckin /></ProtectedRoute>} />
                  <Route path="/member/memberattendance" element={<ProtectedRoute allowedRoles={["MEMBER", "ADMIN"]}><MemberAttendance /></ProtectedRoute>} />
                  <Route path="/member/viewplan" element={<ProtectedRoute allowedRoles={["MEMBER", "ADMIN"]}><ViewPlan /></ProtectedRoute>} />
                  <Route path="/member/requestplan" element={<ProtectedRoute allowedRoles={["MEMBER", "ADMIN"]}><RequestPlan /></ProtectedRoute>} />
                  <Route path="/member/allplans" element={<ProtectedRoute allowedRoles={["MEMBER", "ADMIN"]}><MemberAllPlans /></ProtectedRoute>} />
                  <Route path="/member/announcements" element={<ProtectedRoute allowedRoles={["MEMBER", "ADMIN"]}><AnnouncementsList roleGroup="MEMBERS" /></ProtectedRoute>} />
                  {/* <Route path="/member/memberbooking" element={<MemberBooking />} /> */}
                  {/* ── Receptionist Routes (/receptionist/*) ── */}
                  <Route path="/receptionist/dashboard" element={<ProtectedRoute allowedRoles={["RECEPTIONIST"]}><NewReceptionistDashboard /></ProtectedRoute>} />
                  <Route path="/receptionist/walk-in-registration" element={<ProtectedRoute allowedRoles={["RECEPTIONIST"]}><ReceptionistWalkinMember /></ProtectedRoute>} />
                  <Route path="/receptionist/leads" element={<ProtectedRoute allowedRoles={["RECEPTIONIST"]}><Leads /></ProtectedRoute>} />
                  <Route path="/receptionist/members" element={<ProtectedRoute allowedRoles={["RECEPTIONIST"]}><AdminMember /></ProtectedRoute>} />
                  <Route path="/receptionist/at-risk-members" element={<ProtectedRoute allowedRoles={["RECEPTIONIST"]}><AttendanceAlerts /></ProtectedRoute>} />
                  <Route path="/receptionist/classes-schedule" element={<ProtectedRoute allowedRoles={["RECEPTIONIST"]}><ClassesSchedule /></ProtectedRoute>} />
                  <Route path="/receptionist/session-bookings" element={<ProtectedRoute allowedRoles={["RECEPTIONIST"]}><ReceptionistBookGroupClasses /></ProtectedRoute>} />
                  <Route path="/receptionist/qrcheckin" element={<ProtectedRoute allowedRoles={["RECEPTIONIST"]}><ReceptionistQrCheckin /></ProtectedRoute>} />
                  <Route path="/receptionist/qr-attendance" element={<ProtectedRoute allowedRoles={["RECEPTIONIST"]}><ReceptionistQRCode /></ProtectedRoute>} />
                  <Route path="/receptionist/payment" element={<ProtectedRoute allowedRoles={["RECEPTIONIST"]}><ReceptionistPaymentCollection /></ProtectedRoute>} />
                  <Route path="/receptionist/renewals" element={<ProtectedRoute allowedRoles={["RECEPTIONIST"]}><ReportsAttendance /></ProtectedRoute>} />
                  <Route path="/receptionist/inventory" element={<ProtectedRoute allowedRoles={["RECEPTIONIST"]}><InventoryManagement /></ProtectedRoute>} />
                  <Route path="/receptionist/task-management" element={<ProtectedRoute allowedRoles={["RECEPTIONIST"]}><AdminTaskManagement /></ProtectedRoute>} />
                  <Route path="/receptionist/announcements" element={<ProtectedRoute allowedRoles={["RECEPTIONIST"]}><AnnouncementsList roleGroup="STAFF" /></ProtectedRoute>} />

                  {/* ── Sales Agent Routes (/sales/*) ── */}
                  <Route path="/sales/dashboard" element={<ProtectedRoute allowedRoles={["SALES_AGENT", "ADMIN", "SUPERADMIN"]}><ReceptionistDashboard /></ProtectedRoute>} />
                  <Route path="/admin/leads" element={<ProtectedRoute allowedRoles={["ADMIN", "SUPERADMIN", "SUBADMIN"]}><Leads /></ProtectedRoute>} />
                  <Route path="/sales/leads" element={<ProtectedRoute allowedRoles={["SALES_AGENT"]}><Leads /></ProtectedRoute>} />
                  <Route path="/sales/walk-in-registration" element={<ProtectedRoute allowedRoles={["SALES_AGENT", "ADMIN", "SUPERADMIN"]}><ReceptionistWalkinMember /></ProtectedRoute>} />
                  <Route path="/sales/new-sign-ups" element={<ProtectedRoute allowedRoles={["SALES_AGENT", "ADMIN", "SUPERADMIN"]}><ReceptionistMembershipSignups /></ProtectedRoute>} />
                  <Route path="/sales/qr-attendance" element={<ProtectedRoute allowedRoles={["SALES_AGENT", "ADMIN", "SUPERADMIN"]}><ReceptionistQRCode /></ProtectedRoute>} />
                  <Route path="/sales/qrcheckin" element={<ProtectedRoute allowedRoles={["SALES_AGENT", "ADMIN", "SUPERADMIN"]}><ReceptionistQrCheckin /></ProtectedRoute>} />
                  <Route path="/sales/book-classes-sessions" element={<ProtectedRoute allowedRoles={["SALES_AGENT", "ADMIN", "SUPERADMIN"]}><ReceptionistBookGroupClasses /></ProtectedRoute>} />
                  <Route path="/sales/payment" element={<ProtectedRoute allowedRoles={["SALES_AGENT", "ADMIN", "SUPERADMIN"]}><ReceptionistPaymentCollection /></ProtectedRoute>} />
                  <Route path="/sales/payemnet" element={<Navigate to="/sales/payment" replace />} />
                  <Route path="/sales/reportattendance" element={<ProtectedRoute allowedRoles={["SALES_AGENT", "ADMIN", "SUPERADMIN"]}><ReportsAttendance /></ProtectedRoute>} />
                  <Route path="/sales/report-attendance-checkout" element={<ProtectedRoute allowedRoles={["SALES_AGENT", "ADMIN", "SUPERADMIN"]}><ReceptionistHouseKeepingAttendanceCheckOut /></ProtectedRoute>} />
                  <Route path="/sales/report" element={<ProtectedRoute allowedRoles={["SALES_AGENT", "ADMIN", "SUPERADMIN"]}><ReportsClasses /></ProtectedRoute>} />

                  <Route path="/personaltrainer/dashboard" element={<ProtectedRoute allowedRoles={["PERSONALTRAINER", "ADMIN", "SUPERADMIN"]}><PersonalTrainerDashboard /></ProtectedRoute>} />
                  <Route path="/personaltrainer/assessment-form" element={<ProtectedRoute allowedRoles={["PERSONALTRAINER", "ADMIN", "SUPERADMIN", "GENERALTRAINER"]}><TrainerAssessmentForm /></ProtectedRoute>} />
                  <Route path="/bodybuilder-assessment" element={<ProtectedRoute allowedRoles={["PERSONALTRAINER", "ADMIN", "SUPERADMIN", "GENERALTRAINER"]}><BodybuilderAssessmentForm /></ProtectedRoute>} />
                  <Route path="/personaltrainer/client-progress" element={<ProtectedRoute allowedRoles={["PERSONALTRAINER", "ADMIN", "SUPERADMIN", "GENERALTRAINER"]}><ClientAssessmentList /></ProtectedRoute>} />
                  <Route path="/personaltrainer/member-assessment/:memberId" element={<ProtectedRoute allowedRoles={["PERSONALTRAINER", "ADMIN", "SUPERADMIN", "GENERALTRAINER"]}><MemberAssessmentWrapper /></ProtectedRoute>} />
                  <Route path="/personaltrainer/health-log" element={<ProtectedRoute allowedRoles={["PERSONALTRAINER", "ADMIN", "SUPERADMIN"]}><TrainerHealthLog /></ProtectedRoute>} />
                  <Route path="/personaltrainer/diet-builder" element={<ProtectedRoute allowedRoles={["PERSONALTRAINER", "ADMIN", "SUPERADMIN"]}><DietBuilder /></ProtectedRoute>} />
                  <Route path="/personaltrainer/workout-builder" element={<ProtectedRoute allowedRoles={["PERSONALTRAINER", "ADMIN", "SUPERADMIN"]}><WorkoutBuilder /></ProtectedRoute>} />
                  <Route path="/personaltrainer/classesschedule" element={<ProtectedRoute allowedRoles={["PERSONALTRAINER", "ADMIN", "SUPERADMIN"]}><PersonalTrainerClassesSchedule /></ProtectedRoute>} />
                  <Route path="/personaltrainer/messages" element={<ProtectedRoute allowedRoles={["PERSONALTRAINER", "ADMIN", "SUPERADMIN"]}><PersonalTrainerMessages /></ProtectedRoute>} />
                  <Route path="/personaltrainer/group-classes" element={<ProtectedRoute allowedRoles={["PERSONALTRAINER", "ADMIN", "SUPERADMIN"]}><PersonalTrainerGroupClasses /></ProtectedRoute>} />
                  <Route path="/personaltrainer/bookings" element={<ProtectedRoute allowedRoles={["PERSONALTRAINER", "ADMIN", "SUPERADMIN"]}><PersonalSessionBooking /></ProtectedRoute>} />
                  <Route path="/personaltrainer/qrcheckin" element={<ProtectedRoute allowedRoles={["PERSONALTRAINER", "ADMIN", "SUPERADMIN"]}><PersonalTrainerQrCheckin /></ProtectedRoute>} />
                  <Route path="/personaltrainer/personalattendance" element={<ProtectedRoute allowedRoles={["PERSONALTRAINER", "ADMIN", "SUPERADMIN"]}><PersonalAttendance /></ProtectedRoute>} />
                  <Route path="/personaltrainer/personalplansbookings" element={<ProtectedRoute allowedRoles={["PERSONALTRAINER", "ADMIN", "SUPERADMIN"]}><PersonalPlansBookings /></ProtectedRoute>} />
                  <Route path="/personaltrainer/PersonalPlansBookings" element={<ProtectedRoute allowedRoles={["PERSONALTRAINER", "ADMIN", "SUPERADMIN"]}><PersonalPlansBookings /></ProtectedRoute>} />
                  <Route path="/personaltrainer/shift-managment" element={<ProtectedRoute allowedRoles={["PERSONALTRAINER", "ADMIN", "SUPERADMIN"]}><PersonsalTrainerShiftManagement /></ProtectedRoute>} />
                  <Route path="/personaltrainer/report" element={<ProtectedRoute allowedRoles={["PERSONALTRAINER", "ADMIN", "SUPERADMIN"]}><PersonsalReportsClasses /></ProtectedRoute>} />

                  <Route path="/housekeeping/dashboard" element={<ProtectedRoute allowedRoles={["HOUSEKEEPING", "ADMIN", "SUPERADMIN"]}><HouseKeepingDashboard /></ProtectedRoute>} />
                  <Route path="/housekeeping/qrcheckin" element={<ProtectedRoute allowedRoles={["HOUSEKEEPING", "ADMIN", "SUPERADMIN"]}><HouseKeepingQrCheckin /></ProtectedRoute>} />
                  <Route path="/housekeeping/members" element={<ProtectedRoute allowedRoles={["HOUSEKEEPING", "ADMIN", "SUPERADMIN"]}><HousekeepingShiftView /></ProtectedRoute>} />
                  <Route path="/housekeeping/membership-plan" element={<ProtectedRoute allowedRoles={["HOUSEKEEPING", "ADMIN", "SUPERADMIN"]}><HouseKeepingAttendance /></ProtectedRoute>} />
                  <Route path="/housekeeping/duty-roster" element={<ProtectedRoute allowedRoles={["HOUSEKEEPING", "ADMIN", "SUPERADMIN"]}><HousekeepingTask /></ProtectedRoute>} />
                  <Route path="/housekeeping/class-schedule" element={<ProtectedRoute allowedRoles={["HOUSEKEEPING", "ADMIN", "SUPERADMIN"]}><HouseKeepingNotifications /></ProtectedRoute>} />
                  <Route path="/housekeeping/shift-management" element={<ProtectedRoute allowedRoles={["HOUSEKEEPING", "ADMIN", "SUPERADMIN"]}><HouseKeepingShiftManagement /></ProtectedRoute>} />

                  {/* Staff Announcements */}
                  <Route path="/staff/announcements" element={<ProtectedRoute allowedRoles={["GENERALTRAINER", "PERSONALTRAINER", "RECEPTIONIST", "HOUSEKEEPING", "MANAGER", "ADMIN"]}><AnnouncementsList roleGroup="STAFF" /></ProtectedRoute>} />

                  {/* Public Test Routes for Assessment Validation */}
                  <Route path="/test-assessment-form" element={<TrainerAssessmentForm />} />
                  <Route path="/test-assessment-dashboard" element={<MemberAssessmentDashboard memberId={146} />} />

                </Routes>
              </ErrorBoundary>
            </div>
          </div>
        </>
      )}
    </>
  );
}

export default App;
