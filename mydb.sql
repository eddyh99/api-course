/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19-11.7.2-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: course
-- ------------------------------------------------------
-- Server version	11.7.2-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*M!100616 SET @OLD_NOTE_VERBOSITY=@@NOTE_VERBOSITY, NOTE_VERBOSITY=0 */;

--
-- Table structure for table `courses`
--

DROP TABLE IF EXISTS `courses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `courses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `cover` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `mentor_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `mentor_id` (`mentor_id`),
  CONSTRAINT `courses_ibfk_1` FOREIGN KEY (`mentor_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `courses`
--

LOCK TABLES `courses` WRITE;
/*!40000 ALTER TABLE `courses` DISABLE KEYS */;
INSERT INTO `courses` VALUES
(1,'Introduction to Stock Trading','course/course-1.png','Lorem ipsum dolor sit amet consectetur, adipisicing elit. Optio nisi minus commodi beatae consequuntur ad id veritatis. Velit, debitis? Ipsa nemo est necessitatibus minus iusto laborum esse voluptates sapiente velit! Deserunt veritatis officiis accusantium adipisci voluptatum animi ullam, reprehenderit dolorum. Inventore atque illum veritatis quae tempora quia est commodi. Sed.',8),
(2,'Crypto Trading for Beginners','course/course-1.png','Lorem ipsum dolor sit amet consectetur, adipisicing elit. Optio nisi minus commodi beatae consequuntur ad id veritatis. Velit, debitis? Ipsa nemo est necessitatibus minus iusto laborum esse voluptates sapiente velit! Deserunt veritatis officiis accusantium adipisci voluptatum animi ullam, reprehenderit dolorum. Inventore atque illum veritatis quae tempora quia est commodi. Sed.',8),
(3,'Technical Analysis Fundamentals','course/course-1.png','Lorem ipsum dolor sit amet consectetur, adipisicing elit. Optio nisi minus commodi beatae consequuntur ad id veritatis. Velit, debitis? Ipsa nemo est necessitatibus minus iusto laborum esse voluptates sapiente velit! Deserunt veritatis officiis accusantium adipisci voluptatum animi ullam, reprehenderit dolorum. Inventore atque illum veritatis quae tempora quia est commodi. Sed.',8),
(4,'Advanced Stock Market Strategies','course/course-1.png','Lorem ipsum dolor sit amet consectetur, adipisicing elit. Optio nisi minus commodi beatae consequuntur ad id veritatis. Velit, debitis? Ipsa nemo est necessitatibus minus iusto laborum esse voluptates sapiente velit! Deserunt veritatis officiis accusantium adipisci voluptatum animi ullam, reprehenderit dolorum. Inventore atque illum veritatis quae tempora quia est commodi. Sed.',8),
(5,'Understanding Forex Trading','course/course-1.png','Lorem ipsum dolor sit amet consectetur, adipisicing elit. Optio nisi minus commodi beatae consequuntur ad id veritatis. Velit, debitis? Ipsa nemo est necessitatibus minus iusto laborum esse voluptates sapiente velit! Deserunt veritatis officiis accusantium adipisci voluptatum animi ullam, reprehenderit dolorum. Inventore atque illum veritatis quae tempora quia est commodi. Sed.',8),
(6,'Building a Trading Plan','course/course-1.png','Lorem ipsum dolor sit amet consectetur, adipisicing elit. Optio nisi minus commodi beatae consequuntur ad id veritatis. Velit, debitis? Ipsa nemo est necessitatibus minus iusto laborum esse voluptates sapiente velit! Deserunt veritatis officiis accusantium adipisci voluptatum animi ullam, reprehenderit dolorum. Inventore atque illum veritatis quae tempora quia est commodi. Sed.',8),
(7,'Risk Management in Trading','course/course-1.png','Lorem ipsum dolor sit amet consectetur, adipisicing elit. Optio nisi minus commodi beatae consequuntur ad id veritatis. Velit, debitis? Ipsa nemo est necessitatibus minus iusto laborum esse voluptates sapiente velit! Deserunt veritatis officiis accusantium adipisci voluptatum animi ullam, reprehenderit dolorum. Inventore atque illum veritatis quae tempora quia est commodi. Sed.',8),
(8,'Options Trading for Beginners','course/course-1.png','Lorem ipsum dolor sit amet consectetur, adipisicing elit. Optio nisi minus commodi beatae consequuntur ad id veritatis. Velit, debitis? Ipsa nemo est necessitatibus minus iusto laborum esse voluptates sapiente velit! Deserunt veritatis officiis accusantium adipisci voluptatum animi ullam, reprehenderit dolorum. Inventore atque illum veritatis quae tempora quia est commodi. Sed.',8),
(9,'Fundamental Analysis for Traders','course/course-1.png','Lorem ipsum dolor sit amet consectetur, adipisicing elit. Optio nisi minus commodi beatae consequuntur ad id veritatis. Velit, debitis? Ipsa nemo est necessitatibus minus iusto laborum esse voluptates sapiente velit! Deserunt veritatis officiis accusantium adipisci voluptatum animi ullam, reprehenderit dolorum. Inventore atque illum veritatis quae tempora quia est commodi. Sed.',8),
(10,'Swing Trading Techniques','course/course-1.png','Lorem ipsum dolor sit amet consectetur, adipisicing elit. Optio nisi minus commodi beatae consequuntur ad id veritatis. Velit, debitis? Ipsa nemo est necessitatibus minus iusto laborum esse voluptates sapiente velit! Deserunt veritatis officiis accusantium adipisci voluptatum animi ullam, reprehenderit dolorum. Inventore atque illum veritatis quae tempora quia est commodi. Sed.',8),
(21,'lorem15','course/course-1.png','lorem ipsum 500',18),
(22,'Tes 5','course/course-1.png','lorem 55555555555555555555555',8);
/*!40000 ALTER TABLE `courses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `live`
--

DROP TABLE IF EXISTS `live`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `live` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `mentor_id` int(11) NOT NULL,
  `start_date` datetime NOT NULL,
  `status` enum('upcoming','live','ended') NOT NULL DEFAULT 'upcoming',
  `duration` int(10) unsigned NOT NULL COMMENT 'Duration in minutes',
  `roomid` char(8) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `mentor_id` (`mentor_id`),
  CONSTRAINT `live_ibfk_1` FOREIGN KEY (`mentor_id`) REFERENCES `user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `live`
--

LOCK TABLES `live` WRITE;
/*!40000 ALTER TABLE `live` DISABLE KEYS */;
INSERT INTO `live` VALUES
(1,'Title of course',8,'2025-05-21 12:00:00','upcoming',121,'xwrqxm7','2025-05-21 03:03:38','2025-05-21 13:54:24'),
(18,'LIVE 2',18,'2025-06-12 15:00:00','upcoming',120,'61uxit4','2025-06-09 03:34:55','2025-06-12 08:19:23'),
(19,'Title of course 2',8,'2025-06-09 16:00:00','upcoming',60,'q51e09t','2025-06-09 06:10:01','2025-06-09 06:23:08'),
(20,'Title of course',8,'2025-06-09 10:00:00','upcoming',60,'yzl357u','2025-06-09 06:10:46','2025-06-09 06:10:46');
/*!40000 ALTER TABLE `live` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `status` enum('new','active','disabled') NOT NULL DEFAULT 'new',
  `otp` char(4) DEFAULT NULL,
  `role` varchar(50) NOT NULL,
  `amount` decimal(10,2) DEFAULT NULL,
  `payment_type` enum('banktransfer','stripe','usdt','usdc') DEFAULT NULL,
  `payment_details` text DEFAULT NULL,
  `payment_status` enum('unpaid','pending','completed') NOT NULL DEFAULT 'unpaid',
  `name` varchar(255) DEFAULT NULL,
  `is_delete` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES
(2,'b@b.b','40bd001563085fc35165329ea1ff5c5ecbdbbeef','active','5134','member',0.00,NULL,NULL,'unpaid','Agus',0),
(8,'a@a.a','40bd001563085fc35165329ea1ff5c5ecbdbbeef','active',NULL,'mentor',0.00,NULL,NULL,'unpaid','Subki',0),
(18,'fwzk8mhlpw@knmcadibav.com',NULL,'active','7398','mentor',NULL,NULL,NULL,'unpaid',NULL,0),
(20,'myadmin2@gmail.com',NULL,'active','8180','member',NULL,NULL,NULL,'unpaid',NULL,0);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `videos`
--

DROP TABLE IF EXISTS `videos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `videos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `video` varchar(255) NOT NULL,
  `is_live` tinyint(1) DEFAULT 0,
  `course_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `fk_course` (`course_id`),
  CONSTRAINT `fk_course` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `videos`
--

LOCK TABLES `videos` WRITE;
/*!40000 ALTER TABLE `videos` DISABLE KEYS */;
/*!40000 ALTER TABLE `videos` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*M!100616 SET NOTE_VERBOSITY=@OLD_NOTE_VERBOSITY */;

-- Dump completed on 2025-06-13  8:34:27
