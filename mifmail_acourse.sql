-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jun 11, 2025 at 04:44 PM
-- Server version: 8.0.42
-- PHP Version: 8.3.21

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `mifmail_acourse`
--

-- --------------------------------------------------------

--
-- Table structure for table `courses`
--

CREATE TABLE `courses` (
  `id` int NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cover` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `mentor_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `courses`
--

INSERT INTO `courses` (`id`, `title`, `cover`, `description`, `mentor_id`) VALUES
(1, 'Introduction to Stock Trading', 'course/course-1.png', 'Lorem ipsum dolor sit amet consectetur, adipisicing elit. Optio nisi minus commodi beatae consequuntur ad id veritatis. Velit, debitis? Ipsa nemo est necessitatibus minus iusto laborum esse voluptates sapiente velit! Deserunt veritatis officiis accusantium adipisci voluptatum animi ullam, reprehenderit dolorum. Inventore atque illum veritatis quae tempora quia est commodi. Sed.', 8),
(2, 'Crypto Trading for Beginners', 'course/course-1.png', 'Lorem ipsum dolor sit amet consectetur, adipisicing elit. Optio nisi minus commodi beatae consequuntur ad id veritatis. Velit, debitis? Ipsa nemo est necessitatibus minus iusto laborum esse voluptates sapiente velit! Deserunt veritatis officiis accusantium adipisci voluptatum animi ullam, reprehenderit dolorum. Inventore atque illum veritatis quae tempora quia est commodi. Sed.', 8),
(3, 'Technical Analysis Fundamentals', 'course/course-1.png', 'Lorem ipsum dolor sit amet consectetur, adipisicing elit. Optio nisi minus commodi beatae consequuntur ad id veritatis. Velit, debitis? Ipsa nemo est necessitatibus minus iusto laborum esse voluptates sapiente velit! Deserunt veritatis officiis accusantium adipisci voluptatum animi ullam, reprehenderit dolorum. Inventore atque illum veritatis quae tempora quia est commodi. Sed.', 8),
(4, 'Advanced Stock Market Strategies', 'course/course-1.png', 'Lorem ipsum dolor sit amet consectetur, adipisicing elit. Optio nisi minus commodi beatae consequuntur ad id veritatis. Velit, debitis? Ipsa nemo est necessitatibus minus iusto laborum esse voluptates sapiente velit! Deserunt veritatis officiis accusantium adipisci voluptatum animi ullam, reprehenderit dolorum. Inventore atque illum veritatis quae tempora quia est commodi. Sed.', 8),
(5, 'Understanding Forex Trading', 'course/course-1.png', 'Lorem ipsum dolor sit amet consectetur, adipisicing elit. Optio nisi minus commodi beatae consequuntur ad id veritatis. Velit, debitis? Ipsa nemo est necessitatibus minus iusto laborum esse voluptates sapiente velit! Deserunt veritatis officiis accusantium adipisci voluptatum animi ullam, reprehenderit dolorum. Inventore atque illum veritatis quae tempora quia est commodi. Sed.', 8),
(6, 'Building a Trading Plan', 'course/course-1.png', 'Lorem ipsum dolor sit amet consectetur, adipisicing elit. Optio nisi minus commodi beatae consequuntur ad id veritatis. Velit, debitis? Ipsa nemo est necessitatibus minus iusto laborum esse voluptates sapiente velit! Deserunt veritatis officiis accusantium adipisci voluptatum animi ullam, reprehenderit dolorum. Inventore atque illum veritatis quae tempora quia est commodi. Sed.', 8),
(7, 'Risk Management in Trading', 'course/course-1.png', 'Lorem ipsum dolor sit amet consectetur, adipisicing elit. Optio nisi minus commodi beatae consequuntur ad id veritatis. Velit, debitis? Ipsa nemo est necessitatibus minus iusto laborum esse voluptates sapiente velit! Deserunt veritatis officiis accusantium adipisci voluptatum animi ullam, reprehenderit dolorum. Inventore atque illum veritatis quae tempora quia est commodi. Sed.', 8),
(8, 'Options Trading for Beginners', 'course/course-1.png', 'Lorem ipsum dolor sit amet consectetur, adipisicing elit. Optio nisi minus commodi beatae consequuntur ad id veritatis. Velit, debitis? Ipsa nemo est necessitatibus minus iusto laborum esse voluptates sapiente velit! Deserunt veritatis officiis accusantium adipisci voluptatum animi ullam, reprehenderit dolorum. Inventore atque illum veritatis quae tempora quia est commodi. Sed.', 8),
(9, 'Fundamental Analysis for Traders', 'course/course-1.png', 'Lorem ipsum dolor sit amet consectetur, adipisicing elit. Optio nisi minus commodi beatae consequuntur ad id veritatis. Velit, debitis? Ipsa nemo est necessitatibus minus iusto laborum esse voluptates sapiente velit! Deserunt veritatis officiis accusantium adipisci voluptatum animi ullam, reprehenderit dolorum. Inventore atque illum veritatis quae tempora quia est commodi. Sed.', 8),
(10, 'Swing Trading Techniques', 'course/course-1.png', 'Lorem ipsum dolor sit amet consectetur, adipisicing elit. Optio nisi minus commodi beatae consequuntur ad id veritatis. Velit, debitis? Ipsa nemo est necessitatibus minus iusto laborum esse voluptates sapiente velit! Deserunt veritatis officiis accusantium adipisci voluptatum animi ullam, reprehenderit dolorum. Inventore atque illum veritatis quae tempora quia est commodi. Sed.', 8);

-- --------------------------------------------------------

--
-- Table structure for table `message`
--

CREATE TABLE `message` (
  `id` int NOT NULL,
  `sender_id` int NOT NULL,
  `receiver_id` int NOT NULL,
  `subject` varchar(100) NOT NULL,
  `content` longtext NOT NULL,
  `reply_from` int DEFAULT NULL,
  `is_read` tinyint(1) NOT NULL DEFAULT '0',
  `is_fav` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `message`
--

INSERT INTO `message` (`id`, `sender_id`, `receiver_id`, `subject`, `content`, `reply_from`, `is_read`, `is_fav`, `created_at`) VALUES
(1, 20, 8, 'asd', '<p>kirim pesan</p>', NULL, 0, 0, '2025-06-11 13:59:47');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `status` enum('new','active','disabled') NOT NULL DEFAULT 'new',
  `otp` char(4) DEFAULT NULL,
  `role` varchar(50) NOT NULL,
  `amount` decimal(10,2) DEFAULT NULL,
  `payment_type` enum('banktransfer','stripe','usdt','usdc') DEFAULT NULL,
  `payment_details` text,
  `payment_status` enum('unpaid','pending','completed') NOT NULL DEFAULT 'unpaid',
  `name` varchar(255) DEFAULT NULL,
  `is_delete` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `email`, `password`, `status`, `otp`, `role`, `amount`, `payment_type`, `payment_details`, `payment_status`, `name`, `is_delete`) VALUES
(2, 'b@b.b', '40bd001563085fc35165329ea1ff5c5ecbdbbeef', 'active', '5134', 'member', 0.00, NULL, NULL, 'completed', 'Agus', 0),
(8, 'a@a.a', '40bd001563085fc35165329ea1ff5c5ecbdbbeef', 'active', NULL, 'admin', 0.00, NULL, NULL, 'unpaid', 'Subki', 0),
(18, 'fwzk8mhlpw@knmcadibav.com', NULL, 'active', '7398', 'mentor', NULL, NULL, NULL, 'unpaid', NULL, 0),
(20, 'myadmin2@gmail.com', NULL, 'active', '8180', 'member', NULL, NULL, NULL, 'completed', NULL, 0);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `courses`
--
ALTER TABLE `courses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mentor_id` (`mentor_id`);

--
-- Indexes for table `message`
--
ALTER TABLE `message`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sender_id` (`sender_id`),
  ADD KEY `receiver_id` (`receiver_id`),
  ADD KEY `reply_from` (`reply_from`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `courses`
--
ALTER TABLE `courses`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `message`
--
ALTER TABLE `message`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `courses`
--
ALTER TABLE `courses`
  ADD CONSTRAINT `courses_ibfk_1` FOREIGN KEY (`mentor_id`) REFERENCES `user` (`id`);

--
-- Constraints for table `message`
--
ALTER TABLE `message`
  ADD CONSTRAINT `message_ibfk_1` FOREIGN KEY (`sender_id`) REFERENCES `user` (`id`),
  ADD CONSTRAINT `message_ibfk_2` FOREIGN KEY (`receiver_id`) REFERENCES `user` (`id`),
  ADD CONSTRAINT `message_ibfk_3` FOREIGN KEY (`reply_from`) REFERENCES `message` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
