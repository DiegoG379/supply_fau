-- En este Backup incluyo las 12 tablas de mi base de datos con sus respectivos datos.
-- Este archivo .sql contiene un respaldo de las siguientes tablas: materials, depot_personnel, entry, orders, workers, 
-- outbound, maintenance_log, aircraft, deposit, audits_inspections_log, materials_in_deposit y aircraft_status.


-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: supply_fau
-- ------------------------------------------------------
-- Server version	8.0.34

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
-- Table structure for table `aircraft`
--

DROP TABLE IF EXISTS `aircraft`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `aircraft` (
  `aircraft_id` int NOT NULL AUTO_INCREMENT,
  `platform` varchar(5) NOT NULL,
  `registration` varchar(6) NOT NULL,
  `status` varchar(15) NOT NULL,
  `description` text,
  `worker_id` int NOT NULL,
  PRIMARY KEY (`aircraft_id`),
  UNIQUE KEY `aircraft_id` (`aircraft_id`),
  UNIQUE KEY `registration` (`registration`),
  KEY `worker_id` (`worker_id`),
  CONSTRAINT `aircraft_ibfk_1` FOREIGN KEY (`worker_id`) REFERENCES `workers` (`worker_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aircraft`
--

LOCK TABLES `aircraft` WRITE;
/*!40000 ALTER TABLE `aircraft` DISABLE KEYS */;
INSERT INTO `aircraft` VALUES (1,'C-212','FAU532','Operativo','Aeronave C-212 en estado operativo',1),(2,'C-212','FAU534','Inoperativo','Aeronave C-212 en estado inoperativo',1),(3,'C-212','FAU535','En Inspección','Aeronave C-212 en proceso de inspección',2),(4,'C-212','FAU536','Operativo','Aeronave C-212 en estado operativo',2),(5,'C-120','FAU550','Operativo','Aeronave C-120 en estado operativo',11),(6,'C-120','FAU553','Inoperativo','Aeronave C-120 en estado inoperativo',11),(7,'C-130','FAU591','Operativo','Aeronave KC-130 en estado operativo',6),(8,'C-130','FAU592','Operativo','Aeronave KC-130 en estado operativo',6),(9,'C-130','FAU594','Inoperativo','Aeronave KC-130 en estado inoperativo',7),(10,'C-130','FAU595','En Inspección','Aeronave KC-130 en proceso de inspección',7);
/*!40000 ALTER TABLE `aircraft` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aircraft_status`
--

DROP TABLE IF EXISTS `aircraft_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `aircraft_status` (
  `status_id` int NOT NULL AUTO_INCREMENT,
  `aircraft_id` int NOT NULL,
  `status` varchar(15) NOT NULL,
  `description` text,
  `worker_id` int NOT NULL,
  `change_date` timestamp NOT NULL,
  PRIMARY KEY (`status_id`),
  KEY `aircraft_id` (`aircraft_id`),
  KEY `worker_id` (`worker_id`),
  CONSTRAINT `aircraft_status_ibfk_1` FOREIGN KEY (`aircraft_id`) REFERENCES `aircraft` (`aircraft_id`),
  CONSTRAINT `aircraft_status_ibfk_2` FOREIGN KEY (`worker_id`) REFERENCES `workers` (`worker_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aircraft_status`
--

LOCK TABLES `aircraft_status` WRITE;
/*!40000 ALTER TABLE `aircraft_status` DISABLE KEYS */;
INSERT INTO `aircraft_status` VALUES (1,1,'Operativo','Avión listo para el despegue',3,'2023-01-25 12:30:00'),(2,3,'Inoperativo','Problema de motor detectado',4,'2023-07-24 17:15:00'),(3,2,'En Inspección','Realizando mantenimiento de rutina',1,'2023-09-23 14:20:00'),(4,6,'Operativo','Avión listo para el vuelo de entrenamiento',2,'2023-10-22 11:45:00'),(5,8,'Inoperativo','Necesita reparaciones de aviónica',5,'2023-02-21 16:10:00'),(6,10,'Operativo','Finalizó el mantenimiento preventivo',3,'2023-06-20 12:30:00'),(7,5,'Inoperativo','Problema eléctrico identificado',4,'2023-04-19 17:15:00'),(8,7,'Operativo','Listo para el vuelo de reconocimiento',2,'2023-05-18 14:20:00'),(9,1,'En Inspección','Inspección de seguridad en curso',1,'2023-09-17 11:45:00'),(10,2,'Operativo','Mantenimiento programado completo',5,'2023-02-16 16:10:00'),(11,10,'Inoperativo','Fallo en el tren de aterrizaje',3,'2023-07-15 12:30:00'),(12,4,'Operativo','Mantenimiento rutinario completado',4,'2023-06-14 17:15:00'),(13,9,'En Inspección','Realizando inspección exhaustiva',1,'2023-11-13 14:20:00'),(14,7,'Operativo','Listo para el vuelo de prueba de carga',2,'2023-02-07 11:45:00'),(15,9,'Inoperativo','Problema de comunicación detectado',5,'2023-10-11 16:10:00');
/*!40000 ALTER TABLE `aircraft_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `audits_inspections_log`
--

DROP TABLE IF EXISTS `audits_inspections_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `audits_inspections_log` (
  `audit_inspection_id` int NOT NULL AUTO_INCREMENT,
  `deposit_id` int NOT NULL,
  `audit_date` date NOT NULL,
  `results` text,
  `corrective_actions` text,
  PRIMARY KEY (`audit_inspection_id`),
  UNIQUE KEY `audit_inspection_id` (`audit_inspection_id`),
  KEY `deposit_id` (`deposit_id`),
  CONSTRAINT `audits_inspections_log_ibfk_1` FOREIGN KEY (`deposit_id`) REFERENCES `deposit` (`deposit_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `audits_inspections_log`
--

LOCK TABLES `audits_inspections_log` WRITE;
/*!40000 ALTER TABLE `audits_inspections_log` DISABLE KEYS */;
INSERT INTO `audits_inspections_log` VALUES (1,1,'2023-07-02','Auditoría exitosa','Ninguna acción requerida'),(2,1,'2023-05-01','Algunas áreas desordenadas','Limpiar y organizar áreas específicas'),(3,2,'2023-09-01','Buen estado general','Ninguna acción requerida'),(4,3,'2023-09-01','Algunas áreas desordenadas','Limpiar y organizar áreas específicas'),(5,2,'2023-03-01','Problemas de seguridad','Implementar medidas de seguridad adicionales'),(6,3,'2023-01-01','Auditoría exitosa','Ninguna acción requerida'),(7,1,'2023-01-01','Auditoría exitosa','Ninguna acción requerida');
/*!40000 ALTER TABLE `audits_inspections_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `deposit`
--

DROP TABLE IF EXISTS `deposit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `deposit` (
  `deposit_id` int NOT NULL AUTO_INCREMENT,
  `deposit_name` varchar(60) NOT NULL,
  `max_capacity` int DEFAULT NULL,
  `deposit_type` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`deposit_id`),
  UNIQUE KEY `deposit_id` (`deposit_id`),
  UNIQUE KEY `deposit_name` (`deposit_name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `deposit`
--

LOCK TABLES `deposit` WRITE;
/*!40000 ALTER TABLE `deposit` DISABLE KEYS */;
INSERT INTO `deposit` VALUES (1,'Depósito I',150,'Materiales Fungibles'),(2,'Depósito II',50,'Materiales Fungibles'),(3,'Depósito III',75,'Materiales Reparables');
/*!40000 ALTER TABLE `deposit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `depot_personnel`
--

DROP TABLE IF EXISTS `depot_personnel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `depot_personnel` (
  `depot_personnel_id` int NOT NULL AUTO_INCREMENT,
  `personnel_name` varchar(30) NOT NULL,
  PRIMARY KEY (`depot_personnel_id`),
  UNIQUE KEY `depot_personnel_id` (`depot_personnel_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `depot_personnel`
--

LOCK TABLES `depot_personnel` WRITE;
/*!40000 ALTER TABLE `depot_personnel` DISABLE KEYS */;
INSERT INTO `depot_personnel` VALUES (1,'Juan Martínez'),(2,'María López'),(3,'Pedro Ramírez');
/*!40000 ALTER TABLE `depot_personnel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `entry`
--

DROP TABLE IF EXISTS `entry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `entry` (
  `entry_id` int NOT NULL AUTO_INCREMENT,
  `material_id` int NOT NULL,
  `entered_date` date NOT NULL,
  `entered_quantity` int NOT NULL,
  `depot_personnel_id` int DEFAULT NULL,
  PRIMARY KEY (`entry_id`),
  UNIQUE KEY `entry_id` (`entry_id`),
  KEY `material_id` (`material_id`),
  KEY `depot_personnel_id` (`depot_personnel_id`),
  CONSTRAINT `entry_ibfk_1` FOREIGN KEY (`material_id`) REFERENCES `materials` (`material_id`),
  CONSTRAINT `entry_ibfk_2` FOREIGN KEY (`depot_personnel_id`) REFERENCES `depot_personnel` (`depot_personnel_id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `entry`
--

LOCK TABLES `entry` WRITE;
/*!40000 ALTER TABLE `entry` DISABLE KEYS */;
INSERT INTO `entry` VALUES (1,3,'2023-03-15',30,1),(2,5,'2023-07-02',75,1),(3,8,'2023-05-23',45,3),(4,10,'2023-10-04',50,2),(5,32,'2023-08-18',70,2),(6,15,'2023-01-26',95,2),(7,39,'2023-09-07',65,3),(8,20,'2023-04-12',85,2),(9,42,'2023-06-29',55,1),(10,3,'2023-02-11',80,1),(11,7,'2023-11-05',60,3),(12,9,'2023-12-30',35,1),(13,12,'2023-08-02',40,2),(14,15,'2023-03-21',25,1),(15,27,'2023-05-08',100,2),(16,21,'2023-07-14',55,2),(17,24,'2023-09-28',50,2),(18,27,'2023-04-04',70,3),(19,30,'2023-06-18',45,1),(20,33,'2023-10-13',85,3);
/*!40000 ALTER TABLE `entry` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `maintenance_log`
--

DROP TABLE IF EXISTS `maintenance_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `maintenance_log` (
  `log_id` int NOT NULL AUTO_INCREMENT,
  `material_id` int NOT NULL,
  `maintenance_date` date NOT NULL,
  `description` text,
  `worker_id` int NOT NULL,
  PRIMARY KEY (`log_id`),
  UNIQUE KEY `log_id` (`log_id`),
  KEY `material_id` (`material_id`),
  KEY `worker_id` (`worker_id`),
  CONSTRAINT `maintenance_log_ibfk_1` FOREIGN KEY (`material_id`) REFERENCES `materials` (`material_id`),
  CONSTRAINT `maintenance_log_ibfk_2` FOREIGN KEY (`worker_id`) REFERENCES `workers` (`worker_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `maintenance_log`
--

LOCK TABLES `maintenance_log` WRITE;
/*!40000 ALTER TABLE `maintenance_log` DISABLE KEYS */;
INSERT INTO `maintenance_log` VALUES (1,39,'2023-01-15','Reemplazo de filtro de aire',1),(2,14,'2023-02-10','Inspección y ajuste del tren de aterrizaje',9),(4,50,'2023-03-05','Reparación de aviónica',6),(5,30,'2023-03-12','Mantenimiento preventivo',5),(6,42,'2023-05-06','Reemplazo de componentes eléctricos',11),(8,43,'2023-06-25','Cambio de neumáticos',7),(10,3,'2023-08-02','Reemplazo de ventanas de cabina',13),(11,27,'2023-09-15','Mantenimiento de hélice',10),(12,49,'2023-09-30','Verificación de sistemas de comunicación',9),(13,1,'2023-10-20','Reparación de fuselaje',7);
/*!40000 ALTER TABLE `maintenance_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `materials`
--

DROP TABLE IF EXISTS `materials`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `materials` (
  `material_id` int NOT NULL AUTO_INCREMENT,
  `part_number` varchar(45) NOT NULL,
  `serial_number` varchar(45) DEFAULT NULL,
  `material_name` varchar(45) NOT NULL,
  `stock` int NOT NULL,
  PRIMARY KEY (`material_id`),
  UNIQUE KEY `material_id` (`material_id`)
) ENGINE=InnoDB AUTO_INCREMENT=59 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `materials`
--

LOCK TABLES `materials` WRITE;
/*!40000 ALTER TABLE `materials` DISABLE KEYS */;
INSERT INTO `materials` VALUES (1,'LN65019-05035','','BOLT',79),(2,'LN65019-05025','','BOLT',0),(3,'LN65019-05030','','BOLT',150),(4,'LN65019-05015','','BOLT',174),(5,'LN65019-05050','','BOLT',50),(6,'LN65019-05010','','BOLT',241),(7,'212-41205-9','','BUSHING',27),(8,'212-41202-6','','BUSHING',39),(9,'212-41208-7','','BUSHING',20),(10,'212-41208-3','','BUSHING',24),(11,'212-41209-6','','BUSHING',47),(12,'212-41207-1','','BUSHING',40),(13,'LN9484M8','','NUT',120),(14,'LN9484M3','','NUT',102),(15,'LN9484M4','','NUT',88),(16,'LN9484M1','','NUT',30),(17,'LN9484M7','','NUT',25),(18,'LN9484M2','','NUT',23),(19,'MS29513-117','','PACKING',95),(20,'MS29513-239','','PACKING',44),(21,'MS29513-879','','PACKING',75),(22,'MS29513-963','','PACKING',68),(23,'MS29513-752','','PACKING',123),(24,'MS29513-136','','PACKING',75),(25,'MS29513-158','','PACKING',98),(26,'MS29513-225','','PACKING',57),(27,'MS29513-197','','PACKING',13),(28,'MS29513-009','','PACKING',54),(29,'LN9439M5X10','','SCREW',62),(30,'LN9439M3X16','','SCREW',188),(31,'LN9439M5X12','','SCREW',129),(32,'LN9439M4X28','','SCREW',75),(33,'LN9439M4X24','','SCREW',65),(34,'LN9439M4X30','','SCREW',91),(35,'LN9036-02048','','WASHER',37),(36,'LN9036-09043','','WASHER',82),(37,'LN9036-72009','','WASHER',42),(38,'AN6235-1A','','FILTER',62),(39,'AN6235-2A','','FILTER',93),(40,'AN6235-3A','','FILTER',78),(41,'897390-8','P-144C','FUEL PUMP',1),(42,'51509-002','5327','STATIC VOLTAGE',1),(43,'5006484-2','MAY-12361','BREAK ASSY',1),(44,'5006484-2','NOV-93214','BREAK ASSY',1),(45,'10552E','4887','HEATER-OIL TO FUEL',1),(46,'10552E','2506','HEATER-OIL TO FUEL',1),(47,'23079-005','1518','STARTER GENERATOR',1),(48,'23079-005','1564','STARTER GENERATOR',1),(49,'777-1492-002','2930','RECEIVER ADF',1),(50,'622-2855-001','9588','TRANSCEIVER',1);
/*!40000 ALTER TABLE `materials` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `materials_in_deposit`
--

DROP TABLE IF EXISTS `materials_in_deposit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `materials_in_deposit` (
  `material_in_deposit_id` int NOT NULL AUTO_INCREMENT,
  `material_id` int NOT NULL,
  `deposit_id` int NOT NULL,
  `storage_location` varchar(15) NOT NULL,
  PRIMARY KEY (`material_in_deposit_id`),
  UNIQUE KEY `material_in_deposit_id` (`material_in_deposit_id`),
  KEY `material_id` (`material_id`),
  KEY `deposit_id` (`deposit_id`),
  CONSTRAINT `materials_in_deposit_ibfk_1` FOREIGN KEY (`material_id`) REFERENCES `materials` (`material_id`),
  CONSTRAINT `materials_in_deposit_ibfk_2` FOREIGN KEY (`deposit_id`) REFERENCES `deposit` (`deposit_id`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `materials_in_deposit`
--

LOCK TABLES `materials_in_deposit` WRITE;
/*!40000 ALTER TABLE `materials_in_deposit` DISABLE KEYS */;
INSERT INTO `materials_in_deposit` VALUES (1,1,1,'1/A/1/A'),(2,2,1,'1/A/1/B'),(3,3,1,'1/A/1/C'),(4,4,1,'1/A/2/A'),(5,5,1,'1/A/2/B'),(6,6,1,'1/A/2/C'),(7,7,1,'2/A/1/A'),(8,8,1,'2/A/1/B'),(9,9,1,'2/A/1/C'),(10,10,1,'2/A/2/A'),(11,11,1,'2/A/2/B'),(12,12,1,'2/A/2/C'),(13,13,1,'3/A/1/A'),(14,14,1,'3/A/1/B'),(15,15,1,'3/B/1/A'),(16,16,1,'3/B/1/B'),(17,17,1,'3/C/1/A'),(18,18,1,'3/C/1/B'),(19,19,2,'4/A/1/A'),(20,20,2,'4/A/1/B'),(21,21,2,'4/A/1/C'),(22,22,2,'4/A/2/A'),(23,23,2,'4/A/2/B'),(24,24,2,'4/A/2/C'),(25,25,2,'4/B/1/A'),(26,26,2,'4/B/1/B'),(27,27,2,'4/B/1/C'),(28,28,2,'4/B/1/D'),(29,29,2,'5/A/1/A'),(30,30,2,'5/A/1/B'),(31,31,2,'5/A/1/C'),(32,32,2,'5/A/2/A'),(33,33,2,'5/A/2/B'),(34,34,2,'5/A/2/C'),(35,35,2,'6/A/1/A'),(36,36,2,'6/A/1/B'),(37,37,2,'6/A/1/C'),(38,38,2,'6/A/2/A'),(39,39,2,'6/A/2/B'),(40,40,2,'6/A/2/C'),(41,41,3,'7/A/1/A'),(42,42,3,'7/A/1/B'),(43,43,3,'7/A/1/C'),(44,44,3,'7/A/1/D'),(45,45,3,'7/A/2/A'),(46,46,3,'7/A/2/B'),(47,47,3,'7/B/1/A'),(48,48,3,'7/B/1/B'),(49,49,3,'7/C/1/A'),(50,50,3,'7/C/2/A');
/*!40000 ALTER TABLE `materials_in_deposit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `order_number` int NOT NULL,
  `entry_id` int NOT NULL,
  `order_date` date NOT NULL,
  `required_quantity` int NOT NULL,
  PRIMARY KEY (`order_number`),
  UNIQUE KEY `order_number` (`order_number`),
  KEY `entry_id` (`entry_id`),
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`entry_id`) REFERENCES `entry` (`entry_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1072300001,7,'2022-01-03',100),(1072300002,15,'2022-01-10',300),(1072300003,6,'2022-02-06',400),(1072300004,18,'2022-02-17',140),(1072300005,20,'2022-03-18',100),(1072300006,1,'2022-04-17',200),(1072300007,12,'2022-05-04',150),(1072300008,19,'2022-05-07',320),(1072300009,3,'2022-05-23',105),(1072300010,16,'2022-05-26',500),(1072300011,8,'2022-06-21',350),(1072300012,10,'2022-07-01',220),(1072300013,9,'2022-07-31',108),(1072300014,17,'2022-08-14',270),(1072300015,5,'2022-09-03',100),(1072300016,11,'2022-09-08',270),(1072300017,4,'2022-09-14',200),(1072300018,13,'2022-09-25',120),(1072300019,14,'2022-09-28',240),(1072300020,2,'2022-10-04',300);
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `outbound`
--

DROP TABLE IF EXISTS `outbound`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `outbound` (
  `out_id` int NOT NULL AUTO_INCREMENT,
  `material_id` int NOT NULL,
  `worker_id` int NOT NULL,
  `retirement_date` date NOT NULL,
  `retirement_quantity` int NOT NULL,
  `depot_personnel_id` int DEFAULT NULL,
  PRIMARY KEY (`out_id`),
  UNIQUE KEY `out_id` (`out_id`),
  KEY `material_id` (`material_id`),
  KEY `worker_id` (`worker_id`),
  KEY `depot_personnel_id` (`depot_personnel_id`),
  CONSTRAINT `outbound_ibfk_1` FOREIGN KEY (`material_id`) REFERENCES `materials` (`material_id`),
  CONSTRAINT `outbound_ibfk_2` FOREIGN KEY (`worker_id`) REFERENCES `workers` (`worker_id`),
  CONSTRAINT `outbound_ibfk_3` FOREIGN KEY (`depot_personnel_id`) REFERENCES `depot_personnel` (`depot_personnel_id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `outbound`
--

LOCK TABLES `outbound` WRITE;
/*!40000 ALTER TABLE `outbound` DISABLE KEYS */;
INSERT INTO `outbound` VALUES (1,3,7,'2023-09-15',100,2),(2,28,15,'2023-04-02',14,2),(3,35,3,'2023-02-21',12,3),(4,4,12,'2023-08-12',10,1),(5,22,2,'2023-06-01',17,1),(6,8,5,'2023-03-04',19,2),(7,19,11,'2023-01-17',4,2),(8,9,2,'2023-10-19',15,3),(9,33,9,'2023-07-29',7,1),(10,7,14,'2023-05-30',8,1),(11,14,8,'2023-12-06',13,1),(12,16,1,'2023-11-08',3,2),(13,27,1,'2023-09-02',5,3),(14,32,9,'2023-04-23',18,3),(15,20,15,'2023-08-26',9,3),(16,11,6,'2023-01-08',2,2),(17,30,7,'2023-06-24',11,1),(18,25,3,'2023-07-12',16,1),(19,1,14,'2023-03-15',1,3),(20,29,6,'2023-05-05',20,1);
/*!40000 ALTER TABLE `outbound` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `workers`
--

DROP TABLE IF EXISTS `workers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `workers` (
  `worker_id` int NOT NULL AUTO_INCREMENT,
  `worker_name` varchar(60) NOT NULL,
  `work_section` varchar(10) NOT NULL,
  PRIMARY KEY (`worker_id`),
  UNIQUE KEY `worker_id` (`worker_id`),
  UNIQUE KEY `worker_name` (`worker_name`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `workers`
--

LOCK TABLES `workers` WRITE;
/*!40000 ALTER TABLE `workers` DISABLE KEYS */;
INSERT INTO `workers` VALUES (1,'José Pérez','C-212'),(2,'María González','C-212'),(3,'Carlos López','C-212'),(4,'Ana Rodríguez','C-212'),(5,'Luis Martínez','C-212'),(6,'Sofía Sánchez','KC-130'),(7,'Miguel Romero','KC-130'),(8,'Carmen García','KC-130'),(9,'Laura Fernández','KC-130'),(10,'Juan Martín','KC-130'),(11,'Patricia Jiménez','C-120'),(12,'Pedro Díaz','C-120'),(13,'Lucía Torres','C-120'),(14,'Javier Ruiz','C-120'),(15,'Elena González','C-120');
/*!40000 ALTER TABLE `workers` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-11-16 12:06:30
