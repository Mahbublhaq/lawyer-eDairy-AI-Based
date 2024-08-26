-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 08, 2024 at 09:12 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `lawyer_edairy`
--

-- --------------------------------------------------------

--
-- Table structure for table `appointments`
--

CREATE TABLE `appointments` (
  `appointment_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `user_name` varchar(255) NOT NULL,
  `user_phone` varchar(20) NOT NULL,
  `lawyer_id` int(11) NOT NULL,
  `lawyer_name` varchar(255) NOT NULL,
  `appointment_date` date NOT NULL,
  `appointment_time` time NOT NULL,
  `appointment_status` varchar(50) NOT NULL DEFAULT 'Pending'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `appointments`
--

INSERT INTO `appointments` (`appointment_id`, `user_id`, `user_name`, `user_phone`, `lawyer_id`, `lawyer_name`, `appointment_date`, `appointment_time`, `appointment_status`) VALUES
(16, 1, 'Mahabub', '01718337085', 2, 'Eamin', '2024-05-21', '02:08:00', 'Pending'),
(17, 1, 'Mahabub', '01718337085', 2, 'Eamin', '2024-05-28', '14:45:00', 'Pending'),
(18, 1, 'Rahim', '01718337085', 2, 'Eamin', '2024-05-29', '17:20:00', 'Pending'),
(22, 1, 'Mr X', '01718337085', 2, 'Eamin', '2024-06-07', '12:35:00', 'Pending'),
(23, 1, 'Mr X', '01718337085', 2, 'Eamin', '2024-06-07', '12:35:00', 'Pending'),
(24, 5, 'Vondo', '01718337085', 2, 'Eamin', '2024-06-05', '00:02:00', 'Pending'),
(27, 2, 'Mahabub', '01718337085', 4, 'Mr Nadim', '2024-06-02', '13:00:00', 'Accepted'),
(31, 11, 'lal mia', '01718337085', 1, 'Mr Kuddus Ali ', '2024-07-19', '20:30:00', 'Pending'),
(32, 5, 'Rofiq', '01718337085', 1, 'Mr Kuddus Ali ', '2024-07-20', '10:00:00', 'Pending');

-- --------------------------------------------------------

--
-- Table structure for table `case_details`
--

CREATE TABLE `case_details` (
  `case_no` varchar(15) NOT NULL,
  `case_title` text NOT NULL,
  `judge_name` text NOT NULL,
  `lawyer_name` text NOT NULL,
  `description` text NOT NULL,
  `addcase_lawyer_id` int(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `case_details`
--

INSERT INTO `case_details` (`case_no`, `case_title`, `judge_name`, `lawyer_name`, `description`, `addcase_lawyer_id`) VALUES
('01/2024', 'আসামি মোস্তাফিজের স্বীকারোক্তি, আক্তারুজ্জামানের নির্দেশে আনোয়ারুল আজীম খুন', 'Mr. Mohammad Ali Azam         Mr. Zainul Abedin', 'Nurul Anwar Chy. and ors. vs Deputy Commissioner Coxs Bazar and ors.', 'সংসদ সদস্য আনোয়ারুল আজীম খুনে জড়িত থাকার কথা স্বীকার করে আদালতে জবানবন্দি দিয়েছেন মোস্তাফিজুর রহমান। ঢাকার চিফ মেট্রোপলিটন ম্যাজিস্ট্রেট আদালতের অতিরিক্ত চিফ মেট্রোপলিটন ম্যাজিস্ট্রেট মো. তোফাজ্জল হোসেন মঙ্গলবার তাঁর জবানবন্দি রেকর্ড করেন। পরে তাঁকে কারাগারে পাঠানো হয়।\r\nপুলিশ ও আদালতসংশ্লিষ্ট সূত্রগুলো বলছে, জবানবন্দিতে মোস্তাফিজুর বলেন, সংসদ সদস্য আনোয়ারুল আজীম খুনের মামলার প্রধান আসামি শিমুল ভূঁইয়ার সঙ্গে তাঁর ও আরেক আসামি ফয়সালের যোগাযোগ হয় গত মার্চে। বড় অঙ্কের অর্থ দেওয়ার কথা বলে তাঁদের ভারতে যেতে বলা হয়। ভারতে যাওয়ার জন্য পাসপোর্ট, ভিসা, টিকিটসহ সব কাজ করে দেওয়ার বিষয়ে শিমুল ভূঁইয়া আশ্বাস দেন। পাসপোর্ট করার জন্য শিমুল ভূঁইয়া টাকাও দেন। পরে গত ১৫ এপ্রিল মোস্তাফিজ ও ফয়সাল ঢাকায় এসে হত্যাকাণ্ডের প্রধান পরিকল্পনাকারী আক্তারুজ্জামানের বসুন্ধরার বাসায় ওঠেন। এরপর ২৪ এপ্রিল পর্যন্ত তাঁরা ওই বাসায় অবস্থান করেন।', 7),
('02/2024', 'চলন্ত ট্রেনে তরুণী ধর্ষণ: ৪ আসামির রিমান্ড মঞ্জুর', 'Mr. Md. Taufique Hossain', 'Md. Moin Uddin Khan and ors. vs Md. Humayun Kabir and ors.', 'সিলেট থেকে চট্টগ্রামগামী চলন্ত ট্রেন উদয়ন এক্সপ্রেসে গত সপ্তাহে এক তরুণীকে ধর্ষণের মামলায় গ্রেপ্তার চারজনকে জিজ্ঞাসাবাদ করতে দুই দিন করে রিমান্ড মঞ্জুর করেছেন আদালত। আজ সোমবার দুপুরে চট্টগ্রামের জুডিশিয়াল ম্যাজিস্ট্রেট নুরুল হারুন শুনানি শেষে এ আদেশ দেন।\r\n\r\nগ্রেপ্তার চারজন হলেন মোহাম্মদ জামাল (২৭), মোহাম্মদ শরীফ (২৮), মোহাম্মদ আবদুর রব (২৮) ও মোহাম্মদ রাশেদ (২৭)। তাঁরা সবাই ট্রেনে খাবার সরবরাহকারী প্রতিষ্ঠানের (ক্যাটারিং সার্ভিস) কর্মী।\r\n\r\nচট্টগ্রাম রেলওয়ে থানার ভারপ্রাপ্ত কর্মকর্তা (ওসি) এস এম শহিদুল ইসলাম আজ দুপুরে প্রথম আলোকে বলেন, গ্রেপ্তার চার আসামিকে জিজ্ঞাসাবাদ করতে আদালতে পাঁচ দিনের রিমান্ডের আবেদন করা হয়েছিল। শুনানি শেষে আদালত প্রত্যেকের দুই দিন করে রিমান্ড মঞ্জুর করেন।\r\n\r\n\r\nগত ২৬ জুন ভোরে সিলেট থেকে চট্টগ্রামগামী চলন্ত ট্রেন উদয়ন এক্সপ্রেসে ১৯ বছরের এক তরুণীকে ধর্ষণের অভিযোগ পাওয়া যায়। যে অভিযোগের ভিত্তিতে ঘটনার দিনই রেলওয়ে পুলিশ জামাল, শরীফ ও রাশেদকে ওই ট্রেন থেকে গ্রেপ্তার করে। পরদিন আবদুর রবকে নোয়াখালী থেকে গ্রেপ্তার করা হয়। এ ঘটনায় ট্রেনটির পরিচালক (গার্ড) আবদুর রহিমকে সাময়িক বরখাস্ত করেছে রেলওয়ে।\r\n\r\nগত ২৬ জুন ভোর সাড়ে চারটার দিকে ট্রেনের খাবারের বগিতে যখন ধর্ষণের ঘটনা ঘটে, তখন ট্রেনটি লাকসাম এলাকা পার হচ্ছিল। ভোরে ঘটনা ঘটলেও বিষয়টি জানাজানি হয় সন্ধ্যার পর। উদয়ন এক্সপ্রেস সিলেট থেকে গত মঙ্গলবার রাত ১০টায় চট্টগ্রামের উদ্দেশে ছাড়ে। চট্টগ্রামে পৌঁছায় পরদিন সকাল আটটায়।\r\nএ ঘটনার পর সে রাতেই চট্টগ্রাম-সিলেট রুটে চলাচলকারী উদয়ন ও পাহাড়িকা এক্সপ্রেসে খাবার সরবরাহকারী এসএ করপোরেশনের ক্যাটারিং সার্ভিস স্থগিত করে রেলওয়ের পূর্বাঞ্চলের প্রধান বাণিজ্যিক ব্যবস্থাপকের কার্যালয় থেকে আদেশ জারি করা হয়।', 1),
('03/2024', 'উড়োজাহাজের সিটে পড়ে ছিল প্রায় সাড়ে ৪ কেজি সোনা, উদ্ধার করলেন গোয়েন্দারা', 'Syed Mabhubar Rahman', 'Bangladesh Bar Council vs Advocate Md. Toyob Ali and ors.', 'উদ্ধার হওয়া ৩৮ সোনার বারের বাজারমূল্য ৪ কোটি ৫০ লাখ টাকা। জব্দ করা সোনার বারগুলো ঢাকার কাস্টম হাউসের  শুল্ক গুদামে জমা দেওয়া হয়েছে।\r\n০৩ জুলাই ২০২৪', 7),
('21/2016', 'হোলি আর্টিজানে হামলার', 'Mr. Zainul Abedin, Mr. Md. Zahirul Islam ,  Mr. M. Ashrafuzzaman Khan ', 'Jahir Ahmed Chowdhury vs Razia Begum and ors.', 'দেশে এখন পর্যন্ত যত জঙ্গি হামলার ঘটনা ঘটেছে, সেগুলোতে মূলত চারটি সংগঠনের সম্পৃক্ততার তথ্য পাওয়া গেছে। এদের মধ্যে তিনটি সংগঠন একেবারেই দুর্বল হয়ে পড়েছে। কারও কারও নামমাত্র কার্যক্রম রয়েছে। তবে এখনো তৎপর আছে আনসার আল–ইসলাম বাংলাদেশ।\r\n\r\nজঙ্গিবাদ পর্যবেক্ষণ ও প্রতিরোধে যুক্ত ব্যক্তিরা বলছেন, অন্য জঙ্গি সংগঠনগুলোর নড়বড়ে সাংগঠনিক কাঠামোর সুযোগ নিয়ে আনসার আল–ইসলাম নানা পর্যায়ে আরও বেশি সক্রিয় হওয়ার চেষ্টা করছে। দেশের প্রায় সব এলাকায় ‘সেল’ গঠন করে চলছে কার্যক্রম। তারা নতুন সদস্য সংগ্রহের পাশাপাশি পাঁচ–সাত বছরের পরীক্ষিত সদস্যদের নিয়মিত প্রশিক্ষণ দিচ্ছে। এই গোষ্ঠীটিকে এখন দেশে জঙ্গিবাদের সবচেয়ে বড় ঝুঁকি বলে মনে করছে আইনশৃঙ্খলা রক্ষাকারী বাহিনী।\r\n\r\nদেশে জঙ্গিবাদের ঝুঁকি এখনো আছে। যে চারটি সংগঠন আগে খুব বেশি সক্রিয় ছিল, যারা বিভিন্ন সময় দেশে নাশকতা ও সন্ত্রাসী কর্মকাণ্ড চালিয়েছে, তাদের মধ্যে জামাআতুল মুজাহিদীন বাংলাদেশ (জেএমবি), নব্য জেএমবি, হরকাতুল জিহাদ আল-ইসলামী বাংলাদেশের (হুজিবি) তুলনায় আনসার আল–ইসলামের তৎপরতা এখন বেশি। এই সংগঠনই এখন ঝুঁকির জায়গা\r\nসিটিটিসি ইউনিটের প্রধান মো. আসাদুজ্জামানে\r\n\r\nজঙ্গিবাদ নির্মূলে কাজ করা আইনশৃঙ্খলা রক্ষাকারী বাহিনীর কর্মকর্তারা জানান, রাজধানীর হোলি আর্টিজান বেকারিতে হামলার আট বছর পর অনেকটাই স্তিমিত হয়েছে জঙ্গিদের তৎপরতা। ২০১৬ সালের ১ জুলাই ওই হামলায় ২২ জন নিহত হয়েছিলেন। এই হামলা করেছিল আইএস (ইসলামিক স্টেট) মতাদর্শী জঙ্গিগোষ্ঠী নব্য জেএমবি। এই হামলার পর আইনশৃঙ্খলা রক্ষাকারী বাহিনীর ১৫টি অভিযানে সংগঠনটির ৬৪ জন সদস্য নিহত হন। এর বাইরে শীর্ষস্থানীয় নেতৃত্বের বেশির ভাগই গ্রেপ্তার হন। এতে তাদের সাংগঠনিক কাঠামো ভেঙে যায়। তা ছাড়া সিরিয়া-ইরাকসহ বিশ্বজুড়ে জঙ্গি সংগঠন আইএসের পতনের পর বাংলাদেশেও তাদের অনুসারী এই গোষ্ঠীটির তৎপরতা কমেছে।\r\nদেশে জঙ্গিবাদের ঝুঁকি ও বর্তমানে তাঁদের তৎপরতা নিয়ে গত শনিবার কথা হয় ঢাকা মহানগর পুলিশের (ডিএমপি) কাউন্টার টেররিজম অ্যান্ড ট্রান্সন্যাশনাল ক্রাইম (সিটিটিসি) ইউনিটের প্রধান মো. আসাদুজ্জামানের সঙ্গে। তিনি বলেন, দেশে জঙ্গিবাদের ঝুঁকি এখনো আছে। যে চারটি সংগঠন আগে খুব বেশি সক্রিয় ছিল, যারা বিভিন্ন সময় দেশে নাশকতা ও সন্ত্রাসী কর্মকাণ্ড চালিয়েছে, তাদের মধ্যে জামাআতুল মুজাহিদীন বাংলাদেশ (জেএমবি), নব্য জেএমবি, হরকাতুল জিহাদ আল-ইসলামী বাংলাদেশের (হুজিবি) তুলনায় আনসার আল–ইসলামের তৎপরতা এখন বেশি। এই সংগঠনই এখন ঝুঁকির জায়গা।\r\n\r\nজঙ্গিবাদ নিয়ে কাজ করা পুলিশের এই ঊর্ধ্বতন কর্মকর্তা আরও বলেন, জঙ্গিদের দৃশ্যমান তৎপরতা না থাকলেও সাইবার স্পেসে তারা সক্রিয় আছে। ধীরগতিতে হলেও তাদের সদস্য সংগ্রহ অব্যাহত আছে। এটাই এখন আমাদের বড় চ্যালেঞ্জ। যদিও তাদের বড় হামলা করার সক্ষমতা এখন আর নেই। সামগ্রিকভাবে জঙ্গিবাদ নিয়ন্ত্রণে আছে।', 1),
('57/2023', 'জুয়ার টাকার জন্য চালককে হত্যা করে অটোরিকশা ছিনতাই করেন তাঁরা', 'Mr. A. K. M. Nurul Alam', 'Md. Abdur Rahman and anr. vs The State and anr.', 'আট মাস আগে নরসিংদীর শিবপুরের ধানখেত থেকে রবিউল ইসলাম (১৯) নামের এক অটোরিকশাচালকের গলাকাটা লাশ উদ্ধার করে পুলিশ। এ ঘটনায় করা মামলা তদন্ত করে পুলিশ ব্যুরো অব ইনভেস্টিগেশন (পিবিআই) জানতে পারে অনলাইন জুয়া ও নেশার টাকা জোগাড় করতে একদল মাদকসেবী রবিউলের অটোরিকশাটিকে হাতিয়ে নেওয়ার পরিকল্পনা করেন। এরপর তাঁরা রবিউলকে হত্যা করে অটোরিকশাটি নিয়ে বিক্রি করে দেন।', 7);

-- --------------------------------------------------------

--
-- Table structure for table `lawyers`
--

CREATE TABLE `lawyers` (
  `lawyer_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `favourite_color` varchar(50) NOT NULL,
  `address` varchar(255) NOT NULL,
  `specialization` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `lawyers`
--

INSERT INTO `lawyers` (`lawyer_id`, `name`, `email`, `password`, `phone`, `favourite_color`, `address`, `specialization`) VALUES
(1, 'Mr Kuddus Ali ', 'k@gmail.com', '1234', '+8801702020201', 'RED', 'City University', 'Family Law'),
(2, 'Eamin', 'e@gmail.com', '12345', '01601337085', 'red', 'City University', 'Corporate Law'),
(3, 'Dr Rahat', 'r@gmail.com', '00000', '01601337085', 'black', 'Khagan, Asulia', 'Immigration Law'),
(4, 'Mr Nadim', 'nadim@gmail.com', '00000', '01601337085', 'black', 'Khagan, Asulia', 'Intellectual Property Law'),
(5, 'Mr Salaudin', 's@gmail.com', '00000', '01601337085', 'red', 'Khagan, Asulia', 'Criminal Law'),
(6, 'Mr  Hanif', 'h@gmail.com', '00000', '01601337085', 'black', 'Khagan, Asulia', 'Criminal Law'),
(7, 'Lawyer Tara', 't@gmail.com', '00000', '01718337085', 'pink', 'Mirpur 1', 'Family Law');

-- --------------------------------------------------------

--
-- Table structure for table `messages`
--

CREATE TABLE `messages` (
  `message_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `lawyer_id` int(11) NOT NULL,
  `message_content` text NOT NULL,
  `reply_content` text DEFAULT NULL,
  `status` varchar(50) NOT NULL DEFAULT 'Pending',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `user_name` varchar(255) DEFAULT NULL,
  `lawyer_name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `messages`
--

INSERT INTO `messages` (`message_id`, `user_id`, `lawyer_id`, `message_content`, `reply_content`, `status`, `created_at`, `user_name`, `lawyer_name`) VALUES
(14, 6, 2, 'Hi', NULL, 'Pending', '2024-05-27 00:20:09', 'Rahim', 'Eamin'),
(21, 2, 4, 'Hi', 'Hello', 'Accepted', '2024-05-31 21:42:54', 'Noyon', 'Mr Nadim'),
(35, 10, 1, 'hi', 'Hello', 'Accepted', '2024-06-11 11:01:53', 'Tara', 'Mr Kuddus Ali '),
(36, 11, 1, 'hi', NULL, 'Pending', '2024-07-04 19:29:08', 'Mr Lal Ali', 'Mr Kuddus Ali '),
(37, 5, 1, 'Hi', NULL, 'Pending', '2024-07-09 22:43:38', 'Korim', 'Mr Kuddus Ali '),
(38, 5, 2, 'hi', NULL, 'Pending', '2024-07-10 11:23:58', 'Korim', 'Eamin'),
(39, 5, 1, 'হেলও\r\n', NULL, 'Pending', '2024-07-14 11:41:09', 'Korim', 'Mr Kuddus Ali '),
(40, 5, 1, 'sir help me\r\n', NULL, 'Pending', '2024-08-05 02:20:24', 'Korim', 'Mr Kuddus Ali ');

-- --------------------------------------------------------

--
-- Table structure for table `notes`
--

CREATE TABLE `notes` (
  `note_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `category` varchar(255) NOT NULL,
  `user_name` varchar(255) NOT NULL,
  `case_no` varchar(255) NOT NULL,
  `case_title` varchar(255) NOT NULL,
  `case_date` date NOT NULL,
  `judge_name` varchar(255) NOT NULL,
  `description` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `notes`
--

INSERT INTO `notes` (`note_id`, `user_id`, `category`, `user_name`, `case_no`, `case_title`, `case_date`, `judge_name`, `description`) VALUES
(1, 1, 'Case', 'Vondo', '01', 'Rape', '2024-06-21', 'Mr  Babul', 'none'),
(2, 1, 'Note', 'Vondo', '003', 'Rape', '2024-06-05', 'Mr  Babul', 'cvfd'),
(3, 2, 'Case', 'Mahabub x', '02', 'Bike Accident', '2024-06-21', 'Mr Bokkor ', 'gafefv');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `favourite_color` varchar(50) NOT NULL,
  `address` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `name`, `email`, `password`, `phone`, `favourite_color`, `address`) VALUES
(1, 'Mr Kuddus', 'kudus@gmail.com', '00000', '1234', 'red', 'City University'),
(2, 'Noyon', 'n@gmail.com', '00000', '01601337085', 'black', 'City University'),
(4, 'Admin', 'admin@gmail.com', '00000', '01601337085', 'black', 'City University'),
(5, 'Korim', 'kk@gmail.com', '00000', '01601337085', 'black', 'City University'),
(6, 'Rahim', 'r@gmail.com', '00000', '01718337085', 'black', 'City University'),
(7, 'Mr Eamin', 'eamin@gmail.com', '00000', '01601337085', 'black', 'Khagan, Asulia'),
(9, 'Noyon', 'nn@gmail.com', '00000', '01718337085', 'red', 'city university'),
(10, 'Tara', 't@gmail.com', '1234', '01718337085', 'black', 'City University'),
(11, 'Mr Lal Ali', 'l@gmail.com', '00000', '01718337085', 'black', 'Mirpur 1');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `appointments`
--
ALTER TABLE `appointments`
  ADD PRIMARY KEY (`appointment_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `lawyer_id` (`lawyer_id`);

--
-- Indexes for table `case_details`
--
ALTER TABLE `case_details`
  ADD PRIMARY KEY (`case_no`);

--
-- Indexes for table `lawyers`
--
ALTER TABLE `lawyers`
  ADD PRIMARY KEY (`lawyer_id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `messages`
--
ALTER TABLE `messages`
  ADD PRIMARY KEY (`message_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `lawyer_id` (`lawyer_id`);

--
-- Indexes for table `notes`
--
ALTER TABLE `notes`
  ADD PRIMARY KEY (`note_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `appointments`
--
ALTER TABLE `appointments`
  MODIFY `appointment_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT for table `lawyers`
--
ALTER TABLE `lawyers`
  MODIFY `lawyer_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `messages`
--
ALTER TABLE `messages`
  MODIFY `message_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT for table `notes`
--
ALTER TABLE `notes`
  MODIFY `note_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `appointments`
--
ALTER TABLE `appointments`
  ADD CONSTRAINT `appointments_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `appointments_ibfk_2` FOREIGN KEY (`lawyer_id`) REFERENCES `lawyers` (`lawyer_id`) ON DELETE CASCADE;

--
-- Constraints for table `messages`
--
ALTER TABLE `messages`
  ADD CONSTRAINT `messages_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `messages_ibfk_2` FOREIGN KEY (`lawyer_id`) REFERENCES `lawyers` (`lawyer_id`) ON DELETE CASCADE;

--
-- Constraints for table `notes`
--
ALTER TABLE `notes`
  ADD CONSTRAINT `notes_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
