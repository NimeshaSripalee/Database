-- MySQL dump 10.13  Distrib 8.0.30, for Win64 (x86_64)
--
-- Host: localhost    Database: fadb
-- ------------------------------------------------------
-- Server version	8.0.30

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `accident`
--

DROP TABLE IF EXISTS `accident`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `accident` (
  `accident_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `nature_of_accident` varchar(100) NOT NULL,
  `first_aid_given` text NOT NULL,
  PRIMARY KEY (`accident_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `accident_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `generalpublic` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accident`
--

LOCK TABLES `accident` WRITE;
/*!40000 ALTER TABLE `accident` DISABLE KEYS */;
/*!40000 ALTER TABLE `accident` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ambulance`
--

DROP TABLE IF EXISTS `ambulance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ambulance` (
  `user_id` int NOT NULL,
  `ambulance_location` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  CONSTRAINT `ambulance_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ambulance`
--

LOCK TABLES `ambulance` WRITE;
/*!40000 ALTER TABLE `ambulance` DISABLE KEYS */;
INSERT INTO `ambulance` VALUES (10,NULL),(12,NULL);
/*!40000 ALTER TABLE `ambulance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `feedback`
--

DROP TABLE IF EXISTS `feedback`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `feedback` (
  `feedback_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `feedback_text` text,
  PRIMARY KEY (`feedback_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `feedback_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `generalpublic` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `feedback`
--

LOCK TABLES `feedback` WRITE;
/*!40000 ALTER TABLE `feedback` DISABLE KEYS */;
/*!40000 ALTER TABLE `feedback` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `generalpublic`
--

DROP TABLE IF EXISTS `generalpublic`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `generalpublic` (
  `user_id` int NOT NULL,
  `occupation` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  CONSTRAINT `generalpublic_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `generalpublic`
--

LOCK TABLES `generalpublic` WRITE;
/*!40000 ALTER TABLE `generalpublic` DISABLE KEYS */;
INSERT INTO `generalpublic` VALUES (1,NULL),(2,NULL),(5,NULL),(8,NULL),(9,NULL),(11,NULL);
/*!40000 ALTER TABLE `generalpublic` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `generalpublicambulance`
--

DROP TABLE IF EXISTS `generalpublicambulance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `generalpublicambulance` (
  `generalpublic_id` int NOT NULL,
  `ambulance_id` int NOT NULL,
  PRIMARY KEY (`generalpublic_id`,`ambulance_id`),
  KEY `ambulance_id` (`ambulance_id`),
  CONSTRAINT `generalpublicambulance_ibfk_1` FOREIGN KEY (`generalpublic_id`) REFERENCES `generalpublic` (`user_id`),
  CONSTRAINT `generalpublicambulance_ibfk_2` FOREIGN KEY (`ambulance_id`) REFERENCES `ambulance` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `generalpublicambulance`
--

LOCK TABLES `generalpublicambulance` WRITE;
/*!40000 ALTER TABLE `generalpublicambulance` DISABLE KEYS */;
/*!40000 ALTER TABLE `generalpublicambulance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(255) NOT NULL,
  `username` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `type_of_user` enum('GeneralPublic','Ambulance') NOT NULL,
  `ContactNumber` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'$2a$08$igw9Hv/Wr71xMssJZSYzGuUIEJV6hyYwJmQ13j.wZF2ax8gT15mvW','testuser','testuser@example.com','GeneralPublic',NULL),(2,'$2a$08$JldUu97rpv/d0qWhPHoGf.bsMJ5d6vj5pzogOjE5EmCyzq1T8CIJq','thilinie','xample.com','GeneralPublic',NULL),(5,'$2a$08$xsCcoXveMhXTeJ27GIMRSOae4YBtVs2krgrK7w/WAe6fkNL1qJvjO','testuer','testuser@examle.com','GeneralPublic',NULL),(8,'$2a$08$BTVZv8LfDbEypRBcqe5apexDBpUlG3WXx4Z0xU.66RaI1WwmDJmRq','testuskk','thijkir@example.com','GeneralPublic',NULL),(9,'$2a$08$9nua1IO39WlAzYzO/VyDBeBhIEBaqOBnwspy7u/YQ7bkDwSX2CFma','generalpublic1','generalpublic1@example.com','GeneralPublic',NULL),(10,'$2a$08$4vJtSZIj6SwnFacb9Oy5DeQGHpYKvbXIQIa78WcKPmqAdq7eMSjSK','ambulance1','ambulance1@example.com','GeneralPublic',NULL),(11,'$2a$08$Z9l6Q.Kw41YY8EpMkK4tv.cqZnrCQlR1kdKtsvXCCUQjWB65eEvTy','generalpublic2','generalpublec1@example.com','GeneralPublic',NULL),(12,'$2a$08$aWmWAQcO19qXVUun8iWk7e25dfyiJY4AI5XC73flcXzHt2zE4zEjW','ambulance2','ambulance2@example.com','Ambulance',NULL);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-07-09  8:51:52
