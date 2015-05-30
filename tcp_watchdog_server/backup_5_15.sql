-- MySQL dump 10.13  Distrib 5.5.43, for debian-linux-gnu (armv7l)
--
-- Host: localhost    Database: testdb
-- ------------------------------------------------------
-- Server version	5.5.43-0+deb7u1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `ARDUINOS`
--

DROP TABLE IF EXISTS `ARDUINOS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ARDUINOS` (
  `ID_NAME` char(50) NOT NULL,
  `LOCATION` char(50) DEFAULT NULL,
  `TIMESTAMP` char(100) DEFAULT NULL,
  `STATUS` char(20) DEFAULT NULL,
  PRIMARY KEY (`ID_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ARDUINOS`
--

LOCK TABLES `ARDUINOS` WRITE;
/*!40000 ALTER TABLE `ARDUINOS` DISABLE KEYS */;
INSERT INTO `ARDUINOS` VALUES ('192.168.1.107/test','Dad\'s room','3/04/2015 06:06:60','ERRDUINO_ACKCLEAR'),('192.168.1.177','loneduino','May 29, 2015 20:20:33','ERRDUINO_ACKCLEAR'),('192.168.1.67','berry5','May 29, 2015 21:04:10','ERRPI_ACKCLEAR'),('berry5/','Pi 5 Arduino #2','May 16, 2015 20:25:08','ERRPI_ACKCLEAR'),('berry5/serial2pipe/watchdog_pipe1','Pi 5 Arduino #2','May 29, 2015 21:04:10','ERRDUINO_ACKCLEAR'),('berry5/serial2pipe/watchdog_pipe2','Pi 5 Arduino #1','May 29, 2015 21:02:43','ERRDUINO_NOREPLY'),('raspberrypi','Dad\'s room Arduino #1','May 09, 2015 16:59:43','ERRSERIAL_BROKENPIPE'),('raspberrypi/serial2pipe/arduino_pipe1',NULL,'May 09, 2015 17:20:59','ERRSERIAL_ACKCLEAR'),('raspberrypi/serial2pipe/arduino_pipe2',NULL,'May 09, 2015 17:16:08','ERRSERIAL_ACKCLEAR'),('raspberrypi/serial2pipe/watchdog_pipe1','Dad\'s room Arduino #1','May 09, 2015 17:19:54','ERRSERIAL_ACKCLEAR'),('raspberrypi/serial2pipe/watchdog_pipe2','Dad\'s room Arduino #2','May 09, 2015 17:19:41','ERRDUINO_ACKCLEAR');
/*!40000 ALTER TABLE `ARDUINOS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `LOCATIONS`
--

DROP TABLE IF EXISTS `LOCATIONS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `LOCATIONS` (
  `ID_NAME` char(50) NOT NULL,
  `LOCATION` char(50) DEFAULT NULL,
  PRIMARY KEY (`ID_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `LOCATIONS`
--

LOCK TABLES `LOCATIONS` WRITE;
/*!40000 ALTER TABLE `LOCATIONS` DISABLE KEYS */;
INSERT INTO `LOCATIONS` VALUES ('127.0.0.1','localhost'),('192.168.1.177','loneduino'),('192.168.1.67','berry5'),('berry5','Pi 5'),('berry5/serial2pipe/watchdog_pipe1','Pi 5 Arduino #2'),('berry5/serial2pipe/watchdog_pipe2','Pi 5 Arduino #1'),('raspberrypi/serial2pipe/watchdog_pipe1','Dad\'s room Arduino #1'),('raspberrypi/serial2pipe/watchdog_pipe2','Dad\'s room Arduino #2');
/*!40000 ALTER TABLE `LOCATIONS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PIS`
--

DROP TABLE IF EXISTS `PIS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PIS` (
  `ID_NAME` char(50) NOT NULL,
  `LOCATION` char(50) DEFAULT NULL,
  `TIMESTAMP` char(100) DEFAULT NULL,
  `STATUS` char(20) DEFAULT NULL,
  PRIMARY KEY (`ID_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PIS`
--

LOCK TABLES `PIS` WRITE;
/*!40000 ALTER TABLE `PIS` DISABLE KEYS */;
INSERT INTO `PIS` VALUES ('127.0.0.1','localhost','May 09, 2015 17:20:59','ERRPI_ACKCLEAR'),('192.168.1.177','loneduino','May 29, 2015 20:22:33','ERRPI_DISCON'),('192.168.1.67','berry5','May 29, 2015 20:12:06','ERRPI_DISCON');
/*!40000 ALTER TABLE `PIS` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-05-29 21:06:00
