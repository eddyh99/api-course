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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
(10,'Swing Trading Techniques','course/course-1.png','Lorem ipsum dolor sit amet consectetur, adipisicing elit. Optio nisi minus commodi beatae consequuntur ad id veritatis. Velit, debitis? Ipsa nemo est necessitatibus minus iusto laborum esse voluptates sapiente velit! Deserunt veritatis officiis accusantium adipisci voluptatum animi ullam, reprehenderit dolorum. Inventore atque illum veritatis quae tempora quia est commodi. Sed.',8);
/*!40000 ALTER TABLE `courses` ENABLE KEYS */;
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
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES
(2,'b@b.b','40bd001563085fc35165329ea1ff5c5ecbdbbeef','active','5134','member',0.00,NULL,NULL,'unpaid','Agus'),
(8,'a@a.a','40bd001563085fc35165329ea1ff5c5ecbdbbeef','active',NULL,'mentor',0.00,NULL,NULL,'unpaid','Subki');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*M!100616 SET NOTE_VERBOSITY=@OLD_NOTE_VERBOSITY */;

-- Dump completed on 2025-05-14 13:56:38
