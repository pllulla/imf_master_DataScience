CREATE DATABASE  IF NOT EXISTS `examensql` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `examensql`;
-- MySQL dump 10.13  Distrib 8.0.31, for Win64 (x86_64)
--
-- Host: localhost    Database: examensql
-- ------------------------------------------------------
-- Server version	8.0.31

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
-- Table structure for table `articulo`
--

DROP TABLE IF EXISTS `articulo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `articulo` (
  `referencia` char(1) NOT NULL,
  `id_dpto` int DEFAULT NULL,
  `cod_familia` char(3) DEFAULT NULL,
  `fecha_alta` datetime DEFAULT NULL,
  PRIMARY KEY (`referencia`),
  KEY `fk_art_fam_idx` (`cod_familia`),
  KEY `fk_art_dpt_idx` (`id_dpto`),
  CONSTRAINT `fk_art_dpt` FOREIGN KEY (`id_dpto`) REFERENCES `departamento` (`id_dpto`),
  CONSTRAINT `fk_art_fam` FOREIGN KEY (`cod_familia`) REFERENCES `familia` (`cod_familia`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `articulo`
--

LOCK TABLES `articulo` WRITE;
/*!40000 ALTER TABLE `articulo` DISABLE KEYS */;
INSERT INTO `articulo` VALUES ('A',1,'1F1','2010-02-21 00:00:00'),('B',2,'2F1','2014-02-07 00:00:00'),('C',2,'2F1','2014-05-15 00:00:00'),('D',2,'2F1','2005-10-01 00:00:00'),('E',2,'2F1','2010-10-31 00:00:00'),('F',3,'3F1','2001-04-20 00:00:00'),('G',3,'3F2','2015-02-14 00:00:00'),('H',4,'4F1','2009-03-25 00:00:00');
/*!40000 ALTER TABLE `articulo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `campanias`
--

DROP TABLE IF EXISTS `campanias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `campanias` (
  `id_campania` char(3) NOT NULL,
  `tipo` varchar(45) NOT NULL,
  `fecha_camp` datetime NOT NULL,
  PRIMARY KEY (`id_campania`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `campanias`
--

LOCK TABLES `campanias` WRITE;
/*!40000 ALTER TABLE `campanias` DISABLE KEYS */;
INSERT INTO `campanias` VALUES ('CA1','VENTA','2012-02-05 00:00:00'),('CA2','VENTA','2012-02-04 00:00:00'),('CA3','POSVENTA','2009-10-02 00:00:00'),('CA4','VENTA','2010-05-06 00:00:00'),('CA5','POSVENTA','2010-11-30 00:00:00'),('CA6','POSVENTA','2015-02-07 00:00:00');
/*!40000 ALTER TABLE `campanias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `departamento`
--

DROP TABLE IF EXISTS `departamento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `departamento` (
  `id_dpto` int NOT NULL,
  `desc_dpto` varchar(45) NOT NULL,
  PRIMARY KEY (`id_dpto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `departamento`
--

LOCK TABLES `departamento` WRITE;
/*!40000 ALTER TABLE `departamento` DISABLE KEYS */;
INSERT INTO `departamento` VALUES (1,'JOYERIA'),(2,'BOLSOS'),(3,'ZAPATERIA'),(4,'BAÑO CAB.');
/*!40000 ALTER TABLE `departamento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `depto_campania`
--

DROP TABLE IF EXISTS `depto_campania`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `depto_campania` (
  `id_dpto` int NOT NULL,
  `id_campania` char(3) NOT NULL,
  PRIMARY KEY (`id_dpto`,`id_campania`),
  KEY `fk_camp_idx` (`id_campania`),
  CONSTRAINT `fk_camp` FOREIGN KEY (`id_campania`) REFERENCES `campanias` (`id_campania`),
  CONSTRAINT `fk_dpt` FOREIGN KEY (`id_dpto`) REFERENCES `departamento` (`id_dpto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `depto_campania`
--

LOCK TABLES `depto_campania` WRITE;
/*!40000 ALTER TABLE `depto_campania` DISABLE KEYS */;
INSERT INTO `depto_campania` VALUES (1,'CA1'),(4,'CA1'),(2,'CA2'),(3,'CA2'),(4,'CA2'),(4,'CA3'),(1,'CA4'),(3,'CA5'),(3,'CA6'),(4,'CA6');
/*!40000 ALTER TABLE `depto_campania` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `familia`
--

DROP TABLE IF EXISTS `familia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `familia` (
  `id_dpto` int NOT NULL,
  `cod_familia` char(3) NOT NULL,
  `desc_familia` varchar(45) NOT NULL,
  PRIMARY KEY (`cod_familia`),
  KEY `fk_fam_dpt_idx` (`id_dpto`),
  CONSTRAINT `fk_fam_dpt` FOREIGN KEY (`id_dpto`) REFERENCES `departamento` (`id_dpto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `familia`
--

LOCK TABLES `familia` WRITE;
/*!40000 ALTER TABLE `familia` DISABLE KEYS */;
INSERT INTO `familia` VALUES (1,'1F1','PULSERAS'),(1,'1F2','ANILLOS'),(2,'2F1','BOLSO DE MANO'),(3,'3F1','NAUTICO'),(3,'3F2','SANDALIAS'),(4,'4F1','BERMUDAS');
/*!40000 ALTER TABLE `familia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `venta`
--

DROP TABLE IF EXISTS `venta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `venta` (
  `talon` char(2) NOT NULL,
  `referencia` char(1) NOT NULL,
  `precio` float NOT NULL,
  `fecha_venta` datetime NOT NULL,
  PRIMARY KEY (`talon`),
  KEY `fk_art_idx` (`referencia`),
  CONSTRAINT `fk_art` FOREIGN KEY (`referencia`) REFERENCES `articulo` (`referencia`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `venta`
--

LOCK TABLES `venta` WRITE;
/*!40000 ALTER TABLE `venta` DISABLE KEYS */;
INSERT INTO `venta` VALUES ('01','A',15,'2012-02-11 00:00:00'),('02','A',18,'2012-02-15 00:00:00'),('03','A',14,'2013-10-02 00:00:00'),('04','D',37.95,'2010-08-06 00:00:00'),('05','E',125.95,'2010-11-30 00:00:00'),('06','E',150,'2011-02-05 00:00:00'),('07','H',22.99,'2010-04-11 00:00:00'),('08','H',24,'2011-08-08 00:00:00');
/*!40000 ALTER TABLE `venta` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-12-01 16:56:08
