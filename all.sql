-- MySQL dump 10.13  Distrib 8.0.27, for Linux (x86_64)
--
-- Host: localhost    Database: dev
-- ------------------------------------------------------
-- Server version	8.0.27

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Movies`
--
CREATE DATABASE dev CHARACTER SET utf8 COLLATE utf8_general_ci;
USE dev;

DROP TABLE IF EXISTS `Movies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Movies` (
  `movie_id` varchar(64) NOT NULL,
  `title` varchar(45) NOT NULL,
  `genre` varchar(45) NOT NULL,
  `imdb_rating` int NOT NULL,
  `user_rating` double DEFAULT NULL,
  PRIMARY KEY (`movie_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Movies`
--


--
-- Table structure for table `Review_Movies`
--

DROP TABLE IF EXISTS `Review_Movies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Review_Movies` (
  `revmov_id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(45) NOT NULL,
  `movie_id` varchar(64) NOT NULL,
  `rating` int DEFAULT NULL,
  `review` varchar(225) DEFAULT NULL,
  PRIMARY KEY (`revmov_id`,`username`,`movie_id`),
  KEY `fkrmu_idx` (`username`),
  KEY `fkrmi_idx` (`movie_id`),
  CONSTRAINT `fkrmi` FOREIGN KEY (`movie_id`) REFERENCES `Movies` (`movie_id`),
  CONSTRAINT `fkrmus` FOREIGN KEY (`username`) REFERENCES `User` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Review_Movies`
--

/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`antash`@`localhost`*/ /*!50003 TRIGGER `Review_Movies_AFTER_INSERT` AFTER INSERT ON `Review_Movies` FOR EACH ROW BEGIN
UPDATE Movies 
SET user_rating = (select avg (rating) from Review_Movies where movie_id=NEW.movie_id group by movie_id)
WHERE movie_id = NEW.movie_id;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `Review_Series`
--

DROP TABLE IF EXISTS `Review_Series`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Review_Series` (
  `revser_id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(45) NOT NULL,
  `series_id` varchar(64) NOT NULL,
  `rating` int DEFAULT NULL,
  `review` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`revser_id`,`username`,`series_id`),
  KEY `fksrit_idx` (`series_id`),
  KEY `fksru_idx` (`username`),
  CONSTRAINT `fksrit` FOREIGN KEY (`series_id`) REFERENCES `Series` (`series_id`),
  CONSTRAINT `fksrus` FOREIGN KEY (`username`) REFERENCES `User` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Review_Series`
--
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`antash`@`localhost`*/ /*!50003 TRIGGER `Review_Series_AFTER_INSERT` AFTER INSERT ON `Review_Series` FOR EACH ROW BEGIN
UPDATE Series 
SET user_rating = (select avg (rating) from Review_Series where series_id=NEW.series_id group by series_id)
WHERE series_id = NEW.series_id;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `Series`
--

DROP TABLE IF EXISTS `Series`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Series` (
  `series_id` varchar(64) NOT NULL,
  `title` varchar(45) NOT NULL,
  `genre` varchar(45) NOT NULL,
  `season` int DEFAULT NULL,
  `imdb_rating` int NOT NULL,
  `user_rating` decimal(10,0) DEFAULT NULL,
  PRIMARY KEY (`series_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Series`
--


--
-- Table structure for table `User`
--

DROP TABLE IF EXISTS `User`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `User` (
  `username` varchar(45) NOT NULL,
  `name` varchar(45) NOT NULL,
  `age` varchar(45) NOT NULL,
  `password` varchar(45) NOT NULL,
  `gender` varchar(16) NOT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `User`
--


--
-- Table structure for table `user_watchlist_movie`
--

DROP TABLE IF EXISTS `user_watchlist_movie`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_watchlist_movie` (
  `username` varchar(45) NOT NULL,
  `movie_id` varchar(45) NOT NULL,
  PRIMARY KEY (`username`,`movie_id`),
  KEY `fkmi_idx` (`movie_id`),
  CONSTRAINT `fkuser` FOREIGN KEY (`username`) REFERENCES `User` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_watchlist_movie`
--
--
-- Table structure for table `user_watchlist_series`
--

DROP TABLE IF EXISTS `user_watchlist_series`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_watchlist_series` (
  `username` varchar(45) NOT NULL,
  `series_id` varchar(64) NOT NULL,
  PRIMARY KEY (`username`,`series_id`),
  KEY `fksi_idx` (`series_id`),
  CONSTRAINT `fkseries` FOREIGN KEY (`series_id`) REFERENCES `Series` (`series_id`),
  CONSTRAINT `fkusers` FOREIGN KEY (`username`) REFERENCES `User` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_watchlist_series`
--


--
-- Table structure for table `watched_movie`
--

DROP TABLE IF EXISTS `watched_movie`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `watched_movie` (
  `username` varchar(45) NOT NULL,
  `movie_id` varchar(64) NOT NULL,
  `date` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`username`,`movie_id`),
  KEY `fkmuo_idx` (`movie_id`),
  CONSTRAINT `fkmau` FOREIGN KEY (`username`) REFERENCES `User` (`username`),
  CONSTRAINT `fkmuo` FOREIGN KEY (`movie_id`) REFERENCES `Movies` (`movie_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `watched_movie`
--


--
-- Table structure for table `watched_series`
--

DROP TABLE IF EXISTS `watched_series`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `watched_series` (
  `username` varchar(45) NOT NULL,
  `series_id` varchar(64) NOT NULL,
  `date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `season` int NOT NULL,
  PRIMARY KEY (`username`,`series_id`),
  KEY `fkwsi_idx` (`series_id`),
  CONSTRAINT `fkwsi` FOREIGN KEY (`series_id`) REFERENCES `Series` (`series_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fkwsus` FOREIGN KEY (`username`) REFERENCES `User` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `watched_series`
--

/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-01-05 11:25:22
