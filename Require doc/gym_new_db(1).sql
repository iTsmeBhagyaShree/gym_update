-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 20, 2026 at 12:15 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.1.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `gym_new_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `alert`
--

CREATE TABLE `alert` (
  `id` int(11) NOT NULL,
  `type` varchar(191) NOT NULL,
  `message` varchar(191) NOT NULL,
  `memberId` int(11) DEFAULT NULL,
  `staffId` int(11) DEFAULT NULL,
  `branchId` int(11) NOT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT current_timestamp(3)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `announcement`
--

CREATE TABLE `announcement` (
  `id` int(11) NOT NULL,
  `subject` varchar(255) NOT NULL,
  `message` text NOT NULL,
  `channels` varchar(255) NOT NULL,
  `targetRoles` varchar(255) NOT NULL,
  `sentBy` int(11) DEFAULT NULL,
  `branchId` int(11) DEFAULT NULL,
  `createdAt` timestamp NOT NULL DEFAULT current_timestamp(),
  `adminId` int(11) DEFAULT NULL,
  `imageUrl` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `announcement`
--

INSERT INTO `announcement` (`id`, `subject`, `message`, `channels`, `targetRoles`, `sentBy`, `branchId`, `createdAt`, `adminId`, `imageUrl`) VALUES
(1, 'Test Broadcast from Superadmin', 'Hello owners, this is a system-wide test broadcast for notices and offers!', '[\"EMAIL\",\"WHATSAPP\",\"APP_PUSH\"]', '[2]', NULL, NULL, '2026-06-13 11:24:39', NULL, NULL),
(2, 'Gym closed tomorrow', 'The gym will be closed tomorrow but will be open the day after tomorrow.', '[\"EMAIL\",\"WHATSAPP\",\"APP_PUSH\"]', '[\"MEMBERS\",\"STAFF\"]', 90, NULL, '2026-06-20 06:52:47', 90, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `app_settings`
--

CREATE TABLE `app_settings` (
  `id` int(11) NOT NULL,
  `logo` varchar(500) DEFAULT NULL,
  `gym_name` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `memberPlanId` int(11) DEFAULT NULL,
  `createdAt` datetime DEFAULT current_timestamp(),
  `updatedAt` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `adminId` int(11) DEFAULT NULL,
  `hero_banner` varchar(500) DEFAULT NULL,
  `hero_subtitle` text DEFAULT NULL,
  `hero_title` varchar(255) DEFAULT NULL,
  `services_json` text DEFAULT NULL,
  `testimonials_json` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `app_settings`
--

INSERT INTO `app_settings` (`id`, `logo`, `gym_name`, `description`, `url`, `memberPlanId`, `createdAt`, `updatedAt`, `adminId`, `hero_banner`, `hero_subtitle`, `hero_title`, `services_json`, `testimonials_json`) VALUES
(9, 'https://res.cloudinary.com/dw48hcxi5/image/upload/v1767009449/gym/app-logo/ft1ddb2v3qpzfsmyfxtz.jpg', 'Power Gym', 'Best fitness gym in the city', 'localhost:5173', 35, '2025-12-13 02:11:43', '2026-01-06 14:58:03', 90, NULL, NULL, NULL, NULL, NULL),
(10, 'https://res.cloudinary.com/dw48hcxi5/image/upload/v1765806552/gym/app-logo/vpeahm6mvq7ageoiluxv.jpg', NULL, 'Welcome to GYM – Where Fitness Meets Lifestyle\r\n\r\nGYM ek modern, fully-equipped fitness destination hai jo aapke health aur lifestyle goals ko dhyaan me rakh kar design kiya gaya hai. Yahan sirf workout nahi hota, balki complete fitness transformation hota hai – body, mind aur confidence ka.\r\n\r\nHum provide karte hain state-of-the-art gym equipment, certified trainers, aur scientifically designed workout programs jo beginners se leke advanced athletes tak sabke liye suitable hain. Chahe aap weight loss chahte ho, muscle gain, strength training, ya overall fitness – GYM aapke har goal ke liye ready hai.', 'fitgym', 22, '2025-12-13 02:18:29', '2025-12-15 05:49:08', 90, NULL, NULL, NULL, NULL, NULL),
(11, NULL, 'Power Gym', 'Best fitness gym in the city', 'powergym.com', 35, '2025-12-29 17:37:48', '2025-12-30 13:05:17', 164, NULL, NULL, NULL, NULL, NULL),
(12, 'https://res.cloudinary.com/dw48hcxi5/image/upload/v1767010798/gym/app-logo/ekgmegsemkxrlqs4tnfe.jpg', NULL, 'Testing', 'fitgym', NULL, '2025-12-29 17:49:57', '2025-12-29 17:49:57', 170, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `automation_settings`
--

CREATE TABLE `automation_settings` (
  `id` int(11) NOT NULL,
  `trialDurationDays` int(11) DEFAULT 7,
  `gracePeriodDays` int(11) DEFAULT 3,
  `enableEmailNotif` tinyint(1) DEFAULT 0,
  `enableWhatsappNotif` tinyint(1) DEFAULT 0,
  `updatedAt` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `lowCreditThreshold` int(11) DEFAULT 50
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `automation_settings`
--

INSERT INTO `automation_settings` (`id`, `trialDurationDays`, `gracePeriodDays`, `enableEmailNotif`, `enableWhatsappNotif`, `updatedAt`, `lowCreditThreshold`) VALUES
(1, 7, 3, 0, 0, '2026-06-20 14:09:27', 50);

-- --------------------------------------------------------

--
-- Table structure for table `booking`
--

CREATE TABLE `booking` (
  `id` int(11) NOT NULL,
  `memberId` int(11) NOT NULL,
  `scheduleId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `booking_requests`
--

CREATE TABLE `booking_requests` (
  `id` int(11) NOT NULL,
  `memberId` int(11) DEFAULT NULL,
  `planId` int(11) DEFAULT NULL,
  `classId` int(11) DEFAULT NULL,
  `branchId` int(11) DEFAULT NULL,
  `adminId` int(11) DEFAULT NULL,
  `userId` int(11) DEFAULT NULL,
  `status` enum('pending','approved','rejected') DEFAULT 'pending',
  `createdAt` datetime DEFAULT current_timestamp(),
  `updatedAt` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `price` decimal(10,2) NOT NULL DEFAULT 0.00,
  `upiId` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `branch`
--

CREATE TABLE `branch` (
  `id` int(11) NOT NULL,
  `name` varchar(191) NOT NULL,
  `phone` varchar(191) DEFAULT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `address` varchar(191) DEFAULT NULL,
  `status` enum('ACTIVE','INACTIVE') NOT NULL DEFAULT 'ACTIVE',
  `adminId` int(11) DEFAULT NULL,
  `attendanceRadiusMeters` int(11) NOT NULL DEFAULT 50
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `branch`
--

INSERT INTO `branch` (`id`, `name`, `phone`, `createdAt`, `address`, `status`, `adminId`, `attendanceRadiusMeters`) VALUES
(33, 'Trainer', '07700912345', '2025-12-10 03:24:53.230', '123 High Street', 'ACTIVE', 90, 50),
(48, 'Fitness', '07700912345', '2025-12-12 23:43:47.135', '123 High Street', 'ACTIVE', 90, 50),
(50, 'Main Branch', '9999999999', '2025-12-30 16:36:43.625', 'Demo Address', 'ACTIVE', 90, 50);

-- --------------------------------------------------------

--
-- Table structure for table `classschedule`
--

CREATE TABLE `classschedule` (
  `id` int(11) NOT NULL,
  `adminId` int(11) DEFAULT NULL,
  `className` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `trainerId` int(11) NOT NULL,
  `date` datetime(3) NOT NULL,
  `startTime` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `endTime` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `capacity` int(11) NOT NULL,
  `members` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `status` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Active',
  `day` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `price` decimal(10,2) DEFAULT 0.00
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `classschedule`
--

INSERT INTO `classschedule` (`id`, `adminId`, `className`, `trainerId`, `date`, `startTime`, `endTime`, `capacity`, `members`, `status`, `day`, `price`) VALUES
(15, NULL, 'Yoga', 102, '2025-12-15 00:00:00.000', '15:20', '17:20', 20, '[]', 'Active', 'Monday', 0.00),
(18, NULL, 'new', 166, '2025-12-29 00:00:00.000', '22:18', '23:18', 20, '[]', 'Active', 'Monday', 0.00),
(19, 33, 'one', 165, '2025-12-30 00:00:00.000', '13:21', '14:22', 20, '[]', 'Active', 'Monday', 0.00),
(21, 50, 'Morning Yoga', 150, '2025-12-28 16:45:08.000', '06:00', '07:00', 10, NULL, 'Active', NULL, 0.00),
(22, NULL, 'Old Class', 166, '2025-12-30 00:00:00.000', '20:22', '22:22', 20, '[]', 'Active', 'Wednesday', 0.00),
(26, 90, 'Morning Yoga', 102, '2026-01-02 00:00:00.000', '07:00', '08:00', 20, '[]', 'Active', 'Wednesday', 100.00),
(27, 164, 'yoga', 182, '2026-01-02 00:00:00.000', '19:53', '20:53', 20, '[]', 'Active', '', 0.00),
(28, 90, 'Demo', 102, '2026-01-06 00:00:00.000', '17:26', '18:26', 20, '[]', 'Active', 'Monday', 5000.00);

-- --------------------------------------------------------

--
-- Table structure for table `classtype`
--

CREATE TABLE `classtype` (
  `id` int(11) NOT NULL,
  `name` varchar(191) NOT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT current_timestamp(3)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `credit_packages`
--

CREATE TABLE `credit_packages` (
  `id` int(11) NOT NULL,
  `packageName` varchar(100) NOT NULL,
  `credits` int(11) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `isActive` tinyint(1) DEFAULT 1,
  `createdAt` datetime DEFAULT current_timestamp(),
  `updatedAt` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `credit_packages`
--

INSERT INTO `credit_packages` (`id`, `packageName`, `credits`, `price`, `isActive`, `createdAt`, `updatedAt`) VALUES
(1, 'Bronze Package', 1000, 1000.00, 1, '2026-06-20 15:03:16', '2026-06-20 15:03:16'),
(2, 'Silver Package', 5000, 4500.00, 1, '2026-06-20 15:03:16', '2026-06-20 15:03:16'),
(3, 'Gold Package', 10000, 8000.00, 1, '2026-06-20 15:03:16', '2026-06-20 15:03:16');

-- --------------------------------------------------------

--
-- Table structure for table `demo_requests`
--

CREATE TABLE `demo_requests` (
  `id` int(11) NOT NULL,
  `email` varchar(191) NOT NULL,
  `phone` varchar(191) NOT NULL,
  `status` varchar(191) NOT NULL DEFAULT 'pending',
  `createdAt` datetime(3) NOT NULL DEFAULT current_timestamp(3)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dietmeal`
--

CREATE TABLE `dietmeal` (
  `id` int(11) NOT NULL,
  `dietPlanId` int(11) NOT NULL,
  `time` varchar(191) NOT NULL,
  `food` varchar(191) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `dietmeal`
--

INSERT INTO `dietmeal` (`id`, `dietPlanId`, `time`, `food`) VALUES
(12, 2, 'Breakfast', '4 Egg whites, 1 whole egg + Spinach'),
(13, 2, 'Lunch', 'Grilled Chicken Breast with Steamed Broccoli'),
(14, 2, 'Pre-Workout', 'One Apple or 100g Berries'),
(15, 2, 'Post-Workout', 'Whey Protein Shake + 1 Rice Cake'),
(16, 2, 'Dinner', 'Baked White Fish (Tilapia/Cod) with Asparagus'),
(17, 3, 'Breakfast', 'Greek Yogurt (0%) with Chia Seeds & Blueberries'),
(18, 3, 'Lunch', 'Chickpea & Quinoa Salad with Cucumber'),
(19, 3, 'Pre-Workout', 'Handful of Almonds'),
(20, 3, 'Post-Workout', 'Plant-based Protein Shake'),
(21, 3, 'Dinner', 'Tofu Stir-fry with Bell Peppers and Soy Sauce');

-- --------------------------------------------------------

--
-- Table structure for table `dietplan`
--

CREATE TABLE `dietplan` (
  `id` int(11) NOT NULL,
  `title` varchar(191) NOT NULL,
  `notes` varchar(191) DEFAULT NULL,
  `createdBy` int(11) NOT NULL,
  `branchId` int(11) NOT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `dietType` varchar(20) DEFAULT 'Any'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `dietplan`
--

INSERT INTO `dietplan` (`id`, `title`, `notes`, `createdBy`, `branchId`, `createdAt`, `dietType`) VALUES
(2, 'Extreme weight loss', 'Drink 3L daily', 102, 48, '2026-06-15 15:23:24.373', 'Non-Veg'),
(3, 'Extreme weight loss', 'Drink 3L daily', 102, 48, '2026-06-15 15:33:16.337', 'Veg');

-- --------------------------------------------------------

--
-- Table structure for table `dietplanassignment`
--

CREATE TABLE `dietplanassignment` (
  `id` int(11) NOT NULL,
  `dietPlanId` int(11) NOT NULL,
  `memberId` int(11) NOT NULL,
  `assignedAt` datetime(3) NOT NULL DEFAULT current_timestamp(3)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `dietplanassignment`
--

INSERT INTO `dietplanassignment` (`id`, `dietPlanId`, `memberId`, `assignedAt`) VALUES
(2, 3, 152, '2026-06-15 15:33:26.322'),
(3, 2, 153, '2026-06-15 15:33:35.576');

-- --------------------------------------------------------

--
-- Table structure for table `equipment_requests`
--

CREATE TABLE `equipment_requests` (
  `id` int(11) NOT NULL,
  `requestedBy` int(11) NOT NULL,
  `role` varchar(50) NOT NULL,
  `itemName` varchar(255) NOT NULL,
  `category` varchar(100) DEFAULT NULL,
  `quantity` int(11) DEFAULT 1,
  `reason` text DEFAULT NULL,
  `status` enum('PENDING','APPROVED','REJECTED','COMPLETED') DEFAULT 'PENDING',
  `adminRemarks` text DEFAULT NULL,
  `branchId` int(11) NOT NULL,
  `adminId` int(11) DEFAULT NULL,
  `createdAt` timestamp NOT NULL DEFAULT current_timestamp(),
  `updatedAt` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `expense`
--

CREATE TABLE `expense` (
  `id` int(11) NOT NULL,
  `title` varchar(191) NOT NULL,
  `category` varchar(191) NOT NULL,
  `amount` double NOT NULL,
  `date` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `branchId` int(11) NOT NULL,
  `notes` varchar(191) DEFAULT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT current_timestamp(3)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `global_settings`
--

CREATE TABLE `global_settings` (
  `key_name` varchar(191) NOT NULL,
  `value_data` text NOT NULL,
  `updatedAt` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `global_settings`
--

INSERT INTO `global_settings` (`key_name`, `value_data`, `updatedAt`) VALUES
('invoice_channel', '[\"EMAIL\",\"WHATSAPP\",\"APP_PUSH\"]', '2026-06-13 16:22:46'),
('templates_channel', '[\"EMAIL\",\"WHATSAPP\",\"APP_PUSH\"]', '2026-06-13 16:22:46'),
('welcome_note_channel', '[\"EMAIL\",\"WHATSAPP\",\"APP_PUSH\"]', '2026-06-13 16:22:46');

-- --------------------------------------------------------

--
-- Table structure for table `group_class_bookings`
--

CREATE TABLE `group_class_bookings` (
  `id` int(11) NOT NULL,
  `memberId` int(11) NOT NULL,
  `classId` int(11) NOT NULL,
  `date` date NOT NULL,
  `startTime` time NOT NULL,
  `endTime` time NOT NULL,
  `bookingStatus` varchar(20) DEFAULT 'Booked',
  `paymentStatus` varchar(20) DEFAULT 'Pending',
  `notes` text DEFAULT NULL,
  `branchId` int(11) NOT NULL,
  `createdAt` datetime DEFAULT current_timestamp(),
  `updatedAt` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `gym_equipment`
--

CREATE TABLE `gym_equipment` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `category` varchar(100) DEFAULT NULL,
  `quantity` int(11) DEFAULT 1,
  `condition` varchar(50) DEFAULT 'Good',
  `purchaseDate` date DEFAULT NULL,
  `purchaseCost` decimal(10,2) DEFAULT NULL,
  `location` varchar(255) DEFAULT NULL,
  `nextMaintenanceDate` date DEFAULT NULL,
  `branchId` int(11) NOT NULL,
  `notes` text DEFAULT NULL,
  `isActive` tinyint(1) DEFAULT 1,
  `createdAt` timestamp NOT NULL DEFAULT current_timestamp(),
  `updatedAt` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `housekeepingattendance`
--

CREATE TABLE `housekeepingattendance` (
  `id` int(11) NOT NULL,
  `staffId` int(11) NOT NULL,
  `attendanceDate` date NOT NULL,
  `status` enum('Present','Absent','Late') NOT NULL,
  `checkIn` time DEFAULT NULL,
  `checkOut` time DEFAULT NULL,
  `workHours` varchar(20) DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `createdById` int(11) NOT NULL,
  `createdAt` datetime DEFAULT current_timestamp(),
  `updatedAt` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `housekeepingschedule`
--

CREATE TABLE `housekeepingschedule` (
  `id` int(11) NOT NULL,
  `dutyDate` date NOT NULL,
  `startTime` time NOT NULL,
  `endTime` time NOT NULL,
  `location` varchar(100) DEFAULT NULL,
  `status` enum('In Progress','Completed','Pending') DEFAULT 'Pending',
  `staffId` int(11) NOT NULL,
  `createdById` int(11) NOT NULL,
  `createdAt` datetime DEFAULT current_timestamp(),
  `updatedAt` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `landing_page_cms`
--

CREATE TABLE `landing_page_cms` (
  `id` int(11) NOT NULL,
  `adminId` int(11) NOT NULL,
  `heroTitle` varchar(255) DEFAULT NULL,
  `heroSubtitle` varchar(255) DEFAULT NULL,
  `bannerUrl` varchar(500) DEFAULT NULL,
  `featuresJson` text DEFAULT NULL,
  `testimonialsJson` text DEFAULT NULL,
  `createdAt` datetime DEFAULT current_timestamp(),
  `updatedAt` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `leads`
--

CREATE TABLE `leads` (
  `id` int(11) NOT NULL,
  `adminId` int(11) NOT NULL,
  `fullName` varchar(191) NOT NULL,
  `email` varchar(191) DEFAULT NULL,
  `phone` varchar(191) NOT NULL,
  `gender` varchar(191) DEFAULT NULL,
  `source` varchar(191) NOT NULL DEFAULT 'Landing Page',
  `status` varchar(191) NOT NULL DEFAULT 'New',
  `assignedToStaffId` int(11) DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `updatedAt` datetime(3) NOT NULL,
  `branchId` int(11) DEFAULT NULL,
  `followUpDate` datetime(3) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `leads`
--

INSERT INTO `leads` (`id`, `adminId`, `fullName`, `email`, `phone`, `gender`, `source`, `status`, `assignedToStaffId`, `notes`, `createdAt`, `updatedAt`, `branchId`, `followUpDate`) VALUES
(1, 90, 'vaani', 'vaani@gmail.com', '7788994457', 'Female', 'Website', 'Converted', 51, 'wdfgh', '2026-06-05 14:31:44.000', '2026-06-08 18:08:13.000', NULL, NULL),
(11, 90, 'abc', 'abc@gmail.com', '1111112222', 'Male', 'Website', 'Converted', 25, NULL, '2026-06-08 15:50:21.000', '2026-06-08 15:52:49.000', 48, '2026-06-01 00:00:00.000'),
(12, 90, 'Dummy Lead 1', 'dummy.lead1@example.com', '9000000001', 'Male', 'Landing Page', 'Converted', NULL, 'Dummy lead #1 generated for bulk allocation testing.', '2026-06-08 18:39:30.205', '2026-06-17 14:33:22.000', 48, NULL),
(13, 90, 'Dummy Lead 2', 'dummy.lead2@example.com', '9000000002', 'Female', 'Landing Page', 'New', 51, 'Dummy lead #2 generated for bulk allocation testing.', '2026-06-08 18:39:30.205', '2026-06-08 18:40:22.000', 48, NULL),
(14, 90, 'Dummy Lead 3', 'dummy.lead3@example.com', '9000000003', 'Male', 'Landing Page', 'New', 51, 'Dummy lead #3 generated for bulk allocation testing.', '2026-06-08 18:39:30.205', '2026-06-08 18:40:22.000', 48, NULL),
(15, 90, 'Dummy Lead 4', 'dummy.lead4@example.com', '9000000004', 'Female', 'Landing Page', 'New', 51, 'Dummy lead #4 generated for bulk allocation testing.', '2026-06-08 18:39:30.205', '2026-06-08 18:40:22.000', 48, NULL),
(16, 90, 'Dummy Lead 5', 'dummy.lead5@example.com', '9000000005', 'Male', 'Landing Page', 'New', 51, 'Dummy lead #5 generated for bulk allocation testing.', '2026-06-08 18:39:30.205', '2026-06-08 18:40:22.000', 48, NULL),
(17, 90, 'Dummy Lead 6', 'dummy.lead6@example.com', '9000000006', 'Female', 'Landing Page', 'New', 51, 'Dummy lead #6 generated for bulk allocation testing.', '2026-06-08 18:39:30.205', '2026-06-08 18:40:22.000', 48, NULL),
(18, 90, 'Dummy Lead 7', 'dummy.lead7@example.com', '9000000007', 'Male', 'Landing Page', 'New', 51, 'Dummy lead #7 generated for bulk allocation testing.', '2026-06-08 18:39:30.205', '2026-06-08 18:40:22.000', 48, NULL),
(19, 90, 'Dummy Lead 8', 'dummy.lead8@example.com', '9000000008', 'Female', 'Landing Page', 'New', 51, 'Dummy lead #8 generated for bulk allocation testing.', '2026-06-08 18:39:30.205', '2026-06-08 18:40:22.000', 48, NULL),
(20, 90, 'Dummy Lead 9', 'dummy.lead9@example.com', '9000000009', 'Male', 'Landing Page', 'New', 51, 'Dummy lead #9 generated for bulk allocation testing.', '2026-06-08 18:39:30.205', '2026-06-08 18:40:22.000', 48, NULL),
(21, 90, 'Dummy Lead 10', 'dummy.lead10@example.com', '9000000010', 'Female', 'Landing Page', 'New', 51, 'Dummy lead #10 generated for bulk allocation testing.', '2026-06-08 18:39:30.205', '2026-06-08 18:40:22.000', 48, NULL),
(22, 90, 'Dummy Lead 11', 'dummy.lead11@example.com', '9000000011', 'Male', 'Landing Page', 'New', 51, 'Dummy lead #11 generated for bulk allocation testing.', '2026-06-08 18:39:30.205', '2026-06-08 18:40:22.000', 48, NULL),
(23, 90, 'Dummy Lead 12', 'dummy.lead12@example.com', '9000000012', 'Female', 'Landing Page', 'New', 51, 'Dummy lead #12 generated for bulk allocation testing.', '2026-06-08 18:39:30.205', '2026-06-08 18:40:22.000', 48, NULL),
(24, 90, 'Dummy Lead 13', 'dummy.lead13@example.com', '9000000013', 'Male', 'Landing Page', 'New', 51, 'Dummy lead #13 generated for bulk allocation testing.', '2026-06-08 18:39:30.205', '2026-06-08 18:40:22.000', 48, NULL),
(25, 90, 'Dummy Lead 14', 'dummy.lead14@example.com', '9000000014', 'Female', 'Landing Page', 'New', 51, 'Dummy lead #14 generated for bulk allocation testing.', '2026-06-08 18:39:30.205', '2026-06-08 18:40:22.000', 48, NULL),
(26, 90, 'Dummy Lead 15', 'dummy.lead15@example.com', '9000000015', 'Male', 'Landing Page', 'New', 51, 'Dummy lead #15 generated for bulk allocation testing.', '2026-06-08 18:39:30.205', '2026-06-08 18:40:22.000', 48, NULL),
(27, 90, 'Dummy Lead 16', 'dummy.lead16@example.com', '9000000016', 'Female', 'Landing Page', 'New', 51, 'Dummy lead #16 generated for bulk allocation testing.', '2026-06-08 18:39:30.205', '2026-06-08 18:40:22.000', 48, NULL),
(28, 90, 'Dummy Lead 17', 'dummy.lead17@example.com', '9000000017', 'Male', 'Landing Page', 'New', 51, 'Dummy lead #17 generated for bulk allocation testing.', '2026-06-08 18:39:30.205', '2026-06-08 18:40:22.000', 48, NULL),
(29, 90, 'Dummy Lead 18', 'dummy.lead18@example.com', '9000000018', 'Female', 'Landing Page', 'New', 51, 'Dummy lead #18 generated for bulk allocation testing.', '2026-06-08 18:39:30.205', '2026-06-08 18:40:22.000', 48, NULL),
(30, 90, 'Dummy Lead 19', 'dummy.lead19@example.com', '9000000019', 'Male', 'Landing Page', 'New', 51, 'Dummy lead #19 generated for bulk allocation testing.', '2026-06-08 18:39:30.205', '2026-06-08 18:40:22.000', 48, NULL),
(31, 90, 'Dummy Lead 20', 'dummy.lead20@example.com', '9000000020', 'Female', 'Landing Page', 'New', 51, 'Dummy lead #20 generated for bulk allocation testing.', '2026-06-08 18:39:30.205', '2026-06-08 18:40:22.000', 48, NULL),
(32, 90, 'Dummy Lead 21', 'dummy.lead21@example.com', '9000000021', 'Male', 'Landing Page', 'New', 51, 'Dummy lead #21 generated for bulk allocation testing.', '2026-06-08 18:39:30.205', '2026-06-08 18:40:22.000', 48, NULL),
(33, 90, 'Dummy Lead 22', 'dummy.lead22@example.com', '9000000022', 'Female', 'Landing Page', 'New', 51, 'Dummy lead #22 generated for bulk allocation testing.', '2026-06-08 18:39:30.205', '2026-06-08 18:40:22.000', 48, NULL),
(34, 90, 'Dummy Lead 23', 'dummy.lead23@example.com', '9000000023', 'Male', 'Landing Page', 'New', 51, 'Dummy lead #23 generated for bulk allocation testing.', '2026-06-08 18:39:30.205', '2026-06-08 18:40:22.000', 48, NULL),
(35, 90, 'Dummy Lead 24', 'dummy.lead24@example.com', '9000000024', 'Female', 'Landing Page', 'New', 51, 'Dummy lead #24 generated for bulk allocation testing.', '2026-06-08 18:39:30.205', '2026-06-08 18:40:22.000', 48, NULL),
(36, 90, 'Dummy Lead 25', 'dummy.lead25@example.com', '9000000025', 'Male', 'Landing Page', 'New', 51, 'Dummy lead #25 generated for bulk allocation testing.', '2026-06-08 18:39:30.205', '2026-06-08 18:40:22.000', 48, NULL),
(37, 90, 'Dummy Lead 26', 'dummy.lead26@example.com', '9000000026', 'Female', 'Landing Page', 'New', 53, 'Dummy lead #26 generated for bulk allocation testing.', '2026-06-08 18:39:30.205', '2026-06-20 11:27:29.000', 48, NULL),
(38, 90, 'Dummy Lead 27', 'dummy.lead27@example.com', '9000000027', 'Male', 'Landing Page', 'New', 53, 'Dummy lead #27 generated for bulk allocation testing.', '2026-06-08 18:39:30.205', '2026-06-20 11:27:29.000', 48, NULL),
(39, 90, 'Dummy Lead 28', 'dummy.lead28@example.com', '9000000028', 'Female', 'Landing Page', 'New', 53, 'Dummy lead #28 generated for bulk allocation testing.', '2026-06-08 18:39:30.205', '2026-06-20 11:27:29.000', 48, NULL),
(40, 90, 'Dummy Lead 29', 'dummy.lead29@example.com', '9000000029', 'Male', 'Landing Page', 'New', 53, 'Dummy lead #29 generated for bulk allocation testing.', '2026-06-08 18:39:30.205', '2026-06-20 11:27:29.000', 48, NULL),
(41, 90, 'Dummy Lead 30', 'dummy.lead30@example.com', '9000000030', 'Female', 'Landing Page', 'New', 53, 'Dummy lead #30 generated for bulk allocation testing.', '2026-06-08 18:39:30.205', '2026-06-20 11:27:29.000', 48, NULL),
(42, 90, 'Dummy Lead 31', 'dummy.lead31@example.com', '9000000031', 'Male', 'Landing Page', 'New', NULL, 'Dummy lead #31 generated for bulk allocation testing.', '2026-06-08 18:39:30.205', '2026-06-08 18:39:30.205', 48, NULL),
(43, 90, 'Dummy Lead 32', 'dummy.lead32@example.com', '9000000032', 'Female', 'Landing Page', 'New', NULL, 'Dummy lead #32 generated for bulk allocation testing.', '2026-06-08 18:39:30.205', '2026-06-08 18:39:30.205', 48, NULL),
(44, 90, 'Dummy Lead 33', 'dummy.lead33@example.com', '9000000033', 'Male', 'Landing Page', 'New', NULL, 'Dummy lead #33 generated for bulk allocation testing.', '2026-06-08 18:39:30.205', '2026-06-08 18:39:30.205', 48, NULL),
(45, 90, 'Dummy Lead 34', 'dummy.lead34@example.com', '9000000034', 'Female', 'Landing Page', 'New', NULL, 'Dummy lead #34 generated for bulk allocation testing.', '2026-06-08 18:39:30.205', '2026-06-08 18:39:30.205', 48, NULL),
(46, 90, 'Dummy Lead 35', 'dummy.lead35@example.com', '9000000035', 'Male', 'Landing Page', 'New', NULL, 'Dummy lead #35 generated for bulk allocation testing.', '2026-06-08 18:39:30.205', '2026-06-08 18:39:30.205', 48, NULL),
(47, 90, 'Dummy Lead 36', 'dummy.lead36@example.com', '9000000036', 'Female', 'Landing Page', 'New', NULL, 'Dummy lead #36 generated for bulk allocation testing.', '2026-06-08 18:39:30.205', '2026-06-08 18:39:30.205', 48, NULL),
(48, 90, 'Dummy Lead 37', 'dummy.lead37@example.com', '9000000037', 'Male', 'Landing Page', 'New', NULL, 'Dummy lead #37 generated for bulk allocation testing.', '2026-06-08 18:39:30.205', '2026-06-08 18:39:30.205', 48, NULL),
(49, 90, 'Dummy Lead 38', 'dummy.lead38@example.com', '9000000038', 'Female', 'Landing Page', 'New', NULL, 'Dummy lead #38 generated for bulk allocation testing.', '2026-06-08 18:39:30.205', '2026-06-08 18:39:30.205', 48, NULL),
(50, 90, 'Dummy Lead 39', 'dummy.lead39@example.com', '9000000039', 'Male', 'Landing Page', 'New', NULL, 'Dummy lead #39 generated for bulk allocation testing.', '2026-06-08 18:39:30.205', '2026-06-08 18:39:30.205', 48, NULL),
(51, 90, 'Dummy Lead 40', 'dummy.lead40@example.com', '9000000040', 'Female', 'Landing Page', 'New', NULL, 'Dummy lead #40 generated for bulk allocation testing.', '2026-06-08 18:39:30.205', '2026-06-08 18:39:30.205', 48, NULL),
(52, 90, 'Dummy Lead 41', 'dummy.lead41@example.com', '9000000041', 'Male', 'Landing Page', 'New', NULL, 'Dummy lead #41 generated for bulk allocation testing.', '2026-06-08 18:39:30.205', '2026-06-08 18:39:30.205', 48, NULL),
(53, 90, 'Dummy Lead 42', 'dummy.lead42@example.com', '9000000042', 'Female', 'Landing Page', 'New', NULL, 'Dummy lead #42 generated for bulk allocation testing.', '2026-06-08 18:39:30.205', '2026-06-08 18:39:30.205', 48, NULL),
(54, 90, 'Dummy Lead 43', 'dummy.lead43@example.com', '9000000043', 'Male', 'Landing Page', 'New', NULL, 'Dummy lead #43 generated for bulk allocation testing.', '2026-06-08 18:39:30.205', '2026-06-08 18:39:30.205', 48, NULL),
(55, 90, 'Dummy Lead 44', 'dummy.lead44@example.com', '9000000044', 'Female', 'Landing Page', 'New', NULL, 'Dummy lead #44 generated for bulk allocation testing.', '2026-06-08 18:39:30.205', '2026-06-08 18:39:30.205', 48, NULL),
(56, 90, 'Dummy Lead 45', 'dummy.lead45@example.com', '9000000045', 'Male', 'Landing Page', 'New', NULL, 'Dummy lead #45 generated for bulk allocation testing.', '2026-06-08 18:39:30.205', '2026-06-08 18:39:30.205', 48, NULL),
(57, 90, 'Dummy Lead 46', 'dummy.lead46@example.com', '9000000046', 'Female', 'Landing Page', 'New', NULL, 'Dummy lead #46 generated for bulk allocation testing.', '2026-06-08 18:39:30.205', '2026-06-08 18:39:30.205', 48, NULL),
(58, 90, 'Dummy Lead 47', 'dummy.lead47@example.com', '9000000047', 'Male', 'Landing Page', 'New', NULL, 'Dummy lead #47 generated for bulk allocation testing.', '2026-06-08 18:39:30.205', '2026-06-08 18:39:30.205', 48, NULL),
(59, 90, 'Dummy Lead 48', 'dummy.lead48@example.com', '9000000048', 'Female', 'Landing Page', 'New', NULL, 'Dummy lead #48 generated for bulk allocation testing.', '2026-06-08 18:39:30.205', '2026-06-08 18:39:30.205', 48, NULL),
(60, 90, 'Dummy Lead 49', 'dummy.lead49@example.com', '9000000049', 'Male', 'Landing Page', 'New', 53, 'Dummy lead #49 generated for bulk allocation testing.', '2026-06-08 18:39:30.205', '2026-06-20 11:27:29.000', 48, NULL),
(61, 90, 'Dummy Lead 50', 'dummy.lead50@example.com', '9000000050', 'Female', 'Landing Page', 'New', 51, 'Dummy lead #50 generated for bulk allocation testing.', '2026-06-08 18:39:30.205', '2026-06-08 18:40:22.000', 48, NULL),
(62, 216, 'sarah', 'sarah123@gmail.com', '101010101010', 'Female', 'Phone', 'Converted', NULL, NULL, '2026-06-13 15:26:27.000', '2026-06-13 15:39:22.000', 50, '2026-06-02 00:00:00.000');

-- --------------------------------------------------------

--
-- Table structure for table `marketing_campaigns`
--

CREATE TABLE `marketing_campaigns` (
  `id` int(11) NOT NULL,
  `adminId` int(11) NOT NULL,
  `campaignName` varchar(191) NOT NULL,
  `templateMessage` text NOT NULL,
  `channel` varchar(50) NOT NULL,
  `recipientCount` int(11) NOT NULL,
  `status` varchar(50) NOT NULL DEFAULT 'pending',
  `scheduledAt` datetime DEFAULT NULL,
  `createdAt` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `member`
--

CREATE TABLE `member` (
  `id` int(11) NOT NULL,
  `userId` int(11) DEFAULT NULL,
  `adminId` int(11) NOT NULL,
  `fullName` varchar(191) NOT NULL,
  `email` varchar(191) DEFAULT NULL,
  `phone` varchar(191) NOT NULL,
  `gender` varchar(191) DEFAULT NULL,
  `address` varchar(191) DEFAULT NULL,
  `joinDate` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `branchId` int(11) DEFAULT NULL,
  `membershipFrom` datetime(3) DEFAULT NULL,
  `membershipTo` datetime(3) DEFAULT NULL,
  `paymentMode` varchar(191) DEFAULT NULL,
  `interestedIn` varchar(191) DEFAULT NULL,
  `amountPaid` double DEFAULT NULL,
  `dateOfBirth` datetime(3) DEFAULT NULL,
  `password` varchar(191) DEFAULT NULL,
  `status` varchar(191) NOT NULL DEFAULT 'ACTIVE',
  `planId` int(11) DEFAULT NULL,
  `discount` decimal(10,2) DEFAULT 0.00,
  `goal` varchar(191) DEFAULT NULL,
  `profileImage` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `member`
--

INSERT INTO `member` (`id`, `userId`, `adminId`, `fullName`, `email`, `phone`, `gender`, `address`, `joinDate`, `branchId`, `membershipFrom`, `membershipTo`, `paymentMode`, `interestedIn`, `amountPaid`, `dateOfBirth`, `password`, `status`, `planId`, `discount`, `goal`, `profileImage`) VALUES
(146, 208, 90, 'vaani', 'vaani@gmail.com', '7788994457', 'Female', 'greater indore', '2026-06-05 14:32:16.671', NULL, '2026-06-05 05:30:00.000', '2026-08-04 05:30:00.000', 'Card', 'Personal Training', 0, NULL, '$2b$10$klEZnyQwTbcJl3cIWr/ARueHR5WWJC0EvvJ1dT67wrWHdZhV9V98C', 'Active', 22, 0.00, NULL, NULL),
(147, 209, 90, 'abc', 'abc@gmail.com', '1111112222', 'Male', 'greater indore', '2026-06-08 15:52:49.277', NULL, '2026-06-09 05:30:00.000', '2026-08-08 05:30:00.000', 'Card', 'Personal Training', 0, '2026-06-01 05:30:00.000', '$2b$10$1QFHDVAv22B5cH9a0uQQVuIURBVkuVLPaLM5AMW..V9Tqyxio5NYO', 'Active', 22, 0.00, 'Weight Loss', NULL),
(148, 220, 216, 'sarah', 'sarah123@gmail.com', '101010101010', 'Female', NULL, '2026-06-13 15:39:22.639', NULL, '2026-06-13 05:30:00.000', '2026-07-14 05:30:00.000', 'Cash', 'Personal Training', 0, '2003-02-14 05:30:00.000', '$2b$10$wIknGYilm60SUH302rFVfuK7.RIFP.kfoHc6JxcThONy/vvr1WvUy', 'Active', 43, 0.00, NULL, NULL),
(149, 221, 90, 'vamika', 'vamika@gmail.com', '5858585858', 'Female', 'greater indore', '2026-06-13 16:11:39.014', NULL, '2026-11-12 05:30:00.000', '2027-02-10 05:30:00.000', 'Bank', 'Personal Training', 5000, '2006-01-03 05:30:00.000', '$2b$10$4E0FFfewEHoqb6wypVKFP.G3cD50Co9D4tyH1LjWtVhijf/SjMlDK', 'Inactive', 32, 0.00, 'Weight Gain', NULL),
(150, 222, 90, 'maddii', 'maddii@gmail.com', '101010101010', 'Female', 'greater indore', '2026-06-13 16:26:07.492', NULL, '2026-10-14 16:26:42.034', '2027-01-12 16:26:42.034', 'Cash', 'Personal Training', 5200, '2013-01-29 05:30:00.000', '$2b$10$jkhGEKd5jS5btKdbxdYjaeg24pfLKgCcLD7u8dUKLDKIB6GgezHja', 'Inactive', 32, 0.00, 'Weight Gain', NULL),
(151, 223, 90, 'test_maddii_2', 'test_maddii_2@gmail.com', '9999999999', 'Female', 'greater indore', '2026-06-13 16:35:14.565', NULL, '2026-09-13 05:30:00.000', '2026-10-13 05:30:00.000', 'Cash', 'Personal Training', 5000, '2013-01-29 05:30:00.000', '$2b$10$HwY4bjVtTQ1zsnGhr6Y6W./Y2x6sFNFt/PWlGgf3Lsxgm/iXgOlum', 'Active', 42, 0.00, 'Weight Gain', NULL),
(152, 224, 90, 'demo boy', 'demoboy@gmail.com', '7894561234', 'Male', 'demo street, demo city ', '2026-06-15 14:21:59.007', NULL, '2026-06-15 05:30:00.000', '2026-08-14 05:30:00.000', 'Cash', 'Personal Training', 1000, '1998-12-28 05:30:00.000', '$2b$10$xMgLjnERgs3JU4toOTxGV.W9l0L1bUE39v5/Pi7fTJ24EqhNoRDYK', 'Active', 22, 0.00, 'Weight Loss', NULL),
(153, 225, 90, 'Demo girl', 'demogirl@gmail.com', '457869123', 'Female', 'demo street', '2026-06-15 15:11:44.762', NULL, '2026-06-15 05:30:00.000', '2026-07-15 05:30:00.000', 'Cash', 'General Trainer', 1000, '1999-08-21 05:30:00.000', '$2b$10$oQ/0HcuOdFAY/.NkIooRee2HS.XGtlw7.6DI3xwi3AGeN1T6Gsdjq', 'Active', 39, 0.00, 'Weight Gain', NULL),
(154, 227, 90, 'Demo Aayush', 'demoaayu@gmail.com', '1234567890', 'Male', 'demo street', '2026-06-17 13:28:37.726', NULL, '2026-06-17 05:30:00.000', '2026-07-17 05:30:00.000', 'Cash', 'General Trainer', 1000, '2002-01-01 05:30:00.000', '$2b$10$/qC8JqA2Yq6IxtKKEGJey.btosdudsAV5IQCuoRnb05v0nUyFXd.q', 'Active', 39, 0.00, 'Weight Gain', NULL),
(155, 228, 90, 'Dummy Lead 1', 'dummy.lead1@example.com', '9000000001', 'Male', 'xyz', '2026-06-17 14:33:22.872', NULL, '2026-06-17 05:30:00.000', '2026-07-17 05:30:00.000', 'Cash', 'General Trainer', 0, '2000-08-07 05:30:00.000', '$2b$10$XOroeua9HURQPyWvfQx9ROfv/x.MSxuEGc4ySVMZh0IiNSpreELbG', 'Active', 39, 0.00, 'Weight Loss', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `memberattendance`
--

CREATE TABLE `memberattendance` (
  `id` int(11) NOT NULL,
  `staffId` int(11) DEFAULT NULL,
  `memberId` int(11) DEFAULT NULL,
  `branchId` int(11) DEFAULT NULL,
  `checkIn` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `checkOut` datetime(3) DEFAULT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `notes` text DEFAULT NULL,
  `status` varchar(20) DEFAULT NULL,
  `mode` varchar(20) DEFAULT NULL,
  `shiftId` int(11) DEFAULT NULL,
  `deviceId` varchar(191) DEFAULT NULL,
  `ipAddress` varchar(45) DEFAULT NULL,
  `latitude` decimal(10,8) DEFAULT NULL,
  `longitude` decimal(11,8) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `memberattendance`
--

INSERT INTO `memberattendance` (`id`, `staffId`, `memberId`, `branchId`, `checkIn`, `checkOut`, `createdAt`, `notes`, `status`, `mode`, `shiftId`, `deviceId`, `ipAddress`, `latitude`, `longitude`) VALUES
(35, NULL, 76, 33, '2025-12-15 00:58:41.822', '2025-12-15 04:17:54.914', '2025-12-15 00:58:41.824', 'QR Code Check-in', 'Present', 'Manual', NULL, NULL, NULL, NULL, NULL),
(38, NULL, 76, 33, '2025-12-15 04:24:33.906', NULL, '2025-12-15 04:24:33.908', 'QR Code Check-in', 'Present', 'Manual', NULL, NULL, NULL, NULL, NULL),
(50, 27, NULL, NULL, '2025-12-16 16:31:00.000', '2025-12-16 17:31:00.000', '2025-12-16 16:31:01.380', 'late', 'Late', 'Manual', 1, NULL, NULL, NULL, NULL),
(76, NULL, 149, 1, '2025-12-19 11:51:53.482', NULL, '2025-12-19 11:51:53.484', 'Manual Check-in', 'In Gym', 'Manual', NULL, NULL, NULL, NULL, NULL),
(78, NULL, 101, 48, '2025-12-19 17:07:39.294', '2025-12-19 17:07:48.376', '2025-12-19 17:07:39.296', 'Manual Check-in', 'Present', 'Manual', NULL, NULL, NULL, NULL, NULL),
(80, NULL, 169, 1, '2025-12-29 17:06:40.216', NULL, '2025-12-29 17:06:40.218', 'Manual Check-in', 'In Gym', 'Manual', NULL, NULL, NULL, NULL, NULL),
(81, NULL, 168, 33, '2025-12-29 17:07:31.313', '2025-12-30 13:07:05.667', '2025-12-29 17:07:31.317', 'Manual Check-in', 'Present', 'Manual', NULL, NULL, NULL, NULL, NULL),
(82, NULL, 167, 33, '2025-12-29 17:07:59.437', NULL, '2025-12-29 17:07:59.441', 'Manual Check-in', 'In Gym', 'Manual', NULL, NULL, NULL, NULL, NULL),
(83, NULL, 165, 33, '2025-12-29 18:26:35.907', NULL, '2025-12-29 18:26:35.914', 'Manual Check-in', 'In Gym', 'Manual', NULL, NULL, NULL, NULL, NULL),
(84, NULL, 166, 33, '2025-12-30 13:20:18.520', NULL, '2025-12-30 13:20:18.523', 'Manual Check-in', 'In Gym', 'Manual', NULL, NULL, NULL, NULL, NULL),
(85, NULL, 68, 45, '2025-12-05 08:00:00.000', NULL, '2025-12-30 14:15:14.981', 'Member attended with father', 'In Gym', 'manual', NULL, NULL, NULL, NULL, NULL),
(87, NULL, 101, 1, '2025-12-30 16:42:07.000', '2026-01-06 18:12:44.527', '2025-12-30 16:42:07.976', NULL, 'Present', NULL, NULL, NULL, NULL, NULL, NULL),
(88, NULL, 116, NULL, '2025-12-05 08:00:00.000', NULL, '2025-12-30 16:53:10.886', 'Member attended with father', 'In Gym', 'manual', NULL, NULL, NULL, NULL, NULL),
(90, NULL, 161, 1, '2026-01-01 17:43:22.666', '2026-01-01 17:45:19.557', '2026-01-01 17:43:22.670', 'Scanned Global QR Code - Admin: John Admin', 'Present', 'QR Code', NULL, NULL, NULL, NULL, NULL),
(91, NULL, 184, 1, '2026-01-01 18:37:24.345', '2026-01-01 18:39:41.153', '2026-01-01 18:37:24.352', 'Manual Check-in', 'Present', 'Manual', NULL, NULL, NULL, NULL, NULL),
(92, NULL, 104, 48, '2026-01-03 17:00:09.855', '2026-01-03 17:01:45.438', '2026-01-03 17:00:09.942', 'Manual Check-in', 'Present', 'Manual', NULL, NULL, NULL, NULL, NULL),
(93, NULL, 184, 1, '2026-01-05 14:53:47.882', '2026-01-05 14:54:09.107', '2026-01-05 14:53:47.891', 'Manual Check-in', 'Present', 'Manual', NULL, NULL, NULL, NULL, NULL),
(98, NULL, 102, 48, '2026-01-06 18:09:52.981', '2026-01-06 18:10:21.251', '2026-01-06 18:09:52.989', 'Manual Check-in', 'Present', 'Manual', NULL, NULL, NULL, NULL, NULL),
(99, NULL, 101, 48, '2026-01-06 18:12:47.925', '2026-01-06 18:40:20.658', '2026-01-06 18:12:47.928', 'Manual Check-in', 'Present', 'Manual', NULL, NULL, NULL, NULL, NULL),
(100, 27, 104, 48, '2026-01-06 18:47:13.142', '2026-01-06 18:48:54.237', '2026-01-06 18:47:13.150', 'Manual Check-in', 'Present', 'Manual', NULL, NULL, NULL, NULL, NULL),
(101, NULL, 102, 48, '2026-01-07 13:13:43.962', '2026-01-07 14:14:15.413', '2026-01-07 13:13:43.968', 'Manual Check-in', 'Present', 'Manual', NULL, NULL, NULL, NULL, NULL),
(104, NULL, 146, 1, '2026-06-05 15:22:00.813', NULL, '2026-06-05 15:22:00.837', 'Manual Check-in', 'In Gym', 'Manual', NULL, 'dev_1780653120782_wa7vjrwlh', '::1', 22.69027269, 75.82868233),
(105, NULL, 101, 48, '2026-06-05 15:26:01.119', NULL, '2026-06-05 15:26:01.132', 'Manual Check-in', 'In Gym', 'Manual', NULL, 'dev_1780653120782_wa7vjrwlh', '::1', NULL, NULL),
(106, NULL, 152, 1, '2026-06-15 14:22:31.168', NULL, '2026-06-15 14:22:31.171', 'Manual Check-in', 'In Gym', 'Manual', NULL, 'dev_1781513551162_t50kp7u8w', '::1', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `memberplan`
--

CREATE TABLE `memberplan` (
  `id` int(11) NOT NULL,
  `name` varchar(191) NOT NULL,
  `sessions` int(11) NOT NULL,
  `validityDays` int(11) NOT NULL,
  `price` double NOT NULL,
  `type` varchar(191) NOT NULL DEFAULT 'GROUP',
  `adminId` int(11) NOT NULL,
  `branchId` int(11) DEFAULT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `updatedAt` datetime(3) DEFAULT current_timestamp(3) ON UPDATE current_timestamp(3),
  `trainerId` int(11) DEFAULT NULL,
  `trainerType` varchar(255) DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `taxRate` decimal(5,2) DEFAULT 0.00
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `memberplan`
--

INSERT INTO `memberplan` (`id`, `name`, `sessions`, `validityDays`, `price`, `type`, `adminId`, `branchId`, `createdAt`, `updatedAt`, `trainerId`, `trainerType`, `status`, `taxRate`) VALUES
(13, 'Basic', 12, 30, 12000, 'PERSONAL', 68, 33, '2025-12-10 03:25:18.278', '2025-12-15 01:13:56.955', NULL, NULL, NULL, 0.00),
(14, 'Golden', 12, 60, 5999, 'GROUP', 90, 33, '2025-12-10 03:25:40.750', '2025-12-18 15:47:45.557', NULL, NULL, 'Active', 0.00),
(22, 'Pre', 12, 60, 1500, 'PERSONAL', 90, NULL, '2025-12-12 22:10:39.629', '2025-12-18 15:47:48.999', NULL, NULL, 'Active', 0.00),
(24, 'Basic', 24, 90, 1200, 'GROUP', 90, NULL, '2025-12-13 01:45:45.516', '2026-01-06 14:42:49.698', NULL, NULL, 'Active', 10.00),
(31, 'Basic', 12, 90, 1200, 'MEMBER', 90, NULL, '2025-12-16 17:53:38.853', '2025-12-19 12:13:53.716', 101, 'general', 'Active', 0.00),
(39, 'general', 12, 30, 5000, 'MEMBER', 90, NULL, '2026-01-06 14:27:45.193', '2026-01-06 14:27:45.193', 139, 'general', 'Active', 5.00),
(42, 'test', 1, 30, 5999, 'MEMBER', 90, NULL, '2026-01-07 16:44:15.201', '2026-01-07 16:44:15.201', 181, 'personal', 'Active', 0.00),
(43, 'prmium pack', 13, 31, 5499, 'PERSONAL', 216, NULL, '2026-06-13 15:29:18.669', '2026-06-13 15:29:18.669', NULL, NULL, 'Active', 0.00),
(46, 'Diwali Bonus', 12, 60, 59999, 'GROUP', 90, NULL, '2026-06-17 14:14:50.816', '2026-06-17 14:25:56.297', NULL, NULL, 'Active', 0.00);

-- --------------------------------------------------------

--
-- Table structure for table `membership_renewal_requests`
--

CREATE TABLE `membership_renewal_requests` (
  `id` int(11) NOT NULL,
  `memberId` int(11) NOT NULL,
  `assignmentId` int(11) NOT NULL COMMENT 'ID from member_plan_assignment table',
  `planId` int(11) NOT NULL,
  `paymentMode` varchar(191) DEFAULT NULL,
  `amountPaid` double DEFAULT NULL,
  `requestedBy` int(11) NOT NULL COMMENT 'User ID who requested (admin/receptionist)',
  `requestedByRole` varchar(50) DEFAULT NULL COMMENT 'Role: admin, receptionist',
  `status` varchar(191) NOT NULL DEFAULT 'pending' COMMENT 'pending, approved, rejected',
  `approvedBy` int(11) DEFAULT NULL COMMENT 'Admin ID who approved',
  `approvedAt` datetime(3) DEFAULT NULL,
  `rejectedAt` datetime(3) DEFAULT NULL,
  `rejectionReason` text DEFAULT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `updatedAt` datetime(3) NOT NULL DEFAULT current_timestamp(3) ON UPDATE current_timestamp(3)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `member_assessments`
--

CREATE TABLE `member_assessments` (
  `id` int(11) NOT NULL,
  `memberId` int(11) NOT NULL,
  `assessment_date` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `engine_version` varchar(50) NOT NULL DEFAULT '1.0.0',
  `config_snapshot` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`config_snapshot`)),
  `createdBy` int(11) NOT NULL,
  `age_at_assessment` int(11) NOT NULL,
  `gender_at_assessment` varchar(10) NOT NULL,
  `weight_kg` decimal(5,2) NOT NULL,
  `height_cm` decimal(5,2) NOT NULL,
  `neck_cm` decimal(4,1) NOT NULL,
  `waist_cm` decimal(4,1) NOT NULL,
  `hip_cm` decimal(4,1) DEFAULT NULL,
  `resting_hr` int(11) NOT NULL,
  `activity_level` enum('sedentary','light','moderate','active') NOT NULL,
  `fitness_goal` enum('fat_loss','maintenance','muscle_gain') NOT NULL,
  `bmi` decimal(5,2) NOT NULL,
  `body_fat_percentage` decimal(5,2) NOT NULL,
  `lean_body_mass` decimal(5,2) NOT NULL,
  `ideal_body_weight` decimal(5,2) NOT NULL,
  `waist_to_hip_ratio` decimal(4,2) DEFAULT NULL,
  `bmr` decimal(6,2) NOT NULL,
  `tdee` decimal(6,2) NOT NULL,
  `target_calories` int(11) NOT NULL,
  `protein_grams` int(11) NOT NULL,
  `fat_grams` int(11) NOT NULL,
  `carb_grams` int(11) NOT NULL,
  `metrics_output` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`metrics_output`)),
  `createdAt` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `is_baseline` tinyint(1) DEFAULT 0,
  `baseline_bf_percent` decimal(5,2) DEFAULT NULL,
  `baseline_lbm` decimal(5,2) DEFAULT NULL,
  `demographic_multiplier` decimal(3,2) DEFAULT NULL,
  `final_leaderboard_score` decimal(8,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `member_assessments`
--

INSERT INTO `member_assessments` (`id`, `memberId`, `assessment_date`, `engine_version`, `config_snapshot`, `createdBy`, `age_at_assessment`, `gender_at_assessment`, `weight_kg`, `height_cm`, `neck_cm`, `waist_cm`, `hip_cm`, `resting_hr`, `activity_level`, `fitness_goal`, `bmi`, `body_fat_percentage`, `lean_body_mass`, `ideal_body_weight`, `waist_to_hip_ratio`, `bmr`, `tdee`, `target_calories`, `protein_grams`, `fat_grams`, `carb_grams`, `metrics_output`, `createdAt`, `is_baseline`, `baseline_bf_percent`, `baseline_lbm`, `demographic_multiplier`, `final_leaderboard_score`) VALUES
(1, 146, '2026-06-15 07:55:30.494', '1.0.0', '{\"ENGINE_VERSION\":\"1.0.0\",\"ACTIVITY_MULTIPLIERS\":{\"sedentary\":1.2,\"light\":1.375,\"moderate\":1.55,\"active\":1.725},\"GOAL_ADJUSTMENTS\":{\"fat_loss\":-500,\"maintenance\":0,\"muscle_gain\":350},\"MACRO_RATIOS\":{\"protein_per_kg_lbm\":2.2,\"fat_percentage\":0.25},\"HEART_RATE_ZONES\":{\"fat_burn_low\":0.6,\"fat_burn_high\":0.7,\"cardio_low\":0.7,\"cardio_high\":0.8}}', 1, 28, 'male', 80.00, 180.00, 40.0, 85.0, NULL, 60, 'moderate', 'fat_loss', 24.69, 14.53, 68.38, 74.99, NULL, 1790.00, 2774.50, 2275, 150, 63, 277, '{\"bmi_risk_label\":\"Normal\",\"cardio_zones\":{\"fat_burn_low\":139,\"fat_burn_high\":152,\"cardio_low\":152,\"cardio_high\":166}}', '2026-06-15 07:55:30.494', 0, NULL, NULL, NULL, NULL),
(2, 146, '2026-06-15 08:31:00.858', '1.0.0', '{\"ENGINE_VERSION\":\"1.0.0\",\"ACTIVITY_MULTIPLIERS\":{\"sedentary\":1.2,\"light\":1.375,\"moderate\":1.55,\"active\":1.725},\"GOAL_ADJUSTMENTS\":{\"fat_loss\":-500,\"maintenance\":0,\"muscle_gain\":350},\"MACRO_RATIOS\":{\"protein_per_kg_lbm\":2.2,\"fat_percentage\":0.25},\"HEART_RATE_ZONES\":{\"fat_burn_low\":0.6,\"fat_burn_high\":0.7,\"cardio_low\":0.7,\"cardio_high\":0.8}}', 1, 25, 'male', 75.00, 175.00, 38.0, 82.0, NULL, 60, 'moderate', 'fat_loss', 24.49, 14.54, 64.09, 70.46, NULL, 1723.75, 2671.81, 2172, 141, 60, 266, '{\"bmi_risk_label\":\"Normal\",\"cardio_zones\":{\"fat_burn_low\":141,\"fat_burn_high\":155,\"cardio_low\":155,\"cardio_high\":168}}', '2026-06-15 08:31:00.858', 0, NULL, NULL, NULL, NULL),
(3, 146, '2026-06-15 08:31:42.175', '1.0.0', '{\"ENGINE_VERSION\":\"1.0.0\",\"ACTIVITY_MULTIPLIERS\":{\"sedentary\":1.2,\"light\":1.375,\"moderate\":1.55,\"active\":1.725},\"GOAL_ADJUSTMENTS\":{\"fat_loss\":-500,\"maintenance\":0,\"muscle_gain\":350},\"MACRO_RATIOS\":{\"protein_per_kg_lbm\":2.2,\"fat_percentage\":0.25},\"HEART_RATE_ZONES\":{\"fat_burn_low\":0.6,\"fat_burn_high\":0.7,\"cardio_low\":0.7,\"cardio_high\":0.8}}', 1, 25, 'male', 75.00, 175.00, 38.0, 82.0, NULL, 60, 'moderate', 'fat_loss', 24.49, 14.54, 64.09, 70.46, NULL, 1723.75, 2671.81, 2172, 141, 60, 266, '{\"bmi_risk_label\":\"Normal\",\"cardio_zones\":{\"fat_burn_low\":141,\"fat_burn_high\":155,\"cardio_low\":155,\"cardio_high\":168}}', '2026-06-15 08:31:42.175', 0, NULL, NULL, NULL, NULL),
(4, 152, '2026-06-15 09:09:33.016', '1.0.0', '{\"ENGINE_VERSION\":\"1.0.0\",\"ACTIVITY_MULTIPLIERS\":{\"sedentary\":1.2,\"light\":1.375,\"moderate\":1.55,\"active\":1.725},\"GOAL_ADJUSTMENTS\":{\"fat_loss\":-500,\"maintenance\":0,\"muscle_gain\":350},\"MACRO_RATIOS\":{\"protein_per_kg_lbm\":2.2,\"fat_percentage\":0.25},\"HEART_RATE_ZONES\":{\"fat_burn_low\":0.6,\"fat_burn_high\":0.7,\"cardio_low\":0.7,\"cardio_high\":0.8}}', 1, 28, 'male', 80.00, 200.00, 40.0, 85.0, NULL, 80, 'moderate', 'fat_loss', 20.00, 11.47, 70.83, 93.10, NULL, 1915.00, 2968.25, 2468, 156, 69, 307, '{\"bmi_risk_label\":\"Normal\",\"cardio_zones\":{\"fat_burn_low\":147,\"fat_burn_high\":158,\"cardio_low\":158,\"cardio_high\":170}}', '2026-06-15 09:09:33.016', 0, NULL, NULL, NULL, NULL),
(5, 152, '2026-06-15 09:34:49.053', '1.0.0', '{\"ENGINE_VERSION\":\"1.0.0\",\"ACTIVITY_MULTIPLIERS\":{\"sedentary\":1.2,\"light\":1.375,\"moderate\":1.55,\"active\":1.725},\"GOAL_ADJUSTMENTS\":{\"fat_loss\":-500,\"maintenance\":0,\"muscle_gain\":350},\"MACRO_RATIOS\":{\"protein_per_kg_lbm\":2.2,\"fat_percentage\":0.25},\"HEART_RATE_ZONES\":{\"fat_burn_low\":0.6,\"fat_burn_high\":0.7,\"cardio_low\":0.7,\"cardio_high\":0.8}}', 1, 28, 'male', 78.00, 200.00, 38.0, 75.0, NULL, 75, 'moderate', 'fat_loss', 19.50, 4.59, 74.42, 93.10, NULL, 1895.00, 2937.25, 2437, 164, 68, 293, '{\"bmi_risk_label\":\"Normal\",\"cardio_zones\":{\"fat_burn_low\":145,\"fat_burn_high\":157,\"cardio_low\":157,\"cardio_high\":169}}', '2026-06-15 09:34:49.053', 0, NULL, NULL, NULL, NULL),
(6, 153, '2026-06-15 10:14:54.185', '1.0.0', '{\"ENGINE_VERSION\":\"1.0.0\",\"ACTIVITY_MULTIPLIERS\":{\"sedentary\":1.2,\"light\":1.375,\"moderate\":1.55,\"active\":1.725},\"GOAL_ADJUSTMENTS\":{\"fat_loss\":-500,\"maintenance\":0,\"muscle_gain\":350},\"MACRO_RATIOS\":{\"protein_per_kg_lbm\":2.2,\"fat_percentage\":0.25},\"HEART_RATE_ZONES\":{\"fat_burn_low\":0.6,\"fat_burn_high\":0.7,\"cardio_low\":0.7,\"cardio_high\":0.8}}', 1, 35, 'female', 75.00, 160.00, 35.0, 80.0, 100.0, 68, 'moderate', 'maintenance', 29.30, 32.30, 50.78, 52.38, 0.80, 1414.00, 2191.70, 2192, 112, 61, 299, '{\"bmi_risk_label\":\"Overweight\",\"cardio_zones\":{\"fat_burn_low\":138,\"fat_burn_high\":150,\"cardio_low\":150,\"cardio_high\":162}}', '2026-06-15 10:14:54.185', 0, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `member_bodybuilding_logs`
--

CREATE TABLE `member_bodybuilding_logs` (
  `id` int(11) NOT NULL,
  `memberId` int(11) NOT NULL,
  `log_date` datetime DEFAULT current_timestamp(),
  `weight_kg` decimal(5,2) DEFAULT NULL,
  `chest_cm` decimal(5,2) DEFAULT NULL,
  `shoulders_cm` decimal(5,2) DEFAULT NULL,
  `left_arm_cm` decimal(5,2) DEFAULT NULL,
  `right_arm_cm` decimal(5,2) DEFAULT NULL,
  `left_forearm_cm` decimal(5,2) DEFAULT NULL,
  `right_forearm_cm` decimal(5,2) DEFAULT NULL,
  `waist_cm` decimal(5,2) DEFAULT NULL,
  `thighs_cm` decimal(5,2) DEFAULT NULL,
  `calves_cm` decimal(5,2) DEFAULT NULL,
  `front_photo_url` varchar(255) DEFAULT NULL,
  `back_photo_url` varchar(255) DEFAULT NULL,
  `side_photo_url` varchar(255) DEFAULT NULL,
  `notes` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `member_health_log`
--

CREATE TABLE `member_health_log` (
  `id` int(11) NOT NULL,
  `memberId` int(11) NOT NULL,
  `height` decimal(5,2) NOT NULL,
  `weight` decimal(5,2) NOT NULL,
  `bmi` decimal(5,2) NOT NULL,
  `status` varchar(191) NOT NULL,
  `recordedAt` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `trainerId` int(11) DEFAULT NULL,
  `neck_cm` decimal(4,1) DEFAULT NULL,
  `waist_cm` decimal(4,1) DEFAULT NULL,
  `hip_cm` decimal(4,1) DEFAULT NULL,
  `resting_hr` int(11) DEFAULT NULL,
  `activity_level` varchar(50) DEFAULT NULL,
  `fitness_goal` varchar(50) DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `dietChart` text DEFAULT NULL,
  `bmiStatus` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `member_health_log`
--

INSERT INTO `member_health_log` (`id`, `memberId`, `height`, `weight`, `bmi`, `status`, `recordedAt`, `trainerId`, `neck_cm`, `waist_cm`, `hip_cm`, `resting_hr`, `activity_level`, `fitness_goal`, `notes`, `dietChart`, `bmiStatus`) VALUES
(2, 152, 200.00, 80.00, 20.00, '', '2026-06-15 14:27:45.000', 102, NULL, NULL, NULL, NULL, NULL, NULL, '3 Golden Rules:Hydration: Drink at least 3 to 4 liters of water daily.Avoid: Junk food, deep-fried items, and sugary drinks.Supplement: Creatine (5g) and a daily multivitamin help optimize your workouts.', 'Daily Meal Chart:Meal 1 (Breakfast): 1 bowl of Oats (with milk) OR 4-5 Egg Whites (or 1 whole egg) + 2 slices of brown bread.Meal 2 (Mid-Morning): 1 banana + handful of soaked almonds/walnuts.Meal 3 (Lunch): 150g Grilled Chicken, Fish, or Paneer + 1 cup Brown Rice or Quinoa + Veggie Salad.Meal 4 (Pre/Post-Workout): 1 scoop Whey Protein + 1 Apple or Banana + Black Coffee.Meal 5 (Dinner): 150g Grilled Chicken/Fish OR Soya/Tofu + Veggies + 1 Multigrain Roti.Meal 6 (Bedtime - Optional): 1 glass of Skim Milk or 1 scoop Casein protein', 'Normal'),
(3, 152, 200.00, 78.00, 19.50, '', '2026-06-15 15:15:23.000', 102, NULL, NULL, NULL, NULL, NULL, NULL, 'Water Intake: Din bhar me kam se kam 3-4 litres pani zaroor piyein.\n\nAvoid: Zyada tel (oil), sugar, junk food aur cold drinks se bachein.\n\nConsistency: Isko testing ke liye baseline maan kar 2-3 weeks follow karein aur apne body response ke hisab se quantities adjust karein.', '🏋️‍♂️ Daily Routine & Diet Plan\n🌅 Morning (Pre-Workout / Empty Stomach)\n\n1 glass gunguna pani + 1 baadam/akhrot (optional).\n\nPre-Workout (30 min pehle): 1-2 kele (bananas) ya 1 cup black coffee / oats.\n\n🍳 Breakfast (Post-Workout - High Protein)\n\n4-5 egg whites (boiled/omelette) + 2 brown bread slices.\n\nVeg option: 100g Paneer bhurji ya 1 bowl Oats/Dalia (boiled with skimmed milk) + 1 scoop whey protein.\n\n🍱 Lunch (Balanced Meal)\n\n150g Chicken breast ya 150g Paneer/Tofu.\n\n1 bada bowl dal ya rajma/chole.\n\n1-2 chapati (roti) ya 1 bowl brown/white rice.\n\nSath me green salad zaroor lein.\n\n☕ Evening Snack (Energy Boost)\n\n1 cup green tea ya coffee.\n\nEk mutthi bhune chane (roasted chana) ya roasted makhane / mix nuts.\n\n1-2 boiled eggs ya 50g paneer.\n\n🍽️ Dinner (Light & High Protein)\n\n150g Fish, Chicken, ya Tofu/Paneer (grilled/boiled).\n\n1 bowl mix veg stir-fry ya sabzi.\n\n1 choti roti ya thoda sa rice (dinner me carbs thoda kam rakhein).\n\n🥛 Before Bed (Recovery)\n\n1 glass gunguna doodh (milk) thodi si haldi ke sath (muscle soreness kam karne ke liye).', 'Normal'),
(4, 153, 160.00, 76.00, 29.69, '', '2026-06-15 15:49:32.000', 102, NULL, NULL, NULL, NULL, NULL, NULL, 'Water: Drink 3–4 liters of water daily.\n\nAvoid Whites: Strictly cut out white sugar, maida (refined flour), deep-fried food, and packaged snacks.\n\nMove: Walk briskly for 30–45 minutes or complete 8,000–10,000 steps daily.\n\nSleep: Aim for 7–8 hours of sound sleep to manage stress hormones that stall weight loss.', '🌅 1. Early Morning (7:00 AM)\nDrink: 1-2 glasses of warm water (optional: add 1/2 lemon or cumin seeds).\n\nNuts: 5 soaked almonds (peeled) + 1 walnut.\n\n🍳 2. Breakfast (8:30 AM)\nVeg Option: 1 cup of Oats porridge (with low-fat milk, no sugar, add 1/2 apple) OR 1 Besan/Oats Cheela with veggies.\n\nNon-Veg Option: 3 Egg White omelet/scramble + 1 slice of whole-wheat bread.\n\nDrink: 1 cup of Green Tea or black coffee (sugar-free).\n\n🍏 3. Mid-Morning (11:00 AM)\n1 medium fruit (Apple, Papaya, Guava, or Orange) OR 1 glass of buttermilk with a pinch of cumin powder.\n\n🥗 4. Lunch (1:30 PM)\nStarter: 1 large plate of raw salad (Cucumber, Tomato, Carrot) — Eat this first to control portions.\n\nCarbs: 1 or max 2 Multigrain Rotis (no ghee) OR 1 small bowl of boiled rice.\n\nProtein: 1 big bowl of Dal OR 100g Paneer/Tofu OR 120g Grilled Chicken.\n\nSide: 1 small bowl of low-fat curd.\n\n☕ 5. Evening Snack (5:30 PM)\n1 cup of Green Tea or Milk Tea (without sugar).\n\nWith: 1 small bowl of roasted Makhana (Fox nuts) OR roasted Chana.\n\n🍲 6. Dinner (8:00 PM) — Keep it light & early\nOption A: 1 large bowl of mixed Vegetable Soup with added paneer cubes or shredded chicken.\n\nOption B: 1 bowl of Vegetable Dalia or Oats Khichdi.\n\nOption C: 100g stir-fried veggies (Broccoli, Bell peppers, Mushrooms) with Paneer/Tofu.\n\n🥛 7. Before Bed (9:30 PM)\n1 small cup of warm turmeric milk (low-fat, no sugar).', 'Overweight');

-- --------------------------------------------------------

--
-- Table structure for table `member_plan_assignment`
--

CREATE TABLE `member_plan_assignment` (
  `id` int(11) NOT NULL,
  `memberId` int(11) NOT NULL,
  `planId` int(11) NOT NULL,
  `membershipFrom` datetime(3) NOT NULL,
  `membershipTo` datetime(3) NOT NULL,
  `paymentMode` varchar(191) DEFAULT NULL,
  `amountPaid` double DEFAULT NULL,
  `status` varchar(191) NOT NULL DEFAULT 'Active',
  `assignedBy` int(11) DEFAULT NULL COMMENT 'Admin/Receptionist who assigned this plan',
  `assignedAt` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `createdAt` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `updatedAt` datetime(3) NOT NULL DEFAULT current_timestamp(3) ON UPDATE current_timestamp(3)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `member_plan_assignment`
--

INSERT INTO `member_plan_assignment` (`id`, `memberId`, `planId`, `membershipFrom`, `membershipTo`, `paymentMode`, `amountPaid`, `status`, `assignedBy`, `assignedAt`, `createdAt`, `updatedAt`) VALUES
(51, 146, 22, '2026-06-05 05:30:00.000', '2026-08-04 05:30:00.000', 'Card', 1500, 'Active', 90, '2026-06-05 14:32:16.000', '2026-06-05 14:32:16.683', '2026-06-05 14:32:16.683'),
(52, 147, 22, '2026-06-09 05:30:00.000', '2026-08-08 05:30:00.000', 'Card', 1500, 'Active', 90, '2026-06-08 15:52:49.000', '2026-06-08 15:52:49.285', '2026-06-08 15:52:49.285'),
(53, 148, 43, '2026-06-13 05:30:00.000', '2026-07-14 05:30:00.000', 'Cash', 5499, 'Active', 216, '2026-06-13 15:39:22.000', '2026-06-13 15:39:22.646', '2026-06-13 15:39:22.646'),
(54, 149, 22, '2026-06-13 05:30:00.000', '2026-08-12 05:30:00.000', 'Cash', 200, 'Active', 90, '2026-06-13 16:11:39.000', '2026-06-13 16:11:39.041', '2026-06-13 16:11:39.041'),
(56, 151, 42, '2026-09-13 05:30:00.000', '2026-10-13 05:30:00.000', 'Cash', 5000, 'Active', 90, '2026-06-13 16:35:14.000', '2026-06-13 16:35:14.594', '2026-06-13 16:35:14.594'),
(59, 150, 42, '2026-09-13 16:26:42.034', '2026-10-13 16:26:42.034', 'Cash', 5000, 'Active', 90, '2026-06-13 16:41:43.000', '2026-06-13 16:41:43.309', '2026-06-13 16:41:43.309'),
(60, 152, 22, '2026-06-15 05:30:00.000', '2026-08-14 05:30:00.000', 'Cash', 1000, 'Active', 90, '2026-06-15 14:21:59.000', '2026-06-15 14:21:59.011', '2026-06-15 14:21:59.011'),
(61, 153, 39, '2026-06-15 05:30:00.000', '2026-07-15 05:30:00.000', 'Cash', 1000, 'Active', 90, '2026-06-15 15:11:44.000', '2026-06-15 15:11:44.769', '2026-06-15 15:11:44.769'),
(62, 154, 39, '2026-06-17 05:30:00.000', '2026-07-17 05:30:00.000', 'Cash', 1000, 'Active', 90, '2026-06-17 13:28:37.000', '2026-06-17 13:28:37.731', '2026-06-17 13:28:37.731'),
(63, 155, 39, '2026-06-17 05:30:00.000', '2026-07-17 05:30:00.000', 'Cash', 5000, 'Active', 90, '2026-06-17 14:33:22.000', '2026-06-17 14:33:22.876', '2026-06-17 14:33:22.876');

-- --------------------------------------------------------

--
-- Table structure for table `message_templates`
--

CREATE TABLE `message_templates` (
  `id` int(11) NOT NULL,
  `templateType` varchar(50) NOT NULL,
  `subject` varchar(255) NOT NULL,
  `messageBody` text NOT NULL,
  `updatedAt` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `message_templates`
--

INSERT INTO `message_templates` (`id`, `templateType`, `subject`, `messageBody`, `updatedAt`) VALUES
(1, 'WELCOME_TRIAL', 'Welcome to Your Gym Software Trial!', 'Hi {Name}, your {Days}-day free trial has started. Enjoy!', '2026-06-20 14:09:27'),
(2, 'EXPIRY_REMINDER_DAILY', 'Your Trial is Expiring Soon', 'Hi {Name}, your trial expires on {Date}. Please purchase a subscription to keep access.', '2026-06-20 14:09:27'),
(3, 'TRIAL_EXPIRED_FINAL', 'Your Trial Has Expired', 'Hi {Name}, your trial has expired. Your account is now inactive. Please upgrade.', '2026-06-20 14:09:27'),
(4, 'SUBSCRIPTION_ACTIVATED', 'Welcome Aboard!', 'Hi {Name}, thank you for purchasing a subscription. Your account is fully active!', '2026-06-20 14:09:27');

-- --------------------------------------------------------

--
-- Table structure for table `notificationlog`
--

CREATE TABLE `notificationlog` (
  `id` int(11) NOT NULL,
  `type` varchar(191) NOT NULL,
  `to` varchar(191) NOT NULL,
  `message` varchar(191) NOT NULL,
  `status` varchar(191) NOT NULL DEFAULT 'PENDING',
  `createdAt` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `memberId` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `notificationlog`
--

INSERT INTO `notificationlog` (`id`, `type`, `to`, `message`, `status`, `createdAt`, `memberId`) VALUES
(1, 'EMAIL', 'test-recipient@example.com', 'This is a mock welcome note text message.', 'FAILED', '2026-06-13 15:57:27.939', NULL),
(2, 'EMAIL', 'vamika@gmail.com', 'Hi vamika,\n\nWelcome to our gym! 🏋️‍♂️ Your membership is registered successfully.\n\nLogin credentials:\nEmail: vamika@gmail.com\nPassword: 123456\n\nRegards,\nGym Management', 'FAILED', '2026-06-13 16:11:39.279', 149),
(3, 'EMAIL', 'maddii@gmail.com', 'Hi maddii,\n\nWelcome to our gym! 🏋️‍♂️ Your membership is registered successfully.\n\nLogin credentials:\nEmail: maddii@gmail.com\nPassword: 123456\n\nRegards,\nGym Management', 'FAILED', '2026-06-13 16:26:07.652', 150),
(4, 'WHATSAPP', '101010101010', 'Hi maddii,\n\nWelcome to our gym! 🏋️‍♂️ Your membership is registered successfully.\n\nLogin credentials:\nEmail: maddii@gmail.com\nPassword: 123456\n\nRegards,\nGym Management', 'SENT', '2026-06-13 16:26:07.657', 150),
(5, 'IN-APP', '222', 'Hi maddii,\n\nWelcome to our gym! 🏋️‍♂️ Your membership is registered successfully.\n\nLogin credentials:\nEmail: maddii@gmail.com\nPassword: 123456\n\nRegards,\nGym Management', 'UNREAD', '2026-06-13 16:26:07.660', 150),
(6, 'EMAIL', 'maddii@gmail.com', 'Hi maddii,\n\nThank you for your payment of Rs.5000 for the test plan.\n\nYour membership has been successfully renewed. Enjoy your workout! 💪\n\nRegards,\nGym Management', 'FAILED', '2026-06-13 16:41:43.454', 150),
(7, 'WHATSAPP', '101010101010', 'Hi maddii,\n\nThank you for your payment of Rs.5000 for the test plan.\n\nYour membership has been successfully renewed. Enjoy your workout! 💪\n\nRegards,\nGym Management', 'SENT', '2026-06-13 16:41:43.462', 150),
(8, 'IN-APP', '222', 'Hi maddii,\n\nThank you for your payment of Rs.5000 for the test plan.\n\nYour membership has been successfully renewed. Enjoy your workout! 💪\n\nRegards,\nGym Management', 'UNREAD', '2026-06-13 16:41:43.480', 150),
(9, 'EMAIL', 'jem@gmail.com', 'Hello owners, this is a system-wide test broadcast for notices and offers!', 'FAILED', '2026-06-13 16:54:40.062', NULL),
(10, 'WHATSAPP', '101010101010', 'Hello owners, this is a system-wide test broadcast for notices and offers!', 'SENT', '2026-06-13 16:54:40.075', NULL),
(11, 'IN-APP', '215', 'Hello owners, this is a system-wide test broadcast for notices and offers!', 'UNREAD', '2026-06-13 16:54:40.080', NULL),
(12, 'EMAIL', 'sara@gmail.com', 'Hello owners, this is a system-wide test broadcast for notices and offers!', 'FAILED', '2026-06-13 16:54:40.096', NULL),
(13, 'WHATSAPP', '101010101010', 'Hello owners, this is a system-wide test broadcast for notices and offers!', 'SENT', '2026-06-13 16:54:40.124', NULL),
(14, 'EMAIL', 'admin@gmail.com', 'Hello owners, this is a system-wide test broadcast for notices and offers!', 'FAILED', '2026-06-13 16:54:40.098', NULL),
(15, 'IN-APP', '216', 'Hello owners, this is a system-wide test broadcast for notices and offers!', 'UNREAD', '2026-06-13 16:54:40.130', NULL),
(16, 'EMAIL', 'john@gmail.com', 'Hello owners, this is a system-wide test broadcast for notices and offers!', 'FAILED', '2026-06-13 16:54:40.125', NULL),
(17, 'WHATSAPP', '9876543210', 'Hello owners, this is a system-wide test broadcast for notices and offers!', 'SENT', '2026-06-13 16:54:40.138', NULL),
(18, 'WHATSAPP', '0770090987', 'Hello owners, this is a system-wide test broadcast for notices and offers!', 'SENT', '2026-06-13 16:54:40.141', NULL),
(19, 'IN-APP', '90', 'Hello owners, this is a system-wide test broadcast for notices and offers!', 'READ', '2026-06-13 16:54:40.145', NULL),
(20, 'IN-APP', '89', 'Hello owners, this is a system-wide test broadcast for notices and offers!', 'UNREAD', '2026-06-13 16:54:40.148', NULL),
(21, 'EMAIL', 'demoboy@gmail.com', 'Hi demo boy,\n\nWelcome to our gym! 🏋️‍♂️ Your membership is registered successfully.\n\nLogin credentials:\nEmail: demoboy@gmail.com\nPassword: 123\n\nRegards,\nGym Management', 'FAILED', '2026-06-15 14:21:59.091', 152),
(22, 'EMAIL', 'demoboy@gmail.com', 'Hi demo boy,\n\nThank you for your payment of Rs.1000 for the Pre plan(s).\n\nYour membership is now active. Enjoy your workout! 💪\n\nRegards,\nGym Management', 'FAILED', '2026-06-15 14:21:59.092', 152),
(23, 'WHATSAPP', '7894561234', 'Hi demo boy,\n\nWelcome to our gym! 🏋️‍♂️ Your membership is registered successfully.\n\nLogin credentials:\nEmail: demoboy@gmail.com\nPassword: 123\n\nRegards,\nGym Management', 'SENT', '2026-06-15 14:21:59.095', 152),
(24, 'WHATSAPP', '7894561234', 'Hi demo boy,\n\nThank you for your payment of Rs.1000 for the Pre plan(s).\n\nYour membership is now active. Enjoy your workout! 💪\n\nRegards,\nGym Management', 'SENT', '2026-06-15 14:21:59.097', 152),
(25, 'IN-APP', '224', 'Hi demo boy,\n\nWelcome to our gym! 🏋️‍♂️ Your membership is registered successfully.\n\nLogin credentials:\nEmail: demoboy@gmail.com\nPassword: 123\n\nRegards,\nGym Management', 'UNREAD', '2026-06-15 14:21:59.098', 152),
(26, 'IN-APP', '224', 'Hi demo boy,\n\nThank you for your payment of Rs.1000 for the Pre plan(s).\n\nYour membership is now active. Enjoy your workout! 💪\n\nRegards,\nGym Management', 'UNREAD', '2026-06-15 14:21:59.100', 152),
(27, 'EMAIL', 'demogirl@gmail.com', 'Hi Demo girl,\n\nWelcome to our gym! 🏋️‍♂️ Your membership is registered successfully.\n\nLogin credentials:\nEmail: demogirl@gmail.com\nPassword: 123\n\nRegards,\nGym Management', 'FAILED', '2026-06-15 15:11:44.839', 153),
(28, 'EMAIL', 'demogirl@gmail.com', 'Hi Demo girl,\n\nThank you for your payment of Rs.1000 for the general plan(s).\n\nYour membership is now active. Enjoy your workout! 💪\n\nRegards,\nGym Management', 'FAILED', '2026-06-15 15:11:44.840', 153),
(29, 'WHATSAPP', '457869123', 'Hi Demo girl,\n\nWelcome to our gym! 🏋️‍♂️ Your membership is registered successfully.\n\nLogin credentials:\nEmail: demogirl@gmail.com\nPassword: 123\n\nRegards,\nGym Management', 'SENT', '2026-06-15 15:11:44.842', 153),
(30, 'WHATSAPP', '457869123', 'Hi Demo girl,\n\nThank you for your payment of Rs.1000 for the general plan(s).\n\nYour membership is now active. Enjoy your workout! 💪\n\nRegards,\nGym Management', 'SENT', '2026-06-15 15:11:44.843', 153),
(31, 'IN-APP', '225', 'Hi Demo girl,\n\nWelcome to our gym! 🏋️‍♂️ Your membership is registered successfully.\n\nLogin credentials:\nEmail: demogirl@gmail.com\nPassword: 123\n\nRegards,\nGym Management', 'UNREAD', '2026-06-15 15:11:44.844', 153),
(32, 'IN-APP', '225', 'Hi Demo girl,\n\nThank you for your payment of Rs.1000 for the general plan(s).\n\nYour membership is now active. Enjoy your workout! 💪\n\nRegards,\nGym Management', 'UNREAD', '2026-06-15 15:11:44.844', 153),
(33, 'EMAIL', 'demoaayu@gmail.com', 'Hi Demo Aayush,\n\nWelcome to our gym! 🏋️‍♂️ Your membership is registered successfully.\n\nLogin credentials:\nEmail: demoaayu@gmail.com\nPassword: 123\n\nRegards,\nGym Management', 'FAILED', '2026-06-17 13:28:37.800', 154),
(34, 'EMAIL', 'demoaayu@gmail.com', 'Hi Demo Aayush,\n\nThank you for your payment of Rs.1000 for the general plan(s).\n\nYour membership is now active. Enjoy your workout! 💪\n\nRegards,\nGym Management', 'FAILED', '2026-06-17 13:28:37.801', 154),
(35, 'WHATSAPP', '1234567890', 'Hi Demo Aayush,\n\nWelcome to our gym! 🏋️‍♂️ Your membership is registered successfully.\n\nLogin credentials:\nEmail: demoaayu@gmail.com\nPassword: 123\n\nRegards,\nGym Management', 'SENT', '2026-06-17 13:28:37.804', 154),
(36, 'WHATSAPP', '1234567890', 'Hi Demo Aayush,\n\nThank you for your payment of Rs.1000 for the general plan(s).\n\nYour membership is now active. Enjoy your workout! 💪\n\nRegards,\nGym Management', 'SENT', '2026-06-17 13:28:37.805', 154),
(37, 'IN-APP', '227', 'Hi Demo Aayush,\n\nWelcome to our gym! 🏋️‍♂️ Your membership is registered successfully.\n\nLogin credentials:\nEmail: demoaayu@gmail.com\nPassword: 123\n\nRegards,\nGym Management', 'UNREAD', '2026-06-17 13:28:37.808', 154),
(38, 'IN-APP', '227', 'Hi Demo Aayush,\n\nThank you for your payment of Rs.1000 for the general plan(s).\n\nYour membership is now active. Enjoy your workout! 💪\n\nRegards,\nGym Management', 'UNREAD', '2026-06-17 13:28:37.808', 154),
(39, 'EMAIL', 'dummy.lead1@example.com', 'Hi Dummy Lead 1,\n\nWelcome to our gym! 🏋️‍♂️ Your membership is registered successfully.\n\nLogin credentials:\nEmail: dummy.lead1@example.com\nPassword: 123456\n\nRegards,\nGym Management', 'FAILED', '2026-06-17 14:33:22.976', 155),
(40, 'WHATSAPP', '9000000001', 'Hi Dummy Lead 1,\n\nWelcome to our gym! 🏋️‍♂️ Your membership is registered successfully.\n\nLogin credentials:\nEmail: dummy.lead1@example.com\nPassword: 123456\n\nRegards,\nGym Management', 'SENT', '2026-06-17 14:33:22.979', 155),
(41, 'IN-APP', '228', 'Hi Dummy Lead 1,\n\nWelcome to our gym! 🏋️‍♂️ Your membership is registered successfully.\n\nLogin credentials:\nEmail: dummy.lead1@example.com\nPassword: 123456\n\nRegards,\nGym Management', 'UNREAD', '2026-06-17 14:33:22.981', 155);

-- --------------------------------------------------------

--
-- Table structure for table `payment`
--

CREATE TABLE `payment` (
  `id` int(11) NOT NULL,
  `memberId` int(11) NOT NULL,
  `planId` int(11) NOT NULL,
  `amount` double NOT NULL,
  `paymentDate` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `invoiceNo` varchar(191) NOT NULL,
  `gstAmount` double DEFAULT NULL,
  `gstPercent` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `personal_notification`
--

CREATE TABLE `personal_notification` (
  `id` int(11) NOT NULL,
  `memberId` int(11) NOT NULL,
  `category` varchar(100) NOT NULL,
  `message` text NOT NULL,
  `sentBy` int(11) DEFAULT NULL,
  `isRead` tinyint(1) DEFAULT 0,
  `createdAt` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `plan`
--

CREATE TABLE `plan` (
  `id` int(11) NOT NULL,
  `name` varchar(191) NOT NULL,
  `duration` enum('Monthly','Yearly') NOT NULL,
  `price` double NOT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `category` varchar(191) DEFAULT NULL,
  `description` varchar(191) DEFAULT NULL,
  `status` varchar(191) NOT NULL DEFAULT 'ACTIVE',
  `branchId` int(11) DEFAULT NULL,
  `sessions` int(11) NOT NULL DEFAULT 0,
  `validityDays` int(11) NOT NULL DEFAULT 0,
  `taxRate` decimal(5,2) DEFAULT 0.00
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `plan`
--

INSERT INTO `plan` (`id`, `name`, `duration`, `price`, `createdAt`, `category`, `description`, `status`, `branchId`, `sessions`, `validityDays`, `taxRate`) VALUES
(16, 'Gold', 'Yearly', 4998, '2025-12-10 03:23:46.781', 'BASIC', 'test tsting', 'ACTIVE', NULL, 0, 0, 0.00),
(17, 'Basic', 'Monthly', 8999, '2025-12-10 03:26:29.134', 'BASIC', 'demo', 'ACTIVE', NULL, 0, 0, 0.00),
(18, 'Pro', 'Yearly', 11999, '2025-12-10 03:26:56.723', 'PRO', 'Life Time', 'ACTIVE', NULL, 0, 0, 0.00);

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

CREATE TABLE `product` (
  `id` int(11) NOT NULL,
  `name` varchar(191) NOT NULL,
  `sku` varchar(191) DEFAULT NULL,
  `category` varchar(191) DEFAULT NULL,
  `sellingPrice` double NOT NULL,
  `costPrice` double DEFAULT NULL,
  `currentStock` int(11) NOT NULL DEFAULT 0,
  `branchId` int(11) NOT NULL,
  `isActive` tinyint(1) NOT NULL DEFAULT 1,
  `createdAt` datetime(3) NOT NULL DEFAULT current_timestamp(3)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `pt_bookings`
--

CREATE TABLE `pt_bookings` (
  `id` int(11) NOT NULL,
  `memberId` int(11) NOT NULL,
  `trainerId` int(11) NOT NULL,
  `sessionId` int(11) DEFAULT NULL,
  `date` date NOT NULL,
  `startTime` time NOT NULL,
  `endTime` time NOT NULL,
  `bookingStatus` varchar(20) DEFAULT 'Booked',
  `paymentStatus` varchar(20) DEFAULT 'Pending',
  `notes` text DEFAULT NULL,
  `branchId` int(11) NOT NULL,
  `createdAt` datetime DEFAULT current_timestamp(),
  `updatedAt` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `purchase`
--

CREATE TABLE `purchase` (
  `id` int(11) NOT NULL,
  `selectedPlan` varchar(191) NOT NULL,
  `companyName` varchar(191) NOT NULL,
  `email` varchar(191) NOT NULL,
  `billingDuration` varchar(191) NOT NULL,
  `startDate` datetime(3) NOT NULL,
  `purchaseDate` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `status` varchar(191) NOT NULL DEFAULT 'pending',
  `amount` decimal(10,2) DEFAULT 0.00,
  `phone` varchar(20) DEFAULT NULL,
  `adminName` varchar(191) DEFAULT NULL,
  `branchName` varchar(191) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `purchase`
--

INSERT INTO `purchase` (`id`, `selectedPlan`, `companyName`, `email`, `billingDuration`, `startDate`, `purchaseDate`, `status`, `amount`, `phone`, `adminName`, `branchName`) VALUES
(7, 'Gold', 'test', 'test@gmail.com', 'Yearly', '2025-12-10 16:00:00.000', '2025-12-13 04:10:00.557', 'pending', 0.00, NULL, NULL, NULL),
(8, 'Pro', 'John Admin', 'admin@gmail.com', 'Yearly', '2026-06-09 16:14:20.299', '2026-06-09 16:14:20.755', 'rejected', 11999.00, '9876543210', 'John Admin', 'Fitness'),
(9, 'Pro', 'John Admin', 'admin@gmail.com', 'Yearly', '2026-06-09 16:22:31.748', '2026-06-09 16:22:31.801', 'approved', 11000.00, '9876543210', 'John Admin', 'Fitness'),
(10, 'Pro', 'PBGym', 'Pgym@gmail.com', 'Yearly', '2026-06-22 05:30:00.000', '2026-06-20 15:25:45.283', 'approved', 0.00, '', '', '');

-- --------------------------------------------------------

--
-- Table structure for table `role`
--

CREATE TABLE `role` (
  `id` int(11) NOT NULL,
  `name` varchar(191) NOT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT current_timestamp(3)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `role`
--

INSERT INTO `role` (`id`, `name`, `createdAt`) VALUES
(1, 'Superadmin', '2025-12-03 06:06:52.620'),
(2, 'Admin', '2025-12-03 06:06:52.627'),
(3, 'trainer', '2025-12-03 06:06:52.631'),
(4, 'member', '2025-12-03 06:06:52.634'),
(5, 'personaltrainer', '2025-12-04 15:15:26.000'),
(6, 'generaltrainer', '2025-12-04 15:15:26.000'),
(7, 'receptionist', '2025-12-04 15:15:26.000'),
(8, 'housekeeping', '2025-12-04 15:15:26.000'),
(9, 'Subadmin', '2026-06-09 17:18:59.713'),
(10, 'sales_agent', '2026-06-19 14:38:31.077');

-- --------------------------------------------------------

--
-- Table structure for table `saas_payments`
--

CREATE TABLE `saas_payments` (
  `id` int(11) NOT NULL,
  `adminId` int(11) NOT NULL,
  `amount` double NOT NULL,
  `planType` varchar(191) NOT NULL,
  `paymentStatus` varchar(191) NOT NULL,
  `transactionId` varchar(191) DEFAULT NULL,
  `paymentDate` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `expiryDate` datetime(3) NOT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT current_timestamp(3)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `salary`
--

CREATE TABLE `salary` (
  `id` int(11) NOT NULL,
  `salaryId` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `staffId` int(11) NOT NULL,
  `role` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `periodStart` datetime NOT NULL,
  `periodEnd` datetime NOT NULL,
  `hoursWorked` int(11) DEFAULT 0,
  `hourlyRate` double DEFAULT 0,
  `hourlyTotal` double DEFAULT 0,
  `fixedSalary` double DEFAULT 0,
  `commissionTotal` double DEFAULT 0,
  `bonuses` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `deductions` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `netPay` double NOT NULL,
  `status` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Generated',
  `createdAt` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `salary`
--

INSERT INTO `salary` (`id`, `salaryId`, `staffId`, `role`, `periodStart`, `periodEnd`, `hoursWorked`, `hourlyRate`, `hourlyTotal`, `fixedSalary`, `commissionTotal`, `bonuses`, `deductions`, `netPay`, `status`, `createdAt`) VALUES
(13, 'SAL-47-1781606062033', 47, 'Personal Trainer', '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL, 0, 0, 20000, 1200, '[{\"label\":\"Overtime (5)\",\"amount\":1000}]', '[{\"label\":\"leave\",\"amount\":300}]', 21900, 'Generated', '2026-06-16 16:04:26'),
(14, 'SAL-51-1781606212760', 51, 'Receptionist', '2026-06-01 00:00:00', '2026-06-30 00:00:00', 200, 50, 10000, NULL, 500, '[]', '[{\"label\":\"2 days leave\",\"amount\":200}]', 10300, 'Paid', '2026-06-16 16:07:50'),
(15, 'SAL-38-1781606935100', 38, 'General Trainer', '2026-06-01 00:00:00', '2026-06-30 00:00:00', NULL, 0, 0, 20000, 1000, '[]', '[{\"label\":\"Leave Deduction (0.5 days)\",\"amount\":357.14}]', 20642.86, 'Generated', '2026-06-16 16:19:42');

-- --------------------------------------------------------

--
-- Table structure for table `session`
--

CREATE TABLE `session` (
  `id` int(11) NOT NULL,
  `adminId` int(11) NOT NULL,
  `sessionName` varchar(191) NOT NULL,
  `trainerId` int(11) NOT NULL,
  `branchId` int(11) DEFAULT NULL,
  `date` datetime(3) NOT NULL,
  `time` varchar(191) NOT NULL,
  `duration` int(11) NOT NULL,
  `description` varchar(191) DEFAULT NULL,
  `status` varchar(191) NOT NULL DEFAULT 'Upcoming',
  `createdAt` datetime(3) NOT NULL DEFAULT current_timestamp(3)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `session`
--

INSERT INTO `session` (`id`, `adminId`, `sessionName`, `trainerId`, `branchId`, `date`, `time`, `duration`, `description`, `status`, `createdAt`) VALUES
(34, 90, 'test', 102, NULL, '2025-12-20 00:00:00.000', '12:02', 3, 'teeer', 'Complete', '2025-12-20 11:59:07.995'),
(40, 90, 'Morning Bootcamp', 102, NULL, '2025-12-10 00:00:00.000', '07:00', 60, 'High-intensity interval training', 'Complete', '2025-12-29 16:36:49.013'),
(41, 90, 'new', 150, NULL, '2025-12-30 00:00:00.000', '01:30', 60, 'demo', 'Complete', '2025-12-29 16:45:15.617'),
(42, 164, 'New Session', 165, NULL, '2025-12-29 00:00:00.000', '20:00', 60, 'demo', 'Complete', '2025-12-29 17:01:54.670'),
(43, 164, 'one', 165, NULL, '2025-12-29 00:00:00.000', '03:00', 60, 'demo', 'Complete', '2025-12-29 19:23:59.916'),
(44, 90, 'test', 150, NULL, '2026-01-03 00:00:00.000', '06:30', 60, 'test', 'Complete', '2026-01-03 15:33:53.939');

-- --------------------------------------------------------

--
-- Table structure for table `shifts`
--

CREATE TABLE `shifts` (
  `id` int(11) NOT NULL,
  `staffIds` int(11) DEFAULT NULL,
  `branchId` int(11) DEFAULT NULL,
  `shiftDate` date NOT NULL,
  `startTime` time NOT NULL,
  `endTime` time NOT NULL,
  `shiftType` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `status` varchar(50) NOT NULL DEFAULT 'Pending',
  `createdById` int(11) NOT NULL,
  `createdAt` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `shifts`
--

INSERT INTO `shifts` (`id`, `staffIds`, `branchId`, `shiftDate`, `startTime`, `endTime`, `shiftType`, `description`, `status`, `createdById`, `createdAt`) VALUES
(59, 25, NULL, '2026-01-07', '13:12:00', '15:12:00', 'Evening Shift', 'Test', 'Pending', 7, '2026-01-07 07:42:29'),
(60, 26, NULL, '2026-01-07', '13:17:00', '15:17:00', 'Evening Shift', 'test', 'Pending', 7, '2026-01-07 07:47:55'),
(61, 51, NULL, '2026-06-17', '09:01:00', '15:00:00', 'Morning Shift', NULL, 'Approved', 7, '2026-06-16 10:06:02'),
(62, 47, NULL, '2026-06-17', '09:00:00', '16:00:00', 'Morning Shift', NULL, 'Pending', 7, '2026-06-16 11:00:09');

-- --------------------------------------------------------

--
-- Table structure for table `staff`
--

CREATE TABLE `staff` (
  `id` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `adminId` int(11) DEFAULT NULL,
  `branchId` int(11) DEFAULT NULL,
  `gender` varchar(191) NOT NULL,
  `dateOfBirth` datetime(3) NOT NULL,
  `joinDate` datetime(3) NOT NULL,
  `exitDate` datetime(3) DEFAULT NULL,
  `profilePhoto` varchar(191) DEFAULT NULL,
  `status` varchar(191) NOT NULL DEFAULT 'Active'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `staff`
--

INSERT INTO `staff` (`id`, `userId`, `adminId`, `branchId`, `gender`, `dateOfBirth`, `joinDate`, `exitDate`, `profilePhoto`, `status`) VALUES
(25, 102, 90, 48, 'Male', '2025-12-14 05:30:00.000', '2025-12-14 05:30:00.000', '2025-12-29 05:30:00.000', 'https://res.cloudinary.com/dw48hcxi5/image/upload/v1765965240/staff/profile/c7c68vpqtupwigaamwkg.jpg', 'Active'),
(26, 103, 90, 48, 'Male', '2025-12-14 05:30:00.000', '2025-12-14 05:30:00.000', '2025-12-29 05:30:00.000', 'https://res.cloudinary.com/dw48hcxi5/image/upload/v1765965219/staff/profile/lh7whqydvmixsaajoyon.jpg', 'Active'),
(27, 104, 90, 48, 'Male', '2025-12-14 16:00:00.000', '2025-12-14 16:00:00.000', '2025-12-29 16:00:00.000', 'https://res.cloudinary.com/dw48hcxi5/image/upload/v1765965146/staff/profile/dvfblv1pihcl4d3fg5li.jpg', 'Active'),
(35, 139, 90, 48, ' Female', '1998-03-14 16:00:00.000', '2025-01-31 16:00:00.000', NULL, NULL, 'Active'),
(38, 143, 90, 48, ' Female', '1998-03-14 16:00:00.000', '2025-01-31 16:00:00.000', NULL, 'https://res.cloudinary.com/dw48hcxi5/image/upload/v1765967835/staff/profile/khdz5xzbulleabjfnldd.jpg', 'Active'),
(41, 150, 90, 48, 'Male', '1990-05-14 05:30:00.000', '2025-12-09 05:30:00.000', NULL, NULL, 'Active'),
(43, 165, 164, 33, 'Male', '2025-12-29 05:30:00.000', '2025-12-29 05:30:00.000', '2026-04-28 05:30:00.000', 'https://res.cloudinary.com/dw48hcxi5/image/upload/v1767007436/staff/profile/aqmv4lztzvf2y3woa0f9.jpg', 'Active'),
(44, 166, 164, 33, 'Male', '2025-12-29 05:30:00.000', '2025-12-29 05:30:00.000', '2026-02-28 05:30:00.000', 'https://res.cloudinary.com/dw48hcxi5/image/upload/v1767007497/staff/profile/le18gj4wul2r43tbphg1.png', 'Active'),
(45, 167, 164, 33, 'Male', '2025-12-29 05:30:00.000', '2025-12-29 05:30:00.000', '2026-04-10 05:30:00.000', 'https://res.cloudinary.com/dw48hcxi5/image/upload/v1767007546/staff/profile/htwtaywruuljyzknalqa.png', 'Active'),
(46, 168, 164, 33, 'Male', '2025-12-29 05:30:00.000', '2025-12-29 05:30:00.000', '2026-04-11 05:30:00.000', 'https://res.cloudinary.com/dw48hcxi5/image/upload/v1767007594/staff/profile/eqnhdpvme2f0eborczke.jpg', 'Active'),
(47, 181, 90, 48, 'Male', '2026-01-01 05:30:00.000', '2026-01-01 05:30:00.000', '2026-01-30 05:30:00.000', NULL, 'Active'),
(48, 182, 164, 33, 'Male', '2026-01-01 05:30:00.000', '2026-01-01 05:30:00.000', '2026-01-29 05:30:00.000', NULL, 'Active'),
(49, 183, 164, 33, 'Male', '2026-01-07 05:30:00.000', '2026-01-01 05:30:00.000', '2026-01-15 05:30:00.000', NULL, 'Active'),
(51, 210, 90, 48, 'Male', '2000-02-01 05:30:00.000', '2026-06-08 05:30:00.000', '2026-06-10 05:30:00.000', NULL, 'Active'),
(52, 219, 216, 50, 'Male', '2000-02-01 05:30:00.000', '2026-06-13 05:30:00.000', '2026-08-13 05:30:00.000', 'https://res.cloudinary.com/dw48hcxi5/image/upload/v1781345250/staff/profile/qm4fsxd0zmh0tyc0jgo1.jpg', 'Active'),
(53, 226, 90, 48, 'Female', '1998-06-16 05:30:00.000', '2026-05-01 05:30:00.000', NULL, 'https://res.cloudinary.com/dw48hcxi5/image/upload/v1781608364/staff/profile/ubhc9ahy3l3vqm3r6hmz.jpg', 'Active');

-- --------------------------------------------------------

--
-- Table structure for table `staffattendance`
--

CREATE TABLE `staffattendance` (
  `id` int(11) NOT NULL,
  `shiftId` int(11) DEFAULT NULL,
  `staffId` int(11) NOT NULL,
  `branchId` int(11) NOT NULL,
  `checkIn` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `checkOut` datetime(3) DEFAULT NULL,
  `mode` varchar(20) DEFAULT 'Manual',
  `status` varchar(20) DEFAULT 'Present',
  `notes` text DEFAULT NULL,
  `createdAt` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `staffattendance`
--

INSERT INTO `staffattendance` (`id`, `shiftId`, `staffId`, `branchId`, `checkIn`, `checkOut`, `mode`, `status`, `notes`, `createdAt`) VALUES
(10, 1, 27, 0, '2025-12-16 12:22:00.000', '2025-12-16 15:22:00.000', 'Manual', 'Present', 'test', '2025-12-16 21:01:34'),
(11, 30, 27, 0, '2025-12-16 22:00:00.000', '2025-12-17 06:00:00.000', 'Manual', 'Late', 'asdafghj', '2025-12-16 21:04:36'),
(12, 30, 27, 0, '2025-12-16 22:00:00.000', '2025-12-17 06:00:00.000', 'Manual', 'Late', 'asdafghj', '2025-12-16 21:19:46');

-- --------------------------------------------------------

--
-- Table structure for table `stockmovement`
--

CREATE TABLE `stockmovement` (
  `id` int(11) NOT NULL,
  `productId` int(11) NOT NULL,
  `type` varchar(191) NOT NULL,
  `quantity` int(11) NOT NULL,
  `note` varchar(191) DEFAULT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT current_timestamp(3)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tasks`
--

CREATE TABLE `tasks` (
  `id` int(11) NOT NULL,
  `assignedTo` int(11) DEFAULT NULL,
  `roleId` int(11) DEFAULT NULL,
  `branchId` int(11) DEFAULT NULL,
  `taskTitle` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `dueDate` date NOT NULL,
  `priority` varchar(50) NOT NULL,
  `status` varchar(50) NOT NULL DEFAULT 'Pending',
  `createdById` int(11) NOT NULL,
  `createdAt` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tasks`
--

INSERT INTO `tasks` (`id`, `assignedTo`, `roleId`, `branchId`, `taskTitle`, `description`, `dueDate`, `priority`, `status`, `createdById`, `createdAt`) VALUES
(32, 25, NULL, NULL, 'error', 'fix it', '2025-12-15', 'high', 'completed', 4, '2025-12-15 08:51:42'),
(33, 25, NULL, NULL, 'Work Load', 'sdrg', '2025-12-16', 'low', 'completed', 4, '2025-12-15 08:53:43'),
(35, 27, NULL, NULL, 'wfr', 'ecfw f3', '2025-12-15', 'low', 'completed', 4, '2025-12-15 11:29:14'),
(38, NULL, 8, NULL, 'clean bathroom ', 'The bathroom is so dirty', '2026-06-16', 'High', 'Approved', 90, '2026-06-16 11:19:17'),
(39, NULL, 3, NULL, 'start train 5 person from today ', '5 person train kro , i will audit next week', '2026-06-16', 'Medium', 'Pending', 90, '2026-06-16 11:21:03');

-- --------------------------------------------------------

--
-- Table structure for table `unified_bookings`
--

CREATE TABLE `unified_bookings` (
  `id` int(11) NOT NULL,
  `memberId` int(11) NOT NULL,
  `trainerId` int(11) DEFAULT NULL,
  `sessionId` int(11) DEFAULT NULL,
  `classId` int(11) DEFAULT NULL,
  `date` date NOT NULL,
  `endDate` date DEFAULT NULL,
  `startTime` time NOT NULL,
  `endTime` time NOT NULL,
  `bookingType` enum('PT','GROUP') NOT NULL,
  `bookingStatus` varchar(50) DEFAULT 'Booked',
  `paymentStatus` varchar(50) DEFAULT 'Pending',
  `price` decimal(10,2) DEFAULT NULL,
  `notes` varchar(255) DEFAULT NULL,
  `branchId` int(11) DEFAULT NULL,
  `createdAt` timestamp NULL DEFAULT current_timestamp(),
  `updatedAt` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `unified_bookings`
--

INSERT INTO `unified_bookings` (`id`, `memberId`, `trainerId`, `sessionId`, `classId`, `date`, `endDate`, `startTime`, `endTime`, `bookingType`, `bookingStatus`, `paymentStatus`, `price`, `notes`, `branchId`, `createdAt`, `updatedAt`) VALUES
(8, 3, NULL, NULL, 4, '2025-12-06', NULL, '07:00:00', '08:00:00', 'GROUP', 'Completed', 'Pending', NULL, 'Zumba class test', 1, '2025-12-11 09:12:16', '2026-01-03 10:06:00'),
(9, 68, 87, NULL, 4, '2025-12-11', NULL, '15:52:00', '17:52:00', 'GROUP', 'Completed', 'Pending', NULL, 'Nothing', 33, '2025-12-11 09:23:04', '2026-01-03 10:06:00'),
(10, 3, 5, 2, NULL, '2025-12-10', NULL, '09:00:00', '10:00:00', 'PT', 'Completed', 'Pending', NULL, 'Strength training with personal trainer', 1, '2025-12-11 09:48:05', '2025-12-19 02:25:00'),
(11, 3, NULL, NULL, 4, '2025-12-06', NULL, '07:00:00', '08:00:00', 'GROUP', 'Completed', 'Pending', NULL, 'Zumba class test', 1, '2025-12-11 09:48:33', '2026-01-03 10:06:00'),
(16, 68, 87, NULL, 1, '2025-12-25', NULL, '16:54:00', '18:54:00', 'GROUP', 'Cancelled', 'Refunded', NULL, 'testing...........', 33, '2025-12-11 10:24:56', '2025-12-12 10:47:36'),
(23, 94, NULL, NULL, 24, '2025-12-18', NULL, '17:32:00', '18:32:00', 'GROUP', 'Completed', 'Paid', 1200.00, 'test', NULL, '2025-12-19 01:31:48', '2025-12-19 01:31:48'),
(24, 91, 102, NULL, NULL, '2025-12-18', '2025-12-18', '17:42:00', '18:30:00', 'PT', 'Completed', 'Paid', 1200.00, 'test', NULL, '2025-12-19 01:42:26', '2025-12-19 02:31:00'),
(25, 91, 102, NULL, NULL, '2025-12-18', '2025-12-18', '19:08:00', '19:09:00', 'PT', 'Completed', 'Paid', 1200.00, 'test', NULL, '2025-12-19 03:08:03', '2025-12-19 03:09:00'),
(26, 94, 102, NULL, NULL, '2025-12-19', '2025-12-19', '17:53:00', '17:54:00', 'PT', 'Completed', 'Paid', 1200.00, 'test', NULL, '2025-12-20 01:53:12', '2025-12-20 01:53:48'),
(30, 104, 152, NULL, NULL, '2025-12-01', NULL, '10:00:00', '11:00:00', 'GROUP', 'Completed', 'Pending', NULL, NULL, NULL, '2025-12-01 17:30:00', '2025-12-20 22:23:59'),
(31, 104, 152, NULL, NULL, '2025-12-01', NULL, '18:00:00', '19:00:00', 'GROUP', 'Cancelled', 'Pending', NULL, NULL, NULL, '2025-12-02 01:00:00', '2025-12-20 22:23:59'),
(32, 104, 152, NULL, NULL, '2025-12-02', NULL, '09:00:00', '10:00:00', 'GROUP', 'Completed', 'Pending', NULL, NULL, NULL, '2025-12-02 01:00:00', '2026-01-03 10:06:00'),
(39, 95, 102, NULL, NULL, '2025-12-23', '2025-12-23', '12:00:00', '13:00:00', 'PT', 'Completed', 'Pending', 89500.00, 'testing', NULL, '2025-12-23 05:46:00', '2026-01-03 10:06:00'),
(41, 87, 102, NULL, NULL, '2025-12-23', '2025-12-23', '14:00:00', '15:00:00', 'PT', 'Completed', 'Paid', 80000.00, 'Demo', NULL, '2025-12-23 05:54:42', '2026-01-03 10:06:00'),
(42, 95, 102, NULL, NULL, '2025-12-24', '2025-12-24', '13:00:00', '14:00:00', 'PT', 'Completed', 'Pending', 9000.00, 'Testing', NULL, '2025-12-23 06:07:32', '2026-01-03 10:06:00'),
(45, 102, 150, NULL, NULL, '2025-12-31', '2025-12-31', '13:00:00', '14:00:00', 'PT', 'Completed', 'Pending', 89500.00, 'GHGH', NULL, '2025-12-23 06:18:04', '2026-01-03 10:06:00'),
(47, 87, NULL, NULL, 24, '2025-12-29', NULL, '16:54:00', '19:54:00', 'GROUP', 'Completed', 'Pending', 0.00, 'demo', NULL, '2025-12-29 09:25:11', '2026-01-03 10:06:00');

-- --------------------------------------------------------

--
-- Table structure for table `used_qr_nonces`
--

CREATE TABLE `used_qr_nonces` (
  `id` int(11) NOT NULL,
  `nonce` varchar(191) NOT NULL,
  `memberId` int(11) NOT NULL,
  `usedAt` datetime(3) NOT NULL DEFAULT current_timestamp(3)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `adminId` int(11) DEFAULT NULL,
  `fullName` varchar(191) NOT NULL,
  `email` varchar(191) NOT NULL,
  `password` varchar(191) NOT NULL,
  `phone` varchar(191) DEFAULT NULL,
  `roleId` int(11) NOT NULL,
  `branchId` int(11) DEFAULT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `address` varchar(191) DEFAULT NULL,
  `description` varchar(191) DEFAULT NULL,
  `duration` varchar(191) DEFAULT NULL,
  `gymName` varchar(191) DEFAULT NULL,
  `planName` varchar(191) DEFAULT NULL,
  `price` varchar(191) DEFAULT NULL,
  `status` varchar(191) DEFAULT NULL,
  `dateOfBirth` date DEFAULT NULL,
  `gender` varchar(50) DEFAULT NULL,
  `address_street` varchar(191) DEFAULT NULL,
  `address_city` varchar(191) DEFAULT NULL,
  `address_state` varchar(191) DEFAULT NULL,
  `address_zip` varchar(50) DEFAULT NULL,
  `profileImage` varchar(255) DEFAULT NULL,
  `gstNumber` varchar(50) DEFAULT NULL,
  `tax` decimal(10,2) DEFAULT NULL,
  `gymAddress` text DEFAULT NULL,
  `licenseExpiryDate` datetime(3) DEFAULT NULL,
  `licenseKey` varchar(255) DEFAULT NULL,
  `whatsappPlan` varchar(50) NOT NULL DEFAULT 'Basic',
  `permissions` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`permissions`)),
  `visiblePassword` varchar(255) DEFAULT NULL,
  `whatsappCredits` int(11) NOT NULL DEFAULT 0,
  `isTrial` tinyint(1) NOT NULL DEFAULT 0,
  `trialStartDate` datetime DEFAULT NULL,
  `trialEndDate` datetime DEFAULT NULL,
  `subscriptionPlan` varchar(50) DEFAULT 'Basic',
  `trialStatus` varchar(50) DEFAULT 'None'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `adminId`, `fullName`, `email`, `password`, `phone`, `roleId`, `branchId`, `createdAt`, `address`, `description`, `duration`, `gymName`, `planName`, `price`, `status`, `dateOfBirth`, `gender`, `address_street`, `address_city`, `address_state`, `address_zip`, `profileImage`, `gstNumber`, `tax`, `gymAddress`, `licenseExpiryDate`, `licenseKey`, `whatsappPlan`, `permissions`, `visiblePassword`, `whatsappCredits`, `isTrial`, `trialStartDate`, `trialEndDate`, `subscriptionPlan`, `trialStatus`) VALUES
(67, NULL, 'Super Admin', 'superadmin@gmail.com', '$2b$10$VWFhEhOAdiHkoAsgQZEnCOaCbTcPtrOyX8aGYRXqH/okam7tTo6oO', '7034897239', 1, NULL, '2025-12-10 03:22:10.656', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', '', '', '', '', 'https://res.cloudinary.com/dw48hcxi5/image/upload/v1765963346/users/profile/xkzyztng1iiczl2t2aow.jpg', NULL, NULL, NULL, NULL, NULL, 'Basic', NULL, NULL, 0, 0, NULL, NULL, 'Basic', 'None'),
(82, 68, 'John Doe', 'john.doe@example.com', '123', '1234567890', 4, 33, '2025-12-11 23:23:13.000', NULL, NULL, NULL, NULL, NULL, NULL, 'Active', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Basic', NULL, NULL, 0, 0, NULL, NULL, 'Basic', 'None'),
(87, 68, 'Trainer Name', 'trainer@email.com', 'hashed_password_here', '9999999999', 3, 33, '2025-12-12 02:42:45.028', 'Address here', 'Trainer description', '60 mins', 'Gym Name', 'Plan Name', '1500', 'ACTIVE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Basic', NULL, NULL, 0, 0, NULL, NULL, 'Basic', 'None'),
(89, 90, 'John Smith', 'john@gmail.com', '$2b$10$crhZxB76ZuAWo2BDk1i3AednUk5HK2zm4ApRzkyOvnsn90JPMUxPq', '0770090987', 2, 33, '2025-12-12 23:54:44.133', '123 High Street', 'Life Time', 'Yearly', 'GYM Fitness ', 'Pro', '11999', 'active', NULL, NULL, NULL, NULL, NULL, NULL, 'https://res.cloudinary.com/dw48hcxi5/image/upload/v1765963221/users/profile/pytkcnfpl28ilkk9rpxy.png', '976856345', 10.00, 'indore', '2026-06-13 00:00:00.000', NULL, 'Basic', NULL, NULL, 0, 0, NULL, NULL, 'Basic', 'None'),
(90, 90, 'John Admin', 'admin@gmail.com', '$2b$10$crhZxB76ZuAWo2BDk1i3AednUk5HK2zm4ApRzkyOvnsn90JPMUxPq', '9876543210', 2, 48, '2025-12-13 00:01:36.965', '101 Shanti Nagar, Indore, Madhya Pradesh, 452001', 'Life Time', 'Yearly', 'Admin Gym', 'Pro', '11999', 'active', '2005-02-28', 'Male', NULL, NULL, NULL, NULL, 'https://res.cloudinary.com/dw48hcxi5/image/upload/v1765970252/users/profile/gbtbcuht06njylbc71q8.jpg', '8963546345', 10.00, 'indore', '2026-06-15 00:00:00.000', NULL, 'Basic', NULL, NULL, 0, 0, NULL, NULL, 'Basic', 'None'),
(91, 90, 'John Smith', 'smith1@gmail.com', '$2b$10$zO6HvteXi8KfmXtay9soce6aB0ILw3Jwpe.JznL/SthDX9bz1vHRy', '0770097890', 4, NULL, '2025-12-13 02:02:45.418', '123 High Street', NULL, NULL, NULL, NULL, NULL, 'Active', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Basic', NULL, NULL, 0, 0, NULL, NULL, 'Basic', 'None'),
(93, 90, 'raghu Sharma', 'generaltrainer1@gym.com', '$2b$10$Fg6U/kNI6LkwhRzRmAvF7O7GUJqCO2mVRbq.CXOISSoQ7h0rPtKcy', '9988756655', 6, 33, '2025-12-13 03:13:46.354', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2006-06-02', NULL, NULL, NULL, NULL, NULL, 'https://res.cloudinary.com/dw48hcxi5/image/upload/v1765970802/users/profile/x6ie9nhdrlhoreaflybl.jpg', NULL, NULL, NULL, NULL, NULL, 'Basic', NULL, NULL, 0, 0, NULL, NULL, 'Basic', 'None'),
(102, 90, 'Personal', 'personal@gmail.com', '$2b$10$crhZxB76ZuAWo2BDk1i3AednUk5HK2zm4ApRzkyOvnsn90JPMUxPq', '0770097890', 5, 48, '2025-12-15 00:36:25.338', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'https://res.cloudinary.com/dw48hcxi5/image/upload/v1765965240/staff/profile/c7c68vpqtupwigaamwkg.jpg', NULL, NULL, NULL, NULL, NULL, 'Basic', NULL, NULL, 0, 0, NULL, NULL, 'Basic', 'None'),
(103, 90, 'Receptionist', 'receptionist@gmail.com', '$2b$10$crhZxB76ZuAWo2BDk1i3AednUk5HK2zm4ApRzkyOvnsn90JPMUxPq', '0770095678', 7, 48, '2025-12-15 00:37:32.391', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', '', '', '', '', 'https://res.cloudinary.com/dw48hcxi5/image/upload/v1765965219/staff/profile/lh7whqydvmixsaajoyon.jpg', NULL, NULL, NULL, NULL, NULL, 'Basic', NULL, NULL, 0, 0, NULL, NULL, 'Basic', 'None'),
(104, 90, 'Housekeeping', 'housekeeping@gmail.com', '$2b$10$crhZxB76ZuAWo2BDk1i3AednUk5HK2zm4ApRzkyOvnsn90JPMUxPq', '0770012345', 8, 48, '2025-12-15 00:39:37.602', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Basic', NULL, NULL, 0, 0, NULL, NULL, 'Basic', 'None'),
(127, 90, '123', '123@gym.com', '$2b$10$PkIg/YTs4GFAWUYwnr6o1e9PlFbK7IuOFETGP28n2bTpf5py.dSQK', NULL, 6, NULL, '2025-12-17 13:14:23.306', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Basic', NULL, NULL, 0, 0, NULL, NULL, 'Basic', 'None'),
(128, NULL, 'TestSuperadmin', 'test123@gmail.com', '$2b$10$ImJP5DumtcqVUzwlTZnDwuvXMnyp6yE0H5bk/KHl25tHNRipIepBC', NULL, 1, NULL, '2025-12-17 13:20:31.038', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Basic', NULL, NULL, 0, 0, NULL, NULL, 'Basic', 'None'),
(129, 90, 'rahul123', '234@gmail.com', '$2b$10$CCbyKzVjMOEP7xq6UPgU1.bDEOR0yi.yCgQhSDqDS1xvSV0dkhPPq', NULL, 6, NULL, '2025-12-17 13:30:40.057', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Basic', NULL, NULL, 0, 0, NULL, NULL, 'Basic', 'None'),
(130, 90, 'rahul123', 'r234@gmail.com', '$2b$10$g6PuRz2uxw.llLUKa1w3hu9mR0BMAvnxnHj0IvVX3tnA.tmANv66i', NULL, 6, NULL, '2025-12-17 13:45:55.622', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Basic', NULL, NULL, 0, 0, NULL, NULL, 'Basic', 'None'),
(131, 90, '', '', '$2b$10$hK5NbZFxxE5oe4fAHDk5FuGjKtKhOyaKcnAt6S.r2cSMWCbGCcW..', NULL, 6, NULL, '2025-12-17 13:48:50.667', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'https://res.cloudinary.com/dw48hcxi5/image/upload/v1765960702/users/profile/mfamodv3su9hqpihgbts.jpg', NULL, NULL, NULL, NULL, NULL, 'Basic', NULL, NULL, 0, 0, NULL, NULL, 'Basic', 'None'),
(132, 90, 'raj', 'rrre234@gmail.com', '$2b$10$OIiDwkm7/xZiPfeYEPayRObo0G4yIWuynv4Tnc0UOhMjqXwbBcIAu', NULL, 6, NULL, '2025-12-17 14:14:40.362', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'https://res.cloudinary.com/dw48hcxi5/image/upload/v1765961939/users/profile/kosfccw9efeg1s3qh9h5.jpg', NULL, NULL, NULL, NULL, NULL, 'Basic', NULL, NULL, 0, 0, NULL, NULL, 'Basic', 'None'),
(134, 90, 'Rohit Kumar', 'rohit456@mail.com', '$2b$10$6BFA4S.4C2OdEbLq3jlL/.Nbkak1yBlyDZtJC3tTVXnbaO4RRPE1.', '987654321', 4, 33, '2025-12-17 14:36:01.711', 'India', 'https://res.cloudinary.com/dw48hcxi5/image/upload/v1765962394/users/profile/fgk2ftzwjrer6rjdrl2z.jpg', NULL, NULL, NULL, NULL, 'Active', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Basic', NULL, NULL, 0, 0, NULL, NULL, 'Basic', 'None'),
(139, 90, ' rahul', 'rahul002@gym.com', '$2b$10$pvhaHp/z.YoHfEse3..5S.A9ym7Y8jC7g4RrSMhtBSpyIA8PL1qma', ' 9988756655', 6, 48, '2025-12-17 15:13:24.845', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Basic', NULL, NULL, 0, 0, NULL, NULL, 'Basic', 'None'),
(143, 90, ' Rahul', 'rahul00824@gym.com', '$2b$10$tFMKmeRwvdpVXfwItcqkl.70ad4ocEJVnR1mCGLnvgnDF/4YTYpuW', ' 9988756655', 6, 48, '2025-12-17 15:55:53.103', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'https://res.cloudinary.com/dw48hcxi5/image/upload/v1765967835/staff/profile/khdz5xzbulleabjfnldd.jpg', NULL, NULL, NULL, NULL, NULL, 'Basic', NULL, NULL, 0, 0, NULL, NULL, 'Basic', 'None'),
(150, 90, 'Mike Trainer', 'mike.trainer@example.com', '123', '07700900123', 5, 48, '2025-12-20 12:44:55.000', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Basic', NULL, NULL, 0, 0, NULL, NULL, 'Basic', 'None'),
(151, 90, 'Sam Member', 'sam.member@example.com', '123', NULL, 4, NULL, '2025-12-20 12:45:55.000', NULL, NULL, NULL, NULL, NULL, NULL, 'Active', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Basic', NULL, NULL, 0, 0, NULL, NULL, 'Basic', 'None'),
(161, 90, 'Rohit Kumar', 'rohit@gmail.com', '$2b$10$nnumGwAtIfMi01Q/Hfz5ju6JtgpCBUm9epgFp1u13yT8A1O0mYWiq', '682834545639', 4, NULL, '2025-12-29 15:57:21.147', 'demo', NULL, NULL, NULL, NULL, NULL, 'Active', '2025-12-29', NULL, NULL, NULL, NULL, NULL, 'https://res.cloudinary.com/dw48hcxi5/image/upload/v1767004767/users/profile/zrfba7hmbyxefjh5xujl.jpg', NULL, NULL, NULL, NULL, NULL, 'Basic', NULL, NULL, 0, 0, NULL, NULL, 'Basic', 'None'),
(163, 90, 'Mamber', 'member@gmail.com', '$2b$10$xEWpenRf963lBG1OsqEPx.LYqT5P.yNvOP1MuZvf4ZCiNrqTx1TFa', '07008795635', 4, NULL, '2025-12-29 16:06:39.494', 'indore', NULL, NULL, NULL, NULL, NULL, 'Active', '2025-12-13', NULL, NULL, NULL, NULL, NULL, 'https://res.cloudinary.com/dw48hcxi5/image/upload/v1767004755/users/profile/z1wpk3vxcezt0nwbav81.jpg', NULL, NULL, NULL, NULL, NULL, 'Basic', NULL, NULL, 0, 0, NULL, NULL, 'Basic', 'None'),
(165, 164, 'Personal', 'personal3@gmail.com', '$2b$10$KP/r4CKd5DeUNztlbbRj8.v/LJPovrnk7suXUct7LjHVvZDZyPwNu', '8014535433', 5, 33, '2025-12-29 16:53:55.913', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'https://res.cloudinary.com/dw48hcxi5/image/upload/v1767007436/staff/profile/aqmv4lztzvf2y3woa0f9.jpg', NULL, NULL, NULL, NULL, NULL, 'Basic', NULL, NULL, 0, 0, NULL, NULL, 'Basic', 'None'),
(166, 164, 'General', 'general3@gmail.com', '$2b$10$WUXme3IFWdWoL4FYB23CtOUgQaSI02wfiFRRGyKhj7TkQSLvGfLhS', '571423624289', 6, 33, '2025-12-29 16:54:57.611', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'https://res.cloudinary.com/dw48hcxi5/image/upload/v1767007497/staff/profile/le18gj4wul2r43tbphg1.png', NULL, NULL, NULL, NULL, NULL, 'Basic', NULL, NULL, 0, 0, NULL, NULL, 'Basic', 'None'),
(167, 164, 'Housekeeping', 'housekeeping3@gmail.com', '$2b$10$NoEvoNrPUwtBk8C62BWREOTT2lYlU4z1Fss41E1V7O042gSjMOegq', '989543321321', 8, 33, '2025-12-29 16:55:46.503', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'https://res.cloudinary.com/dw48hcxi5/image/upload/v1767007546/staff/profile/htwtaywruuljyzknalqa.png', NULL, NULL, NULL, NULL, NULL, 'Basic', NULL, NULL, 0, 0, NULL, NULL, 'Basic', 'None'),
(168, 164, 'Receptionist Receptionist', 'receptionist3@gmail.com', '$2b$10$V4dr5xmI1ltMe6pltDGpou9cRxOsOzQhUPKh4n7qIt3oYV0u81p76', '9845621357', 7, 33, '2025-12-29 16:56:34.642', 'indore, indore, Madhya Pradesh, 455464', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', 'indore', 'indore', 'Madhya Pradesh', '455464', 'https://res.cloudinary.com/dw48hcxi5/image/upload/v1767007594/staff/profile/eqnhdpvme2f0eborczke.jpg', NULL, NULL, NULL, NULL, NULL, 'Basic', NULL, NULL, 0, 0, NULL, NULL, 'Basic', 'None'),
(169, 164, 'Demo Member', 'memberdemo@gmail.com', '$2b$10$hf8flVewCsfxdn3CbvF.NukNV9prXOuH4TC7Boh/FIxJVm5KgXYr.', '7891742645', 4, 33, '2025-12-29 17:06:00.646', 'indore, indore, Madhya Pradesh, 48946', NULL, NULL, NULL, NULL, NULL, 'Active', '2025-12-29', 'Male', 'indore', 'indore', 'Madhya Pradesh', '48946', 'https://res.cloudinary.com/dw48hcxi5/image/upload/v1767084270/users/profile/qa26gdzqkf8veywmi6vx.jpg', NULL, NULL, NULL, NULL, NULL, 'Basic', NULL, NULL, 0, 0, NULL, NULL, 'Basic', 'None'),
(177, 164, 'Test', 'test@gmail.com', '$2b$10$JQFPaMODm505YNdSa3bCge63EyiSw7Y2V9WhyitpNzRPZWDebhc9e', '879135465425', 4, NULL, '2025-12-30 17:52:59.452', NULL, NULL, NULL, NULL, NULL, NULL, 'Active', '2025-12-30', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Basic', NULL, NULL, 0, 0, NULL, NULL, 'Basic', 'None'),
(180, 90, 'Smith', 'smith123@gmail.com', '$2b$10$7ntoDhEWiZlFdlCyOxP9SOfZWfYuITkZmYSbJCMj4X5WyCODhVTb2', '07700900123', 4, NULL, '2026-01-01 15:24:58.429', '123 High Street', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-01-01', NULL, NULL, NULL, NULL, NULL, 'https://res.cloudinary.com/dw48hcxi5/image/upload/v1767262712/users/profile/byjee88vrwtqu5i6x41p.jpg', NULL, NULL, NULL, NULL, NULL, 'Basic', NULL, NULL, 0, 0, NULL, NULL, 'Basic', 'None'),
(181, 90, 'JohnBhai', 'johnbhai@gmail.com', '$2b$10$DVcK8vbOtNGyRVngB4jH2uPJ68ZAUtdgSgGRt/gi7MsXz8OsKmHt2', '07700900123', 5, 48, '2026-01-01 17:51:36.304', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Basic', NULL, NULL, 0, 0, NULL, NULL, 'Basic', 'None'),
(182, 164, 'General4', 'general4@gmail.com', '$2b$10$wwyyXWykD5NCndwJV5gXk.RMw8duMKQ64vFQD8GebXZ2oNBlM19xG', '871981682747', 6, 33, '2026-01-01 17:54:18.156', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Basic', NULL, NULL, 0, 0, NULL, NULL, 'Basic', 'None'),
(183, 164, 'HouseKeeping4', 'house@gmail.com', '$2b$10$yoZ.BHNLBgq6rQi/nwpuPuXraEe46KuvrEUz6w1PIrPjlGMXhZ2VK', '12435346456456', 8, 33, '2026-01-01 18:07:22.012', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Basic', NULL, NULL, 0, 0, NULL, NULL, 'Basic', 'None'),
(184, 90, 'Aman', 'aman@gmail.com', '$2b$10$ZxtsyaU4dDrneMfMXq.XUeGZUjF.6kfl1Poc/8.gHDTnBKknsVNLO', '456789091', 4, NULL, '2026-01-01 18:36:41.849', '123 High Street', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-01-01', NULL, NULL, NULL, NULL, NULL, 'https://res.cloudinary.com/dw48hcxi5/image/upload/v1767272799/users/profile/uwjjrwnuskexslwdvy2j.jpg', NULL, NULL, NULL, NULL, NULL, 'Basic', NULL, NULL, 0, 0, NULL, NULL, 'Basic', 'None'),
(186, 90, 'Test', 'test456@gmail.com', '$2b$10$CRvGCaT79xkIwEVonQLJg.ChAdZuJkbsStTw/cgJISwxBUUrEl0Si', '34567890', 4, NULL, '2026-01-02 12:21:50.165', '123 Indore Street', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-01-02', NULL, NULL, NULL, NULL, NULL, 'https://res.cloudinary.com/dw48hcxi5/image/upload/v1767336709/users/profile/tq61112zew86fjczatbd.jpg', NULL, NULL, NULL, NULL, NULL, 'Basic', NULL, NULL, 0, 0, NULL, NULL, 'Basic', 'None'),
(188, 90, 'asdf', 'asdf@gmail.com', '$2b$10$P1fIb5egWqxH7S4amwnnqOf1/d7tcelpX77NzFK54Hm5FPewkwOBS', '12345678', 4, NULL, '2026-01-02 14:19:42.765', 'Rau Circle Indore', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-01-02', NULL, NULL, NULL, NULL, NULL, 'https://res.cloudinary.com/dw48hcxi5/image/upload/v1767343782/users/profile/lnubvnapjqdgz2n1hl1u.jpg', NULL, NULL, NULL, NULL, NULL, 'Basic', NULL, NULL, 0, 0, NULL, NULL, 'Basic', 'None'),
(191, 90, 'Jay', 'jay9977@gmai.com', '$2b$10$KU1zkLdI6QnhXpNbQyJc2OM76Cj23XiXkvWdzFfEwhGFuPhhK6uea', '12345678', 4, NULL, '2026-01-03 12:48:51.513', 'Rau Circle Indore', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-01-03', NULL, NULL, NULL, NULL, NULL, 'https://res.cloudinary.com/dw48hcxi5/image/upload/v1767424730/users/profile/t3vocb9zaytadfvise0t.jpg', NULL, NULL, NULL, NULL, NULL, 'Basic', NULL, NULL, 0, 0, NULL, NULL, 'Basic', 'None'),
(206, 90, 'demo', 'demo2345@gmail.com', '$2b$10$v6DqlyDOVoU7exUJEUl6.eQCddyeMzj8D5PSWa1.ip3cYCYNRrUVe', '2324343432', 4, NULL, '2026-01-07 16:44:54.892', '123 High Street', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-01-07', NULL, NULL, NULL, NULL, NULL, 'https://res.cloudinary.com/dw48hcxi5/image/upload/v1767784493/users/profile/s5v8jn3owxbhnaclxr4n.jpg', NULL, 5.00, NULL, NULL, NULL, 'Basic', NULL, NULL, 0, 0, NULL, NULL, 'Basic', 'None'),
(207, 90, 'test', 'test56789@gmail.com', '$2b$10$Dmx9ORgIWOrzsWAYKOYFMe.4jsYNP0QsdwdlYnTPCAVlQxaqHiuyi', '123456789', 4, NULL, '2026-01-08 14:51:31.410', '123 High Street', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-01-08', NULL, NULL, NULL, NULL, NULL, 'https://res.cloudinary.com/dw48hcxi5/image/upload/v1767864090/users/profile/yjylix8eylk2x6pkk30j.jpg', NULL, 5.00, NULL, NULL, NULL, 'Basic', NULL, NULL, 0, 0, NULL, NULL, 'Basic', 'None'),
(208, 90, 'vaani', 'vaani@gmail.com', '$2b$10$klEZnyQwTbcJl3cIWr/ARueHR5WWJC0EvvJ1dT67wrWHdZhV9V98C', '7788994457', 4, NULL, '2026-06-05 14:32:16.666', 'greater indore', NULL, NULL, NULL, NULL, NULL, 'Active', NULL, NULL, NULL, NULL, NULL, NULL, 'https://res.cloudinary.com/dw48hcxi5/image/upload/v1780650160/users/profile/iwrajebny2pegioajkwk.jpg', NULL, NULL, NULL, NULL, NULL, 'Basic', NULL, NULL, 0, 0, NULL, NULL, 'Basic', 'None'),
(209, 90, 'abc', 'abc@gmail.com', '$2b$10$1QFHDVAv22B5cH9a0uQQVuIURBVkuVLPaLM5AMW..V9Tqyxio5NYO', '1111112222', 4, NULL, '2026-06-08 15:52:49.271', 'greater indore', NULL, NULL, NULL, NULL, NULL, 'Active', '2026-06-01', NULL, NULL, NULL, NULL, NULL, 'https://res.cloudinary.com/dw48hcxi5/image/upload/v1780914171/users/profile/lwfkio2idurffvbap9ey.jpg', NULL, NULL, NULL, NULL, NULL, 'Basic', NULL, NULL, 0, 0, NULL, NULL, 'Basic', 'None'),
(210, 90, 'sales', 'sales@gmail.com', '$2b$10$1eAtUAkWwPHuvCsqqyAhheApoj14YgEFnOhfJB2rS9veKHeFLyD2q', '1122336699', 7, 48, '2026-06-08 18:00:17.584', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Basic', NULL, NULL, 0, 0, NULL, NULL, 'Basic', 'None'),
(214, NULL, 'admin0', 'admin0@gmail.com', '$2b$10$NUZDOvygsHJ7zM/XCLX.3.Gc5ZWNMW/ThVK86B9OlZ00TcsigjD/m', '2255889944', 9, NULL, '2026-06-09 18:12:22.845', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'https://res.cloudinary.com/dw48hcxi5/image/upload/v1781008946/users/profile/ltaxk1vhtswyiijawa8k.png', NULL, NULL, NULL, NULL, NULL, 'Basic', '[\"Dashboard\",\"Payments\",\"Gym Owners\"]', '123456', 0, 0, NULL, NULL, 'Basic', 'None'),
(215, 90, 'jem', 'jem@gmail.com', '$2b$10$ML1HcNIW1tf.gDEFWaN4h.s9NMaSZgnqpmbq4ju64H8X.Ti2UDMsG', '101010101010', 2, 50, '2026-06-13 14:44:58.363', 'greater indore', 'Life Time', 'Yearly', 'GYM Fitness ', 'Pro', '11999', 'active', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '74AS741851526', 10.00, 'greater indore', '2026-06-29 00:00:00.000', NULL, 'Basic', NULL, NULL, 0, 0, NULL, NULL, 'Basic', 'None'),
(216, 90, 'sara', 'sara@gmail.com', '$2b$10$HJq02i6VyjOMgjeA6vNyYuIyOSRbyr0OJIhCKGGJPHJjEyCKdUKcO', '101010101010', 2, 50, '2026-06-13 14:52:46.378', 'greater indore', 'Life Time', 'Yearly', 'GYM Fitness ', 'Pro', '11999', 'active', NULL, NULL, NULL, NULL, NULL, NULL, 'https://res.cloudinary.com/dw48hcxi5/image/upload/v1781342574/users/profile/c3kqwbvvneetjrlxbxxe.jpg', '976856345', 5.00, 'greater indore', NULL, NULL, 'Basic', NULL, NULL, 0, 0, NULL, NULL, 'Basic', 'None'),
(218, NULL, 'admin2', 'admin2@gmail.com', '$2b$10$Vn16r2VQLEBXez7bAGhf5uMlBnB9JqezPZ1avjHsix27yccMjbIem', '101010101010', 9, NULL, '2026-06-13 15:15:52.823', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'https://res.cloudinary.com/dw48hcxi5/image/upload/v1781343960/users/profile/ek3uravjelxraqi5lypx.png', NULL, NULL, NULL, NULL, NULL, 'Basic', '[\"Dashboard\",\"Leads / Inquiries\",\"Branches\",\"Gym Owners\"]', '123456', 0, 0, NULL, NULL, 'Basic', 'None'),
(219, 216, 'kkk', 'kkkk@gmail.com', '$2b$10$X7Egrr8ApuijHOvfJ/vN.uB9wBa5mo7YW7uv7C1dBd0ve.AYj7lfq', '101010101010', 5, 50, '2026-06-13 15:37:22.696', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'https://res.cloudinary.com/dw48hcxi5/image/upload/v1781345250/staff/profile/qm4fsxd0zmh0tyc0jgo1.jpg', NULL, NULL, NULL, NULL, NULL, 'Basic', NULL, NULL, 0, 0, NULL, NULL, 'Basic', 'None'),
(220, 216, 'sarah', 'sarah123@gmail.com', '$2b$10$wIknGYilm60SUH302rFVfuK7.RIFP.kfoHc6JxcThONy/vvr1WvUy', '101010101010', 4, NULL, '2026-06-13 15:39:22.634', NULL, NULL, NULL, NULL, NULL, NULL, 'Active', '2003-02-14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Basic', NULL, NULL, 0, 0, NULL, NULL, 'Basic', 'None'),
(221, 90, 'vamika', 'vamika@gmail.com', '$2b$10$4E0FFfewEHoqb6wypVKFP.G3cD50Co9D4tyH1LjWtVhijf/SjMlDK', '5858585858', 4, NULL, '2026-06-13 16:11:38.995', 'greater indore', NULL, NULL, NULL, NULL, NULL, 'Active', '2006-01-03', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Basic', NULL, NULL, 0, 0, NULL, NULL, 'Basic', 'None'),
(222, 90, 'maddii', 'maddii@gmail.com', '$2b$10$jkhGEKd5jS5btKdbxdYjaeg24pfLKgCcLD7u8dUKLDKIB6GgezHja', '101010101010', 4, NULL, '2026-06-13 16:26:07.482', 'greater indore', NULL, NULL, NULL, NULL, NULL, 'Active', '2013-01-29', NULL, NULL, NULL, NULL, NULL, 'https://res.cloudinary.com/dw48hcxi5/image/upload/v1781348175/users/profile/yddyqhpjv9tfdsfzhmqq.jpg', NULL, NULL, NULL, NULL, NULL, 'Basic', NULL, NULL, 0, 0, NULL, NULL, 'Basic', 'None'),
(223, 90, 'test_maddii_2', 'test_maddii_2@gmail.com', '$2b$10$HwY4bjVtTQ1zsnGhr6Y6W./Y2x6sFNFt/PWlGgf3Lsxgm/iXgOlum', '9999999999', 4, NULL, '2026-06-13 16:35:14.529', 'greater indore', NULL, NULL, NULL, NULL, NULL, 'Active', '2013-01-29', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Basic', NULL, NULL, 0, 0, NULL, NULL, 'Basic', 'None'),
(224, 90, 'demo boy', 'demoboy@gmail.com', '$2b$10$xMgLjnERgs3JU4toOTxGV.W9l0L1bUE39v5/Pi7fTJ24EqhNoRDYK', '7894561234', 4, NULL, '2026-06-15 14:21:59.005', 'demo street, demo city ', NULL, NULL, NULL, NULL, NULL, 'Active', '1998-12-28', NULL, NULL, NULL, NULL, NULL, 'https://res.cloudinary.com/dw48hcxi5/image/upload/v1781513517/users/profile/egljij6lqw3qbkblb80r.jpg', NULL, NULL, NULL, NULL, NULL, 'Basic', NULL, NULL, 0, 0, NULL, NULL, 'Basic', 'None'),
(225, 90, 'Demo girl', 'demogirl@gmail.com', '$2b$10$oQ/0HcuOdFAY/.NkIooRee2HS.XGtlw7.6DI3xwi3AGeN1T6Gsdjq', '457869123', 4, NULL, '2026-06-15 15:11:44.759', 'demo street', NULL, NULL, NULL, NULL, NULL, 'Active', '1999-08-21', NULL, NULL, NULL, NULL, NULL, 'https://res.cloudinary.com/dw48hcxi5/image/upload/v1781516504/users/profile/e9x7ms3n7ay59oj0gc97.jpg', NULL, NULL, NULL, NULL, NULL, 'Basic', NULL, NULL, 0, 0, NULL, NULL, 'Basic', 'None'),
(226, 90, 'aarti demo ', 'housekeeping1@gmail.com', '$2b$10$bx6O2SII1NeThTrDjACaN.esl03kAjc4ut.vwCTWLeggOpn5hmB/K', '745859612345', 8, 48, '2026-06-16 16:42:45.573', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'https://res.cloudinary.com/dw48hcxi5/image/upload/v1781608364/staff/profile/ubhc9ahy3l3vqm3r6hmz.jpg', NULL, NULL, NULL, NULL, NULL, 'Basic', NULL, NULL, 0, 0, NULL, NULL, 'Basic', 'None'),
(227, 90, 'Demo Aayush', 'demoaayu@gmail.com', '$2b$10$/qC8JqA2Yq6IxtKKEGJey.btosdudsAV5IQCuoRnb05v0nUyFXd.q', '1234567890', 4, NULL, '2026-06-17 13:28:37.723', 'demo street', NULL, NULL, NULL, NULL, NULL, 'Active', '2002-01-01', NULL, NULL, NULL, NULL, NULL, 'https://res.cloudinary.com/dw48hcxi5/image/upload/v1781683117/users/profile/f5kzs3ldapiae0kogzzl.jpg', NULL, NULL, NULL, NULL, NULL, 'Basic', NULL, NULL, 0, 0, NULL, NULL, 'Basic', 'None'),
(228, 90, 'Dummy Lead 1', 'dummy.lead1@example.com', '$2b$10$XOroeua9HURQPyWvfQx9ROfv/x.MSxuEGc4ySVMZh0IiNSpreELbG', '9000000001', 4, NULL, '2026-06-17 14:33:22.870', 'xyz', NULL, NULL, NULL, NULL, NULL, 'Active', '2000-08-07', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Basic', NULL, NULL, 0, 0, NULL, NULL, 'Basic', 'None'),
(229, 90, 'Sales Agent', 'salesagent@gmail.com', '$2b$10$4qA1AkvgZkxtHUYLQJIjWencWdrdBwbDv0cYHrD2so1DAyJMICU.O', NULL, 10, 48, '2026-06-19 14:38:31.187', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Basic', NULL, NULL, 0, 0, NULL, NULL, 'Basic', 'None');

-- --------------------------------------------------------

--
-- Table structure for table `whatsapp_credit_transactions`
--

CREATE TABLE `whatsapp_credit_transactions` (
  `id` int(11) NOT NULL,
  `adminId` int(11) NOT NULL,
  `creditsPurchased` int(11) NOT NULL,
  `amountPaid` double NOT NULL,
  `paymentStatus` varchar(50) NOT NULL,
  `transactionId` varchar(191) DEFAULT NULL,
  `createdAt` datetime DEFAULT current_timestamp(),
  `transactionType` enum('PURCHASE','USAGE','REFUND') DEFAULT 'USAGE',
  `description` varchar(255) DEFAULT NULL,
  `userId` int(11) NOT NULL,
  `creditsAdded` int(11) DEFAULT 0,
  `creditsUsed` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `workoutexercise`
--

CREATE TABLE `workoutexercise` (
  `id` int(11) NOT NULL,
  `workoutPlanId` int(11) NOT NULL,
  `name` varchar(191) NOT NULL,
  `sets` int(11) DEFAULT NULL,
  `reps` int(11) DEFAULT NULL,
  `duration` varchar(191) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `workoutplan`
--

CREATE TABLE `workoutplan` (
  `id` int(11) NOT NULL,
  `title` varchar(191) NOT NULL,
  `notes` varchar(191) DEFAULT NULL,
  `createdBy` int(11) NOT NULL,
  `branchId` int(11) NOT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT current_timestamp(3)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `workoutplanassignment`
--

CREATE TABLE `workoutplanassignment` (
  `id` int(11) NOT NULL,
  `workoutPlanId` int(11) NOT NULL,
  `memberId` int(11) NOT NULL,
  `assignedAt` datetime(3) NOT NULL DEFAULT current_timestamp(3)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `alert`
--
ALTER TABLE `alert`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Alert_branchId_idx` (`branchId`),
  ADD KEY `Alert_memberId_idx` (`memberId`),
  ADD KEY `Alert_staffId_idx` (`staffId`);

--
-- Indexes for table `announcement`
--
ALTER TABLE `announcement`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `app_settings`
--
ALTER TABLE `app_settings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `automation_settings`
--
ALTER TABLE `automation_settings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `booking`
--
ALTER TABLE `booking`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Booking_memberId_idx` (`memberId`),
  ADD KEY `Booking_scheduleId_idx` (`scheduleId`);

--
-- Indexes for table `booking_requests`
--
ALTER TABLE `booking_requests`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `branch`
--
ALTER TABLE `branch`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Branch_adminId_fkey` (`adminId`);

--
-- Indexes for table `classschedule`
--
ALTER TABLE `classschedule`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ClassSchedule_branchId_idx` (`adminId`),
  ADD KEY `ClassSchedule_trainerId_idx` (`trainerId`);

--
-- Indexes for table `classtype`
--
ALTER TABLE `classtype`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `credit_packages`
--
ALTER TABLE `credit_packages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `demo_requests`
--
ALTER TABLE `demo_requests`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `dietmeal`
--
ALTER TABLE `dietmeal`
  ADD PRIMARY KEY (`id`),
  ADD KEY `DietMeal_dietPlanId_idx` (`dietPlanId`);

--
-- Indexes for table `dietplan`
--
ALTER TABLE `dietplan`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `dietplanassignment`
--
ALTER TABLE `dietplanassignment`
  ADD PRIMARY KEY (`id`),
  ADD KEY `DietPlanAssignment_dietPlanId_idx` (`dietPlanId`),
  ADD KEY `DietPlanAssignment_memberId_idx` (`memberId`);

--
-- Indexes for table `equipment_requests`
--
ALTER TABLE `equipment_requests`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `expense`
--
ALTER TABLE `expense`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Expense_branchId_idx` (`branchId`);

--
-- Indexes for table `global_settings`
--
ALTER TABLE `global_settings`
  ADD PRIMARY KEY (`key_name`);

--
-- Indexes for table `group_class_bookings`
--
ALTER TABLE `group_class_bookings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `gym_equipment`
--
ALTER TABLE `gym_equipment`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `housekeepingattendance`
--
ALTER TABLE `housekeepingattendance`
  ADD PRIMARY KEY (`id`),
  ADD KEY `staffId` (`staffId`),
  ADD KEY `createdById` (`createdById`);

--
-- Indexes for table `housekeepingschedule`
--
ALTER TABLE `housekeepingschedule`
  ADD PRIMARY KEY (`id`),
  ADD KEY `staffId` (`staffId`),
  ADD KEY `createdById` (`createdById`);

--
-- Indexes for table `landing_page_cms`
--
ALTER TABLE `landing_page_cms`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `leads`
--
ALTER TABLE `leads`
  ADD PRIMARY KEY (`id`),
  ADD KEY `leads_adminId_fkey` (`adminId`),
  ADD KEY `leads_assignedToStaffId_fkey` (`assignedToStaffId`);

--
-- Indexes for table `marketing_campaigns`
--
ALTER TABLE `marketing_campaigns`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `member`
--
ALTER TABLE `member`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `Member_email_key` (`email`),
  ADD KEY `Member_branchId_idx` (`branchId`),
  ADD KEY `fk_member_user` (`userId`);

--
-- Indexes for table `memberattendance`
--
ALTER TABLE `memberattendance`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `memberplan`
--
ALTER TABLE `memberplan`
  ADD PRIMARY KEY (`id`),
  ADD KEY `MemberPlan_adminId_fkey` (`adminId`);

--
-- Indexes for table `membership_renewal_requests`
--
ALTER TABLE `membership_renewal_requests`
  ADD PRIMARY KEY (`id`),
  ADD KEY `memberId` (`memberId`),
  ADD KEY `assignmentId` (`assignmentId`),
  ADD KEY `planId` (`planId`),
  ADD KEY `requestedBy` (`requestedBy`),
  ADD KEY `status` (`status`);

--
-- Indexes for table `member_assessments`
--
ALTER TABLE `member_assessments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `member_assessments_memberId_idx` (`memberId`),
  ADD KEY `idx_leaderboard` (`fitness_goal`,`final_leaderboard_score`);

--
-- Indexes for table `member_bodybuilding_logs`
--
ALTER TABLE `member_bodybuilding_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `memberId` (`memberId`);

--
-- Indexes for table `member_health_log`
--
ALTER TABLE `member_health_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `member_health_log_memberId_fkey` (`memberId`);

--
-- Indexes for table `member_plan_assignment`
--
ALTER TABLE `member_plan_assignment`
  ADD PRIMARY KEY (`id`),
  ADD KEY `member_plan_assignment_memberId_idx` (`memberId`),
  ADD KEY `member_plan_assignment_planId_idx` (`planId`),
  ADD KEY `member_plan_assignment_status_idx` (`status`);

--
-- Indexes for table `message_templates`
--
ALTER TABLE `message_templates`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `templateType` (`templateType`);

--
-- Indexes for table `notificationlog`
--
ALTER TABLE `notificationlog`
  ADD PRIMARY KEY (`id`),
  ADD KEY `NotificationLog_memberId_idx` (`memberId`);

--
-- Indexes for table `payment`
--
ALTER TABLE `payment`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `Payment_invoiceNo_key` (`invoiceNo`),
  ADD KEY `Payment_memberId_idx` (`memberId`),
  ADD KEY `Payment_planId_idx` (`planId`);

--
-- Indexes for table `personal_notification`
--
ALTER TABLE `personal_notification`
  ADD PRIMARY KEY (`id`),
  ADD KEY `memberId` (`memberId`);

--
-- Indexes for table `plan`
--
ALTER TABLE `plan`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Plan_branchId_idx` (`branchId`);

--
-- Indexes for table `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `Product_sku_key` (`sku`),
  ADD KEY `Product_branchId_idx` (`branchId`);

--
-- Indexes for table `pt_bookings`
--
ALTER TABLE `pt_bookings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_pt_session` (`sessionId`);

--
-- Indexes for table `purchase`
--
ALTER TABLE `purchase`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `role`
--
ALTER TABLE `role`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `Role_name_key` (`name`);

--
-- Indexes for table `saas_payments`
--
ALTER TABLE `saas_payments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `saas_payments_adminId_fkey` (`adminId`);

--
-- Indexes for table `salary`
--
ALTER TABLE `salary`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ux_salary_salaryId` (`salaryId`),
  ADD KEY `idx_salary_staffId` (`staffId`);

--
-- Indexes for table `session`
--
ALTER TABLE `session`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Session_trainerId_idx` (`trainerId`),
  ADD KEY `Session_branchId_idx` (`branchId`);

--
-- Indexes for table `shifts`
--
ALTER TABLE `shifts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `staff`
--
ALTER TABLE `staff`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `staffattendance`
--
ALTER TABLE `staffattendance`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `stockmovement`
--
ALTER TABLE `stockmovement`
  ADD PRIMARY KEY (`id`),
  ADD KEY `StockMovement_productId_idx` (`productId`);

--
-- Indexes for table `tasks`
--
ALTER TABLE `tasks`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `unified_bookings`
--
ALTER TABLE `unified_bookings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `used_qr_nonces`
--
ALTER TABLE `used_qr_nonces`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `used_qr_nonces_nonce_key` (`nonce`),
  ADD KEY `used_qr_nonces_memberId_fkey` (`memberId`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `User_email_key` (`email`),
  ADD KEY `User_branchId_idx` (`branchId`),
  ADD KEY `User_roleId_idx` (`roleId`);

--
-- Indexes for table `whatsapp_credit_transactions`
--
ALTER TABLE `whatsapp_credit_transactions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `workoutexercise`
--
ALTER TABLE `workoutexercise`
  ADD PRIMARY KEY (`id`),
  ADD KEY `WorkoutExercise_workoutPlanId_idx` (`workoutPlanId`);

--
-- Indexes for table `workoutplan`
--
ALTER TABLE `workoutplan`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `workoutplanassignment`
--
ALTER TABLE `workoutplanassignment`
  ADD PRIMARY KEY (`id`),
  ADD KEY `WorkoutPlanAssignment_memberId_idx` (`memberId`),
  ADD KEY `WorkoutPlanAssignment_workoutPlanId_idx` (`workoutPlanId`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `alert`
--
ALTER TABLE `alert`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `announcement`
--
ALTER TABLE `announcement`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `app_settings`
--
ALTER TABLE `app_settings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `automation_settings`
--
ALTER TABLE `automation_settings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `booking`
--
ALTER TABLE `booking`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=44;

--
-- AUTO_INCREMENT for table `booking_requests`
--
ALTER TABLE `booking_requests`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `branch`
--
ALTER TABLE `branch`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- AUTO_INCREMENT for table `classschedule`
--
ALTER TABLE `classschedule`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `classtype`
--
ALTER TABLE `classtype`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `credit_packages`
--
ALTER TABLE `credit_packages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `demo_requests`
--
ALTER TABLE `demo_requests`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `dietmeal`
--
ALTER TABLE `dietmeal`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `dietplan`
--
ALTER TABLE `dietplan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `dietplanassignment`
--
ALTER TABLE `dietplanassignment`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `equipment_requests`
--
ALTER TABLE `equipment_requests`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `expense`
--
ALTER TABLE `expense`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `group_class_bookings`
--
ALTER TABLE `group_class_bookings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `gym_equipment`
--
ALTER TABLE `gym_equipment`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `housekeepingattendance`
--
ALTER TABLE `housekeepingattendance`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `housekeepingschedule`
--
ALTER TABLE `housekeepingschedule`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `landing_page_cms`
--
ALTER TABLE `landing_page_cms`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `leads`
--
ALTER TABLE `leads`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=63;

--
-- AUTO_INCREMENT for table `marketing_campaigns`
--
ALTER TABLE `marketing_campaigns`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `member`
--
ALTER TABLE `member`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=156;

--
-- AUTO_INCREMENT for table `memberattendance`
--
ALTER TABLE `memberattendance`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=107;

--
-- AUTO_INCREMENT for table `memberplan`
--
ALTER TABLE `memberplan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=47;

--
-- AUTO_INCREMENT for table `membership_renewal_requests`
--
ALTER TABLE `membership_renewal_requests`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `member_assessments`
--
ALTER TABLE `member_assessments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `member_bodybuilding_logs`
--
ALTER TABLE `member_bodybuilding_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `member_health_log`
--
ALTER TABLE `member_health_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `member_plan_assignment`
--
ALTER TABLE `member_plan_assignment`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=64;

--
-- AUTO_INCREMENT for table `message_templates`
--
ALTER TABLE `message_templates`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `notificationlog`
--
ALTER TABLE `notificationlog`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=42;

--
-- AUTO_INCREMENT for table `payment`
--
ALTER TABLE `payment`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `personal_notification`
--
ALTER TABLE `personal_notification`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `plan`
--
ALTER TABLE `plan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `product`
--
ALTER TABLE `product`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pt_bookings`
--
ALTER TABLE `pt_bookings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `purchase`
--
ALTER TABLE `purchase`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `role`
--
ALTER TABLE `role`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `saas_payments`
--
ALTER TABLE `saas_payments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `salary`
--
ALTER TABLE `salary`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `session`
--
ALTER TABLE `session`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=45;

--
-- AUTO_INCREMENT for table `shifts`
--
ALTER TABLE `shifts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=63;

--
-- AUTO_INCREMENT for table `staff`
--
ALTER TABLE `staff`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=54;

--
-- AUTO_INCREMENT for table `staffattendance`
--
ALTER TABLE `staffattendance`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `stockmovement`
--
ALTER TABLE `stockmovement`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tasks`
--
ALTER TABLE `tasks`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

--
-- AUTO_INCREMENT for table `unified_bookings`
--
ALTER TABLE `unified_bookings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=62;

--
-- AUTO_INCREMENT for table `used_qr_nonces`
--
ALTER TABLE `used_qr_nonces`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=230;

--
-- AUTO_INCREMENT for table `whatsapp_credit_transactions`
--
ALTER TABLE `whatsapp_credit_transactions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `workoutexercise`
--
ALTER TABLE `workoutexercise`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `workoutplan`
--
ALTER TABLE `workoutplan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `workoutplanassignment`
--
ALTER TABLE `workoutplanassignment`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `alert`
--
ALTER TABLE `alert`
  ADD CONSTRAINT `Alert_branchId_fkey` FOREIGN KEY (`branchId`) REFERENCES `branch` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `Alert_memberId_fkey` FOREIGN KEY (`memberId`) REFERENCES `member` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `Alert_staffId_fkey` FOREIGN KEY (`staffId`) REFERENCES `user` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `booking`
--
ALTER TABLE `booking`
  ADD CONSTRAINT `Booking_memberId_fkey` FOREIGN KEY (`memberId`) REFERENCES `member` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `Booking_scheduleId_fkey` FOREIGN KEY (`scheduleId`) REFERENCES `classschedule` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `branch`
--
ALTER TABLE `branch`
  ADD CONSTRAINT `Branch_adminId_fkey` FOREIGN KEY (`adminId`) REFERENCES `user` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `classschedule`
--
ALTER TABLE `classschedule`
  ADD CONSTRAINT `ClassSchedule_trainerId_fkey` FOREIGN KEY (`trainerId`) REFERENCES `user` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `dietmeal`
--
ALTER TABLE `dietmeal`
  ADD CONSTRAINT `DietMeal_dietPlanId_fkey` FOREIGN KEY (`dietPlanId`) REFERENCES `dietplan` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `dietplanassignment`
--
ALTER TABLE `dietplanassignment`
  ADD CONSTRAINT `DietPlanAssignment_dietPlanId_fkey` FOREIGN KEY (`dietPlanId`) REFERENCES `dietplan` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `DietPlanAssignment_memberId_fkey` FOREIGN KEY (`memberId`) REFERENCES `member` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `expense`
--
ALTER TABLE `expense`
  ADD CONSTRAINT `Expense_branchId_fkey` FOREIGN KEY (`branchId`) REFERENCES `branch` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `leads`
--
ALTER TABLE `leads`
  ADD CONSTRAINT `leads_adminId_fkey` FOREIGN KEY (`adminId`) REFERENCES `user` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `leads_assignedToStaffId_fkey` FOREIGN KEY (`assignedToStaffId`) REFERENCES `staff` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `member`
--
ALTER TABLE `member`
  ADD CONSTRAINT `Member_branchId_fkey` FOREIGN KEY (`branchId`) REFERENCES `branch` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_member_user` FOREIGN KEY (`userId`) REFERENCES `user` (`id`);

--
-- Constraints for table `membership_renewal_requests`
--
ALTER TABLE `membership_renewal_requests`
  ADD CONSTRAINT `membership_renewal_requests_assignmentId_fkey` FOREIGN KEY (`assignmentId`) REFERENCES `member_plan_assignment` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `membership_renewal_requests_memberId_fkey` FOREIGN KEY (`memberId`) REFERENCES `member` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `membership_renewal_requests_planId_fkey` FOREIGN KEY (`planId`) REFERENCES `memberplan` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `member_assessments`
--
ALTER TABLE `member_assessments`
  ADD CONSTRAINT `member_assessments_memberId_fkey` FOREIGN KEY (`memberId`) REFERENCES `member` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `member_bodybuilding_logs`
--
ALTER TABLE `member_bodybuilding_logs`
  ADD CONSTRAINT `member_bodybuilding_logs_ibfk_1` FOREIGN KEY (`memberId`) REFERENCES `member` (`id`);

--
-- Constraints for table `member_health_log`
--
ALTER TABLE `member_health_log`
  ADD CONSTRAINT `member_health_log_memberId_fkey` FOREIGN KEY (`memberId`) REFERENCES `member` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `member_plan_assignment`
--
ALTER TABLE `member_plan_assignment`
  ADD CONSTRAINT `member_plan_assignment_memberId_fkey` FOREIGN KEY (`memberId`) REFERENCES `member` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `member_plan_assignment_planId_fkey` FOREIGN KEY (`planId`) REFERENCES `memberplan` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `notificationlog`
--
ALTER TABLE `notificationlog`
  ADD CONSTRAINT `NotificationLog_memberId_fkey` FOREIGN KEY (`memberId`) REFERENCES `member` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `payment`
--
ALTER TABLE `payment`
  ADD CONSTRAINT `Payment_memberId_fkey` FOREIGN KEY (`memberId`) REFERENCES `member` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `Payment_planId_fkey` FOREIGN KEY (`planId`) REFERENCES `plan` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `plan`
--
ALTER TABLE `plan`
  ADD CONSTRAINT `Plan_branchId_fkey` FOREIGN KEY (`branchId`) REFERENCES `branch` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `product`
--
ALTER TABLE `product`
  ADD CONSTRAINT `Product_branchId_fkey` FOREIGN KEY (`branchId`) REFERENCES `branch` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `pt_bookings`
--
ALTER TABLE `pt_bookings`
  ADD CONSTRAINT `fk_pt_session` FOREIGN KEY (`sessionId`) REFERENCES `session` (`id`);

--
-- Constraints for table `saas_payments`
--
ALTER TABLE `saas_payments`
  ADD CONSTRAINT `saas_payments_adminId_fkey` FOREIGN KEY (`adminId`) REFERENCES `user` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `salary`
--
ALTER TABLE `salary`
  ADD CONSTRAINT `fk_salary_staff` FOREIGN KEY (`staffId`) REFERENCES `staff` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `session`
--
ALTER TABLE `session`
  ADD CONSTRAINT `Session_branchId_fkey` FOREIGN KEY (`branchId`) REFERENCES `branch` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `Session_trainerId_fkey` FOREIGN KEY (`trainerId`) REFERENCES `user` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `stockmovement`
--
ALTER TABLE `stockmovement`
  ADD CONSTRAINT `StockMovement_productId_fkey` FOREIGN KEY (`productId`) REFERENCES `product` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `used_qr_nonces`
--
ALTER TABLE `used_qr_nonces`
  ADD CONSTRAINT `used_qr_nonces_memberId_fkey` FOREIGN KEY (`memberId`) REFERENCES `member` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `user`
--
ALTER TABLE `user`
  ADD CONSTRAINT `User_branchId_fkey` FOREIGN KEY (`branchId`) REFERENCES `branch` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `User_roleId_fkey` FOREIGN KEY (`roleId`) REFERENCES `role` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `workoutexercise`
--
ALTER TABLE `workoutexercise`
  ADD CONSTRAINT `WorkoutExercise_workoutPlanId_fkey` FOREIGN KEY (`workoutPlanId`) REFERENCES `workoutplan` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `workoutplanassignment`
--
ALTER TABLE `workoutplanassignment`
  ADD CONSTRAINT `WorkoutPlanAssignment_memberId_fkey` FOREIGN KEY (`memberId`) REFERENCES `member` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `WorkoutPlanAssignment_workoutPlanId_fkey` FOREIGN KEY (`workoutPlanId`) REFERENCES `workoutplan` (`id`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
