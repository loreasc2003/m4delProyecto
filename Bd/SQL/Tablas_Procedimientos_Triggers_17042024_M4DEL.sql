CREATE DATABASE  IF NOT EXISTS `bd_gimnasio_210519` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `bd_gimnasio_210519`;
-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: localhost    Database: bd_gimnasio_210519
-- ------------------------------------------------------
-- Server version	8.0.35

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
-- Table structure for table `areas`
--

DROP TABLE IF EXISTS `areas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `areas` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(80) NOT NULL,
  `Descripcion` text,
  `Responsable_ID` int DEFAULT NULL,
  `Sucursal_ID` int unsigned DEFAULT NULL,
  `Total_Equipos` int unsigned NOT NULL DEFAULT '0',
  `Estatus` bit(1) NOT NULL DEFAULT b'1',
  PRIMARY KEY (`ID`),
  KEY `fk_empleado_3` (`Responsable_ID`),
  KEY `fk_sucursales_2` (`Sucursal_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `areas`
--

LOCK TABLES `areas` WRITE;
/*!40000 ALTER TABLE `areas` DISABLE KEYS */;
INSERT INTO `areas` VALUES (1,'Atencion a clientes',NULL,2,1,0,_binary ''),(2,'Control de Inventarios',NULL,45,1,0,_binary ''),(3,'Gerencia',NULL,45,1,0,_binary ''),(4,'Marketing',NULL,2,1,0,_binary ''),(5,'Membresias',NULL,2,1,0,_binary ''),(6,'Nutricion',NULL,2,2,0,_binary ''),(7,'Recursos Humanos',NULL,45,2,0,_binary ''),(8,'Recursus Materiales',NULL,2,2,0,_binary ''),(9,'Training',NULL,45,2,0,_binary '');
/*!40000 ALTER TABLE `areas` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `areas_AFTER_INSERT` AFTER INSERT ON `areas` FOR EACH ROW BEGIN
    -- Declaración de variables
    DECLARE v_cadena_estatus varchar(15) default null;
    DECLARE v_nombre_responsable varchar(60) default null;
    DECLARE v_nombre_sucursal varchar(60) default null;

    -- Iniciación de las variables
    -- El estatus de la sucursal se almacena en un dato del tipo BIT, por
    -- cuestiones de memoria, pero para registrar eventos en bitacora
    -- se requiere ser más descriptivo con la redacción de los eventos
    IF new.estatus = b'1' then
        set v_cadena_estatus = "Activa";
    else
        set v_cadena_estatus = "Inactiva";
    end if;

    if new.responsable_id is not null then
        -- En caso de tener el id del empleado responsable debemos recuperar su nombre
        set v_nombre_responsable = (SELECT CONCAT_WS(" ", p.titulo_cortesia, p.nombre, p.primer_apellido, p.segundo_Apellido) FROM personas p WHERE id = NEW.responsable_id);
    else
        SET v_nombre_responsable = "Sin responsable asignado";
    end if;

    if new.sucursal_id is not null then
        -- En caso de tener el id de la sucursal debemos recuperar su nombre
        set v_nombre_sucursal = (SELECT nombre FROM sucursales WHERE id = NEW.sucursal_id);
    else
        SET v_nombre_sucursal = "Sin sucursal asignada";
    end if;

    -- Insertar en la bitacora
    INSERT INTO bitacora VALUES(
        DEFAULT,
        USER(),
        "Create",
        "areas",
        CONCAT_WS(" ","Se ha insertado una nueva AREA con el ID: ",NEW.ID, 
        "con los siguientes datos: ",
        "NOMBRE = ", NEW.nombre,
        "DESCRIPCIÓN = ", NEW.descripcion,
        "RESPONSABLE ID = ", v_nombre_responsable,
        "SUCURSAL ID = ",  v_nombre_sucursal,
        "TOTAL EQUIPOS = ", NEW.total_equipos, 
        "ESTATUS = ", v_cadena_estatus),
        NOW(),
        DEFAULT
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `areas_AFTER_UPDATE` AFTER UPDATE ON `areas` FOR EACH ROW BEGIN
	 -- Declaración de variables
    DECLARE v_cadena_estatus VARCHAR(15) DEFAULT NULL;
    DECLARE v_nombre_responsable VARCHAR(100) DEFAULT NULL;
    DECLARE v_cadena_estatus2 VARCHAR(15) DEFAULT NULL;
    DECLARE v_nombre_responsable2 VARCHAR(100) DEFAULT NULL;
    DECLARE v_nombre_sucursal VARCHAR(60) DEFAULT NULL;
    DECLARE v_nombre_sucursal2 VARCHAR(60) DEFAULT NULL;

    -- Inicialización de las variables
    -- El estatus de la sucursal se almacena en un dato del tipo BIT, por
    -- cuestiones de memoria, pero para registrar eventos en bitacora
    -- se requiere ser más descriptivo con la redacción de los eventos. 
    IF NEW.estatus = b'1' THEN
		SET v_cadena_estatus= "Activa";
    ELSE
		SET v_cadena_estatus= "Inactiva";
    END IF; 
    
    IF OLD.estatus = b'1' THEN
		SET v_cadena_estatus2= "Activa";
    ELSE
		SET v_cadena_estatus2= "Inactiva";
    END IF; 
          
    IF NEW.responsable_id IS NOT NULL THEN 
		-- En caso de tener el id del empleado responsable debemos recuperar su nombre
		-- para ingresarlo en la bitacora.
		SET v_nombre_responsable = (SELECT CONCAT_WS(" ", p.titulo_cortesia, p.nombre, p.primer_apellido,p.segundo_apellido) FROM personas p WHERE id = NEW.responsable_id);
    ELSE
		SET v_nombre_responsable = "Sin responsable asignado.";
    END IF;
    
    IF OLD.responsable_id IS NOT NULL THEN 
		-- En caso de tener el id del empleado responsable debemos recuperar su nombre
		-- para ingresarlo en la bitacora.
		SET v_nombre_responsable2 = (SELECT CONCAT_WS(" ", p.titulo_cortesia, p.nombre, p.primer_apellido,
		p.segundo_apellido) FROM personas p WHERE id = OLD.responsable_id);
    ELSE
		SET v_nombre_responsable2 = "Sin responsable asignado.";
    END IF;

    IF NEW.sucursal_id IS NOT NULL THEN 
		-- En caso de tener el id de la sucursal debemos recuperar su nombre
		-- para ingresarlo en la bitacora.
		SET v_nombre_sucursal = (SELECT nombre FROM sucursales WHERE id = NEW.sucursal_id);
    ELSE
		SET v_nombre_sucursal = "Sin sucursal asignada.";
    END IF;

    IF OLD.sucursal_id IS NOT NULL THEN 
		-- En caso de tener el id de la sucursal debemos recuperar su nombre
		-- para ingresarlo en la bitacora.
		SET v_nombre_sucursal2 = (SELECT nombre FROM sucursales WHERE id = OLD.sucursal_id);
    ELSE
		SET v_nombre_sucursal2 = "Sin sucursal asignada.";
    END IF;
    
    INSERT INTO bitacora VALUES(
        DEFAULT,
        USER(),
        "Update",
        "areas",
        CONCAT_WS(" ","Se han actualizado los datos del área con el ID: ",
        NEW.ID, "con los siguientes datos:",
        "RESPONSABLE = ", v_nombre_responsable2, "cambio a", v_nombre_responsable,
        "SUCURSAL ID =",v_nombre_sucursal2,"cambio a", v_nombre_sucursal,
        "ESTATUS = ", v_cadena_estatus2, "cambio a", v_cadena_estatus),
        NOW(),
        DEFAULT       
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `areas_AFTER_DELETE` AFTER DELETE ON `areas` FOR EACH ROW BEGIN
	INSERT INTO bitacora VALUES(
		DEFAULT,
        USER(),
        "Delete",
        "area",
        CONCAT_WS(" ","Se ha eliminado una AREA con el ID: ", OLD.ID),
        now(),
        DEFAULT
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `bitacora`
--

DROP TABLE IF EXISTS `bitacora`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bitacora` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `Usuario` varchar(50) NOT NULL,
  `Operacion` enum('Create','Read','Update','Delete') NOT NULL,
  `Tabla` varchar(50) NOT NULL,
  `Descripcion` text NOT NULL,
  `Fecha_Hora` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Estatus` bit(1) NOT NULL DEFAULT b'1',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=1683 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bitacora`
--

LOCK TABLES `bitacora` WRITE;
/*!40000 ALTER TABLE `bitacora` DISABLE KEYS */;
INSERT INTO `bitacora` VALUES (1,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  1 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Karla PRIMER APELLIDO =  Moreno SEGUNDO APELLIDO =  Aguilar FECHA NACIMIENTO =  1996-04-12 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  B- ESTATUS =   FECHA REGISTRO =  2020-11-10 14:16:21 FECHA ACTUALIZACIÓN = ','2024-04-17 23:20:07',_binary ''),(2,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  2 con los siguientes datos:  TITULO CORTESIA =  Lic. NOMBRE= Edgar PRIMER APELLIDO =  Cortes SEGUNDO APELLIDO =  Estrada FECHA NACIMIENTO =  1962-02-25 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  B- ESTATUS =   FECHA REGISTRO =  2020-12-02 15:39:17 FECHA ACTUALIZACIÓN = ','2024-04-17 23:20:07',_binary ''),(3,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  3 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Diana PRIMER APELLIDO =  Salazar SEGUNDO APELLIDO =  Guzmán FECHA NACIMIENTO =  1971-07-19 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  A+ ESTATUS =   FECHA REGISTRO =  2021-07-06 16:23:45 FECHA ACTUALIZACIÓN = ','2024-04-17 23:20:07',_binary ''),(4,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  4 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Ricardo PRIMER APELLIDO =  Velázquez SEGUNDO APELLIDO =  Cruz FECHA NACIMIENTO =  1992-06-10 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  O+ ESTATUS =   FECHA REGISTRO =  2023-11-29 10:16:30 FECHA ACTUALIZACIÓN = ','2024-04-17 23:20:07',_binary ''),(5,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  5 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Paula PRIMER APELLIDO =  Soto SEGUNDO APELLIDO =  Cortes FECHA NACIMIENTO =  1962-11-16 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  O+ ESTATUS =   FECHA REGISTRO =  2022-05-12 13:50:35 FECHA ACTUALIZACIÓN = ','2024-04-17 23:20:07',_binary ''),(6,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  6 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Daniel PRIMER APELLIDO =  Castillo SEGUNDO APELLIDO =  Méndez FECHA NACIMIENTO =  1971-04-08 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  AB+ ESTATUS =   FECHA REGISTRO =  2020-09-18 09:08:00 FECHA ACTUALIZACIÓN = ','2024-04-17 23:20:07',_binary ''),(7,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  7 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Valeria PRIMER APELLIDO =  López SEGUNDO APELLIDO =  Ortiz FECHA NACIMIENTO =  1962-11-17 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  A+ ESTATUS =   FECHA REGISTRO =  2023-06-11 19:56:10 FECHA ACTUALIZACIÓN = ','2024-04-17 23:20:07',_binary ''),(8,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  8 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Guadalupe PRIMER APELLIDO =  Mendoza SEGUNDO APELLIDO =  Morales FECHA NACIMIENTO =  1962-06-28 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  AB+ ESTATUS =   FECHA REGISTRO =  2022-04-24 08:36:51 FECHA ACTUALIZACIÓN = ','2024-04-17 23:20:07',_binary ''),(9,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  9 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Hugo PRIMER APELLIDO =  Romero SEGUNDO APELLIDO =  Méndez FECHA NACIMIENTO =  1968-08-06 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  B+ ESTATUS =   FECHA REGISTRO =  2020-02-29 10:42:19 FECHA ACTUALIZACIÓN = ','2024-04-17 23:20:07',_binary ''),(10,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  10 con los siguientes datos:  TITULO CORTESIA =  C.P. NOMBRE= Adalid PRIMER APELLIDO =  Sánchez SEGUNDO APELLIDO =   Rivera FECHA NACIMIENTO =  1986-08-12 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  O- ESTATUS =   FECHA REGISTRO =  2021-04-11 14:03:55 FECHA ACTUALIZACIÓN = ','2024-04-17 23:20:07',_binary ''),(11,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  11 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Alondra PRIMER APELLIDO =  Bautista SEGUNDO APELLIDO =   Rivera FECHA NACIMIENTO =  1962-10-28 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  AB+ ESTATUS =   FECHA REGISTRO =  2023-08-23 12:48:11 FECHA ACTUALIZACIÓN = ','2024-04-17 23:20:07',_binary ''),(12,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  11 con los siguientes datos:  NOMBRE USUARIO=  Alondra Bautista  Rivera PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Offline ULTIMA CONEXIÓN =  2023-09-13 08:53:16','2024-04-17 23:20:07',_binary ''),(13,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  12 con los siguientes datos:  TITULO CORTESIA =  Sr. NOMBRE= Edgar PRIMER APELLIDO =  Gómes SEGUNDO APELLIDO =  Hernández FECHA NACIMIENTO =  1975-07-24 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  AB- ESTATUS =   FECHA REGISTRO =  2021-01-27 11:38:12 FECHA ACTUALIZACIÓN = ','2024-04-17 23:20:07',_binary ''),(14,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  12 con los siguientes datos:  NOMBRE USUARIO=  Sr. Edgar Gómes Hernández PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Offline ULTIMA CONEXIÓN =  2023-07-16 18:58:59','2024-04-17 23:20:07',_binary ''),(15,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  13 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Diana PRIMER APELLIDO =  Díaz SEGUNDO APELLIDO =  Díaz FECHA NACIMIENTO =  1992-09-08 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  B+ ESTATUS =   FECHA REGISTRO =  2023-06-11 18:48:08 FECHA ACTUALIZACIÓN = ','2024-04-17 23:20:07',_binary ''),(16,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  13 con los siguientes datos:  NOMBRE USUARIO=  Diana Díaz Díaz PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Offline ULTIMA CONEXIÓN =  2023-07-11 17:22:04','2024-04-17 23:20:07',_binary ''),(17,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  14 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Lucía PRIMER APELLIDO =  Luna SEGUNDO APELLIDO =  Luna FECHA NACIMIENTO =  1993-09-02 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  O- ESTATUS =   FECHA REGISTRO =  2022-08-30 11:10:56 FECHA ACTUALIZACIÓN = ','2024-04-17 23:20:07',_binary ''),(18,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  14 con los siguientes datos:  NOMBRE USUARIO=  Lucía Luna Luna PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Offline ULTIMA CONEXIÓN =  2023-06-04 14:24:38','2024-04-17 23:20:07',_binary ''),(19,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  15 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Esmeralda PRIMER APELLIDO =  Medina SEGUNDO APELLIDO =  Castillo FECHA NACIMIENTO =  1978-03-30 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  B- ESTATUS =   FECHA REGISTRO =  2020-04-17 08:03:31 FECHA ACTUALIZACIÓN = ','2024-04-17 23:20:07',_binary ''),(20,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  15 con los siguientes datos:  NOMBRE USUARIO=  Esmeralda Medina Castillo PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Offline ULTIMA CONEXIÓN =  2023-07-28 08:58:42','2024-04-17 23:20:07',_binary ''),(21,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  16 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Monica PRIMER APELLIDO =  Ortega SEGUNDO APELLIDO =  Reyes FECHA NACIMIENTO =  2003-02-18 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  AB+ ESTATUS =   FECHA REGISTRO =  2020-11-26 11:47:23 FECHA ACTUALIZACIÓN = ','2024-04-17 23:20:07',_binary ''),(22,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  16 con los siguientes datos:  NOMBRE USUARIO=  Monica Ortega Reyes PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Offline ULTIMA CONEXIÓN =  2024-02-13 17:29:17','2024-04-17 23:20:07',_binary ''),(23,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  17 con los siguientes datos:  TITULO CORTESIA =  Med. NOMBRE= Gerardo PRIMER APELLIDO =  Salazar SEGUNDO APELLIDO =  Vázquez FECHA NACIMIENTO =  1999-05-13 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  B+ ESTATUS =   FECHA REGISTRO =  2024-03-20 08:35:00 FECHA ACTUALIZACIÓN = ','2024-04-17 23:20:07',_binary ''),(24,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  17 con los siguientes datos:  NOMBRE USUARIO=  Med. Gerardo Salazar Vázquez PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Offline ULTIMA CONEXIÓN =  2024-03-28 12:05:18','2024-04-17 23:20:07',_binary ''),(25,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  18 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Jorge PRIMER APELLIDO =  Juárez SEGUNDO APELLIDO =  Salazar FECHA NACIMIENTO =  1974-01-03 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  A+ ESTATUS =   FECHA REGISTRO =  2020-11-12 19:21:21 FECHA ACTUALIZACIÓN = ','2024-04-17 23:20:07',_binary ''),(26,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  18 con los siguientes datos:  NOMBRE USUARIO=  Jorge Juárez Salazar PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Offline ULTIMA CONEXIÓN =  2021-04-20 17:32:49','2024-04-17 23:20:07',_binary ''),(27,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  19 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Ameli PRIMER APELLIDO =  Gómes SEGUNDO APELLIDO =  Álvarez FECHA NACIMIENTO =  2005-10-02 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  A- ESTATUS =   FECHA REGISTRO =  2024-02-10 11:39:52 FECHA ACTUALIZACIÓN = ','2024-04-17 23:20:07',_binary ''),(28,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  19 con los siguientes datos:  NOMBRE USUARIO=  Ameli Gómes Álvarez PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Offline ULTIMA CONEXIÓN =  2024-03-25 12:18:44','2024-04-17 23:20:07',_binary ''),(29,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  20 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Fernando PRIMER APELLIDO =  Vázquez SEGUNDO APELLIDO =  Herrera FECHA NACIMIENTO =  1983-04-12 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  B- ESTATUS =   FECHA REGISTRO =  2023-08-04 17:33:26 FECHA ACTUALIZACIÓN = ','2024-04-17 23:20:07',_binary ''),(30,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  20 con los siguientes datos:  NOMBRE USUARIO=  Fernando Vázquez Herrera PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Offline ULTIMA CONEXIÓN =  2023-12-04 19:48:53','2024-04-17 23:20:07',_binary ''),(31,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  1 con los siguientes datos:  NOMBRE =  Bebida isotónica MARCA =  SpeedStep PRECIO ACTUAL =  20.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:20:07',_binary ''),(32,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  2 con los siguientes datos:  NOMBRE =  Esterilla de yoga MARCA =  FlexiBand PRECIO ACTUAL =  30.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:20:07',_binary ''),(33,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  3 con los siguientes datos:  NOMBRE =  Magnesio para mejorar el agarre MARCA =  FlexiBand PRECIO ACTUAL =  60.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:20:07',_binary ''),(34,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  4 con los siguientes datos:  NOMBRE =  Bloque de espuma para estiramientos MARCA =  PowerBands PRECIO ACTUAL =  80.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:20:07',_binary ''),(35,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  5 con los siguientes datos:  NOMBRE =  Bloque de espuma para estiramientos MARCA =  FlexiPod PRECIO ACTUAL =  20.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:20:07',_binary ''),(36,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  6 con los siguientes datos:  NOMBRE =  Colchoneta para ejercicios MARCA =  PowerBar PRECIO ACTUAL =  20.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:20:07',_binary ''),(37,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  7 con los siguientes datos:  NOMBRE =  Bebida energética pre-entrenamiento MARCA =  MuscleRelief PRECIO ACTUAL =  80.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:20:07',_binary ''),(38,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  8 con los siguientes datos:  NOMBRE =  Suplemento pre-entrenamiento MARCA =  PowerSprint PRECIO ACTUAL =  90.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:20:07',_binary ''),(39,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  9 con los siguientes datos:  NOMBRE =  Suplemento pre-entrenamiento MARCA =  PowerProtein PRECIO ACTUAL =  20.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:20:07',_binary ''),(40,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  10 con los siguientes datos:  NOMBRE =  Vendas para muñecas y tobillos MARCA =  CardioCharge PRECIO ACTUAL =  60.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:20:07',_binary ''),(41,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  11 con los siguientes datos:  NOMBRE =  Banda de resistencia para entrenamiento MARCA =  FlexiWheel PRECIO ACTUAL =  20.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:20:07',_binary ''),(42,'root@localhost','Create','detalles_productos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  11 con los siguientes datos:  PRODUCTO ID =  Banda de resistencia para entrenamiento FlexiWheel DESCRIPCION =  Suplemento que contiene los aminoácidos esenciales leucina, isoleucina y valina, que ayudan a promover la recuperación muscular, reducir la fatiga y preservar la masa muscular durante el ejercicio. CODIGO DE BARRAS =  123457354 PRESENTACION =  Proteína Whey Gold Standard ESTATUS =  Activa','2024-04-17 23:20:07',_binary ''),(43,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  12 con los siguientes datos:  NOMBRE =  Banda de resistencia para estiramientos MARCA =  PowerProtein PRECIO ACTUAL =  10.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:20:07',_binary ''),(44,'root@localhost','Create','detalles_productos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  12 con los siguientes datos:  PRODUCTO ID =  Banda de resistencia para estiramientos PowerProtein DESCRIPCION =  Suplemento que contiene los aminoácidos esenciales leucina, isoleucina y valina, que ayudan a promover la recuperación muscular, reducir la fatiga y preservar la masa muscular durante el ejercicio. CODIGO DE BARRAS =  190532901 PRESENTACION =  Nordic Naturals Ultimate Omega ESTATUS =  Activa','2024-04-17 23:20:07',_binary ''),(45,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  13 con los siguientes datos:  NOMBRE =  Suplemento de creatina MARCA =  FlexiBottle PRECIO ACTUAL =  40.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:20:07',_binary ''),(46,'root@localhost','Create','detalles_productos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  13 con los siguientes datos:  PRODUCTO ID =  Suplemento de creatina FlexiBottle DESCRIPCION =  Suplemento nutricional utilizado para aumentar la ingesta de proteínas, promover la recuperación muscular y el crecimiento después del entrenamiento. CODIGO DE BARRAS =  105389073 PRESENTACION =  C4 Original Pre-Workout) ESTATUS =  Activa','2024-04-17 23:20:07',_binary ''),(47,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  14 con los siguientes datos:  NOMBRE =  Batidos de proteínas MARCA =  SpeedStep PRECIO ACTUAL =  60.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:20:07',_binary ''),(48,'root@localhost','Create','detalles_productos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  14 con los siguientes datos:  PRODUCTO ID =  Batidos de proteínas SpeedStep DESCRIPCION =  Suplemento utilizado para aumentar la fuerza, la potencia y ​​la masa muscular, al mejorar la disponibilidad de energía en los músculos durante el ejercicio de alta intensidad. CODIGO DE BARRAS =  385987635 PRESENTACION =  Nordic Naturals Ultimate Omega ESTATUS =  Activa','2024-04-17 23:20:07',_binary ''),(49,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  15 con los siguientes datos:  NOMBRE =  Banda elástica para ejercicios de resistencia MARCA =  FlexiGel PRECIO ACTUAL =  30.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:20:07',_binary ''),(50,'root@localhost','Create','detalles_productos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  15 con los siguientes datos:  PRODUCTO ID =  Banda elástica para ejercicios de resistencia FlexiGel DESCRIPCION =  Suplemento que contiene ácidos grasos esenciales omega-3, conocidos por sus efectos antiinflamatorios y beneficios para la salud cardiovascular y articular. CODIGO DE BARRAS =  450578976 PRESENTACION =  Xtend BCAA Powder ESTATUS =  Activa','2024-04-17 23:20:07',_binary ''),(51,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  16 con los siguientes datos:  NOMBRE =  Colchoneta para ejercicios MARCA =  FlexiStick PRECIO ACTUAL =  40.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:20:07',_binary ''),(52,'root@localhost','Create','detalles_productos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  16 con los siguientes datos:  PRODUCTO ID =  Colchoneta para ejercicios FlexiStick DESCRIPCION =  Suplemento que contiene ácidos grasos esenciales omega-3, conocidos por sus efectos antiinflamatorios y beneficios para la salud cardiovascular y articular. CODIGO DE BARRAS =  385987635 PRESENTACION =  Proteína Whey Gold Standard ESTATUS =  Activa','2024-04-17 23:20:07',_binary ''),(53,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  17 con los siguientes datos:  NOMBRE =  Bebida isotónica MARCA =  FlexiMat PRECIO ACTUAL =  50.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:20:07',_binary ''),(54,'root@localhost','Create','detalles_productos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  17 con los siguientes datos:  PRODUCTO ID =  Bebida isotónica FlexiMat DESCRIPCION =  Fórmula diseñada para aumentar la energía, mejorar el enfoque mental y la resistencia durante el entrenamiento, generalmente contiene ingredientes como cafeína, beta-alanina y creatina. CODIGO DE BARRAS =  450578976 PRESENTACION =   Optimum Nutrition Creatine Monohydrate ESTATUS =  Activa','2024-04-17 23:20:07',_binary ''),(55,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  18 con los siguientes datos:  NOMBRE =  Suplemento de creatina MARCA =  FlexiFoam PRECIO ACTUAL =  60.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:20:07',_binary ''),(56,'root@localhost','Create','detalles_productos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  18 con los siguientes datos:  PRODUCTO ID =  Suplemento de creatina FlexiFoam DESCRIPCION =  Snacks convenientes y portátiles que proporcionan una fuente rápida de proteínas y carbohidratos, ideales para consumir antes o después del entrenamiento para apoyar la recuperación muscular. CODIGO DE BARRAS =  450578976 PRESENTACION =  C4 Original Pre-Workout) ESTATUS =  Activa','2024-04-17 23:20:07',_binary ''),(57,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  19 con los siguientes datos:  NOMBRE =  Magnesio para mejorar el agarre MARCA =  MuscleRelief PRECIO ACTUAL =  30.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:20:07',_binary ''),(58,'root@localhost','Create','detalles_productos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  19 con los siguientes datos:  PRODUCTO ID =  Magnesio para mejorar el agarre MuscleRelief DESCRIPCION =  Suplemento utilizado para aumentar la fuerza, la potencia y ​​la masa muscular, al mejorar la disponibilidad de energía en los músculos durante el ejercicio de alta intensidad. CODIGO DE BARRAS =  105389073 PRESENTACION =  Xtend BCAA Powder ESTATUS =  Activa','2024-04-17 23:20:07',_binary ''),(59,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  20 con los siguientes datos:  NOMBRE =  Termogénico para quemar grasa MARCA =  FlexiBall PRECIO ACTUAL =  70.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:20:07',_binary ''),(60,'root@localhost','Create','detalles_productos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  20 con los siguientes datos:  PRODUCTO ID =  Termogénico para quemar grasa FlexiBall DESCRIPCION =  Fórmula diseñada para aumentar la energía, mejorar el enfoque mental y la resistencia durante el entrenamiento, generalmente contiene ingredientes como cafeína, beta-alanina y creatina. CODIGO DE BARRAS =  123457354 PRESENTACION =  Nordic Naturals Ultimate Omega ESTATUS =  Activa','2024-04-17 23:20:07',_binary ''),(61,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  21 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Alejandro PRIMER APELLIDO =  Ramos SEGUNDO APELLIDO =  Herrera FECHA NACIMIENTO =  1981-11-08 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  B+ ESTATUS =   FECHA REGISTRO =  2020-08-15 17:42:29 FECHA ACTUALIZACIÓN = ','2024-04-17 23:20:07',_binary ''),(62,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  21 con los siguientes datos:  NOMBRE USUARIO=  Alejandro Ramos Herrera PASSWORD =  TIPO =  Miembro ESTATUS CONEXIÓN =  Offline ULTIMA CONEXIÓN =  2021-09-07 14:54:32','2024-04-17 23:20:07',_binary ''),(63,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  21 con los siguientes datos:  NOMBRE =  Batidos de proteínas MARCA =  MuscleRecover PRECIO ACTUAL =  60.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:20:07',_binary ''),(64,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  1 con los siguientes datos:  USUARIO ID =  Alejandro Ramos Herrera PRODUCTO ID =  Batidos de proteínas MuscleRecover 60.00 TOTAL =  100.00 FECHA REGISTRO =  2024-04-09 09:30:11 ESTATUS =  Activa','2024-04-17 23:20:07',_binary ''),(65,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  22 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Ana PRIMER APELLIDO =  Salazar SEGUNDO APELLIDO =  Díaz FECHA NACIMIENTO =  1969-08-27 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  A+ ESTATUS =   FECHA REGISTRO =  2022-05-10 15:35:02 FECHA ACTUALIZACIÓN = ','2024-04-17 23:20:07',_binary ''),(66,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  22 con los siguientes datos:  NOMBRE USUARIO=  Ana Salazar Díaz PASSWORD =  TIPO =  Miembro ESTATUS CONEXIÓN =  Banned ULTIMA CONEXIÓN =  2024-01-01 10:30:06','2024-04-17 23:20:07',_binary ''),(67,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  22 con los siguientes datos:  NOMBRE =  Bebida isotónica MARCA =  PowerLift PRECIO ACTUAL =  80.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:20:07',_binary ''),(68,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  2 con los siguientes datos:  USUARIO ID =  Ana Salazar Díaz PRODUCTO ID =  Bebida isotónica PowerLift 80.00 TOTAL =  40.00 FECHA REGISTRO =  2021-02-06 12:00:56 ESTATUS =  Activa','2024-04-17 23:20:07',_binary ''),(69,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  23 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Sofia PRIMER APELLIDO =  Guzmán SEGUNDO APELLIDO =  Ramírez FECHA NACIMIENTO =  1990-09-28 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  AB- ESTATUS =   FECHA REGISTRO =  2021-11-16 10:00:26 FECHA ACTUALIZACIÓN = ','2024-04-17 23:20:07',_binary ''),(70,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  23 con los siguientes datos:  NOMBRE USUARIO=  Sofia Guzmán Ramírez PASSWORD =  TIPO =  Miembro ESTATUS CONEXIÓN =  Online ULTIMA CONEXIÓN =  2022-01-02 18:41:31','2024-04-17 23:20:07',_binary ''),(71,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  23 con los siguientes datos:  NOMBRE =  Suplemento pre-entrenamiento MARCA =  PowerBeam PRECIO ACTUAL =  10.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:20:07',_binary ''),(72,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  3 con los siguientes datos:  USUARIO ID =  Sofia Guzmán Ramírez PRODUCTO ID =  Suplemento pre-entrenamiento PowerBeam 10.00 TOTAL =  10.00 FECHA REGISTRO =  2020-03-10 08:24:32 ESTATUS =  Activa','2024-04-17 23:20:07',_binary ''),(73,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  24 con los siguientes datos:  TITULO CORTESIA =  Mtro. NOMBRE= Mario PRIMER APELLIDO =  Hernández SEGUNDO APELLIDO =  Luna FECHA NACIMIENTO =  1968-02-01 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  B+ ESTATUS =   FECHA REGISTRO =  2021-05-16 13:48:31 FECHA ACTUALIZACIÓN = ','2024-04-17 23:20:07',_binary ''),(74,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  24 con los siguientes datos:  NOMBRE USUARIO=  Mtro. Mario Hernández Luna PASSWORD =  TIPO =  Visitante ESTATUS CONEXIÓN =  Banned ULTIMA CONEXIÓN =  2023-12-10 18:01:52','2024-04-17 23:20:07',_binary ''),(75,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  24 con los siguientes datos:  NOMBRE =  Correa de estiramiento MARCA =  FlexiStrap PRECIO ACTUAL =  50.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:20:07',_binary ''),(76,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  4 con los siguientes datos:  USUARIO ID =  Mtro. Mario Hernández Luna PRODUCTO ID =  Correa de estiramiento FlexiStrap 50.00 TOTAL =  60.00 FECHA REGISTRO =  2021-04-15 19:19:36 ESTATUS =  Activa','2024-04-17 23:20:07',_binary ''),(77,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  25 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Federico PRIMER APELLIDO =  Álvarez SEGUNDO APELLIDO =  García FECHA NACIMIENTO =  1988-09-01 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  O- ESTATUS =   FECHA REGISTRO =  2022-11-08 15:43:37 FECHA ACTUALIZACIÓN = ','2024-04-17 23:20:07',_binary ''),(78,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  25 con los siguientes datos:  NOMBRE USUARIO=  Federico Álvarez García PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Online ULTIMA CONEXIÓN =  2023-04-29 08:21:25','2024-04-17 23:20:07',_binary ''),(79,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  25 con los siguientes datos:  NOMBRE =  Suplemento de creatina MARCA =  FlexiStick PRECIO ACTUAL =  30.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:20:07',_binary ''),(80,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  5 con los siguientes datos:  USUARIO ID =  Federico Álvarez García PRODUCTO ID =  Suplemento de creatina FlexiStick 30.00 TOTAL =  10.00 FECHA REGISTRO =  2022-01-06 10:18:41 ESTATUS =  Activa','2024-04-17 23:20:07',_binary ''),(81,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  26 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Hugo PRIMER APELLIDO =  García SEGUNDO APELLIDO =  Ramírez FECHA NACIMIENTO =  1995-02-01 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  A- ESTATUS =   FECHA REGISTRO =  2022-09-26 16:14:40 FECHA ACTUALIZACIÓN = ','2024-04-17 23:20:07',_binary ''),(82,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  26 con los siguientes datos:  NOMBRE USUARIO=  Hugo García Ramírez PASSWORD =  TIPO =  Miembro ESTATUS CONEXIÓN =  Offline ULTIMA CONEXIÓN =  2023-02-09 14:08:16','2024-04-17 23:20:07',_binary ''),(83,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  26 con los siguientes datos:  NOMBRE =  Bebida energética post-entrenamiento MARCA =  SpeedJump PRECIO ACTUAL =  80.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:20:07',_binary ''),(84,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  6 con los siguientes datos:  USUARIO ID =  Hugo García Ramírez PRODUCTO ID =  Bebida energética post-entrenamiento SpeedJump 80.00 TOTAL =  80.00 FECHA REGISTRO =  2023-01-07 09:42:32 ESTATUS =  Activa','2024-04-17 23:20:07',_binary ''),(85,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  27 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Suri PRIMER APELLIDO =  Hernández SEGUNDO APELLIDO =  Juárez FECHA NACIMIENTO =  2006-09-28 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  A+ ESTATUS =   FECHA REGISTRO =  2021-01-20 09:38:55 FECHA ACTUALIZACIÓN = ','2024-04-17 23:20:07',_binary ''),(86,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  27 con los siguientes datos:  NOMBRE USUARIO=  Suri Hernández Juárez PASSWORD =  TIPO =  Instructor ESTATUS CONEXIÓN =  Offline ULTIMA CONEXIÓN =  2023-10-22 10:41:51','2024-04-17 23:20:07',_binary ''),(87,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  27 con los siguientes datos:  NOMBRE =  Rodillo de espuma para masaje muscular MARCA =  FlexiStrap PRECIO ACTUAL =  40.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:20:07',_binary ''),(88,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  7 con los siguientes datos:  USUARIO ID =  Suri Hernández Juárez PRODUCTO ID =  Rodillo de espuma para masaje muscular FlexiStrap 40.00 TOTAL =  100.00 FECHA REGISTRO =  2023-11-22 15:17:48 ESTATUS =  Activa','2024-04-17 23:20:07',_binary ''),(89,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  28 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Esmeralda PRIMER APELLIDO =  Álvarez SEGUNDO APELLIDO =  Castro FECHA NACIMIENTO =  2005-11-17 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  AB- ESTATUS =   FECHA REGISTRO =  2021-04-14 15:16:46 FECHA ACTUALIZACIÓN = ','2024-04-17 23:20:07',_binary ''),(90,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  28 con los siguientes datos:  NOMBRE USUARIO=  Esmeralda Álvarez Castro PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Banned ULTIMA CONEXIÓN =  2023-11-16 16:56:25','2024-04-17 23:20:07',_binary ''),(91,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  28 con los siguientes datos:  NOMBRE =  Bebida energética pre-entrenamiento MARCA =  FlexiWheel PRECIO ACTUAL =  100.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:20:07',_binary ''),(92,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  8 con los siguientes datos:  USUARIO ID =  Esmeralda Álvarez Castro PRODUCTO ID =  Bebida energética pre-entrenamiento FlexiWheel 100.00 TOTAL =  50.00 FECHA REGISTRO =  2020-08-22 14:08:21 ESTATUS =  Activa','2024-04-17 23:20:07',_binary ''),(93,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  29 con los siguientes datos:  TITULO CORTESIA =  Tnte. NOMBRE= Aldair PRIMER APELLIDO =  Ortega SEGUNDO APELLIDO =  Romero FECHA NACIMIENTO =  2006-07-08 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  B+ ESTATUS =   FECHA REGISTRO =  2022-01-26 15:03:03 FECHA ACTUALIZACIÓN = ','2024-04-17 23:20:07',_binary ''),(94,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  29 con los siguientes datos:  NOMBRE USUARIO=  Tnte. Aldair Ortega Romero PASSWORD =  TIPO =  Visitante ESTATUS CONEXIÓN =  Banned ULTIMA CONEXIÓN =  2024-04-06 18:15:57','2024-04-17 23:20:07',_binary ''),(95,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  29 con los siguientes datos:  NOMBRE =  Banda de resistencia para estiramientos MARCA =  FlexiGrip PRECIO ACTUAL =  20.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:20:07',_binary ''),(96,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  9 con los siguientes datos:  USUARIO ID =  Tnte. Aldair Ortega Romero PRODUCTO ID =  Banda de resistencia para estiramientos FlexiGrip 20.00 TOTAL =  90.00 FECHA REGISTRO =  2022-10-25 16:59:55 ESTATUS =  Activa','2024-04-17 23:20:07',_binary ''),(97,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  30 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Esmeralda PRIMER APELLIDO =  Guerrero SEGUNDO APELLIDO =  Chávez FECHA NACIMIENTO =  1966-03-10 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  O- ESTATUS =   FECHA REGISTRO =  2022-05-26 17:40:06 FECHA ACTUALIZACIÓN = ','2024-04-17 23:20:07',_binary ''),(98,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  30 con los siguientes datos:  NOMBRE USUARIO=  Esmeralda Guerrero Chávez PASSWORD =  TIPO =  Visitante ESTATUS CONEXIÓN =  Offline ULTIMA CONEXIÓN =  2023-08-23 11:03:53','2024-04-17 23:20:07',_binary ''),(99,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  30 con los siguientes datos:  NOMBRE =  Banda de resistencia para estiramientos MARCA =  SpeedSpike PRECIO ACTUAL =  100.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:20:07',_binary ''),(100,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  10 con los siguientes datos:  USUARIO ID =  Esmeralda Guerrero Chávez PRODUCTO ID =  Banda de resistencia para estiramientos SpeedSpike 100.00 TOTAL =  40.00 FECHA REGISTRO =  2023-12-07 14:37:45 ESTATUS =  Activa','2024-04-17 23:20:07',_binary ''),(101,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  31 con los siguientes datos:  TITULO CORTESIA =  Ing. NOMBRE= Juan PRIMER APELLIDO =  Ramírez SEGUNDO APELLIDO =  Ramos FECHA NACIMIENTO =  1992-06-04 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  B- ESTATUS =   FECHA REGISTRO =  2021-03-20 08:21:35 FECHA ACTUALIZACIÓN = ','2024-04-17 23:20:07',_binary ''),(102,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  31 con los siguientes datos:  NOMBRE USUARIO=  Ing. Juan Ramírez Ramos PASSWORD =  TIPO =  Visitante ESTATUS CONEXIÓN =  Offline ULTIMA CONEXIÓN =  2021-08-27 13:51:07','2024-04-17 23:20:07',_binary ''),(103,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  31 con los siguientes datos:  NOMBRE =  Batidos de proteínas MARCA =  MuscleEase PRECIO ACTUAL =  100.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:20:07',_binary ''),(104,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  11 con los siguientes datos:  USUARIO ID =  Ing. Juan Ramírez Ramos PRODUCTO ID =  Batidos de proteínas MuscleEase 100.00 TOTAL =  90.00 FECHA REGISTRO =  2021-12-09 16:41:38 ESTATUS =  Activa','2024-04-17 23:20:07',_binary ''),(105,'root@localhost','Create','detalles_pedidos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  1 con los siguientes datos:  PEDIDO ID =  31 90.00 2021-12-09 16:41:38 PRODUCTO ID =  Bebida isotónica SpeedStep CANTIDAD =  380 TOTAL PARCIAL =  20.00 FECHA REGISTRO =  2020-02-04 15:22:00 FECHA ENTREGA =  2024-04-17 23:20:07 ESTATUS =  Activa','2024-04-17 23:20:07',_binary ''),(106,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  32 con los siguientes datos:  TITULO CORTESIA =  C. NOMBRE= Fernando PRIMER APELLIDO =  Guzmán SEGUNDO APELLIDO =  Sánchez FECHA NACIMIENTO =  1982-01-10 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  O- ESTATUS =   FECHA REGISTRO =  2024-03-24 11:34:03 FECHA ACTUALIZACIÓN = ','2024-04-17 23:20:07',_binary ''),(107,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  32 con los siguientes datos:  NOMBRE USUARIO=  C. Fernando Guzmán Sánchez PASSWORD =  TIPO =  Miembro ESTATUS CONEXIÓN =  Banned ULTIMA CONEXIÓN =  2024-03-30 19:38:18','2024-04-17 23:20:07',_binary ''),(108,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  32 con los siguientes datos:  NOMBRE =  Guantes para levantamiento de pesas MARCA =  PowerBar PRECIO ACTUAL =  30.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:20:07',_binary ''),(109,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  12 con los siguientes datos:  USUARIO ID =  C. Fernando Guzmán Sánchez PRODUCTO ID =  Guantes para levantamiento de pesas PowerBar 30.00 TOTAL =  60.00 FECHA REGISTRO =  2021-04-27 17:16:19 ESTATUS =  Activa','2024-04-17 23:20:07',_binary ''),(110,'root@localhost','Create','detalles_pedidos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  2 con los siguientes datos:  PEDIDO ID =  32 60.00 2021-04-27 17:16:19 PRODUCTO ID =  Bebida isotónica SpeedStep CANTIDAD =  60 TOTAL PARCIAL =  40.00 FECHA REGISTRO =  2020-05-20 11:37:26 FECHA ENTREGA =  2024-04-17 23:20:07 ESTATUS =  Activa','2024-04-17 23:20:07',_binary ''),(111,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  33 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Iram PRIMER APELLIDO =  Hernández SEGUNDO APELLIDO =  Herrera FECHA NACIMIENTO =  1975-11-11 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  AB- ESTATUS =   FECHA REGISTRO =  2021-09-23 19:32:42 FECHA ACTUALIZACIÓN = ','2024-04-17 23:20:07',_binary ''),(112,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  33 con los siguientes datos:  NOMBRE USUARIO=  Iram Hernández Herrera PASSWORD =  TIPO =  Miembro ESTATUS CONEXIÓN =  Online ULTIMA CONEXIÓN =  2023-11-17 17:36:50','2024-04-17 23:20:07',_binary ''),(113,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  33 con los siguientes datos:  NOMBRE =  Bebida isotónica MARCA =  CardioCharge PRECIO ACTUAL =  90.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:20:07',_binary ''),(114,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  13 con los siguientes datos:  USUARIO ID =  Iram Hernández Herrera PRODUCTO ID =  Bebida isotónica CardioCharge 90.00 TOTAL =  90.00 FECHA REGISTRO =  2024-01-15 08:59:37 ESTATUS =  Activa','2024-04-17 23:20:07',_binary ''),(115,'root@localhost','Create','detalles_pedidos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  3 con los siguientes datos:  PEDIDO ID =  33 90.00 2024-01-15 08:59:37 PRODUCTO ID =  Bebida isotónica SpeedStep CANTIDAD =  450 TOTAL PARCIAL =  80.00 FECHA REGISTRO =  2023-05-15 17:25:44 FECHA ENTREGA =  2024-04-17 23:20:07 ESTATUS =  Activa','2024-04-17 23:20:07',_binary ''),(116,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  34 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Sofia PRIMER APELLIDO =  Contreras SEGUNDO APELLIDO =  Mendoza FECHA NACIMIENTO =  1989-12-28 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  O- ESTATUS =   FECHA REGISTRO =  2022-10-22 14:35:24 FECHA ACTUALIZACIÓN = ','2024-04-17 23:20:07',_binary ''),(117,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  34 con los siguientes datos:  NOMBRE USUARIO=  Sofia Contreras Mendoza PASSWORD =  TIPO =  Instructor ESTATUS CONEXIÓN =  Online ULTIMA CONEXIÓN =  2022-10-31 11:13:11','2024-04-17 23:20:07',_binary ''),(118,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  34 con los siguientes datos:  NOMBRE =  Suplemento pre-entrenamiento MARCA =  FlexiBlock PRECIO ACTUAL =  30.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:20:07',_binary ''),(119,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  14 con los siguientes datos:  USUARIO ID =  Sofia Contreras Mendoza PRODUCTO ID =  Suplemento pre-entrenamiento FlexiBlock 30.00 TOTAL =  60.00 FECHA REGISTRO =  2023-11-25 18:30:12 ESTATUS =  Activa','2024-04-17 23:20:07',_binary ''),(120,'root@localhost','Create','detalles_pedidos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  4 con los siguientes datos:  PEDIDO ID =  34 60.00 2023-11-25 18:30:12 PRODUCTO ID =  Bebida isotónica SpeedStep CANTIDAD =  500 TOTAL PARCIAL =  70.00 FECHA REGISTRO =  2020-12-10 10:18:10 FECHA ENTREGA =  2024-04-17 23:20:07 ESTATUS =  Activa','2024-04-17 23:20:07',_binary ''),(121,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  35 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Brenda PRIMER APELLIDO =  Estrada SEGUNDO APELLIDO =  Mendoza FECHA NACIMIENTO =  1970-10-01 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  O- ESTATUS =   FECHA REGISTRO =  2020-06-18 15:51:29 FECHA ACTUALIZACIÓN = ','2024-04-17 23:20:07',_binary ''),(122,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  35 con los siguientes datos:  NOMBRE USUARIO=  Brenda Estrada Mendoza PASSWORD =  TIPO =  Instructor ESTATUS CONEXIÓN =  Banned ULTIMA CONEXIÓN =  2020-09-29 08:10:41','2024-04-17 23:20:07',_binary ''),(123,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  35 con los siguientes datos:  NOMBRE =  Bloque de espuma para estiramientos MARCA =  MuscleRelief PRECIO ACTUAL =  60.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:20:07',_binary ''),(124,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  15 con los siguientes datos:  USUARIO ID =  Brenda Estrada Mendoza PRODUCTO ID =  Bloque de espuma para estiramientos MuscleRelief 60.00 TOTAL =  10.00 FECHA REGISTRO =  2022-10-05 08:37:18 ESTATUS =  Activa','2024-04-17 23:20:07',_binary ''),(125,'root@localhost','Create','detalles_pedidos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  5 con los siguientes datos:  PEDIDO ID =  35 10.00 2022-10-05 08:37:18 PRODUCTO ID =  Bebida isotónica SpeedStep CANTIDAD =  380 TOTAL PARCIAL =  50.00 FECHA REGISTRO =  2022-01-24 19:03:04 FECHA ENTREGA =  2024-04-17 23:20:07 ESTATUS =  Activa','2024-04-17 23:20:07',_binary ''),(126,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  36 con los siguientes datos:  TITULO CORTESIA =  Tnte. NOMBRE= Edgar PRIMER APELLIDO =  Pérez SEGUNDO APELLIDO =  Romero FECHA NACIMIENTO =  1969-11-21 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  AB+ ESTATUS =   FECHA REGISTRO =  2020-06-13 18:27:02 FECHA ACTUALIZACIÓN = ','2024-04-17 23:20:07',_binary ''),(127,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  36 con los siguientes datos:  NOMBRE USUARIO=  Tnte. Edgar Pérez Romero PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Offline ULTIMA CONEXIÓN =  2023-08-26 12:40:20','2024-04-17 23:20:07',_binary ''),(128,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  36 con los siguientes datos:  NOMBRE =  Banda de resistencia para entrenamiento MARCA =  MuscleMax PRECIO ACTUAL =  10.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:20:07',_binary ''),(129,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  16 con los siguientes datos:  USUARIO ID =  Tnte. Edgar Pérez Romero PRODUCTO ID =  Banda de resistencia para entrenamiento MuscleMax 10.00 TOTAL =  10.00 FECHA REGISTRO =  2023-11-23 13:59:43 ESTATUS =  Activa','2024-04-17 23:20:07',_binary ''),(130,'root@localhost','Create','detalles_pedidos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  6 con los siguientes datos:  PEDIDO ID =  36 10.00 2023-11-23 13:59:43 PRODUCTO ID =  Bebida isotónica SpeedStep CANTIDAD =  500 TOTAL PARCIAL =  40.00 FECHA REGISTRO =  2022-08-22 18:50:36 FECHA ENTREGA =  2024-04-17 23:20:07 ESTATUS =  Activa','2024-04-17 23:20:07',_binary ''),(131,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  37 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Karla PRIMER APELLIDO =  Moreno SEGUNDO APELLIDO =  Castillo FECHA NACIMIENTO =  1961-01-29 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  AB- ESTATUS =   FECHA REGISTRO =  2021-10-31 08:09:03 FECHA ACTUALIZACIÓN = ','2024-04-17 23:20:07',_binary ''),(132,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  37 con los siguientes datos:  NOMBRE USUARIO=  Karla Moreno Castillo PASSWORD =  TIPO =  Instructor ESTATUS CONEXIÓN =  Banned ULTIMA CONEXIÓN =  2021-11-17 13:45:24','2024-04-17 23:20:07',_binary ''),(133,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  37 con los siguientes datos:  NOMBRE =  Banda de resistencia para estiramientos MARCA =  SpeedGrip PRECIO ACTUAL =  30.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:20:07',_binary ''),(134,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  17 con los siguientes datos:  USUARIO ID =  Karla Moreno Castillo PRODUCTO ID =  Banda de resistencia para estiramientos SpeedGrip 30.00 TOTAL =  60.00 FECHA REGISTRO =  2023-10-19 17:53:10 ESTATUS =  Activa','2024-04-17 23:20:07',_binary ''),(135,'root@localhost','Create','detalles_pedidos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  7 con los siguientes datos:  PEDIDO ID =  37 60.00 2023-10-19 17:53:10 PRODUCTO ID =  Bebida isotónica SpeedStep CANTIDAD =  450 TOTAL PARCIAL =  90.00 FECHA REGISTRO =  2023-11-08 18:52:55 FECHA ENTREGA =  2024-04-17 23:20:07 ESTATUS =  Activa','2024-04-17 23:20:07',_binary ''),(136,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  38 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Daniel PRIMER APELLIDO =  Jiménez SEGUNDO APELLIDO =  Herrera FECHA NACIMIENTO =  1979-02-28 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  A+ ESTATUS =   FECHA REGISTRO =  2023-12-04 13:52:16 FECHA ACTUALIZACIÓN = ','2024-04-17 23:20:07',_binary ''),(137,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  38 con los siguientes datos:  NOMBRE USUARIO=  Daniel Jiménez Herrera PASSWORD =  TIPO =  Miembro ESTATUS CONEXIÓN =  Online ULTIMA CONEXIÓN =  2023-12-30 17:23:48','2024-04-17 23:20:07',_binary ''),(138,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  38 con los siguientes datos:  NOMBRE =  Banda de resistencia para estiramientos MARCA =  PowerPulse PRECIO ACTUAL =  60.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:20:07',_binary ''),(139,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  18 con los siguientes datos:  USUARIO ID =  Daniel Jiménez Herrera PRODUCTO ID =  Banda de resistencia para estiramientos PowerPulse 60.00 TOTAL =  100.00 FECHA REGISTRO =  2020-03-21 12:33:07 ESTATUS =  Activa','2024-04-17 23:20:07',_binary ''),(140,'root@localhost','Create','detalles_pedidos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  8 con los siguientes datos:  PEDIDO ID =  38 100.00 2020-03-21 12:33:07 PRODUCTO ID =  Bebida isotónica SpeedStep CANTIDAD =  500 TOTAL PARCIAL =  60.00 FECHA REGISTRO =  2022-10-11 14:05:08 FECHA ENTREGA =  2024-04-17 23:20:07 ESTATUS =  Activa','2024-04-17 23:20:07',_binary ''),(141,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  39 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Adan PRIMER APELLIDO =  Cortes SEGUNDO APELLIDO =  Álvarez FECHA NACIMIENTO =  2008-01-19 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  B- ESTATUS =   FECHA REGISTRO =  2024-01-09 14:21:09 FECHA ACTUALIZACIÓN = ','2024-04-17 23:20:07',_binary ''),(142,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  39 con los siguientes datos:  NOMBRE USUARIO=  Adan Cortes Álvarez PASSWORD =  TIPO =  Instructor ESTATUS CONEXIÓN =  Offline ULTIMA CONEXIÓN =  2024-02-26 15:33:42','2024-04-17 23:20:07',_binary ''),(143,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  39 con los siguientes datos:  NOMBRE =  Termogénico para quemar grasa MARCA =  FlexiBottle PRECIO ACTUAL =  80.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:20:07',_binary ''),(144,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  19 con los siguientes datos:  USUARIO ID =  Adan Cortes Álvarez PRODUCTO ID =  Termogénico para quemar grasa FlexiBottle 80.00 TOTAL =  30.00 FECHA REGISTRO =  2023-11-29 17:15:38 ESTATUS =  Activa','2024-04-17 23:20:07',_binary ''),(145,'root@localhost','Create','detalles_pedidos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  9 con los siguientes datos:  PEDIDO ID =  39 30.00 2023-11-29 17:15:38 PRODUCTO ID =  Bebida isotónica SpeedStep CANTIDAD =  10 TOTAL PARCIAL =  40.00 FECHA REGISTRO =  2020-11-25 09:09:31 FECHA ENTREGA =  2024-04-17 23:20:07 ESTATUS =  Activa','2024-04-17 23:20:07',_binary ''),(146,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  40 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Karla PRIMER APELLIDO =  Juárez SEGUNDO APELLIDO =  Rodríguez FECHA NACIMIENTO =  1999-01-07 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  AB- ESTATUS =   FECHA REGISTRO =  2023-12-23 15:22:28 FECHA ACTUALIZACIÓN = ','2024-04-17 23:20:07',_binary ''),(147,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  40 con los siguientes datos:  NOMBRE USUARIO=  Karla Juárez Rodríguez PASSWORD =  TIPO =  Visitante ESTATUS CONEXIÓN =  Offline ULTIMA CONEXIÓN =  2024-01-24 13:44:30','2024-04-17 23:20:07',_binary ''),(148,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  40 con los siguientes datos:  NOMBRE =  Rodillo de espuma para masaje muscular MARCA =  FlexiFoam PRECIO ACTUAL =  40.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:20:07',_binary ''),(149,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  20 con los siguientes datos:  USUARIO ID =  Karla Juárez Rodríguez PRODUCTO ID =  Rodillo de espuma para masaje muscular FlexiFoam 40.00 TOTAL =  40.00 FECHA REGISTRO =  2023-04-22 17:57:03 ESTATUS =  Activa','2024-04-17 23:20:07',_binary ''),(150,'root@localhost','Create','detalles_pedidos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  10 con los siguientes datos:  PEDIDO ID =  40 40.00 2023-04-22 17:57:03 PRODUCTO ID =  Bebida isotónica SpeedStep CANTIDAD =  60 TOTAL PARCIAL =  80.00 FECHA REGISTRO =  2024-03-30 18:04:08 FECHA ENTREGA =  2024-04-17 23:20:07 ESTATUS =  Activa','2024-04-17 23:20:07',_binary ''),(151,'root@localhost','Update','sucursales','Se ha modificado una SUCURSAL  existente con el ID:  1 con los siguientes datos: NOMBRE = Xicotepec cambio a Xicotepec DIRECCION = Av. 5 de Mayo #75, Col. Centro cambio a Av. 5 de Mayo #75, Col. Centro RESPONSABLE =  Sin responsable asingado. cambio a Sin responsable asingado. TOTAL CLIENTES ATENDIDOS  = 0 cambio a 0 PROMEDIO DE CLIENTES POR DIA = 0 cambio a 0 CAPACIDAD MÀXIMA = 80 cambio a 80 TOTAL EMPLEADOS = 0 cambio a 0 HORARIO_DISPONIBILIDAD = 08:00 a 24:00 cambio a 08:00 a 24:00 ESTATUS =  Activa cambio a Activa','2024-04-17 23:22:44',_binary ''),(152,'root@localhost','Update','sucursales','Se ha modificado una SUCURSAL  existente con el ID:  2 con los siguientes datos: NOMBRE = Villa Ávila Camacho cambio a Villa Ávila Camacho DIRECCION = Calle Asturinas #124, Col. del Rio cambio a Calle Asturinas #124, Col. del Rio RESPONSABLE =  Sin responsable asingado. cambio a Sin responsable asingado. TOTAL CLIENTES ATENDIDOS  = 0 cambio a 0 PROMEDIO DE CLIENTES POR DIA = 0 cambio a 0 CAPACIDAD MÀXIMA = 50 cambio a 50 TOTAL EMPLEADOS = 0 cambio a 0 HORARIO_DISPONIBILIDAD = 08:00 a 20:00 cambio a 08:00 a 20:00 ESTATUS =  Activa cambio a Activa','2024-04-17 23:22:44',_binary ''),(153,'root@localhost','Update','sucursales','Se ha modificado una SUCURSAL  existente con el ID:  3 con los siguientes datos: NOMBRE = San Isidro cambio a San Isidro DIRECCION = Av. Lopez Mateoz #162 Col. Tierra Negra cambio a Av. Lopez Mateoz #162 Col. Tierra Negra RESPONSABLE =  Sin responsable asingado. cambio a Sin responsable asingado. TOTAL CLIENTES ATENDIDOS  = 1 cambio a 1 PROMEDIO DE CLIENTES POR DIA = 1 cambio a 1 CAPACIDAD MÀXIMA = 90 cambio a 90 TOTAL EMPLEADOS = 0 cambio a 0 HORARIO_DISPONIBILIDAD = 09:00 a 21:00 cambio a 09:00 a 21:00 ESTATUS =  Activa cambio a Activa','2024-04-17 23:22:44',_binary ''),(154,'root@localhost','Update','sucursales','Se ha modificado una SUCURSAL  existente con el ID:  4 con los siguientes datos: NOMBRE = Seiva cambio a Seiva DIRECCION = Av. de las Torres #239, Col. Centro cambio a Av. de las Torres #239, Col. Centro RESPONSABLE =  Sin responsable asingado. cambio a Sin responsable asingado. TOTAL CLIENTES ATENDIDOS  = 0 cambio a 0 PROMEDIO DE CLIENTES POR DIA = 0 cambio a 0 CAPACIDAD MÀXIMA = 50 cambio a 50 TOTAL EMPLEADOS = 0 cambio a 0 HORARIO_DISPONIBILIDAD = 07:00 a 22:00 cambio a 07:00 a 22:00 ESTATUS =  Inactiva cambio a Inactiva','2024-04-17 23:22:44',_binary ''),(155,'root@localhost','Update','sucursales','Se ha modificado una SUCURSAL  existente con el ID:  5 con los siguientes datos: NOMBRE = Huahuchinango cambio a Huahuchinango DIRECCION = Calle Abasolo #25, Col.Barrio tibanco cambio a Calle Abasolo #25, Col.Barrio tibanco RESPONSABLE =  Sin responsable asingado. cambio a Sin responsable asingado. TOTAL CLIENTES ATENDIDOS  = 0 cambio a 0 PROMEDIO DE CLIENTES POR DIA = 0 cambio a 0 CAPACIDAD MÀXIMA = 56 cambio a 56 TOTAL EMPLEADOS = 0 cambio a 0 HORARIO_DISPONIBILIDAD = 07:00 a 21:00 cambio a 07:00 a 21:00 ESTATUS =  Activa cambio a Activa','2024-04-17 23:22:44',_binary ''),(156,'root@localhost','Delete','detalles_productos','Se ha eliminado un DETALLE_PRODUCTO con el ID:  11','2024-04-17 23:22:44',_binary ''),(157,'root@localhost','Delete','detalles_productos','Se ha eliminado un DETALLE_PRODUCTO con el ID:  12','2024-04-17 23:22:44',_binary ''),(158,'root@localhost','Delete','detalles_productos','Se ha eliminado un DETALLE_PRODUCTO con el ID:  13','2024-04-17 23:22:44',_binary ''),(159,'root@localhost','Delete','detalles_productos','Se ha eliminado un DETALLE_PRODUCTO con el ID:  14','2024-04-17 23:22:44',_binary ''),(160,'root@localhost','Delete','detalles_productos','Se ha eliminado un DETALLE_PRODUCTO con el ID:  15','2024-04-17 23:22:44',_binary ''),(161,'root@localhost','Delete','detalles_productos','Se ha eliminado un DETALLE_PRODUCTO con el ID:  16','2024-04-17 23:22:44',_binary ''),(162,'root@localhost','Delete','detalles_productos','Se ha eliminado un DETALLE_PRODUCTO con el ID:  17','2024-04-17 23:22:44',_binary ''),(163,'root@localhost','Delete','detalles_productos','Se ha eliminado un DETALLE_PRODUCTO con el ID:  18','2024-04-17 23:22:44',_binary ''),(164,'root@localhost','Delete','detalles_productos','Se ha eliminado un DETALLE_PRODUCTO con el ID:  19','2024-04-17 23:22:44',_binary ''),(165,'root@localhost','Delete','detalles_productos','Se ha eliminado un DETALLE_PRODUCTO con el ID:  20','2024-04-17 23:22:44',_binary ''),(166,'root@localhost','Delete','detalles_pedidos','Se ha eliminado una relación DETALLES_PEDIDOS con el ID:  1','2024-04-17 23:22:44',_binary ''),(167,'root@localhost','Delete','detalles_pedidos','Se ha eliminado una relación DETALLES_PEDIDOS con el ID:  2','2024-04-17 23:22:44',_binary ''),(168,'root@localhost','Delete','detalles_pedidos','Se ha eliminado una relación DETALLES_PEDIDOS con el ID:  3','2024-04-17 23:22:44',_binary ''),(169,'root@localhost','Delete','detalles_pedidos','Se ha eliminado una relación DETALLES_PEDIDOS con el ID:  4','2024-04-17 23:22:44',_binary ''),(170,'root@localhost','Delete','detalles_pedidos','Se ha eliminado una relación DETALLES_PEDIDOS con el ID:  5','2024-04-17 23:22:44',_binary ''),(171,'root@localhost','Delete','detalles_pedidos','Se ha eliminado una relación DETALLES_PEDIDOS con el ID:  6','2024-04-17 23:22:44',_binary ''),(172,'root@localhost','Delete','detalles_pedidos','Se ha eliminado una relación DETALLES_PEDIDOS con el ID:  7','2024-04-17 23:22:44',_binary ''),(173,'root@localhost','Delete','detalles_pedidos','Se ha eliminado una relación DETALLES_PEDIDOS con el ID:  8','2024-04-17 23:22:44',_binary ''),(174,'root@localhost','Delete','detalles_pedidos','Se ha eliminado una relación DETALLES_PEDIDOS con el ID:  9','2024-04-17 23:22:44',_binary ''),(175,'root@localhost','Delete','detalles_pedidos','Se ha eliminado una relación DETALLES_PEDIDOS con el ID:  10','2024-04-17 23:22:44',_binary ''),(176,'root@localhost','Delete','pedidos','Se ha eliminado un PEDIDO con el ID:  1','2024-04-17 23:22:44',_binary ''),(177,'root@localhost','Delete','pedidos','Se ha eliminado un PEDIDO con el ID:  2','2024-04-17 23:22:44',_binary ''),(178,'root@localhost','Delete','pedidos','Se ha eliminado un PEDIDO con el ID:  3','2024-04-17 23:22:44',_binary ''),(179,'root@localhost','Delete','pedidos','Se ha eliminado un PEDIDO con el ID:  4','2024-04-17 23:22:44',_binary ''),(180,'root@localhost','Delete','pedidos','Se ha eliminado un PEDIDO con el ID:  5','2024-04-17 23:22:44',_binary ''),(181,'root@localhost','Delete','pedidos','Se ha eliminado un PEDIDO con el ID:  6','2024-04-17 23:22:44',_binary ''),(182,'root@localhost','Delete','pedidos','Se ha eliminado un PEDIDO con el ID:  7','2024-04-17 23:22:44',_binary ''),(183,'root@localhost','Delete','pedidos','Se ha eliminado un PEDIDO con el ID:  8','2024-04-17 23:22:44',_binary ''),(184,'root@localhost','Delete','pedidos','Se ha eliminado un PEDIDO con el ID:  9','2024-04-17 23:22:44',_binary ''),(185,'root@localhost','Delete','pedidos','Se ha eliminado un PEDIDO con el ID:  10','2024-04-17 23:22:44',_binary ''),(186,'root@localhost','Delete','pedidos','Se ha eliminado un PEDIDO con el ID:  11','2024-04-17 23:22:44',_binary ''),(187,'root@localhost','Delete','pedidos','Se ha eliminado un PEDIDO con el ID:  12','2024-04-17 23:22:44',_binary ''),(188,'root@localhost','Delete','pedidos','Se ha eliminado un PEDIDO con el ID:  13','2024-04-17 23:22:44',_binary ''),(189,'root@localhost','Delete','pedidos','Se ha eliminado un PEDIDO con el ID:  14','2024-04-17 23:22:44',_binary ''),(190,'root@localhost','Delete','pedidos','Se ha eliminado un PEDIDO con el ID:  15','2024-04-17 23:22:44',_binary ''),(191,'root@localhost','Delete','pedidos','Se ha eliminado un PEDIDO con el ID:  16','2024-04-17 23:22:44',_binary ''),(192,'root@localhost','Delete','pedidos','Se ha eliminado un PEDIDO con el ID:  17','2024-04-17 23:22:44',_binary ''),(193,'root@localhost','Delete','pedidos','Se ha eliminado un PEDIDO con el ID:  18','2024-04-17 23:22:44',_binary ''),(194,'root@localhost','Delete','pedidos','Se ha eliminado un PEDIDO con el ID:  19','2024-04-17 23:22:44',_binary ''),(195,'root@localhost','Delete','pedidos','Se ha eliminado un PEDIDO con el ID:  20','2024-04-17 23:22:44',_binary ''),(196,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  1','2024-04-17 23:22:44',_binary ''),(197,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  2','2024-04-17 23:22:44',_binary ''),(198,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  3','2024-04-17 23:22:44',_binary ''),(199,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  4','2024-04-17 23:22:44',_binary ''),(200,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  5','2024-04-17 23:22:44',_binary ''),(201,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  6','2024-04-17 23:22:44',_binary ''),(202,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  7','2024-04-17 23:22:44',_binary ''),(203,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  8','2024-04-17 23:22:44',_binary ''),(204,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  9','2024-04-17 23:22:44',_binary ''),(205,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  10','2024-04-17 23:22:44',_binary ''),(206,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  11','2024-04-17 23:22:44',_binary ''),(207,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  12','2024-04-17 23:22:44',_binary ''),(208,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  13','2024-04-17 23:22:44',_binary ''),(209,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  14','2024-04-17 23:22:44',_binary ''),(210,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  15','2024-04-17 23:22:44',_binary ''),(211,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  16','2024-04-17 23:22:44',_binary ''),(212,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  17','2024-04-17 23:22:44',_binary ''),(213,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  18','2024-04-17 23:22:44',_binary ''),(214,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  19','2024-04-17 23:22:44',_binary ''),(215,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  20','2024-04-17 23:22:44',_binary ''),(216,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  21','2024-04-17 23:22:44',_binary ''),(217,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  22','2024-04-17 23:22:44',_binary ''),(218,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  23','2024-04-17 23:22:44',_binary ''),(219,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  24','2024-04-17 23:22:44',_binary ''),(220,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  25','2024-04-17 23:22:44',_binary ''),(221,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  26','2024-04-17 23:22:44',_binary ''),(222,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  27','2024-04-17 23:22:44',_binary ''),(223,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  28','2024-04-17 23:22:44',_binary ''),(224,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  29','2024-04-17 23:22:44',_binary ''),(225,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  30','2024-04-17 23:22:44',_binary ''),(226,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  31','2024-04-17 23:22:44',_binary ''),(227,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  32','2024-04-17 23:22:44',_binary ''),(228,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  33','2024-04-17 23:22:44',_binary ''),(229,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  34','2024-04-17 23:22:44',_binary ''),(230,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  35','2024-04-17 23:22:44',_binary ''),(231,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  36','2024-04-17 23:22:44',_binary ''),(232,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  37','2024-04-17 23:22:44',_binary ''),(233,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  38','2024-04-17 23:22:44',_binary ''),(234,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  39','2024-04-17 23:22:44',_binary ''),(235,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  40','2024-04-17 23:22:44',_binary ''),(236,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  11','2024-04-17 23:22:44',_binary ''),(237,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  12','2024-04-17 23:22:44',_binary ''),(238,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  13','2024-04-17 23:22:44',_binary ''),(239,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  14','2024-04-17 23:22:44',_binary ''),(240,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  15','2024-04-17 23:22:44',_binary ''),(241,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  16','2024-04-17 23:22:44',_binary ''),(242,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  17','2024-04-17 23:22:44',_binary ''),(243,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  18','2024-04-17 23:22:44',_binary ''),(244,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  19','2024-04-17 23:22:44',_binary ''),(245,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  20','2024-04-17 23:22:44',_binary ''),(246,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  21','2024-04-17 23:22:44',_binary ''),(247,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  22','2024-04-17 23:22:44',_binary ''),(248,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  23','2024-04-17 23:22:44',_binary ''),(249,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  24','2024-04-17 23:22:44',_binary ''),(250,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  25','2024-04-17 23:22:44',_binary ''),(251,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  26','2024-04-17 23:22:44',_binary ''),(252,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  27','2024-04-17 23:22:44',_binary ''),(253,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  28','2024-04-17 23:22:44',_binary ''),(254,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  29','2024-04-17 23:22:44',_binary ''),(255,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  30','2024-04-17 23:22:44',_binary ''),(256,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  31','2024-04-17 23:22:44',_binary ''),(257,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  32','2024-04-17 23:22:44',_binary ''),(258,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  33','2024-04-17 23:22:44',_binary ''),(259,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  34','2024-04-17 23:22:44',_binary ''),(260,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  35','2024-04-17 23:22:44',_binary ''),(261,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  36','2024-04-17 23:22:44',_binary ''),(262,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  37','2024-04-17 23:22:44',_binary ''),(263,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  38','2024-04-17 23:22:44',_binary ''),(264,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  39','2024-04-17 23:22:44',_binary ''),(265,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  40','2024-04-17 23:22:44',_binary ''),(266,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  1','2024-04-17 23:22:44',_binary ''),(267,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  2','2024-04-17 23:22:44',_binary ''),(268,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  3','2024-04-17 23:22:44',_binary ''),(269,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  4','2024-04-17 23:22:44',_binary ''),(270,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  5','2024-04-17 23:22:44',_binary ''),(271,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  6','2024-04-17 23:22:44',_binary ''),(272,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  7','2024-04-17 23:22:44',_binary ''),(273,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  8','2024-04-17 23:22:44',_binary ''),(274,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  9','2024-04-17 23:22:44',_binary ''),(275,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  10','2024-04-17 23:22:44',_binary ''),(276,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  11','2024-04-17 23:22:44',_binary ''),(277,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  12','2024-04-17 23:22:44',_binary ''),(278,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  13','2024-04-17 23:22:44',_binary ''),(279,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  14','2024-04-17 23:22:44',_binary ''),(280,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  15','2024-04-17 23:22:44',_binary ''),(281,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  16','2024-04-17 23:22:44',_binary ''),(282,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  17','2024-04-17 23:22:44',_binary ''),(283,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  18','2024-04-17 23:22:44',_binary ''),(284,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  19','2024-04-17 23:22:44',_binary ''),(285,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  20','2024-04-17 23:22:44',_binary ''),(286,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  21','2024-04-17 23:22:44',_binary ''),(287,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  22','2024-04-17 23:22:44',_binary ''),(288,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  23','2024-04-17 23:22:44',_binary ''),(289,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  24','2024-04-17 23:22:44',_binary ''),(290,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  25','2024-04-17 23:22:44',_binary ''),(291,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  26','2024-04-17 23:22:44',_binary ''),(292,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  27','2024-04-17 23:22:44',_binary ''),(293,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  28','2024-04-17 23:22:44',_binary ''),(294,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  29','2024-04-17 23:22:44',_binary ''),(295,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  30','2024-04-17 23:22:44',_binary ''),(296,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  31','2024-04-17 23:22:44',_binary ''),(297,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  32','2024-04-17 23:22:44',_binary ''),(298,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  33','2024-04-17 23:22:44',_binary ''),(299,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  34','2024-04-17 23:22:44',_binary ''),(300,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  35','2024-04-17 23:22:44',_binary ''),(301,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  36','2024-04-17 23:22:44',_binary ''),(302,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  37','2024-04-17 23:22:44',_binary ''),(303,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  38','2024-04-17 23:22:44',_binary ''),(304,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  39','2024-04-17 23:22:44',_binary ''),(305,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  40','2024-04-17 23:22:44',_binary ''),(306,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  1 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Jazmin PRIMER APELLIDO =  Ramos SEGUNDO APELLIDO =  Domínguez FECHA NACIMIENTO =  1975-11-16 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  AB- ESTATUS =   FECHA REGISTRO =  2022-12-23 10:53:26 FECHA ACTUALIZACIÓN = ','2024-04-17 23:22:53',_binary ''),(307,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  2 con los siguientes datos:  TITULO CORTESIA =  Srita NOMBRE= Esmeralda PRIMER APELLIDO =  Mendoza SEGUNDO APELLIDO =  Cortes FECHA NACIMIENTO =  1996-05-06 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  A- ESTATUS =   FECHA REGISTRO =  2022-07-23 13:31:06 FECHA ACTUALIZACIÓN = ','2024-04-17 23:22:53',_binary ''),(308,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  3 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Adalid PRIMER APELLIDO =  Torres SEGUNDO APELLIDO =  Romero FECHA NACIMIENTO =  1987-09-06 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  B+ ESTATUS =   FECHA REGISTRO =  2020-04-04 10:40:22 FECHA ACTUALIZACIÓN = ','2024-04-17 23:22:53',_binary ''),(309,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  4 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Suri PRIMER APELLIDO =  Santiago SEGUNDO APELLIDO =  Cortés FECHA NACIMIENTO =  1965-09-24 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  O+ ESTATUS =   FECHA REGISTRO =  2021-09-25 16:52:58 FECHA ACTUALIZACIÓN = ','2024-04-17 23:22:53',_binary ''),(310,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  5 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= José PRIMER APELLIDO =  Herrera SEGUNDO APELLIDO =  Torres FECHA NACIMIENTO =  1992-06-16 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  B+ ESTATUS =   FECHA REGISTRO =  2023-07-26 08:24:34 FECHA ACTUALIZACIÓN = ','2024-04-17 23:22:53',_binary ''),(311,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  6 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Jesus PRIMER APELLIDO =  Ruíz SEGUNDO APELLIDO =  Méndez FECHA NACIMIENTO =  1990-01-28 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  B- ESTATUS =   FECHA REGISTRO =  2022-01-01 19:03:37 FECHA ACTUALIZACIÓN = ','2024-04-17 23:22:53',_binary ''),(312,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  7 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Iram PRIMER APELLIDO =  García SEGUNDO APELLIDO =  Salazar FECHA NACIMIENTO =  1963-04-23 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  O- ESTATUS =   FECHA REGISTRO =  2021-03-01 15:44:23 FECHA ACTUALIZACIÓN = ','2024-04-17 23:22:53',_binary ''),(313,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  8 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Adalid PRIMER APELLIDO =  Méndez SEGUNDO APELLIDO =  Juárez FECHA NACIMIENTO =  1977-04-25 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  A+ ESTATUS =   FECHA REGISTRO =  2020-02-04 08:24:37 FECHA ACTUALIZACIÓN = ','2024-04-17 23:22:53',_binary ''),(314,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  9 con los siguientes datos:  TITULO CORTESIA =  C. NOMBRE= Jorge PRIMER APELLIDO =  Gutiérrez SEGUNDO APELLIDO =   Rivera FECHA NACIMIENTO =  2000-08-24 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  B- ESTATUS =   FECHA REGISTRO =  2022-11-17 08:21:49 FECHA ACTUALIZACIÓN = ','2024-04-17 23:22:53',_binary ''),(315,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  10 con los siguientes datos:  TITULO CORTESIA =  Lic. NOMBRE= Carmen PRIMER APELLIDO =  Ortega SEGUNDO APELLIDO =  Morales FECHA NACIMIENTO =  1993-09-16 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  AB- ESTATUS =   FECHA REGISTRO =  2022-05-18 14:51:13 FECHA ACTUALIZACIÓN = ','2024-04-17 23:22:53',_binary ''),(316,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  11 con los siguientes datos:  TITULO CORTESIA =  Tnte. NOMBRE= Federico PRIMER APELLIDO =  López SEGUNDO APELLIDO =  Velázquez FECHA NACIMIENTO =  1992-12-29 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  A+ ESTATUS =   FECHA REGISTRO =  2022-01-26 09:00:39 FECHA ACTUALIZACIÓN = ','2024-04-17 23:22:53',_binary ''),(317,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  11 con los siguientes datos:  NOMBRE USUARIO=  Tnte. Federico López Velázquez PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Banned ULTIMA CONEXIÓN =  2023-06-13 10:03:22','2024-04-17 23:22:53',_binary ''),(318,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  12 con los siguientes datos:  TITULO CORTESIA =  Lic. NOMBRE= Edgar PRIMER APELLIDO =  Morales SEGUNDO APELLIDO =  Pérez FECHA NACIMIENTO =  1998-06-22 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  AB- ESTATUS =   FECHA REGISTRO =  2024-02-18 17:30:58 FECHA ACTUALIZACIÓN = ','2024-04-17 23:22:53',_binary ''),(319,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  12 con los siguientes datos:  NOMBRE USUARIO=  Lic. Edgar Morales Pérez PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Banned ULTIMA CONEXIÓN =  2024-02-22 08:13:07','2024-04-17 23:22:53',_binary ''),(320,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  13 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Yair PRIMER APELLIDO =  Contreras SEGUNDO APELLIDO =   Rivera FECHA NACIMIENTO =  1984-10-28 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  O+ ESTATUS =   FECHA REGISTRO =  2022-08-04 14:11:44 FECHA ACTUALIZACIÓN = ','2024-04-17 23:22:53',_binary ''),(321,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  13 con los siguientes datos:  NOMBRE USUARIO=  Yair Contreras  Rivera PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Banned ULTIMA CONEXIÓN =  2023-11-27 11:43:26','2024-04-17 23:22:53',_binary ''),(322,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  14 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Adan PRIMER APELLIDO =  Bautista SEGUNDO APELLIDO =  Rodríguez FECHA NACIMIENTO =  1997-01-06 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  B- ESTATUS =   FECHA REGISTRO =  2020-05-26 08:18:55 FECHA ACTUALIZACIÓN = ','2024-04-17 23:22:53',_binary ''),(323,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  14 con los siguientes datos:  NOMBRE USUARIO=  Adan Bautista Rodríguez PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Banned ULTIMA CONEXIÓN =  2023-09-18 10:04:57','2024-04-17 23:22:53',_binary ''),(324,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  15 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Hugo PRIMER APELLIDO =   Rivera SEGUNDO APELLIDO =  Guerrero FECHA NACIMIENTO =  1998-10-12 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  B+ ESTATUS =   FECHA REGISTRO =  2024-01-02 18:12:41 FECHA ACTUALIZACIÓN = ','2024-04-17 23:22:53',_binary ''),(325,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  15 con los siguientes datos:  NOMBRE USUARIO=  Hugo  Rivera Guerrero PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Banned ULTIMA CONEXIÓN =  2024-02-20 16:51:56','2024-04-17 23:22:53',_binary ''),(326,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  16 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Samuel PRIMER APELLIDO =  Méndez SEGUNDO APELLIDO =  Estrada FECHA NACIMIENTO =  2007-03-16 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  A+ ESTATUS =   FECHA REGISTRO =  2022-10-27 19:09:34 FECHA ACTUALIZACIÓN = ','2024-04-17 23:22:53',_binary ''),(327,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  16 con los siguientes datos:  NOMBRE USUARIO=  Samuel Méndez Estrada PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Banned ULTIMA CONEXIÓN =  2023-10-28 15:17:12','2024-04-17 23:22:53',_binary ''),(328,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  17 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Federico PRIMER APELLIDO =  Vargas SEGUNDO APELLIDO =   González FECHA NACIMIENTO =  1974-10-05 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  B+ ESTATUS =   FECHA REGISTRO =  2021-12-03 12:48:57 FECHA ACTUALIZACIÓN = ','2024-04-17 23:22:53',_binary ''),(329,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  17 con los siguientes datos:  NOMBRE USUARIO=  Federico Vargas  González PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Banned ULTIMA CONEXIÓN =  2023-07-01 09:22:43','2024-04-17 23:22:53',_binary ''),(330,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  18 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Luz PRIMER APELLIDO =  Contreras SEGUNDO APELLIDO =  Velázquez FECHA NACIMIENTO =  1979-11-16 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  O+ ESTATUS =   FECHA REGISTRO =  2022-08-15 16:44:14 FECHA ACTUALIZACIÓN = ','2024-04-17 23:22:53',_binary ''),(331,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  18 con los siguientes datos:  NOMBRE USUARIO=  Luz Contreras Velázquez PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Banned ULTIMA CONEXIÓN =  2023-12-23 18:24:48','2024-04-17 23:22:53',_binary ''),(332,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  19 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Valeria PRIMER APELLIDO =  Bautista SEGUNDO APELLIDO =  Estrada FECHA NACIMIENTO =  1995-04-17 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  O- ESTATUS =   FECHA REGISTRO =  2021-07-20 08:46:47 FECHA ACTUALIZACIÓN = ','2024-04-17 23:22:53',_binary ''),(333,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  19 con los siguientes datos:  NOMBRE USUARIO=  Valeria Bautista Estrada PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Banned ULTIMA CONEXIÓN =  2022-03-20 08:13:21','2024-04-17 23:22:53',_binary ''),(334,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  20 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Brenda PRIMER APELLIDO =  Aguilar SEGUNDO APELLIDO =  Ortega FECHA NACIMIENTO =  1962-10-20 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  O+ ESTATUS =   FECHA REGISTRO =  2022-06-30 15:32:19 FECHA ACTUALIZACIÓN = ','2024-04-17 23:22:53',_binary ''),(335,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  20 con los siguientes datos:  NOMBRE USUARIO=  Brenda Aguilar Ortega PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Banned ULTIMA CONEXIÓN =  2023-03-18 09:14:21','2024-04-17 23:22:53',_binary ''),(336,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  1 con los siguientes datos:  NOMBRE =  Banda de resistencia para estiramientos MARCA =  PowerPulse PRECIO ACTUAL =  60.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:22:53',_binary ''),(337,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  2 con los siguientes datos:  NOMBRE =  Vendas para muñecas y tobillos MARCA =  PowerSprint PRECIO ACTUAL =  80.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:22:53',_binary ''),(338,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  3 con los siguientes datos:  NOMBRE =  Guantes para levantamiento de pesas MARCA =  FlexiLoop PRECIO ACTUAL =  70.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:22:53',_binary ''),(339,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  4 con los siguientes datos:  NOMBRE =  Correa de estiramiento MARCA =  FlexiGel PRECIO ACTUAL =  70.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:22:53',_binary ''),(340,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  5 con los siguientes datos:  NOMBRE =  Bebida energética post-entrenamiento MARCA =  FlexiLoop PRECIO ACTUAL =  40.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:22:53',_binary ''),(341,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  6 con los siguientes datos:  NOMBRE =  Guantes para levantamiento de pesas MARCA =  FlexiBall PRECIO ACTUAL =  60.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:22:53',_binary ''),(342,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  7 con los siguientes datos:  NOMBRE =  Vendas para muñecas y tobillos MARCA =  SpeedSpike PRECIO ACTUAL =  20.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:22:53',_binary ''),(343,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  8 con los siguientes datos:  NOMBRE =  Esterilla de yoga MARCA =  PowerBar PRECIO ACTUAL =  40.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:22:53',_binary ''),(344,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  9 con los siguientes datos:  NOMBRE =  Suplemento de creatina MARCA =  FlexiGel PRECIO ACTUAL =  80.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:22:53',_binary ''),(345,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  10 con los siguientes datos:  NOMBRE =  Esterilla de yoga MARCA =  FlexiPad PRECIO ACTUAL =  40.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:22:53',_binary ''),(346,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  11 con los siguientes datos:  NOMBRE =  Bebida isotónica MARCA =  FlexiStretch PRECIO ACTUAL =  30.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:22:53',_binary ''),(347,'root@localhost','Create','detalles_productos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  11 con los siguientes datos:  PRODUCTO ID =  Bebida isotónica FlexiStretch DESCRIPCION =  Equipos de soporte diseñados para proteger la espalda y mejorar la estabilidad durante los levantamientos de peso pesado, como sentadillas y peso muerto. CODIGO DE BARRAS =  385987635 PRESENTACION =   Optimum Nutrition Creatine Monohydrate ESTATUS =  Activa','2024-04-17 23:22:53',_binary ''),(348,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  12 con los siguientes datos:  NOMBRE =  Termogénico para quemar grasa MARCA =  PowerHydrate PRECIO ACTUAL =  100.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:22:53',_binary ''),(349,'root@localhost','Create','detalles_productos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  12 con los siguientes datos:  PRODUCTO ID =  Termogénico para quemar grasa PowerHydrate DESCRIPCION =  Fórmula diseñada para aumentar la energía, mejorar el enfoque mental y la resistencia durante el entrenamiento, generalmente contiene ingredientes como cafeína, beta-alanina y creatina. CODIGO DE BARRAS =  190532901 PRESENTACION =  Quest Nutrition Protein Bar ESTATUS =  Activa','2024-04-17 23:22:53',_binary ''),(350,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  13 con los siguientes datos:  NOMBRE =  Colchoneta para ejercicios MARCA =  PowerSprint PRECIO ACTUAL =  30.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:22:53',_binary ''),(351,'root@localhost','Create','detalles_productos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  13 con los siguientes datos:  PRODUCTO ID =  Colchoneta para ejercicios PowerSprint DESCRIPCION =  Suplementos que contienen una variedad de vitaminas y minerales esenciales para apoyar la salud general, el metabolismo y la función muscular durante el ejercicio intenso. CODIGO DE BARRAS =  190532901 PRESENTACION =  C4 Original Pre-Workout) ESTATUS =  Activa','2024-04-17 23:22:53',_binary ''),(352,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  14 con los siguientes datos:  NOMBRE =  Termogénico para quemar grasa MARCA =  SpeedSpike PRECIO ACTUAL =  90.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:22:53',_binary ''),(353,'root@localhost','Create','detalles_productos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  14 con los siguientes datos:  PRODUCTO ID =  Termogénico para quemar grasa SpeedSpike DESCRIPCION =  Suplemento nutricional utilizado para aumentar la ingesta de proteínas, promover la recuperación muscular y el crecimiento después del entrenamiento. CODIGO DE BARRAS =  450578976 PRESENTACION =   Optimum Nutrition Creatine Monohydrate ESTATUS =  Activa','2024-04-17 23:22:53',_binary ''),(354,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  15 con los siguientes datos:  NOMBRE =  Banda de resistencia para estiramientos MARCA =  FlexiLoop PRECIO ACTUAL =  100.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:22:53',_binary ''),(355,'root@localhost','Create','detalles_productos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  15 con los siguientes datos:  PRODUCTO ID =  Banda de resistencia para estiramientos FlexiLoop DESCRIPCION =  Suplemento nutricional utilizado para aumentar la ingesta de proteínas, promover la recuperación muscular y el crecimiento después del entrenamiento. CODIGO DE BARRAS =  450578976 PRESENTACION =  Quest Nutrition Protein Bar ESTATUS =  Activa','2024-04-17 23:22:53',_binary ''),(356,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  16 con los siguientes datos:  NOMBRE =  Bebida isotónica MARCA =  StaminaBoost PRECIO ACTUAL =  10.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:22:53',_binary ''),(357,'root@localhost','Create','detalles_productos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  16 con los siguientes datos:  PRODUCTO ID =  Bebida isotónica StaminaBoost DESCRIPCION =  Accesorios que protegen las manos de callosidades y proporcionan un mejor agarre durante el levantamiento de pesas y otros ejercicios de fuerza. CODIGO DE BARRAS =  105389073 PRESENTACION =  C4 Original Pre-Workout) ESTATUS =  Activa','2024-04-17 23:22:53',_binary ''),(358,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  17 con los siguientes datos:  NOMBRE =  Vendas para muñecas y tobillos MARCA =  MuscleRecover PRECIO ACTUAL =  100.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:22:53',_binary ''),(359,'root@localhost','Create','detalles_productos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  17 con los siguientes datos:  PRODUCTO ID =  Vendas para muñecas y tobillos MuscleRecover DESCRIPCION =  Accesorios que protegen las manos de callosidades y proporcionan un mejor agarre durante el levantamiento de pesas y otros ejercicios de fuerza. CODIGO DE BARRAS =  385987635 PRESENTACION =  Nordic Naturals Ultimate Omega ESTATUS =  Activa','2024-04-17 23:22:53',_binary ''),(360,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  18 con los siguientes datos:  NOMBRE =  Guantes para levantamiento de pesas MARCA =  PowerLift PRECIO ACTUAL =  100.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:22:53',_binary ''),(361,'root@localhost','Create','detalles_productos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  18 con los siguientes datos:  PRODUCTO ID =  Guantes para levantamiento de pesas PowerLift DESCRIPCION =  Fórmula diseñada para aumentar la energía, mejorar el enfoque mental y la resistencia durante el entrenamiento, generalmente contiene ingredientes como cafeína, beta-alanina y creatina. CODIGO DE BARRAS =  190532901 PRESENTACION =  Quest Nutrition Protein Bar ESTATUS =  Activa','2024-04-17 23:22:53',_binary ''),(362,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  19 con los siguientes datos:  NOMBRE =  Barritas energéticas MARCA =  PowerCord PRECIO ACTUAL =  40.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:22:53',_binary ''),(363,'root@localhost','Create','detalles_productos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  19 con los siguientes datos:  PRODUCTO ID =  Barritas energéticas PowerCord DESCRIPCION =  Accesorios que protegen las manos de callosidades y proporcionan un mejor agarre durante el levantamiento de pesas y otros ejercicios de fuerza. CODIGO DE BARRAS =  450578976 PRESENTACION =  Quest Nutrition Protein Bar ESTATUS =  Activa','2024-04-17 23:22:53',_binary ''),(364,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  20 con los siguientes datos:  NOMBRE =  Bebida energética pre-entrenamiento MARCA =  PowerBlitz PRECIO ACTUAL =  30.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:22:53',_binary ''),(365,'root@localhost','Create','detalles_productos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  20 con los siguientes datos:  PRODUCTO ID =  Bebida energética pre-entrenamiento PowerBlitz DESCRIPCION =  Suplemento nutricional utilizado para aumentar la ingesta de proteínas, promover la recuperación muscular y el crecimiento después del entrenamiento. CODIGO DE BARRAS =  450578976 PRESENTACION =  C4 Original Pre-Workout) ESTATUS =  Activa','2024-04-17 23:22:53',_binary ''),(366,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  21 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Carlos PRIMER APELLIDO =  Contreras SEGUNDO APELLIDO =   Rivera FECHA NACIMIENTO =  1985-04-25 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  O+ ESTATUS =   FECHA REGISTRO =  2023-04-09 10:19:59 FECHA ACTUALIZACIÓN = ','2024-04-17 23:22:53',_binary ''),(367,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  21 con los siguientes datos:  NOMBRE USUARIO=  Carlos Contreras  Rivera PASSWORD =  TIPO =  Miembro ESTATUS CONEXIÓN =  Banned ULTIMA CONEXIÓN =  2023-06-28 14:06:16','2024-04-17 23:22:53',_binary ''),(368,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  21 con los siguientes datos:  NOMBRE =  Bloque de espuma para estiramientos MARCA =  PowerStim PRECIO ACTUAL =  20.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:22:53',_binary ''),(369,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  1 con los siguientes datos:  USUARIO ID =  Carlos Contreras  Rivera PRODUCTO ID =  Bloque de espuma para estiramientos PowerStim 20.00 TOTAL =  80.00 FECHA REGISTRO =  2021-05-28 12:56:23 ESTATUS =  Activa','2024-04-17 23:22:53',_binary ''),(370,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  22 con los siguientes datos:  TITULO CORTESIA =  Med. NOMBRE= Pedro PRIMER APELLIDO =  Bautista SEGUNDO APELLIDO =  Ortiz FECHA NACIMIENTO =  1978-04-25 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  AB+ ESTATUS =   FECHA REGISTRO =  2023-10-01 14:29:24 FECHA ACTUALIZACIÓN = ','2024-04-17 23:22:53',_binary ''),(371,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  22 con los siguientes datos:  NOMBRE USUARIO=  Med. Pedro Bautista Ortiz PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Banned ULTIMA CONEXIÓN =  2024-03-06 14:03:17','2024-04-17 23:22:53',_binary ''),(372,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  22 con los siguientes datos:  NOMBRE =  Suplemento de creatina MARCA =  PowerPulse PRECIO ACTUAL =  10.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:22:53',_binary ''),(373,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  2 con los siguientes datos:  USUARIO ID =  Med. Pedro Bautista Ortiz PRODUCTO ID =  Suplemento de creatina PowerPulse 10.00 TOTAL =  30.00 FECHA REGISTRO =  2020-10-28 10:11:54 ESTATUS =  Activa','2024-04-17 23:22:53',_binary ''),(374,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  23 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Edgar PRIMER APELLIDO =  Pérez SEGUNDO APELLIDO =  Mendoza FECHA NACIMIENTO =  1995-05-23 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  B- ESTATUS =   FECHA REGISTRO =  2020-02-15 17:36:12 FECHA ACTUALIZACIÓN = ','2024-04-17 23:22:53',_binary ''),(375,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  23 con los siguientes datos:  NOMBRE USUARIO=  Edgar Pérez Mendoza PASSWORD =  TIPO =  Instructor ESTATUS CONEXIÓN =  Online ULTIMA CONEXIÓN =  2020-09-06 09:42:00','2024-04-17 23:22:53',_binary ''),(376,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  23 con los siguientes datos:  NOMBRE =  Banda de resistencia para estiramientos MARCA =  PowerFuel PRECIO ACTUAL =  70.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:22:53',_binary ''),(377,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  3 con los siguientes datos:  USUARIO ID =  Edgar Pérez Mendoza PRODUCTO ID =  Banda de resistencia para estiramientos PowerFuel 70.00 TOTAL =  80.00 FECHA REGISTRO =  2020-01-19 16:50:13 ESTATUS =  Activa','2024-04-17 23:22:53',_binary ''),(378,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  24 con los siguientes datos:  TITULO CORTESIA =  NOMBRE=  Agustin PRIMER APELLIDO =  Luna SEGUNDO APELLIDO =  Vargas FECHA NACIMIENTO =  1962-11-23 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  A- ESTATUS =   FECHA REGISTRO =  2022-11-24 18:01:29 FECHA ACTUALIZACIÓN = ','2024-04-17 23:22:53',_binary ''),(379,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  24 con los siguientes datos:  NOMBRE USUARIO=   Agustin Luna Vargas PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Online ULTIMA CONEXIÓN =  2024-01-31 13:25:40','2024-04-17 23:22:53',_binary ''),(380,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  24 con los siguientes datos:  NOMBRE =  Banda elástica para ejercicios de resistencia MARCA =  MuscleRelief PRECIO ACTUAL =  10.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:22:53',_binary ''),(381,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  4 con los siguientes datos:  USUARIO ID =   Agustin Luna Vargas PRODUCTO ID =  Banda elástica para ejercicios de resistencia MuscleRelief 10.00 TOTAL =  50.00 FECHA REGISTRO =  2021-02-20 18:45:41 ESTATUS =  Activa','2024-04-17 23:22:53',_binary ''),(382,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  25 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Paola PRIMER APELLIDO =  Cortes SEGUNDO APELLIDO =  Cortés FECHA NACIMIENTO =  1971-09-06 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  B+ ESTATUS =   FECHA REGISTRO =  2023-11-14 14:05:52 FECHA ACTUALIZACIÓN = ','2024-04-17 23:22:53',_binary ''),(383,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  25 con los siguientes datos:  NOMBRE USUARIO=  Paola Cortes Cortés PASSWORD =  TIPO =  Instructor ESTATUS CONEXIÓN =  Banned ULTIMA CONEXIÓN =  2024-03-21 09:30:32','2024-04-17 23:22:53',_binary ''),(384,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  25 con los siguientes datos:  NOMBRE =  Suplemento de creatina MARCA =  FlexiMat PRECIO ACTUAL =  50.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:22:53',_binary ''),(385,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  5 con los siguientes datos:  USUARIO ID =  Paola Cortes Cortés PRODUCTO ID =  Suplemento de creatina FlexiMat 50.00 TOTAL =  100.00 FECHA REGISTRO =  2022-08-22 09:48:36 ESTATUS =  Activa','2024-04-17 23:22:53',_binary ''),(386,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  26 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Jorge PRIMER APELLIDO =  Ortiz SEGUNDO APELLIDO =  Soto FECHA NACIMIENTO =  1989-08-06 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  A+ ESTATUS =   FECHA REGISTRO =  2023-03-01 11:56:08 FECHA ACTUALIZACIÓN = ','2024-04-17 23:22:53',_binary ''),(387,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  26 con los siguientes datos:  NOMBRE USUARIO=  Jorge Ortiz Soto PASSWORD =  TIPO =  Visitante ESTATUS CONEXIÓN =  Online ULTIMA CONEXIÓN =  2023-10-10 10:27:31','2024-04-17 23:22:53',_binary ''),(388,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  26 con los siguientes datos:  NOMBRE =  Banda de resistencia para entrenamiento MARCA =  PowerCharge PRECIO ACTUAL =  80.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:22:53',_binary ''),(389,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  6 con los siguientes datos:  USUARIO ID =  Jorge Ortiz Soto PRODUCTO ID =  Banda de resistencia para entrenamiento PowerCharge 80.00 TOTAL =  80.00 FECHA REGISTRO =  2020-11-30 19:11:24 ESTATUS =  Activa','2024-04-17 23:22:53',_binary ''),(390,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  27 con los siguientes datos:  TITULO CORTESIA =  Med. NOMBRE= José PRIMER APELLIDO =  Domínguez SEGUNDO APELLIDO =  Torres FECHA NACIMIENTO =  1993-01-17 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  B- ESTATUS =   FECHA REGISTRO =  2021-01-01 17:28:01 FECHA ACTUALIZACIÓN = ','2024-04-17 23:22:53',_binary ''),(391,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  27 con los siguientes datos:  NOMBRE USUARIO=  Med. José Domínguez Torres PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Banned ULTIMA CONEXIÓN =  2022-09-12 08:20:32','2024-04-17 23:22:53',_binary ''),(392,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  27 con los siguientes datos:  NOMBRE =  Rodillo de espuma para masaje muscular MARCA =  PowerSprint PRECIO ACTUAL =  80.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:22:53',_binary ''),(393,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  7 con los siguientes datos:  USUARIO ID =  Med. José Domínguez Torres PRODUCTO ID =  Rodillo de espuma para masaje muscular PowerSprint 80.00 TOTAL =  90.00 FECHA REGISTRO =  2021-02-05 15:37:12 ESTATUS =  Activa','2024-04-17 23:22:53',_binary ''),(394,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  28 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Mario PRIMER APELLIDO =  Guzmán SEGUNDO APELLIDO =  Aguilar FECHA NACIMIENTO =  2004-07-09 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  B+ ESTATUS =   FECHA REGISTRO =  2023-09-17 12:04:18 FECHA ACTUALIZACIÓN = ','2024-04-17 23:22:53',_binary ''),(395,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  28 con los siguientes datos:  NOMBRE USUARIO=  Mario Guzmán Aguilar PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Offline ULTIMA CONEXIÓN =  2023-11-04 15:15:29','2024-04-17 23:22:53',_binary ''),(396,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  28 con los siguientes datos:  NOMBRE =  Banda de resistencia para estiramientos MARCA =  PowerSprint PRECIO ACTUAL =  60.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:22:53',_binary ''),(397,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  8 con los siguientes datos:  USUARIO ID =  Mario Guzmán Aguilar PRODUCTO ID =  Banda de resistencia para estiramientos PowerSprint 60.00 TOTAL =  100.00 FECHA REGISTRO =  2021-01-17 11:29:21 ESTATUS =  Activa','2024-04-17 23:22:53',_binary ''),(398,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  29 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Hortencia PRIMER APELLIDO =  Moreno SEGUNDO APELLIDO =  Vargas FECHA NACIMIENTO =  1972-12-28 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  A- ESTATUS =   FECHA REGISTRO =  2020-04-22 17:45:41 FECHA ACTUALIZACIÓN = ','2024-04-17 23:22:53',_binary ''),(399,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  29 con los siguientes datos:  NOMBRE USUARIO=  Hortencia Moreno Vargas PASSWORD =  TIPO =  Instructor ESTATUS CONEXIÓN =  Banned ULTIMA CONEXIÓN =  2022-05-30 10:14:53','2024-04-17 23:22:53',_binary ''),(400,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  29 con los siguientes datos:  NOMBRE =  Esterilla de yoga MARCA =  FlexiStrap PRECIO ACTUAL =  10.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:22:53',_binary ''),(401,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  9 con los siguientes datos:  USUARIO ID =  Hortencia Moreno Vargas PRODUCTO ID =  Esterilla de yoga FlexiStrap 10.00 TOTAL =  40.00 FECHA REGISTRO =  2023-07-30 08:43:37 ESTATUS =  Activa','2024-04-17 23:22:53',_binary ''),(402,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  30 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Lucía PRIMER APELLIDO =  Castillo SEGUNDO APELLIDO =  López FECHA NACIMIENTO =  2003-01-06 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  A- ESTATUS =   FECHA REGISTRO =  2021-12-16 15:12:44 FECHA ACTUALIZACIÓN = ','2024-04-17 23:22:53',_binary ''),(403,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  30 con los siguientes datos:  NOMBRE USUARIO=  Lucía Castillo López PASSWORD =  TIPO =  Miembro ESTATUS CONEXIÓN =  Offline ULTIMA CONEXIÓN =  2024-04-11 17:50:45','2024-04-17 23:22:53',_binary ''),(404,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  30 con los siguientes datos:  NOMBRE =  Bebida energética pre-entrenamiento MARCA =  FlexiLoop PRECIO ACTUAL =  50.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:22:53',_binary ''),(405,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  10 con los siguientes datos:  USUARIO ID =  Lucía Castillo López PRODUCTO ID =  Bebida energética pre-entrenamiento FlexiLoop 50.00 TOTAL =  80.00 FECHA REGISTRO =  2021-08-26 16:13:31 ESTATUS =  Activa','2024-04-17 23:22:53',_binary ''),(406,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  31 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Jorge PRIMER APELLIDO =  Velázquez SEGUNDO APELLIDO =  Juárez FECHA NACIMIENTO =  1996-05-03 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  O- ESTATUS =   FECHA REGISTRO =  2021-12-27 13:43:12 FECHA ACTUALIZACIÓN = ','2024-04-17 23:22:53',_binary ''),(407,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  31 con los siguientes datos:  NOMBRE USUARIO=  Jorge Velázquez Juárez PASSWORD =  TIPO =  Instructor ESTATUS CONEXIÓN =  Offline ULTIMA CONEXIÓN =  2023-08-28 19:55:22','2024-04-17 23:22:53',_binary ''),(408,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  31 con los siguientes datos:  NOMBRE =  Colchoneta para ejercicios MARCA =  PowerProtein PRECIO ACTUAL =  70.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:22:53',_binary ''),(409,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  11 con los siguientes datos:  USUARIO ID =  Jorge Velázquez Juárez PRODUCTO ID =  Colchoneta para ejercicios PowerProtein 70.00 TOTAL =  20.00 FECHA REGISTRO =  2020-01-03 13:27:05 ESTATUS =  Activa','2024-04-17 23:22:53',_binary ''),(410,'root@localhost','Create','detalles_pedidos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  1 con los siguientes datos:  PEDIDO ID =  31 20.00 2020-01-03 13:27:05 PRODUCTO ID =  Banda de resistencia para estiramientos PowerPulse CANTIDAD =  380 TOTAL PARCIAL =  100.00 FECHA REGISTRO =  2020-02-25 11:19:25 FECHA ENTREGA =  2024-04-17 23:22:53 ESTATUS =  Activa','2024-04-17 23:22:53',_binary ''),(411,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  32 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Esmeralda PRIMER APELLIDO =  Cortes SEGUNDO APELLIDO =   González FECHA NACIMIENTO =  1999-05-29 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  O+ ESTATUS =   FECHA REGISTRO =  2023-01-24 08:46:46 FECHA ACTUALIZACIÓN = ','2024-04-17 23:22:53',_binary ''),(412,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  32 con los siguientes datos:  NOMBRE USUARIO=  Esmeralda Cortes  González PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Banned ULTIMA CONEXIÓN =  2023-03-07 11:23:02','2024-04-17 23:22:53',_binary ''),(413,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  32 con los siguientes datos:  NOMBRE =  Bebida energética pre-entrenamiento MARCA =  PowerBeam PRECIO ACTUAL =  60.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:22:53',_binary ''),(414,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  12 con los siguientes datos:  USUARIO ID =  Esmeralda Cortes  González PRODUCTO ID =  Bebida energética pre-entrenamiento PowerBeam 60.00 TOTAL =  50.00 FECHA REGISTRO =  2022-09-08 16:47:07 ESTATUS =  Activa','2024-04-17 23:22:53',_binary ''),(415,'root@localhost','Create','detalles_pedidos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  2 con los siguientes datos:  PEDIDO ID =  32 50.00 2022-09-08 16:47:07 PRODUCTO ID =  Banda de resistencia para estiramientos PowerPulse CANTIDAD =  500 TOTAL PARCIAL =  80.00 FECHA REGISTRO =  2021-02-19 09:51:39 FECHA ENTREGA =  2024-04-17 23:22:53 ESTATUS =  Activa','2024-04-17 23:22:53',_binary ''),(416,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  33 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Gustavo PRIMER APELLIDO =  Santiago SEGUNDO APELLIDO =  Guzmán FECHA NACIMIENTO =  1962-09-21 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  A+ ESTATUS =   FECHA REGISTRO =  2021-03-14 09:15:05 FECHA ACTUALIZACIÓN = ','2024-04-17 23:22:53',_binary ''),(417,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  33 con los siguientes datos:  NOMBRE USUARIO=  Gustavo Santiago Guzmán PASSWORD =  TIPO =  Miembro ESTATUS CONEXIÓN =  Online ULTIMA CONEXIÓN =  2022-08-07 19:33:18','2024-04-17 23:22:53',_binary ''),(418,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  33 con los siguientes datos:  NOMBRE =  Bebida isotónica MARCA =  PowerCharge PRECIO ACTUAL =  70.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:22:53',_binary ''),(419,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  13 con los siguientes datos:  USUARIO ID =  Gustavo Santiago Guzmán PRODUCTO ID =  Bebida isotónica PowerCharge 70.00 TOTAL =  90.00 FECHA REGISTRO =  2021-07-21 11:40:03 ESTATUS =  Activa','2024-04-17 23:22:53',_binary ''),(420,'root@localhost','Create','detalles_pedidos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  3 con los siguientes datos:  PEDIDO ID =  33 90.00 2021-07-21 11:40:03 PRODUCTO ID =  Banda de resistencia para estiramientos PowerPulse CANTIDAD =  450 TOTAL PARCIAL =  30.00 FECHA REGISTRO =  2020-08-19 18:13:55 FECHA ENTREGA =  2024-04-17 23:22:53 ESTATUS =  Activa','2024-04-17 23:22:53',_binary ''),(421,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  34 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Ana PRIMER APELLIDO =  Castro SEGUNDO APELLIDO =  Guzmán FECHA NACIMIENTO =  1990-09-14 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  O- ESTATUS =   FECHA REGISTRO =  2023-03-30 19:37:09 FECHA ACTUALIZACIÓN = ','2024-04-17 23:22:53',_binary ''),(422,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  34 con los siguientes datos:  NOMBRE USUARIO=  Ana Castro Guzmán PASSWORD =  TIPO =  Miembro ESTATUS CONEXIÓN =  Banned ULTIMA CONEXIÓN =  2023-05-28 18:06:04','2024-04-17 23:22:53',_binary ''),(423,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  34 con los siguientes datos:  NOMBRE =  Banda elástica para ejercicios de resistencia MARCA =  FlexiStrap PRECIO ACTUAL =  80.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:22:53',_binary ''),(424,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  14 con los siguientes datos:  USUARIO ID =  Ana Castro Guzmán PRODUCTO ID =  Banda elástica para ejercicios de resistencia FlexiStrap 80.00 TOTAL =  30.00 FECHA REGISTRO =  2020-08-05 17:38:22 ESTATUS =  Activa','2024-04-17 23:22:53',_binary ''),(425,'root@localhost','Create','detalles_pedidos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  4 con los siguientes datos:  PEDIDO ID =  34 30.00 2020-08-05 17:38:22 PRODUCTO ID =  Banda de resistencia para estiramientos PowerPulse CANTIDAD =  500 TOTAL PARCIAL =  60.00 FECHA REGISTRO =  2020-09-08 08:17:13 FECHA ENTREGA =  2024-04-17 23:22:53 ESTATUS =  Activa','2024-04-17 23:22:53',_binary ''),(426,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  35 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Edgar PRIMER APELLIDO =  Sánchez SEGUNDO APELLIDO =   Rivera FECHA NACIMIENTO =  1986-05-19 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  O- ESTATUS =   FECHA REGISTRO =  2021-01-09 11:03:42 FECHA ACTUALIZACIÓN = ','2024-04-17 23:22:53',_binary ''),(427,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  35 con los siguientes datos:  NOMBRE USUARIO=  Edgar Sánchez  Rivera PASSWORD =  TIPO =  Miembro ESTATUS CONEXIÓN =  Online ULTIMA CONEXIÓN =  2022-08-14 12:03:17','2024-04-17 23:22:53',_binary ''),(428,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  35 con los siguientes datos:  NOMBRE =  Barritas energéticas MARCA =  PowerFuel PRECIO ACTUAL =  100.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:22:53',_binary ''),(429,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  15 con los siguientes datos:  USUARIO ID =  Edgar Sánchez  Rivera PRODUCTO ID =  Barritas energéticas PowerFuel 100.00 TOTAL =  30.00 FECHA REGISTRO =  2021-10-23 12:48:19 ESTATUS =  Activa','2024-04-17 23:22:53',_binary ''),(430,'root@localhost','Create','detalles_pedidos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  5 con los siguientes datos:  PEDIDO ID =  35 30.00 2021-10-23 12:48:19 PRODUCTO ID =  Banda de resistencia para estiramientos PowerPulse CANTIDAD =  500 TOTAL PARCIAL =  50.00 FECHA REGISTRO =  2020-12-14 15:47:43 FECHA ENTREGA =  2024-04-17 23:22:53 ESTATUS =  Activa','2024-04-17 23:22:53',_binary ''),(431,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  36 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Maria PRIMER APELLIDO =  Ruíz SEGUNDO APELLIDO =  Guzmán FECHA NACIMIENTO =  1990-10-31 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  O- ESTATUS =   FECHA REGISTRO =  2023-05-10 08:56:31 FECHA ACTUALIZACIÓN = ','2024-04-17 23:22:53',_binary ''),(432,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  36 con los siguientes datos:  NOMBRE USUARIO=  Maria Ruíz Guzmán PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Online ULTIMA CONEXIÓN =  2024-03-15 13:49:57','2024-04-17 23:22:53',_binary ''),(433,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  36 con los siguientes datos:  NOMBRE =  Banda elástica para ejercicios de resistencia MARCA =  FlexiRoll PRECIO ACTUAL =  60.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:22:53',_binary ''),(434,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  16 con los siguientes datos:  USUARIO ID =  Maria Ruíz Guzmán PRODUCTO ID =  Banda elástica para ejercicios de resistencia FlexiRoll 60.00 TOTAL =  40.00 FECHA REGISTRO =  2020-06-05 13:13:50 ESTATUS =  Activa','2024-04-17 23:22:53',_binary ''),(435,'root@localhost','Create','detalles_pedidos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  6 con los siguientes datos:  PEDIDO ID =  36 40.00 2020-06-05 13:13:50 PRODUCTO ID =  Banda de resistencia para estiramientos PowerPulse CANTIDAD =  60 TOTAL PARCIAL =  10.00 FECHA REGISTRO =  2023-07-31 18:34:06 FECHA ENTREGA =  2024-04-17 23:22:53 ESTATUS =  Activa','2024-04-17 23:22:53',_binary ''),(436,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  37 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Paola PRIMER APELLIDO =  Velázquez SEGUNDO APELLIDO =  Salazar FECHA NACIMIENTO =  2000-11-27 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  AB- ESTATUS =   FECHA REGISTRO =  2020-08-13 14:02:22 FECHA ACTUALIZACIÓN = ','2024-04-17 23:22:53',_binary ''),(437,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  37 con los siguientes datos:  NOMBRE USUARIO=  Paola Velázquez Salazar PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Banned ULTIMA CONEXIÓN =  2021-11-05 19:00:32','2024-04-17 23:22:53',_binary ''),(438,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  37 con los siguientes datos:  NOMBRE =  Rodillo de espuma para masaje muscular MARCA =  FlexiLoop PRECIO ACTUAL =  10.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:22:53',_binary ''),(439,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  17 con los siguientes datos:  USUARIO ID =  Paola Velázquez Salazar PRODUCTO ID =  Rodillo de espuma para masaje muscular FlexiLoop 10.00 TOTAL =  100.00 FECHA REGISTRO =  2021-04-12 17:10:50 ESTATUS =  Activa','2024-04-17 23:22:53',_binary ''),(440,'root@localhost','Create','detalles_pedidos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  7 con los siguientes datos:  PEDIDO ID =  37 100.00 2021-04-12 17:10:50 PRODUCTO ID =  Banda de resistencia para estiramientos PowerPulse CANTIDAD =  60 TOTAL PARCIAL =  40.00 FECHA REGISTRO =  2024-04-15 19:00:39 FECHA ENTREGA =  2024-04-17 23:22:53 ESTATUS =  Activa','2024-04-17 23:22:54',_binary ''),(441,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  38 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Gustavo PRIMER APELLIDO =  Velázquez SEGUNDO APELLIDO =  Cortés FECHA NACIMIENTO =  1986-12-25 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  O- ESTATUS =   FECHA REGISTRO =  2023-10-16 15:59:51 FECHA ACTUALIZACIÓN = ','2024-04-17 23:22:54',_binary ''),(442,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  38 con los siguientes datos:  NOMBRE USUARIO=  Gustavo Velázquez Cortés PASSWORD =  TIPO =  Miembro ESTATUS CONEXIÓN =  Offline ULTIMA CONEXIÓN =  2023-10-27 08:26:11','2024-04-17 23:22:54',_binary ''),(443,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  38 con los siguientes datos:  NOMBRE =  Cinturón de levantamiento de pesas MARCA =  SpeedMate PRECIO ACTUAL =  50.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:22:54',_binary ''),(444,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  18 con los siguientes datos:  USUARIO ID =  Gustavo Velázquez Cortés PRODUCTO ID =  Cinturón de levantamiento de pesas SpeedMate 50.00 TOTAL =  50.00 FECHA REGISTRO =  2020-09-13 12:10:25 ESTATUS =  Activa','2024-04-17 23:22:54',_binary ''),(445,'root@localhost','Create','detalles_pedidos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  8 con los siguientes datos:  PEDIDO ID =  38 50.00 2020-09-13 12:10:25 PRODUCTO ID =  Banda de resistencia para estiramientos PowerPulse CANTIDAD =  380 TOTAL PARCIAL =  20.00 FECHA REGISTRO =  2021-01-08 15:12:14 FECHA ENTREGA =  2024-04-17 23:22:53 ESTATUS =  Activa','2024-04-17 23:22:54',_binary ''),(446,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  39 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Carmen PRIMER APELLIDO =  Guzmán SEGUNDO APELLIDO =  Vargas FECHA NACIMIENTO =  1979-11-11 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  O- ESTATUS =   FECHA REGISTRO =  2021-02-14 15:09:04 FECHA ACTUALIZACIÓN = ','2024-04-17 23:22:54',_binary ''),(447,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  39 con los siguientes datos:  NOMBRE USUARIO=  Carmen Guzmán Vargas PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Online ULTIMA CONEXIÓN =  2022-03-15 09:44:54','2024-04-17 23:22:54',_binary ''),(448,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  39 con los siguientes datos:  NOMBRE =  Banda elástica para ejercicios de resistencia MARCA =  PowerFuel PRECIO ACTUAL =  50.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:22:54',_binary ''),(449,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  19 con los siguientes datos:  USUARIO ID =  Carmen Guzmán Vargas PRODUCTO ID =  Banda elástica para ejercicios de resistencia PowerFuel 50.00 TOTAL =  80.00 FECHA REGISTRO =  2021-05-15 13:41:32 ESTATUS =  Activa','2024-04-17 23:22:54',_binary ''),(450,'root@localhost','Create','detalles_pedidos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  9 con los siguientes datos:  PEDIDO ID =  39 80.00 2021-05-15 13:41:32 PRODUCTO ID =  Banda de resistencia para estiramientos PowerPulse CANTIDAD =  450 TOTAL PARCIAL =  70.00 FECHA REGISTRO =  2020-01-19 09:15:11 FECHA ENTREGA =  2024-04-17 23:22:53 ESTATUS =  Activa','2024-04-17 23:22:54',_binary ''),(451,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  40 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Alejandro PRIMER APELLIDO =  Ruíz SEGUNDO APELLIDO =  Álvarez FECHA NACIMIENTO =  1980-07-10 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  AB+ ESTATUS =   FECHA REGISTRO =  2022-11-03 14:21:43 FECHA ACTUALIZACIÓN = ','2024-04-17 23:22:54',_binary ''),(452,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  40 con los siguientes datos:  NOMBRE USUARIO=  Alejandro Ruíz Álvarez PASSWORD =  TIPO =  Miembro ESTATUS CONEXIÓN =  Banned ULTIMA CONEXIÓN =  2023-11-18 12:07:49','2024-04-17 23:22:54',_binary ''),(453,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  40 con los siguientes datos:  NOMBRE =  Rodillo de espuma para masaje muscular MARCA =  PowerLift PRECIO ACTUAL =  60.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:22:54',_binary ''),(454,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  20 con los siguientes datos:  USUARIO ID =  Alejandro Ruíz Álvarez PRODUCTO ID =  Rodillo de espuma para masaje muscular PowerLift 60.00 TOTAL =  20.00 FECHA REGISTRO =  2024-03-11 14:21:37 ESTATUS =  Activa','2024-04-17 23:22:54',_binary ''),(455,'root@localhost','Create','detalles_pedidos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  10 con los siguientes datos:  PEDIDO ID =  40 20.00 2024-03-11 14:21:37 PRODUCTO ID =  Banda de resistencia para estiramientos PowerPulse CANTIDAD =  500 TOTAL PARCIAL =  10.00 FECHA REGISTRO =  2024-01-30 16:08:06 FECHA ENTREGA =  2024-04-17 23:22:53 ESTATUS =  Activa','2024-04-17 23:22:54',_binary ''),(456,'root@localhost','Update','sucursales','Se ha modificado una SUCURSAL  existente con el ID:  1 con los siguientes datos: NOMBRE = Xicotepec cambio a Xicotepec DIRECCION = Av. 5 de Mayo #75, Col. Centro cambio a Av. 5 de Mayo #75, Col. Centro RESPONSABLE =  Sin responsable asingado. cambio a Sin responsable asingado. TOTAL CLIENTES ATENDIDOS  = 0 cambio a 0 PROMEDIO DE CLIENTES POR DIA = 0 cambio a 0 CAPACIDAD MÀXIMA = 80 cambio a 80 TOTAL EMPLEADOS = 0 cambio a 0 HORARIO_DISPONIBILIDAD = 08:00 a 24:00 cambio a 08:00 a 24:00 ESTATUS =  Activa cambio a Activa','2024-04-17 23:24:58',_binary ''),(457,'root@localhost','Update','sucursales','Se ha modificado una SUCURSAL  existente con el ID:  2 con los siguientes datos: NOMBRE = Villa Ávila Camacho cambio a Villa Ávila Camacho DIRECCION = Calle Asturinas #124, Col. del Rio cambio a Calle Asturinas #124, Col. del Rio RESPONSABLE =  Sin responsable asingado. cambio a Sin responsable asingado. TOTAL CLIENTES ATENDIDOS  = 0 cambio a 0 PROMEDIO DE CLIENTES POR DIA = 0 cambio a 0 CAPACIDAD MÀXIMA = 50 cambio a 50 TOTAL EMPLEADOS = 0 cambio a 0 HORARIO_DISPONIBILIDAD = 08:00 a 20:00 cambio a 08:00 a 20:00 ESTATUS =  Activa cambio a Activa','2024-04-17 23:24:58',_binary ''),(458,'root@localhost','Update','sucursales','Se ha modificado una SUCURSAL  existente con el ID:  3 con los siguientes datos: NOMBRE = San Isidro cambio a San Isidro DIRECCION = Av. Lopez Mateoz #162 Col. Tierra Negra cambio a Av. Lopez Mateoz #162 Col. Tierra Negra RESPONSABLE =  Sin responsable asingado. cambio a Sin responsable asingado. TOTAL CLIENTES ATENDIDOS  = 1 cambio a 1 PROMEDIO DE CLIENTES POR DIA = 1 cambio a 1 CAPACIDAD MÀXIMA = 90 cambio a 90 TOTAL EMPLEADOS = 0 cambio a 0 HORARIO_DISPONIBILIDAD = 09:00 a 21:00 cambio a 09:00 a 21:00 ESTATUS =  Activa cambio a Activa','2024-04-17 23:24:58',_binary ''),(459,'root@localhost','Update','sucursales','Se ha modificado una SUCURSAL  existente con el ID:  4 con los siguientes datos: NOMBRE = Seiva cambio a Seiva DIRECCION = Av. de las Torres #239, Col. Centro cambio a Av. de las Torres #239, Col. Centro RESPONSABLE =  Sin responsable asingado. cambio a Sin responsable asingado. TOTAL CLIENTES ATENDIDOS  = 0 cambio a 0 PROMEDIO DE CLIENTES POR DIA = 0 cambio a 0 CAPACIDAD MÀXIMA = 50 cambio a 50 TOTAL EMPLEADOS = 0 cambio a 0 HORARIO_DISPONIBILIDAD = 07:00 a 22:00 cambio a 07:00 a 22:00 ESTATUS =  Inactiva cambio a Inactiva','2024-04-17 23:24:58',_binary ''),(460,'root@localhost','Update','sucursales','Se ha modificado una SUCURSAL  existente con el ID:  5 con los siguientes datos: NOMBRE = Huahuchinango cambio a Huahuchinango DIRECCION = Calle Abasolo #25, Col.Barrio tibanco cambio a Calle Abasolo #25, Col.Barrio tibanco RESPONSABLE =  Sin responsable asingado. cambio a Sin responsable asingado. TOTAL CLIENTES ATENDIDOS  = 0 cambio a 0 PROMEDIO DE CLIENTES POR DIA = 0 cambio a 0 CAPACIDAD MÀXIMA = 56 cambio a 56 TOTAL EMPLEADOS = 0 cambio a 0 HORARIO_DISPONIBILIDAD = 07:00 a 21:00 cambio a 07:00 a 21:00 ESTATUS =  Activa cambio a Activa','2024-04-17 23:24:58',_binary ''),(461,'root@localhost','Delete','detalles_productos','Se ha eliminado un DETALLE_PRODUCTO con el ID:  11','2024-04-17 23:24:58',_binary ''),(462,'root@localhost','Delete','detalles_productos','Se ha eliminado un DETALLE_PRODUCTO con el ID:  12','2024-04-17 23:24:58',_binary ''),(463,'root@localhost','Delete','detalles_productos','Se ha eliminado un DETALLE_PRODUCTO con el ID:  13','2024-04-17 23:24:58',_binary ''),(464,'root@localhost','Delete','detalles_productos','Se ha eliminado un DETALLE_PRODUCTO con el ID:  14','2024-04-17 23:24:58',_binary ''),(465,'root@localhost','Delete','detalles_productos','Se ha eliminado un DETALLE_PRODUCTO con el ID:  15','2024-04-17 23:24:58',_binary ''),(466,'root@localhost','Delete','detalles_productos','Se ha eliminado un DETALLE_PRODUCTO con el ID:  16','2024-04-17 23:24:58',_binary ''),(467,'root@localhost','Delete','detalles_productos','Se ha eliminado un DETALLE_PRODUCTO con el ID:  17','2024-04-17 23:24:58',_binary ''),(468,'root@localhost','Delete','detalles_productos','Se ha eliminado un DETALLE_PRODUCTO con el ID:  18','2024-04-17 23:24:58',_binary ''),(469,'root@localhost','Delete','detalles_productos','Se ha eliminado un DETALLE_PRODUCTO con el ID:  19','2024-04-17 23:24:58',_binary ''),(470,'root@localhost','Delete','detalles_productos','Se ha eliminado un DETALLE_PRODUCTO con el ID:  20','2024-04-17 23:24:58',_binary ''),(471,'root@localhost','Delete','detalles_pedidos','Se ha eliminado una relación DETALLES_PEDIDOS con el ID:  1','2024-04-17 23:24:58',_binary ''),(472,'root@localhost','Delete','detalles_pedidos','Se ha eliminado una relación DETALLES_PEDIDOS con el ID:  2','2024-04-17 23:24:58',_binary ''),(473,'root@localhost','Delete','detalles_pedidos','Se ha eliminado una relación DETALLES_PEDIDOS con el ID:  3','2024-04-17 23:24:58',_binary ''),(474,'root@localhost','Delete','detalles_pedidos','Se ha eliminado una relación DETALLES_PEDIDOS con el ID:  4','2024-04-17 23:24:58',_binary ''),(475,'root@localhost','Delete','detalles_pedidos','Se ha eliminado una relación DETALLES_PEDIDOS con el ID:  5','2024-04-17 23:24:58',_binary ''),(476,'root@localhost','Delete','detalles_pedidos','Se ha eliminado una relación DETALLES_PEDIDOS con el ID:  6','2024-04-17 23:24:58',_binary ''),(477,'root@localhost','Delete','detalles_pedidos','Se ha eliminado una relación DETALLES_PEDIDOS con el ID:  7','2024-04-17 23:24:58',_binary ''),(478,'root@localhost','Delete','detalles_pedidos','Se ha eliminado una relación DETALLES_PEDIDOS con el ID:  8','2024-04-17 23:24:58',_binary ''),(479,'root@localhost','Delete','detalles_pedidos','Se ha eliminado una relación DETALLES_PEDIDOS con el ID:  9','2024-04-17 23:24:58',_binary ''),(480,'root@localhost','Delete','detalles_pedidos','Se ha eliminado una relación DETALLES_PEDIDOS con el ID:  10','2024-04-17 23:24:58',_binary ''),(481,'root@localhost','Delete','pedidos','Se ha eliminado un PEDIDO con el ID:  1','2024-04-17 23:24:58',_binary ''),(482,'root@localhost','Delete','pedidos','Se ha eliminado un PEDIDO con el ID:  2','2024-04-17 23:24:58',_binary ''),(483,'root@localhost','Delete','pedidos','Se ha eliminado un PEDIDO con el ID:  3','2024-04-17 23:24:58',_binary ''),(484,'root@localhost','Delete','pedidos','Se ha eliminado un PEDIDO con el ID:  4','2024-04-17 23:24:58',_binary ''),(485,'root@localhost','Delete','pedidos','Se ha eliminado un PEDIDO con el ID:  5','2024-04-17 23:24:58',_binary ''),(486,'root@localhost','Delete','pedidos','Se ha eliminado un PEDIDO con el ID:  6','2024-04-17 23:24:58',_binary ''),(487,'root@localhost','Delete','pedidos','Se ha eliminado un PEDIDO con el ID:  7','2024-04-17 23:24:58',_binary ''),(488,'root@localhost','Delete','pedidos','Se ha eliminado un PEDIDO con el ID:  8','2024-04-17 23:24:58',_binary ''),(489,'root@localhost','Delete','pedidos','Se ha eliminado un PEDIDO con el ID:  9','2024-04-17 23:24:58',_binary ''),(490,'root@localhost','Delete','pedidos','Se ha eliminado un PEDIDO con el ID:  10','2024-04-17 23:24:58',_binary ''),(491,'root@localhost','Delete','pedidos','Se ha eliminado un PEDIDO con el ID:  11','2024-04-17 23:24:58',_binary ''),(492,'root@localhost','Delete','pedidos','Se ha eliminado un PEDIDO con el ID:  12','2024-04-17 23:24:58',_binary ''),(493,'root@localhost','Delete','pedidos','Se ha eliminado un PEDIDO con el ID:  13','2024-04-17 23:24:58',_binary ''),(494,'root@localhost','Delete','pedidos','Se ha eliminado un PEDIDO con el ID:  14','2024-04-17 23:24:58',_binary ''),(495,'root@localhost','Delete','pedidos','Se ha eliminado un PEDIDO con el ID:  15','2024-04-17 23:24:58',_binary ''),(496,'root@localhost','Delete','pedidos','Se ha eliminado un PEDIDO con el ID:  16','2024-04-17 23:24:58',_binary ''),(497,'root@localhost','Delete','pedidos','Se ha eliminado un PEDIDO con el ID:  17','2024-04-17 23:24:58',_binary ''),(498,'root@localhost','Delete','pedidos','Se ha eliminado un PEDIDO con el ID:  18','2024-04-17 23:24:58',_binary ''),(499,'root@localhost','Delete','pedidos','Se ha eliminado un PEDIDO con el ID:  19','2024-04-17 23:24:58',_binary ''),(500,'root@localhost','Delete','pedidos','Se ha eliminado un PEDIDO con el ID:  20','2024-04-17 23:24:58',_binary ''),(501,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  1','2024-04-17 23:24:58',_binary ''),(502,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  2','2024-04-17 23:24:58',_binary ''),(503,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  3','2024-04-17 23:24:58',_binary ''),(504,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  4','2024-04-17 23:24:58',_binary ''),(505,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  5','2024-04-17 23:24:58',_binary ''),(506,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  6','2024-04-17 23:24:58',_binary ''),(507,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  7','2024-04-17 23:24:58',_binary ''),(508,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  8','2024-04-17 23:24:58',_binary ''),(509,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  9','2024-04-17 23:24:58',_binary ''),(510,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  10','2024-04-17 23:24:58',_binary ''),(511,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  11','2024-04-17 23:24:58',_binary ''),(512,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  12','2024-04-17 23:24:58',_binary ''),(513,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  13','2024-04-17 23:24:58',_binary ''),(514,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  14','2024-04-17 23:24:58',_binary ''),(515,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  15','2024-04-17 23:24:58',_binary ''),(516,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  16','2024-04-17 23:24:58',_binary ''),(517,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  17','2024-04-17 23:24:58',_binary ''),(518,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  18','2024-04-17 23:24:58',_binary ''),(519,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  19','2024-04-17 23:24:58',_binary ''),(520,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  20','2024-04-17 23:24:58',_binary ''),(521,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  21','2024-04-17 23:24:58',_binary ''),(522,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  22','2024-04-17 23:24:58',_binary ''),(523,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  23','2024-04-17 23:24:58',_binary ''),(524,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  24','2024-04-17 23:24:58',_binary ''),(525,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  25','2024-04-17 23:24:58',_binary ''),(526,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  26','2024-04-17 23:24:58',_binary ''),(527,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  27','2024-04-17 23:24:58',_binary ''),(528,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  28','2024-04-17 23:24:58',_binary ''),(529,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  29','2024-04-17 23:24:58',_binary ''),(530,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  30','2024-04-17 23:24:58',_binary ''),(531,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  31','2024-04-17 23:24:58',_binary ''),(532,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  32','2024-04-17 23:24:58',_binary ''),(533,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  33','2024-04-17 23:24:58',_binary ''),(534,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  34','2024-04-17 23:24:58',_binary ''),(535,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  35','2024-04-17 23:24:58',_binary ''),(536,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  36','2024-04-17 23:24:58',_binary ''),(537,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  37','2024-04-17 23:24:58',_binary ''),(538,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  38','2024-04-17 23:24:58',_binary ''),(539,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  39','2024-04-17 23:24:58',_binary ''),(540,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  40','2024-04-17 23:24:58',_binary ''),(541,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  11','2024-04-17 23:24:58',_binary ''),(542,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  12','2024-04-17 23:24:58',_binary ''),(543,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  13','2024-04-17 23:24:58',_binary ''),(544,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  14','2024-04-17 23:24:58',_binary ''),(545,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  15','2024-04-17 23:24:58',_binary ''),(546,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  16','2024-04-17 23:24:58',_binary ''),(547,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  17','2024-04-17 23:24:58',_binary ''),(548,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  18','2024-04-17 23:24:58',_binary ''),(549,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  19','2024-04-17 23:24:58',_binary ''),(550,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  20','2024-04-17 23:24:58',_binary ''),(551,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  21','2024-04-17 23:24:58',_binary ''),(552,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  22','2024-04-17 23:24:58',_binary ''),(553,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  23','2024-04-17 23:24:58',_binary ''),(554,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  24','2024-04-17 23:24:58',_binary ''),(555,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  25','2024-04-17 23:24:58',_binary ''),(556,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  26','2024-04-17 23:24:58',_binary ''),(557,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  27','2024-04-17 23:24:58',_binary ''),(558,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  28','2024-04-17 23:24:58',_binary ''),(559,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  29','2024-04-17 23:24:58',_binary ''),(560,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  30','2024-04-17 23:24:58',_binary ''),(561,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  31','2024-04-17 23:24:58',_binary ''),(562,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  32','2024-04-17 23:24:58',_binary ''),(563,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  33','2024-04-17 23:24:58',_binary ''),(564,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  34','2024-04-17 23:24:58',_binary ''),(565,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  35','2024-04-17 23:24:58',_binary ''),(566,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  36','2024-04-17 23:24:58',_binary ''),(567,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  37','2024-04-17 23:24:58',_binary ''),(568,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  38','2024-04-17 23:24:58',_binary ''),(569,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  39','2024-04-17 23:24:58',_binary ''),(570,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  40','2024-04-17 23:24:58',_binary ''),(571,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  1','2024-04-17 23:24:58',_binary ''),(572,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  2','2024-04-17 23:24:58',_binary ''),(573,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  3','2024-04-17 23:24:58',_binary ''),(574,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  4','2024-04-17 23:24:58',_binary ''),(575,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  5','2024-04-17 23:24:58',_binary ''),(576,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  6','2024-04-17 23:24:58',_binary ''),(577,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  7','2024-04-17 23:24:58',_binary ''),(578,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  8','2024-04-17 23:24:58',_binary ''),(579,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  9','2024-04-17 23:24:58',_binary ''),(580,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  10','2024-04-17 23:24:58',_binary ''),(581,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  11','2024-04-17 23:24:58',_binary ''),(582,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  12','2024-04-17 23:24:58',_binary ''),(583,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  13','2024-04-17 23:24:58',_binary ''),(584,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  14','2024-04-17 23:24:58',_binary ''),(585,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  15','2024-04-17 23:24:58',_binary ''),(586,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  16','2024-04-17 23:24:58',_binary ''),(587,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  17','2024-04-17 23:24:58',_binary ''),(588,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  18','2024-04-17 23:24:58',_binary ''),(589,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  19','2024-04-17 23:24:58',_binary ''),(590,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  20','2024-04-17 23:24:58',_binary ''),(591,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  21','2024-04-17 23:24:58',_binary ''),(592,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  22','2024-04-17 23:24:58',_binary ''),(593,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  23','2024-04-17 23:24:58',_binary ''),(594,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  24','2024-04-17 23:24:58',_binary ''),(595,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  25','2024-04-17 23:24:58',_binary ''),(596,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  26','2024-04-17 23:24:58',_binary ''),(597,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  27','2024-04-17 23:24:58',_binary ''),(598,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  28','2024-04-17 23:24:58',_binary ''),(599,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  29','2024-04-17 23:24:58',_binary ''),(600,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  30','2024-04-17 23:24:58',_binary ''),(601,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  31','2024-04-17 23:24:58',_binary ''),(602,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  32','2024-04-17 23:24:58',_binary ''),(603,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  33','2024-04-17 23:24:58',_binary ''),(604,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  34','2024-04-17 23:24:58',_binary ''),(605,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  35','2024-04-17 23:24:58',_binary ''),(606,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  36','2024-04-17 23:24:58',_binary ''),(607,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  37','2024-04-17 23:24:58',_binary ''),(608,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  38','2024-04-17 23:24:58',_binary ''),(609,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  39','2024-04-17 23:24:58',_binary ''),(610,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  40','2024-04-17 23:24:58',_binary ''),(611,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  1 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Paola PRIMER APELLIDO =   Rivera SEGUNDO APELLIDO =  Contreras FECHA NACIMIENTO =  1972-08-17 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  O- ESTATUS =   FECHA REGISTRO =  2023-07-19 12:06:06 FECHA ACTUALIZACIÓN = ','2024-04-17 23:25:26',_binary ''),(612,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  2 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Daniel PRIMER APELLIDO =  Chávez SEGUNDO APELLIDO =  Luna FECHA NACIMIENTO =  1986-12-05 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  B+ ESTATUS =   FECHA REGISTRO =  2022-07-17 10:16:11 FECHA ACTUALIZACIÓN = ','2024-04-17 23:25:26',_binary ''),(613,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  3 con los siguientes datos:  TITULO CORTESIA =  C.P. NOMBRE= José PRIMER APELLIDO =  Domínguez SEGUNDO APELLIDO =  Cortes FECHA NACIMIENTO =  1964-10-05 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  O- ESTATUS =   FECHA REGISTRO =  2021-05-17 17:40:57 FECHA ACTUALIZACIÓN = ','2024-04-17 23:25:26',_binary ''),(614,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  4 con los siguientes datos:  TITULO CORTESIA =  Ing. NOMBRE= Lucía PRIMER APELLIDO =  Romero SEGUNDO APELLIDO =  Pérez FECHA NACIMIENTO =  1960-08-02 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  O+ ESTATUS =   FECHA REGISTRO =  2023-08-04 17:57:32 FECHA ACTUALIZACIÓN = ','2024-04-17 23:25:26',_binary ''),(615,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  5 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Monica PRIMER APELLIDO =  Gómes SEGUNDO APELLIDO =  Pérez FECHA NACIMIENTO =  2001-09-03 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  O- ESTATUS =   FECHA REGISTRO =  2021-08-04 18:28:19 FECHA ACTUALIZACIÓN = ','2024-04-17 23:25:26',_binary ''),(616,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  6 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Diana PRIMER APELLIDO =  Gutiérrez SEGUNDO APELLIDO =  Castillo FECHA NACIMIENTO =  1977-05-11 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  B+ ESTATUS =   FECHA REGISTRO =  2022-08-19 08:23:59 FECHA ACTUALIZACIÓN = ','2024-04-17 23:25:26',_binary ''),(617,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  7 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Paola PRIMER APELLIDO =  Estrada SEGUNDO APELLIDO =  Álvarez FECHA NACIMIENTO =  2001-11-01 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  AB- ESTATUS =   FECHA REGISTRO =  2020-06-11 11:31:49 FECHA ACTUALIZACIÓN = ','2024-04-17 23:25:26',_binary ''),(618,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  8 con los siguientes datos:  TITULO CORTESIA =  Sra. NOMBRE= Brenda PRIMER APELLIDO =  Gutiérrez SEGUNDO APELLIDO =  Domínguez FECHA NACIMIENTO =  1967-08-30 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  O- ESTATUS =   FECHA REGISTRO =  2023-12-11 19:11:07 FECHA ACTUALIZACIÓN = ','2024-04-17 23:25:26',_binary ''),(619,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  9 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Valeria PRIMER APELLIDO =  Chávez SEGUNDO APELLIDO =  García FECHA NACIMIENTO =  1978-11-26 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  O- ESTATUS =   FECHA REGISTRO =  2021-08-27 10:05:57 FECHA ACTUALIZACIÓN = ','2024-04-17 23:25:26',_binary ''),(620,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  10 con los siguientes datos:  TITULO CORTESIA =  NOMBRE=  Agustin PRIMER APELLIDO =  Vargas SEGUNDO APELLIDO =  Rodríguez FECHA NACIMIENTO =  1980-05-12 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  O+ ESTATUS =   FECHA REGISTRO =  2022-03-16 11:25:17 FECHA ACTUALIZACIÓN = ','2024-04-17 23:25:26',_binary ''),(621,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  11 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Suri PRIMER APELLIDO =  Reyes SEGUNDO APELLIDO =  Salazar FECHA NACIMIENTO =  1974-01-07 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  A+ ESTATUS =   FECHA REGISTRO =  2020-07-27 15:42:46 FECHA ACTUALIZACIÓN = ','2024-04-17 23:25:30',_binary ''),(622,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  11 con los siguientes datos:  NOMBRE USUARIO=  Suri Reyes Salazar PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Banned ULTIMA CONEXIÓN =  2021-02-16 11:39:31','2024-04-17 23:25:30',_binary ''),(623,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  12 con los siguientes datos:  TITULO CORTESIA =  Ing. NOMBRE= Carlos PRIMER APELLIDO =  Martínez SEGUNDO APELLIDO =  Velázquez FECHA NACIMIENTO =  1992-04-20 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  A+ ESTATUS =   FECHA REGISTRO =  2021-05-18 12:46:48 FECHA ACTUALIZACIÓN = ','2024-04-17 23:25:30',_binary ''),(624,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  12 con los siguientes datos:  NOMBRE USUARIO=  Ing. Carlos Martínez Velázquez PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Banned ULTIMA CONEXIÓN =  2021-06-18 19:26:29','2024-04-17 23:25:30',_binary ''),(625,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  13 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Estrella PRIMER APELLIDO =  Romero SEGUNDO APELLIDO =  Domínguez FECHA NACIMIENTO =  1997-06-29 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  O- ESTATUS =   FECHA REGISTRO =  2021-03-23 15:49:14 FECHA ACTUALIZACIÓN = ','2024-04-17 23:25:30',_binary ''),(626,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  13 con los siguientes datos:  NOMBRE USUARIO=  Estrella Romero Domínguez PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Banned ULTIMA CONEXIÓN =  2022-06-18 08:43:07','2024-04-17 23:25:30',_binary ''),(627,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  14 con los siguientes datos:  TITULO CORTESIA =  Ing. NOMBRE= Aldair PRIMER APELLIDO =  Guerrero SEGUNDO APELLIDO =  Domínguez FECHA NACIMIENTO =  1984-10-27 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  AB- ESTATUS =   FECHA REGISTRO =  2022-12-11 13:44:59 FECHA ACTUALIZACIÓN = ','2024-04-17 23:25:30',_binary ''),(628,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  14 con los siguientes datos:  NOMBRE USUARIO=  Ing. Aldair Guerrero Domínguez PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Banned ULTIMA CONEXIÓN =  2023-05-27 11:04:35','2024-04-17 23:25:30',_binary ''),(629,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  15 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Esmeralda PRIMER APELLIDO =  Jiménez SEGUNDO APELLIDO =  Méndez FECHA NACIMIENTO =  2000-10-21 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  AB+ ESTATUS =   FECHA REGISTRO =  2021-05-05 18:12:58 FECHA ACTUALIZACIÓN = ','2024-04-17 23:25:30',_binary ''),(630,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  15 con los siguientes datos:  NOMBRE USUARIO=  Esmeralda Jiménez Méndez PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Banned ULTIMA CONEXIÓN =  2022-04-13 08:27:21','2024-04-17 23:25:30',_binary ''),(631,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  16 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Maximiliano PRIMER APELLIDO =  De la Cruz SEGUNDO APELLIDO =  Ramírez FECHA NACIMIENTO =  1984-09-04 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  A+ ESTATUS =   FECHA REGISTRO =  2023-01-20 12:45:57 FECHA ACTUALIZACIÓN = ','2024-04-17 23:25:30',_binary ''),(632,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  16 con los siguientes datos:  NOMBRE USUARIO=  Maximiliano De la Cruz Ramírez PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Banned ULTIMA CONEXIÓN =  2024-02-10 08:49:09','2024-04-17 23:25:30',_binary ''),(633,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  17 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Ana PRIMER APELLIDO =  Pérez SEGUNDO APELLIDO =  Contreras FECHA NACIMIENTO =  1994-08-14 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  A- ESTATUS =   FECHA REGISTRO =  2022-10-06 16:48:06 FECHA ACTUALIZACIÓN = ','2024-04-17 23:25:30',_binary ''),(634,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  17 con los siguientes datos:  NOMBRE USUARIO=  Ana Pérez Contreras PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Banned ULTIMA CONEXIÓN =  2023-11-22 13:49:09','2024-04-17 23:25:30',_binary ''),(635,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  18 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Bertha PRIMER APELLIDO =  Vázquez SEGUNDO APELLIDO =   González FECHA NACIMIENTO =  1991-06-11 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  O- ESTATUS =   FECHA REGISTRO =  2020-01-28 09:09:56 FECHA ACTUALIZACIÓN = ','2024-04-17 23:25:30',_binary ''),(636,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  18 con los siguientes datos:  NOMBRE USUARIO=  Bertha Vázquez  González PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Banned ULTIMA CONEXIÓN =  2021-11-24 18:26:55','2024-04-17 23:25:30',_binary ''),(637,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  19 con los siguientes datos:  TITULO CORTESIA =  Srita NOMBRE= Paula PRIMER APELLIDO =  Guerrero SEGUNDO APELLIDO =  Luna FECHA NACIMIENTO =  1984-05-03 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  A+ ESTATUS =   FECHA REGISTRO =  2022-07-28 18:58:47 FECHA ACTUALIZACIÓN = ','2024-04-17 23:25:30',_binary ''),(638,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  19 con los siguientes datos:  NOMBRE USUARIO=  Srita Paula Guerrero Luna PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Banned ULTIMA CONEXIÓN =  2023-11-30 09:45:49','2024-04-17 23:25:30',_binary ''),(639,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  20 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Guadalupe PRIMER APELLIDO =  Vázquez SEGUNDO APELLIDO =  Juárez FECHA NACIMIENTO =  1970-01-16 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  B+ ESTATUS =   FECHA REGISTRO =  2022-12-13 15:31:57 FECHA ACTUALIZACIÓN = ','2024-04-17 23:25:30',_binary ''),(640,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  20 con los siguientes datos:  NOMBRE USUARIO=  Guadalupe Vázquez Juárez PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Banned ULTIMA CONEXIÓN =  2023-01-20 14:03:53','2024-04-17 23:25:30',_binary ''),(641,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  1 con los siguientes datos:  NOMBRE =  Suplemento pre-entrenamiento MARCA =  MuscleFlow PRECIO ACTUAL =  90.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:25:36',_binary ''),(642,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  2 con los siguientes datos:  NOMBRE =  Rodillo de espuma para masaje muscular MARCA =  FlexiStretch PRECIO ACTUAL =  10.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:25:36',_binary ''),(643,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  3 con los siguientes datos:  NOMBRE =  Termogénico para quemar grasa MARCA =  FlexiStrap PRECIO ACTUAL =  20.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:25:36',_binary ''),(644,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  4 con los siguientes datos:  NOMBRE =  Guantes para levantamiento de pesas MARCA =  MuscleFlex PRECIO ACTUAL =  10.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:25:36',_binary ''),(645,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  5 con los siguientes datos:  NOMBRE =  Termogénico para quemar grasa MARCA =  FlexiRoll PRECIO ACTUAL =  90.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:25:36',_binary ''),(646,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  6 con los siguientes datos:  NOMBRE =  Magnesio para mejorar el agarre MARCA =  PowerBands PRECIO ACTUAL =  50.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:25:36',_binary ''),(647,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  7 con los siguientes datos:  NOMBRE =  Suplemento de creatina MARCA =  FlexiRing PRECIO ACTUAL =  90.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:25:36',_binary ''),(648,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  8 con los siguientes datos:  NOMBRE =  Suplemento de creatina MARCA =  FlexiFoam PRECIO ACTUAL =  50.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:25:36',_binary ''),(649,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  9 con los siguientes datos:  NOMBRE =  Guantes para levantamiento de pesas MARCA =  MuscleFlow PRECIO ACTUAL =  60.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:25:36',_binary ''),(650,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  10 con los siguientes datos:  NOMBRE =  Batidos de proteínas MARCA =  PowerPulse PRECIO ACTUAL =  60.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:25:36',_binary ''),(651,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  11 con los siguientes datos:  NOMBRE =  Vendas para muñecas y tobillos MARCA =  PowerBeam PRECIO ACTUAL =  30.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:25:40',_binary ''),(652,'root@localhost','Create','detalles_productos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  11 con los siguientes datos:  PRODUCTO ID =  Vendas para muñecas y tobillos PowerBeam DESCRIPCION =  Botellas diseñadas para mezclar fácilmente proteína en polvo con agua o leche, convenientes para consumir bebidas nutritivas antes o después del entrenamiento. CODIGO DE BARRAS =  105389073 PRESENTACION =  Quest Nutrition Protein Bar ESTATUS =  Activa','2024-04-17 23:25:40',_binary ''),(653,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  12 con los siguientes datos:  NOMBRE =  Colchoneta para ejercicios MARCA =  FlexiStrap PRECIO ACTUAL =  70.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:25:40',_binary ''),(654,'root@localhost','Create','detalles_productos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  12 con los siguientes datos:  PRODUCTO ID =  Colchoneta para ejercicios FlexiStrap DESCRIPCION =  Accesorios que protegen las manos de callosidades y proporcionan un mejor agarre durante el levantamiento de pesas y otros ejercicios de fuerza. CODIGO DE BARRAS =  105389073 PRESENTACION =  Proteína Whey Gold Standard ESTATUS =  Activa','2024-04-17 23:25:40',_binary ''),(655,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  13 con los siguientes datos:  NOMBRE =  Bloque de espuma para estiramientos MARCA =  PowerPulse PRECIO ACTUAL =  100.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:25:40',_binary ''),(656,'root@localhost','Create','detalles_productos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  13 con los siguientes datos:  PRODUCTO ID =  Bloque de espuma para estiramientos PowerPulse DESCRIPCION =  Equipos de soporte diseñados para proteger la espalda y mejorar la estabilidad durante los levantamientos de peso pesado, como sentadillas y peso muerto. CODIGO DE BARRAS =  190532901 PRESENTACION =  Nordic Naturals Ultimate Omega ESTATUS =  Activa','2024-04-17 23:25:40',_binary ''),(657,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  14 con los siguientes datos:  NOMBRE =  Banda de resistencia para estiramientos MARCA =  PowerLift PRECIO ACTUAL =  40.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:25:40',_binary ''),(658,'root@localhost','Create','detalles_productos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  14 con los siguientes datos:  PRODUCTO ID =  Banda de resistencia para estiramientos PowerLift DESCRIPCION =  Suplemento que contiene los aminoácidos esenciales leucina, isoleucina y valina, que ayudan a promover la recuperación muscular, reducir la fatiga y preservar la masa muscular durante el ejercicio. CODIGO DE BARRAS =  385987635 PRESENTACION =  Nordic Naturals Ultimate Omega ESTATUS =  Activa','2024-04-17 23:25:40',_binary ''),(659,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  15 con los siguientes datos:  NOMBRE =  Banda de resistencia para entrenamiento MARCA =  FlexiBlock PRECIO ACTUAL =  80.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:25:40',_binary ''),(660,'root@localhost','Create','detalles_productos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  15 con los siguientes datos:  PRODUCTO ID =  Banda de resistencia para entrenamiento FlexiBlock DESCRIPCION =  Suplemento nutricional utilizado para aumentar la ingesta de proteínas, promover la recuperación muscular y el crecimiento después del entrenamiento. CODIGO DE BARRAS =  190532901 PRESENTACION =  C4 Original Pre-Workout) ESTATUS =  Activa','2024-04-17 23:25:40',_binary ''),(661,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  16 con los siguientes datos:  NOMBRE =  Colchoneta para ejercicios MARCA =  FlexiWheel PRECIO ACTUAL =  100.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:25:40',_binary ''),(662,'root@localhost','Create','detalles_productos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  16 con los siguientes datos:  PRODUCTO ID =  Colchoneta para ejercicios FlexiWheel DESCRIPCION =  Snacks convenientes y portátiles que proporcionan una fuente rápida de proteínas y carbohidratos, ideales para consumir antes o después del entrenamiento para apoyar la recuperación muscular. CODIGO DE BARRAS =  385987635 PRESENTACION =  C4 Original Pre-Workout) ESTATUS =  Activa','2024-04-17 23:25:40',_binary ''),(663,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  17 con los siguientes datos:  NOMBRE =  Esterilla de yoga MARCA =  FlexiRoll PRECIO ACTUAL =  80.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:25:40',_binary ''),(664,'root@localhost','Create','detalles_productos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  17 con los siguientes datos:  PRODUCTO ID =  Esterilla de yoga FlexiRoll DESCRIPCION =  Suplemento nutricional utilizado para aumentar la ingesta de proteínas, promover la recuperación muscular y el crecimiento después del entrenamiento. CODIGO DE BARRAS =  385987635 PRESENTACION =  Proteína Whey Gold Standard ESTATUS =  Activa','2024-04-17 23:25:40',_binary ''),(665,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  18 con los siguientes datos:  NOMBRE =  Suplemento de creatina MARCA =  FlexiPad PRECIO ACTUAL =  100.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:25:40',_binary ''),(666,'root@localhost','Create','detalles_productos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  18 con los siguientes datos:  PRODUCTO ID =  Suplemento de creatina FlexiPad DESCRIPCION =  Suplemento utilizado para aumentar la fuerza, la potencia y ​​la masa muscular, al mejorar la disponibilidad de energía en los músculos durante el ejercicio de alta intensidad. CODIGO DE BARRAS =  190532901 PRESENTACION =   Optimum Nutrition Creatine Monohydrate ESTATUS =  Activa','2024-04-17 23:25:40',_binary ''),(667,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  19 con los siguientes datos:  NOMBRE =  Bebida isotónica MARCA =  MuscleFlow PRECIO ACTUAL =  40.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:25:40',_binary ''),(668,'root@localhost','Create','detalles_productos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  19 con los siguientes datos:  PRODUCTO ID =  Bebida isotónica MuscleFlow DESCRIPCION =  Suplemento que contiene ácidos grasos esenciales omega-3, conocidos por sus efectos antiinflamatorios y beneficios para la salud cardiovascular y articular. CODIGO DE BARRAS =  385987635 PRESENTACION =  Quest Nutrition Protein Bar ESTATUS =  Activa','2024-04-17 23:25:40',_binary ''),(669,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  20 con los siguientes datos:  NOMBRE =  Termogénico para quemar grasa MARCA =  PowerFuel PRECIO ACTUAL =  70.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:25:40',_binary ''),(670,'root@localhost','Create','detalles_productos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  20 con los siguientes datos:  PRODUCTO ID =  Termogénico para quemar grasa PowerFuel DESCRIPCION =  Suplemento que contiene ácidos grasos esenciales omega-3, conocidos por sus efectos antiinflamatorios y beneficios para la salud cardiovascular y articular. CODIGO DE BARRAS =  450578976 PRESENTACION =   Optimum Nutrition Creatine Monohydrate ESTATUS =  Activa','2024-04-17 23:25:40',_binary ''),(671,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  21 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Iram PRIMER APELLIDO =  Méndez SEGUNDO APELLIDO =  Torres FECHA NACIMIENTO =  1960-06-08 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  A+ ESTATUS =   FECHA REGISTRO =  2022-04-21 11:49:02 FECHA ACTUALIZACIÓN = ','2024-04-17 23:25:43',_binary ''),(672,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  21 con los siguientes datos:  NOMBRE USUARIO=  Iram Méndez Torres PASSWORD =  TIPO =  Instructor ESTATUS CONEXIÓN =  Banned ULTIMA CONEXIÓN =  2023-12-07 10:47:21','2024-04-17 23:25:43',_binary ''),(673,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  21 con los siguientes datos:  NOMBRE =  Banda elástica para ejercicios de resistencia MARCA =  PowerLift PRECIO ACTUAL =  10.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:25:43',_binary ''),(674,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  1 con los siguientes datos:  USUARIO ID =  Iram Méndez Torres PRODUCTO ID =  Banda elástica para ejercicios de resistencia PowerLift 10.00 TOTAL =  100.00 FECHA REGISTRO =  2022-02-18 15:18:25 ESTATUS =  Activa','2024-04-17 23:25:43',_binary ''),(675,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  22 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Maria PRIMER APELLIDO =  Aguilar SEGUNDO APELLIDO =  García FECHA NACIMIENTO =  1998-06-08 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  O- ESTATUS =   FECHA REGISTRO =  2021-01-30 13:39:10 FECHA ACTUALIZACIÓN = ','2024-04-17 23:25:43',_binary ''),(676,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  22 con los siguientes datos:  NOMBRE USUARIO=  Maria Aguilar García PASSWORD =  TIPO =  Miembro ESTATUS CONEXIÓN =  Offline ULTIMA CONEXIÓN =  2021-06-17 18:06:10','2024-04-17 23:25:43',_binary ''),(677,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  22 con los siguientes datos:  NOMBRE =  Bloque de espuma para estiramientos MARCA =  FlexiStick PRECIO ACTUAL =  20.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:25:43',_binary ''),(678,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  2 con los siguientes datos:  USUARIO ID =  Maria Aguilar García PRODUCTO ID =  Bloque de espuma para estiramientos FlexiStick 20.00 TOTAL =  70.00 FECHA REGISTRO =  2022-06-29 08:32:02 ESTATUS =  Activa','2024-04-17 23:25:43',_binary ''),(679,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  23 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Fernando PRIMER APELLIDO =  Guzmán SEGUNDO APELLIDO =  Soto FECHA NACIMIENTO =  1994-11-10 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  AB- ESTATUS =   FECHA REGISTRO =  2020-05-08 13:27:21 FECHA ACTUALIZACIÓN = ','2024-04-17 23:25:43',_binary ''),(680,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  23 con los siguientes datos:  NOMBRE USUARIO=  Fernando Guzmán Soto PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Banned ULTIMA CONEXIÓN =  2023-05-31 14:46:57','2024-04-17 23:25:43',_binary ''),(681,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  23 con los siguientes datos:  NOMBRE =  Bebida isotónica MARCA =  PowerBeam PRECIO ACTUAL =  50.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:25:43',_binary ''),(682,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  3 con los siguientes datos:  USUARIO ID =  Fernando Guzmán Soto PRODUCTO ID =  Bebida isotónica PowerBeam 50.00 TOTAL =  10.00 FECHA REGISTRO =  2023-04-10 16:07:59 ESTATUS =  Activa','2024-04-17 23:25:43',_binary ''),(683,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  24 con los siguientes datos:  TITULO CORTESIA =  Ing. NOMBRE= Daniel PRIMER APELLIDO =   Rivera SEGUNDO APELLIDO =   González FECHA NACIMIENTO =  1991-06-22 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  A+ ESTATUS =   FECHA REGISTRO =  2020-05-19 12:53:39 FECHA ACTUALIZACIÓN = ','2024-04-17 23:25:43',_binary ''),(684,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  24 con los siguientes datos:  NOMBRE USUARIO=  Ing. Daniel  Rivera  González PASSWORD =  TIPO =  Instructor ESTATUS CONEXIÓN =  Offline ULTIMA CONEXIÓN =  2023-11-25 14:44:42','2024-04-17 23:25:43',_binary ''),(685,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  24 con los siguientes datos:  NOMBRE =  Bebida energética pre-entrenamiento MARCA =  SpeedMate PRECIO ACTUAL =  10.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:25:43',_binary ''),(686,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  4 con los siguientes datos:  USUARIO ID =  Ing. Daniel  Rivera  González PRODUCTO ID =  Bebida energética pre-entrenamiento SpeedMate 10.00 TOTAL =  80.00 FECHA REGISTRO =  2022-06-14 14:42:59 ESTATUS =  Activa','2024-04-17 23:25:43',_binary ''),(687,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  25 con los siguientes datos:  TITULO CORTESIA =  Ing. NOMBRE= Ana PRIMER APELLIDO =  Velázquez SEGUNDO APELLIDO =  Pérez FECHA NACIMIENTO =  1968-01-25 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  AB+ ESTATUS =   FECHA REGISTRO =  2021-11-18 12:51:27 FECHA ACTUALIZACIÓN = ','2024-04-17 23:25:43',_binary ''),(688,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  25 con los siguientes datos:  NOMBRE USUARIO=  Ing. Ana Velázquez Pérez PASSWORD =  TIPO =  Miembro ESTATUS CONEXIÓN =  Offline ULTIMA CONEXIÓN =  2023-03-17 16:52:10','2024-04-17 23:25:43',_binary ''),(689,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  25 con los siguientes datos:  NOMBRE =  Batidos de proteínas MARCA =  FlexiGrip PRECIO ACTUAL =  100.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:25:43',_binary ''),(690,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  5 con los siguientes datos:  USUARIO ID =  Ing. Ana Velázquez Pérez PRODUCTO ID =  Batidos de proteínas FlexiGrip 100.00 TOTAL =  80.00 FECHA REGISTRO =  2023-06-12 17:37:33 ESTATUS =  Activa','2024-04-17 23:25:43',_binary ''),(691,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  26 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Ana PRIMER APELLIDO =  Castillo SEGUNDO APELLIDO =  Domínguez FECHA NACIMIENTO =  1995-10-15 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  O+ ESTATUS =   FECHA REGISTRO =  2023-03-22 12:18:18 FECHA ACTUALIZACIÓN = ','2024-04-17 23:25:43',_binary ''),(692,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  26 con los siguientes datos:  NOMBRE USUARIO=  Ana Castillo Domínguez PASSWORD =  TIPO =  Miembro ESTATUS CONEXIÓN =  Offline ULTIMA CONEXIÓN =  2023-11-09 08:15:39','2024-04-17 23:25:43',_binary ''),(693,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  26 con los siguientes datos:  NOMBRE =  Banda de resistencia para estiramientos MARCA =  PowerCord PRECIO ACTUAL =  10.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:25:43',_binary ''),(694,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  6 con los siguientes datos:  USUARIO ID =  Ana Castillo Domínguez PRODUCTO ID =  Banda de resistencia para estiramientos PowerCord 10.00 TOTAL =  40.00 FECHA REGISTRO =  2023-09-05 09:00:27 ESTATUS =  Activa','2024-04-17 23:25:43',_binary ''),(695,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  27 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Jesus PRIMER APELLIDO =  Gutiérrez SEGUNDO APELLIDO =  Aguilar FECHA NACIMIENTO =  1962-07-31 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  A+ ESTATUS =   FECHA REGISTRO =  2023-11-10 13:10:44 FECHA ACTUALIZACIÓN = ','2024-04-17 23:25:43',_binary ''),(696,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  27 con los siguientes datos:  NOMBRE USUARIO=  Jesus Gutiérrez Aguilar PASSWORD =  TIPO =  Visitante ESTATUS CONEXIÓN =  Online ULTIMA CONEXIÓN =  2024-03-03 14:09:47','2024-04-17 23:25:43',_binary ''),(697,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  27 con los siguientes datos:  NOMBRE =  Banda de resistencia para entrenamiento MARCA =  FlexiBottle PRECIO ACTUAL =  60.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:25:43',_binary ''),(698,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  7 con los siguientes datos:  USUARIO ID =  Jesus Gutiérrez Aguilar PRODUCTO ID =  Banda de resistencia para entrenamiento FlexiBottle 60.00 TOTAL =  30.00 FECHA REGISTRO =  2021-02-23 16:43:22 ESTATUS =  Activa','2024-04-17 23:25:43',_binary ''),(699,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  28 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Bertha PRIMER APELLIDO =  Cruz SEGUNDO APELLIDO =  Ramos FECHA NACIMIENTO =  1988-03-18 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  A+ ESTATUS =   FECHA REGISTRO =  2022-06-20 15:59:58 FECHA ACTUALIZACIÓN = ','2024-04-17 23:25:43',_binary ''),(700,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  28 con los siguientes datos:  NOMBRE USUARIO=  Bertha Cruz Ramos PASSWORD =  TIPO =  Miembro ESTATUS CONEXIÓN =  Online ULTIMA CONEXIÓN =  2023-03-11 18:09:05','2024-04-17 23:25:43',_binary ''),(701,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  28 con los siguientes datos:  NOMBRE =  Batidos de proteínas MARCA =  PowerBands PRECIO ACTUAL =  30.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:25:43',_binary ''),(702,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  8 con los siguientes datos:  USUARIO ID =  Bertha Cruz Ramos PRODUCTO ID =  Batidos de proteínas PowerBands 30.00 TOTAL =  20.00 FECHA REGISTRO =  2020-08-01 10:04:03 ESTATUS =  Activa','2024-04-17 23:25:43',_binary ''),(703,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  29 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Alondra PRIMER APELLIDO =  Juárez SEGUNDO APELLIDO =  Guerrero FECHA NACIMIENTO =  1997-09-26 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  A- ESTATUS =   FECHA REGISTRO =  2021-12-28 17:56:53 FECHA ACTUALIZACIÓN = ','2024-04-17 23:25:43',_binary ''),(704,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  29 con los siguientes datos:  NOMBRE USUARIO=  Alondra Juárez Guerrero PASSWORD =  TIPO =  Instructor ESTATUS CONEXIÓN =  Online ULTIMA CONEXIÓN =  2022-04-22 18:11:53','2024-04-17 23:25:43',_binary ''),(705,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  29 con los siguientes datos:  NOMBRE =  Bebida energética post-entrenamiento MARCA =  FlexiBlock PRECIO ACTUAL =  70.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:25:43',_binary ''),(706,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  9 con los siguientes datos:  USUARIO ID =  Alondra Juárez Guerrero PRODUCTO ID =  Bebida energética post-entrenamiento FlexiBlock 70.00 TOTAL =  40.00 FECHA REGISTRO =  2023-05-16 18:38:17 ESTATUS =  Activa','2024-04-17 23:25:43',_binary ''),(707,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  30 con los siguientes datos:  TITULO CORTESIA =  Med. NOMBRE= Valeria PRIMER APELLIDO =  Mendoza SEGUNDO APELLIDO =  Morales FECHA NACIMIENTO =  2007-01-23 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  A- ESTATUS =   FECHA REGISTRO =  2023-07-07 15:43:13 FECHA ACTUALIZACIÓN = ','2024-04-17 23:25:43',_binary ''),(708,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  30 con los siguientes datos:  NOMBRE USUARIO=  Med. Valeria Mendoza Morales PASSWORD =  TIPO =  Instructor ESTATUS CONEXIÓN =  Banned ULTIMA CONEXIÓN =  2023-08-18 08:55:47','2024-04-17 23:25:43',_binary ''),(709,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  30 con los siguientes datos:  NOMBRE =  Vendas para muñecas y tobillos MARCA =  PowerBar PRECIO ACTUAL =  60.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:25:43',_binary ''),(710,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  10 con los siguientes datos:  USUARIO ID =  Med. Valeria Mendoza Morales PRODUCTO ID =  Vendas para muñecas y tobillos PowerBar 60.00 TOTAL =  50.00 FECHA REGISTRO =  2022-07-23 14:50:22 ESTATUS =  Activa','2024-04-17 23:25:43',_binary ''),(711,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  31 con los siguientes datos:  TITULO CORTESIA =  C.P. NOMBRE= Bertha PRIMER APELLIDO =  Chávez SEGUNDO APELLIDO =  Chávez FECHA NACIMIENTO =  1965-12-30 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  O- ESTATUS =   FECHA REGISTRO =  2022-02-12 14:15:46 FECHA ACTUALIZACIÓN = ','2024-04-17 23:25:46',_binary ''),(712,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  31 con los siguientes datos:  NOMBRE USUARIO=  C.P. Bertha Chávez Chávez PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Online ULTIMA CONEXIÓN =  2022-03-30 08:16:05','2024-04-17 23:25:46',_binary ''),(713,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  31 con los siguientes datos:  NOMBRE =  Vendas para muñecas y tobillos MARCA =  PowerCord PRECIO ACTUAL =  30.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:25:46',_binary ''),(714,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  11 con los siguientes datos:  USUARIO ID =  C.P. Bertha Chávez Chávez PRODUCTO ID =  Vendas para muñecas y tobillos PowerCord 30.00 TOTAL =  40.00 FECHA REGISTRO =  2020-12-14 19:14:27 ESTATUS =  Activa','2024-04-17 23:25:46',_binary ''),(715,'root@localhost','Create','detalles_pedidos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  1 con los siguientes datos:  PEDIDO ID =  31 40.00 2020-12-14 19:14:27 PRODUCTO ID =  Suplemento pre-entrenamiento MuscleFlow CANTIDAD =  10 TOTAL PARCIAL =  30.00 FECHA REGISTRO =  2021-06-25 18:37:05 FECHA ENTREGA =  2024-04-17 23:25:46 ESTATUS =  Activa','2024-04-17 23:25:46',_binary ''),(716,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  32 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Gerardo PRIMER APELLIDO =  Ramos SEGUNDO APELLIDO =  Morales FECHA NACIMIENTO =  1975-08-08 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  O- ESTATUS =   FECHA REGISTRO =  2022-10-13 13:24:13 FECHA ACTUALIZACIÓN = ','2024-04-17 23:25:46',_binary ''),(717,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  32 con los siguientes datos:  NOMBRE USUARIO=  Gerardo Ramos Morales PASSWORD =  TIPO =  Visitante ESTATUS CONEXIÓN =  Online ULTIMA CONEXIÓN =  2022-11-03 15:24:27','2024-04-17 23:25:46',_binary ''),(718,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  32 con los siguientes datos:  NOMBRE =  Cinturón de levantamiento de pesas MARCA =  FlexiSqueeze PRECIO ACTUAL =  10.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:25:46',_binary ''),(719,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  12 con los siguientes datos:  USUARIO ID =  Gerardo Ramos Morales PRODUCTO ID =  Cinturón de levantamiento de pesas FlexiSqueeze 10.00 TOTAL =  30.00 FECHA REGISTRO =  2020-09-26 08:51:11 ESTATUS =  Activa','2024-04-17 23:25:46',_binary ''),(720,'root@localhost','Create','detalles_pedidos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  2 con los siguientes datos:  PEDIDO ID =  32 30.00 2020-09-26 08:51:11 PRODUCTO ID =  Suplemento pre-entrenamiento MuscleFlow CANTIDAD =  60 TOTAL PARCIAL =  100.00 FECHA REGISTRO =  2021-10-30 09:56:20 FECHA ENTREGA =  2024-04-17 23:25:46 ESTATUS =  Activa','2024-04-17 23:25:46',_binary ''),(721,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  33 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Ricardo PRIMER APELLIDO =  Herrera SEGUNDO APELLIDO =  Ramos FECHA NACIMIENTO =  1965-05-09 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  O+ ESTATUS =   FECHA REGISTRO =  2021-08-22 15:53:39 FECHA ACTUALIZACIÓN = ','2024-04-17 23:25:46',_binary ''),(722,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  33 con los siguientes datos:  NOMBRE USUARIO=  Ricardo Herrera Ramos PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Banned ULTIMA CONEXIÓN =  2022-05-27 10:29:13','2024-04-17 23:25:46',_binary ''),(723,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  33 con los siguientes datos:  NOMBRE =  Suplemento de creatina MARCA =  SpeedGrip PRECIO ACTUAL =  80.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:25:46',_binary ''),(724,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  13 con los siguientes datos:  USUARIO ID =  Ricardo Herrera Ramos PRODUCTO ID =  Suplemento de creatina SpeedGrip 80.00 TOTAL =  90.00 FECHA REGISTRO =  2023-10-23 08:20:03 ESTATUS =  Activa','2024-04-17 23:25:46',_binary ''),(725,'root@localhost','Create','detalles_pedidos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  3 con los siguientes datos:  PEDIDO ID =  33 90.00 2023-10-23 08:20:03 PRODUCTO ID =  Suplemento pre-entrenamiento MuscleFlow CANTIDAD =  450 TOTAL PARCIAL =  40.00 FECHA REGISTRO =  2020-07-04 15:53:13 FECHA ENTREGA =  2024-04-17 23:25:46 ESTATUS =  Activa','2024-04-17 23:25:46',_binary ''),(726,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  34 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Monica PRIMER APELLIDO =  Cruz SEGUNDO APELLIDO =  Cortés FECHA NACIMIENTO =  1974-04-12 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  AB+ ESTATUS =   FECHA REGISTRO =  2020-08-20 18:48:36 FECHA ACTUALIZACIÓN = ','2024-04-17 23:25:46',_binary ''),(727,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  34 con los siguientes datos:  NOMBRE USUARIO=  Monica Cruz Cortés PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Offline ULTIMA CONEXIÓN =  2023-08-06 10:59:50','2024-04-17 23:25:46',_binary ''),(728,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  34 con los siguientes datos:  NOMBRE =  Bebida energética post-entrenamiento MARCA =  FlexiMat PRECIO ACTUAL =  40.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:25:46',_binary ''),(729,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  14 con los siguientes datos:  USUARIO ID =  Monica Cruz Cortés PRODUCTO ID =  Bebida energética post-entrenamiento FlexiMat 40.00 TOTAL =  80.00 FECHA REGISTRO =  2022-01-01 10:25:01 ESTATUS =  Activa','2024-04-17 23:25:46',_binary ''),(730,'root@localhost','Create','detalles_pedidos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  4 con los siguientes datos:  PEDIDO ID =  34 80.00 2022-01-01 10:25:01 PRODUCTO ID =  Suplemento pre-entrenamiento MuscleFlow CANTIDAD =  500 TOTAL PARCIAL =  50.00 FECHA REGISTRO =  2021-06-25 13:06:29 FECHA ENTREGA =  2024-04-17 23:25:46 ESTATUS =  Activa','2024-04-17 23:25:46',_binary ''),(731,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  35 con los siguientes datos:  TITULO CORTESIA =  Sgto. NOMBRE= Edgar PRIMER APELLIDO =  Álvarez SEGUNDO APELLIDO =  Méndez FECHA NACIMIENTO =  1966-12-18 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  A- ESTATUS =   FECHA REGISTRO =  2020-12-31 16:55:01 FECHA ACTUALIZACIÓN = ','2024-04-17 23:25:46',_binary ''),(732,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  35 con los siguientes datos:  NOMBRE USUARIO=  Sgto. Edgar Álvarez Méndez PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Banned ULTIMA CONEXIÓN =  2021-09-22 14:27:59','2024-04-17 23:25:46',_binary ''),(733,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  35 con los siguientes datos:  NOMBRE =  Batidos de proteínas MARCA =  PowerGrip PRECIO ACTUAL =  70.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:25:46',_binary ''),(734,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  15 con los siguientes datos:  USUARIO ID =  Sgto. Edgar Álvarez Méndez PRODUCTO ID =  Batidos de proteínas PowerGrip 70.00 TOTAL =  70.00 FECHA REGISTRO =  2021-01-13 11:17:05 ESTATUS =  Activa','2024-04-17 23:25:46',_binary ''),(735,'root@localhost','Create','detalles_pedidos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  5 con los siguientes datos:  PEDIDO ID =  35 70.00 2021-01-13 11:17:05 PRODUCTO ID =  Suplemento pre-entrenamiento MuscleFlow CANTIDAD =  500 TOTAL PARCIAL =  50.00 FECHA REGISTRO =  2020-04-21 09:49:53 FECHA ENTREGA =  2024-04-17 23:25:46 ESTATUS =  Activa','2024-04-17 23:25:46',_binary ''),(736,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  36 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Carlos PRIMER APELLIDO =  Ramírez SEGUNDO APELLIDO =  Ortiz FECHA NACIMIENTO =  1995-12-09 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  B+ ESTATUS =   FECHA REGISTRO =  2022-08-14 19:13:04 FECHA ACTUALIZACIÓN = ','2024-04-17 23:25:46',_binary ''),(737,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  36 con los siguientes datos:  NOMBRE USUARIO=  Carlos Ramírez Ortiz PASSWORD =  TIPO =  Instructor ESTATUS CONEXIÓN =  Offline ULTIMA CONEXIÓN =  2023-08-13 16:16:31','2024-04-17 23:25:46',_binary ''),(738,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  36 con los siguientes datos:  NOMBRE =  Termogénico para quemar grasa MARCA =  PowerBurn PRECIO ACTUAL =  40.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:25:46',_binary ''),(739,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  16 con los siguientes datos:  USUARIO ID =  Carlos Ramírez Ortiz PRODUCTO ID =  Termogénico para quemar grasa PowerBurn 40.00 TOTAL =  90.00 FECHA REGISTRO =  2020-07-25 10:21:43 ESTATUS =  Activa','2024-04-17 23:25:46',_binary ''),(740,'root@localhost','Create','detalles_pedidos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  6 con los siguientes datos:  PEDIDO ID =  36 90.00 2020-07-25 10:21:43 PRODUCTO ID =  Suplemento pre-entrenamiento MuscleFlow CANTIDAD =  450 TOTAL PARCIAL =  40.00 FECHA REGISTRO =  2020-02-24 09:04:03 FECHA ENTREGA =  2024-04-17 23:25:46 ESTATUS =  Activa','2024-04-17 23:25:46',_binary ''),(741,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  37 con los siguientes datos:  TITULO CORTESIA =  NOMBRE=  Agustin PRIMER APELLIDO =  Chávez SEGUNDO APELLIDO =  Jiménez FECHA NACIMIENTO =  2001-02-20 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  B+ ESTATUS =   FECHA REGISTRO =  2020-06-06 14:03:59 FECHA ACTUALIZACIÓN = ','2024-04-17 23:25:46',_binary ''),(742,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  37 con los siguientes datos:  NOMBRE USUARIO=   Agustin Chávez Jiménez PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Offline ULTIMA CONEXIÓN =  2021-12-03 09:06:40','2024-04-17 23:25:46',_binary ''),(743,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  37 con los siguientes datos:  NOMBRE =  Banda de resistencia para estiramientos MARCA =  SpeedGrip PRECIO ACTUAL =  40.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:25:46',_binary ''),(744,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  17 con los siguientes datos:  USUARIO ID =   Agustin Chávez Jiménez PRODUCTO ID =  Banda de resistencia para estiramientos SpeedGrip 40.00 TOTAL =  90.00 FECHA REGISTRO =  2020-08-23 11:36:58 ESTATUS =  Activa','2024-04-17 23:25:46',_binary ''),(745,'root@localhost','Create','detalles_pedidos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  7 con los siguientes datos:  PEDIDO ID =  37 90.00 2020-08-23 11:36:58 PRODUCTO ID =  Suplemento pre-entrenamiento MuscleFlow CANTIDAD =  10 TOTAL PARCIAL =  40.00 FECHA REGISTRO =  2023-03-03 14:31:12 FECHA ENTREGA =  2024-04-17 23:25:46 ESTATUS =  Activa','2024-04-17 23:25:46',_binary ''),(746,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  38 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Valeria PRIMER APELLIDO =  Bautista SEGUNDO APELLIDO =  Hernández FECHA NACIMIENTO =  1969-05-16 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  O- ESTATUS =   FECHA REGISTRO =  2021-04-06 14:17:37 FECHA ACTUALIZACIÓN = ','2024-04-17 23:25:46',_binary ''),(747,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  38 con los siguientes datos:  NOMBRE USUARIO=  Valeria Bautista Hernández PASSWORD =  TIPO =  Miembro ESTATUS CONEXIÓN =  Online ULTIMA CONEXIÓN =  2022-06-26 15:43:05','2024-04-17 23:25:46',_binary ''),(748,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  38 con los siguientes datos:  NOMBRE =  Batidos de proteínas MARCA =  PowerFuel PRECIO ACTUAL =  50.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:25:46',_binary ''),(749,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  18 con los siguientes datos:  USUARIO ID =  Valeria Bautista Hernández PRODUCTO ID =  Batidos de proteínas PowerFuel 50.00 TOTAL =  20.00 FECHA REGISTRO =  2020-09-28 13:50:43 ESTATUS =  Activa','2024-04-17 23:25:46',_binary ''),(750,'root@localhost','Create','detalles_pedidos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  8 con los siguientes datos:  PEDIDO ID =  38 20.00 2020-09-28 13:50:43 PRODUCTO ID =  Suplemento pre-entrenamiento MuscleFlow CANTIDAD =  60 TOTAL PARCIAL =  20.00 FECHA REGISTRO =  2023-09-06 19:02:57 FECHA ENTREGA =  2024-04-17 23:25:46 ESTATUS =  Activa','2024-04-17 23:25:46',_binary ''),(751,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  39 con los siguientes datos:  TITULO CORTESIA =  C.P. NOMBRE= Adalid PRIMER APELLIDO =  Pérez SEGUNDO APELLIDO =  Aguilar FECHA NACIMIENTO =  2001-03-03 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  O- ESTATUS =   FECHA REGISTRO =  2021-01-16 11:57:42 FECHA ACTUALIZACIÓN = ','2024-04-17 23:25:46',_binary ''),(752,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  39 con los siguientes datos:  NOMBRE USUARIO=  C.P. Adalid Pérez Aguilar PASSWORD =  TIPO =  Instructor ESTATUS CONEXIÓN =  Offline ULTIMA CONEXIÓN =  2022-02-20 17:53:36','2024-04-17 23:25:46',_binary ''),(753,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  39 con los siguientes datos:  NOMBRE =  Bebida energética pre-entrenamiento MARCA =  MuscleMax PRECIO ACTUAL =  10.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:25:46',_binary ''),(754,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  19 con los siguientes datos:  USUARIO ID =  C.P. Adalid Pérez Aguilar PRODUCTO ID =  Bebida energética pre-entrenamiento MuscleMax 10.00 TOTAL =  10.00 FECHA REGISTRO =  2020-04-25 10:40:50 ESTATUS =  Activa','2024-04-17 23:25:46',_binary ''),(755,'root@localhost','Create','detalles_pedidos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  9 con los siguientes datos:  PEDIDO ID =  39 10.00 2020-04-25 10:40:50 PRODUCTO ID =  Suplemento pre-entrenamiento MuscleFlow CANTIDAD =  60 TOTAL PARCIAL =  90.00 FECHA REGISTRO =  2021-07-14 12:18:56 FECHA ENTREGA =  2024-04-17 23:25:46 ESTATUS =  Activa','2024-04-17 23:25:46',_binary ''),(756,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  40 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Guadalupe PRIMER APELLIDO =  Vázquez SEGUNDO APELLIDO =  Méndez FECHA NACIMIENTO =  1959-07-24 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  B+ ESTATUS =   FECHA REGISTRO =  2023-03-17 16:06:06 FECHA ACTUALIZACIÓN = ','2024-04-17 23:25:46',_binary ''),(757,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  40 con los siguientes datos:  NOMBRE USUARIO=  Guadalupe Vázquez Méndez PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Offline ULTIMA CONEXIÓN =  2024-02-23 12:14:53','2024-04-17 23:25:46',_binary ''),(758,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  40 con los siguientes datos:  NOMBRE =  Suplemento de creatina MARCA =  MuscleFlex PRECIO ACTUAL =  70.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:25:46',_binary ''),(759,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  20 con los siguientes datos:  USUARIO ID =  Guadalupe Vázquez Méndez PRODUCTO ID =  Suplemento de creatina MuscleFlex 70.00 TOTAL =  80.00 FECHA REGISTRO =  2023-02-23 13:26:41 ESTATUS =  Activa','2024-04-17 23:25:46',_binary ''),(760,'root@localhost','Create','detalles_pedidos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  10 con los siguientes datos:  PEDIDO ID =  40 80.00 2023-02-23 13:26:41 PRODUCTO ID =  Suplemento pre-entrenamiento MuscleFlow CANTIDAD =  10 TOTAL PARCIAL =  100.00 FECHA REGISTRO =  2023-03-14 16:59:32 FECHA ENTREGA =  2024-04-17 23:25:46 ESTATUS =  Activa','2024-04-17 23:25:46',_binary ''),(761,'root@localhost','Update','sucursales','Se ha modificado una SUCURSAL  existente con el ID:  1 con los siguientes datos: NOMBRE = Xicotepec cambio a Xicotepec DIRECCION = Av. 5 de Mayo #75, Col. Centro cambio a Av. 5 de Mayo #75, Col. Centro RESPONSABLE =  Sin responsable asingado. cambio a Sin responsable asingado. TOTAL CLIENTES ATENDIDOS  = 0 cambio a 0 PROMEDIO DE CLIENTES POR DIA = 0 cambio a 0 CAPACIDAD MÀXIMA = 80 cambio a 80 TOTAL EMPLEADOS = 0 cambio a 0 HORARIO_DISPONIBILIDAD = 08:00 a 24:00 cambio a 08:00 a 24:00 ESTATUS =  Activa cambio a Activa','2024-04-17 23:26:35',_binary ''),(762,'root@localhost','Update','sucursales','Se ha modificado una SUCURSAL  existente con el ID:  2 con los siguientes datos: NOMBRE = Villa Ávila Camacho cambio a Villa Ávila Camacho DIRECCION = Calle Asturinas #124, Col. del Rio cambio a Calle Asturinas #124, Col. del Rio RESPONSABLE =  Sin responsable asingado. cambio a Sin responsable asingado. TOTAL CLIENTES ATENDIDOS  = 0 cambio a 0 PROMEDIO DE CLIENTES POR DIA = 0 cambio a 0 CAPACIDAD MÀXIMA = 50 cambio a 50 TOTAL EMPLEADOS = 0 cambio a 0 HORARIO_DISPONIBILIDAD = 08:00 a 20:00 cambio a 08:00 a 20:00 ESTATUS =  Activa cambio a Activa','2024-04-17 23:26:35',_binary ''),(763,'root@localhost','Update','sucursales','Se ha modificado una SUCURSAL  existente con el ID:  3 con los siguientes datos: NOMBRE = San Isidro cambio a San Isidro DIRECCION = Av. Lopez Mateoz #162 Col. Tierra Negra cambio a Av. Lopez Mateoz #162 Col. Tierra Negra RESPONSABLE =  Sin responsable asingado. cambio a Sin responsable asingado. TOTAL CLIENTES ATENDIDOS  = 1 cambio a 1 PROMEDIO DE CLIENTES POR DIA = 1 cambio a 1 CAPACIDAD MÀXIMA = 90 cambio a 90 TOTAL EMPLEADOS = 0 cambio a 0 HORARIO_DISPONIBILIDAD = 09:00 a 21:00 cambio a 09:00 a 21:00 ESTATUS =  Activa cambio a Activa','2024-04-17 23:26:35',_binary ''),(764,'root@localhost','Update','sucursales','Se ha modificado una SUCURSAL  existente con el ID:  4 con los siguientes datos: NOMBRE = Seiva cambio a Seiva DIRECCION = Av. de las Torres #239, Col. Centro cambio a Av. de las Torres #239, Col. Centro RESPONSABLE =  Sin responsable asingado. cambio a Sin responsable asingado. TOTAL CLIENTES ATENDIDOS  = 0 cambio a 0 PROMEDIO DE CLIENTES POR DIA = 0 cambio a 0 CAPACIDAD MÀXIMA = 50 cambio a 50 TOTAL EMPLEADOS = 0 cambio a 0 HORARIO_DISPONIBILIDAD = 07:00 a 22:00 cambio a 07:00 a 22:00 ESTATUS =  Inactiva cambio a Inactiva','2024-04-17 23:26:35',_binary ''),(765,'root@localhost','Update','sucursales','Se ha modificado una SUCURSAL  existente con el ID:  5 con los siguientes datos: NOMBRE = Huahuchinango cambio a Huahuchinango DIRECCION = Calle Abasolo #25, Col.Barrio tibanco cambio a Calle Abasolo #25, Col.Barrio tibanco RESPONSABLE =  Sin responsable asingado. cambio a Sin responsable asingado. TOTAL CLIENTES ATENDIDOS  = 0 cambio a 0 PROMEDIO DE CLIENTES POR DIA = 0 cambio a 0 CAPACIDAD MÀXIMA = 56 cambio a 56 TOTAL EMPLEADOS = 0 cambio a 0 HORARIO_DISPONIBILIDAD = 07:00 a 21:00 cambio a 07:00 a 21:00 ESTATUS =  Activa cambio a Activa','2024-04-17 23:26:35',_binary ''),(766,'root@localhost','Delete','detalles_productos','Se ha eliminado un DETALLE_PRODUCTO con el ID:  11','2024-04-17 23:26:35',_binary ''),(767,'root@localhost','Delete','detalles_productos','Se ha eliminado un DETALLE_PRODUCTO con el ID:  12','2024-04-17 23:26:35',_binary ''),(768,'root@localhost','Delete','detalles_productos','Se ha eliminado un DETALLE_PRODUCTO con el ID:  13','2024-04-17 23:26:35',_binary ''),(769,'root@localhost','Delete','detalles_productos','Se ha eliminado un DETALLE_PRODUCTO con el ID:  14','2024-04-17 23:26:35',_binary ''),(770,'root@localhost','Delete','detalles_productos','Se ha eliminado un DETALLE_PRODUCTO con el ID:  15','2024-04-17 23:26:35',_binary ''),(771,'root@localhost','Delete','detalles_productos','Se ha eliminado un DETALLE_PRODUCTO con el ID:  16','2024-04-17 23:26:35',_binary ''),(772,'root@localhost','Delete','detalles_productos','Se ha eliminado un DETALLE_PRODUCTO con el ID:  17','2024-04-17 23:26:35',_binary ''),(773,'root@localhost','Delete','detalles_productos','Se ha eliminado un DETALLE_PRODUCTO con el ID:  18','2024-04-17 23:26:35',_binary ''),(774,'root@localhost','Delete','detalles_productos','Se ha eliminado un DETALLE_PRODUCTO con el ID:  19','2024-04-17 23:26:35',_binary ''),(775,'root@localhost','Delete','detalles_productos','Se ha eliminado un DETALLE_PRODUCTO con el ID:  20','2024-04-17 23:26:35',_binary ''),(776,'root@localhost','Delete','detalles_pedidos','Se ha eliminado una relación DETALLES_PEDIDOS con el ID:  1','2024-04-17 23:26:35',_binary ''),(777,'root@localhost','Delete','detalles_pedidos','Se ha eliminado una relación DETALLES_PEDIDOS con el ID:  2','2024-04-17 23:26:35',_binary ''),(778,'root@localhost','Delete','detalles_pedidos','Se ha eliminado una relación DETALLES_PEDIDOS con el ID:  3','2024-04-17 23:26:35',_binary ''),(779,'root@localhost','Delete','detalles_pedidos','Se ha eliminado una relación DETALLES_PEDIDOS con el ID:  4','2024-04-17 23:26:35',_binary ''),(780,'root@localhost','Delete','detalles_pedidos','Se ha eliminado una relación DETALLES_PEDIDOS con el ID:  5','2024-04-17 23:26:35',_binary ''),(781,'root@localhost','Delete','detalles_pedidos','Se ha eliminado una relación DETALLES_PEDIDOS con el ID:  6','2024-04-17 23:26:35',_binary ''),(782,'root@localhost','Delete','detalles_pedidos','Se ha eliminado una relación DETALLES_PEDIDOS con el ID:  7','2024-04-17 23:26:35',_binary ''),(783,'root@localhost','Delete','detalles_pedidos','Se ha eliminado una relación DETALLES_PEDIDOS con el ID:  8','2024-04-17 23:26:35',_binary ''),(784,'root@localhost','Delete','detalles_pedidos','Se ha eliminado una relación DETALLES_PEDIDOS con el ID:  9','2024-04-17 23:26:35',_binary ''),(785,'root@localhost','Delete','detalles_pedidos','Se ha eliminado una relación DETALLES_PEDIDOS con el ID:  10','2024-04-17 23:26:35',_binary ''),(786,'root@localhost','Delete','pedidos','Se ha eliminado un PEDIDO con el ID:  1','2024-04-17 23:26:35',_binary ''),(787,'root@localhost','Delete','pedidos','Se ha eliminado un PEDIDO con el ID:  2','2024-04-17 23:26:35',_binary ''),(788,'root@localhost','Delete','pedidos','Se ha eliminado un PEDIDO con el ID:  3','2024-04-17 23:26:35',_binary ''),(789,'root@localhost','Delete','pedidos','Se ha eliminado un PEDIDO con el ID:  4','2024-04-17 23:26:35',_binary ''),(790,'root@localhost','Delete','pedidos','Se ha eliminado un PEDIDO con el ID:  5','2024-04-17 23:26:35',_binary ''),(791,'root@localhost','Delete','pedidos','Se ha eliminado un PEDIDO con el ID:  6','2024-04-17 23:26:35',_binary ''),(792,'root@localhost','Delete','pedidos','Se ha eliminado un PEDIDO con el ID:  7','2024-04-17 23:26:35',_binary ''),(793,'root@localhost','Delete','pedidos','Se ha eliminado un PEDIDO con el ID:  8','2024-04-17 23:26:35',_binary ''),(794,'root@localhost','Delete','pedidos','Se ha eliminado un PEDIDO con el ID:  9','2024-04-17 23:26:35',_binary ''),(795,'root@localhost','Delete','pedidos','Se ha eliminado un PEDIDO con el ID:  10','2024-04-17 23:26:35',_binary ''),(796,'root@localhost','Delete','pedidos','Se ha eliminado un PEDIDO con el ID:  11','2024-04-17 23:26:35',_binary ''),(797,'root@localhost','Delete','pedidos','Se ha eliminado un PEDIDO con el ID:  12','2024-04-17 23:26:35',_binary ''),(798,'root@localhost','Delete','pedidos','Se ha eliminado un PEDIDO con el ID:  13','2024-04-17 23:26:35',_binary ''),(799,'root@localhost','Delete','pedidos','Se ha eliminado un PEDIDO con el ID:  14','2024-04-17 23:26:35',_binary ''),(800,'root@localhost','Delete','pedidos','Se ha eliminado un PEDIDO con el ID:  15','2024-04-17 23:26:35',_binary ''),(801,'root@localhost','Delete','pedidos','Se ha eliminado un PEDIDO con el ID:  16','2024-04-17 23:26:35',_binary ''),(802,'root@localhost','Delete','pedidos','Se ha eliminado un PEDIDO con el ID:  17','2024-04-17 23:26:35',_binary ''),(803,'root@localhost','Delete','pedidos','Se ha eliminado un PEDIDO con el ID:  18','2024-04-17 23:26:35',_binary ''),(804,'root@localhost','Delete','pedidos','Se ha eliminado un PEDIDO con el ID:  19','2024-04-17 23:26:35',_binary ''),(805,'root@localhost','Delete','pedidos','Se ha eliminado un PEDIDO con el ID:  20','2024-04-17 23:26:35',_binary ''),(806,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  1','2024-04-17 23:26:35',_binary ''),(807,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  2','2024-04-17 23:26:35',_binary ''),(808,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  3','2024-04-17 23:26:35',_binary ''),(809,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  4','2024-04-17 23:26:35',_binary ''),(810,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  5','2024-04-17 23:26:35',_binary ''),(811,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  6','2024-04-17 23:26:35',_binary ''),(812,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  7','2024-04-17 23:26:35',_binary ''),(813,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  8','2024-04-17 23:26:35',_binary ''),(814,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  9','2024-04-17 23:26:35',_binary ''),(815,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  10','2024-04-17 23:26:35',_binary ''),(816,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  11','2024-04-17 23:26:35',_binary ''),(817,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  12','2024-04-17 23:26:35',_binary ''),(818,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  13','2024-04-17 23:26:35',_binary ''),(819,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  14','2024-04-17 23:26:35',_binary ''),(820,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  15','2024-04-17 23:26:35',_binary ''),(821,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  16','2024-04-17 23:26:35',_binary ''),(822,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  17','2024-04-17 23:26:35',_binary ''),(823,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  18','2024-04-17 23:26:35',_binary ''),(824,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  19','2024-04-17 23:26:35',_binary ''),(825,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  20','2024-04-17 23:26:35',_binary ''),(826,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  21','2024-04-17 23:26:35',_binary ''),(827,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  22','2024-04-17 23:26:35',_binary ''),(828,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  23','2024-04-17 23:26:35',_binary ''),(829,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  24','2024-04-17 23:26:35',_binary ''),(830,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  25','2024-04-17 23:26:35',_binary ''),(831,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  26','2024-04-17 23:26:35',_binary ''),(832,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  27','2024-04-17 23:26:35',_binary ''),(833,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  28','2024-04-17 23:26:35',_binary ''),(834,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  29','2024-04-17 23:26:35',_binary ''),(835,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  30','2024-04-17 23:26:35',_binary ''),(836,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  31','2024-04-17 23:26:35',_binary ''),(837,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  32','2024-04-17 23:26:35',_binary ''),(838,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  33','2024-04-17 23:26:35',_binary ''),(839,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  34','2024-04-17 23:26:35',_binary ''),(840,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  35','2024-04-17 23:26:35',_binary ''),(841,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  36','2024-04-17 23:26:35',_binary ''),(842,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  37','2024-04-17 23:26:35',_binary ''),(843,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  38','2024-04-17 23:26:35',_binary ''),(844,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  39','2024-04-17 23:26:35',_binary ''),(845,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  40','2024-04-17 23:26:35',_binary ''),(846,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  11','2024-04-17 23:26:35',_binary ''),(847,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  12','2024-04-17 23:26:35',_binary ''),(848,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  13','2024-04-17 23:26:35',_binary ''),(849,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  14','2024-04-17 23:26:35',_binary ''),(850,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  15','2024-04-17 23:26:35',_binary ''),(851,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  16','2024-04-17 23:26:35',_binary ''),(852,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  17','2024-04-17 23:26:35',_binary ''),(853,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  18','2024-04-17 23:26:35',_binary ''),(854,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  19','2024-04-17 23:26:35',_binary ''),(855,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  20','2024-04-17 23:26:35',_binary ''),(856,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  21','2024-04-17 23:26:35',_binary ''),(857,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  22','2024-04-17 23:26:35',_binary ''),(858,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  23','2024-04-17 23:26:35',_binary ''),(859,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  24','2024-04-17 23:26:35',_binary ''),(860,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  25','2024-04-17 23:26:35',_binary ''),(861,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  26','2024-04-17 23:26:35',_binary ''),(862,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  27','2024-04-17 23:26:35',_binary ''),(863,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  28','2024-04-17 23:26:35',_binary ''),(864,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  29','2024-04-17 23:26:35',_binary ''),(865,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  30','2024-04-17 23:26:35',_binary ''),(866,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  31','2024-04-17 23:26:35',_binary ''),(867,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  32','2024-04-17 23:26:35',_binary ''),(868,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  33','2024-04-17 23:26:35',_binary ''),(869,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  34','2024-04-17 23:26:35',_binary ''),(870,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  35','2024-04-17 23:26:35',_binary ''),(871,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  36','2024-04-17 23:26:35',_binary ''),(872,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  37','2024-04-17 23:26:35',_binary ''),(873,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  38','2024-04-17 23:26:35',_binary ''),(874,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  39','2024-04-17 23:26:35',_binary ''),(875,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  40','2024-04-17 23:26:35',_binary ''),(876,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  1','2024-04-17 23:26:35',_binary ''),(877,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  2','2024-04-17 23:26:35',_binary ''),(878,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  3','2024-04-17 23:26:35',_binary ''),(879,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  4','2024-04-17 23:26:35',_binary ''),(880,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  5','2024-04-17 23:26:35',_binary ''),(881,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  6','2024-04-17 23:26:35',_binary ''),(882,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  7','2024-04-17 23:26:35',_binary ''),(883,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  8','2024-04-17 23:26:35',_binary ''),(884,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  9','2024-04-17 23:26:35',_binary ''),(885,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  10','2024-04-17 23:26:35',_binary ''),(886,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  11','2024-04-17 23:26:35',_binary ''),(887,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  12','2024-04-17 23:26:35',_binary ''),(888,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  13','2024-04-17 23:26:35',_binary ''),(889,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  14','2024-04-17 23:26:35',_binary ''),(890,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  15','2024-04-17 23:26:35',_binary ''),(891,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  16','2024-04-17 23:26:35',_binary ''),(892,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  17','2024-04-17 23:26:35',_binary ''),(893,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  18','2024-04-17 23:26:35',_binary ''),(894,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  19','2024-04-17 23:26:35',_binary ''),(895,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  20','2024-04-17 23:26:35',_binary ''),(896,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  21','2024-04-17 23:26:35',_binary ''),(897,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  22','2024-04-17 23:26:35',_binary ''),(898,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  23','2024-04-17 23:26:35',_binary ''),(899,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  24','2024-04-17 23:26:35',_binary ''),(900,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  25','2024-04-17 23:26:35',_binary ''),(901,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  26','2024-04-17 23:26:35',_binary ''),(902,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  27','2024-04-17 23:26:35',_binary ''),(903,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  28','2024-04-17 23:26:35',_binary ''),(904,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  29','2024-04-17 23:26:35',_binary ''),(905,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  30','2024-04-17 23:26:35',_binary ''),(906,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  31','2024-04-17 23:26:35',_binary ''),(907,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  32','2024-04-17 23:26:35',_binary ''),(908,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  33','2024-04-17 23:26:35',_binary ''),(909,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  34','2024-04-17 23:26:35',_binary ''),(910,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  35','2024-04-17 23:26:35',_binary ''),(911,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  36','2024-04-17 23:26:35',_binary ''),(912,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  37','2024-04-17 23:26:35',_binary ''),(913,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  38','2024-04-17 23:26:35',_binary ''),(914,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  39','2024-04-17 23:26:35',_binary ''),(915,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  40','2024-04-17 23:26:35',_binary ''),(916,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  1 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Juan PRIMER APELLIDO =  Vázquez SEGUNDO APELLIDO =  Morales FECHA NACIMIENTO =  1978-07-28 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  A- ESTATUS =   FECHA REGISTRO =  2024-04-04 11:02:56 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:44',_binary ''),(917,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  2 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Paola PRIMER APELLIDO =  Gutiérrez SEGUNDO APELLIDO =  Medina FECHA NACIMIENTO =  1978-06-07 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  O+ ESTATUS =   FECHA REGISTRO =  2020-10-01 11:11:14 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:44',_binary ''),(918,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  3 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Edgar PRIMER APELLIDO =  Luna SEGUNDO APELLIDO =  Pérez FECHA NACIMIENTO =  1961-02-04 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  O+ ESTATUS =   FECHA REGISTRO =  2020-06-06 19:42:41 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:44',_binary ''),(919,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  4 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Luz PRIMER APELLIDO =  Álvarez SEGUNDO APELLIDO =  Gutiérrez FECHA NACIMIENTO =  1973-12-08 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  B+ ESTATUS =   FECHA REGISTRO =  2024-02-08 16:00:07 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:44',_binary ''),(920,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  5 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Gustavo PRIMER APELLIDO =  Ruíz SEGUNDO APELLIDO =  López FECHA NACIMIENTO =  1969-05-05 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  O+ ESTATUS =   FECHA REGISTRO =  2022-01-13 18:59:06 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:44',_binary ''),(921,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  6 con los siguientes datos:  TITULO CORTESIA =  Sgto. NOMBRE= Adalid PRIMER APELLIDO =  De la Cruz SEGUNDO APELLIDO =  Luna FECHA NACIMIENTO =  2003-08-11 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  O- ESTATUS =   FECHA REGISTRO =  2020-01-07 10:17:05 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:44',_binary ''),(922,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  7 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Carlos PRIMER APELLIDO =  Medina SEGUNDO APELLIDO =  Hernández FECHA NACIMIENTO =  1959-11-07 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  A+ ESTATUS =   FECHA REGISTRO =  2024-03-29 19:05:22 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:44',_binary ''),(923,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  8 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Estrella PRIMER APELLIDO =  Méndez SEGUNDO APELLIDO =  Santiago FECHA NACIMIENTO =  2000-03-28 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  B- ESTATUS =   FECHA REGISTRO =  2023-11-09 08:33:03 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:44',_binary ''),(924,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  9 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Luz PRIMER APELLIDO =  Estrada SEGUNDO APELLIDO =  Jiménez FECHA NACIMIENTO =  1995-04-30 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  O+ ESTATUS =   FECHA REGISTRO =  2022-08-29 17:36:08 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:44',_binary ''),(925,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  10 con los siguientes datos:  TITULO CORTESIA =  Sr. NOMBRE= Federico PRIMER APELLIDO =  Velázquez SEGUNDO APELLIDO =  Jiménez FECHA NACIMIENTO =  1971-04-02 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  B+ ESTATUS =   FECHA REGISTRO =  2022-11-25 14:23:36 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:44',_binary ''),(926,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  11 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Lorena PRIMER APELLIDO =  Ruíz SEGUNDO APELLIDO =  Santiago FECHA NACIMIENTO =  1969-12-24 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  B- ESTATUS =   FECHA REGISTRO =  2022-07-04 14:53:38 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:44',_binary ''),(927,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  12 con los siguientes datos:  TITULO CORTESIA =  Sra. NOMBRE= Paola PRIMER APELLIDO =  Gómes SEGUNDO APELLIDO =   González FECHA NACIMIENTO =  1998-01-25 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  AB- ESTATUS =   FECHA REGISTRO =  2024-01-14 16:31:10 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:44',_binary ''),(928,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  13 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Bertha PRIMER APELLIDO =   Rivera SEGUNDO APELLIDO =  Domínguez FECHA NACIMIENTO =  1982-10-26 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  B- ESTATUS =   FECHA REGISTRO =  2023-06-29 16:33:41 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:44',_binary ''),(929,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  14 con los siguientes datos:  TITULO CORTESIA =  Sr. NOMBRE= Juan PRIMER APELLIDO =  García SEGUNDO APELLIDO =  Santiago FECHA NACIMIENTO =  1977-11-06 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  A- ESTATUS =   FECHA REGISTRO =  2020-01-03 11:55:00 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:44',_binary ''),(930,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  15 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Fernando PRIMER APELLIDO =  Cortés SEGUNDO APELLIDO =  Cortes FECHA NACIMIENTO =  1967-05-11 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  A- ESTATUS =   FECHA REGISTRO =  2021-06-21 10:32:57 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:44',_binary ''),(931,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  16 con los siguientes datos:  TITULO CORTESIA =  Ing. NOMBRE= Suri PRIMER APELLIDO =  Ramírez SEGUNDO APELLIDO =  Díaz FECHA NACIMIENTO =  1972-11-06 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  B+ ESTATUS =   FECHA REGISTRO =  2023-02-08 16:12:49 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:44',_binary ''),(932,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  17 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Gerardo PRIMER APELLIDO =  Contreras SEGUNDO APELLIDO =  Cruz FECHA NACIMIENTO =  1985-12-29 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  A- ESTATUS =   FECHA REGISTRO =  2020-03-13 17:51:51 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:44',_binary ''),(933,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  18 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Juan PRIMER APELLIDO =  López SEGUNDO APELLIDO =  Cruz FECHA NACIMIENTO =  1996-03-30 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  A- ESTATUS =   FECHA REGISTRO =  2023-01-29 19:57:06 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:44',_binary ''),(934,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  19 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Gerardo PRIMER APELLIDO =  Pérez SEGUNDO APELLIDO =  Chávez FECHA NACIMIENTO =  1984-06-07 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  O+ ESTATUS =   FECHA REGISTRO =  2023-07-06 13:40:47 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:44',_binary ''),(935,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  20 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Marco PRIMER APELLIDO =  Juárez SEGUNDO APELLIDO =  Hernández FECHA NACIMIENTO =  1969-12-27 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  A+ ESTATUS =   FECHA REGISTRO =  2022-11-06 09:30:43 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:44',_binary ''),(936,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  21 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Suri PRIMER APELLIDO =  Moreno SEGUNDO APELLIDO =  Velázquez FECHA NACIMIENTO =  1983-04-14 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  A+ ESTATUS =   FECHA REGISTRO =  2020-05-31 09:43:51 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:44',_binary ''),(937,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  22 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Karla PRIMER APELLIDO =  Aguilar SEGUNDO APELLIDO =  Cruz FECHA NACIMIENTO =  1992-08-26 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  O+ ESTATUS =   FECHA REGISTRO =  2020-04-02 17:59:39 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:44',_binary ''),(938,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  23 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Gustavo PRIMER APELLIDO =  Guerrero SEGUNDO APELLIDO =  De la Cruz FECHA NACIMIENTO =  1969-03-14 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  AB- ESTATUS =   FECHA REGISTRO =  2023-01-08 14:21:51 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:44',_binary ''),(939,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  24 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Daniel PRIMER APELLIDO =  Castillo SEGUNDO APELLIDO =  Méndez FECHA NACIMIENTO =  1974-02-15 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  O+ ESTATUS =   FECHA REGISTRO =  2021-05-01 08:13:51 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:44',_binary ''),(940,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  25 con los siguientes datos:  TITULO CORTESIA =  Mtra NOMBRE= Jazmin PRIMER APELLIDO =  Moreno SEGUNDO APELLIDO =  Velázquez FECHA NACIMIENTO =  1981-03-16 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  O- ESTATUS =   FECHA REGISTRO =  2021-07-12 19:31:37 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:44',_binary ''),(941,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  26 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Flor PRIMER APELLIDO =  Moreno SEGUNDO APELLIDO =  Martínez FECHA NACIMIENTO =  2002-01-16 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  A- ESTATUS =   FECHA REGISTRO =  2021-04-10 19:12:29 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:44',_binary ''),(942,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  27 con los siguientes datos:  TITULO CORTESIA =  NOMBRE=  Agustin PRIMER APELLIDO =  Álvarez SEGUNDO APELLIDO =  Pérez FECHA NACIMIENTO =  2007-06-24 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  AB+ ESTATUS =   FECHA REGISTRO =  2024-04-11 10:32:29 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:44',_binary ''),(943,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  28 con los siguientes datos:  TITULO CORTESIA =  Mtra NOMBRE= Lucía PRIMER APELLIDO =  Salazar SEGUNDO APELLIDO =  Guzmán FECHA NACIMIENTO =  1970-06-09 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  O- ESTATUS =   FECHA REGISTRO =  2023-09-01 14:33:26 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:44',_binary ''),(944,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  29 con los siguientes datos:  TITULO CORTESIA =  Med. NOMBRE= Ricardo PRIMER APELLIDO =  Gutiérrez SEGUNDO APELLIDO =  Cortes FECHA NACIMIENTO =  2004-04-13 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  O- ESTATUS =   FECHA REGISTRO =  2020-05-15 14:19:09 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:44',_binary ''),(945,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  30 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Hugo PRIMER APELLIDO =  Salazar SEGUNDO APELLIDO =   González FECHA NACIMIENTO =  2006-07-12 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  AB+ ESTATUS =   FECHA REGISTRO =  2023-12-23 19:16:14 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:44',_binary ''),(946,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  31 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Luz PRIMER APELLIDO =  Gómes SEGUNDO APELLIDO =  Luna FECHA NACIMIENTO =  1987-08-17 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  B+ ESTATUS =   FECHA REGISTRO =  2023-08-05 10:52:00 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:44',_binary ''),(947,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  32 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Jazmin PRIMER APELLIDO =  Gutiérrez SEGUNDO APELLIDO =  Díaz FECHA NACIMIENTO =  1990-12-28 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  A- ESTATUS =   FECHA REGISTRO =  2024-01-30 10:35:11 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:44',_binary ''),(948,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  33 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Iram PRIMER APELLIDO =  Mendoza SEGUNDO APELLIDO =  Guzmán FECHA NACIMIENTO =  1984-09-23 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  B+ ESTATUS =   FECHA REGISTRO =  2020-05-31 13:52:12 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:44',_binary ''),(949,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  34 con los siguientes datos:  TITULO CORTESIA =  Sr. NOMBRE= Aldair PRIMER APELLIDO =  Salazar SEGUNDO APELLIDO =  Morales FECHA NACIMIENTO =  1996-06-16 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  A+ ESTATUS =   FECHA REGISTRO =  2023-12-07 13:32:35 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:44',_binary ''),(950,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  35 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Jesus PRIMER APELLIDO =   González SEGUNDO APELLIDO =  Soto FECHA NACIMIENTO =  1994-02-22 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  AB+ ESTATUS =   FECHA REGISTRO =  2023-03-20 08:10:11 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:44',_binary ''),(951,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  36 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Samuel PRIMER APELLIDO =  Ruíz SEGUNDO APELLIDO =  Cortes FECHA NACIMIENTO =  2002-03-10 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  AB- ESTATUS =   FECHA REGISTRO =  2020-02-21 19:36:42 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:44',_binary ''),(952,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  37 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Flor PRIMER APELLIDO =  Castillo SEGUNDO APELLIDO =   González FECHA NACIMIENTO =  2007-06-25 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  AB- ESTATUS =   FECHA REGISTRO =  2021-06-11 16:31:08 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:44',_binary ''),(953,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  38 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Ana PRIMER APELLIDO =  Castillo SEGUNDO APELLIDO =  Vargas FECHA NACIMIENTO =  1967-01-25 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  AB+ ESTATUS =   FECHA REGISTRO =  2022-08-05 10:03:05 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:44',_binary ''),(954,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  39 con los siguientes datos:  TITULO CORTESIA =  Mtra NOMBRE= Sofia PRIMER APELLIDO =  López SEGUNDO APELLIDO =  Contreras FECHA NACIMIENTO =  1999-01-07 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  AB- ESTATUS =   FECHA REGISTRO =  2023-04-16 18:55:36 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:44',_binary ''),(955,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  40 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Valeria PRIMER APELLIDO =  Sánchez SEGUNDO APELLIDO =  Santiago FECHA NACIMIENTO =  2007-12-11 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  B+ ESTATUS =   FECHA REGISTRO =  2022-02-11 14:56:31 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:44',_binary ''),(956,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  41 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Jesus PRIMER APELLIDO =  Torres SEGUNDO APELLIDO =  Vázquez FECHA NACIMIENTO =  1975-03-23 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  O+ ESTATUS =   FECHA REGISTRO =  2020-07-29 10:27:10 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:44',_binary ''),(957,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  42 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Maximiliano PRIMER APELLIDO =  Mendoza SEGUNDO APELLIDO =  Torres FECHA NACIMIENTO =  1978-03-06 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  O- ESTATUS =   FECHA REGISTRO =  2022-10-06 12:03:29 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:44',_binary ''),(958,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  43 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Monica PRIMER APELLIDO =  Santiago SEGUNDO APELLIDO =  Romero FECHA NACIMIENTO =  2001-12-19 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  O+ ESTATUS =   FECHA REGISTRO =  2022-03-25 09:23:53 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:44',_binary ''),(959,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  44 con los siguientes datos:  TITULO CORTESIA =  C.P. NOMBRE= Paola PRIMER APELLIDO =  Sánchez SEGUNDO APELLIDO =  Chávez FECHA NACIMIENTO =  1981-02-26 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  AB+ ESTATUS =   FECHA REGISTRO =  2020-10-18 12:58:05 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:44',_binary ''),(960,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  45 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Juan PRIMER APELLIDO =  Ruíz SEGUNDO APELLIDO =  Velázquez FECHA NACIMIENTO =  1992-10-16 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  A+ ESTATUS =   FECHA REGISTRO =  2021-09-13 16:33:04 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:44',_binary ''),(961,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  46 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Hortencia PRIMER APELLIDO =  Méndez SEGUNDO APELLIDO =   González FECHA NACIMIENTO =  1997-10-05 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  AB- ESTATUS =   FECHA REGISTRO =  2024-04-02 19:18:52 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:44',_binary ''),(962,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  47 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Ameli PRIMER APELLIDO =  Castillo SEGUNDO APELLIDO =  De la Cruz FECHA NACIMIENTO =  1979-05-21 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  AB- ESTATUS =   FECHA REGISTRO =  2021-05-04 13:12:42 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:44',_binary ''),(963,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  48 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Monica PRIMER APELLIDO =  Guzmán SEGUNDO APELLIDO =  Castro FECHA NACIMIENTO =  1974-03-11 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  B- ESTATUS =   FECHA REGISTRO =  2020-03-25 09:04:05 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:44',_binary ''),(964,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  49 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Fernando PRIMER APELLIDO =   González SEGUNDO APELLIDO =  Guzmán FECHA NACIMIENTO =  1983-01-13 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  A- ESTATUS =   FECHA REGISTRO =  2021-05-25 09:55:28 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:44',_binary ''),(965,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  50 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Brenda PRIMER APELLIDO =  Contreras SEGUNDO APELLIDO =  De la Cruz FECHA NACIMIENTO =  1986-05-01 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  B+ ESTATUS =   FECHA REGISTRO =  2020-11-26 19:12:46 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:44',_binary ''),(966,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  51 con los siguientes datos:  TITULO CORTESIA =  C. NOMBRE= Pedro PRIMER APELLIDO =  Ortega SEGUNDO APELLIDO =  Pérez FECHA NACIMIENTO =  2004-02-01 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  A- ESTATUS =   FECHA REGISTRO =  2022-02-28 17:14:08 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:46',_binary ''),(967,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  51 con los siguientes datos:  NOMBRE USUARIO=  C. Pedro Ortega Pérez PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Offline ULTIMA CONEXIÓN =  2022-12-22 18:41:31','2024-04-17 23:26:46',_binary ''),(968,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  52 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Jazmin PRIMER APELLIDO =  Salazar SEGUNDO APELLIDO =  Medina FECHA NACIMIENTO =  2003-09-24 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  B- ESTATUS =   FECHA REGISTRO =  2023-01-06 08:41:23 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:46',_binary ''),(969,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  52 con los siguientes datos:  NOMBRE USUARIO=  Jazmin Salazar Medina PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Offline ULTIMA CONEXIÓN =  2023-03-31 16:46:45','2024-04-17 23:26:46',_binary ''),(970,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  53 con los siguientes datos:  TITULO CORTESIA =  Med. NOMBRE= Edgar PRIMER APELLIDO =  Velázquez SEGUNDO APELLIDO =  Guzmán FECHA NACIMIENTO =  1981-08-13 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  A+ ESTATUS =   FECHA REGISTRO =  2023-03-26 16:17:49 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:46',_binary ''),(971,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  53 con los siguientes datos:  NOMBRE USUARIO=  Med. Edgar Velázquez Guzmán PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Offline ULTIMA CONEXIÓN =  2023-06-11 19:03:58','2024-04-17 23:26:46',_binary ''),(972,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  54 con los siguientes datos:  TITULO CORTESIA =  Lic. NOMBRE= Adalid PRIMER APELLIDO =  Romero SEGUNDO APELLIDO =  Moreno FECHA NACIMIENTO =  1997-01-21 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  B- ESTATUS =   FECHA REGISTRO =  2024-03-05 13:52:57 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:46',_binary ''),(973,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  54 con los siguientes datos:  NOMBRE USUARIO=  Lic. Adalid Romero Moreno PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Offline ULTIMA CONEXIÓN =  2024-03-28 10:25:38','2024-04-17 23:26:46',_binary ''),(974,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  55 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Samuel PRIMER APELLIDO =  Gutiérrez SEGUNDO APELLIDO =   González FECHA NACIMIENTO =  1974-03-24 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  B+ ESTATUS =   FECHA REGISTRO =  2021-08-29 09:49:06 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:46',_binary ''),(975,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  55 con los siguientes datos:  NOMBRE USUARIO=  Samuel Gutiérrez  González PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Offline ULTIMA CONEXIÓN =  2023-03-28 14:27:16','2024-04-17 23:26:46',_binary ''),(976,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  56 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Guadalupe PRIMER APELLIDO =  Mendoza SEGUNDO APELLIDO =  Jiménez FECHA NACIMIENTO =  1972-11-19 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  B- ESTATUS =   FECHA REGISTRO =  2022-02-09 08:43:48 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:46',_binary ''),(977,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  56 con los siguientes datos:  NOMBRE USUARIO=  Guadalupe Mendoza Jiménez PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Offline ULTIMA CONEXIÓN =  2023-12-05 19:41:19','2024-04-17 23:26:46',_binary ''),(978,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  57 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Monica PRIMER APELLIDO =  Moreno SEGUNDO APELLIDO =  Díaz FECHA NACIMIENTO =  1974-07-28 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  AB+ ESTATUS =   FECHA REGISTRO =  2022-12-10 18:12:30 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:46',_binary ''),(979,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  57 con los siguientes datos:  NOMBRE USUARIO=  Monica Moreno Díaz PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Offline ULTIMA CONEXIÓN =  2023-03-18 13:22:12','2024-04-17 23:26:46',_binary ''),(980,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  58 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Karla PRIMER APELLIDO =  Martínez SEGUNDO APELLIDO =  Torres FECHA NACIMIENTO =  1981-08-15 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  B+ ESTATUS =   FECHA REGISTRO =  2020-08-22 18:02:19 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:46',_binary ''),(981,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  58 con los siguientes datos:  NOMBRE USUARIO=  Karla Martínez Torres PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Offline ULTIMA CONEXIÓN =  2023-04-30 09:59:01','2024-04-17 23:26:46',_binary ''),(982,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  59 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Suri PRIMER APELLIDO =  Rodríguez SEGUNDO APELLIDO =  Pérez FECHA NACIMIENTO =  1965-07-20 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  B+ ESTATUS =   FECHA REGISTRO =  2020-10-07 19:27:58 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:46',_binary ''),(983,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  59 con los siguientes datos:  NOMBRE USUARIO=  Suri Rodríguez Pérez PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Offline ULTIMA CONEXIÓN =  2021-08-15 12:07:43','2024-04-17 23:26:46',_binary ''),(984,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  60 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Paola PRIMER APELLIDO =  Castro SEGUNDO APELLIDO =  Moreno FECHA NACIMIENTO =  1967-02-27 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  B- ESTATUS =   FECHA REGISTRO =  2022-08-13 17:28:28 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:46',_binary ''),(985,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  60 con los siguientes datos:  NOMBRE USUARIO=  Paola Castro Moreno PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Offline ULTIMA CONEXIÓN =  2022-10-26 10:52:03','2024-04-17 23:26:46',_binary ''),(986,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  61 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Edgar PRIMER APELLIDO =  Pérez SEGUNDO APELLIDO =  Castillo FECHA NACIMIENTO =  1965-08-14 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  A- ESTATUS =   FECHA REGISTRO =  2022-02-03 18:56:46 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:46',_binary ''),(987,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  61 con los siguientes datos:  NOMBRE USUARIO=  Edgar Pérez Castillo PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Offline ULTIMA CONEXIÓN =  2022-04-23 17:04:41','2024-04-17 23:26:46',_binary ''),(988,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  62 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Adalid PRIMER APELLIDO =  Jiménez SEGUNDO APELLIDO =  Moreno FECHA NACIMIENTO =  1979-10-15 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  AB- ESTATUS =   FECHA REGISTRO =  2020-08-30 16:43:20 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:46',_binary ''),(989,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  62 con los siguientes datos:  NOMBRE USUARIO=  Adalid Jiménez Moreno PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Offline ULTIMA CONEXIÓN =  2021-04-13 16:04:59','2024-04-17 23:26:46',_binary ''),(990,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  63 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Edgar PRIMER APELLIDO =  Contreras SEGUNDO APELLIDO =  Guerrero FECHA NACIMIENTO =  1963-07-06 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  AB- ESTATUS =   FECHA REGISTRO =  2021-06-24 14:43:26 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:46',_binary ''),(991,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  63 con los siguientes datos:  NOMBRE USUARIO=  Edgar Contreras Guerrero PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Offline ULTIMA CONEXIÓN =  2023-08-23 09:56:17','2024-04-17 23:26:46',_binary ''),(992,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  64 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Aldair PRIMER APELLIDO =  García SEGUNDO APELLIDO =  Jiménez FECHA NACIMIENTO =  1980-07-08 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  A- ESTATUS =   FECHA REGISTRO =  2023-12-08 18:12:37 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:46',_binary ''),(993,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  64 con los siguientes datos:  NOMBRE USUARIO=  Aldair García Jiménez PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Offline ULTIMA CONEXIÓN =  2024-02-12 19:44:19','2024-04-17 23:26:46',_binary ''),(994,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  65 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Hortencia PRIMER APELLIDO =  Salazar SEGUNDO APELLIDO =  Ramos FECHA NACIMIENTO =  1988-08-18 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  A+ ESTATUS =   FECHA REGISTRO =  2023-07-06 16:36:54 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:46',_binary ''),(995,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  65 con los siguientes datos:  NOMBRE USUARIO=  Hortencia Salazar Ramos PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Offline ULTIMA CONEXIÓN =  2023-08-14 14:26:30','2024-04-17 23:26:46',_binary ''),(996,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  66 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Paula PRIMER APELLIDO =  Cruz SEGUNDO APELLIDO =  Torres FECHA NACIMIENTO =  1961-06-01 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  A- ESTATUS =   FECHA REGISTRO =  2020-05-02 15:59:33 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:46',_binary ''),(997,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  66 con los siguientes datos:  NOMBRE USUARIO=  Paula Cruz Torres PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Offline ULTIMA CONEXIÓN =  2020-09-17 13:45:35','2024-04-17 23:26:46',_binary ''),(998,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  67 con los siguientes datos:  TITULO CORTESIA =  Joven NOMBRE= Juan PRIMER APELLIDO =  Aguilar SEGUNDO APELLIDO =  Bautista FECHA NACIMIENTO =  1982-04-18 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  AB+ ESTATUS =   FECHA REGISTRO =  2020-06-18 08:21:41 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:46',_binary ''),(999,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  67 con los siguientes datos:  NOMBRE USUARIO=  Joven Juan Aguilar Bautista PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Offline ULTIMA CONEXIÓN =  2023-08-19 08:31:03','2024-04-17 23:26:46',_binary ''),(1000,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  68 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Hortencia PRIMER APELLIDO =  García SEGUNDO APELLIDO =  Méndez FECHA NACIMIENTO =  1991-04-10 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  AB+ ESTATUS =   FECHA REGISTRO =  2020-07-10 17:08:28 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:46',_binary ''),(1001,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  68 con los siguientes datos:  NOMBRE USUARIO=  Hortencia García Méndez PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Offline ULTIMA CONEXIÓN =  2022-03-12 19:09:20','2024-04-17 23:26:46',_binary ''),(1002,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  69 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Maria PRIMER APELLIDO =  Cortés SEGUNDO APELLIDO =  Juárez FECHA NACIMIENTO =  1968-04-16 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  A+ ESTATUS =   FECHA REGISTRO =  2023-03-24 14:52:58 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:46',_binary ''),(1003,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  69 con los siguientes datos:  NOMBRE USUARIO=  Maria Cortés Juárez PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Offline ULTIMA CONEXIÓN =  2023-11-19 12:15:05','2024-04-17 23:26:46',_binary ''),(1004,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  70 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Maria PRIMER APELLIDO =  Ramos SEGUNDO APELLIDO =  Bautista FECHA NACIMIENTO =  2001-10-06 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  B- ESTATUS =   FECHA REGISTRO =  2023-05-20 14:02:51 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:46',_binary ''),(1005,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  70 con los siguientes datos:  NOMBRE USUARIO=  Maria Ramos Bautista PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Offline ULTIMA CONEXIÓN =  2023-07-11 11:20:16','2024-04-17 23:26:46',_binary ''),(1006,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  71 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Esmeralda PRIMER APELLIDO =  Vargas SEGUNDO APELLIDO =  Herrera FECHA NACIMIENTO =  1967-09-07 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  O+ ESTATUS =   FECHA REGISTRO =  2022-11-06 17:42:03 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:46',_binary ''),(1007,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  71 con los siguientes datos:  NOMBRE USUARIO=  Esmeralda Vargas Herrera PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Offline ULTIMA CONEXIÓN =  2022-12-04 18:06:10','2024-04-17 23:26:46',_binary ''),(1008,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  72 con los siguientes datos:  TITULO CORTESIA =  Med. NOMBRE= Luz PRIMER APELLIDO =  Cortes SEGUNDO APELLIDO =  Herrera FECHA NACIMIENTO =  1996-06-08 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  O+ ESTATUS =   FECHA REGISTRO =  2022-06-23 14:52:39 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:46',_binary ''),(1009,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  72 con los siguientes datos:  NOMBRE USUARIO=  Med. Luz Cortes Herrera PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Offline ULTIMA CONEXIÓN =  2022-09-21 19:29:51','2024-04-17 23:26:46',_binary ''),(1010,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  73 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Juan PRIMER APELLIDO =  Morales SEGUNDO APELLIDO =  Martínez FECHA NACIMIENTO =  1982-02-28 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  A- ESTATUS =   FECHA REGISTRO =  2022-05-19 10:22:48 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:46',_binary ''),(1011,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  73 con los siguientes datos:  NOMBRE USUARIO=  Juan Morales Martínez PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Offline ULTIMA CONEXIÓN =  2023-01-04 08:36:26','2024-04-17 23:26:46',_binary ''),(1012,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  74 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Pedro PRIMER APELLIDO =  Santiago SEGUNDO APELLIDO =  Gómes FECHA NACIMIENTO =  1982-10-20 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  AB- ESTATUS =   FECHA REGISTRO =  2020-02-18 08:53:01 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:46',_binary ''),(1013,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  74 con los siguientes datos:  NOMBRE USUARIO=  Pedro Santiago Gómes PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Offline ULTIMA CONEXIÓN =  2021-04-10 09:49:34','2024-04-17 23:26:46',_binary ''),(1014,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  75 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Hugo PRIMER APELLIDO =  Cortés SEGUNDO APELLIDO =  Santiago FECHA NACIMIENTO =  1984-07-08 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  O- ESTATUS =   FECHA REGISTRO =  2024-03-22 10:23:50 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:46',_binary ''),(1015,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  75 con los siguientes datos:  NOMBRE USUARIO=  Hugo Cortés Santiago PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Offline ULTIMA CONEXIÓN =  2024-03-23 15:45:09','2024-04-17 23:26:46',_binary ''),(1016,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  76 con los siguientes datos:  TITULO CORTESIA =  Sr. NOMBRE= Gustavo PRIMER APELLIDO =  Contreras SEGUNDO APELLIDO =  Torres FECHA NACIMIENTO =  1970-04-29 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  A- ESTATUS =   FECHA REGISTRO =  2024-02-25 13:21:47 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:46',_binary ''),(1017,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  76 con los siguientes datos:  NOMBRE USUARIO=  Sr. Gustavo Contreras Torres PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Offline ULTIMA CONEXIÓN =  2024-03-13 12:01:51','2024-04-17 23:26:46',_binary ''),(1018,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  77 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Iram PRIMER APELLIDO =  Contreras SEGUNDO APELLIDO =  Guzmán FECHA NACIMIENTO =  1973-03-07 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  A- ESTATUS =   FECHA REGISTRO =  2020-02-20 15:35:18 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:46',_binary ''),(1019,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  77 con los siguientes datos:  NOMBRE USUARIO=  Iram Contreras Guzmán PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Offline ULTIMA CONEXIÓN =  2020-05-28 13:06:43','2024-04-17 23:26:46',_binary ''),(1020,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  78 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Ricardo PRIMER APELLIDO =  Contreras SEGUNDO APELLIDO =  Castillo FECHA NACIMIENTO =  2005-09-27 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  B+ ESTATUS =   FECHA REGISTRO =  2022-09-18 11:17:36 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:46',_binary ''),(1021,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  78 con los siguientes datos:  NOMBRE USUARIO=  Ricardo Contreras Castillo PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Offline ULTIMA CONEXIÓN =  2023-06-20 14:42:29','2024-04-17 23:26:46',_binary ''),(1022,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  79 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= José PRIMER APELLIDO =  Luna SEGUNDO APELLIDO =  Gómes FECHA NACIMIENTO =  1991-07-26 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  AB+ ESTATUS =   FECHA REGISTRO =  2023-12-22 18:36:47 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:46',_binary ''),(1023,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  79 con los siguientes datos:  NOMBRE USUARIO=  José Luna Gómes PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Offline ULTIMA CONEXIÓN =  2024-03-07 14:59:31','2024-04-17 23:26:46',_binary ''),(1024,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  80 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Aldair PRIMER APELLIDO =  Ortega SEGUNDO APELLIDO =  Mendoza FECHA NACIMIENTO =  1980-07-11 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  O- ESTATUS =   FECHA REGISTRO =  2021-12-07 12:48:53 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:46',_binary ''),(1025,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  80 con los siguientes datos:  NOMBRE USUARIO=  Aldair Ortega Mendoza PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Offline ULTIMA CONEXIÓN =  2023-06-25 08:52:32','2024-04-17 23:26:46',_binary ''),(1026,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  81 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Monica PRIMER APELLIDO =  López SEGUNDO APELLIDO =  Jiménez FECHA NACIMIENTO =  1977-10-19 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  O- ESTATUS =   FECHA REGISTRO =  2022-04-18 18:28:29 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:46',_binary ''),(1027,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  81 con los siguientes datos:  NOMBRE USUARIO=  Monica López Jiménez PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Offline ULTIMA CONEXIÓN =  2023-10-25 10:11:48','2024-04-17 23:26:46',_binary ''),(1028,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  82 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Ameli PRIMER APELLIDO =  Ramírez SEGUNDO APELLIDO =  Morales FECHA NACIMIENTO =  1995-03-01 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  O- ESTATUS =   FECHA REGISTRO =  2021-06-02 19:13:50 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:46',_binary ''),(1029,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  82 con los siguientes datos:  NOMBRE USUARIO=  Ameli Ramírez Morales PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Offline ULTIMA CONEXIÓN =  2023-05-26 15:36:30','2024-04-17 23:26:46',_binary ''),(1030,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  83 con los siguientes datos:  TITULO CORTESIA =  C.P. NOMBRE= Dulce PRIMER APELLIDO =  Jiménez SEGUNDO APELLIDO =   González FECHA NACIMIENTO =  1987-10-21 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  AB+ ESTATUS =   FECHA REGISTRO =  2021-04-22 16:19:03 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:46',_binary ''),(1031,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  83 con los siguientes datos:  NOMBRE USUARIO=  C.P. Dulce Jiménez  González PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Offline ULTIMA CONEXIÓN =  2022-12-15 16:09:07','2024-04-17 23:26:46',_binary ''),(1032,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  84 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Dulce PRIMER APELLIDO =   Rivera SEGUNDO APELLIDO =  Ramos FECHA NACIMIENTO =  1976-08-03 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  O- ESTATUS =   FECHA REGISTRO =  2021-05-15 19:36:20 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:46',_binary ''),(1033,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  84 con los siguientes datos:  NOMBRE USUARIO=  Dulce  Rivera Ramos PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Offline ULTIMA CONEXIÓN =  2023-12-11 13:56:53','2024-04-17 23:26:46',_binary ''),(1034,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  85 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Maria PRIMER APELLIDO =   González SEGUNDO APELLIDO =  Díaz FECHA NACIMIENTO =  1981-10-08 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  A- ESTATUS =   FECHA REGISTRO =  2023-07-16 12:46:46 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:46',_binary ''),(1035,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  85 con los siguientes datos:  NOMBRE USUARIO=  Maria  González Díaz PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Offline ULTIMA CONEXIÓN =  2023-12-07 12:54:02','2024-04-17 23:26:46',_binary ''),(1036,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  86 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Mario PRIMER APELLIDO =  Domínguez SEGUNDO APELLIDO =  Estrada FECHA NACIMIENTO =  1994-06-15 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  O+ ESTATUS =   FECHA REGISTRO =  2023-06-27 16:09:36 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:46',_binary ''),(1037,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  86 con los siguientes datos:  NOMBRE USUARIO=  Mario Domínguez Estrada PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Offline ULTIMA CONEXIÓN =  2024-04-07 17:24:33','2024-04-17 23:26:46',_binary ''),(1038,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  87 con los siguientes datos:  TITULO CORTESIA =  C.P. NOMBRE= Brenda PRIMER APELLIDO =  Cruz SEGUNDO APELLIDO =  Vargas FECHA NACIMIENTO =  1965-06-10 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  B- ESTATUS =   FECHA REGISTRO =  2023-04-09 14:16:46 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:46',_binary ''),(1039,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  87 con los siguientes datos:  NOMBRE USUARIO=  C.P. Brenda Cruz Vargas PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Offline ULTIMA CONEXIÓN =  2023-08-11 09:08:06','2024-04-17 23:26:46',_binary ''),(1040,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  88 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Marco PRIMER APELLIDO =  Contreras SEGUNDO APELLIDO =  Martínez FECHA NACIMIENTO =  1997-02-13 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  AB- ESTATUS =   FECHA REGISTRO =  2021-04-09 11:44:46 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:46',_binary ''),(1041,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  88 con los siguientes datos:  NOMBRE USUARIO=  Marco Contreras Martínez PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Offline ULTIMA CONEXIÓN =  2023-04-23 13:09:38','2024-04-17 23:26:46',_binary ''),(1042,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  89 con los siguientes datos:  TITULO CORTESIA =  Lic. NOMBRE= Marco PRIMER APELLIDO =  Guzmán SEGUNDO APELLIDO =  Velázquez FECHA NACIMIENTO =  1988-12-30 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  AB- ESTATUS =   FECHA REGISTRO =  2023-01-26 13:27:43 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:46',_binary ''),(1043,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  89 con los siguientes datos:  NOMBRE USUARIO=  Lic. Marco Guzmán Velázquez PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Offline ULTIMA CONEXIÓN =  2023-03-25 11:26:56','2024-04-17 23:26:46',_binary ''),(1044,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  90 con los siguientes datos:  TITULO CORTESIA =  Sgto. NOMBRE= Hugo PRIMER APELLIDO =  Juárez SEGUNDO APELLIDO =  López FECHA NACIMIENTO =  1985-09-07 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  B- ESTATUS =   FECHA REGISTRO =  2022-12-15 08:41:16 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:46',_binary ''),(1045,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  90 con los siguientes datos:  NOMBRE USUARIO=  Sgto. Hugo Juárez López PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Offline ULTIMA CONEXIÓN =  2023-04-03 19:18:34','2024-04-17 23:26:46',_binary ''),(1046,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  91 con los siguientes datos:  TITULO CORTESIA =  C. NOMBRE= Samuel PRIMER APELLIDO =  Gómes SEGUNDO APELLIDO =  Gutiérrez FECHA NACIMIENTO =  1964-01-29 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  B- ESTATUS =   FECHA REGISTRO =  2023-02-10 12:55:18 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:46',_binary ''),(1047,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  91 con los siguientes datos:  NOMBRE USUARIO=  C. Samuel Gómes Gutiérrez PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Offline ULTIMA CONEXIÓN =  2024-02-25 09:56:44','2024-04-17 23:26:46',_binary ''),(1048,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  92 con los siguientes datos:  TITULO CORTESIA =  Lic. NOMBRE= Samuel PRIMER APELLIDO =  Mendoza SEGUNDO APELLIDO =  Cortes FECHA NACIMIENTO =  2001-11-09 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  AB- ESTATUS =   FECHA REGISTRO =  2023-10-13 11:44:34 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:46',_binary ''),(1049,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  92 con los siguientes datos:  NOMBRE USUARIO=  Lic. Samuel Mendoza Cortes PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Offline ULTIMA CONEXIÓN =  2024-04-02 15:48:26','2024-04-17 23:26:46',_binary ''),(1050,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  93 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Ana PRIMER APELLIDO =  Herrera SEGUNDO APELLIDO =   Rivera FECHA NACIMIENTO =  2001-12-08 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  AB+ ESTATUS =   FECHA REGISTRO =  2021-11-27 12:38:00 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:46',_binary ''),(1051,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  93 con los siguientes datos:  NOMBRE USUARIO=  Ana Herrera  Rivera PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Offline ULTIMA CONEXIÓN =  2023-05-04 18:03:21','2024-04-17 23:26:46',_binary ''),(1052,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  94 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Juan PRIMER APELLIDO =  Bautista SEGUNDO APELLIDO =  Méndez FECHA NACIMIENTO =  2005-07-10 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  A+ ESTATUS =   FECHA REGISTRO =  2021-10-15 19:13:01 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:46',_binary ''),(1053,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  94 con los siguientes datos:  NOMBRE USUARIO=  Juan Bautista Méndez PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Offline ULTIMA CONEXIÓN =  2022-11-07 11:47:23','2024-04-17 23:26:46',_binary ''),(1054,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  95 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Lorena PRIMER APELLIDO =  Torres SEGUNDO APELLIDO =  Chávez FECHA NACIMIENTO =  2000-04-02 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  B- ESTATUS =   FECHA REGISTRO =  2024-03-19 12:56:21 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:46',_binary ''),(1055,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  95 con los siguientes datos:  NOMBRE USUARIO=  Lorena Torres Chávez PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Offline ULTIMA CONEXIÓN =  2024-03-22 12:05:24','2024-04-17 23:26:46',_binary ''),(1056,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  96 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Flor PRIMER APELLIDO =   Rivera SEGUNDO APELLIDO =  Juárez FECHA NACIMIENTO =  1974-02-28 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  AB- ESTATUS =   FECHA REGISTRO =  2021-11-18 10:11:13 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:46',_binary ''),(1057,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  96 con los siguientes datos:  NOMBRE USUARIO=  Flor  Rivera Juárez PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Offline ULTIMA CONEXIÓN =  2023-04-27 13:13:12','2024-04-17 23:26:46',_binary ''),(1058,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  97 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Esmeralda PRIMER APELLIDO =  Bautista SEGUNDO APELLIDO =  Santiago FECHA NACIMIENTO =  1989-04-12 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  B+ ESTATUS =   FECHA REGISTRO =  2024-04-01 18:12:42 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:46',_binary ''),(1059,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  97 con los siguientes datos:  NOMBRE USUARIO=  Esmeralda Bautista Santiago PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Offline ULTIMA CONEXIÓN =  2024-04-05 18:36:01','2024-04-17 23:26:46',_binary ''),(1060,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  98 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Daniel PRIMER APELLIDO =  Aguilar SEGUNDO APELLIDO =  Morales FECHA NACIMIENTO =  2006-09-12 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  A+ ESTATUS =   FECHA REGISTRO =  2022-05-08 13:35:14 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:46',_binary ''),(1061,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  98 con los siguientes datos:  NOMBRE USUARIO=  Daniel Aguilar Morales PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Offline ULTIMA CONEXIÓN =  2023-09-08 08:27:17','2024-04-17 23:26:46',_binary ''),(1062,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  99 con los siguientes datos:  TITULO CORTESIA =  Dra. NOMBRE= Brenda PRIMER APELLIDO =  Salazar SEGUNDO APELLIDO =  Bautista FECHA NACIMIENTO =  1971-06-09 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  B- ESTATUS =   FECHA REGISTRO =  2021-05-12 12:11:09 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:46',_binary ''),(1063,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  99 con los siguientes datos:  NOMBRE USUARIO=  Dra. Brenda Salazar Bautista PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Offline ULTIMA CONEXIÓN =  2023-09-09 19:01:23','2024-04-17 23:26:46',_binary ''),(1064,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  100 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Samuel PRIMER APELLIDO =  Medina SEGUNDO APELLIDO =  Medina FECHA NACIMIENTO =  1978-06-10 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  O+ ESTATUS =   FECHA REGISTRO =  2020-09-15 10:40:07 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:46',_binary ''),(1065,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  100 con los siguientes datos:  NOMBRE USUARIO=  Samuel Medina Medina PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Offline ULTIMA CONEXIÓN =  2022-12-03 13:01:14','2024-04-17 23:26:46',_binary ''),(1066,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  1 con los siguientes datos:  NOMBRE =  Barritas energéticas MARCA =  MuscleFlow PRECIO ACTUAL =  10.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:47',_binary ''),(1067,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  2 con los siguientes datos:  NOMBRE =  Barritas energéticas MARCA =  FlexiLoop PRECIO ACTUAL =  10.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:47',_binary ''),(1068,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  3 con los siguientes datos:  NOMBRE =  Bloque de espuma para estiramientos MARCA =  SpeedGrip PRECIO ACTUAL =  60.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:47',_binary ''),(1069,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  4 con los siguientes datos:  NOMBRE =  Suplemento de creatina MARCA =  PowerProtein PRECIO ACTUAL =  70.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:47',_binary ''),(1070,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  5 con los siguientes datos:  NOMBRE =  Bebida energética pre-entrenamiento MARCA =  FlexiBlock PRECIO ACTUAL =  90.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:47',_binary ''),(1071,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  6 con los siguientes datos:  NOMBRE =  Suplemento de creatina MARCA =  MuscleRecover PRECIO ACTUAL =  30.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:47',_binary ''),(1072,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  7 con los siguientes datos:  NOMBRE =  Barritas energéticas MARCA =  FlexiMat PRECIO ACTUAL =  20.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:47',_binary ''),(1073,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  8 con los siguientes datos:  NOMBRE =  Banda elástica para ejercicios de resistencia MARCA =  StaminaBoost PRECIO ACTUAL =  30.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:47',_binary ''),(1074,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  9 con los siguientes datos:  NOMBRE =  Barritas energéticas MARCA =  FlexiRoll PRECIO ACTUAL =  20.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:47',_binary ''),(1075,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  10 con los siguientes datos:  NOMBRE =  Esterilla de yoga MARCA =  PowerPulse PRECIO ACTUAL =  50.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:47',_binary ''),(1076,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  11 con los siguientes datos:  NOMBRE =  Barritas energéticas MARCA =  MuscleFlow PRECIO ACTUAL =  100.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:47',_binary ''),(1077,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  12 con los siguientes datos:  NOMBRE =  Bebida energética pre-entrenamiento MARCA =  MuscleEase PRECIO ACTUAL =  60.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:47',_binary ''),(1078,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  13 con los siguientes datos:  NOMBRE =  Barritas energéticas MARCA =  PowerBurn PRECIO ACTUAL =  80.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:47',_binary ''),(1079,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  14 con los siguientes datos:  NOMBRE =  Cinturón de levantamiento de pesas MARCA =  FlexiBottle PRECIO ACTUAL =  100.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:47',_binary ''),(1080,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  15 con los siguientes datos:  NOMBRE =  Bebida energética post-entrenamiento MARCA =  SpeedWrap PRECIO ACTUAL =  70.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:47',_binary ''),(1081,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  16 con los siguientes datos:  NOMBRE =  Suplemento de creatina MARCA =  MusclePatch PRECIO ACTUAL =  10.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:47',_binary ''),(1082,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  17 con los siguientes datos:  NOMBRE =  Bebida energética pre-entrenamiento MARCA =  SpeedStep PRECIO ACTUAL =  30.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:47',_binary ''),(1083,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  18 con los siguientes datos:  NOMBRE =  Correa de estiramiento MARCA =  FlexiSqueeze PRECIO ACTUAL =  40.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:47',_binary ''),(1084,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  19 con los siguientes datos:  NOMBRE =  Cinturón de levantamiento de pesas MARCA =  FlexiRing PRECIO ACTUAL =  60.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:47',_binary ''),(1085,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  20 con los siguientes datos:  NOMBRE =  Magnesio para mejorar el agarre MARCA =  FlexiWheel PRECIO ACTUAL =  50.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:47',_binary ''),(1086,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  21 con los siguientes datos:  NOMBRE =  Guantes para levantamiento de pesas MARCA =  PowerLift PRECIO ACTUAL =  10.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:47',_binary ''),(1087,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  22 con los siguientes datos:  NOMBRE =  Banda elástica para ejercicios de resistencia MARCA =  FlexiWheel PRECIO ACTUAL =  20.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:47',_binary ''),(1088,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  23 con los siguientes datos:  NOMBRE =  Barritas energéticas MARCA =  FlexiSocks PRECIO ACTUAL =  40.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:47',_binary ''),(1089,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  24 con los siguientes datos:  NOMBRE =  Barritas energéticas MARCA =  SpeedGrip PRECIO ACTUAL =  50.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:47',_binary ''),(1090,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  25 con los siguientes datos:  NOMBRE =  Rodillo de espuma para masaje muscular MARCA =  FlexiPad PRECIO ACTUAL =  80.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:47',_binary ''),(1091,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  26 con los siguientes datos:  NOMBRE =  Bebida isotónica MARCA =  MuscleFlow PRECIO ACTUAL =  40.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:47',_binary ''),(1092,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  27 con los siguientes datos:  NOMBRE =  Bebida energética post-entrenamiento MARCA =  FlexiRoll PRECIO ACTUAL =  30.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:47',_binary ''),(1093,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  28 con los siguientes datos:  NOMBRE =  Termogénico para quemar grasa MARCA =  FlexiRing PRECIO ACTUAL =  50.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:47',_binary ''),(1094,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  29 con los siguientes datos:  NOMBRE =  Batidos de proteínas MARCA =  MuscleFlex PRECIO ACTUAL =  20.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:47',_binary ''),(1095,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  30 con los siguientes datos:  NOMBRE =  Suplemento de creatina MARCA =  SpeedWrap PRECIO ACTUAL =  70.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:47',_binary ''),(1096,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  31 con los siguientes datos:  NOMBRE =  Cinturón de levantamiento de pesas MARCA =  MuscleFlex PRECIO ACTUAL =  40.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:47',_binary ''),(1097,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  32 con los siguientes datos:  NOMBRE =  Bebida energética pre-entrenamiento MARCA =  PowerGrip PRECIO ACTUAL =  50.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:47',_binary ''),(1098,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  33 con los siguientes datos:  NOMBRE =  Correa de estiramiento MARCA =  FlexiBand PRECIO ACTUAL =  100.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:47',_binary ''),(1099,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  34 con los siguientes datos:  NOMBRE =  Termogénico para quemar grasa MARCA =  PowerBands PRECIO ACTUAL =  40.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:47',_binary ''),(1100,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  35 con los siguientes datos:  NOMBRE =  Termogénico para quemar grasa MARCA =  PowerLift PRECIO ACTUAL =  20.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:47',_binary ''),(1101,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  36 con los siguientes datos:  NOMBRE =  Bebida isotónica MARCA =  FlexiPod PRECIO ACTUAL =  30.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:47',_binary ''),(1102,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  37 con los siguientes datos:  NOMBRE =  Suplemento pre-entrenamiento MARCA =  FlexiSocks PRECIO ACTUAL =  20.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:47',_binary ''),(1103,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  38 con los siguientes datos:  NOMBRE =  Esterilla de yoga MARCA =  FlexiBall PRECIO ACTUAL =  70.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:47',_binary ''),(1104,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  39 con los siguientes datos:  NOMBRE =  Bebida energética pre-entrenamiento MARCA =  FlexiRing PRECIO ACTUAL =  20.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:47',_binary ''),(1105,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  40 con los siguientes datos:  NOMBRE =  Correa de estiramiento MARCA =  FlexiBall PRECIO ACTUAL =  20.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:47',_binary ''),(1106,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  41 con los siguientes datos:  NOMBRE =  Magnesio para mejorar el agarre MARCA =  PowerBands PRECIO ACTUAL =  50.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:47',_binary ''),(1107,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  42 con los siguientes datos:  NOMBRE =  Esterilla de yoga MARCA =  SpeedStep PRECIO ACTUAL =  50.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:47',_binary ''),(1108,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  43 con los siguientes datos:  NOMBRE =  Termogénico para quemar grasa MARCA =  MuscleFlow PRECIO ACTUAL =  90.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:47',_binary ''),(1109,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  44 con los siguientes datos:  NOMBRE =  Bebida energética pre-entrenamiento MARCA =  MuscleRecover PRECIO ACTUAL =  20.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:47',_binary ''),(1110,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  45 con los siguientes datos:  NOMBRE =  Bloque de espuma para estiramientos MARCA =  PowerStim PRECIO ACTUAL =  20.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:47',_binary ''),(1111,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  46 con los siguientes datos:  NOMBRE =  Termogénico para quemar grasa MARCA =  FlexiRoll PRECIO ACTUAL =  70.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:47',_binary ''),(1112,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  47 con los siguientes datos:  NOMBRE =  Magnesio para mejorar el agarre MARCA =  PowerPulse PRECIO ACTUAL =  70.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:47',_binary ''),(1113,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  48 con los siguientes datos:  NOMBRE =  Correa de estiramiento MARCA =  FlexiBottle PRECIO ACTUAL =  30.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:47',_binary ''),(1114,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  49 con los siguientes datos:  NOMBRE =  Bebida isotónica MARCA =  MuscleEase PRECIO ACTUAL =  60.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:47',_binary ''),(1115,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  50 con los siguientes datos:  NOMBRE =  Suplemento de creatina MARCA =  FlexiRoll PRECIO ACTUAL =  20.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:47',_binary ''),(1116,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  51 con los siguientes datos:  NOMBRE =  Correa de estiramiento MARCA =  StaminaBoost PRECIO ACTUAL =  90.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:48',_binary ''),(1117,'root@localhost','Create','detalles_productos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  51 con los siguientes datos:  PRODUCTO ID =  Correa de estiramiento StaminaBoost DESCRIPCION =  Accesorios que protegen las manos de callosidades y proporcionan un mejor agarre durante el levantamiento de pesas y otros ejercicios de fuerza. CODIGO DE BARRAS =  190532901 PRESENTACION =  Nordic Naturals Ultimate Omega ESTATUS =  Activa','2024-04-17 23:26:49',_binary ''),(1118,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  52 con los siguientes datos:  NOMBRE =  Vendas para muñecas y tobillos MARCA =  FlexiGel PRECIO ACTUAL =  60.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:49',_binary ''),(1119,'root@localhost','Create','detalles_productos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  52 con los siguientes datos:  PRODUCTO ID =  Vendas para muñecas y tobillos FlexiGel DESCRIPCION =  Botellas diseñadas para mezclar fácilmente proteína en polvo con agua o leche, convenientes para consumir bebidas nutritivas antes o después del entrenamiento. CODIGO DE BARRAS =  385987635 PRESENTACION =  Nordic Naturals Ultimate Omega ESTATUS =  Activa','2024-04-17 23:26:49',_binary ''),(1120,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  53 con los siguientes datos:  NOMBRE =  Rodillo de espuma para masaje muscular MARCA =  PowerLift PRECIO ACTUAL =  60.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:49',_binary ''),(1121,'root@localhost','Create','detalles_productos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  53 con los siguientes datos:  PRODUCTO ID =  Rodillo de espuma para masaje muscular PowerLift DESCRIPCION =  Suplemento que contiene los aminoácidos esenciales leucina, isoleucina y valina, que ayudan a promover la recuperación muscular, reducir la fatiga y preservar la masa muscular durante el ejercicio. CODIGO DE BARRAS =  190532901 PRESENTACION =  C4 Original Pre-Workout) ESTATUS =  Activa','2024-04-17 23:26:49',_binary ''),(1122,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  54 con los siguientes datos:  NOMBRE =  Magnesio para mejorar el agarre MARCA =  SpeedWrap PRECIO ACTUAL =  40.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:49',_binary ''),(1123,'root@localhost','Create','detalles_productos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  54 con los siguientes datos:  PRODUCTO ID =  Magnesio para mejorar el agarre SpeedWrap DESCRIPCION =  Suplemento utilizado para aumentar la fuerza, la potencia y ​​la masa muscular, al mejorar la disponibilidad de energía en los músculos durante el ejercicio de alta intensidad. CODIGO DE BARRAS =  450578976 PRESENTACION =  Nordic Naturals Ultimate Omega ESTATUS =  Activa','2024-04-17 23:26:49',_binary ''),(1124,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  55 con los siguientes datos:  NOMBRE =  Banda elástica para ejercicios de resistencia MARCA =  PowerPulse PRECIO ACTUAL =  40.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:49',_binary ''),(1125,'root@localhost','Create','detalles_productos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  55 con los siguientes datos:  PRODUCTO ID =  Banda elástica para ejercicios de resistencia PowerPulse DESCRIPCION =  Suplemento que contiene ácidos grasos esenciales omega-3, conocidos por sus efectos antiinflamatorios y beneficios para la salud cardiovascular y articular. CODIGO DE BARRAS =  105389073 PRESENTACION =  Proteína Whey Gold Standard ESTATUS =  Activa','2024-04-17 23:26:49',_binary ''),(1126,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  56 con los siguientes datos:  NOMBRE =  Banda elástica para ejercicios de resistencia MARCA =  FlexiWheel PRECIO ACTUAL =  30.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:49',_binary ''),(1127,'root@localhost','Create','detalles_productos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  56 con los siguientes datos:  PRODUCTO ID =  Banda elástica para ejercicios de resistencia FlexiWheel DESCRIPCION =  Suplemento que contiene ácidos grasos esenciales omega-3, conocidos por sus efectos antiinflamatorios y beneficios para la salud cardiovascular y articular. CODIGO DE BARRAS =  123457354 PRESENTACION =   Optimum Nutrition Creatine Monohydrate ESTATUS =  Activa','2024-04-17 23:26:49',_binary ''),(1128,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  57 con los siguientes datos:  NOMBRE =  Bebida energética pre-entrenamiento MARCA =  MuscleFlex PRECIO ACTUAL =  90.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:49',_binary ''),(1129,'root@localhost','Create','detalles_productos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  57 con los siguientes datos:  PRODUCTO ID =  Bebida energética pre-entrenamiento MuscleFlex DESCRIPCION =  Equipos de soporte diseñados para proteger la espalda y mejorar la estabilidad durante los levantamientos de peso pesado, como sentadillas y peso muerto. CODIGO DE BARRAS =  385987635 PRESENTACION =  C4 Original Pre-Workout) ESTATUS =  Activa','2024-04-17 23:26:49',_binary ''),(1130,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  58 con los siguientes datos:  NOMBRE =  Batidos de proteínas MARCA =  MuscleMax PRECIO ACTUAL =  30.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:49',_binary ''),(1131,'root@localhost','Create','detalles_productos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  58 con los siguientes datos:  PRODUCTO ID =  Batidos de proteínas MuscleMax DESCRIPCION =  Suplemento que contiene los aminoácidos esenciales leucina, isoleucina y valina, que ayudan a promover la recuperación muscular, reducir la fatiga y preservar la masa muscular durante el ejercicio. CODIGO DE BARRAS =  105389073 PRESENTACION =  C4 Original Pre-Workout) ESTATUS =  Activa','2024-04-17 23:26:49',_binary ''),(1132,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  59 con los siguientes datos:  NOMBRE =  Vendas para muñecas y tobillos MARCA =  SpeedSpike PRECIO ACTUAL =  10.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:49',_binary ''),(1133,'root@localhost','Create','detalles_productos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  59 con los siguientes datos:  PRODUCTO ID =  Vendas para muñecas y tobillos SpeedSpike DESCRIPCION =  Accesorios que protegen las manos de callosidades y proporcionan un mejor agarre durante el levantamiento de pesas y otros ejercicios de fuerza. CODIGO DE BARRAS =  385987635 PRESENTACION =  Xtend BCAA Powder ESTATUS =  Activa','2024-04-17 23:26:49',_binary ''),(1134,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  60 con los siguientes datos:  NOMBRE =  Suplemento de creatina MARCA =  StaminaBoost PRECIO ACTUAL =  90.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:49',_binary ''),(1135,'root@localhost','Create','detalles_productos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  60 con los siguientes datos:  PRODUCTO ID =  Suplemento de creatina StaminaBoost DESCRIPCION =  Suplemento nutricional utilizado para aumentar la ingesta de proteínas, promover la recuperación muscular y el crecimiento después del entrenamiento. CODIGO DE BARRAS =  123457354 PRESENTACION =  Xtend BCAA Powder ESTATUS =  Activa','2024-04-17 23:26:49',_binary ''),(1136,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  61 con los siguientes datos:  NOMBRE =  Banda de resistencia para entrenamiento MARCA =  SpeedGrip PRECIO ACTUAL =  100.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:49',_binary ''),(1137,'root@localhost','Create','detalles_productos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  61 con los siguientes datos:  PRODUCTO ID =  Banda de resistencia para entrenamiento SpeedGrip DESCRIPCION =  Suplemento nutricional utilizado para aumentar la ingesta de proteínas, promover la recuperación muscular y el crecimiento después del entrenamiento. CODIGO DE BARRAS =  450578976 PRESENTACION =  Proteína Whey Gold Standard ESTATUS =  Activa','2024-04-17 23:26:49',_binary ''),(1138,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  62 con los siguientes datos:  NOMBRE =  Vendas para muñecas y tobillos MARCA =  FlexiLoop PRECIO ACTUAL =  20.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:49',_binary ''),(1139,'root@localhost','Create','detalles_productos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  62 con los siguientes datos:  PRODUCTO ID =  Vendas para muñecas y tobillos FlexiLoop DESCRIPCION =  Fórmula diseñada para aumentar la energía, mejorar el enfoque mental y la resistencia durante el entrenamiento, generalmente contiene ingredientes como cafeína, beta-alanina y creatina. CODIGO DE BARRAS =  385987635 PRESENTACION =  Quest Nutrition Protein Bar ESTATUS =  Activa','2024-04-17 23:26:49',_binary ''),(1140,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  63 con los siguientes datos:  NOMBRE =  Barritas energéticas MARCA =  MusclePatch PRECIO ACTUAL =  90.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:49',_binary ''),(1141,'root@localhost','Create','detalles_productos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  63 con los siguientes datos:  PRODUCTO ID =  Barritas energéticas MusclePatch DESCRIPCION =  Suplemento utilizado para aumentar la fuerza, la potencia y ​​la masa muscular, al mejorar la disponibilidad de energía en los músculos durante el ejercicio de alta intensidad. CODIGO DE BARRAS =  105389073 PRESENTACION =  Proteína Whey Gold Standard ESTATUS =  Activa','2024-04-17 23:26:49',_binary ''),(1142,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  64 con los siguientes datos:  NOMBRE =  Termogénico para quemar grasa MARCA =  SpeedWrap PRECIO ACTUAL =  20.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:49',_binary ''),(1143,'root@localhost','Create','detalles_productos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  64 con los siguientes datos:  PRODUCTO ID =  Termogénico para quemar grasa SpeedWrap DESCRIPCION =  Suplementos que contienen una variedad de vitaminas y minerales esenciales para apoyar la salud general, el metabolismo y la función muscular durante el ejercicio intenso. CODIGO DE BARRAS =  450578976 PRESENTACION =  C4 Original Pre-Workout) ESTATUS =  Activa','2024-04-17 23:26:49',_binary ''),(1144,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  65 con los siguientes datos:  NOMBRE =  Bebida energética post-entrenamiento MARCA =  PowerProtein PRECIO ACTUAL =  70.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:49',_binary ''),(1145,'root@localhost','Create','detalles_productos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  65 con los siguientes datos:  PRODUCTO ID =  Bebida energética post-entrenamiento PowerProtein DESCRIPCION =  Fórmula diseñada para aumentar la energía, mejorar el enfoque mental y la resistencia durante el entrenamiento, generalmente contiene ingredientes como cafeína, beta-alanina y creatina. CODIGO DE BARRAS =  190532901 PRESENTACION =  Nordic Naturals Ultimate Omega ESTATUS =  Activa','2024-04-17 23:26:49',_binary ''),(1146,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  66 con los siguientes datos:  NOMBRE =  Esterilla de yoga MARCA =  PowerStim PRECIO ACTUAL =  90.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:49',_binary ''),(1147,'root@localhost','Create','detalles_productos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  66 con los siguientes datos:  PRODUCTO ID =  Esterilla de yoga PowerStim DESCRIPCION =  Fórmula diseñada para aumentar la energía, mejorar el enfoque mental y la resistencia durante el entrenamiento, generalmente contiene ingredientes como cafeína, beta-alanina y creatina. CODIGO DE BARRAS =  385987635 PRESENTACION =  Quest Nutrition Protein Bar ESTATUS =  Activa','2024-04-17 23:26:49',_binary ''),(1148,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  67 con los siguientes datos:  NOMBRE =  Batidos de proteínas MARCA =  PowerGrip PRECIO ACTUAL =  80.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:49',_binary ''),(1149,'root@localhost','Create','detalles_productos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  67 con los siguientes datos:  PRODUCTO ID =  Batidos de proteínas PowerGrip DESCRIPCION =  Botellas diseñadas para mezclar fácilmente proteína en polvo con agua o leche, convenientes para consumir bebidas nutritivas antes o después del entrenamiento. CODIGO DE BARRAS =  123457354 PRESENTACION =  C4 Original Pre-Workout) ESTATUS =  Activa','2024-04-17 23:26:49',_binary ''),(1150,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  68 con los siguientes datos:  NOMBRE =  Magnesio para mejorar el agarre MARCA =  MuscleFlow PRECIO ACTUAL =  100.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:49',_binary ''),(1151,'root@localhost','Create','detalles_productos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  68 con los siguientes datos:  PRODUCTO ID =  Magnesio para mejorar el agarre MuscleFlow DESCRIPCION =  Botellas diseñadas para mezclar fácilmente proteína en polvo con agua o leche, convenientes para consumir bebidas nutritivas antes o después del entrenamiento. CODIGO DE BARRAS =  123457354 PRESENTACION =  Xtend BCAA Powder ESTATUS =  Activa','2024-04-17 23:26:49',_binary ''),(1152,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  69 con los siguientes datos:  NOMBRE =  Magnesio para mejorar el agarre MARCA =  PowerBar PRECIO ACTUAL =  60.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:49',_binary ''),(1153,'root@localhost','Create','detalles_productos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  69 con los siguientes datos:  PRODUCTO ID =  Magnesio para mejorar el agarre PowerBar DESCRIPCION =  Suplemento utilizado para aumentar la fuerza, la potencia y ​​la masa muscular, al mejorar la disponibilidad de energía en los músculos durante el ejercicio de alta intensidad. CODIGO DE BARRAS =  385987635 PRESENTACION =  C4 Original Pre-Workout) ESTATUS =  Activa','2024-04-17 23:26:49',_binary ''),(1154,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  70 con los siguientes datos:  NOMBRE =  Cinturón de levantamiento de pesas MARCA =  SpeedSpike PRECIO ACTUAL =  10.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:49',_binary ''),(1155,'root@localhost','Create','detalles_productos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  70 con los siguientes datos:  PRODUCTO ID =  Cinturón de levantamiento de pesas SpeedSpike DESCRIPCION =  Equipos de soporte diseñados para proteger la espalda y mejorar la estabilidad durante los levantamientos de peso pesado, como sentadillas y peso muerto. CODIGO DE BARRAS =  123457354 PRESENTACION =  Quest Nutrition Protein Bar ESTATUS =  Activa','2024-04-17 23:26:49',_binary ''),(1156,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  71 con los siguientes datos:  NOMBRE =  Banda de resistencia para estiramientos MARCA =  PowerSprint PRECIO ACTUAL =  60.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:49',_binary ''),(1157,'root@localhost','Create','detalles_productos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  71 con los siguientes datos:  PRODUCTO ID =  Banda de resistencia para estiramientos PowerSprint DESCRIPCION =  Accesorios que protegen las manos de callosidades y proporcionan un mejor agarre durante el levantamiento de pesas y otros ejercicios de fuerza. CODIGO DE BARRAS =  190532901 PRESENTACION =  Nordic Naturals Ultimate Omega ESTATUS =  Activa','2024-04-17 23:26:49',_binary ''),(1158,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  72 con los siguientes datos:  NOMBRE =  Rodillo de espuma para masaje muscular MARCA =  PowerBurn PRECIO ACTUAL =  70.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:49',_binary ''),(1159,'root@localhost','Create','detalles_productos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  72 con los siguientes datos:  PRODUCTO ID =  Rodillo de espuma para masaje muscular PowerBurn DESCRIPCION =  Snacks convenientes y portátiles que proporcionan una fuente rápida de proteínas y carbohidratos, ideales para consumir antes o después del entrenamiento para apoyar la recuperación muscular. CODIGO DE BARRAS =  385987635 PRESENTACION =  Nordic Naturals Ultimate Omega ESTATUS =  Activa','2024-04-17 23:26:49',_binary ''),(1160,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  73 con los siguientes datos:  NOMBRE =  Magnesio para mejorar el agarre MARCA =  FlexiStick PRECIO ACTUAL =  90.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:49',_binary ''),(1161,'root@localhost','Create','detalles_productos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  73 con los siguientes datos:  PRODUCTO ID =  Magnesio para mejorar el agarre FlexiStick DESCRIPCION =  Suplemento nutricional utilizado para aumentar la ingesta de proteínas, promover la recuperación muscular y el crecimiento después del entrenamiento. CODIGO DE BARRAS =  123457354 PRESENTACION =  Xtend BCAA Powder ESTATUS =  Activa','2024-04-17 23:26:49',_binary ''),(1162,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  74 con los siguientes datos:  NOMBRE =  Magnesio para mejorar el agarre MARCA =  FlexiBall PRECIO ACTUAL =  100.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:49',_binary ''),(1163,'root@localhost','Create','detalles_productos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  74 con los siguientes datos:  PRODUCTO ID =  Magnesio para mejorar el agarre FlexiBall DESCRIPCION =  Suplementos que contienen una variedad de vitaminas y minerales esenciales para apoyar la salud general, el metabolismo y la función muscular durante el ejercicio intenso. CODIGO DE BARRAS =  190532901 PRESENTACION =  C4 Original Pre-Workout) ESTATUS =  Activa','2024-04-17 23:26:49',_binary ''),(1164,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  75 con los siguientes datos:  NOMBRE =  Bebida isotónica MARCA =  FlexiBlock PRECIO ACTUAL =  80.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:49',_binary ''),(1165,'root@localhost','Create','detalles_productos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  75 con los siguientes datos:  PRODUCTO ID =  Bebida isotónica FlexiBlock DESCRIPCION =  Equipos de soporte diseñados para proteger la espalda y mejorar la estabilidad durante los levantamientos de peso pesado, como sentadillas y peso muerto. CODIGO DE BARRAS =  450578976 PRESENTACION =  Xtend BCAA Powder ESTATUS =  Activa','2024-04-17 23:26:49',_binary ''),(1166,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  76 con los siguientes datos:  NOMBRE =  Correa de estiramiento MARCA =  PowerSprint PRECIO ACTUAL =  100.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:49',_binary ''),(1167,'root@localhost','Create','detalles_productos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  76 con los siguientes datos:  PRODUCTO ID =  Correa de estiramiento PowerSprint DESCRIPCION =  Botellas diseñadas para mezclar fácilmente proteína en polvo con agua o leche, convenientes para consumir bebidas nutritivas antes o después del entrenamiento. CODIGO DE BARRAS =  190532901 PRESENTACION =  Nordic Naturals Ultimate Omega ESTATUS =  Activa','2024-04-17 23:26:49',_binary ''),(1168,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  77 con los siguientes datos:  NOMBRE =  Banda de resistencia para estiramientos MARCA =  CardioCharge PRECIO ACTUAL =  40.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:49',_binary ''),(1169,'root@localhost','Create','detalles_productos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  77 con los siguientes datos:  PRODUCTO ID =  Banda de resistencia para estiramientos CardioCharge DESCRIPCION =  Suplemento que contiene ácidos grasos esenciales omega-3, conocidos por sus efectos antiinflamatorios y beneficios para la salud cardiovascular y articular. CODIGO DE BARRAS =  105389073 PRESENTACION =  Nordic Naturals Ultimate Omega ESTATUS =  Activa','2024-04-17 23:26:49',_binary ''),(1170,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  78 con los siguientes datos:  NOMBRE =  Banda elástica para ejercicios de resistencia MARCA =  SpeedJump PRECIO ACTUAL =  10.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:49',_binary ''),(1171,'root@localhost','Create','detalles_productos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  78 con los siguientes datos:  PRODUCTO ID =  Banda elástica para ejercicios de resistencia SpeedJump DESCRIPCION =  Snacks convenientes y portátiles que proporcionan una fuente rápida de proteínas y carbohidratos, ideales para consumir antes o después del entrenamiento para apoyar la recuperación muscular. CODIGO DE BARRAS =  105389073 PRESENTACION =  Proteína Whey Gold Standard ESTATUS =  Activa','2024-04-17 23:26:49',_binary ''),(1172,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  79 con los siguientes datos:  NOMBRE =  Correa de estiramiento MARCA =  SpeedWrap PRECIO ACTUAL =  60.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:49',_binary ''),(1173,'root@localhost','Create','detalles_productos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  79 con los siguientes datos:  PRODUCTO ID =  Correa de estiramiento SpeedWrap DESCRIPCION =  Suplemento que contiene ácidos grasos esenciales omega-3, conocidos por sus efectos antiinflamatorios y beneficios para la salud cardiovascular y articular. CODIGO DE BARRAS =  385987635 PRESENTACION =  Nordic Naturals Ultimate Omega ESTATUS =  Activa','2024-04-17 23:26:49',_binary ''),(1174,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  80 con los siguientes datos:  NOMBRE =  Batidos de proteínas MARCA =  PowerBlitz PRECIO ACTUAL =  70.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:49',_binary ''),(1175,'root@localhost','Create','detalles_productos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  80 con los siguientes datos:  PRODUCTO ID =  Batidos de proteínas PowerBlitz DESCRIPCION =  Botellas diseñadas para mezclar fácilmente proteína en polvo con agua o leche, convenientes para consumir bebidas nutritivas antes o después del entrenamiento. CODIGO DE BARRAS =  123457354 PRESENTACION =   Optimum Nutrition Creatine Monohydrate ESTATUS =  Activa','2024-04-17 23:26:49',_binary ''),(1176,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  81 con los siguientes datos:  NOMBRE =  Guantes para levantamiento de pesas MARCA =  FlexiFoam PRECIO ACTUAL =  90.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:49',_binary ''),(1177,'root@localhost','Create','detalles_productos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  81 con los siguientes datos:  PRODUCTO ID =  Guantes para levantamiento de pesas FlexiFoam DESCRIPCION =  Accesorios que protegen las manos de callosidades y proporcionan un mejor agarre durante el levantamiento de pesas y otros ejercicios de fuerza. CODIGO DE BARRAS =  190532901 PRESENTACION =  Xtend BCAA Powder ESTATUS =  Activa','2024-04-17 23:26:49',_binary ''),(1178,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  82 con los siguientes datos:  NOMBRE =  Bebida energética post-entrenamiento MARCA =  FlexiPod PRECIO ACTUAL =  30.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:49',_binary ''),(1179,'root@localhost','Create','detalles_productos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  82 con los siguientes datos:  PRODUCTO ID =  Bebida energética post-entrenamiento FlexiPod DESCRIPCION =  Fórmula diseñada para aumentar la energía, mejorar el enfoque mental y la resistencia durante el entrenamiento, generalmente contiene ingredientes como cafeína, beta-alanina y creatina. CODIGO DE BARRAS =  385987635 PRESENTACION =  C4 Original Pre-Workout) ESTATUS =  Activa','2024-04-17 23:26:49',_binary ''),(1180,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  83 con los siguientes datos:  NOMBRE =  Batidos de proteínas MARCA =  FlexiSqueeze PRECIO ACTUAL =  90.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:49',_binary ''),(1181,'root@localhost','Create','detalles_productos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  83 con los siguientes datos:  PRODUCTO ID =  Batidos de proteínas FlexiSqueeze DESCRIPCION =  Snacks convenientes y portátiles que proporcionan una fuente rápida de proteínas y carbohidratos, ideales para consumir antes o después del entrenamiento para apoyar la recuperación muscular. CODIGO DE BARRAS =  123457354 PRESENTACION =  Xtend BCAA Powder ESTATUS =  Activa','2024-04-17 23:26:49',_binary ''),(1182,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  84 con los siguientes datos:  NOMBRE =  Correa de estiramiento MARCA =  FlexiRoll PRECIO ACTUAL =  20.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:49',_binary ''),(1183,'root@localhost','Create','detalles_productos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  84 con los siguientes datos:  PRODUCTO ID =  Correa de estiramiento FlexiRoll DESCRIPCION =  Suplemento que contiene los aminoácidos esenciales leucina, isoleucina y valina, que ayudan a promover la recuperación muscular, reducir la fatiga y preservar la masa muscular durante el ejercicio. CODIGO DE BARRAS =  123457354 PRESENTACION =  Nordic Naturals Ultimate Omega ESTATUS =  Activa','2024-04-17 23:26:49',_binary ''),(1184,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  85 con los siguientes datos:  NOMBRE =  Banda de resistencia para entrenamiento MARCA =  PowerSprint PRECIO ACTUAL =  20.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:49',_binary ''),(1185,'root@localhost','Create','detalles_productos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  85 con los siguientes datos:  PRODUCTO ID =  Banda de resistencia para entrenamiento PowerSprint DESCRIPCION =  Suplemento que contiene los aminoácidos esenciales leucina, isoleucina y valina, que ayudan a promover la recuperación muscular, reducir la fatiga y preservar la masa muscular durante el ejercicio. CODIGO DE BARRAS =  123457354 PRESENTACION =   Optimum Nutrition Creatine Monohydrate ESTATUS =  Activa','2024-04-17 23:26:49',_binary ''),(1186,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  86 con los siguientes datos:  NOMBRE =  Banda de resistencia para entrenamiento MARCA =  SpeedGrip PRECIO ACTUAL =  100.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:49',_binary ''),(1187,'root@localhost','Create','detalles_productos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  86 con los siguientes datos:  PRODUCTO ID =  Banda de resistencia para entrenamiento SpeedGrip DESCRIPCION =  Botellas diseñadas para mezclar fácilmente proteína en polvo con agua o leche, convenientes para consumir bebidas nutritivas antes o después del entrenamiento. CODIGO DE BARRAS =  190532901 PRESENTACION =  Nordic Naturals Ultimate Omega ESTATUS =  Activa','2024-04-17 23:26:49',_binary ''),(1188,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  87 con los siguientes datos:  NOMBRE =  Rodillo de espuma para masaje muscular MARCA =  FlexiBottle PRECIO ACTUAL =  20.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:49',_binary ''),(1189,'root@localhost','Create','detalles_productos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  87 con los siguientes datos:  PRODUCTO ID =  Rodillo de espuma para masaje muscular FlexiBottle DESCRIPCION =  Suplemento nutricional utilizado para aumentar la ingesta de proteínas, promover la recuperación muscular y el crecimiento después del entrenamiento. CODIGO DE BARRAS =  190532901 PRESENTACION =  Nordic Naturals Ultimate Omega ESTATUS =  Activa','2024-04-17 23:26:49',_binary ''),(1190,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  88 con los siguientes datos:  NOMBRE =  Bebida energética pre-entrenamiento MARCA =  FlexiGel PRECIO ACTUAL =  90.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:49',_binary ''),(1191,'root@localhost','Create','detalles_productos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  88 con los siguientes datos:  PRODUCTO ID =  Bebida energética pre-entrenamiento FlexiGel DESCRIPCION =  Equipos de soporte diseñados para proteger la espalda y mejorar la estabilidad durante los levantamientos de peso pesado, como sentadillas y peso muerto. CODIGO DE BARRAS =  385987635 PRESENTACION =  C4 Original Pre-Workout) ESTATUS =  Activa','2024-04-17 23:26:49',_binary ''),(1192,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  89 con los siguientes datos:  NOMBRE =  Magnesio para mejorar el agarre MARCA =  PowerGrip PRECIO ACTUAL =  100.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:49',_binary ''),(1193,'root@localhost','Create','detalles_productos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  89 con los siguientes datos:  PRODUCTO ID =  Magnesio para mejorar el agarre PowerGrip DESCRIPCION =  Accesorios que protegen las manos de callosidades y proporcionan un mejor agarre durante el levantamiento de pesas y otros ejercicios de fuerza. CODIGO DE BARRAS =  123457354 PRESENTACION =  Quest Nutrition Protein Bar ESTATUS =  Activa','2024-04-17 23:26:49',_binary ''),(1194,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  90 con los siguientes datos:  NOMBRE =  Barritas energéticas MARCA =  SpeedWrap PRECIO ACTUAL =  60.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:49',_binary ''),(1195,'root@localhost','Create','detalles_productos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  90 con los siguientes datos:  PRODUCTO ID =  Barritas energéticas SpeedWrap DESCRIPCION =  Suplementos que contienen una variedad de vitaminas y minerales esenciales para apoyar la salud general, el metabolismo y la función muscular durante el ejercicio intenso. CODIGO DE BARRAS =  190532901 PRESENTACION =  C4 Original Pre-Workout) ESTATUS =  Activa','2024-04-17 23:26:49',_binary ''),(1196,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  91 con los siguientes datos:  NOMBRE =  Cinturón de levantamiento de pesas MARCA =  SpeedSpike PRECIO ACTUAL =  10.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:49',_binary ''),(1197,'root@localhost','Create','detalles_productos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  91 con los siguientes datos:  PRODUCTO ID =  Cinturón de levantamiento de pesas SpeedSpike DESCRIPCION =  Suplemento que contiene ácidos grasos esenciales omega-3, conocidos por sus efectos antiinflamatorios y beneficios para la salud cardiovascular y articular. CODIGO DE BARRAS =  385987635 PRESENTACION =  Nordic Naturals Ultimate Omega ESTATUS =  Activa','2024-04-17 23:26:49',_binary ''),(1198,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  92 con los siguientes datos:  NOMBRE =  Batidos de proteínas MARCA =  FlexiStretch PRECIO ACTUAL =  60.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:49',_binary ''),(1199,'root@localhost','Create','detalles_productos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  92 con los siguientes datos:  PRODUCTO ID =  Batidos de proteínas FlexiStretch DESCRIPCION =  Suplemento utilizado para aumentar la fuerza, la potencia y ​​la masa muscular, al mejorar la disponibilidad de energía en los músculos durante el ejercicio de alta intensidad. CODIGO DE BARRAS =  105389073 PRESENTACION =  Proteína Whey Gold Standard ESTATUS =  Activa','2024-04-17 23:26:49',_binary ''),(1200,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  93 con los siguientes datos:  NOMBRE =  Correa de estiramiento MARCA =  FlexiBottle PRECIO ACTUAL =  30.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:49',_binary ''),(1201,'root@localhost','Create','detalles_productos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  93 con los siguientes datos:  PRODUCTO ID =  Correa de estiramiento FlexiBottle DESCRIPCION =  Suplementos que contienen una variedad de vitaminas y minerales esenciales para apoyar la salud general, el metabolismo y la función muscular durante el ejercicio intenso. CODIGO DE BARRAS =  190532901 PRESENTACION =  Xtend BCAA Powder ESTATUS =  Activa','2024-04-17 23:26:49',_binary ''),(1202,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  94 con los siguientes datos:  NOMBRE =  Bebida isotónica MARCA =  SpeedWrap PRECIO ACTUAL =  80.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:49',_binary ''),(1203,'root@localhost','Create','detalles_productos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  94 con los siguientes datos:  PRODUCTO ID =  Bebida isotónica SpeedWrap DESCRIPCION =  Suplemento que contiene los aminoácidos esenciales leucina, isoleucina y valina, que ayudan a promover la recuperación muscular, reducir la fatiga y preservar la masa muscular durante el ejercicio. CODIGO DE BARRAS =  105389073 PRESENTACION =  Quest Nutrition Protein Bar ESTATUS =  Activa','2024-04-17 23:26:49',_binary ''),(1204,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  95 con los siguientes datos:  NOMBRE =  Bebida energética post-entrenamiento MARCA =  PowerFuel PRECIO ACTUAL =  10.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:49',_binary ''),(1205,'root@localhost','Create','detalles_productos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  95 con los siguientes datos:  PRODUCTO ID =  Bebida energética post-entrenamiento PowerFuel DESCRIPCION =  Botellas diseñadas para mezclar fácilmente proteína en polvo con agua o leche, convenientes para consumir bebidas nutritivas antes o después del entrenamiento. CODIGO DE BARRAS =  450578976 PRESENTACION =  Nordic Naturals Ultimate Omega ESTATUS =  Activa','2024-04-17 23:26:49',_binary ''),(1206,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  96 con los siguientes datos:  NOMBRE =  Banda de resistencia para estiramientos MARCA =  MuscleRelief PRECIO ACTUAL =  30.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:49',_binary ''),(1207,'root@localhost','Create','detalles_productos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  96 con los siguientes datos:  PRODUCTO ID =  Banda de resistencia para estiramientos MuscleRelief DESCRIPCION =  Suplemento utilizado para aumentar la fuerza, la potencia y ​​la masa muscular, al mejorar la disponibilidad de energía en los músculos durante el ejercicio de alta intensidad. CODIGO DE BARRAS =  105389073 PRESENTACION =   Optimum Nutrition Creatine Monohydrate ESTATUS =  Activa','2024-04-17 23:26:49',_binary ''),(1208,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  97 con los siguientes datos:  NOMBRE =  Vendas para muñecas y tobillos MARCA =  PowerBands PRECIO ACTUAL =  60.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:49',_binary ''),(1209,'root@localhost','Create','detalles_productos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  97 con los siguientes datos:  PRODUCTO ID =  Vendas para muñecas y tobillos PowerBands DESCRIPCION =  Suplementos que contienen una variedad de vitaminas y minerales esenciales para apoyar la salud general, el metabolismo y la función muscular durante el ejercicio intenso. CODIGO DE BARRAS =  385987635 PRESENTACION =  Nordic Naturals Ultimate Omega ESTATUS =  Activa','2024-04-17 23:26:49',_binary ''),(1210,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  98 con los siguientes datos:  NOMBRE =  Bebida energética post-entrenamiento MARCA =  MuscleFlow PRECIO ACTUAL =  30.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:49',_binary ''),(1211,'root@localhost','Create','detalles_productos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  98 con los siguientes datos:  PRODUCTO ID =  Bebida energética post-entrenamiento MuscleFlow DESCRIPCION =  Suplemento que contiene ácidos grasos esenciales omega-3, conocidos por sus efectos antiinflamatorios y beneficios para la salud cardiovascular y articular. CODIGO DE BARRAS =  105389073 PRESENTACION =  Proteína Whey Gold Standard ESTATUS =  Activa','2024-04-17 23:26:49',_binary ''),(1212,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  99 con los siguientes datos:  NOMBRE =  Guantes para levantamiento de pesas MARCA =  PowerBands PRECIO ACTUAL =  30.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:49',_binary ''),(1213,'root@localhost','Create','detalles_productos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  99 con los siguientes datos:  PRODUCTO ID =  Guantes para levantamiento de pesas PowerBands DESCRIPCION =  Suplemento nutricional utilizado para aumentar la ingesta de proteínas, promover la recuperación muscular y el crecimiento después del entrenamiento. CODIGO DE BARRAS =  385987635 PRESENTACION =  Nordic Naturals Ultimate Omega ESTATUS =  Activa','2024-04-17 23:26:49',_binary ''),(1214,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  100 con los siguientes datos:  NOMBRE =  Correa de estiramiento MARCA =  FlexiWheel PRECIO ACTUAL =  90.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:49',_binary ''),(1215,'root@localhost','Create','detalles_productos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  100 con los siguientes datos:  PRODUCTO ID =  Correa de estiramiento FlexiWheel DESCRIPCION =  Suplemento que contiene ácidos grasos esenciales omega-3, conocidos por sus efectos antiinflamatorios y beneficios para la salud cardiovascular y articular. CODIGO DE BARRAS =  123457354 PRESENTACION =  Xtend BCAA Powder ESTATUS =  Activa','2024-04-17 23:26:49',_binary ''),(1216,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  101 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Lorena PRIMER APELLIDO =  Herrera SEGUNDO APELLIDO =  Reyes FECHA NACIMIENTO =  1981-02-26 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  B+ ESTATUS =   FECHA REGISTRO =  2021-07-24 17:33:41 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:50',_binary ''),(1217,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  101 con los siguientes datos:  NOMBRE USUARIO=  Lorena Herrera Reyes PASSWORD =  TIPO =  Instructor ESTATUS CONEXIÓN =  Online ULTIMA CONEXIÓN =  2023-06-19 11:04:04','2024-04-17 23:26:50',_binary ''),(1218,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  101 con los siguientes datos:  NOMBRE =  Suplemento de creatina MARCA =  PowerHydrate PRECIO ACTUAL =  40.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:50',_binary ''),(1219,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  1 con los siguientes datos:  USUARIO ID =  Lorena Herrera Reyes PRODUCTO ID =  Suplemento de creatina PowerHydrate 40.00 TOTAL =  20.00 FECHA REGISTRO =  2023-02-09 10:05:57 ESTATUS =  Activa','2024-04-17 23:26:50',_binary ''),(1220,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  102 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Sofia PRIMER APELLIDO =  Jiménez SEGUNDO APELLIDO =  Estrada FECHA NACIMIENTO =  1998-02-03 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  A- ESTATUS =   FECHA REGISTRO =  2021-05-31 10:39:41 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:50',_binary ''),(1221,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  102 con los siguientes datos:  NOMBRE USUARIO=  Sofia Jiménez Estrada PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Banned ULTIMA CONEXIÓN =  2022-06-18 19:45:47','2024-04-17 23:26:50',_binary ''),(1222,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  102 con los siguientes datos:  NOMBRE =  Bebida energética post-entrenamiento MARCA =  PowerFuel PRECIO ACTUAL =  20.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:50',_binary ''),(1223,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  2 con los siguientes datos:  USUARIO ID =  Sofia Jiménez Estrada PRODUCTO ID =  Bebida energética post-entrenamiento PowerFuel 20.00 TOTAL =  30.00 FECHA REGISTRO =  2024-03-08 08:51:03 ESTATUS =  Activa','2024-04-17 23:26:50',_binary ''),(1224,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  103 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Diana PRIMER APELLIDO =  Aguilar SEGUNDO APELLIDO =  Guzmán FECHA NACIMIENTO =  1980-10-20 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  O- ESTATUS =   FECHA REGISTRO =  2022-05-20 18:11:47 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:50',_binary ''),(1225,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  103 con los siguientes datos:  NOMBRE USUARIO=  Diana Aguilar Guzmán PASSWORD =  TIPO =  Miembro ESTATUS CONEXIÓN =  Offline ULTIMA CONEXIÓN =  2022-08-14 13:55:24','2024-04-17 23:26:50',_binary ''),(1226,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  103 con los siguientes datos:  NOMBRE =  Guantes para levantamiento de pesas MARCA =  FlexiSqueeze PRECIO ACTUAL =  70.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:50',_binary ''),(1227,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  3 con los siguientes datos:  USUARIO ID =  Diana Aguilar Guzmán PRODUCTO ID =  Guantes para levantamiento de pesas FlexiSqueeze 70.00 TOTAL =  50.00 FECHA REGISTRO =  2021-06-01 10:25:43 ESTATUS =  Activa','2024-04-17 23:26:50',_binary ''),(1228,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  104 con los siguientes datos:  TITULO CORTESIA =  Med. NOMBRE= Brenda PRIMER APELLIDO =  Díaz SEGUNDO APELLIDO =  Méndez FECHA NACIMIENTO =  1993-05-24 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  O+ ESTATUS =   FECHA REGISTRO =  2020-02-10 15:56:45 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:50',_binary ''),(1229,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  104 con los siguientes datos:  NOMBRE USUARIO=  Med. Brenda Díaz Méndez PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Online ULTIMA CONEXIÓN =  2020-11-17 12:41:33','2024-04-17 23:26:50',_binary ''),(1230,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  104 con los siguientes datos:  NOMBRE =  Banda de resistencia para entrenamiento MARCA =  PowerLift PRECIO ACTUAL =  10.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:50',_binary ''),(1231,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  4 con los siguientes datos:  USUARIO ID =  Med. Brenda Díaz Méndez PRODUCTO ID =  Banda de resistencia para entrenamiento PowerLift 10.00 TOTAL =  50.00 FECHA REGISTRO =  2022-01-06 18:16:49 ESTATUS =  Activa','2024-04-17 23:26:50',_binary ''),(1232,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  105 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Alondra PRIMER APELLIDO =  Chávez SEGUNDO APELLIDO =  Domínguez FECHA NACIMIENTO =  1987-02-12 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  O+ ESTATUS =   FECHA REGISTRO =  2022-11-17 16:42:44 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:50',_binary ''),(1233,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  105 con los siguientes datos:  NOMBRE USUARIO=  Alondra Chávez Domínguez PASSWORD =  TIPO =  Miembro ESTATUS CONEXIÓN =  Banned ULTIMA CONEXIÓN =  2023-12-11 19:55:28','2024-04-17 23:26:50',_binary ''),(1234,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  105 con los siguientes datos:  NOMBRE =  Banda elástica para ejercicios de resistencia MARCA =  FlexiBottle PRECIO ACTUAL =  80.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:50',_binary ''),(1235,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  5 con los siguientes datos:  USUARIO ID =  Alondra Chávez Domínguez PRODUCTO ID =  Banda elástica para ejercicios de resistencia FlexiBottle 80.00 TOTAL =  10.00 FECHA REGISTRO =  2024-01-02 14:30:21 ESTATUS =  Activa','2024-04-17 23:26:50',_binary ''),(1236,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  106 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Esmeralda PRIMER APELLIDO =  Sánchez SEGUNDO APELLIDO =  Castro FECHA NACIMIENTO =  1965-10-23 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  AB+ ESTATUS =   FECHA REGISTRO =  2021-02-18 16:40:19 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:50',_binary ''),(1237,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  106 con los siguientes datos:  NOMBRE USUARIO=  Esmeralda Sánchez Castro PASSWORD =  TIPO =  Instructor ESTATUS CONEXIÓN =  Banned ULTIMA CONEXIÓN =  2021-11-01 11:34:57','2024-04-17 23:26:50',_binary ''),(1238,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  106 con los siguientes datos:  NOMBRE =  Bebida energética post-entrenamiento MARCA =  MuscleRelief PRECIO ACTUAL =  80.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:50',_binary ''),(1239,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  6 con los siguientes datos:  USUARIO ID =  Esmeralda Sánchez Castro PRODUCTO ID =  Bebida energética post-entrenamiento MuscleRelief 80.00 TOTAL =  90.00 FECHA REGISTRO =  2020-09-15 10:49:25 ESTATUS =  Activa','2024-04-17 23:26:50',_binary ''),(1240,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  107 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Jazmin PRIMER APELLIDO =  Torres SEGUNDO APELLIDO =  Rodríguez FECHA NACIMIENTO =  1994-08-18 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  A- ESTATUS =   FECHA REGISTRO =  2023-07-07 14:00:40 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:50',_binary ''),(1241,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  107 con los siguientes datos:  NOMBRE USUARIO=  Jazmin Torres Rodríguez PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Banned ULTIMA CONEXIÓN =  2023-12-26 17:13:29','2024-04-17 23:26:50',_binary ''),(1242,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  107 con los siguientes datos:  NOMBRE =  Batidos de proteínas MARCA =  PowerLift PRECIO ACTUAL =  20.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:50',_binary ''),(1243,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  7 con los siguientes datos:  USUARIO ID =  Jazmin Torres Rodríguez PRODUCTO ID =  Batidos de proteínas PowerLift 20.00 TOTAL =  20.00 FECHA REGISTRO =  2020-08-15 12:55:21 ESTATUS =  Activa','2024-04-17 23:26:50',_binary ''),(1244,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  108 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Alondra PRIMER APELLIDO =  Ruíz SEGUNDO APELLIDO =  De la Cruz FECHA NACIMIENTO =  1997-06-25 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  AB+ ESTATUS =   FECHA REGISTRO =  2021-04-22 19:13:51 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:50',_binary ''),(1245,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  108 con los siguientes datos:  NOMBRE USUARIO=  Alondra Ruíz De la Cruz PASSWORD =  TIPO =  Instructor ESTATUS CONEXIÓN =  Online ULTIMA CONEXIÓN =  2023-10-14 08:50:33','2024-04-17 23:26:50',_binary ''),(1246,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  108 con los siguientes datos:  NOMBRE =  Bloque de espuma para estiramientos MARCA =  PowerFuel PRECIO ACTUAL =  100.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:50',_binary ''),(1247,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  8 con los siguientes datos:  USUARIO ID =  Alondra Ruíz De la Cruz PRODUCTO ID =  Bloque de espuma para estiramientos PowerFuel 100.00 TOTAL =  30.00 FECHA REGISTRO =  2022-09-26 12:15:50 ESTATUS =  Activa','2024-04-17 23:26:50',_binary ''),(1248,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  109 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Edgar PRIMER APELLIDO =  Guzmán SEGUNDO APELLIDO =   Rivera FECHA NACIMIENTO =  1996-11-18 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  A+ ESTATUS =   FECHA REGISTRO =  2023-10-31 12:08:35 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:50',_binary ''),(1249,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  109 con los siguientes datos:  NOMBRE USUARIO=  Edgar Guzmán  Rivera PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Online ULTIMA CONEXIÓN =  2024-04-02 18:59:14','2024-04-17 23:26:50',_binary ''),(1250,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  109 con los siguientes datos:  NOMBRE =  Bebida energética post-entrenamiento MARCA =  PowerBar PRECIO ACTUAL =  100.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:50',_binary ''),(1251,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  9 con los siguientes datos:  USUARIO ID =  Edgar Guzmán  Rivera PRODUCTO ID =  Bebida energética post-entrenamiento PowerBar 100.00 TOTAL =  10.00 FECHA REGISTRO =  2023-01-30 11:44:31 ESTATUS =  Activa','2024-04-17 23:26:50',_binary ''),(1252,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  110 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Gerardo PRIMER APELLIDO =  Ramírez SEGUNDO APELLIDO =  Soto FECHA NACIMIENTO =  1981-04-27 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  B+ ESTATUS =   FECHA REGISTRO =  2024-01-08 18:53:48 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:50',_binary ''),(1253,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  110 con los siguientes datos:  NOMBRE USUARIO=  Gerardo Ramírez Soto PASSWORD =  TIPO =  Miembro ESTATUS CONEXIÓN =  Banned ULTIMA CONEXIÓN =  2024-02-28 16:34:29','2024-04-17 23:26:50',_binary ''),(1254,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  110 con los siguientes datos:  NOMBRE =  Batidos de proteínas MARCA =  PowerFuel PRECIO ACTUAL =  40.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:50',_binary ''),(1255,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  10 con los siguientes datos:  USUARIO ID =  Gerardo Ramírez Soto PRODUCTO ID =  Batidos de proteínas PowerFuel 40.00 TOTAL =  60.00 FECHA REGISTRO =  2022-08-14 12:58:35 ESTATUS =  Activa','2024-04-17 23:26:50',_binary ''),(1256,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  111 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Dulce PRIMER APELLIDO =  Salazar SEGUNDO APELLIDO =  Herrera FECHA NACIMIENTO =  2000-12-28 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  B+ ESTATUS =   FECHA REGISTRO =  2023-04-06 08:07:27 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:50',_binary ''),(1257,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  111 con los siguientes datos:  NOMBRE USUARIO=  Dulce Salazar Herrera PASSWORD =  TIPO =  Instructor ESTATUS CONEXIÓN =  Banned ULTIMA CONEXIÓN =  2024-02-22 17:10:33','2024-04-17 23:26:50',_binary ''),(1258,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  111 con los siguientes datos:  NOMBRE =  Suplemento pre-entrenamiento MARCA =  PowerProtein PRECIO ACTUAL =  30.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:50',_binary ''),(1259,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  11 con los siguientes datos:  USUARIO ID =  Dulce Salazar Herrera PRODUCTO ID =  Suplemento pre-entrenamiento PowerProtein 30.00 TOTAL =  50.00 FECHA REGISTRO =  2021-04-25 10:31:40 ESTATUS =  Activa','2024-04-17 23:26:50',_binary ''),(1260,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  112 con los siguientes datos:  TITULO CORTESIA =  C. NOMBRE= Fernando PRIMER APELLIDO =  Hernández SEGUNDO APELLIDO =  Mendoza FECHA NACIMIENTO =  1961-10-19 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  A+ ESTATUS =   FECHA REGISTRO =  2023-08-23 10:52:09 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:50',_binary ''),(1261,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  112 con los siguientes datos:  NOMBRE USUARIO=  C. Fernando Hernández Mendoza PASSWORD =  TIPO =  Miembro ESTATUS CONEXIÓN =  Offline ULTIMA CONEXIÓN =  2024-02-17 09:18:38','2024-04-17 23:26:50',_binary ''),(1262,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  112 con los siguientes datos:  NOMBRE =  Banda de resistencia para estiramientos MARCA =  FlexiStrap PRECIO ACTUAL =  20.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:50',_binary ''),(1263,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  12 con los siguientes datos:  USUARIO ID =  C. Fernando Hernández Mendoza PRODUCTO ID =  Banda de resistencia para estiramientos FlexiStrap 20.00 TOTAL =  10.00 FECHA REGISTRO =  2020-02-12 18:14:41 ESTATUS =  Activa','2024-04-17 23:26:50',_binary ''),(1264,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  113 con los siguientes datos:  TITULO CORTESIA =  Mtro. NOMBRE= Jesus PRIMER APELLIDO =  Jiménez SEGUNDO APELLIDO =  Ramírez FECHA NACIMIENTO =  2004-04-02 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  A+ ESTATUS =   FECHA REGISTRO =  2023-01-13 11:05:25 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:50',_binary ''),(1265,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  113 con los siguientes datos:  NOMBRE USUARIO=  Mtro. Jesus Jiménez Ramírez PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Online ULTIMA CONEXIÓN =  2024-01-31 19:27:03','2024-04-17 23:26:50',_binary ''),(1266,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  113 con los siguientes datos:  NOMBRE =  Suplemento pre-entrenamiento MARCA =  SpeedStep PRECIO ACTUAL =  90.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:50',_binary ''),(1267,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  13 con los siguientes datos:  USUARIO ID =  Mtro. Jesus Jiménez Ramírez PRODUCTO ID =  Suplemento pre-entrenamiento SpeedStep 90.00 TOTAL =  50.00 FECHA REGISTRO =  2023-06-21 16:27:15 ESTATUS =  Activa','2024-04-17 23:26:50',_binary ''),(1268,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  114 con los siguientes datos:  TITULO CORTESIA =  Sgto. NOMBRE= Fernando PRIMER APELLIDO =   Rivera SEGUNDO APELLIDO =  Torres FECHA NACIMIENTO =  2003-07-04 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  B- ESTATUS =   FECHA REGISTRO =  2023-04-23 12:23:04 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:50',_binary ''),(1269,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  114 con los siguientes datos:  NOMBRE USUARIO=  Sgto. Fernando  Rivera Torres PASSWORD =  TIPO =  Miembro ESTATUS CONEXIÓN =  Offline ULTIMA CONEXIÓN =  2024-03-01 18:45:03','2024-04-17 23:26:50',_binary ''),(1270,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  114 con los siguientes datos:  NOMBRE =  Bloque de espuma para estiramientos MARCA =  PowerBands PRECIO ACTUAL =  80.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:50',_binary ''),(1271,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  14 con los siguientes datos:  USUARIO ID =  Sgto. Fernando  Rivera Torres PRODUCTO ID =  Bloque de espuma para estiramientos PowerBands 80.00 TOTAL =  80.00 FECHA REGISTRO =  2021-03-19 11:40:27 ESTATUS =  Activa','2024-04-17 23:26:50',_binary ''),(1272,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  115 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Mario PRIMER APELLIDO =  Juárez SEGUNDO APELLIDO =  Velázquez FECHA NACIMIENTO =  1959-10-23 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  O+ ESTATUS =   FECHA REGISTRO =  2023-05-09 15:22:26 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:50',_binary ''),(1273,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  115 con los siguientes datos:  NOMBRE USUARIO=  Mario Juárez Velázquez PASSWORD =  TIPO =  Miembro ESTATUS CONEXIÓN =  Banned ULTIMA CONEXIÓN =  2024-03-05 19:10:46','2024-04-17 23:26:50',_binary ''),(1274,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  115 con los siguientes datos:  NOMBRE =  Batidos de proteínas MARCA =  FlexiMat PRECIO ACTUAL =  80.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:50',_binary ''),(1275,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  15 con los siguientes datos:  USUARIO ID =  Mario Juárez Velázquez PRODUCTO ID =  Batidos de proteínas FlexiMat 80.00 TOTAL =  80.00 FECHA REGISTRO =  2022-04-04 11:41:22 ESTATUS =  Activa','2024-04-17 23:26:50',_binary ''),(1276,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  116 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Jazmin PRIMER APELLIDO =  Bautista SEGUNDO APELLIDO =  Ramírez FECHA NACIMIENTO =  1959-08-20 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  AB+ ESTATUS =   FECHA REGISTRO =  2022-10-06 15:25:41 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:50',_binary ''),(1277,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  116 con los siguientes datos:  NOMBRE USUARIO=  Jazmin Bautista Ramírez PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Banned ULTIMA CONEXIÓN =  2023-04-10 17:13:05','2024-04-17 23:26:50',_binary ''),(1278,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  116 con los siguientes datos:  NOMBRE =  Bebida energética post-entrenamiento MARCA =  PowerSprint PRECIO ACTUAL =  10.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:50',_binary ''),(1279,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  16 con los siguientes datos:  USUARIO ID =  Jazmin Bautista Ramírez PRODUCTO ID =  Bebida energética post-entrenamiento PowerSprint 10.00 TOTAL =  40.00 FECHA REGISTRO =  2022-12-04 12:28:11 ESTATUS =  Activa','2024-04-17 23:26:50',_binary ''),(1280,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  117 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Bertha PRIMER APELLIDO =  Cruz SEGUNDO APELLIDO =  Herrera FECHA NACIMIENTO =  1995-10-25 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  AB- ESTATUS =   FECHA REGISTRO =  2022-02-08 10:35:02 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:50',_binary ''),(1281,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  117 con los siguientes datos:  NOMBRE USUARIO=  Bertha Cruz Herrera PASSWORD =  TIPO =  Miembro ESTATUS CONEXIÓN =  Offline ULTIMA CONEXIÓN =  2022-05-02 12:24:03','2024-04-17 23:26:50',_binary ''),(1282,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  117 con los siguientes datos:  NOMBRE =  Correa de estiramiento MARCA =  FlexiPad PRECIO ACTUAL =  100.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:50',_binary ''),(1283,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  17 con los siguientes datos:  USUARIO ID =  Bertha Cruz Herrera PRODUCTO ID =  Correa de estiramiento FlexiPad 100.00 TOTAL =  40.00 FECHA REGISTRO =  2023-07-15 08:48:44 ESTATUS =  Activa','2024-04-17 23:26:50',_binary ''),(1284,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  118 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Pedro PRIMER APELLIDO =   González SEGUNDO APELLIDO =  Pérez FECHA NACIMIENTO =  1974-07-03 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  A- ESTATUS =   FECHA REGISTRO =  2020-08-19 09:04:21 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:50',_binary ''),(1285,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  118 con los siguientes datos:  NOMBRE USUARIO=  Pedro  González Pérez PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Banned ULTIMA CONEXIÓN =  2023-06-12 14:50:31','2024-04-17 23:26:50',_binary ''),(1286,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  118 con los siguientes datos:  NOMBRE =  Correa de estiramiento MARCA =  FlexiGrip PRECIO ACTUAL =  50.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:50',_binary ''),(1287,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  18 con los siguientes datos:  USUARIO ID =  Pedro  González Pérez PRODUCTO ID =  Correa de estiramiento FlexiGrip 50.00 TOTAL =  40.00 FECHA REGISTRO =  2020-11-01 19:54:52 ESTATUS =  Activa','2024-04-17 23:26:50',_binary ''),(1288,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  119 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Diana PRIMER APELLIDO =  Juárez SEGUNDO APELLIDO =   Rivera FECHA NACIMIENTO =  1967-09-07 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  A+ ESTATUS =   FECHA REGISTRO =  2023-07-04 18:35:21 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:50',_binary ''),(1289,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  119 con los siguientes datos:  NOMBRE USUARIO=  Diana Juárez  Rivera PASSWORD =  TIPO =  Instructor ESTATUS CONEXIÓN =  Online ULTIMA CONEXIÓN =  2024-04-09 12:03:06','2024-04-17 23:26:50',_binary ''),(1290,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  119 con los siguientes datos:  NOMBRE =  Colchoneta para ejercicios MARCA =  FlexiGel PRECIO ACTUAL =  100.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:50',_binary ''),(1291,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  19 con los siguientes datos:  USUARIO ID =  Diana Juárez  Rivera PRODUCTO ID =  Colchoneta para ejercicios FlexiGel 100.00 TOTAL =  40.00 FECHA REGISTRO =  2023-03-06 16:11:01 ESTATUS =  Activa','2024-04-17 23:26:50',_binary ''),(1292,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  120 con los siguientes datos:  TITULO CORTESIA =  Pfra NOMBRE= Luz PRIMER APELLIDO =  Juárez SEGUNDO APELLIDO =  Vargas FECHA NACIMIENTO =  2000-11-27 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  A+ ESTATUS =   FECHA REGISTRO =  2022-11-24 10:53:18 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:50',_binary ''),(1293,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  120 con los siguientes datos:  NOMBRE USUARIO=  Pfra Luz Juárez Vargas PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Online ULTIMA CONEXIÓN =  2023-05-10 09:26:13','2024-04-17 23:26:50',_binary ''),(1294,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  120 con los siguientes datos:  NOMBRE =  Magnesio para mejorar el agarre MARCA =  MusclePatch PRECIO ACTUAL =  80.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:50',_binary ''),(1295,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  20 con los siguientes datos:  USUARIO ID =  Pfra Luz Juárez Vargas PRODUCTO ID =  Magnesio para mejorar el agarre MusclePatch 80.00 TOTAL =  60.00 FECHA REGISTRO =  2022-09-26 13:31:35 ESTATUS =  Activa','2024-04-17 23:26:50',_binary ''),(1296,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  121 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Paola PRIMER APELLIDO =  Velázquez SEGUNDO APELLIDO =  Vargas FECHA NACIMIENTO =  1975-09-22 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  AB+ ESTATUS =   FECHA REGISTRO =  2022-02-27 08:05:02 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:50',_binary ''),(1297,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  121 con los siguientes datos:  NOMBRE USUARIO=  Paola Velázquez Vargas PASSWORD =  TIPO =  Miembro ESTATUS CONEXIÓN =  Offline ULTIMA CONEXIÓN =  2023-03-28 16:02:56','2024-04-17 23:26:50',_binary ''),(1298,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  121 con los siguientes datos:  NOMBRE =  Bebida energética post-entrenamiento MARCA =  PowerHydrate PRECIO ACTUAL =  50.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:50',_binary ''),(1299,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  21 con los siguientes datos:  USUARIO ID =  Paola Velázquez Vargas PRODUCTO ID =  Bebida energética post-entrenamiento PowerHydrate 50.00 TOTAL =  50.00 FECHA REGISTRO =  2021-02-07 17:30:29 ESTATUS =  Activa','2024-04-17 23:26:50',_binary ''),(1300,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  122 con los siguientes datos:  TITULO CORTESIA =  Dra. NOMBRE= Paola PRIMER APELLIDO =  Medina SEGUNDO APELLIDO =  Reyes FECHA NACIMIENTO =  1978-08-31 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  A+ ESTATUS =   FECHA REGISTRO =  2021-08-18 14:41:35 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:50',_binary ''),(1301,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  122 con los siguientes datos:  NOMBRE USUARIO=  Dra. Paola Medina Reyes PASSWORD =  TIPO =  Miembro ESTATUS CONEXIÓN =  Offline ULTIMA CONEXIÓN =  2024-02-26 19:56:27','2024-04-17 23:26:50',_binary ''),(1302,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  122 con los siguientes datos:  NOMBRE =  Bebida energética pre-entrenamiento MARCA =  FlexiRing PRECIO ACTUAL =  10.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:50',_binary ''),(1303,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  22 con los siguientes datos:  USUARIO ID =  Dra. Paola Medina Reyes PRODUCTO ID =  Bebida energética pre-entrenamiento FlexiRing 10.00 TOTAL =  20.00 FECHA REGISTRO =  2022-04-25 11:36:08 ESTATUS =  Activa','2024-04-17 23:26:50',_binary ''),(1304,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  123 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Valeria PRIMER APELLIDO =  Ramírez SEGUNDO APELLIDO =  García FECHA NACIMIENTO =  1989-11-20 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  A+ ESTATUS =   FECHA REGISTRO =  2021-04-13 12:40:55 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:50',_binary ''),(1305,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  123 con los siguientes datos:  NOMBRE USUARIO=  Valeria Ramírez García PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Online ULTIMA CONEXIÓN =  2022-05-10 13:38:01','2024-04-17 23:26:50',_binary ''),(1306,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  123 con los siguientes datos:  NOMBRE =  Suplemento pre-entrenamiento MARCA =  FlexiSqueeze PRECIO ACTUAL =  10.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:50',_binary ''),(1307,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  23 con los siguientes datos:  USUARIO ID =  Valeria Ramírez García PRODUCTO ID =  Suplemento pre-entrenamiento FlexiSqueeze 10.00 TOTAL =  50.00 FECHA REGISTRO =  2023-12-06 11:30:12 ESTATUS =  Activa','2024-04-17 23:26:50',_binary ''),(1308,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  124 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Carmen PRIMER APELLIDO =  Juárez SEGUNDO APELLIDO =  Martínez FECHA NACIMIENTO =  1980-04-27 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  O- ESTATUS =   FECHA REGISTRO =  2022-08-16 09:22:17 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:50',_binary ''),(1309,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  124 con los siguientes datos:  NOMBRE USUARIO=  Carmen Juárez Martínez PASSWORD =  TIPO =  Miembro ESTATUS CONEXIÓN =  Offline ULTIMA CONEXIÓN =  2023-07-22 16:38:21','2024-04-17 23:26:50',_binary ''),(1310,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  124 con los siguientes datos:  NOMBRE =  Vendas para muñecas y tobillos MARCA =  PowerBar PRECIO ACTUAL =  70.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:50',_binary ''),(1311,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  24 con los siguientes datos:  USUARIO ID =  Carmen Juárez Martínez PRODUCTO ID =  Vendas para muñecas y tobillos PowerBar 70.00 TOTAL =  70.00 FECHA REGISTRO =  2022-04-17 15:27:58 ESTATUS =  Activa','2024-04-17 23:26:50',_binary ''),(1312,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  125 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Sofia PRIMER APELLIDO =  Díaz SEGUNDO APELLIDO =  Pérez FECHA NACIMIENTO =  1984-05-25 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  A- ESTATUS =   FECHA REGISTRO =  2022-07-09 11:06:16 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:50',_binary ''),(1313,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  125 con los siguientes datos:  NOMBRE USUARIO=  Sofia Díaz Pérez PASSWORD =  TIPO =  Miembro ESTATUS CONEXIÓN =  Banned ULTIMA CONEXIÓN =  2024-01-19 15:37:36','2024-04-17 23:26:50',_binary ''),(1314,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  125 con los siguientes datos:  NOMBRE =  Rodillo de espuma para masaje muscular MARCA =  CardioCharge PRECIO ACTUAL =  50.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:50',_binary ''),(1315,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  25 con los siguientes datos:  USUARIO ID =  Sofia Díaz Pérez PRODUCTO ID =  Rodillo de espuma para masaje muscular CardioCharge 50.00 TOTAL =  10.00 FECHA REGISTRO =  2023-12-08 13:26:37 ESTATUS =  Activa','2024-04-17 23:26:50',_binary ''),(1316,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  126 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Aldair PRIMER APELLIDO =  Díaz SEGUNDO APELLIDO =  Guerrero FECHA NACIMIENTO =  1984-08-23 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  O+ ESTATUS =   FECHA REGISTRO =  2022-12-28 19:10:45 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:50',_binary ''),(1317,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  126 con los siguientes datos:  NOMBRE USUARIO=  Aldair Díaz Guerrero PASSWORD =  TIPO =  Miembro ESTATUS CONEXIÓN =  Online ULTIMA CONEXIÓN =  2023-09-20 15:36:46','2024-04-17 23:26:50',_binary ''),(1318,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  126 con los siguientes datos:  NOMBRE =  Bebida isotónica MARCA =  FlexiBottle PRECIO ACTUAL =  40.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:50',_binary ''),(1319,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  26 con los siguientes datos:  USUARIO ID =  Aldair Díaz Guerrero PRODUCTO ID =  Bebida isotónica FlexiBottle 40.00 TOTAL =  20.00 FECHA REGISTRO =  2022-07-08 14:08:15 ESTATUS =  Activa','2024-04-17 23:26:50',_binary ''),(1320,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  127 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Fernando PRIMER APELLIDO =  Cruz SEGUNDO APELLIDO =  Cruz FECHA NACIMIENTO =  1976-05-03 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  A- ESTATUS =   FECHA REGISTRO =  2024-01-25 09:41:25 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:50',_binary ''),(1321,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  127 con los siguientes datos:  NOMBRE USUARIO=  Fernando Cruz Cruz PASSWORD =  TIPO =  Instructor ESTATUS CONEXIÓN =  Banned ULTIMA CONEXIÓN =  2024-04-07 16:24:52','2024-04-17 23:26:50',_binary ''),(1322,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  127 con los siguientes datos:  NOMBRE =  Bloque de espuma para estiramientos MARCA =  FlexiBand PRECIO ACTUAL =  80.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:50',_binary ''),(1323,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  27 con los siguientes datos:  USUARIO ID =  Fernando Cruz Cruz PRODUCTO ID =  Bloque de espuma para estiramientos FlexiBand 80.00 TOTAL =  20.00 FECHA REGISTRO =  2020-08-25 13:17:17 ESTATUS =  Activa','2024-04-17 23:26:50',_binary ''),(1324,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  128 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Federico PRIMER APELLIDO =  López SEGUNDO APELLIDO =  Castro FECHA NACIMIENTO =  1977-01-22 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  AB- ESTATUS =   FECHA REGISTRO =  2021-06-14 15:37:18 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:50',_binary ''),(1325,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  128 con los siguientes datos:  NOMBRE USUARIO=  Federico López Castro PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Banned ULTIMA CONEXIÓN =  2021-07-06 12:52:02','2024-04-17 23:26:50',_binary ''),(1326,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  128 con los siguientes datos:  NOMBRE =  Cinturón de levantamiento de pesas MARCA =  MuscleEase PRECIO ACTUAL =  10.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:50',_binary ''),(1327,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  28 con los siguientes datos:  USUARIO ID =  Federico López Castro PRODUCTO ID =  Cinturón de levantamiento de pesas MuscleEase 10.00 TOTAL =  70.00 FECHA REGISTRO =  2020-05-23 13:13:40 ESTATUS =  Activa','2024-04-17 23:26:50',_binary ''),(1328,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  129 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Hugo PRIMER APELLIDO =  Sánchez SEGUNDO APELLIDO =  Medina FECHA NACIMIENTO =  1959-09-13 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  O- ESTATUS =   FECHA REGISTRO =  2023-04-17 19:29:55 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:50',_binary ''),(1329,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  129 con los siguientes datos:  NOMBRE USUARIO=  Hugo Sánchez Medina PASSWORD =  TIPO =  Visitante ESTATUS CONEXIÓN =  Offline ULTIMA CONEXIÓN =  2023-09-23 13:03:55','2024-04-17 23:26:50',_binary ''),(1330,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  129 con los siguientes datos:  NOMBRE =  Bebida energética post-entrenamiento MARCA =  PowerBeam PRECIO ACTUAL =  60.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:50',_binary ''),(1331,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  29 con los siguientes datos:  USUARIO ID =  Hugo Sánchez Medina PRODUCTO ID =  Bebida energética post-entrenamiento PowerBeam 60.00 TOTAL =  20.00 FECHA REGISTRO =  2021-05-30 09:37:02 ESTATUS =  Activa','2024-04-17 23:26:50',_binary ''),(1332,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  130 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Pedro PRIMER APELLIDO =  Mendoza SEGUNDO APELLIDO =  Velázquez FECHA NACIMIENTO =  1987-06-06 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  AB+ ESTATUS =   FECHA REGISTRO =  2020-10-11 09:59:12 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:50',_binary ''),(1333,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  130 con los siguientes datos:  NOMBRE USUARIO=  Pedro Mendoza Velázquez PASSWORD =  TIPO =  Visitante ESTATUS CONEXIÓN =  Banned ULTIMA CONEXIÓN =  2023-05-20 19:24:08','2024-04-17 23:26:50',_binary ''),(1334,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  130 con los siguientes datos:  NOMBRE =  Correa de estiramiento MARCA =  PowerBeam PRECIO ACTUAL =  40.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:50',_binary ''),(1335,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  30 con los siguientes datos:  USUARIO ID =  Pedro Mendoza Velázquez PRODUCTO ID =  Correa de estiramiento PowerBeam 40.00 TOTAL =  60.00 FECHA REGISTRO =  2021-09-01 13:11:42 ESTATUS =  Activa','2024-04-17 23:26:50',_binary ''),(1336,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  131 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Diana PRIMER APELLIDO =  Jiménez SEGUNDO APELLIDO =  Pérez FECHA NACIMIENTO =  1990-01-22 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  O+ ESTATUS =   FECHA REGISTRO =  2020-08-11 11:34:19 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:50',_binary ''),(1337,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  131 con los siguientes datos:  NOMBRE USUARIO=  Diana Jiménez Pérez PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Offline ULTIMA CONEXIÓN =  2023-10-14 08:59:14','2024-04-17 23:26:50',_binary ''),(1338,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  131 con los siguientes datos:  NOMBRE =  Bebida energética post-entrenamiento MARCA =  SpeedMate PRECIO ACTUAL =  100.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:50',_binary ''),(1339,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  31 con los siguientes datos:  USUARIO ID =  Diana Jiménez Pérez PRODUCTO ID =  Bebida energética post-entrenamiento SpeedMate 100.00 TOTAL =  20.00 FECHA REGISTRO =  2022-12-21 09:30:05 ESTATUS =  Activa','2024-04-17 23:26:50',_binary ''),(1340,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  132 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Gustavo PRIMER APELLIDO =  López SEGUNDO APELLIDO =  Domínguez FECHA NACIMIENTO =  1959-05-12 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  A+ ESTATUS =   FECHA REGISTRO =  2021-07-15 14:52:36 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:50',_binary ''),(1341,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  132 con los siguientes datos:  NOMBRE USUARIO=  Gustavo López Domínguez PASSWORD =  TIPO =  Instructor ESTATUS CONEXIÓN =  Online ULTIMA CONEXIÓN =  2023-10-07 11:57:05','2024-04-17 23:26:50',_binary ''),(1342,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  132 con los siguientes datos:  NOMBRE =  Barritas energéticas MARCA =  FlexiStretch PRECIO ACTUAL =  100.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:50',_binary ''),(1343,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  32 con los siguientes datos:  USUARIO ID =  Gustavo López Domínguez PRODUCTO ID =  Barritas energéticas FlexiStretch 100.00 TOTAL =  60.00 FECHA REGISTRO =  2023-01-06 18:59:16 ESTATUS =  Activa','2024-04-17 23:26:50',_binary ''),(1344,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  133 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Monica PRIMER APELLIDO =  Aguilar SEGUNDO APELLIDO =  Cortes FECHA NACIMIENTO =  1994-04-23 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  O- ESTATUS =   FECHA REGISTRO =  2022-11-20 13:38:16 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:50',_binary ''),(1345,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  133 con los siguientes datos:  NOMBRE USUARIO=  Monica Aguilar Cortes PASSWORD =  TIPO =  Visitante ESTATUS CONEXIÓN =  Online ULTIMA CONEXIÓN =  2023-04-19 16:11:22','2024-04-17 23:26:50',_binary ''),(1346,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  133 con los siguientes datos:  NOMBRE =  Correa de estiramiento MARCA =  SpeedJump PRECIO ACTUAL =  60.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:50',_binary ''),(1347,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  33 con los siguientes datos:  USUARIO ID =  Monica Aguilar Cortes PRODUCTO ID =  Correa de estiramiento SpeedJump 60.00 TOTAL =  10.00 FECHA REGISTRO =  2021-07-29 17:02:20 ESTATUS =  Activa','2024-04-17 23:26:50',_binary ''),(1348,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  134 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Hugo PRIMER APELLIDO =  Castillo SEGUNDO APELLIDO =  Mendoza FECHA NACIMIENTO =  1987-06-08 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  AB- ESTATUS =   FECHA REGISTRO =  2022-06-09 18:21:38 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:50',_binary ''),(1349,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  134 con los siguientes datos:  NOMBRE USUARIO=  Hugo Castillo Mendoza PASSWORD =  TIPO =  Miembro ESTATUS CONEXIÓN =  Offline ULTIMA CONEXIÓN =  2023-06-27 12:34:45','2024-04-17 23:26:50',_binary ''),(1350,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  134 con los siguientes datos:  NOMBRE =  Barritas energéticas MARCA =  PowerSprint PRECIO ACTUAL =  100.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:50',_binary ''),(1351,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  34 con los siguientes datos:  USUARIO ID =  Hugo Castillo Mendoza PRODUCTO ID =  Barritas energéticas PowerSprint 100.00 TOTAL =  100.00 FECHA REGISTRO =  2024-02-14 19:08:37 ESTATUS =  Activa','2024-04-17 23:26:50',_binary ''),(1352,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  135 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Fernando PRIMER APELLIDO =  Ruíz SEGUNDO APELLIDO =  Gómes FECHA NACIMIENTO =  2006-09-04 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  A- ESTATUS =   FECHA REGISTRO =  2023-11-20 08:29:46 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:50',_binary ''),(1353,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  135 con los siguientes datos:  NOMBRE USUARIO=  Fernando Ruíz Gómes PASSWORD =  TIPO =  Visitante ESTATUS CONEXIÓN =  Offline ULTIMA CONEXIÓN =  2023-12-20 19:59:26','2024-04-17 23:26:50',_binary ''),(1354,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  135 con los siguientes datos:  NOMBRE =  Esterilla de yoga MARCA =  PowerStim PRECIO ACTUAL =  70.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:50',_binary ''),(1355,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  35 con los siguientes datos:  USUARIO ID =  Fernando Ruíz Gómes PRODUCTO ID =  Esterilla de yoga PowerStim 70.00 TOTAL =  40.00 FECHA REGISTRO =  2024-01-04 14:17:50 ESTATUS =  Activa','2024-04-17 23:26:50',_binary ''),(1356,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  136 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Ana PRIMER APELLIDO =  Herrera SEGUNDO APELLIDO =  Méndez FECHA NACIMIENTO =  1996-04-22 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  A+ ESTATUS =   FECHA REGISTRO =  2021-06-28 12:24:43 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:50',_binary ''),(1357,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  136 con los siguientes datos:  NOMBRE USUARIO=  Ana Herrera Méndez PASSWORD =  TIPO =  Instructor ESTATUS CONEXIÓN =  Banned ULTIMA CONEXIÓN =  2021-07-17 13:22:16','2024-04-17 23:26:50',_binary ''),(1358,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  136 con los siguientes datos:  NOMBRE =  Suplemento de creatina MARCA =  FlexiBottle PRECIO ACTUAL =  30.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:50',_binary ''),(1359,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  36 con los siguientes datos:  USUARIO ID =  Ana Herrera Méndez PRODUCTO ID =  Suplemento de creatina FlexiBottle 30.00 TOTAL =  80.00 FECHA REGISTRO =  2023-09-24 09:10:32 ESTATUS =  Activa','2024-04-17 23:26:50',_binary ''),(1360,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  137 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Marco PRIMER APELLIDO =  Herrera SEGUNDO APELLIDO =  Reyes FECHA NACIMIENTO =  1980-02-03 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  B+ ESTATUS =   FECHA REGISTRO =  2020-05-08 15:09:47 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:50',_binary ''),(1361,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  137 con los siguientes datos:  NOMBRE USUARIO=  Marco Herrera Reyes PASSWORD =  TIPO =  Miembro ESTATUS CONEXIÓN =  Banned ULTIMA CONEXIÓN =  2021-07-05 17:10:30','2024-04-17 23:26:50',_binary ''),(1362,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  137 con los siguientes datos:  NOMBRE =  Vendas para muñecas y tobillos MARCA =  FlexiFoam PRECIO ACTUAL =  30.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:50',_binary ''),(1363,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  37 con los siguientes datos:  USUARIO ID =  Marco Herrera Reyes PRODUCTO ID =  Vendas para muñecas y tobillos FlexiFoam 30.00 TOTAL =  100.00 FECHA REGISTRO =  2023-09-03 14:38:46 ESTATUS =  Activa','2024-04-17 23:26:50',_binary ''),(1364,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  138 con los siguientes datos:  TITULO CORTESIA =  Sr. NOMBRE= Iram PRIMER APELLIDO =  Torres SEGUNDO APELLIDO =  Gutiérrez FECHA NACIMIENTO =  1999-11-04 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  A+ ESTATUS =   FECHA REGISTRO =  2023-02-13 14:05:09 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:50',_binary ''),(1365,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  138 con los siguientes datos:  NOMBRE USUARIO=  Sr. Iram Torres Gutiérrez PASSWORD =  TIPO =  Visitante ESTATUS CONEXIÓN =  Online ULTIMA CONEXIÓN =  2023-05-22 12:25:55','2024-04-17 23:26:50',_binary ''),(1366,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  138 con los siguientes datos:  NOMBRE =  Suplemento de creatina MARCA =  FlexiRing PRECIO ACTUAL =  100.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:50',_binary ''),(1367,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  38 con los siguientes datos:  USUARIO ID =  Sr. Iram Torres Gutiérrez PRODUCTO ID =  Suplemento de creatina FlexiRing 100.00 TOTAL =  70.00 FECHA REGISTRO =  2021-01-14 12:40:51 ESTATUS =  Activa','2024-04-17 23:26:50',_binary ''),(1368,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  139 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Luz PRIMER APELLIDO =  Herrera SEGUNDO APELLIDO =  Martínez FECHA NACIMIENTO =  1970-11-21 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  A+ ESTATUS =   FECHA REGISTRO =  2021-10-05 19:43:51 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:50',_binary ''),(1369,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  139 con los siguientes datos:  NOMBRE USUARIO=  Luz Herrera Martínez PASSWORD =  TIPO =  Miembro ESTATUS CONEXIÓN =  Offline ULTIMA CONEXIÓN =  2023-10-29 08:00:20','2024-04-17 23:26:50',_binary ''),(1370,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  139 con los siguientes datos:  NOMBRE =  Rodillo de espuma para masaje muscular MARCA =  PowerBeam PRECIO ACTUAL =  30.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:50',_binary ''),(1371,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  39 con los siguientes datos:  USUARIO ID =  Luz Herrera Martínez PRODUCTO ID =  Rodillo de espuma para masaje muscular PowerBeam 30.00 TOTAL =  100.00 FECHA REGISTRO =  2020-06-08 14:44:04 ESTATUS =  Activa','2024-04-17 23:26:50',_binary ''),(1372,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  140 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Estrella PRIMER APELLIDO =  Juárez SEGUNDO APELLIDO =  Cruz FECHA NACIMIENTO =  1967-02-05 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  A- ESTATUS =   FECHA REGISTRO =  2022-05-01 09:13:18 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:50',_binary ''),(1373,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  140 con los siguientes datos:  NOMBRE USUARIO=  Estrella Juárez Cruz PASSWORD =  TIPO =  Instructor ESTATUS CONEXIÓN =  Online ULTIMA CONEXIÓN =  2023-12-27 19:06:27','2024-04-17 23:26:50',_binary ''),(1374,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  140 con los siguientes datos:  NOMBRE =  Guantes para levantamiento de pesas MARCA =  MusclePatch PRECIO ACTUAL =  30.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:50',_binary ''),(1375,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  40 con los siguientes datos:  USUARIO ID =  Estrella Juárez Cruz PRODUCTO ID =  Guantes para levantamiento de pesas MusclePatch 30.00 TOTAL =  30.00 FECHA REGISTRO =  2021-09-04 10:36:55 ESTATUS =  Activa','2024-04-17 23:26:50',_binary ''),(1376,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  141 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Valeria PRIMER APELLIDO =  Santiago SEGUNDO APELLIDO =   Rivera FECHA NACIMIENTO =  1974-05-16 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  O+ ESTATUS =   FECHA REGISTRO =  2023-11-26 10:55:02 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:50',_binary ''),(1377,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  141 con los siguientes datos:  NOMBRE USUARIO=  Valeria Santiago  Rivera PASSWORD =  TIPO =  Visitante ESTATUS CONEXIÓN =  Banned ULTIMA CONEXIÓN =  2023-12-16 14:20:54','2024-04-17 23:26:50',_binary ''),(1378,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  141 con los siguientes datos:  NOMBRE =  Barritas energéticas MARCA =  PowerGrip PRECIO ACTUAL =  10.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:50',_binary ''),(1379,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  41 con los siguientes datos:  USUARIO ID =  Valeria Santiago  Rivera PRODUCTO ID =  Barritas energéticas PowerGrip 10.00 TOTAL =  80.00 FECHA REGISTRO =  2022-07-11 15:35:23 ESTATUS =  Activa','2024-04-17 23:26:50',_binary ''),(1380,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  142 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Gustavo PRIMER APELLIDO =  Martínez SEGUNDO APELLIDO =  Moreno FECHA NACIMIENTO =  1967-07-13 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  B- ESTATUS =   FECHA REGISTRO =  2023-02-09 11:22:13 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:50',_binary ''),(1381,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  142 con los siguientes datos:  NOMBRE USUARIO=  Gustavo Martínez Moreno PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Online ULTIMA CONEXIÓN =  2024-03-18 16:04:26','2024-04-17 23:26:50',_binary ''),(1382,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  142 con los siguientes datos:  NOMBRE =  Rodillo de espuma para masaje muscular MARCA =  PowerLift PRECIO ACTUAL =  60.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:50',_binary ''),(1383,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  42 con los siguientes datos:  USUARIO ID =  Gustavo Martínez Moreno PRODUCTO ID =  Rodillo de espuma para masaje muscular PowerLift 60.00 TOTAL =  10.00 FECHA REGISTRO =  2022-08-24 19:49:41 ESTATUS =  Activa','2024-04-17 23:26:50',_binary ''),(1384,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  143 con los siguientes datos:  TITULO CORTESIA =  C.P. NOMBRE= Yair PRIMER APELLIDO =  Ramos SEGUNDO APELLIDO =  Ramos FECHA NACIMIENTO =  1970-03-08 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  A- ESTATUS =   FECHA REGISTRO =  2022-06-30 09:52:08 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:50',_binary ''),(1385,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  143 con los siguientes datos:  NOMBRE USUARIO=  C.P. Yair Ramos Ramos PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Banned ULTIMA CONEXIÓN =  2023-04-28 09:52:05','2024-04-17 23:26:50',_binary ''),(1386,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  143 con los siguientes datos:  NOMBRE =  Banda de resistencia para entrenamiento MARCA =  SpeedStep PRECIO ACTUAL =  50.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:50',_binary ''),(1387,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  43 con los siguientes datos:  USUARIO ID =  C.P. Yair Ramos Ramos PRODUCTO ID =  Banda de resistencia para entrenamiento SpeedStep 50.00 TOTAL =  80.00 FECHA REGISTRO =  2022-01-31 08:53:50 ESTATUS =  Activa','2024-04-17 23:26:50',_binary ''),(1388,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  144 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Juan PRIMER APELLIDO =  Gómes SEGUNDO APELLIDO =  Estrada FECHA NACIMIENTO =  1960-04-14 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  B+ ESTATUS =   FECHA REGISTRO =  2021-07-09 19:03:54 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:50',_binary ''),(1389,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  144 con los siguientes datos:  NOMBRE USUARIO=  Juan Gómes Estrada PASSWORD =  TIPO =  Miembro ESTATUS CONEXIÓN =  Banned ULTIMA CONEXIÓN =  2022-02-16 10:10:44','2024-04-17 23:26:50',_binary ''),(1390,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  144 con los siguientes datos:  NOMBRE =  Barritas energéticas MARCA =  FlexiRing PRECIO ACTUAL =  80.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:50',_binary ''),(1391,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  44 con los siguientes datos:  USUARIO ID =  Juan Gómes Estrada PRODUCTO ID =  Barritas energéticas FlexiRing 80.00 TOTAL =  60.00 FECHA REGISTRO =  2023-04-02 08:02:37 ESTATUS =  Activa','2024-04-17 23:26:50',_binary ''),(1392,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  145 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Bertha PRIMER APELLIDO =  Ortega SEGUNDO APELLIDO =   González FECHA NACIMIENTO =  2000-02-16 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  O- ESTATUS =   FECHA REGISTRO =  2020-03-30 14:36:32 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:50',_binary ''),(1393,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  145 con los siguientes datos:  NOMBRE USUARIO=  Bertha Ortega  González PASSWORD =  TIPO =  Miembro ESTATUS CONEXIÓN =  Online ULTIMA CONEXIÓN =  2022-07-07 08:11:23','2024-04-17 23:26:50',_binary ''),(1394,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  145 con los siguientes datos:  NOMBRE =  Esterilla de yoga MARCA =  MuscleFlow PRECIO ACTUAL =  60.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:50',_binary ''),(1395,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  45 con los siguientes datos:  USUARIO ID =  Bertha Ortega  González PRODUCTO ID =  Esterilla de yoga MuscleFlow 60.00 TOTAL =  90.00 FECHA REGISTRO =  2022-01-22 19:28:17 ESTATUS =  Activa','2024-04-17 23:26:50',_binary ''),(1396,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  146 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Suri PRIMER APELLIDO =  Díaz SEGUNDO APELLIDO =  Cruz FECHA NACIMIENTO =  2005-10-10 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  A- ESTATUS =   FECHA REGISTRO =  2024-01-19 10:54:38 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:50',_binary ''),(1397,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  146 con los siguientes datos:  NOMBRE USUARIO=  Suri Díaz Cruz PASSWORD =  TIPO =  Visitante ESTATUS CONEXIÓN =  Online ULTIMA CONEXIÓN =  2024-03-30 12:50:18','2024-04-17 23:26:50',_binary ''),(1398,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  146 con los siguientes datos:  NOMBRE =  Magnesio para mejorar el agarre MARCA =  PowerStim PRECIO ACTUAL =  100.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:50',_binary ''),(1399,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  46 con los siguientes datos:  USUARIO ID =  Suri Díaz Cruz PRODUCTO ID =  Magnesio para mejorar el agarre PowerStim 100.00 TOTAL =  70.00 FECHA REGISTRO =  2022-04-10 16:21:56 ESTATUS =  Activa','2024-04-17 23:26:50',_binary ''),(1400,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  147 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Gustavo PRIMER APELLIDO =  Cruz SEGUNDO APELLIDO =  Rodríguez FECHA NACIMIENTO =  1963-04-01 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  A+ ESTATUS =   FECHA REGISTRO =  2023-07-12 08:49:46 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:50',_binary ''),(1401,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  147 con los siguientes datos:  NOMBRE USUARIO=  Gustavo Cruz Rodríguez PASSWORD =  TIPO =  Instructor ESTATUS CONEXIÓN =  Online ULTIMA CONEXIÓN =  2023-10-18 09:48:50','2024-04-17 23:26:50',_binary ''),(1402,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  147 con los siguientes datos:  NOMBRE =  Banda elástica para ejercicios de resistencia MARCA =  StaminaBoost PRECIO ACTUAL =  40.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:50',_binary ''),(1403,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  47 con los siguientes datos:  USUARIO ID =  Gustavo Cruz Rodríguez PRODUCTO ID =  Banda elástica para ejercicios de resistencia StaminaBoost 40.00 TOTAL =  30.00 FECHA REGISTRO =  2021-06-28 19:48:47 ESTATUS =  Activa','2024-04-17 23:26:50',_binary ''),(1404,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  148 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Aldair PRIMER APELLIDO =  De la Cruz SEGUNDO APELLIDO =  López FECHA NACIMIENTO =  2005-06-02 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  AB+ ESTATUS =   FECHA REGISTRO =  2023-04-08 11:01:26 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:50',_binary ''),(1405,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  148 con los siguientes datos:  NOMBRE USUARIO=  Aldair De la Cruz López PASSWORD =  TIPO =  Instructor ESTATUS CONEXIÓN =  Online ULTIMA CONEXIÓN =  2024-01-13 11:48:03','2024-04-17 23:26:50',_binary ''),(1406,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  148 con los siguientes datos:  NOMBRE =  Banda de resistencia para estiramientos MARCA =  PowerBeam PRECIO ACTUAL =  100.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:50',_binary ''),(1407,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  48 con los siguientes datos:  USUARIO ID =  Aldair De la Cruz López PRODUCTO ID =  Banda de resistencia para estiramientos PowerBeam 100.00 TOTAL =  30.00 FECHA REGISTRO =  2021-10-08 12:12:13 ESTATUS =  Activa','2024-04-17 23:26:50',_binary ''),(1408,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  149 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Luz PRIMER APELLIDO =  Salazar SEGUNDO APELLIDO =  Bautista FECHA NACIMIENTO =  1969-06-02 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  A- ESTATUS =   FECHA REGISTRO =  2021-08-14 11:26:19 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:50',_binary ''),(1409,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  149 con los siguientes datos:  NOMBRE USUARIO=  Luz Salazar Bautista PASSWORD =  TIPO =  Visitante ESTATUS CONEXIÓN =  Offline ULTIMA CONEXIÓN =  2022-07-16 17:14:25','2024-04-17 23:26:50',_binary ''),(1410,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  149 con los siguientes datos:  NOMBRE =  Bebida energética post-entrenamiento MARCA =  PowerBeam PRECIO ACTUAL =  50.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:50',_binary ''),(1411,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  49 con los siguientes datos:  USUARIO ID =  Luz Salazar Bautista PRODUCTO ID =  Bebida energética post-entrenamiento PowerBeam 50.00 TOTAL =  100.00 FECHA REGISTRO =  2020-12-05 12:05:02 ESTATUS =  Activa','2024-04-17 23:26:50',_binary ''),(1412,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  150 con los siguientes datos:  TITULO CORTESIA =  Ing. NOMBRE= Jesus PRIMER APELLIDO =  Ramírez SEGUNDO APELLIDO =  Moreno FECHA NACIMIENTO =  2003-02-01 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  A+ ESTATUS =   FECHA REGISTRO =  2022-01-03 10:58:57 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:50',_binary ''),(1413,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  150 con los siguientes datos:  NOMBRE USUARIO=  Ing. Jesus Ramírez Moreno PASSWORD =  TIPO =  Instructor ESTATUS CONEXIÓN =  Offline ULTIMA CONEXIÓN =  2023-09-25 12:52:16','2024-04-17 23:26:50',_binary ''),(1414,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  150 con los siguientes datos:  NOMBRE =  Colchoneta para ejercicios MARCA =  PowerCord PRECIO ACTUAL =  80.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:50',_binary ''),(1415,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  50 con los siguientes datos:  USUARIO ID =  Ing. Jesus Ramírez Moreno PRODUCTO ID =  Colchoneta para ejercicios PowerCord 80.00 TOTAL =  20.00 FECHA REGISTRO =  2020-07-21 12:07:33 ESTATUS =  Activa','2024-04-17 23:26:50',_binary ''),(1416,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  151 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Dulce PRIMER APELLIDO =  Salazar SEGUNDO APELLIDO =  Medina FECHA NACIMIENTO =  2008-03-10 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  O- ESTATUS =   FECHA REGISTRO =  2022-05-11 08:14:06 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:50',_binary ''),(1417,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  151 con los siguientes datos:  NOMBRE USUARIO=  Dulce Salazar Medina PASSWORD =  TIPO =  Visitante ESTATUS CONEXIÓN =  Online ULTIMA CONEXIÓN =  2023-07-28 14:32:24','2024-04-17 23:26:50',_binary ''),(1418,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  151 con los siguientes datos:  NOMBRE =  Bebida energética post-entrenamiento MARCA =  MuscleEase PRECIO ACTUAL =  50.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:50',_binary ''),(1419,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  51 con los siguientes datos:  USUARIO ID =  Dulce Salazar Medina PRODUCTO ID =  Bebida energética post-entrenamiento MuscleEase 50.00 TOTAL =  40.00 FECHA REGISTRO =  2022-01-09 11:42:23 ESTATUS =  Activa','2024-04-17 23:26:50',_binary ''),(1420,'root@localhost','Create','detalles_pedidos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  1 con los siguientes datos:  PEDIDO ID =  151 40.00 2022-01-09 11:42:23 PRODUCTO ID =  Barritas energéticas MuscleFlow CANTIDAD =  10 TOTAL PARCIAL =  80.00 FECHA REGISTRO =  2020-12-22 19:35:29 FECHA ENTREGA =  2024-04-17 23:26:50 ESTATUS =  Activa','2024-04-17 23:26:50',_binary ''),(1421,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  152 con los siguientes datos:  TITULO CORTESIA =  C. NOMBRE= Karla PRIMER APELLIDO =  Gómes SEGUNDO APELLIDO =  Gómes FECHA NACIMIENTO =  1980-08-20 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  AB+ ESTATUS =   FECHA REGISTRO =  2020-12-17 15:12:20 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:50',_binary ''),(1422,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  152 con los siguientes datos:  NOMBRE USUARIO=  C. Karla Gómes Gómes PASSWORD =  TIPO =  Visitante ESTATUS CONEXIÓN =  Banned ULTIMA CONEXIÓN =  2021-11-20 17:55:22','2024-04-17 23:26:50',_binary ''),(1423,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  152 con los siguientes datos:  NOMBRE =  Banda de resistencia para estiramientos MARCA =  FlexiGrip PRECIO ACTUAL =  30.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:50',_binary ''),(1424,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  52 con los siguientes datos:  USUARIO ID =  C. Karla Gómes Gómes PRODUCTO ID =  Banda de resistencia para estiramientos FlexiGrip 30.00 TOTAL =  100.00 FECHA REGISTRO =  2021-05-06 15:09:46 ESTATUS =  Activa','2024-04-17 23:26:50',_binary ''),(1425,'root@localhost','Create','detalles_pedidos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  2 con los siguientes datos:  PEDIDO ID =  152 100.00 2021-05-06 15:09:46 PRODUCTO ID =  Barritas energéticas MuscleFlow CANTIDAD =  10 TOTAL PARCIAL =  50.00 FECHA REGISTRO =  2020-03-04 18:46:15 FECHA ENTREGA =  2024-04-17 23:26:50 ESTATUS =  Activa','2024-04-17 23:26:50',_binary ''),(1426,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  153 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Maximiliano PRIMER APELLIDO =  Romero SEGUNDO APELLIDO =  Salazar FECHA NACIMIENTO =  1989-01-20 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  AB+ ESTATUS =   FECHA REGISTRO =  2023-10-13 17:23:14 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:50',_binary ''),(1427,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  153 con los siguientes datos:  NOMBRE USUARIO=  Maximiliano Romero Salazar PASSWORD =  TIPO =  Visitante ESTATUS CONEXIÓN =  Banned ULTIMA CONEXIÓN =  2023-11-16 19:02:36','2024-04-17 23:26:50',_binary ''),(1428,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  153 con los siguientes datos:  NOMBRE =  Guantes para levantamiento de pesas MARCA =  FlexiPad PRECIO ACTUAL =  40.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:50',_binary ''),(1429,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  53 con los siguientes datos:  USUARIO ID =  Maximiliano Romero Salazar PRODUCTO ID =  Guantes para levantamiento de pesas FlexiPad 40.00 TOTAL =  30.00 FECHA REGISTRO =  2021-08-08 19:55:11 ESTATUS =  Activa','2024-04-17 23:26:51',_binary ''),(1430,'root@localhost','Create','detalles_pedidos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  3 con los siguientes datos:  PEDIDO ID =  153 30.00 2021-08-08 19:55:11 PRODUCTO ID =  Barritas energéticas MuscleFlow CANTIDAD =  60 TOTAL PARCIAL =  30.00 FECHA REGISTRO =  2023-02-21 18:43:28 FECHA ENTREGA =  2024-04-17 23:26:50 ESTATUS =  Activa','2024-04-17 23:26:51',_binary ''),(1431,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  154 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Estrella PRIMER APELLIDO =   González SEGUNDO APELLIDO =  Méndez FECHA NACIMIENTO =  1981-02-10 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  AB+ ESTATUS =   FECHA REGISTRO =  2022-11-20 14:40:52 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:51',_binary ''),(1432,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  154 con los siguientes datos:  NOMBRE USUARIO=  Estrella  González Méndez PASSWORD =  TIPO =  Instructor ESTATUS CONEXIÓN =  Online ULTIMA CONEXIÓN =  2023-08-13 09:11:37','2024-04-17 23:26:51',_binary ''),(1433,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  154 con los siguientes datos:  NOMBRE =  Vendas para muñecas y tobillos MARCA =  FlexiFoam PRECIO ACTUAL =  30.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:51',_binary ''),(1434,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  54 con los siguientes datos:  USUARIO ID =  Estrella  González Méndez PRODUCTO ID =  Vendas para muñecas y tobillos FlexiFoam 30.00 TOTAL =  10.00 FECHA REGISTRO =  2021-06-07 15:19:32 ESTATUS =  Activa','2024-04-17 23:26:51',_binary ''),(1435,'root@localhost','Create','detalles_pedidos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  4 con los siguientes datos:  PEDIDO ID =  154 10.00 2021-06-07 15:19:32 PRODUCTO ID =  Barritas energéticas MuscleFlow CANTIDAD =  10 TOTAL PARCIAL =  50.00 FECHA REGISTRO =  2024-03-29 15:49:44 FECHA ENTREGA =  2024-04-17 23:26:50 ESTATUS =  Activa','2024-04-17 23:26:51',_binary ''),(1436,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  155 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Flor PRIMER APELLIDO =  Torres SEGUNDO APELLIDO =  Jiménez FECHA NACIMIENTO =  1984-06-09 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  AB- ESTATUS =   FECHA REGISTRO =  2023-03-13 16:59:33 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:51',_binary ''),(1437,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  155 con los siguientes datos:  NOMBRE USUARIO=  Flor Torres Jiménez PASSWORD =  TIPO =  Miembro ESTATUS CONEXIÓN =  Online ULTIMA CONEXIÓN =  2023-04-20 13:52:32','2024-04-17 23:26:51',_binary ''),(1438,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  155 con los siguientes datos:  NOMBRE =  Suplemento de creatina MARCA =  FlexiBall PRECIO ACTUAL =  30.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:51',_binary ''),(1439,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  55 con los siguientes datos:  USUARIO ID =  Flor Torres Jiménez PRODUCTO ID =  Suplemento de creatina FlexiBall 30.00 TOTAL =  30.00 FECHA REGISTRO =  2021-12-02 14:00:38 ESTATUS =  Activa','2024-04-17 23:26:51',_binary ''),(1440,'root@localhost','Create','detalles_pedidos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  5 con los siguientes datos:  PEDIDO ID =  155 30.00 2021-12-02 14:00:38 PRODUCTO ID =  Barritas energéticas MuscleFlow CANTIDAD =  10 TOTAL PARCIAL =  40.00 FECHA REGISTRO =  2020-05-01 13:22:40 FECHA ENTREGA =  2024-04-17 23:26:50 ESTATUS =  Activa','2024-04-17 23:26:51',_binary ''),(1441,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  156 con los siguientes datos:  TITULO CORTESIA =  Med. NOMBRE= Dulce PRIMER APELLIDO =  Mendoza SEGUNDO APELLIDO =  Chávez FECHA NACIMIENTO =  1991-01-16 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  AB+ ESTATUS =   FECHA REGISTRO =  2022-12-05 17:59:47 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:51',_binary ''),(1442,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  156 con los siguientes datos:  NOMBRE USUARIO=  Med. Dulce Mendoza Chávez PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Online ULTIMA CONEXIÓN =  2023-02-17 13:17:27','2024-04-17 23:26:51',_binary ''),(1443,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  156 con los siguientes datos:  NOMBRE =  Colchoneta para ejercicios MARCA =  PowerLift PRECIO ACTUAL =  10.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:51',_binary ''),(1444,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  56 con los siguientes datos:  USUARIO ID =  Med. Dulce Mendoza Chávez PRODUCTO ID =  Colchoneta para ejercicios PowerLift 10.00 TOTAL =  80.00 FECHA REGISTRO =  2023-01-22 11:25:43 ESTATUS =  Activa','2024-04-17 23:26:51',_binary ''),(1445,'root@localhost','Create','detalles_pedidos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  6 con los siguientes datos:  PEDIDO ID =  156 80.00 2023-01-22 11:25:43 PRODUCTO ID =  Barritas energéticas MuscleFlow CANTIDAD =  380 TOTAL PARCIAL =  60.00 FECHA REGISTRO =  2020-07-06 17:37:40 FECHA ENTREGA =  2024-04-17 23:26:50 ESTATUS =  Activa','2024-04-17 23:26:51',_binary ''),(1446,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  157 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Carmen PRIMER APELLIDO =  Martínez SEGUNDO APELLIDO =  Reyes FECHA NACIMIENTO =  1972-07-02 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  B- ESTATUS =   FECHA REGISTRO =  2022-11-01 17:48:34 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:51',_binary ''),(1447,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  157 con los siguientes datos:  NOMBRE USUARIO=  Carmen Martínez Reyes PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Online ULTIMA CONEXIÓN =  2023-01-02 11:52:29','2024-04-17 23:26:51',_binary ''),(1448,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  157 con los siguientes datos:  NOMBRE =  Suplemento pre-entrenamiento MARCA =  MuscleRecover PRECIO ACTUAL =  100.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:51',_binary ''),(1449,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  57 con los siguientes datos:  USUARIO ID =  Carmen Martínez Reyes PRODUCTO ID =  Suplemento pre-entrenamiento MuscleRecover 100.00 TOTAL =  60.00 FECHA REGISTRO =  2024-02-15 10:13:25 ESTATUS =  Activa','2024-04-17 23:26:51',_binary ''),(1450,'root@localhost','Create','detalles_pedidos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  7 con los siguientes datos:  PEDIDO ID =  157 60.00 2024-02-15 10:13:25 PRODUCTO ID =  Barritas energéticas MuscleFlow CANTIDAD =  10 TOTAL PARCIAL =  70.00 FECHA REGISTRO =  2020-12-11 09:02:57 FECHA ENTREGA =  2024-04-17 23:26:50 ESTATUS =  Activa','2024-04-17 23:26:51',_binary ''),(1451,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  158 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Flor PRIMER APELLIDO =  Cortés SEGUNDO APELLIDO =   Rivera FECHA NACIMIENTO =  1960-04-02 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  B+ ESTATUS =   FECHA REGISTRO =  2022-06-06 18:15:02 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:51',_binary ''),(1452,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  158 con los siguientes datos:  NOMBRE USUARIO=  Flor Cortés  Rivera PASSWORD =  TIPO =  Miembro ESTATUS CONEXIÓN =  Online ULTIMA CONEXIÓN =  2023-12-08 09:27:10','2024-04-17 23:26:51',_binary ''),(1453,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  158 con los siguientes datos:  NOMBRE =  Suplemento de creatina MARCA =  PowerGrip PRECIO ACTUAL =  20.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:51',_binary ''),(1454,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  58 con los siguientes datos:  USUARIO ID =  Flor Cortés  Rivera PRODUCTO ID =  Suplemento de creatina PowerGrip 20.00 TOTAL =  40.00 FECHA REGISTRO =  2020-06-04 13:47:17 ESTATUS =  Activa','2024-04-17 23:26:51',_binary ''),(1455,'root@localhost','Create','detalles_pedidos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  8 con los siguientes datos:  PEDIDO ID =  158 40.00 2020-06-04 13:47:17 PRODUCTO ID =  Barritas energéticas MuscleFlow CANTIDAD =  10 TOTAL PARCIAL =  20.00 FECHA REGISTRO =  2021-03-02 19:53:12 FECHA ENTREGA =  2024-04-17 23:26:50 ESTATUS =  Activa','2024-04-17 23:26:51',_binary ''),(1456,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  159 con los siguientes datos:  TITULO CORTESIA =  Srita NOMBRE= Paola PRIMER APELLIDO =  Bautista SEGUNDO APELLIDO =  Medina FECHA NACIMIENTO =  1987-03-20 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  O+ ESTATUS =   FECHA REGISTRO =  2021-02-15 19:08:28 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:51',_binary ''),(1457,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  159 con los siguientes datos:  NOMBRE USUARIO=  Srita Paola Bautista Medina PASSWORD =  TIPO =  Instructor ESTATUS CONEXIÓN =  Offline ULTIMA CONEXIÓN =  2023-12-12 19:42:30','2024-04-17 23:26:51',_binary ''),(1458,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  159 con los siguientes datos:  NOMBRE =  Barritas energéticas MARCA =  PowerFuel PRECIO ACTUAL =  100.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:51',_binary ''),(1459,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  59 con los siguientes datos:  USUARIO ID =  Srita Paola Bautista Medina PRODUCTO ID =  Barritas energéticas PowerFuel 100.00 TOTAL =  50.00 FECHA REGISTRO =  2021-11-06 17:07:06 ESTATUS =  Activa','2024-04-17 23:26:51',_binary ''),(1460,'root@localhost','Create','detalles_pedidos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  9 con los siguientes datos:  PEDIDO ID =  159 50.00 2021-11-06 17:07:06 PRODUCTO ID =  Barritas energéticas MuscleFlow CANTIDAD =  450 TOTAL PARCIAL =  30.00 FECHA REGISTRO =  2023-04-19 08:46:24 FECHA ENTREGA =  2024-04-17 23:26:50 ESTATUS =  Activa','2024-04-17 23:26:51',_binary ''),(1461,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  160 con los siguientes datos:  TITULO CORTESIA =  Med. NOMBRE= Guadalupe PRIMER APELLIDO =  Ortiz SEGUNDO APELLIDO =  Álvarez FECHA NACIMIENTO =  1976-03-08 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  A+ ESTATUS =   FECHA REGISTRO =  2022-05-27 13:17:05 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:51',_binary ''),(1462,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  160 con los siguientes datos:  NOMBRE USUARIO=  Med. Guadalupe Ortiz Álvarez PASSWORD =  TIPO =  Miembro ESTATUS CONEXIÓN =  Online ULTIMA CONEXIÓN =  2024-02-24 16:37:21','2024-04-17 23:26:51',_binary ''),(1463,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  160 con los siguientes datos:  NOMBRE =  Bebida energética post-entrenamiento MARCA =  PowerStim PRECIO ACTUAL =  40.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:51',_binary ''),(1464,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  60 con los siguientes datos:  USUARIO ID =  Med. Guadalupe Ortiz Álvarez PRODUCTO ID =  Bebida energética post-entrenamiento PowerStim 40.00 TOTAL =  80.00 FECHA REGISTRO =  2024-01-25 12:20:50 ESTATUS =  Activa','2024-04-17 23:26:51',_binary ''),(1465,'root@localhost','Create','detalles_pedidos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  10 con los siguientes datos:  PEDIDO ID =  160 80.00 2024-01-25 12:20:50 PRODUCTO ID =  Barritas energéticas MuscleFlow CANTIDAD =  60 TOTAL PARCIAL =  80.00 FECHA REGISTRO =  2024-01-30 13:09:06 FECHA ENTREGA =  2024-04-17 23:26:50 ESTATUS =  Activa','2024-04-17 23:26:51',_binary ''),(1466,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  161 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Pedro PRIMER APELLIDO =  Guerrero SEGUNDO APELLIDO =  Vázquez FECHA NACIMIENTO =  1986-11-09 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  A+ ESTATUS =   FECHA REGISTRO =  2022-01-05 11:00:53 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:51',_binary ''),(1467,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  161 con los siguientes datos:  NOMBRE USUARIO=  Pedro Guerrero Vázquez PASSWORD =  TIPO =  Instructor ESTATUS CONEXIÓN =  Offline ULTIMA CONEXIÓN =  2024-02-03 08:57:09','2024-04-17 23:26:51',_binary ''),(1468,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  161 con los siguientes datos:  NOMBRE =  Termogénico para quemar grasa MARCA =  StaminaBoost PRECIO ACTUAL =  50.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:51',_binary ''),(1469,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  61 con los siguientes datos:  USUARIO ID =  Pedro Guerrero Vázquez PRODUCTO ID =  Termogénico para quemar grasa StaminaBoost 50.00 TOTAL =  90.00 FECHA REGISTRO =  2020-06-13 18:43:56 ESTATUS =  Activa','2024-04-17 23:26:51',_binary ''),(1470,'root@localhost','Create','detalles_pedidos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  11 con los siguientes datos:  PEDIDO ID =  161 90.00 2020-06-13 18:43:56 PRODUCTO ID =  Barritas energéticas MuscleFlow CANTIDAD =  10 TOTAL PARCIAL =  20.00 FECHA REGISTRO =  2020-04-07 19:51:09 FECHA ENTREGA =  2024-04-17 23:26:50 ESTATUS =  Activa','2024-04-17 23:26:51',_binary ''),(1471,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  162 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Brenda PRIMER APELLIDO =  Díaz SEGUNDO APELLIDO =  Moreno FECHA NACIMIENTO =  1974-10-17 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  A- ESTATUS =   FECHA REGISTRO =  2023-12-09 08:46:17 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:51',_binary ''),(1472,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  162 con los siguientes datos:  NOMBRE USUARIO=  Brenda Díaz Moreno PASSWORD =  TIPO =  Miembro ESTATUS CONEXIÓN =  Offline ULTIMA CONEXIÓN =  2024-02-25 08:15:44','2024-04-17 23:26:51',_binary ''),(1473,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  162 con los siguientes datos:  NOMBRE =  Banda de resistencia para estiramientos MARCA =  PowerLift PRECIO ACTUAL =  40.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:51',_binary ''),(1474,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  62 con los siguientes datos:  USUARIO ID =  Brenda Díaz Moreno PRODUCTO ID =  Banda de resistencia para estiramientos PowerLift 40.00 TOTAL =  30.00 FECHA REGISTRO =  2022-01-13 13:58:43 ESTATUS =  Activa','2024-04-17 23:26:51',_binary ''),(1475,'root@localhost','Create','detalles_pedidos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  12 con los siguientes datos:  PEDIDO ID =  162 30.00 2022-01-13 13:58:43 PRODUCTO ID =  Barritas energéticas MuscleFlow CANTIDAD =  10 TOTAL PARCIAL =  90.00 FECHA REGISTRO =  2020-03-24 16:29:42 FECHA ENTREGA =  2024-04-17 23:26:50 ESTATUS =  Activa','2024-04-17 23:26:51',_binary ''),(1476,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  163 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Flor PRIMER APELLIDO =  Moreno SEGUNDO APELLIDO =  Martínez FECHA NACIMIENTO =  1999-11-16 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  A+ ESTATUS =   FECHA REGISTRO =  2022-04-27 16:13:02 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:51',_binary ''),(1477,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  163 con los siguientes datos:  NOMBRE USUARIO=  Flor Moreno Martínez PASSWORD =  TIPO =  Instructor ESTATUS CONEXIÓN =  Banned ULTIMA CONEXIÓN =  2023-02-26 10:32:30','2024-04-17 23:26:51',_binary ''),(1478,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  163 con los siguientes datos:  NOMBRE =  Colchoneta para ejercicios MARCA =  MuscleRecover PRECIO ACTUAL =  30.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:51',_binary ''),(1479,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  63 con los siguientes datos:  USUARIO ID =  Flor Moreno Martínez PRODUCTO ID =  Colchoneta para ejercicios MuscleRecover 30.00 TOTAL =  20.00 FECHA REGISTRO =  2021-01-18 15:57:06 ESTATUS =  Activa','2024-04-17 23:26:51',_binary ''),(1480,'root@localhost','Create','detalles_pedidos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  13 con los siguientes datos:  PEDIDO ID =  163 20.00 2021-01-18 15:57:06 PRODUCTO ID =  Barritas energéticas MuscleFlow CANTIDAD =  450 TOTAL PARCIAL =  100.00 FECHA REGISTRO =  2023-06-23 11:48:03 FECHA ENTREGA =  2024-04-17 23:26:50 ESTATUS =  Activa','2024-04-17 23:26:51',_binary ''),(1481,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  164 con los siguientes datos:  TITULO CORTESIA =  Lic. NOMBRE= Esmeralda PRIMER APELLIDO =  Velázquez SEGUNDO APELLIDO =  Guerrero FECHA NACIMIENTO =  1973-09-12 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  AB- ESTATUS =   FECHA REGISTRO =  2023-01-06 12:18:02 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:51',_binary ''),(1482,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  164 con los siguientes datos:  NOMBRE USUARIO=  Lic. Esmeralda Velázquez Guerrero PASSWORD =  TIPO =  Miembro ESTATUS CONEXIÓN =  Offline ULTIMA CONEXIÓN =  2023-12-14 15:01:46','2024-04-17 23:26:51',_binary ''),(1483,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  164 con los siguientes datos:  NOMBRE =  Banda elástica para ejercicios de resistencia MARCA =  PowerSprint PRECIO ACTUAL =  40.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:51',_binary ''),(1484,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  64 con los siguientes datos:  USUARIO ID =  Lic. Esmeralda Velázquez Guerrero PRODUCTO ID =  Banda elástica para ejercicios de resistencia PowerSprint 40.00 TOTAL =  90.00 FECHA REGISTRO =  2022-04-02 19:07:44 ESTATUS =  Activa','2024-04-17 23:26:51',_binary ''),(1485,'root@localhost','Create','detalles_pedidos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  14 con los siguientes datos:  PEDIDO ID =  164 90.00 2022-04-02 19:07:44 PRODUCTO ID =  Barritas energéticas MuscleFlow CANTIDAD =  10 TOTAL PARCIAL =  60.00 FECHA REGISTRO =  2022-03-03 18:52:00 FECHA ENTREGA =  2024-04-17 23:26:50 ESTATUS =  Activa','2024-04-17 23:26:51',_binary ''),(1486,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  165 con los siguientes datos:  TITULO CORTESIA =  Tnte. NOMBRE= Yair PRIMER APELLIDO =  Jiménez SEGUNDO APELLIDO =   González FECHA NACIMIENTO =  1984-01-07 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  B+ ESTATUS =   FECHA REGISTRO =  2023-06-23 11:00:59 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:51',_binary ''),(1487,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  165 con los siguientes datos:  NOMBRE USUARIO=  Tnte. Yair Jiménez  González PASSWORD =  TIPO =  Instructor ESTATUS CONEXIÓN =  Offline ULTIMA CONEXIÓN =  2023-11-15 10:57:39','2024-04-17 23:26:51',_binary ''),(1488,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  165 con los siguientes datos:  NOMBRE =  Colchoneta para ejercicios MARCA =  FlexiStretch PRECIO ACTUAL =  40.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:51',_binary ''),(1489,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  65 con los siguientes datos:  USUARIO ID =  Tnte. Yair Jiménez  González PRODUCTO ID =  Colchoneta para ejercicios FlexiStretch 40.00 TOTAL =  30.00 FECHA REGISTRO =  2021-07-10 19:32:56 ESTATUS =  Activa','2024-04-17 23:26:51',_binary ''),(1490,'root@localhost','Create','detalles_pedidos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  15 con los siguientes datos:  PEDIDO ID =  165 30.00 2021-07-10 19:32:56 PRODUCTO ID =  Barritas energéticas MuscleFlow CANTIDAD =  500 TOTAL PARCIAL =  90.00 FECHA REGISTRO =  2020-01-14 13:54:25 FECHA ENTREGA =  2024-04-17 23:26:50 ESTATUS =  Activa','2024-04-17 23:26:51',_binary ''),(1491,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  166 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Suri PRIMER APELLIDO =  Santiago SEGUNDO APELLIDO =  Salazar FECHA NACIMIENTO =  1985-05-27 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  A- ESTATUS =   FECHA REGISTRO =  2020-08-18 11:26:27 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:51',_binary ''),(1492,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  166 con los siguientes datos:  NOMBRE USUARIO=  Suri Santiago Salazar PASSWORD =  TIPO =  Instructor ESTATUS CONEXIÓN =  Online ULTIMA CONEXIÓN =  2022-08-27 13:18:23','2024-04-17 23:26:51',_binary ''),(1493,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  166 con los siguientes datos:  NOMBRE =  Rodillo de espuma para masaje muscular MARCA =  PowerLift PRECIO ACTUAL =  60.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:51',_binary ''),(1494,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  66 con los siguientes datos:  USUARIO ID =  Suri Santiago Salazar PRODUCTO ID =  Rodillo de espuma para masaje muscular PowerLift 60.00 TOTAL =  50.00 FECHA REGISTRO =  2022-06-28 14:36:11 ESTATUS =  Activa','2024-04-17 23:26:51',_binary ''),(1495,'root@localhost','Create','detalles_pedidos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  16 con los siguientes datos:  PEDIDO ID =  166 50.00 2022-06-28 14:36:11 PRODUCTO ID =  Barritas energéticas MuscleFlow CANTIDAD =  10 TOTAL PARCIAL =  50.00 FECHA REGISTRO =  2020-01-10 17:40:19 FECHA ENTREGA =  2024-04-17 23:26:50 ESTATUS =  Activa','2024-04-17 23:26:51',_binary ''),(1496,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  167 con los siguientes datos:  TITULO CORTESIA =  Srita NOMBRE= Paula PRIMER APELLIDO =  Bautista SEGUNDO APELLIDO =  Rodríguez FECHA NACIMIENTO =  1997-07-14 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  AB+ ESTATUS =   FECHA REGISTRO =  2020-10-27 13:15:36 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:51',_binary ''),(1497,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  167 con los siguientes datos:  NOMBRE USUARIO=  Srita Paula Bautista Rodríguez PASSWORD =  TIPO =  Miembro ESTATUS CONEXIÓN =  Banned ULTIMA CONEXIÓN =  2024-04-14 16:08:46','2024-04-17 23:26:51',_binary ''),(1498,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  167 con los siguientes datos:  NOMBRE =  Banda de resistencia para entrenamiento MARCA =  PowerStim PRECIO ACTUAL =  70.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:51',_binary ''),(1499,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  67 con los siguientes datos:  USUARIO ID =  Srita Paula Bautista Rodríguez PRODUCTO ID =  Banda de resistencia para entrenamiento PowerStim 70.00 TOTAL =  40.00 FECHA REGISTRO =  2023-03-28 16:55:49 ESTATUS =  Activa','2024-04-17 23:26:51',_binary ''),(1500,'root@localhost','Create','detalles_pedidos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  17 con los siguientes datos:  PEDIDO ID =  167 40.00 2023-03-28 16:55:49 PRODUCTO ID =  Barritas energéticas MuscleFlow CANTIDAD =  450 TOTAL PARCIAL =  10.00 FECHA REGISTRO =  2024-02-16 15:11:21 FECHA ENTREGA =  2024-04-17 23:26:50 ESTATUS =  Activa','2024-04-17 23:26:51',_binary ''),(1501,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  168 con los siguientes datos:  TITULO CORTESIA =  Ing. NOMBRE= Ameli PRIMER APELLIDO =  Méndez SEGUNDO APELLIDO =  Pérez FECHA NACIMIENTO =  2005-03-03 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  B+ ESTATUS =   FECHA REGISTRO =  2023-07-24 09:56:18 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:51',_binary ''),(1502,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  168 con los siguientes datos:  NOMBRE USUARIO=  Ing. Ameli Méndez Pérez PASSWORD =  TIPO =  Visitante ESTATUS CONEXIÓN =  Online ULTIMA CONEXIÓN =  2024-01-13 18:18:49','2024-04-17 23:26:51',_binary ''),(1503,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  168 con los siguientes datos:  NOMBRE =  Esterilla de yoga MARCA =  MuscleRelief PRECIO ACTUAL =  10.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:51',_binary ''),(1504,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  68 con los siguientes datos:  USUARIO ID =  Ing. Ameli Méndez Pérez PRODUCTO ID =  Esterilla de yoga MuscleRelief 10.00 TOTAL =  80.00 FECHA REGISTRO =  2021-06-03 14:04:12 ESTATUS =  Activa','2024-04-17 23:26:51',_binary ''),(1505,'root@localhost','Create','detalles_pedidos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  18 con los siguientes datos:  PEDIDO ID =  168 80.00 2021-06-03 14:04:12 PRODUCTO ID =  Barritas energéticas MuscleFlow CANTIDAD =  450 TOTAL PARCIAL =  20.00 FECHA REGISTRO =  2020-11-14 14:20:23 FECHA ENTREGA =  2024-04-17 23:26:50 ESTATUS =  Activa','2024-04-17 23:26:51',_binary ''),(1506,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  169 con los siguientes datos:  TITULO CORTESIA =  C. NOMBRE= Ameli PRIMER APELLIDO =  Contreras SEGUNDO APELLIDO =  Torres FECHA NACIMIENTO =  1969-05-06 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  A+ ESTATUS =   FECHA REGISTRO =  2022-09-04 19:40:44 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:51',_binary ''),(1507,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  169 con los siguientes datos:  NOMBRE USUARIO=  C. Ameli Contreras Torres PASSWORD =  TIPO =  Instructor ESTATUS CONEXIÓN =  Online ULTIMA CONEXIÓN =  2023-03-12 13:00:46','2024-04-17 23:26:51',_binary ''),(1508,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  169 con los siguientes datos:  NOMBRE =  Bebida energética pre-entrenamiento MARCA =  FlexiMat PRECIO ACTUAL =  60.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:51',_binary ''),(1509,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  69 con los siguientes datos:  USUARIO ID =  C. Ameli Contreras Torres PRODUCTO ID =  Bebida energética pre-entrenamiento FlexiMat 60.00 TOTAL =  50.00 FECHA REGISTRO =  2023-01-17 10:14:44 ESTATUS =  Activa','2024-04-17 23:26:51',_binary ''),(1510,'root@localhost','Create','detalles_pedidos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  19 con los siguientes datos:  PEDIDO ID =  169 50.00 2023-01-17 10:14:44 PRODUCTO ID =  Barritas energéticas MuscleFlow CANTIDAD =  60 TOTAL PARCIAL =  50.00 FECHA REGISTRO =  2024-03-11 13:16:58 FECHA ENTREGA =  2024-04-17 23:26:50 ESTATUS =  Activa','2024-04-17 23:26:51',_binary ''),(1511,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  170 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Adalid PRIMER APELLIDO =  Luna SEGUNDO APELLIDO =  Martínez FECHA NACIMIENTO =  1992-10-14 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  B+ ESTATUS =   FECHA REGISTRO =  2021-08-14 08:20:13 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:51',_binary ''),(1512,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  170 con los siguientes datos:  NOMBRE USUARIO=  Adalid Luna Martínez PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Banned ULTIMA CONEXIÓN =  2023-09-27 08:47:05','2024-04-17 23:26:51',_binary ''),(1513,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  170 con los siguientes datos:  NOMBRE =  Cinturón de levantamiento de pesas MARCA =  FlexiBottle PRECIO ACTUAL =  100.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:51',_binary ''),(1514,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  70 con los siguientes datos:  USUARIO ID =  Adalid Luna Martínez PRODUCTO ID =  Cinturón de levantamiento de pesas FlexiBottle 100.00 TOTAL =  20.00 FECHA REGISTRO =  2023-11-08 19:58:11 ESTATUS =  Activa','2024-04-17 23:26:51',_binary ''),(1515,'root@localhost','Create','detalles_pedidos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  20 con los siguientes datos:  PEDIDO ID =  170 20.00 2023-11-08 19:58:11 PRODUCTO ID =  Barritas energéticas MuscleFlow CANTIDAD =  380 TOTAL PARCIAL =  50.00 FECHA REGISTRO =  2022-05-18 11:38:38 FECHA ENTREGA =  2024-04-17 23:26:50 ESTATUS =  Activa','2024-04-17 23:26:51',_binary ''),(1516,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  171 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Gerardo PRIMER APELLIDO =  Gutiérrez SEGUNDO APELLIDO =  Estrada FECHA NACIMIENTO =  1987-12-12 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  A+ ESTATUS =   FECHA REGISTRO =  2023-07-09 17:00:53 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:51',_binary ''),(1517,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  171 con los siguientes datos:  NOMBRE USUARIO=  Gerardo Gutiérrez Estrada PASSWORD =  TIPO =  Visitante ESTATUS CONEXIÓN =  Online ULTIMA CONEXIÓN =  2023-10-05 18:00:44','2024-04-17 23:26:51',_binary ''),(1518,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  171 con los siguientes datos:  NOMBRE =  Barritas energéticas MARCA =  PowerBands PRECIO ACTUAL =  70.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:51',_binary ''),(1519,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  71 con los siguientes datos:  USUARIO ID =  Gerardo Gutiérrez Estrada PRODUCTO ID =  Barritas energéticas PowerBands 70.00 TOTAL =  40.00 FECHA REGISTRO =  2022-11-20 12:08:39 ESTATUS =  Activa','2024-04-17 23:26:51',_binary ''),(1520,'root@localhost','Create','detalles_pedidos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  21 con los siguientes datos:  PEDIDO ID =  171 40.00 2022-11-20 12:08:39 PRODUCTO ID =  Barritas energéticas MuscleFlow CANTIDAD =  500 TOTAL PARCIAL =  60.00 FECHA REGISTRO =  2021-11-30 16:11:42 FECHA ENTREGA =  2024-04-17 23:26:50 ESTATUS =  Activa','2024-04-17 23:26:51',_binary ''),(1521,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  172 con los siguientes datos:  TITULO CORTESIA =  Lic. NOMBRE= Gustavo PRIMER APELLIDO =  Soto SEGUNDO APELLIDO =  Pérez FECHA NACIMIENTO =  1989-05-02 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  AB- ESTATUS =   FECHA REGISTRO =  2023-05-07 16:41:24 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:51',_binary ''),(1522,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  172 con los siguientes datos:  NOMBRE USUARIO=  Lic. Gustavo Soto Pérez PASSWORD =  TIPO =  Visitante ESTATUS CONEXIÓN =  Online ULTIMA CONEXIÓN =  2023-09-16 09:58:50','2024-04-17 23:26:51',_binary ''),(1523,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  172 con los siguientes datos:  NOMBRE =  Termogénico para quemar grasa MARCA =  PowerSprint PRECIO ACTUAL =  60.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:51',_binary ''),(1524,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  72 con los siguientes datos:  USUARIO ID =  Lic. Gustavo Soto Pérez PRODUCTO ID =  Termogénico para quemar grasa PowerSprint 60.00 TOTAL =  100.00 FECHA REGISTRO =  2020-08-25 18:41:48 ESTATUS =  Activa','2024-04-17 23:26:51',_binary ''),(1525,'root@localhost','Create','detalles_pedidos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  22 con los siguientes datos:  PEDIDO ID =  172 100.00 2020-08-25 18:41:48 PRODUCTO ID =  Barritas energéticas MuscleFlow CANTIDAD =  10 TOTAL PARCIAL =  40.00 FECHA REGISTRO =  2022-12-06 12:46:54 FECHA ENTREGA =  2024-04-17 23:26:50 ESTATUS =  Activa','2024-04-17 23:26:51',_binary ''),(1526,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  173 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Lucía PRIMER APELLIDO =  Moreno SEGUNDO APELLIDO =  Estrada FECHA NACIMIENTO =  1972-08-13 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  AB+ ESTATUS =   FECHA REGISTRO =  2023-10-20 17:40:00 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:51',_binary ''),(1527,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  173 con los siguientes datos:  NOMBRE USUARIO=  Lucía Moreno Estrada PASSWORD =  TIPO =  Visitante ESTATUS CONEXIÓN =  Offline ULTIMA CONEXIÓN =  2023-11-07 10:15:59','2024-04-17 23:26:51',_binary ''),(1528,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  173 con los siguientes datos:  NOMBRE =  Magnesio para mejorar el agarre MARCA =  MuscleEase PRECIO ACTUAL =  10.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:51',_binary ''),(1529,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  73 con los siguientes datos:  USUARIO ID =  Lucía Moreno Estrada PRODUCTO ID =  Magnesio para mejorar el agarre MuscleEase 10.00 TOTAL =  60.00 FECHA REGISTRO =  2022-01-14 17:20:18 ESTATUS =  Activa','2024-04-17 23:26:51',_binary ''),(1530,'root@localhost','Create','detalles_pedidos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  23 con los siguientes datos:  PEDIDO ID =  173 60.00 2022-01-14 17:20:18 PRODUCTO ID =  Barritas energéticas MuscleFlow CANTIDAD =  450 TOTAL PARCIAL =  10.00 FECHA REGISTRO =  2022-08-16 08:33:28 FECHA ENTREGA =  2024-04-17 23:26:50 ESTATUS =  Activa','2024-04-17 23:26:51',_binary ''),(1531,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  174 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Luz PRIMER APELLIDO =  Guerrero SEGUNDO APELLIDO =  Vázquez FECHA NACIMIENTO =  1987-07-21 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  A+ ESTATUS =   FECHA REGISTRO =  2023-04-03 13:56:36 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:51',_binary ''),(1532,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  174 con los siguientes datos:  NOMBRE USUARIO=  Luz Guerrero Vázquez PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Offline ULTIMA CONEXIÓN =  2023-04-22 15:52:29','2024-04-17 23:26:51',_binary ''),(1533,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  174 con los siguientes datos:  NOMBRE =  Bebida energética pre-entrenamiento MARCA =  PowerBands PRECIO ACTUAL =  10.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:51',_binary ''),(1534,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  74 con los siguientes datos:  USUARIO ID =  Luz Guerrero Vázquez PRODUCTO ID =  Bebida energética pre-entrenamiento PowerBands 10.00 TOTAL =  100.00 FECHA REGISTRO =  2023-08-14 11:38:54 ESTATUS =  Activa','2024-04-17 23:26:51',_binary ''),(1535,'root@localhost','Create','detalles_pedidos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  24 con los siguientes datos:  PEDIDO ID =  174 100.00 2023-08-14 11:38:54 PRODUCTO ID =  Barritas energéticas MuscleFlow CANTIDAD =  60 TOTAL PARCIAL =  10.00 FECHA REGISTRO =  2021-05-10 12:47:56 FECHA ENTREGA =  2024-04-17 23:26:50 ESTATUS =  Activa','2024-04-17 23:26:51',_binary ''),(1536,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  175 con los siguientes datos:  TITULO CORTESIA =  Sr. NOMBRE= Adan PRIMER APELLIDO =  Reyes SEGUNDO APELLIDO =  De la Cruz FECHA NACIMIENTO =  1964-06-18 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  A- ESTATUS =   FECHA REGISTRO =  2021-11-25 17:06:14 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:51',_binary ''),(1537,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  175 con los siguientes datos:  NOMBRE USUARIO=  Sr. Adan Reyes De la Cruz PASSWORD =  TIPO =  Visitante ESTATUS CONEXIÓN =  Online ULTIMA CONEXIÓN =  2023-12-03 08:56:31','2024-04-17 23:26:51',_binary ''),(1538,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  175 con los siguientes datos:  NOMBRE =  Bloque de espuma para estiramientos MARCA =  MuscleMax PRECIO ACTUAL =  80.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:51',_binary ''),(1539,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  75 con los siguientes datos:  USUARIO ID =  Sr. Adan Reyes De la Cruz PRODUCTO ID =  Bloque de espuma para estiramientos MuscleMax 80.00 TOTAL =  50.00 FECHA REGISTRO =  2020-10-28 14:19:16 ESTATUS =  Activa','2024-04-17 23:26:51',_binary ''),(1540,'root@localhost','Create','detalles_pedidos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  25 con los siguientes datos:  PEDIDO ID =  175 50.00 2020-10-28 14:19:16 PRODUCTO ID =  Barritas energéticas MuscleFlow CANTIDAD =  10 TOTAL PARCIAL =  80.00 FECHA REGISTRO =  2021-06-29 15:31:35 FECHA ENTREGA =  2024-04-17 23:26:50 ESTATUS =  Activa','2024-04-17 23:26:51',_binary ''),(1541,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  176 con los siguientes datos:  TITULO CORTESIA =  Lic. NOMBRE= Diana PRIMER APELLIDO =  Ruíz SEGUNDO APELLIDO =  Álvarez FECHA NACIMIENTO =  1981-10-15 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  AB- ESTATUS =   FECHA REGISTRO =  2021-03-30 10:59:12 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:51',_binary ''),(1542,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  176 con los siguientes datos:  NOMBRE USUARIO=  Lic. Diana Ruíz Álvarez PASSWORD =  TIPO =  Visitante ESTATUS CONEXIÓN =  Online ULTIMA CONEXIÓN =  2022-10-26 10:21:51','2024-04-17 23:26:51',_binary ''),(1543,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  176 con los siguientes datos:  NOMBRE =  Banda de resistencia para entrenamiento MARCA =  MuscleEase PRECIO ACTUAL =  70.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:51',_binary ''),(1544,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  76 con los siguientes datos:  USUARIO ID =  Lic. Diana Ruíz Álvarez PRODUCTO ID =  Banda de resistencia para entrenamiento MuscleEase 70.00 TOTAL =  50.00 FECHA REGISTRO =  2020-10-19 16:04:23 ESTATUS =  Activa','2024-04-17 23:26:51',_binary ''),(1545,'root@localhost','Create','detalles_pedidos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  26 con los siguientes datos:  PEDIDO ID =  176 50.00 2020-10-19 16:04:23 PRODUCTO ID =  Barritas energéticas MuscleFlow CANTIDAD =  60 TOTAL PARCIAL =  10.00 FECHA REGISTRO =  2022-08-17 08:30:53 FECHA ENTREGA =  2024-04-17 23:26:50 ESTATUS =  Activa','2024-04-17 23:26:51',_binary ''),(1546,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  177 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Paola PRIMER APELLIDO =  Cortes SEGUNDO APELLIDO =  Soto FECHA NACIMIENTO =  1971-06-11 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  B+ ESTATUS =   FECHA REGISTRO =  2023-03-04 17:37:09 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:51',_binary ''),(1547,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  177 con los siguientes datos:  NOMBRE USUARIO=  Paola Cortes Soto PASSWORD =  TIPO =  Instructor ESTATUS CONEXIÓN =  Offline ULTIMA CONEXIÓN =  2023-08-29 13:45:39','2024-04-17 23:26:51',_binary ''),(1548,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  177 con los siguientes datos:  NOMBRE =  Guantes para levantamiento de pesas MARCA =  CardioCharge PRECIO ACTUAL =  100.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:51',_binary ''),(1549,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  77 con los siguientes datos:  USUARIO ID =  Paola Cortes Soto PRODUCTO ID =  Guantes para levantamiento de pesas CardioCharge 100.00 TOTAL =  80.00 FECHA REGISTRO =  2023-03-19 14:18:28 ESTATUS =  Activa','2024-04-17 23:26:51',_binary ''),(1550,'root@localhost','Create','detalles_pedidos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  27 con los siguientes datos:  PEDIDO ID =  177 80.00 2023-03-19 14:18:28 PRODUCTO ID =  Barritas energéticas MuscleFlow CANTIDAD =  380 TOTAL PARCIAL =  40.00 FECHA REGISTRO =  2022-06-03 17:28:15 FECHA ENTREGA =  2024-04-17 23:26:50 ESTATUS =  Activa','2024-04-17 23:26:51',_binary ''),(1551,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  178 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Flor PRIMER APELLIDO =  Rodríguez SEGUNDO APELLIDO =  Torres FECHA NACIMIENTO =  1973-07-20 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  B- ESTATUS =   FECHA REGISTRO =  2021-07-29 13:53:06 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:51',_binary ''),(1552,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  178 con los siguientes datos:  NOMBRE USUARIO=  Flor Rodríguez Torres PASSWORD =  TIPO =  Visitante ESTATUS CONEXIÓN =  Online ULTIMA CONEXIÓN =  2022-08-08 08:20:25','2024-04-17 23:26:51',_binary ''),(1553,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  178 con los siguientes datos:  NOMBRE =  Batidos de proteínas MARCA =  PowerStim PRECIO ACTUAL =  80.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:51',_binary ''),(1554,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  78 con los siguientes datos:  USUARIO ID =  Flor Rodríguez Torres PRODUCTO ID =  Batidos de proteínas PowerStim 80.00 TOTAL =  10.00 FECHA REGISTRO =  2023-01-08 13:55:08 ESTATUS =  Activa','2024-04-17 23:26:51',_binary ''),(1555,'root@localhost','Create','detalles_pedidos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  28 con los siguientes datos:  PEDIDO ID =  178 10.00 2023-01-08 13:55:08 PRODUCTO ID =  Barritas energéticas MuscleFlow CANTIDAD =  380 TOTAL PARCIAL =  40.00 FECHA REGISTRO =  2021-12-04 11:58:41 FECHA ENTREGA =  2024-04-17 23:26:50 ESTATUS =  Activa','2024-04-17 23:26:51',_binary ''),(1556,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  179 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Paula PRIMER APELLIDO =  Guzmán SEGUNDO APELLIDO =   González FECHA NACIMIENTO =  1969-09-25 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  O+ ESTATUS =   FECHA REGISTRO =  2021-03-08 08:21:43 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:51',_binary ''),(1557,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  179 con los siguientes datos:  NOMBRE USUARIO=  Paula Guzmán  González PASSWORD =  TIPO =  Visitante ESTATUS CONEXIÓN =  Offline ULTIMA CONEXIÓN =  2023-03-29 16:42:03','2024-04-17 23:26:51',_binary ''),(1558,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  179 con los siguientes datos:  NOMBRE =  Magnesio para mejorar el agarre MARCA =  CardioCharge PRECIO ACTUAL =  30.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:51',_binary ''),(1559,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  79 con los siguientes datos:  USUARIO ID =  Paula Guzmán  González PRODUCTO ID =  Magnesio para mejorar el agarre CardioCharge 30.00 TOTAL =  30.00 FECHA REGISTRO =  2021-12-23 14:21:17 ESTATUS =  Activa','2024-04-17 23:26:51',_binary ''),(1560,'root@localhost','Create','detalles_pedidos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  29 con los siguientes datos:  PEDIDO ID =  179 30.00 2021-12-23 14:21:17 PRODUCTO ID =  Barritas energéticas MuscleFlow CANTIDAD =  380 TOTAL PARCIAL =  80.00 FECHA REGISTRO =  2023-11-20 11:38:01 FECHA ENTREGA =  2024-04-17 23:26:50 ESTATUS =  Activa','2024-04-17 23:26:51',_binary ''),(1561,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  180 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Juan PRIMER APELLIDO =  Cortés SEGUNDO APELLIDO =  Castro FECHA NACIMIENTO =  1989-12-17 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  A+ ESTATUS =   FECHA REGISTRO =  2020-09-11 17:26:28 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:51',_binary ''),(1562,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  180 con los siguientes datos:  NOMBRE USUARIO=  Juan Cortés Castro PASSWORD =  TIPO =  Visitante ESTATUS CONEXIÓN =  Banned ULTIMA CONEXIÓN =  2020-11-05 14:57:58','2024-04-17 23:26:51',_binary ''),(1563,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  180 con los siguientes datos:  NOMBRE =  Colchoneta para ejercicios MARCA =  FlexiStretch PRECIO ACTUAL =  40.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:51',_binary ''),(1564,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  80 con los siguientes datos:  USUARIO ID =  Juan Cortés Castro PRODUCTO ID =  Colchoneta para ejercicios FlexiStretch 40.00 TOTAL =  40.00 FECHA REGISTRO =  2023-09-12 09:39:59 ESTATUS =  Activa','2024-04-17 23:26:51',_binary ''),(1565,'root@localhost','Create','detalles_pedidos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  30 con los siguientes datos:  PEDIDO ID =  180 40.00 2023-09-12 09:39:59 PRODUCTO ID =  Barritas energéticas MuscleFlow CANTIDAD =  10 TOTAL PARCIAL =  20.00 FECHA REGISTRO =  2021-08-29 13:58:29 FECHA ENTREGA =  2024-04-17 23:26:50 ESTATUS =  Activa','2024-04-17 23:26:51',_binary ''),(1566,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  181 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Carlos PRIMER APELLIDO =  Álvarez SEGUNDO APELLIDO =  Vázquez FECHA NACIMIENTO =  1995-10-20 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  O- ESTATUS =   FECHA REGISTRO =  2021-06-12 19:16:40 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:51',_binary ''),(1567,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  181 con los siguientes datos:  NOMBRE USUARIO=  Carlos Álvarez Vázquez PASSWORD =  TIPO =  Miembro ESTATUS CONEXIÓN =  Offline ULTIMA CONEXIÓN =  2021-08-24 13:38:48','2024-04-17 23:26:51',_binary ''),(1568,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  181 con los siguientes datos:  NOMBRE =  Bebida energética pre-entrenamiento MARCA =  FlexiBand PRECIO ACTUAL =  10.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:51',_binary ''),(1569,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  81 con los siguientes datos:  USUARIO ID =  Carlos Álvarez Vázquez PRODUCTO ID =  Bebida energética pre-entrenamiento FlexiBand 10.00 TOTAL =  30.00 FECHA REGISTRO =  2021-03-23 15:13:22 ESTATUS =  Activa','2024-04-17 23:26:51',_binary ''),(1570,'root@localhost','Create','detalles_pedidos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  31 con los siguientes datos:  PEDIDO ID =  181 30.00 2021-03-23 15:13:22 PRODUCTO ID =  Barritas energéticas MuscleFlow CANTIDAD =  10 TOTAL PARCIAL =  100.00 FECHA REGISTRO =  2021-08-09 19:35:47 FECHA ENTREGA =  2024-04-17 23:26:50 ESTATUS =  Activa','2024-04-17 23:26:51',_binary ''),(1571,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  182 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Dulce PRIMER APELLIDO =  Castro SEGUNDO APELLIDO =  Ramírez FECHA NACIMIENTO =  1993-11-05 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  A+ ESTATUS =   FECHA REGISTRO =  2024-02-20 17:13:20 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:51',_binary ''),(1572,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  182 con los siguientes datos:  NOMBRE USUARIO=  Dulce Castro Ramírez PASSWORD =  TIPO =  Instructor ESTATUS CONEXIÓN =  Offline ULTIMA CONEXIÓN =  2024-03-16 17:57:58','2024-04-17 23:26:51',_binary ''),(1573,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  182 con los siguientes datos:  NOMBRE =  Bebida energética post-entrenamiento MARCA =  FlexiBlock PRECIO ACTUAL =  80.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:51',_binary ''),(1574,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  82 con los siguientes datos:  USUARIO ID =  Dulce Castro Ramírez PRODUCTO ID =  Bebida energética post-entrenamiento FlexiBlock 80.00 TOTAL =  70.00 FECHA REGISTRO =  2024-03-15 08:26:13 ESTATUS =  Activa','2024-04-17 23:26:51',_binary ''),(1575,'root@localhost','Create','detalles_pedidos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  32 con los siguientes datos:  PEDIDO ID =  182 70.00 2024-03-15 08:26:13 PRODUCTO ID =  Barritas energéticas MuscleFlow CANTIDAD =  380 TOTAL PARCIAL =  20.00 FECHA REGISTRO =  2023-09-08 19:13:16 FECHA ENTREGA =  2024-04-17 23:26:50 ESTATUS =  Activa','2024-04-17 23:26:51',_binary ''),(1576,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  183 con los siguientes datos:  TITULO CORTESIA =  Srita NOMBRE= Flor PRIMER APELLIDO =  Aguilar SEGUNDO APELLIDO =  Velázquez FECHA NACIMIENTO =  1988-04-07 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  AB- ESTATUS =   FECHA REGISTRO =  2021-07-26 19:16:58 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:51',_binary ''),(1577,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  183 con los siguientes datos:  NOMBRE USUARIO=  Srita Flor Aguilar Velázquez PASSWORD =  TIPO =  Miembro ESTATUS CONEXIÓN =  Online ULTIMA CONEXIÓN =  2022-04-06 15:33:58','2024-04-17 23:26:51',_binary ''),(1578,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  183 con los siguientes datos:  NOMBRE =  Esterilla de yoga MARCA =  CardioCharge PRECIO ACTUAL =  10.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:51',_binary ''),(1579,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  83 con los siguientes datos:  USUARIO ID =  Srita Flor Aguilar Velázquez PRODUCTO ID =  Esterilla de yoga CardioCharge 10.00 TOTAL =  20.00 FECHA REGISTRO =  2021-09-18 16:05:57 ESTATUS =  Activa','2024-04-17 23:26:51',_binary ''),(1580,'root@localhost','Create','detalles_pedidos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  33 con los siguientes datos:  PEDIDO ID =  183 20.00 2021-09-18 16:05:57 PRODUCTO ID =  Barritas energéticas MuscleFlow CANTIDAD =  10 TOTAL PARCIAL =  90.00 FECHA REGISTRO =  2023-03-17 10:02:03 FECHA ENTREGA =  2024-04-17 23:26:50 ESTATUS =  Activa','2024-04-17 23:26:51',_binary ''),(1581,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  184 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Lucía PRIMER APELLIDO =  Moreno SEGUNDO APELLIDO =  Estrada FECHA NACIMIENTO =  1971-11-08 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  B- ESTATUS =   FECHA REGISTRO =  2022-08-16 15:30:54 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:51',_binary ''),(1582,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  184 con los siguientes datos:  NOMBRE USUARIO=  Lucía Moreno Estrada PASSWORD =  TIPO =  Visitante ESTATUS CONEXIÓN =  Offline ULTIMA CONEXIÓN =  2022-12-03 08:36:58','2024-04-17 23:26:51',_binary ''),(1583,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  184 con los siguientes datos:  NOMBRE =  Banda elástica para ejercicios de resistencia MARCA =  SpeedWrap PRECIO ACTUAL =  10.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:51',_binary ''),(1584,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  84 con los siguientes datos:  USUARIO ID =  Lucía Moreno Estrada PRODUCTO ID =  Banda elástica para ejercicios de resistencia SpeedWrap 10.00 TOTAL =  90.00 FECHA REGISTRO =  2021-04-13 18:06:03 ESTATUS =  Activa','2024-04-17 23:26:51',_binary ''),(1585,'root@localhost','Create','detalles_pedidos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  34 con los siguientes datos:  PEDIDO ID =  184 90.00 2021-04-13 18:06:03 PRODUCTO ID =  Barritas energéticas MuscleFlow CANTIDAD =  380 TOTAL PARCIAL =  10.00 FECHA REGISTRO =  2021-01-28 09:40:31 FECHA ENTREGA =  2024-04-17 23:26:50 ESTATUS =  Activa','2024-04-17 23:26:51',_binary ''),(1586,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  185 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Jorge PRIMER APELLIDO =  Castro SEGUNDO APELLIDO =  Gutiérrez FECHA NACIMIENTO =  1992-05-23 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  B+ ESTATUS =   FECHA REGISTRO =  2021-11-18 11:45:32 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:51',_binary ''),(1587,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  185 con los siguientes datos:  NOMBRE USUARIO=  Jorge Castro Gutiérrez PASSWORD =  TIPO =  Visitante ESTATUS CONEXIÓN =  Online ULTIMA CONEXIÓN =  2023-11-12 09:57:14','2024-04-17 23:26:51',_binary ''),(1588,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  185 con los siguientes datos:  NOMBRE =  Banda de resistencia para estiramientos MARCA =  PowerBurn PRECIO ACTUAL =  30.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:51',_binary ''),(1589,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  85 con los siguientes datos:  USUARIO ID =  Jorge Castro Gutiérrez PRODUCTO ID =  Banda de resistencia para estiramientos PowerBurn 30.00 TOTAL =  50.00 FECHA REGISTRO =  2022-10-22 17:51:57 ESTATUS =  Activa','2024-04-17 23:26:51',_binary ''),(1590,'root@localhost','Create','detalles_pedidos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  35 con los siguientes datos:  PEDIDO ID =  185 50.00 2022-10-22 17:51:57 PRODUCTO ID =  Barritas energéticas MuscleFlow CANTIDAD =  10 TOTAL PARCIAL =  30.00 FECHA REGISTRO =  2024-01-29 18:54:49 FECHA ENTREGA =  2024-04-17 23:26:50 ESTATUS =  Activa','2024-04-17 23:26:51',_binary ''),(1591,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  186 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Brenda PRIMER APELLIDO =  Díaz SEGUNDO APELLIDO =   Rivera FECHA NACIMIENTO =  2003-12-25 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  O+ ESTATUS =   FECHA REGISTRO =  2020-06-15 10:42:46 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:51',_binary ''),(1592,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  186 con los siguientes datos:  NOMBRE USUARIO=  Brenda Díaz  Rivera PASSWORD =  TIPO =  Instructor ESTATUS CONEXIÓN =  Offline ULTIMA CONEXIÓN =  2022-03-26 10:05:53','2024-04-17 23:26:51',_binary ''),(1593,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  186 con los siguientes datos:  NOMBRE =  Bebida isotónica MARCA =  PowerSprint PRECIO ACTUAL =  10.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:51',_binary ''),(1594,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  86 con los siguientes datos:  USUARIO ID =  Brenda Díaz  Rivera PRODUCTO ID =  Bebida isotónica PowerSprint 10.00 TOTAL =  70.00 FECHA REGISTRO =  2020-04-04 11:57:01 ESTATUS =  Activa','2024-04-17 23:26:51',_binary ''),(1595,'root@localhost','Create','detalles_pedidos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  36 con los siguientes datos:  PEDIDO ID =  186 70.00 2020-04-04 11:57:01 PRODUCTO ID =  Barritas energéticas MuscleFlow CANTIDAD =  450 TOTAL PARCIAL =  40.00 FECHA REGISTRO =  2021-04-07 13:31:40 FECHA ENTREGA =  2024-04-17 23:26:50 ESTATUS =  Activa','2024-04-17 23:26:51',_binary ''),(1596,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  187 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Karla PRIMER APELLIDO =  Díaz SEGUNDO APELLIDO =  Salazar FECHA NACIMIENTO =  1965-06-14 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  A- ESTATUS =   FECHA REGISTRO =  2021-04-19 09:15:51 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:51',_binary ''),(1597,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  187 con los siguientes datos:  NOMBRE USUARIO=  Karla Díaz Salazar PASSWORD =  TIPO =  Miembro ESTATUS CONEXIÓN =  Banned ULTIMA CONEXIÓN =  2021-05-25 18:00:33','2024-04-17 23:26:51',_binary ''),(1598,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  187 con los siguientes datos:  NOMBRE =  Guantes para levantamiento de pesas MARCA =  PowerLift PRECIO ACTUAL =  10.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:51',_binary ''),(1599,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  87 con los siguientes datos:  USUARIO ID =  Karla Díaz Salazar PRODUCTO ID =  Guantes para levantamiento de pesas PowerLift 10.00 TOTAL =  60.00 FECHA REGISTRO =  2023-04-30 10:02:47 ESTATUS =  Activa','2024-04-17 23:26:51',_binary ''),(1600,'root@localhost','Create','detalles_pedidos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  37 con los siguientes datos:  PEDIDO ID =  187 60.00 2023-04-30 10:02:47 PRODUCTO ID =  Barritas energéticas MuscleFlow CANTIDAD =  450 TOTAL PARCIAL =  20.00 FECHA REGISTRO =  2020-04-23 19:36:34 FECHA ENTREGA =  2024-04-17 23:26:50 ESTATUS =  Activa','2024-04-17 23:26:51',_binary ''),(1601,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  188 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Alejandro PRIMER APELLIDO =  García SEGUNDO APELLIDO =  Guzmán FECHA NACIMIENTO =  1992-11-28 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  A- ESTATUS =   FECHA REGISTRO =  2023-07-11 14:53:49 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:51',_binary ''),(1602,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  188 con los siguientes datos:  NOMBRE USUARIO=  Alejandro García Guzmán PASSWORD =  TIPO =  Visitante ESTATUS CONEXIÓN =  Offline ULTIMA CONEXIÓN =  2023-11-16 11:12:26','2024-04-17 23:26:51',_binary ''),(1603,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  188 con los siguientes datos:  NOMBRE =  Cinturón de levantamiento de pesas MARCA =  FlexiGrip PRECIO ACTUAL =  30.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:51',_binary ''),(1604,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  88 con los siguientes datos:  USUARIO ID =  Alejandro García Guzmán PRODUCTO ID =  Cinturón de levantamiento de pesas FlexiGrip 30.00 TOTAL =  20.00 FECHA REGISTRO =  2023-09-30 08:04:28 ESTATUS =  Activa','2024-04-17 23:26:51',_binary ''),(1605,'root@localhost','Create','detalles_pedidos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  38 con los siguientes datos:  PEDIDO ID =  188 20.00 2023-09-30 08:04:28 PRODUCTO ID =  Barritas energéticas MuscleFlow CANTIDAD =  450 TOTAL PARCIAL =  10.00 FECHA REGISTRO =  2020-01-15 18:45:24 FECHA ENTREGA =  2024-04-17 23:26:50 ESTATUS =  Activa','2024-04-17 23:26:51',_binary ''),(1606,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  189 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Hortencia PRIMER APELLIDO =  Cortés SEGUNDO APELLIDO =  Cruz FECHA NACIMIENTO =  1960-10-18 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  AB+ ESTATUS =   FECHA REGISTRO =  2024-01-10 18:24:26 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:51',_binary ''),(1607,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  189 con los siguientes datos:  NOMBRE USUARIO=  Hortencia Cortés Cruz PASSWORD =  TIPO =  Miembro ESTATUS CONEXIÓN =  Online ULTIMA CONEXIÓN =  2024-03-04 16:12:36','2024-04-17 23:26:51',_binary ''),(1608,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  189 con los siguientes datos:  NOMBRE =  Colchoneta para ejercicios MARCA =  SpeedSpike PRECIO ACTUAL =  60.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:51',_binary ''),(1609,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  89 con los siguientes datos:  USUARIO ID =  Hortencia Cortés Cruz PRODUCTO ID =  Colchoneta para ejercicios SpeedSpike 60.00 TOTAL =  50.00 FECHA REGISTRO =  2022-01-27 09:43:46 ESTATUS =  Activa','2024-04-17 23:26:51',_binary ''),(1610,'root@localhost','Create','detalles_pedidos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  39 con los siguientes datos:  PEDIDO ID =  189 50.00 2022-01-27 09:43:46 PRODUCTO ID =  Barritas energéticas MuscleFlow CANTIDAD =  380 TOTAL PARCIAL =  100.00 FECHA REGISTRO =  2023-06-25 11:18:36 FECHA ENTREGA =  2024-04-17 23:26:50 ESTATUS =  Activa','2024-04-17 23:26:51',_binary ''),(1611,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  190 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Brenda PRIMER APELLIDO =  Estrada SEGUNDO APELLIDO =  Moreno FECHA NACIMIENTO =  1987-05-27 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  B- ESTATUS =   FECHA REGISTRO =  2021-12-15 19:39:17 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:51',_binary ''),(1612,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  190 con los siguientes datos:  NOMBRE USUARIO=  Brenda Estrada Moreno PASSWORD =  TIPO =  Visitante ESTATUS CONEXIÓN =  Offline ULTIMA CONEXIÓN =  2022-06-13 13:22:46','2024-04-17 23:26:51',_binary ''),(1613,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  190 con los siguientes datos:  NOMBRE =  Magnesio para mejorar el agarre MARCA =  FlexiRing PRECIO ACTUAL =  70.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:51',_binary ''),(1614,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  90 con los siguientes datos:  USUARIO ID =  Brenda Estrada Moreno PRODUCTO ID =  Magnesio para mejorar el agarre FlexiRing 70.00 TOTAL =  10.00 FECHA REGISTRO =  2022-06-14 14:51:16 ESTATUS =  Activa','2024-04-17 23:26:51',_binary ''),(1615,'root@localhost','Create','detalles_pedidos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  40 con los siguientes datos:  PEDIDO ID =  190 10.00 2022-06-14 14:51:16 PRODUCTO ID =  Barritas energéticas MuscleFlow CANTIDAD =  10 TOTAL PARCIAL =  10.00 FECHA REGISTRO =  2022-07-21 19:28:13 FECHA ENTREGA =  2024-04-17 23:26:50 ESTATUS =  Activa','2024-04-17 23:26:51',_binary ''),(1616,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  191 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Maximiliano PRIMER APELLIDO =   Rivera SEGUNDO APELLIDO =  Cortes FECHA NACIMIENTO =  1973-05-01 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  O+ ESTATUS =   FECHA REGISTRO =  2020-05-01 08:18:43 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:51',_binary ''),(1617,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  191 con los siguientes datos:  NOMBRE USUARIO=  Maximiliano  Rivera Cortes PASSWORD =  TIPO =  Instructor ESTATUS CONEXIÓN =  Offline ULTIMA CONEXIÓN =  2021-09-11 14:01:10','2024-04-17 23:26:51',_binary ''),(1618,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  191 con los siguientes datos:  NOMBRE =  Bebida isotónica MARCA =  FlexiGel PRECIO ACTUAL =  100.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:51',_binary ''),(1619,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  91 con los siguientes datos:  USUARIO ID =  Maximiliano  Rivera Cortes PRODUCTO ID =  Bebida isotónica FlexiGel 100.00 TOTAL =  100.00 FECHA REGISTRO =  2020-02-26 11:49:14 ESTATUS =  Activa','2024-04-17 23:26:51',_binary ''),(1620,'root@localhost','Create','detalles_pedidos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  41 con los siguientes datos:  PEDIDO ID =  191 100.00 2020-02-26 11:49:14 PRODUCTO ID =  Barritas energéticas MuscleFlow CANTIDAD =  450 TOTAL PARCIAL =  50.00 FECHA REGISTRO =  2023-10-13 08:02:29 FECHA ENTREGA =  2024-04-17 23:26:50 ESTATUS =  Activa','2024-04-17 23:26:51',_binary ''),(1621,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  192 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Suri PRIMER APELLIDO =  Ruíz SEGUNDO APELLIDO =  Ruíz FECHA NACIMIENTO =  1994-11-03 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  B- ESTATUS =   FECHA REGISTRO =  2020-12-23 16:20:40 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:51',_binary ''),(1622,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  192 con los siguientes datos:  NOMBRE USUARIO=  Suri Ruíz Ruíz PASSWORD =  TIPO =  Instructor ESTATUS CONEXIÓN =  Banned ULTIMA CONEXIÓN =  2021-02-14 14:45:38','2024-04-17 23:26:51',_binary ''),(1623,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  192 con los siguientes datos:  NOMBRE =  Termogénico para quemar grasa MARCA =  PowerBlitz PRECIO ACTUAL =  70.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:51',_binary ''),(1624,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  92 con los siguientes datos:  USUARIO ID =  Suri Ruíz Ruíz PRODUCTO ID =  Termogénico para quemar grasa PowerBlitz 70.00 TOTAL =  100.00 FECHA REGISTRO =  2023-01-14 17:25:23 ESTATUS =  Activa','2024-04-17 23:26:51',_binary ''),(1625,'root@localhost','Create','detalles_pedidos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  42 con los siguientes datos:  PEDIDO ID =  192 100.00 2023-01-14 17:25:23 PRODUCTO ID =  Barritas energéticas MuscleFlow CANTIDAD =  60 TOTAL PARCIAL =  70.00 FECHA REGISTRO =  2024-01-25 16:34:49 FECHA ENTREGA =  2024-04-17 23:26:50 ESTATUS =  Activa','2024-04-17 23:26:51',_binary ''),(1626,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  193 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Diana PRIMER APELLIDO =  Domínguez SEGUNDO APELLIDO =  Guerrero FECHA NACIMIENTO =  1988-03-12 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  A- ESTATUS =   FECHA REGISTRO =  2021-06-30 08:50:54 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:51',_binary ''),(1627,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  193 con los siguientes datos:  NOMBRE USUARIO=  Diana Domínguez Guerrero PASSWORD =  TIPO =  Visitante ESTATUS CONEXIÓN =  Online ULTIMA CONEXIÓN =  2023-07-17 15:55:21','2024-04-17 23:26:51',_binary ''),(1628,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  193 con los siguientes datos:  NOMBRE =  Bebida energética pre-entrenamiento MARCA =  FlexiBottle PRECIO ACTUAL =  50.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:51',_binary ''),(1629,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  93 con los siguientes datos:  USUARIO ID =  Diana Domínguez Guerrero PRODUCTO ID =  Bebida energética pre-entrenamiento FlexiBottle 50.00 TOTAL =  80.00 FECHA REGISTRO =  2020-11-02 17:28:31 ESTATUS =  Activa','2024-04-17 23:26:51',_binary ''),(1630,'root@localhost','Create','detalles_pedidos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  43 con los siguientes datos:  PEDIDO ID =  193 80.00 2020-11-02 17:28:31 PRODUCTO ID =  Barritas energéticas MuscleFlow CANTIDAD =  380 TOTAL PARCIAL =  50.00 FECHA REGISTRO =  2020-08-01 12:09:40 FECHA ENTREGA =  2024-04-17 23:26:50 ESTATUS =  Activa','2024-04-17 23:26:51',_binary ''),(1631,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  194 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Valeria PRIMER APELLIDO =  Soto SEGUNDO APELLIDO =   González FECHA NACIMIENTO =  1983-10-08 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  A- ESTATUS =   FECHA REGISTRO =  2022-08-04 12:16:30 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:51',_binary ''),(1632,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  194 con los siguientes datos:  NOMBRE USUARIO=  Valeria Soto  González PASSWORD =  TIPO =  Instructor ESTATUS CONEXIÓN =  Banned ULTIMA CONEXIÓN =  2022-08-12 16:34:21','2024-04-17 23:26:51',_binary ''),(1633,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  194 con los siguientes datos:  NOMBRE =  Correa de estiramiento MARCA =  FlexiPad PRECIO ACTUAL =  100.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:51',_binary ''),(1634,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  94 con los siguientes datos:  USUARIO ID =  Valeria Soto  González PRODUCTO ID =  Correa de estiramiento FlexiPad 100.00 TOTAL =  20.00 FECHA REGISTRO =  2020-05-05 18:20:11 ESTATUS =  Activa','2024-04-17 23:26:51',_binary ''),(1635,'root@localhost','Create','detalles_pedidos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  44 con los siguientes datos:  PEDIDO ID =  194 20.00 2020-05-05 18:20:11 PRODUCTO ID =  Barritas energéticas MuscleFlow CANTIDAD =  10 TOTAL PARCIAL =  80.00 FECHA REGISTRO =  2022-05-09 13:53:15 FECHA ENTREGA =  2024-04-17 23:26:50 ESTATUS =  Activa','2024-04-17 23:26:51',_binary ''),(1636,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  195 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Diana PRIMER APELLIDO =  Romero SEGUNDO APELLIDO =  Gómes FECHA NACIMIENTO =  1990-10-24 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  B- ESTATUS =   FECHA REGISTRO =  2022-06-11 12:08:56 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:51',_binary ''),(1637,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  195 con los siguientes datos:  NOMBRE USUARIO=  Diana Romero Gómes PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Online ULTIMA CONEXIÓN =  2022-12-25 10:58:16','2024-04-17 23:26:51',_binary ''),(1638,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  195 con los siguientes datos:  NOMBRE =  Esterilla de yoga MARCA =  MuscleMax PRECIO ACTUAL =  30.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:51',_binary ''),(1639,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  95 con los siguientes datos:  USUARIO ID =  Diana Romero Gómes PRODUCTO ID =  Esterilla de yoga MuscleMax 30.00 TOTAL =  100.00 FECHA REGISTRO =  2024-02-22 08:32:13 ESTATUS =  Activa','2024-04-17 23:26:51',_binary ''),(1640,'root@localhost','Create','detalles_pedidos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  45 con los siguientes datos:  PEDIDO ID =  195 100.00 2024-02-22 08:32:13 PRODUCTO ID =  Barritas energéticas MuscleFlow CANTIDAD =  380 TOTAL PARCIAL =  60.00 FECHA REGISTRO =  2022-07-26 13:12:04 FECHA ENTREGA =  2024-04-17 23:26:50 ESTATUS =  Activa','2024-04-17 23:26:51',_binary ''),(1641,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  196 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Brenda PRIMER APELLIDO =  Martínez SEGUNDO APELLIDO =  Bautista FECHA NACIMIENTO =  1990-04-21 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  B+ ESTATUS =   FECHA REGISTRO =  2022-09-26 11:09:38 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:51',_binary ''),(1642,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  196 con los siguientes datos:  NOMBRE USUARIO=  Brenda Martínez Bautista PASSWORD =  TIPO =  Visitante ESTATUS CONEXIÓN =  Online ULTIMA CONEXIÓN =  2024-04-09 10:26:37','2024-04-17 23:26:51',_binary ''),(1643,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  196 con los siguientes datos:  NOMBRE =  Guantes para levantamiento de pesas MARCA =  MusclePatch PRECIO ACTUAL =  40.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:51',_binary ''),(1644,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  96 con los siguientes datos:  USUARIO ID =  Brenda Martínez Bautista PRODUCTO ID =  Guantes para levantamiento de pesas MusclePatch 40.00 TOTAL =  60.00 FECHA REGISTRO =  2022-08-10 13:50:09 ESTATUS =  Activa','2024-04-17 23:26:51',_binary ''),(1645,'root@localhost','Create','detalles_pedidos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  46 con los siguientes datos:  PEDIDO ID =  196 60.00 2022-08-10 13:50:09 PRODUCTO ID =  Barritas energéticas MuscleFlow CANTIDAD =  500 TOTAL PARCIAL =  60.00 FECHA REGISTRO =  2020-08-01 18:46:54 FECHA ENTREGA =  2024-04-17 23:26:50 ESTATUS =  Activa','2024-04-17 23:26:51',_binary ''),(1646,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  197 con los siguientes datos:  TITULO CORTESIA =  Mtra NOMBRE= Flor PRIMER APELLIDO =  Guzmán SEGUNDO APELLIDO =  Ruíz FECHA NACIMIENTO =  1993-11-13 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  B+ ESTATUS =   FECHA REGISTRO =  2022-10-15 10:13:27 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:51',_binary ''),(1647,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  197 con los siguientes datos:  NOMBRE USUARIO=  Mtra Flor Guzmán Ruíz PASSWORD =  TIPO =  Instructor ESTATUS CONEXIÓN =  Offline ULTIMA CONEXIÓN =  2023-12-17 18:18:17','2024-04-17 23:26:51',_binary ''),(1648,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  197 con los siguientes datos:  NOMBRE =  Cinturón de levantamiento de pesas MARCA =  MuscleRelief PRECIO ACTUAL =  30.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:51',_binary ''),(1649,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  97 con los siguientes datos:  USUARIO ID =  Mtra Flor Guzmán Ruíz PRODUCTO ID =  Cinturón de levantamiento de pesas MuscleRelief 30.00 TOTAL =  60.00 FECHA REGISTRO =  2023-12-19 08:21:10 ESTATUS =  Activa','2024-04-17 23:26:51',_binary ''),(1650,'root@localhost','Create','detalles_pedidos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  47 con los siguientes datos:  PEDIDO ID =  197 60.00 2023-12-19 08:21:10 PRODUCTO ID =  Barritas energéticas MuscleFlow CANTIDAD =  380 TOTAL PARCIAL =  80.00 FECHA REGISTRO =  2023-09-22 19:13:08 FECHA ENTREGA =  2024-04-17 23:26:50 ESTATUS =  Activa','2024-04-17 23:26:51',_binary ''),(1651,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  198 con los siguientes datos:  TITULO CORTESIA =  Ing. NOMBRE= Karla PRIMER APELLIDO =  Castro SEGUNDO APELLIDO =  Juárez FECHA NACIMIENTO =  2007-01-21 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  A+ ESTATUS =   FECHA REGISTRO =  2020-10-27 18:40:27 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:51',_binary ''),(1652,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  198 con los siguientes datos:  NOMBRE USUARIO=  Ing. Karla Castro Juárez PASSWORD =  TIPO =  Instructor ESTATUS CONEXIÓN =  Banned ULTIMA CONEXIÓN =  2023-10-03 09:44:47','2024-04-17 23:26:51',_binary ''),(1653,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  198 con los siguientes datos:  NOMBRE =  Suplemento de creatina MARCA =  SpeedStep PRECIO ACTUAL =  10.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:51',_binary ''),(1654,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  98 con los siguientes datos:  USUARIO ID =  Ing. Karla Castro Juárez PRODUCTO ID =  Suplemento de creatina SpeedStep 10.00 TOTAL =  90.00 FECHA REGISTRO =  2020-04-28 17:07:23 ESTATUS =  Activa','2024-04-17 23:26:51',_binary ''),(1655,'root@localhost','Create','detalles_pedidos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  48 con los siguientes datos:  PEDIDO ID =  198 90.00 2020-04-28 17:07:23 PRODUCTO ID =  Barritas energéticas MuscleFlow CANTIDAD =  450 TOTAL PARCIAL =  60.00 FECHA REGISTRO =  2020-12-20 12:19:37 FECHA ENTREGA =  2024-04-17 23:26:50 ESTATUS =  Activa','2024-04-17 23:26:51',_binary ''),(1656,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  199 con los siguientes datos:  TITULO CORTESIA =  Mtra NOMBRE= Luz PRIMER APELLIDO =  Ortiz SEGUNDO APELLIDO =  Cortés FECHA NACIMIENTO =  1981-11-03 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  B- ESTATUS =   FECHA REGISTRO =  2022-12-04 10:00:45 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:51',_binary ''),(1657,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  199 con los siguientes datos:  NOMBRE USUARIO=  Mtra Luz Ortiz Cortés PASSWORD =  TIPO =  Instructor ESTATUS CONEXIÓN =  Offline ULTIMA CONEXIÓN =  2024-04-14 14:26:22','2024-04-17 23:26:51',_binary ''),(1658,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  199 con los siguientes datos:  NOMBRE =  Banda elástica para ejercicios de resistencia MARCA =  PowerSprint PRECIO ACTUAL =  50.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:51',_binary ''),(1659,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  99 con los siguientes datos:  USUARIO ID =  Mtra Luz Ortiz Cortés PRODUCTO ID =  Banda elástica para ejercicios de resistencia PowerSprint 50.00 TOTAL =  50.00 FECHA REGISTRO =  2020-04-03 18:23:44 ESTATUS =  Activa','2024-04-17 23:26:51',_binary ''),(1660,'root@localhost','Create','detalles_pedidos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  49 con los siguientes datos:  PEDIDO ID =  199 50.00 2020-04-03 18:23:44 PRODUCTO ID =  Barritas energéticas MuscleFlow CANTIDAD =  10 TOTAL PARCIAL =  20.00 FECHA REGISTRO =  2021-08-07 12:20:52 FECHA ENTREGA =  2024-04-17 23:26:50 ESTATUS =  Activa','2024-04-17 23:26:51',_binary ''),(1661,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  200 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Federico PRIMER APELLIDO =  Pérez SEGUNDO APELLIDO =  Cortés FECHA NACIMIENTO =  1986-04-06 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  O+ ESTATUS =   FECHA REGISTRO =  2022-02-09 19:39:13 FECHA ACTUALIZACIÓN = ','2024-04-17 23:26:51',_binary ''),(1662,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  200 con los siguientes datos:  NOMBRE USUARIO=  Federico Pérez Cortés PASSWORD =  TIPO =  Visitante ESTATUS CONEXIÓN =  Banned ULTIMA CONEXIÓN =  2023-12-04 09:59:38','2024-04-17 23:26:51',_binary ''),(1663,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  200 con los siguientes datos:  NOMBRE =  Banda de resistencia para estiramientos MARCA =  FlexiStrap PRECIO ACTUAL =  100.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:26:51',_binary ''),(1664,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  100 con los siguientes datos:  USUARIO ID =  Federico Pérez Cortés PRODUCTO ID =  Banda de resistencia para estiramientos FlexiStrap 100.00 TOTAL =  40.00 FECHA REGISTRO =  2023-01-16 14:27:06 ESTATUS =  Activa','2024-04-17 23:26:51',_binary ''),(1665,'root@localhost','Create','detalles_pedidos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  50 con los siguientes datos:  PEDIDO ID =  200 40.00 2023-01-16 14:27:06 PRODUCTO ID =  Barritas energéticas MuscleFlow CANTIDAD =  450 TOTAL PARCIAL =  30.00 FECHA REGISTRO =  2021-06-20 09:04:31 FECHA ENTREGA =  2024-04-17 23:26:50 ESTATUS =  Activa','2024-04-17 23:26:51',_binary ''),(1666,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  201 con los siguientes datos:  NOMBRE =  Banda de resistencia para entrenamiento MARCA =  PowerLift PRECIO ACTUAL =  100.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:29:11',_binary ''),(1667,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  202 con los siguientes datos:  NOMBRE =  Batidos de proteínas MARCA =  FlexiGel PRECIO ACTUAL =  30.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:30:14',_binary ''),(1668,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  203 con los siguientes datos:  NOMBRE =  Vendas para muñecas y tobillos MARCA =  FlexiRing PRECIO ACTUAL =  70.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:35:45',_binary ''),(1669,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  204 con los siguientes datos:  NOMBRE =  Rodillo de espuma para masaje muscular MARCA =  PowerFuel PRECIO ACTUAL =  90.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:38:21',_binary ''),(1670,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  205 con los siguientes datos:  NOMBRE =  Vendas para muñecas y tobillos MARCA =  FlexiGel PRECIO ACTUAL =  70.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:44:08',_binary ''),(1671,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  206 con los siguientes datos:  NOMBRE =  Colchoneta para ejercicios MARCA =  MuscleEase PRECIO ACTUAL =  60.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-17 23:44:22',_binary ''),(1672,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  207 con los siguientes datos:  NOMBRE =  Correa de estiramiento MARCA =  FlexiGrip PRECIO ACTUAL =  70.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 00:27:36',_binary ''),(1673,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  208 con los siguientes datos:  NOMBRE =  Esterilla de yoga MARCA =  FlexiBall PRECIO ACTUAL =  70.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 00:28:21',_binary ''),(1674,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  209 con los siguientes datos:  NOMBRE =  Suplemento de creatina MARCA =  FlexiRoll PRECIO ACTUAL =  20.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 00:29:17',_binary ''),(1675,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  210 con los siguientes datos:  NOMBRE =  Banda de resistencia para estiramientos MARCA =  FlexiFoam PRECIO ACTUAL =  20.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 00:29:27',_binary ''),(1676,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  211 con los siguientes datos:  NOMBRE =  Correa de estiramiento MARCA =  PowerBar PRECIO ACTUAL =  80.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 00:31:15',_binary ''),(1677,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  212 con los siguientes datos:  NOMBRE =  Guantes para levantamiento de pesas MARCA =  FlexiPod PRECIO ACTUAL =  50.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 00:31:22',_binary ''),(1678,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  213 con los siguientes datos:  NOMBRE =  Vendas para muñecas y tobillos MARCA =  FlexiBand PRECIO ACTUAL =  70.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 00:35:35',_binary ''),(1679,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  214 con los siguientes datos:  NOMBRE =  Guantes para levantamiento de pesas MARCA =  MuscleRelief PRECIO ACTUAL =  90.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 00:35:42',_binary ''),(1680,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  215 con los siguientes datos:  NOMBRE =  Bebida energética pre-entrenamiento MARCA =  PowerCharge PRECIO ACTUAL =  60.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 00:35:47',_binary ''),(1681,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  216 con los siguientes datos:  NOMBRE =  Guantes para levantamiento de pesas MARCA =  PowerFuel PRECIO ACTUAL =  30.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 00:36:12',_binary ''),(1682,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  217 con los siguientes datos:  NOMBRE =  Barritas energéticas MARCA =  FlexiStretch PRECIO ACTUAL =  100.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 00:41:06',_binary '');
/*!40000 ALTER TABLE `bitacora` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `detalles_pedidos`
--

DROP TABLE IF EXISTS `detalles_pedidos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `detalles_pedidos` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `Pedido_ID` int unsigned NOT NULL,
  `Producto_ID` int unsigned NOT NULL,
  `Cantidad` int NOT NULL,
  `Total_Parcial` decimal(6,2) NOT NULL,
  `Fecha_Registro` datetime DEFAULT CURRENT_TIMESTAMP,
  `Fecha_Entrega` datetime DEFAULT NULL,
  `Estatus` bit(1) NOT NULL DEFAULT b'1',
  PRIMARY KEY (`ID`),
  KEY `fk_pedido_1` (`Pedido_ID`),
  KEY `fk_producto_1` (`Producto_ID`),
  CONSTRAINT `fk_pedido_1` FOREIGN KEY (`Pedido_ID`) REFERENCES `pedidos` (`ID`),
  CONSTRAINT `fk_producto_1` FOREIGN KEY (`Producto_ID`) REFERENCES `productos` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detalles_pedidos`
--

LOCK TABLES `detalles_pedidos` WRITE;
/*!40000 ALTER TABLE `detalles_pedidos` DISABLE KEYS */;
INSERT INTO `detalles_pedidos` VALUES (1,51,1,10,80.00,'2020-12-22 19:35:29','2024-04-17 23:26:50',_binary ''),(2,52,1,10,50.00,'2020-03-04 18:46:15','2024-04-17 23:26:50',_binary ''),(3,53,1,60,30.00,'2023-02-21 18:43:28','2024-04-17 23:26:50',_binary ''),(4,54,1,10,50.00,'2024-03-29 15:49:44','2024-04-17 23:26:50',_binary ''),(5,55,1,10,40.00,'2020-05-01 13:22:40','2024-04-17 23:26:50',_binary ''),(6,56,1,380,60.00,'2020-07-06 17:37:40','2024-04-17 23:26:50',_binary ''),(7,57,1,10,70.00,'2020-12-11 09:02:57','2024-04-17 23:26:50',_binary ''),(8,58,1,10,20.00,'2021-03-02 19:53:12','2024-04-17 23:26:50',_binary ''),(9,59,1,450,30.00,'2023-04-19 08:46:24','2024-04-17 23:26:50',_binary ''),(10,60,1,60,80.00,'2024-01-30 13:09:06','2024-04-17 23:26:50',_binary ''),(11,61,1,10,20.00,'2020-04-07 19:51:09','2024-04-17 23:26:50',_binary ''),(12,62,1,10,90.00,'2020-03-24 16:29:42','2024-04-17 23:26:50',_binary ''),(13,63,1,450,100.00,'2023-06-23 11:48:03','2024-04-17 23:26:50',_binary ''),(14,64,1,10,60.00,'2022-03-03 18:52:00','2024-04-17 23:26:50',_binary ''),(15,65,1,500,90.00,'2020-01-14 13:54:25','2024-04-17 23:26:50',_binary ''),(16,66,1,10,50.00,'2020-01-10 17:40:19','2024-04-17 23:26:50',_binary ''),(17,67,1,450,10.00,'2024-02-16 15:11:21','2024-04-17 23:26:50',_binary ''),(18,68,1,450,20.00,'2020-11-14 14:20:23','2024-04-17 23:26:50',_binary ''),(19,69,1,60,50.00,'2024-03-11 13:16:58','2024-04-17 23:26:50',_binary ''),(20,70,1,380,50.00,'2022-05-18 11:38:38','2024-04-17 23:26:50',_binary ''),(21,71,1,500,60.00,'2021-11-30 16:11:42','2024-04-17 23:26:50',_binary ''),(22,72,1,10,40.00,'2022-12-06 12:46:54','2024-04-17 23:26:50',_binary ''),(23,73,1,450,10.00,'2022-08-16 08:33:28','2024-04-17 23:26:50',_binary ''),(24,74,1,60,10.00,'2021-05-10 12:47:56','2024-04-17 23:26:50',_binary ''),(25,75,1,10,80.00,'2021-06-29 15:31:35','2024-04-17 23:26:50',_binary ''),(26,76,1,60,10.00,'2022-08-17 08:30:53','2024-04-17 23:26:50',_binary ''),(27,77,1,380,40.00,'2022-06-03 17:28:15','2024-04-17 23:26:50',_binary ''),(28,78,1,380,40.00,'2021-12-04 11:58:41','2024-04-17 23:26:50',_binary ''),(29,79,1,380,80.00,'2023-11-20 11:38:01','2024-04-17 23:26:50',_binary ''),(30,80,1,10,20.00,'2021-08-29 13:58:29','2024-04-17 23:26:50',_binary ''),(31,81,1,10,100.00,'2021-08-09 19:35:47','2024-04-17 23:26:50',_binary ''),(32,82,1,380,20.00,'2023-09-08 19:13:16','2024-04-17 23:26:50',_binary ''),(33,83,1,10,90.00,'2023-03-17 10:02:03','2024-04-17 23:26:50',_binary ''),(34,84,1,380,10.00,'2021-01-28 09:40:31','2024-04-17 23:26:50',_binary ''),(35,85,1,10,30.00,'2024-01-29 18:54:49','2024-04-17 23:26:50',_binary ''),(36,86,1,450,40.00,'2021-04-07 13:31:40','2024-04-17 23:26:50',_binary ''),(37,87,1,450,20.00,'2020-04-23 19:36:34','2024-04-17 23:26:50',_binary ''),(38,88,1,450,10.00,'2020-01-15 18:45:24','2024-04-17 23:26:50',_binary ''),(39,89,1,380,100.00,'2023-06-25 11:18:36','2024-04-17 23:26:50',_binary ''),(40,90,1,10,10.00,'2022-07-21 19:28:13','2024-04-17 23:26:50',_binary ''),(41,91,1,450,50.00,'2023-10-13 08:02:29','2024-04-17 23:26:50',_binary ''),(42,92,1,60,70.00,'2024-01-25 16:34:49','2024-04-17 23:26:50',_binary ''),(43,93,1,380,50.00,'2020-08-01 12:09:40','2024-04-17 23:26:50',_binary ''),(44,94,1,10,80.00,'2022-05-09 13:53:15','2024-04-17 23:26:50',_binary ''),(45,95,1,380,60.00,'2022-07-26 13:12:04','2024-04-17 23:26:50',_binary ''),(46,96,1,500,60.00,'2020-08-01 18:46:54','2024-04-17 23:26:50',_binary ''),(47,97,1,380,80.00,'2023-09-22 19:13:08','2024-04-17 23:26:50',_binary ''),(48,98,1,450,60.00,'2020-12-20 12:19:37','2024-04-17 23:26:50',_binary ''),(49,99,1,10,20.00,'2021-08-07 12:20:52','2024-04-17 23:26:50',_binary ''),(50,100,1,450,30.00,'2021-06-20 09:04:31','2024-04-17 23:26:50',_binary '');
/*!40000 ALTER TABLE `detalles_pedidos` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `detalles_pedidos_AFTER_INSERT` AFTER INSERT ON `detalles_pedidos` FOR EACH ROW BEGIN
	-- Declaración de variables
    DECLARE v_cadena_estatus varchar(15) default null;
    DECLARE v_nombre_pedido varchar(60) default null;
    DECLARE v_nombre_producto varchar(60) default null;

    -- Iniciación de las variables
    IF new.estatus = b'1' then
        set v_cadena_estatus = "Activa";
    else
        set v_cadena_estatus = "Inactiva";
    end if;

    if new.pedido_id is not null then
        -- En caso de tener el id del empleado responsable debemos recuperar su nombre
        set v_nombre_pedido = (SELECT CONCAT_WS(" ", p.usuario_id, p.total, p.fecha_registro) FROM pedidos p WHERE id = NEW.pedido_id);
    else
        SET v_nombre_pedido = "Sin pedido asignado";
    end if;

    if new.producto_id is not null then
        -- En caso de tener el id de la sucursal debemos recuperar su nombre
        set v_nombre_producto = (SELECT concat_ws(" ", p.nombre, p.marca) FROM productos p WHERE id = NEW.producto_id);
    else
        SET v_nombre_producto = "Sin producto asignado";
    end if;

    -- Insertar en la bitacora
    INSERT INTO bitacora VALUES(
        DEFAULT,
        USER(),
        "Create",
        "detalles_pedidos",
        CONCAT_WS(" ","Se ha insertado una nuevo DETALLE_PEDIDO con el ID: ",NEW.ID, 
        "con los siguientes datos: ",
        "PEDIDO ID = ", v_nombre_pedido,
        "PRODUCTO ID = ",  v_nombre_producto,
        "CANTIDAD = ", NEW.cantidad,
		"TOTAL PARCIAL = ", NEW.total_parcial,
        "FECHA REGISTRO = ", NEW.fecha_registro,
        "FECHA ENTREGA = ", NEW.fecha_entrega,
        "ESTATUS = ", v_cadena_estatus),
        NOW(),
        DEFAULT
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `detalles_pedidos_AFTER_UPDATE` AFTER UPDATE ON `detalles_pedidos` FOR EACH ROW BEGIN
		 -- Declaración de variables
    DECLARE v_cadena_estatus VARCHAR(15) DEFAULT NULL;
    DECLARE v_nombre_pedido VARCHAR(100) DEFAULT NULL;
    DECLARE v_cadena_estatus2 VARCHAR(15) DEFAULT NULL;
    DECLARE v_nombre_pedido2 VARCHAR(100) DEFAULT NULL;
    DECLARE v_nombre_producto VARCHAR(60) DEFAULT NULL;
    DECLARE v_nombre_producto2 VARCHAR(60) DEFAULT NULL;

    -- Inicialización de las variables 
    IF NEW.estatus = b'1' THEN
		SET v_cadena_estatus= "Activa";
    ELSE
		SET v_cadena_estatus= "Inactiva";
    END IF; 
    
    IF OLD.estatus = b'1' THEN
		SET v_cadena_estatus2= "Activa";
    ELSE
		SET v_cadena_estatus2= "Inactiva";
    END IF; 
          
    IF NEW.pedido_id IS NOT NULL THEN 
		-- En caso de tener el id del pedido
        set v_nombre_pedido = (SELECT CONCAT_WS(" ", p.usuario_id, p.total, p.fecha_registro) FROM pedidos p WHERE id = NEW.pedido_id);
    ELSE
		SET v_nombre_pedido = "Sin pedido asignado.";
    END IF;
    
    IF OLD.pedido_id IS NOT NULL THEN 
		-- En caso de tener el id del pedido
        set v_nombre_pedido2 = (SELECT CONCAT_WS(" ", p.usuario_id, p.total, p.fecha_registro) FROM pedidos p WHERE id = OLD.pedido_id);
    ELSE
		SET v_nombre_pedido2 = "Sin pedido asignado.";
    END IF;

    IF NEW.producto_id IS NOT NULL THEN 
		-- En caso de tener el id del producto
        SET v_nombre_producto = (SELECT concat_ws(" ", p.nombre, p.marca) FROM productos WHERE id = NEW.producto_id);
    ELSE
		SET v_nombre_producto = "Sin producto asignado.";
    END IF;

    IF OLD.producto_id IS NOT NULL THEN 
		-- En caso de tener el id del producto
        SET v_nombre_producto = (SELECT concat_ws(" ", p.nombre, p.marca) FROM productos WHERE id = OLD.producto_id);
    ELSE
		SET v_nombre_producto2 = "Sin producto asignado.";
    END IF;
    
    INSERT INTO bitacora VALUES(
        DEFAULT,
        USER(),
        "Update",
        "detalles_pedidos",
        CONCAT_WS(" ","Se han actualizado los datos del DETALLES_PEDIDOS con el ID: ",NEW.ID, 
        "con los siguientes datos:",
        "PEDIDO ID = ", v_nombre_pedido2, " cambio a ", v_nombre_pedido,
        "PRODUCTO ID =",v_nombre_producto2," cambio a ", v_nombre_producto,
        "CANTIDAD = ", OLD.cantidad, "cambio a ", NEW.cantidad,
        "TOTAL PARCIAL = ", OLD.total_parcial, " cambio a ", NEW.total_parcial,
        "FECHA REGISTRO = ", OLD.fecha_registro, " cambio a ", NEW.fecha_registro,
        "RECHAENTREGA = ", OLD.fecha_entrega, " cambio a ", NEW.fecha_entrega,
        "ESTATUS = ", v_cadena_estatus2, " cambio a ", v_cadena_estatus),
        NOW(),
        DEFAULT       
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `detalles_pedidos_AFTER_DELETE` AFTER DELETE ON `detalles_pedidos` FOR EACH ROW BEGIN
	INSERT INTO bitacora VALUES(
		DEFAULT,
        USER(),
        "Delete",
        "detalles_pedidos",
        CONCAT_WS(" ","Se ha eliminado una relación DETALLES_PEDIDOS con el ID: ", OLD.ID),
        now(),
        DEFAULT
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `detalles_productos`
--

DROP TABLE IF EXISTS `detalles_productos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `detalles_productos` (
  `Producto_ID` int unsigned NOT NULL,
  `Descripcion` text,
  `Codigo_Barras` int DEFAULT NULL,
  `Presentacion` text,
  `Productos_existencia` int DEFAULT NULL,
  `Estatus` bit(1) NOT NULL DEFAULT b'1',
  PRIMARY KEY (`Producto_ID`),
  CONSTRAINT `1_Productos_ID` FOREIGN KEY (`Producto_ID`) REFERENCES `productos` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detalles_productos`
--

LOCK TABLES `detalles_productos` WRITE;
/*!40000 ALTER TABLE `detalles_productos` DISABLE KEYS */;
INSERT INTO `detalles_productos` VALUES (51,'Accesorios que protegen las manos de callosidades y proporcionan un mejor agarre durante el levantamiento de pesas y otros ejercicios de fuerza.',190532901,'Nordic Naturals Ultimate Omega',60,_binary ''),(52,'Botellas diseñadas para mezclar fácilmente proteína en polvo con agua o leche, convenientes para consumir bebidas nutritivas antes o después del entrenamiento.',385987635,'Nordic Naturals Ultimate Omega',450,_binary ''),(53,'Suplemento que contiene los aminoácidos esenciales leucina, isoleucina y valina, que ayudan a promover la recuperación muscular, reducir la fatiga y preservar la masa muscular durante el ejercicio.',190532901,'C4 Original Pre-Workout)',60,_binary ''),(54,'Suplemento utilizado para aumentar la fuerza, la potencia y ​​la masa muscular, al mejorar la disponibilidad de energía en los músculos durante el ejercicio de alta intensidad.',450578976,'Nordic Naturals Ultimate Omega',10,_binary ''),(55,'Suplemento que contiene ácidos grasos esenciales omega-3, conocidos por sus efectos antiinflamatorios y beneficios para la salud cardiovascular y articular.',105389073,'Proteína Whey Gold Standard',10,_binary ''),(56,'Suplemento que contiene ácidos grasos esenciales omega-3, conocidos por sus efectos antiinflamatorios y beneficios para la salud cardiovascular y articular.',123457354,' Optimum Nutrition Creatine Monohydrate',380,_binary ''),(57,'Equipos de soporte diseñados para proteger la espalda y mejorar la estabilidad durante los levantamientos de peso pesado, como sentadillas y peso muerto.',385987635,'C4 Original Pre-Workout)',380,_binary ''),(58,'Suplemento que contiene los aminoácidos esenciales leucina, isoleucina y valina, que ayudan a promover la recuperación muscular, reducir la fatiga y preservar la masa muscular durante el ejercicio.',105389073,'C4 Original Pre-Workout)',60,_binary ''),(59,'Accesorios que protegen las manos de callosidades y proporcionan un mejor agarre durante el levantamiento de pesas y otros ejercicios de fuerza.',385987635,'Xtend BCAA Powder',60,_binary ''),(60,'Suplemento nutricional utilizado para aumentar la ingesta de proteínas, promover la recuperación muscular y el crecimiento después del entrenamiento.',123457354,'Xtend BCAA Powder',500,_binary ''),(61,'Suplemento nutricional utilizado para aumentar la ingesta de proteínas, promover la recuperación muscular y el crecimiento después del entrenamiento.',450578976,'Proteína Whey Gold Standard',500,_binary ''),(62,'Fórmula diseñada para aumentar la energía, mejorar el enfoque mental y la resistencia durante el entrenamiento, generalmente contiene ingredientes como cafeína, beta-alanina y creatina.',385987635,'Quest Nutrition Protein Bar',10,_binary ''),(63,'Suplemento utilizado para aumentar la fuerza, la potencia y ​​la masa muscular, al mejorar la disponibilidad de energía en los músculos durante el ejercicio de alta intensidad.',105389073,'Proteína Whey Gold Standard',500,_binary ''),(64,'Suplementos que contienen una variedad de vitaminas y minerales esenciales para apoyar la salud general, el metabolismo y la función muscular durante el ejercicio intenso.',450578976,'C4 Original Pre-Workout)',380,_binary ''),(65,'Fórmula diseñada para aumentar la energía, mejorar el enfoque mental y la resistencia durante el entrenamiento, generalmente contiene ingredientes como cafeína, beta-alanina y creatina.',190532901,'Nordic Naturals Ultimate Omega',380,_binary ''),(66,'Fórmula diseñada para aumentar la energía, mejorar el enfoque mental y la resistencia durante el entrenamiento, generalmente contiene ingredientes como cafeína, beta-alanina y creatina.',385987635,'Quest Nutrition Protein Bar',60,_binary ''),(67,'Botellas diseñadas para mezclar fácilmente proteína en polvo con agua o leche, convenientes para consumir bebidas nutritivas antes o después del entrenamiento.',123457354,'C4 Original Pre-Workout)',10,_binary ''),(68,'Botellas diseñadas para mezclar fácilmente proteína en polvo con agua o leche, convenientes para consumir bebidas nutritivas antes o después del entrenamiento.',123457354,'Xtend BCAA Powder',60,_binary ''),(69,'Suplemento utilizado para aumentar la fuerza, la potencia y ​​la masa muscular, al mejorar la disponibilidad de energía en los músculos durante el ejercicio de alta intensidad.',385987635,'C4 Original Pre-Workout)',380,_binary ''),(70,'Equipos de soporte diseñados para proteger la espalda y mejorar la estabilidad durante los levantamientos de peso pesado, como sentadillas y peso muerto.',123457354,'Quest Nutrition Protein Bar',60,_binary ''),(71,'Accesorios que protegen las manos de callosidades y proporcionan un mejor agarre durante el levantamiento de pesas y otros ejercicios de fuerza.',190532901,'Nordic Naturals Ultimate Omega',60,_binary ''),(72,'Snacks convenientes y portátiles que proporcionan una fuente rápida de proteínas y carbohidratos, ideales para consumir antes o después del entrenamiento para apoyar la recuperación muscular.',385987635,'Nordic Naturals Ultimate Omega',10,_binary ''),(73,'Suplemento nutricional utilizado para aumentar la ingesta de proteínas, promover la recuperación muscular y el crecimiento después del entrenamiento.',123457354,'Xtend BCAA Powder',60,_binary ''),(74,'Suplementos que contienen una variedad de vitaminas y minerales esenciales para apoyar la salud general, el metabolismo y la función muscular durante el ejercicio intenso.',190532901,'C4 Original Pre-Workout)',380,_binary ''),(75,'Equipos de soporte diseñados para proteger la espalda y mejorar la estabilidad durante los levantamientos de peso pesado, como sentadillas y peso muerto.',450578976,'Xtend BCAA Powder',380,_binary ''),(76,'Botellas diseñadas para mezclar fácilmente proteína en polvo con agua o leche, convenientes para consumir bebidas nutritivas antes o después del entrenamiento.',190532901,'Nordic Naturals Ultimate Omega',60,_binary ''),(77,'Suplemento que contiene ácidos grasos esenciales omega-3, conocidos por sus efectos antiinflamatorios y beneficios para la salud cardiovascular y articular.',105389073,'Nordic Naturals Ultimate Omega',380,_binary ''),(78,'Snacks convenientes y portátiles que proporcionan una fuente rápida de proteínas y carbohidratos, ideales para consumir antes o después del entrenamiento para apoyar la recuperación muscular.',105389073,'Proteína Whey Gold Standard',380,_binary ''),(79,'Suplemento que contiene ácidos grasos esenciales omega-3, conocidos por sus efectos antiinflamatorios y beneficios para la salud cardiovascular y articular.',385987635,'Nordic Naturals Ultimate Omega',500,_binary ''),(80,'Botellas diseñadas para mezclar fácilmente proteína en polvo con agua o leche, convenientes para consumir bebidas nutritivas antes o después del entrenamiento.',123457354,' Optimum Nutrition Creatine Monohydrate',500,_binary ''),(81,'Accesorios que protegen las manos de callosidades y proporcionan un mejor agarre durante el levantamiento de pesas y otros ejercicios de fuerza.',190532901,'Xtend BCAA Powder',10,_binary ''),(82,'Fórmula diseñada para aumentar la energía, mejorar el enfoque mental y la resistencia durante el entrenamiento, generalmente contiene ingredientes como cafeína, beta-alanina y creatina.',385987635,'C4 Original Pre-Workout)',380,_binary ''),(83,'Snacks convenientes y portátiles que proporcionan una fuente rápida de proteínas y carbohidratos, ideales para consumir antes o después del entrenamiento para apoyar la recuperación muscular.',123457354,'Xtend BCAA Powder',450,_binary ''),(84,'Suplemento que contiene los aminoácidos esenciales leucina, isoleucina y valina, que ayudan a promover la recuperación muscular, reducir la fatiga y preservar la masa muscular durante el ejercicio.',123457354,'Nordic Naturals Ultimate Omega',450,_binary ''),(85,'Suplemento que contiene los aminoácidos esenciales leucina, isoleucina y valina, que ayudan a promover la recuperación muscular, reducir la fatiga y preservar la masa muscular durante el ejercicio.',123457354,' Optimum Nutrition Creatine Monohydrate',60,_binary ''),(86,'Botellas diseñadas para mezclar fácilmente proteína en polvo con agua o leche, convenientes para consumir bebidas nutritivas antes o después del entrenamiento.',190532901,'Nordic Naturals Ultimate Omega',450,_binary ''),(87,'Suplemento nutricional utilizado para aumentar la ingesta de proteínas, promover la recuperación muscular y el crecimiento después del entrenamiento.',190532901,'Nordic Naturals Ultimate Omega',60,_binary ''),(88,'Equipos de soporte diseñados para proteger la espalda y mejorar la estabilidad durante los levantamientos de peso pesado, como sentadillas y peso muerto.',385987635,'C4 Original Pre-Workout)',450,_binary ''),(89,'Accesorios que protegen las manos de callosidades y proporcionan un mejor agarre durante el levantamiento de pesas y otros ejercicios de fuerza.',123457354,'Quest Nutrition Protein Bar',450,_binary ''),(90,'Suplementos que contienen una variedad de vitaminas y minerales esenciales para apoyar la salud general, el metabolismo y la función muscular durante el ejercicio intenso.',190532901,'C4 Original Pre-Workout)',380,_binary ''),(91,'Suplemento que contiene ácidos grasos esenciales omega-3, conocidos por sus efectos antiinflamatorios y beneficios para la salud cardiovascular y articular.',385987635,'Nordic Naturals Ultimate Omega',380,_binary ''),(92,'Suplemento utilizado para aumentar la fuerza, la potencia y ​​la masa muscular, al mejorar la disponibilidad de energía en los músculos durante el ejercicio de alta intensidad.',105389073,'Proteína Whey Gold Standard',380,_binary ''),(93,'Suplementos que contienen una variedad de vitaminas y minerales esenciales para apoyar la salud general, el metabolismo y la función muscular durante el ejercicio intenso.',190532901,'Xtend BCAA Powder',500,_binary ''),(94,'Suplemento que contiene los aminoácidos esenciales leucina, isoleucina y valina, que ayudan a promover la recuperación muscular, reducir la fatiga y preservar la masa muscular durante el ejercicio.',105389073,'Quest Nutrition Protein Bar',10,_binary ''),(95,'Botellas diseñadas para mezclar fácilmente proteína en polvo con agua o leche, convenientes para consumir bebidas nutritivas antes o después del entrenamiento.',450578976,'Nordic Naturals Ultimate Omega',500,_binary ''),(96,'Suplemento utilizado para aumentar la fuerza, la potencia y ​​la masa muscular, al mejorar la disponibilidad de energía en los músculos durante el ejercicio de alta intensidad.',105389073,' Optimum Nutrition Creatine Monohydrate',10,_binary ''),(97,'Suplementos que contienen una variedad de vitaminas y minerales esenciales para apoyar la salud general, el metabolismo y la función muscular durante el ejercicio intenso.',385987635,'Nordic Naturals Ultimate Omega',500,_binary ''),(98,'Suplemento que contiene ácidos grasos esenciales omega-3, conocidos por sus efectos antiinflamatorios y beneficios para la salud cardiovascular y articular.',105389073,'Proteína Whey Gold Standard',60,_binary ''),(99,'Suplemento nutricional utilizado para aumentar la ingesta de proteínas, promover la recuperación muscular y el crecimiento después del entrenamiento.',385987635,'Nordic Naturals Ultimate Omega',500,_binary ''),(100,'Suplemento que contiene ácidos grasos esenciales omega-3, conocidos por sus efectos antiinflamatorios y beneficios para la salud cardiovascular y articular.',123457354,'Xtend BCAA Powder',60,_binary '');
/*!40000 ALTER TABLE `detalles_productos` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `detalles_productos_AFTER_INSERT` AFTER INSERT ON `detalles_productos` FOR EACH ROW BEGIN
	-- Declaración de variables
    DECLARE v_cadena_estatus varchar(15) default null;
    DECLARE v_nombre_producto varchar(60) default null;

    -- Iniciación de las variables
    IF new.estatus = b'1' then
        set v_cadena_estatus = "Activa";
    else
        set v_cadena_estatus = "Inactiva";
    end if;

    if new.producto_id is not null then
        -- En caso de tener el id de la sucursal debemos recuperar su nombre
        set v_nombre_producto = (SELECT concat_ws(" ", p.nombre, p.marca) FROM productos p WHERE id = NEW.producto_id);
    else
        SET v_nombre_producto = "Sin producto asignado";
    end if;

    -- Insertar en la bitacora
    INSERT INTO bitacora VALUES(
        DEFAULT,
        USER(),
        "Create",
        "detalles_productos",
        CONCAT_WS(" ","Se ha insertado una nuevo DETALLE_PEDIDO con el ID: ",NEW.Producto_ID, 
        "con los siguientes datos: ",
        "PRODUCTO ID = ",  v_nombre_producto,
        "DESCRIPCION = ", NEW.Descripcion,
		"CODIGO DE BARRAS = ", NEW.Codigo_Barras,
        "PRESENTACION = ", NEW.Presentacion,
        "ESTATUS = ", v_cadena_estatus),
        NOW(),
        DEFAULT
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `detalles_productos_AFTER_UPDATE` AFTER UPDATE ON `detalles_productos` FOR EACH ROW BEGIN
-- Declaración de variables
    DECLARE v_cadena_estatus VARCHAR(15) DEFAULT NULL;
    DECLARE v_cadena_estatus2 VARCHAR(15) DEFAULT NULL;
    
    DECLARE v_nombre_producto VARCHAR(60) DEFAULT NULL;
    DECLARE v_nombre_producto2 VARCHAR(60) DEFAULT NULL;

    -- Inicialización de las variables 
    IF NEW.estatus = b'1' THEN
		SET v_cadena_estatus= "Activa";
    ELSE
		SET v_cadena_estatus= "Inactiva";
    END IF; 
    
    IF OLD.estatus = b'1' THEN
		SET v_cadena_estatus2= "Activa";
    ELSE
		SET v_cadena_estatus2= "Inactiva";
    END IF; 
          
    IF NEW.producto_id IS NOT NULL THEN 
		-- En caso de tener el id del producto
        SET v_nombre_producto = (SELECT concat_ws(" ", p.nombre, p.marca) FROM productos WHERE id = NEW.producto_id);
    ELSE
		SET v_nombre_producto = "Sin producto asignado.";
    END IF;

    IF OLD.producto_id IS NOT NULL THEN 
		-- En caso de tener el id del producto
        SET v_nombre_producto = (SELECT concat_ws(" ", p.nombre, p.marca) FROM productos WHERE id = OLD.producto_id);
    ELSE
		SET v_nombre_producto2 = "Sin producto asignado.";
    END IF;
    
    INSERT INTO bitacora VALUES(
        DEFAULT,
        USER(),
        "Update",
        "detalles_productos",
        CONCAT_WS(" ","Se han actualizado los datos de los DETALLES_PRODUCTOS con el ID: ",NEW.Producto_ID, 
        "con los siguientes datos:",
        "PRODUCTO ID =",v_nombre_producto2," cambio a ", v_nombre_producto,
        "DESCRIPCION = ", OLD.Descripcion, "cambio a ", NEW.Descripcion,
        "CODIGO EN BARRAS = ", OLD.Codigo_Barras, " cambio a ", NEW.Codigo_Barras,
        "PRESENTACION = ", OLD.Presentacion, " cambio a ", NEW.Presentacion,
        "PRODUCTOS EN EXISTENCIA = ", OLD.Productos_existencia, " cambio a ", NEW.Productos_existencia,
        "ESTATUS = ", v_cadena_estatus2, " cambio a ", v_cadena_estatus),
        NOW(),
        DEFAULT       
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `detalles_productos_AFTER_DELETE` AFTER DELETE ON `detalles_productos` FOR EACH ROW INSERT INTO bitacora VALUES(
		DEFAULT,
        USER(),
        "Delete",
        "detalles_productos",
        CONCAT_WS(" ","Se ha eliminado un DETALLE_PRODUCTO con el ID: ", OLD.Producto_ID),
        now(),
        DEFAULT
    ); */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `detalles_programas_saludables`
--

DROP TABLE IF EXISTS `detalles_programas_saludables`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `detalles_programas_saludables` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `Programa_ID` int unsigned DEFAULT NULL,
  `Rutina_ID` int unsigned DEFAULT NULL,
  `Dieta_ID` int unsigned DEFAULT NULL,
  `Fecha_Inicio` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Fecha_Fin` datetime NOT NULL,
  `Estatus` enum('Programada','Iniciada','Seguimiento','Suspendida','Finalizada') NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_programa_1` (`Programa_ID`),
  KEY `fk_rutina_1` (`Rutina_ID`),
  KEY `fk_dieta_1` (`Dieta_ID`),
  CONSTRAINT `fk_dieta_1` FOREIGN KEY (`Dieta_ID`) REFERENCES `dietas` (`ID`),
  CONSTRAINT `fk_programa_1` FOREIGN KEY (`Programa_ID`) REFERENCES `programas_saludables` (`ID`),
  CONSTRAINT `fk_rutina_1` FOREIGN KEY (`Rutina_ID`) REFERENCES `rutinas` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detalles_programas_saludables`
--

LOCK TABLES `detalles_programas_saludables` WRITE;
/*!40000 ALTER TABLE `detalles_programas_saludables` DISABLE KEYS */;
/*!40000 ALTER TABLE `detalles_programas_saludables` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `detalles_programas_saludables_AFTER_INSERT` AFTER INSERT ON `detalles_programas_saludables` FOR EACH ROW BEGIN
	-- Declaración de variables
    DECLARE v_nombre_programa varchar(60) default null;
    DECLARE v_nombre_rutina varchar(60) default null;
    DECLARE v_nombre_dieta varchar(60) default null;

    -- Iniciación de las variables
     if new.programa_id is not null then
        -- En caso de tener el id del empleado responsable debemos recuperar su nombre
        set v_nombre_programa = (SELECT nombre FROM programas_saludables WHERE id = NEW.programa_id);
    else
        SET v_nombre_programa = "Sin programa asignado";
    end if;

    if new.rutina_id is not null then
        -- En caso de tener el id de la rutina
        set v_nombre_rutina = (SELECT resultados_esperados FROM rutinas WHERE id = NEW.rutina_id);
    else
        SET v_nombre_rutina = "Sin rutina asignada";
    end if;

    if new.dieta_id is not null then
        -- En caso de tener el id de la dieta
        set v_nombre_dieta = (SELECT nombre FROM dietas WHERE id = NEW.dieta_id);
    else
        SET v_nombre_dieta = "Sin dieta asignada";
    end if;

    -- Insertar en la bitacora
    INSERT INTO bitacora VALUES(
        DEFAULT,
        USER(),
        "Create",
        "detalles_programas_saludables",
        CONCAT_WS(" ","Se ha insertado una nueva relación en DETALLES PROGRAMAS SALUDABLES con el ID: ",NEW.ID, 
        "con los siguientes datos: ",
        "PROGRAMA ID = ", v_nombre_programa,
        "RUTINA ID = ", v_nombre_rutina,
        "DIETA ID = ",  v_nombre_dieta,
        "FECHA INICIO = ", NEW.fecha_inicio, 
        "FECHA FIN = ", NEW.fecha_fin,
        "ESTATUS = ", NEW.estatus),
        NOW(),
        DEFAULT
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `detalles_programas_saludables_AFTER_UPDATE` AFTER UPDATE ON `detalles_programas_saludables` FOR EACH ROW BEGIN
	 -- Declaración de variables
    DECLARE v_nombre_programa varchar(60) default null;
    DECLARE v_nombre_rutina VARCHAR(100) DEFAULT NULL;
    DECLARE v_nombre_programa2 varchar(60) default null;
    DECLARE v_nombre_rutina2 VARCHAR(100) DEFAULT NULL;
    DECLARE v_nombre_dieta VARCHAR(60) DEFAULT NULL;
    DECLARE v_nombre_dieta2 VARCHAR(60) DEFAULT NULL;

    -- Inicialización de las variables
    if new.programa_id is not null then
        -- En caso de tener el id del empleado responsable debemos recuperar su nombre
        set v_nombre_programa = (SELECT nombre FROM programas_saludables WHERE id = NEW.programa_id);
    else
        SET v_nombre_programa = "Sin programa asignado";
    end if;
    
    if old.programa_id is not null then
        -- En caso de tener el id del empleado responsable debemos recuperar su nombre
        set v_nombre_programa = (SELECT nombre FROM programas_saludables WHERE id = old.programa_id);
    else
        SET v_nombre_programa = "Sin programa asignado";
    end if;
          
    IF NEW.rutina_id IS NOT NULL THEN 
		-- En caso de tener el id de la rutina
		SET v_nombre_rutina = (SELECT resultados_esperados FROM rutinas WHERE id = NEW.rutina_id);
    ELSE
		SET v_nombre_rutina = "Sin rutina asignada.";
    END IF;
    
    IF OLD.rutina_id IS NOT NULL THEN 
		-- En caso de tener el id de la rutina
		SET v_nombre_rutina2 = (SELECT resultados_esperados FROM rutinas WHERE id = OLD.rutina_id);
    ELSE
		SET v_nombre_rutina2 = "Sin rutina asignada.";
    END IF;

    IF NEW.dieta_id IS NOT NULL THEN 
		-- En caso de tener el id de la dieta
		SET v_nombre_dieta = (SELECT nombre FROM dietas WHERE id = NEW.dieta_id);
    ELSE
		SET v_nombre_dieta = "Sin dieta asignada.";
    END IF;

    IF OLD.dieta_id IS NOT NULL THEN 
		-- En caso de tener el id de la dieta
		SET v_nombre_dieta2 = (SELECT nombre FROM dietas WHERE id = OLD.dieta_id);
    ELSE
		SET v_nombre_dieta2 = "Sin dieta asignada.";
    END IF;
    
    INSERT INTO bitacora VALUES(
        DEFAULT,
        USER(),
        "Update",
        "detalles_programas_saludables",
        CONCAT_WS(" ","Se han actualizado los datos de la relación DETALLES PROGRAMAS SALUDABLES con el ID: ",NEW.ID, 
        "con los siguientes datos:",
        "PROGRAMA ID = ", v_nombre_programa2, " cambio a ", v_nombre_programa,
        "RUTINA ID = ", v_nombre_rutina2, " cambio a ", v_nombre_rutina,
        "DIETA ID =",v_nombre_dieta2," cambio a ", v_nombre_dieta,
        "FECHA INICIO = ", OLD.fecha_inicio, " cambio a ", NEW.fecha_inicio,
        "FECHA FIN = ", OLD.fecha_fin, " cambio a ", NEW.fecha_fin,
        "ESTATUS = ", OLD.estatus, " cambio a ", NEW.estatus),
        NOW(),
        DEFAULT       
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `detalles_programas_saludables_AFTER_DELETE` AFTER DELETE ON `detalles_programas_saludables` FOR EACH ROW BEGIN
	INSERT INTO bitacora VALUES(
		DEFAULT,
        USER(),
        "Delete",
        "detalles_programas_saludables",
        CONCAT_WS(" ","Se ha eliminado un registro de DETALLES PROGRAMAS SALUDABLES con el ID: ", OLD.ID),
        now(),
        DEFAULT
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `detalles_promociones`
--

DROP TABLE IF EXISTS `detalles_promociones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `detalles_promociones` (
  `Promociones_ID` int unsigned NOT NULL,
  `Fecha_Inicio` datetime DEFAULT NULL,
  `Fecha_Fin` datetime DEFAULT NULL,
  `Estatus` bit(1) DEFAULT NULL,
  PRIMARY KEY (`Promociones_ID`),
  CONSTRAINT `Promociones_ID` FOREIGN KEY (`Promociones_ID`) REFERENCES `promociones` (`Producto_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detalles_promociones`
--

LOCK TABLES `detalles_promociones` WRITE;
/*!40000 ALTER TABLE `detalles_promociones` DISABLE KEYS */;
/*!40000 ALTER TABLE `detalles_promociones` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `detalles_promociones_AFTER_INSERT` AFTER INSERT ON `detalles_promociones` FOR EACH ROW BEGIN
-- Declaración de variables
    DECLARE v_cadena_estatus varchar(15) default null;
    
    DECLARE v_tipo_promocion varchar(60) default null;

    -- Iniciación de las variables
    IF new.estatus = b'1' then
        set v_cadena_estatus = "Activa";
    else
        set v_cadena_estatus = "Inactiva";
    end if;

    if new.promociones_id is not null then
        -- En caso de tener el id de la sucursal debemos recuperar su nombre
        set v_tipo_promocion = (SELECT concat_ws(" ", p.tipo_promocion) FROM promociones WHERE id = NEW.promociones_id);
    else
        SET v_tipo_promocion = "Sin promoción asignada";
    end if;

    -- Insertar en la bitacora
    INSERT INTO bitacora VALUES(
        DEFAULT,
        USER(),
        "Create",
        "detalles_promociones",
        CONCAT_WS(" ","Se ha insertado una nueva PROMOCION con el ID: ",NEW.Promociones_ID, 
        "con los siguientes datos: ",
        "FECHA DE INICIO = ", Fecha_Inicio,
        "FECHA DE FINALIZACION = ",  Fecha_Fin,
        "ESTATUS = ", v_cadena_estatus),
        NOW(),
        DEFAULT
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `detalles_promociones_AFTER_UPDATE` AFTER UPDATE ON `detalles_promociones` FOR EACH ROW BEGIN
 -- Declaración de variables
    DECLARE v_cadena_estatus VARCHAR(15) DEFAULT NULL;
    DECLARE v_cadena_estatus2 VARCHAR(15) DEFAULT NULL;
    
    DECLARE v_tipo_promocion varchar(60) default null;
    DECLARE v_tipo_promocion2 VARCHAR(60) DEFAULT NULL;

    -- Inicialización de las variables 
    IF NEW.estatus = b'1' THEN
		SET v_cadena_estatus= "Activa";
    ELSE
		SET v_cadena_estatus= "Inactiva";
    END IF; 
    
    IF OLD.estatus = b'1' THEN
		SET v_cadena_estatus2= "Activa";
    ELSE
		SET v_cadena_estatus2= "Inactiva";
    END IF; 
          
    IF NEW.promociones_id IS NOT NULL THEN 
		-- En caso de tener el id del producto
        SET v_tipo_promocion = (SELECT concat_ws(" ", p.tipo_promocion) FROM promociones WHERE id = NEW.promociones_id);
    ELSE
		SET v_tipo_promocion = "Sin promoción asignada.";
    END IF;

    IF OLD.promociones_id IS NOT NULL THEN 
		-- En caso de tener el id del producto
        SET v_tipo_promocion = (SELECT concat_ws(" ", p.tipo_promocion) FROM promociones WHERE id = OLD.promociones_id);
    ELSE
		SET v_tipo_promocion2 = "Sin promoción asignada.";
    END IF;
    
    INSERT INTO bitacora VALUES(
        DEFAULT,
        USER(),
        "Update",
        "detalles_promociones",
        CONCAT_WS(" ","Se han actualizado los datos de los DETALLES_PROMOCIONES con el ID: ",NEW.Promociones_ID, 
        "con los siguientes datos:",
        "PROMOCIONES ID =",v_tipo_promocion2," cambio a ", v_tipo_promocion,
        "FECHA DE INICIO = ", OLD.Fecha_Inicio, "cambio a ", NEW.Fecha_Inicio,
        "FECHA DE FINALIZACION = ", OLD.Fecha_Fin, " cambio a ", NEW.Fecha_Fin,
        "ESTATUS = ", v_cadena_estatus2, " cambio a ", v_cadena_estatus),
        NOW(),
        DEFAULT       
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `detalles_promociones_AFTER_DELETE` AFTER DELETE ON `detalles_promociones` FOR EACH ROW BEGIN
INSERT INTO bitacora VALUES(
		DEFAULT,
        USER(),
        "Delete",
        "detalles_promociones",
        CONCAT_WS(" ","Se ha eliminado un DETALLE_PROMOCION con el ID: ", OLD.Promociones_ID),
        now(),
        DEFAULT
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `dietas`
--

DROP TABLE IF EXISTS `dietas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dietas` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(300) NOT NULL,
  `Descripccion` text,
  `Objetivo` text,
  `Restricciones` text,
  `Estatus` bit(1) NOT NULL DEFAULT b'1',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dietas`
--

LOCK TABLES `dietas` WRITE;
/*!40000 ALTER TABLE `dietas` DISABLE KEYS */;
/*!40000 ALTER TABLE `dietas` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `dietas_AFTER_INSERT` AFTER INSERT ON `dietas` FOR EACH ROW BEGIN
	-- Declaración de variables
    DECLARE v_cadena_estatus varchar(15) default null;
    
    -- Iniciación de las variables
    IF new.estatus = b'1' then
        set v_cadena_estatus = "Activa";
    else
        set v_cadena_estatus = "Inactiva";
    end if;
    
	INSERT INTO bitacora VALUES(
		DEFAULT,
        USER(),
        "Create",
        "dietas",
        CONCAT_WS(" ","Se ha insertado una nueva DIETA con el ID: ",NEW.ID, 
        "con los siguientes datos: NOMBRE=", NEW.nombre,
        "DESCRIPCION = ", NEW.descripccion,
        "OBJETIVO = ", NEW.objetivo, 
        "RESTRICCIONES = ", NEW.restricciones,
        "ESTATUS = ", v_cadena_estatus),
        NOW(),
        DEFAULT
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `dietas_AFTER_UPDATE` AFTER UPDATE ON `dietas` FOR EACH ROW BEGIN
	 -- Declaración de variables
    DECLARE v_cadena_estatus VARCHAR(15) DEFAULT NULL;
    DECLARE v_cadena_estatus2 VARCHAR(15) DEFAULT NULL;
    
	IF NEW.estatus = b'1' THEN
		SET v_cadena_estatus= "Activa";
    ELSE
		SET v_cadena_estatus= "Inactiva";
    END IF; 
    
    IF OLD.estatus = b'1' THEN
		SET v_cadena_estatus2= "Activa";
    ELSE
		SET v_cadena_estatus2= "Inactiva";
    END IF; 
	
    INSERT INTO bitacora VALUES(
        DEFAULT,
        USER(),
        "Update",
        "dietas",
        CONCAT_WS(" ","Se han actualizado los datos de la DIETA con el ID:",NEW.ID,
        "con los siguientes datos: ",
        "NOMBRE = ", OLD.nombre, " cambio a ", NEW.nombre,
        "DESCRIPCION = ", OLD.descripccion,"cambio a ", NEW.descripccion,
        "OBJETIVO = ", OLD.objetivo," cambio a", NEW.objetivo,
        "RESCRICCIONES = ", OLD.restricciones," cambio a ", NEW.restricciones,
        "ESTATUS = ", v_cadena_estatus2, " cambio a ", v_cadena_estatus),
        NOW(),
        DEFAULT       
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `dietas_AFTER_DELETE` AFTER DELETE ON `dietas` FOR EACH ROW BEGIN
	INSERT INTO bitacora VALUES(
		DEFAULT,
        USER(),
        "Delete",
        "dietas",
        CONCAT_WS(" ","Se ha eliminado una DIETA con el ID: ", OLD.ID),
        now(),
        DEFAULT
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `ejercicios`
--

DROP TABLE IF EXISTS `ejercicios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ejercicios` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `Nombre_Formal` varchar(80) NOT NULL,
  `Nombre_Comun` varchar(50) NOT NULL,
  `Descripcion` text,
  `Tipo` enum('Aeróbico','Resistencia','Flexibilidad','Fuerza') DEFAULT NULL,
  `Video_Ejemplo` varchar(100) DEFAULT NULL,
  `Consideraciones` text,
  `Dificultad` enum('Básica','Intermedia','Avanzada') DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=112 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ejercicios`
--

LOCK TABLES `ejercicios` WRITE;
/*!40000 ALTER TABLE `ejercicios` DISABLE KEYS */;
/*!40000 ALTER TABLE `ejercicios` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `ejercicios_AFTER_INSERT` AFTER INSERT ON `ejercicios` FOR EACH ROW BEGIN
	INSERT INTO bitacora VALUES(
		DEFAULT,
        USER(),
        "Create",
        "ejercicios",
        CONCAT_WS(" ","Se ha insertado un nuevo ejercicio con el ID: ",
        NEW.ID, "con los siguientes datos: NOMBRE_FORMAL=", NEW.nombre_formal,
        "NOMBRE_COMUN = ", NEW.nombre_comun, "DESCRIPCION = ", NEW.descripcion,
        "TIPO = ", NEW.tipo, "VIDEO_EJEMPLO = ", NEW.video_ejemplo,
        "CONSIDERACIONES = ", NEW.consideraciones, "DIFICULTAD = ", NEW.dificultad),
        NOW(),
        DEFAULT
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `ejercicios_AFTER_UPDATE` AFTER UPDATE ON `ejercicios` FOR EACH ROW BEGIN
	INSERT INTO bitacora VALUES(
		DEFAULT,
        USER(),
        "Update",
        "ejercicios",
        CONCAT_WS(" ","Se han actualizado los datos del ejercicio con el ID: ",
        NEW.ID, "con los siguientes datos:",
        "NOMBRE_FORMAL=", OLD.nombre_formal, " cambio a " ,NEW.nombre_formal,
        "NOMBRE_COMUN = ", OLD.nombre_comun, " cambio a " , NEW.nombre_comun, 
        "DESCRIPCION = ", OLD.descripcion, " cambio a " , NEW.descripcion,
        "TIPO = ",  OLD.tipo, " cambio a " ,NEW.tipo, 
        "VIDEO_EJEMPLO = ", OLD.video_ejemplo, " cambio a " , NEW.video_ejemplo,
        "CONSIDERACIONES = ",  OLD.consideraciones, " cambio a " ,NEW.consideraciones, 
        "DIFICULTAD = ", OLD.dificultad, " cambio a " , NEW.dificultad),
        NOW(),
        DEFAULT
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `ejercicios_AFTER_DELETE` AFTER DELETE ON `ejercicios` FOR EACH ROW BEGIN
	INSERT INTO bitacora VALUES(
		DEFAULT,
        USER(),
        "Delete",
        "ejercicios",
        CONCAT_WS(" ","Se han eliminado un ejercicio con el ID: ", OLD.ID),
        now(),
        DEFAULT
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `empleados`
--

DROP TABLE IF EXISTS `empleados`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `empleados` (
  `Persona_ID` int unsigned NOT NULL,
  `Puesto` varchar(50) NOT NULL,
  `Area` varchar(60) NOT NULL,
  `Numero_Empleado` int unsigned NOT NULL,
  `Sucursal_ID` int unsigned NOT NULL,
  `Fecha_Contratacion` datetime NOT NULL,
  PRIMARY KEY (`Persona_ID`),
  KEY `fk_sucursales_1` (`Sucursal_ID`),
  CONSTRAINT `fk_persona_2` FOREIGN KEY (`Persona_ID`) REFERENCES `personas` (`ID`),
  CONSTRAINT `fk_sucursales_1` FOREIGN KEY (`Sucursal_ID`) REFERENCES `sucursales` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `empleados`
--

LOCK TABLES `empleados` WRITE;
/*!40000 ALTER TABLE `empleados` DISABLE KEYS */;
/*!40000 ALTER TABLE `empleados` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `empleados_AFTER_INSERT` AFTER INSERT ON `empleados` FOR EACH ROW BEGIN
	 -- Declaración de variables
     DECLARE v_nombre_sucursal varchar(60) default null;
     
     if new.sucursal_id is not null then
        -- En caso de tener el id de la sucursal debemos recuperar su nombre
        set v_nombre_sucursal = (SELECT nombre FROM sucursales WHERE id = NEW.sucursal_id);
    else
        SET v_nombre_sucursal = "Sin sucursal asignada";
    end if;
    
    INSERT INTO bitacora VALUES(
		DEFAULT,
        USER(),
        "Create",
        "empleados",
        CONCAT_WS(" ","Se ha insertado una nuevo EMPLEADO con el ID: ",NEW.persona_id, 
        "con los siguientes datos: PUESTO = ", NEW.puesto,
        "AREA=", NEW.area,
        "NUMERO EMPLEADO = ", NEW.numero_empleado,
        "SUCURSAL ID = ", v_nombre_sucursal,
        "FECHA CONTRATACIÓN = ",  NEW.fecha_contratacion),
        NOW(),
        DEFAULT
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `empleados_AFTER_UPDATE` AFTER UPDATE ON `empleados` FOR EACH ROW BEGIN
	-- Declaración de variables
	DECLARE v_nombre_sucursal VARCHAR(60) DEFAULT NULL;
    DECLARE v_nombre_sucursal2 VARCHAR(60) DEFAULT NULL;
    
    IF NEW.sucursal_id IS NOT NULL THEN 
		-- En caso de tener el id de la sucursal debemos recuperar su nombre
		-- para ingresarlo en la bitacora.
		SET v_nombre_sucursal = (SELECT nombre FROM sucursales WHERE id = NEW.sucursal_id);
    ELSE
		SET v_nombre_sucursal = "Sin sucursal asignada.";
    END IF;

    IF OLD.sucursal_id IS NOT NULL THEN 
		-- En caso de tener el id de la sucursal debemos recuperar su nombre
		-- para ingresarlo en la bitacora.
		SET v_nombre_sucursal2 = (SELECT nombre FROM sucursales WHERE id = OLD.sucursal_id);
    ELSE
		SET v_nombre_sucursal2 = "Sin sucursal asignada.";
    END IF;
    
    INSERT INTO bitacora VALUES(
        DEFAULT,
        USER(),
        "Update",
        "empleados",
        CONCAT_WS(" ","Se han actualizado los datos del empleado con el ID: ",
        NEW.persona_id, "con los siguientes datos:",
        "PUESTO = ", OLD.puesto, " cambio a " ,NEW.puesto,
        "AREA = ", OLD.area, " cambio a " , NEW.area, 
        "NUMERO EMPLEADO = ", OLD.numero_empleado, " cambio a " , NEW.numero_empleado,
        "SUCURSAL ID = ", v_nombre_sucursal2 , " cambio a " , v_nombre_sucursal, 
        "FECHA CONTRATACIÓN = ", OLD.fecha_contratacion, " cambio a " , NEW.fecha_contratacion),
        NOW(),
        DEFAULT
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `empleados_AFTER_DELETE` AFTER DELETE ON `empleados` FOR EACH ROW BEGIN
	INSERT INTO bitacora VALUES(
        DEFAULT,
        USER(),
        "Delete",
        "empleados",
        CONCAT_WS(" ","Se ha eliminado un EMPLEADO con el ID: ", OLD.persona_id),
        NOW(),
        DEFAULT
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `equipos`
--

DROP TABLE IF EXISTS `equipos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `equipos` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(250) NOT NULL,
  `Descripcion` text,
  `Marca` varchar(50) NOT NULL,
  `Modelo` varchar(50) NOT NULL,
  `Especificaciones` text,
  `Fotografia` varchar(100) DEFAULT NULL,
  `Total_Existencia` int unsigned NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `equipos`
--

LOCK TABLES `equipos` WRITE;
/*!40000 ALTER TABLE `equipos` DISABLE KEYS */;
/*!40000 ALTER TABLE `equipos` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `equipos_AFTER_INSERT` AFTER INSERT ON `equipos` FOR EACH ROW BEGIN
	INSERT INTO bitacora VALUES(
		DEFAULT,
        USER(),
        "Create",
        "equipos",
        CONCAT_WS(" ","Se ha insertado un nuevo equipo con el ID: ",NEW.ID, 
        "con los siguientes datos: NOMBRE=", NEW.nombre,
        "DESCRIPCION = ", NEW.descripcion,
        "MARCA = ", NEW.marca,
        "MODELO = ", NEW.modelo, 
        "ESPECIFICACIONES = ", NEW.especificaciones,
        "FOTOGRAFIA = ", NEW.fotografia, 
        "TOTAL_EXISTENCIA = ", NEW.total_existencia),
        NOW(),
        DEFAULT
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `equipos_BEFORE_UPDATE` BEFORE UPDATE ON `equipos` FOR EACH ROW BEGIN
INSERT INTO bitacora VALUES(
		DEFAULT,
        USER(),
        "Update",
        "equipos",
        CONCAT_WS(" ","Se han actualizado los datos del equipo con el ID: ",NEW.ID, 
        "con los siguientes datos:", "NOMBRE=", OLD.nombre, " cambio a " ,NEW.nombre,
        "DESCRIPCION = ", OLD.descripcion, " cambio a " , NEW.descripcion,
        "MARCA = ", OLD.marca, " cambio a " , NEW.marca, 
        "MODELO = ",  OLD.modelo, " cambio a " ,NEW.modelo, 
        "ESPECIFICACIONES = ", OLD.especificaciones, " cambio a " , NEW.especificaciones,
        "FOTOGRAFIA = ",  OLD.fotografia, " cambio a " ,NEW.fotografia, 
        "TOTAL_EXISTENCIA = ", OLD.total_existencia, " cambio a " , NEW.total_existencia),
        NOW(),
        DEFAULT
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `equipos_AFTER_DELETE` AFTER DELETE ON `equipos` FOR EACH ROW BEGIN
INSERT INTO bitacora VALUES(
		DEFAULT,
        USER(),
        "Delete",
        "equipos",
        CONCAT_WS(" ","Se ha eliminado un equipo con el ID: ", OLD.ID),
        now(),
        DEFAULT
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `equipos_existencias`
--

DROP TABLE IF EXISTS `equipos_existencias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `equipos_existencias` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `Equipo_ID` int unsigned NOT NULL,
  `Area_ID` int unsigned NOT NULL,
  `Color` varchar(100) DEFAULT NULL,
  `Estatus` enum('Nuevo','Semi-Nuevo','Bueno','Regular','Malo','Baja','Extraviado') NOT NULL,
  `Fecha_Asignacion` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  KEY `fk_equipo_1` (`Equipo_ID`),
  KEY `fk_area_1` (`Area_ID`),
  CONSTRAINT `fk_area_1` FOREIGN KEY (`Area_ID`) REFERENCES `areas` (`ID`),
  CONSTRAINT `fk_equipo_1` FOREIGN KEY (`Equipo_ID`) REFERENCES `equipos` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `equipos_existencias`
--

LOCK TABLES `equipos_existencias` WRITE;
/*!40000 ALTER TABLE `equipos_existencias` DISABLE KEYS */;
/*!40000 ALTER TABLE `equipos_existencias` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `equipos_existencias_AFTER_INSERT` AFTER INSERT ON `equipos_existencias` FOR EACH ROW BEGIN
	-- Declaración de variables
    DECLARE v_nombre_equipo varchar(60) default null;
    DECLARE v_nombre_area varchar(60) default null;

    -- Iniciación de las variables
    if new.equipo_id is not null then
        -- En caso de tener el id del equipo
        set v_nombre_equipo = (SELECT CONCAT_WS(" ", e.nombre, e.marca, e.modelo) FROM equipos e WHERE id = NEW.equipo_id);
    else
        SET v_nombre_equipo = "Sin equipo asignado";
    end if;

    if new.area_id is not null then
        -- En caso de tener el id del area
        set v_nombre_area = (SELECT nombre FROM areas WHERE id = NEW.area_id);
    else
        SET v_nombre_area = "Sin area asignada";
    end if;

    -- Insertar en la bitacora
    INSERT INTO bitacora VALUES(
        DEFAULT,
        USER(),
        "Create",
        "equipos_existencias",
        CONCAT_WS(" ","Se ha insertado una nueva relación de EQUIPOS EXISTENCIAS con el ID: ",NEW.ID, 
        "con los siguientes datos: ",
        "EQUIPO ID = ", v_nombre_equipo,
        "AREA ID = ",  v_nombre_area,
        "COLOR = ", NEW.color, 
        "ESTATUS = ", NEW.estatus,
        "FECHA DE ASIGNACIÓN = ", NEW.fecha_asignacion),
        NOW(),
        DEFAULT
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `equipos_existencias_AFTER_UPDATE` AFTER UPDATE ON `equipos_existencias` FOR EACH ROW BEGIN
	-- Declaración de variables
    DECLARE v_nombre_equipo VARCHAR(100) DEFAULT NULL;
    DECLARE v_nombre_equipo2 VARCHAR(100) DEFAULT NULL;
    DECLARE v_nombre_area VARCHAR(60) DEFAULT NULL;
    DECLARE v_nombre_area2 VARCHAR(60) DEFAULT NULL;

    -- Inicialización de las variables
    IF NEW.equipo_id IS NOT NULL THEN 
		-- En caso de tener el id del equipo
		SET v_nombre_equipo = (SELECT CONCAT_WS(" ", e.nombre, e.marca, e.modelo) FROM equipos e WHERE id = NEW.equipo_id);
    ELSE
		SET v_nombre_equipo = "Sin equipo asignado.";
    END IF;
    
    IF OLD.equipo_id IS NOT NULL THEN 
		-- En caso de tener el id del equipo
		SET v_nombre_equipo2 =(SELECT CONCAT_WS(" ", e.nombre, e.marca, e.modelo) FROM equipos e WHERE id = OLD.equipo_id);
    ELSE
		SET v_nombre_equipo2 = "Sin equipo asignado.";
    END IF;

    IF NEW.area_id IS NOT NULL THEN 
		-- En caso de tener el id del area
		SET v_nombre_area = (SELECT nombre FROM areas WHERE id = NEW.area_id);
    ELSE
		SET v_nombre_area = "Sin area asignada.";
    END IF;

    IF OLD.area_id IS NOT NULL THEN 
		-- En caso de tener el id del area
		SET v_nombre_area2 = (SELECT nombre FROM areas WHERE id = OLD.area_id);
    ELSE
		SET v_nombre_area2 = "Sin area asignada.";
    END IF;
    
    INSERT INTO bitacora VALUES(
        DEFAULT,
        USER(),
        "Update",
        "equipos_exixstencias",
        CONCAT_WS(" ","Se han actualizado los datos de la relación EQUIPOS EXISTENCIAS con el ID: ",NEW.ID, 
        "con los siguientes datos:",
        "EQUIPO ID = ", v_nombre_equipo2, "cambio a", v_nombre_equipo,
        "AREA ID =",v_nombre_area2,"cambio a", v_nombre_area,
        "COLOR = ", OLD.color, "cambio a", NEW.color ,
        "ESTATUS = ", OLD.estatus, "cambio a", NEW.estatus,
        "FECHA DE ASIGNACIÓN = ", OLD.fecha_asignacion , "cambio a", NEW.fecha_asignacion ),
        NOW(),
        DEFAULT       
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `equipos_existencias_AFTER_DELETE` AFTER DELETE ON `equipos_existencias` FOR EACH ROW BEGIN
	INSERT INTO bitacora VALUES(
		DEFAULT,
        USER(),
        "Delete",
        "equipos_existencias",
        CONCAT_WS(" ","Se ha eliminado una relación EUIPOS EXISTENCIAS con los IDs: ", OLD.ID),
        now(),
        DEFAULT
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `instructores`
--

DROP TABLE IF EXISTS `instructores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `instructores` (
  `Empleado_ID` int unsigned NOT NULL,
  `Especialidad` varchar(100) DEFAULT NULL,
  `Horario_Disponibilidad` text,
  `Total_Miembros_Atendidos` int unsigned DEFAULT NULL,
  `Valoracion_Miembro` int unsigned DEFAULT '0',
  PRIMARY KEY (`Empleado_ID`),
  CONSTRAINT `fk_empleado_1` FOREIGN KEY (`Empleado_ID`) REFERENCES `empleados` (`Persona_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `instructores`
--

LOCK TABLES `instructores` WRITE;
/*!40000 ALTER TABLE `instructores` DISABLE KEYS */;
/*!40000 ALTER TABLE `instructores` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `instructores_AFTER_INSERT` AFTER INSERT ON `instructores` FOR EACH ROW BEGIN
	INSERT INTO bitacora VALUES(
		DEFAULT,
        USER(),
        "Create",
        "instructores",
        CONCAT_WS(" ","Se ha insertado un nuevo INSTRUCTOR con el ID: ",NEW.empleado_id, 
        "con los siguientes datos: ESPECIALIDAD=", NEW.especialidad,
        "HORARIO DE DISPONIBILIDAD = ", NEW.horario_disponibilidad, 
        "TOTAL DE MIEMBROS ATENDIDOS = ", NEW.total_miembros_atendidos,
        "VALORACIÓN DE LOS MIEMBROS = ", NEW.valoracion_miembro),
        NOW(),
        DEFAULT
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `instructores_AFTER_UPDATE` AFTER UPDATE ON `instructores` FOR EACH ROW BEGIN
	INSERT INTO bitacora VALUES(
		DEFAULT,
        USER(),
        "Update",
        "instructores",
        CONCAT_WS(" ","Se han actualizado los datos del INSTRUCTOR con el ID: ",NEW.empleado_id, 
        "con los siguientes datos:",
        "ESPECIALIDAD = ", OLD.especialidad, " cambio a " ,NEW.especialidad,
        "HORARIO DE DISPONIBILIDAD = ", OLD.horario_disponibilidad, " cambio a " , NEW.horario_disponibilidad, 
        "TOTAL DE MIEMBROS ATENDIDOS = ", OLD.total_miembros_atendidos, " cambio a " , NEW.total_miembros_atendidos,
        "VALORACIÓN DE MIEMBRO = ",  OLD.valoracion_miembro, " cambio a " ,NEW.valoracion_miembro),
        NOW(),
        DEFAULT
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `instructores_AFTER_DELETE` AFTER DELETE ON `instructores` FOR EACH ROW BEGIN
	INSERT INTO bitacora VALUES(
		DEFAULT,
        USER(),
        "Delete",
        "instructores",
        CONCAT_WS(" ","Se ha eliminado un INSTRUCTOR con el ID: ", OLD.empleado_id),
        now(),
        DEFAULT
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `membresias`
--

DROP TABLE IF EXISTS `membresias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `membresias` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `Codigo` varchar(50) NOT NULL,
  `Tipo` enum('Individual','Familiar','Empresarial') NOT NULL,
  `Tipo_Servicios` enum('Basicos','Completa','Coaching','Nutriólogo') NOT NULL,
  `Tipo_Plan` enum('Anual','Semestral','Trimestral','Bimestral','Mensual','Semanal','Diaria') DEFAULT NULL,
  `Nivel` enum('Nuevo','Plata','Oro','Diamante') NOT NULL,
  `Fecha_Inicio` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Fecha_Fin` datetime NOT NULL,
  `Estatus` bit(1) NOT NULL DEFAULT b'1',
  `Fecha_Registro` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Fecha_Actualizacion` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `Codigo` (`Codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `membresias`
--

LOCK TABLES `membresias` WRITE;
/*!40000 ALTER TABLE `membresias` DISABLE KEYS */;
/*!40000 ALTER TABLE `membresias` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `membresias_AFTER_INSERT` AFTER INSERT ON `membresias` FOR EACH ROW BEGIN
	-- Declaración de variables
    DECLARE v_cadena_estatus varchar(15) default null;

    -- Iniciación de las variables
    IF new.estatus = b'1' then
        set v_cadena_estatus = "Activa";
    else
        set v_cadena_estatus = "Inactiva";
    end if;

    -- Insertar en la bitacora
    INSERT INTO bitacora VALUES(
        DEFAULT,
        USER(),
        "Create",
        "membresias",
        CONCAT_WS(" ","Se ha insertado una nueva AREA con el ID: ",NEW.ID, 
        "con los siguientes datos: ",
        "CODIGO = ", NEW.codigo,
        "TIPO = ", NEW.tipo,
        "TIPO SERVICIOS = ", NEW.tipo_servicios,
        "TIPO PLAN = ",  NEW.tipo_plan,
        "NIVEL = ", NEW.nivel, 
        "FECHA INICIO = ", NEW.fecha_inicio,
        "FECHA FIN = ", NEW.fecha_fin,
        "ESTATUS = ", v_cadena_estatus,
        "FECHA REGISTRO = ", NEW.fecha_registro,
        "FECHA ACTUALIZACIÓN = ", NEW.fecha_actualizacion),
        NOW(),
        DEFAULT
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `membresias_AFTER_UPDATE` AFTER UPDATE ON `membresias` FOR EACH ROW BEGIN
	 -- Declaración de variables
    DECLARE v_cadena_estatus VARCHAR(15) DEFAULT NULL;
    DECLARE v_cadena_estatus2 VARCHAR(15) DEFAULT NULL;
    
    -- Inicialización de las variables 
    IF NEW.estatus = b'1' THEN
		SET v_cadena_estatus= "Activa";
    ELSE
		SET v_cadena_estatus= "Inactiva";
    END IF; 
    
    IF OLD.estatus = b'1' THEN
		SET v_cadena_estatus2= "Activa";
    ELSE
		SET v_cadena_estatus2= "Inactiva";
    END IF; 
	INSERT INTO bitacora VALUES(
		DEFAULT,
        USER(),
        "Update",
        "membresias",
        CONCAT_WS(" ","Se han actualizado los datos de la MEMBRESIA con el ID: ",NEW.ID, 
        "con los siguientes datos:",
        "CODIGO = ", OLD.codigo, " cambio a " ,NEW.codigo,
        "TIPO = ",  OLD.tipo, " cambio a " ,NEW.tipo, 
		"TIPO SERVICIOS = ", OLD.tipo_servicios, " cambio a " , NEW.tipo_servicios,
        "TIPO PLAN = ", OLD.tipo_plan, " cambio a " , NEW.tipo_plan, 
        "NIVEL = ", OLD.nivel, " cambio a " , NEW.nivel,
        "FECHA INICIO = ",  OLD.fecha_inicio, " cambio a " ,NEW.fecha_inicio, 
        "FECHA FIN = ", OLD.fecha_fin, " cambio a " , NEW.fecha_fin,
        "ESTATUS = ",  v_cadena_estatus2, " cambio a " ,v_cadena_estatus,
        "FECHA REGISTRO = ",  OLD.fecha_registro, " cambio a " ,NEW.fecha_registro,
        "FECHA ACTUALIZACIÓN = ",  OLD.fecha_actualizacion, " cambio a " ,NEW.fecha_actualizacion),
        NOW(),
        DEFAULT
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `membresias_AFTER_DELETE` AFTER DELETE ON `membresias` FOR EACH ROW BEGIN
	INSERT INTO bitacora VALUES(
		DEFAULT,
        USER(),
        "Delete",
        "membresias",
        CONCAT_WS(" ","Se ha eliminado una MEMBRESIA con el ID: ", OLD.ID),
        now(),
        DEFAULT
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `membresias_usuarios`
--

DROP TABLE IF EXISTS `membresias_usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `membresias_usuarios` (
  `Membresia_ID` int unsigned NOT NULL,
  `Usuarios_ID` int unsigned NOT NULL,
  `Fecha_Ultima_Visita` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Estatus` bit(1) NOT NULL DEFAULT b'1',
  PRIMARY KEY (`Membresia_ID`,`Usuarios_ID`),
  KEY `fk_usuario_2` (`Usuarios_ID`),
  CONSTRAINT `fk_membresia_ID` FOREIGN KEY (`Membresia_ID`) REFERENCES `membresias` (`ID`),
  CONSTRAINT `fk_usuario_2` FOREIGN KEY (`Usuarios_ID`) REFERENCES `usuarios` (`Persona_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `membresias_usuarios`
--

LOCK TABLES `membresias_usuarios` WRITE;
/*!40000 ALTER TABLE `membresias_usuarios` DISABLE KEYS */;
/*!40000 ALTER TABLE `membresias_usuarios` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `membresias_usuarios_AFTER_INSERT` AFTER INSERT ON `membresias_usuarios` FOR EACH ROW BEGIN
	-- Declaración de variables
    DECLARE v_cadena_estatus varchar(15) default null;
    DECLARE v_nombre_membresia varchar(60) default null;
    DECLARE v_nombre_usuario varchar(60) default null;

    -- Iniciación de las variables
    IF new.estatus = b'1' then
        set v_cadena_estatus = "Activa";
    else
        set v_cadena_estatus = "Inactiva";
    end if;

    if new.membresia_id is not null then
        -- En caso de tener el id del empleado responsable debemos recuperar su nombre
        set v_nombre_membresia = (SELECT codigo FROM membresias WHERE id = NEW.membresia_id);
    else
        SET v_nombre_membresia = "Sin membresia asignado";
    end if;

    if new.usuarios_id is not null then
        -- En caso de tener el id de la sucursal debemos recuperar su nombre
        set v_nombre_usuario = (SELECT CONCAT_WS(" ", p.titulo_cortesia, p.nombre, p.primer_apellido, p.segundo_Apellido) FROM personas p WHERE id = NEW.usuarios_id);
    else
        SET v_nombre_usuario = "Sin usuario asignado";
    end if;

    -- Insertar en la bitacora
    INSERT INTO bitacora VALUES(
        DEFAULT,
        USER(),
        "Create",
        "membresias",
        CONCAT_WS(" ","Se ha insertado una nueva AREA con los IDs: Membresia - ", NEW.membresia_id, ", Usuario - ", NEW.usuarios_id, 
        "con los siguientes datos: ",
        "MEMBRESIA ID = ", v_nombre_membresia,
        "USUARIO ID = ",  v_nombre_usuario,
        "FECHA ULTIMA VISITA = ", NEW.fecha_ultima_visita, 
        "ESTATUS = ", v_cadena_estatus),
        NOW(),
        DEFAULT
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `membresias_usuarios_AFTER_UPDATE` AFTER UPDATE ON `membresias_usuarios` FOR EACH ROW BEGIN
	-- Declaración de variables
    DECLARE v_cadena_estatus VARCHAR(15) DEFAULT NULL;
    DECLARE v_nombre_membresia VARCHAR(100) DEFAULT NULL;
    DECLARE v_cadena_estatus2 VARCHAR(15) DEFAULT NULL;
    DECLARE v_nombre_membresia2 VARCHAR(100) DEFAULT NULL;
    DECLARE v_nombre_usuario VARCHAR(60) DEFAULT NULL;
    DECLARE v_nombre_usuario2 VARCHAR(60) DEFAULT NULL;

    -- Inicialización de las variables
    IF NEW.estatus = b'1' THEN
		SET v_cadena_estatus= "Activa";
    ELSE
		SET v_cadena_estatus= "Inactiva";
    END IF; 
    
    IF OLD.estatus = b'1' THEN
		SET v_cadena_estatus2= "Activa";
    ELSE
		SET v_cadena_estatus2= "Inactiva";
    END IF; 
          
    IF NEW.membresia_id IS NOT NULL THEN 
		-- En caso de tener el id de la membresia
		SET v_nombre_membresia =  (SELECT codigo FROM membresias WHERE id = NEW.membresia_id);
    ELSE
		SET v_nombre_membresia = "Sin membresia asignada.";
    END IF;
    
    IF OLD.membresia_id IS NOT NULL THEN 
		-- En caso de tener el id de la membresia
		SET v_nombre_membresia2 =  (SELECT codigo FROM membresias WHERE id = OLD.membresia_id);
    ELSE
		SET v_nombre_membresia2 = "Sin membresia asignada.";
    END IF;

    IF NEW.usuarios_id IS NOT NULL THEN 
		-- En caso de tener el id del usuario
		SET v_nombre_usuario =  (SELECT CONCAT_WS(" ", p.titulo_cortesia, p.nombre, p.primer_apellido, p.segundo_Apellido) FROM personas p WHERE id = NEW.usuarios_id);
    ELSE
		SET v_nombre_usuario = "Sin usuario asignada.";
    END IF;

    IF OLD.usuarios_id IS NOT NULL THEN 
		-- En caso de tener el id del usuario
		SET v_nombre_usuario2 =  (SELECT CONCAT_WS(" ", p.titulo_cortesia, p.nombre, p.primer_apellido, p.segundo_Apellido) FROM personas p WHERE id = OLD.usuarios_id);
    ELSE
		SET v_nombre_usuario2 = "Sin usuario asignada.";
    END IF;
    
    INSERT INTO bitacora VALUES(
        DEFAULT,
        USER(),
        "Update",
        "membresias_usuarios",
        CONCAT_WS(" ","Se han actualizado los datos del área con los IDs: Membresia - ", OLD.membresia_id, ", Usuario - ", OLD.usuarios_id,
		"con los siguientes datos:",
        "MEMBRESIA ID = ", v_nombre_membresia2, " cambio a ", v_nombre_membresia,
        "USUARIOS ID =",v_nombre_usuario2," cambio a ", v_nombre_usuario,
        "FECHA ULTIMA VISITA =",OLD.fecha_ultima_visita," cambio a ", NEW.fecha_ultima_visita,
        "ESTATUS = ", v_cadena_estatus2, " cambio a ", v_cadena_estatus),
        NOW(),
        DEFAULT       
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `membresias_usuarios_AFTER_DELETE` AFTER DELETE ON `membresias_usuarios` FOR EACH ROW BEGIN
	INSERT INTO bitacora VALUES(
		DEFAULT,
		USER(),
		"Delete",
		"membresias_usuarios",
		CONCAT_WS(" ","Se ha eliminado una relación MEMBRESIAS USUARIOS con los IDs: Membresia - ", OLD.membresia_id, ", Usuario - ", OLD.usuarios_id),
		now(),
		DEFAULT
	);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `miembros`
--

DROP TABLE IF EXISTS `miembros`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `miembros` (
  `Persona_ID` int unsigned NOT NULL,
  `Tipo` enum('Frecuente','Ocasional','Nuevo','Esporádico','Una sola visita') NOT NULL,
  `Membresia_Activa` bit(1) NOT NULL DEFAULT b'1',
  `Antiguedad` varchar(80) NOT NULL,
  PRIMARY KEY (`Persona_ID`),
  CONSTRAINT `fk_persona_1` FOREIGN KEY (`Persona_ID`) REFERENCES `personas` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `miembros`
--

LOCK TABLES `miembros` WRITE;
/*!40000 ALTER TABLE `miembros` DISABLE KEYS */;
/*!40000 ALTER TABLE `miembros` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `miembros_AFTER_INSERT` AFTER INSERT ON `miembros` FOR EACH ROW BEGIN
	-- Declaración de variables
    DECLARE v_cadena_estatus varchar(15) default null;
	-- Iniciación de las variables
    IF new.membresia_activa = b'1' then
        set v_cadena_estatus = "Activa";
    else
        set v_cadena_estatus = "Inactiva";
    end if;
    
	INSERT INTO bitacora VALUES(
		DEFAULT,
        USER(),
        "Create",
        "miembros",
        CONCAT_WS(" ","Se ha insertado un nuevo MIEMBRO con el ID: ",NEW.persona_id, 
        "con los siguientes datos: TIPO = ", NEW.tipo,
        "MEMBRESIA ACTIVA = ", v_cadena_estatus,
        "ANTIGUEDAD = ", NEW.antiguedad),
        NOW(),
        DEFAULT
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `miembros_AFTER_UPDATE` AFTER UPDATE ON `miembros` FOR EACH ROW BEGIN
	-- Declaración de variables
    DECLARE v_cadena_estatus VARCHAR(15) DEFAULT NULL;
    DECLARE v_cadena_estatus2 VARCHAR(15) DEFAULT NULL;
    
    -- Inicialización de las variables
    IF NEW.membresia_activa = b'1' THEN
		SET v_cadena_estatus= "Activa";
    ELSE
		SET v_cadena_estatus= "Inactiva";
    END IF; 
    
    IF OLD.membresia_activa = b'1' THEN
		SET v_cadena_estatus2= "Activa";
    ELSE
		SET v_cadena_estatus2= "Inactiva";
    END IF; 
    
    INSERT INTO bitacora VALUES(
        DEFAULT,
        USER(),
        "Update",
        "miembros",
        CONCAT_WS(" ","Se han actualizado los datos del MIEMBRO con el ID: ",
        NEW.persona_id, "con los siguientes datos:",
        "TIPO = ", OLD.tipo, "cambio a", NEW.tipo,
        "MEMBRESIA ACTIVA =",v_cadena_estatus2,"cambio a", v_cadena_estatus,
        "ANTIGUEDAD = ", OLD.antiguedad, "cambio a", NEW.antiguedad),
        NOW(),
        DEFAULT       
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `miembros_AFTER_DELETE` AFTER DELETE ON `miembros` FOR EACH ROW BEGIN
	INSERT INTO bitacora VALUES(
		DEFAULT,
        USER(),
        "Delete",
        "miembros",
        CONCAT_WS(" ","Se ha eliminado el MIEMBRO con el ID: ", OLD.persona_id),
        now(),
        DEFAULT
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `pedidos`
--

DROP TABLE IF EXISTS `pedidos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pedidos` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `Usuario_ID` int unsigned NOT NULL,
  `Producto_ID` int unsigned NOT NULL,
  `Total` decimal(6,2) NOT NULL,
  `Fecha_Registro` datetime DEFAULT CURRENT_TIMESTAMP,
  `Estatus` bit(1) NOT NULL DEFAULT b'1',
  PRIMARY KEY (`ID`),
  KEY `fk_usuario_3` (`Usuario_ID`),
  KEY `fk_producto_4` (`Producto_ID`),
  CONSTRAINT `fk_producto_4` FOREIGN KEY (`Producto_ID`) REFERENCES `productos` (`ID`),
  CONSTRAINT `fk_usuario_3` FOREIGN KEY (`Usuario_ID`) REFERENCES `usuarios` (`Persona_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedidos`
--

LOCK TABLES `pedidos` WRITE;
/*!40000 ALTER TABLE `pedidos` DISABLE KEYS */;
INSERT INTO `pedidos` VALUES (1,101,101,20.00,'2023-02-09 10:05:57',_binary ''),(2,102,102,30.00,'2024-03-08 08:51:03',_binary ''),(3,103,103,50.00,'2021-06-01 10:25:43',_binary ''),(4,104,104,50.00,'2022-01-06 18:16:49',_binary ''),(5,105,105,10.00,'2024-01-02 14:30:21',_binary ''),(6,106,106,90.00,'2020-09-15 10:49:25',_binary ''),(7,107,107,20.00,'2020-08-15 12:55:21',_binary ''),(8,108,108,30.00,'2022-09-26 12:15:50',_binary ''),(9,109,109,10.00,'2023-01-30 11:44:31',_binary ''),(10,110,110,60.00,'2022-08-14 12:58:35',_binary ''),(11,111,111,50.00,'2021-04-25 10:31:40',_binary ''),(12,112,112,10.00,'2020-02-12 18:14:41',_binary ''),(13,113,113,50.00,'2023-06-21 16:27:15',_binary ''),(14,114,114,80.00,'2021-03-19 11:40:27',_binary ''),(15,115,115,80.00,'2022-04-04 11:41:22',_binary ''),(16,116,116,40.00,'2022-12-04 12:28:11',_binary ''),(17,117,117,40.00,'2023-07-15 08:48:44',_binary ''),(18,118,118,40.00,'2020-11-01 19:54:52',_binary ''),(19,119,119,40.00,'2023-03-06 16:11:01',_binary ''),(20,120,120,60.00,'2022-09-26 13:31:35',_binary ''),(21,121,121,50.00,'2021-02-07 17:30:29',_binary ''),(22,122,122,20.00,'2022-04-25 11:36:08',_binary ''),(23,123,123,50.00,'2023-12-06 11:30:12',_binary ''),(24,124,124,70.00,'2022-04-17 15:27:58',_binary ''),(25,125,125,10.00,'2023-12-08 13:26:37',_binary ''),(26,126,126,20.00,'2022-07-08 14:08:15',_binary ''),(27,127,127,20.00,'2020-08-25 13:17:17',_binary ''),(28,128,128,70.00,'2020-05-23 13:13:40',_binary ''),(29,129,129,20.00,'2021-05-30 09:37:02',_binary ''),(30,130,130,60.00,'2021-09-01 13:11:42',_binary ''),(31,131,131,20.00,'2022-12-21 09:30:05',_binary ''),(32,132,132,60.00,'2023-01-06 18:59:16',_binary ''),(33,133,133,10.00,'2021-07-29 17:02:20',_binary ''),(34,134,134,100.00,'2024-02-14 19:08:37',_binary ''),(35,135,135,40.00,'2024-01-04 14:17:50',_binary ''),(36,136,136,80.00,'2023-09-24 09:10:32',_binary ''),(37,137,137,100.00,'2023-09-03 14:38:46',_binary ''),(38,138,138,70.00,'2021-01-14 12:40:51',_binary ''),(39,139,139,100.00,'2020-06-08 14:44:04',_binary ''),(40,140,140,30.00,'2021-09-04 10:36:55',_binary ''),(41,141,141,80.00,'2022-07-11 15:35:23',_binary ''),(42,142,142,10.00,'2022-08-24 19:49:41',_binary ''),(43,143,143,80.00,'2022-01-31 08:53:50',_binary ''),(44,144,144,60.00,'2023-04-02 08:02:37',_binary ''),(45,145,145,90.00,'2022-01-22 19:28:17',_binary ''),(46,146,146,70.00,'2022-04-10 16:21:56',_binary ''),(47,147,147,30.00,'2021-06-28 19:48:47',_binary ''),(48,148,148,30.00,'2021-10-08 12:12:13',_binary ''),(49,149,149,100.00,'2020-12-05 12:05:02',_binary ''),(50,150,150,20.00,'2020-07-21 12:07:33',_binary ''),(51,151,151,40.00,'2022-01-09 11:42:23',_binary ''),(52,152,152,100.00,'2021-05-06 15:09:46',_binary ''),(53,153,153,30.00,'2021-08-08 19:55:11',_binary ''),(54,154,154,10.00,'2021-06-07 15:19:32',_binary ''),(55,155,155,30.00,'2021-12-02 14:00:38',_binary ''),(56,156,156,80.00,'2023-01-22 11:25:43',_binary ''),(57,157,157,60.00,'2024-02-15 10:13:25',_binary ''),(58,158,158,40.00,'2020-06-04 13:47:17',_binary ''),(59,159,159,50.00,'2021-11-06 17:07:06',_binary ''),(60,160,160,80.00,'2024-01-25 12:20:50',_binary ''),(61,161,161,90.00,'2020-06-13 18:43:56',_binary ''),(62,162,162,30.00,'2022-01-13 13:58:43',_binary ''),(63,163,163,20.00,'2021-01-18 15:57:06',_binary ''),(64,164,164,90.00,'2022-04-02 19:07:44',_binary ''),(65,165,165,30.00,'2021-07-10 19:32:56',_binary ''),(66,166,166,50.00,'2022-06-28 14:36:11',_binary ''),(67,167,167,40.00,'2023-03-28 16:55:49',_binary ''),(68,168,168,80.00,'2021-06-03 14:04:12',_binary ''),(69,169,169,50.00,'2023-01-17 10:14:44',_binary ''),(70,170,170,20.00,'2023-11-08 19:58:11',_binary ''),(71,171,171,40.00,'2022-11-20 12:08:39',_binary ''),(72,172,172,100.00,'2020-08-25 18:41:48',_binary ''),(73,173,173,60.00,'2022-01-14 17:20:18',_binary ''),(74,174,174,100.00,'2023-08-14 11:38:54',_binary ''),(75,175,175,50.00,'2020-10-28 14:19:16',_binary ''),(76,176,176,50.00,'2020-10-19 16:04:23',_binary ''),(77,177,177,80.00,'2023-03-19 14:18:28',_binary ''),(78,178,178,10.00,'2023-01-08 13:55:08',_binary ''),(79,179,179,30.00,'2021-12-23 14:21:17',_binary ''),(80,180,180,40.00,'2023-09-12 09:39:59',_binary ''),(81,181,181,30.00,'2021-03-23 15:13:22',_binary ''),(82,182,182,70.00,'2024-03-15 08:26:13',_binary ''),(83,183,183,20.00,'2021-09-18 16:05:57',_binary ''),(84,184,184,90.00,'2021-04-13 18:06:03',_binary ''),(85,185,185,50.00,'2022-10-22 17:51:57',_binary ''),(86,186,186,70.00,'2020-04-04 11:57:01',_binary ''),(87,187,187,60.00,'2023-04-30 10:02:47',_binary ''),(88,188,188,20.00,'2023-09-30 08:04:28',_binary ''),(89,189,189,50.00,'2022-01-27 09:43:46',_binary ''),(90,190,190,10.00,'2022-06-14 14:51:16',_binary ''),(91,191,191,100.00,'2020-02-26 11:49:14',_binary ''),(92,192,192,100.00,'2023-01-14 17:25:23',_binary ''),(93,193,193,80.00,'2020-11-02 17:28:31',_binary ''),(94,194,194,20.00,'2020-05-05 18:20:11',_binary ''),(95,195,195,100.00,'2024-02-22 08:32:13',_binary ''),(96,196,196,60.00,'2022-08-10 13:50:09',_binary ''),(97,197,197,60.00,'2023-12-19 08:21:10',_binary ''),(98,198,198,90.00,'2020-04-28 17:07:23',_binary ''),(99,199,199,50.00,'2020-04-03 18:23:44',_binary ''),(100,200,200,40.00,'2023-01-16 14:27:06',_binary '');
/*!40000 ALTER TABLE `pedidos` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `pedidos_AFTER_INSERT` AFTER INSERT ON `pedidos` FOR EACH ROW BEGIN
	-- Declaración de variables
    DECLARE v_nombre_usuario varchar(100) default null;
    DECLARE v_nombre_producto varchar(100) default null;
	DECLARE v_cadena_estatus varchar(15) default null;

    -- Iniciación de las variables
    IF new.estatus = b'1' then
        set v_cadena_estatus = "Activa";
    else
        set v_cadena_estatus = "Inactiva";
    end if;
    
    if new.usuario_id is not null then
        -- En caso de tener el id del usuario debemos recuperar su nombre
        set v_nombre_usuario = (SELECT CONCAT_WS(" ", p.titulo_cortesia, p.nombre, p.primer_apellido, p.segundo_Apellido) FROM personas p WHERE id = NEW.usuario_id);
    else
        SET v_nombre_usuario = "Sin usuario asignado";
    end if;
    
    if new.producto_id is not null then
        -- En caso de tener el id del usuario debemos recuperar su nombre
        set v_nombre_producto = (SELECT CONCAT_WS(" ", p.nombre, p.marca, p.precio_actual, p.fotografia) FROM productos p WHERE id = NEW.producto_id);
    else
        SET v_nombre_producto = "Sin usuario asignado";
    end if;

    -- Insertar en la bitacora
    INSERT INTO bitacora VALUES(
        DEFAULT,
        USER(),
        "Create",
        "pedidos",
        CONCAT_WS(" ","Se ha insertado un nuevo PEDIDO con el ID: ",NEW.ID, 
        "con los siguientes datos: ",
        "USUARIO ID = ", v_nombre_usuario,
        "PRODUCTO ID = ", v_nombre_producto,
        "TOTAL = ", NEW.total, 
        "FECHA REGISTRO = ",  NEW.fecha_registro,
        "ESTATUS = ", v_cadena_estatus),
        NOW(),
        DEFAULT
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `pedidos_AFTER_UPDATE` AFTER UPDATE ON `pedidos` FOR EACH ROW BEGIN
	 -- Declaración de variables
    DECLARE v_cadena_estatus VARCHAR(15) DEFAULT NULL;
    DECLARE v_nombre_usuario VARCHAR(100) DEFAULT NULL;
    DECLARE v_cadena_estatus2 VARCHAR(15) DEFAULT NULL;
    DECLARE v_nombre_usuario2 VARCHAR(100) DEFAULT NULL;
    DECLARE v_nombre_producto VARCHAR(100) DEFAULT NULL;
    DECLARE v_nombre_producto2 VARCHAR(100) DEFAULT NULL;

    -- Inicialización de las variables
    IF NEW.estatus = b'1' THEN
		SET v_cadena_estatus= "Activa";
    ELSE
		SET v_cadena_estatus= "Inactiva";
    END IF; 
    
    IF OLD.estatus = b'1' THEN
		SET v_cadena_estatus2= "Activa";
    ELSE
		SET v_cadena_estatus2= "Inactiva";
    END IF; 
          
    IF NEW.usuario_id IS NOT NULL THEN 
		-- En caso de tener el id del usuario
		SET v_nombre_usuario = (SELECT CONCAT_WS(" ", p.titulo_cortesia, p.nombre, p.primer_apellido,p.segundo_apellido) FROM personas p WHERE id = NEW.usuario_id);
    ELSE
		SET v_nombre_usuario = "Sin usuario asignado.";
    END IF;
    
    IF OLD.usuario_id IS NOT NULL THEN 
		-- En caso de tener el id del usuario
		SET v_nombre_usuario2 = (SELECT CONCAT_WS(" ", p.titulo_cortesia, p.nombre, p.primer_apellido,
		p.segundo_apellido) FROM personas p WHERE id = OLD.usuario_id);
    ELSE
		SET v_nombre_usuario2 = "Sin usuario asignado.";
    END IF;
    
    if new.producto_id is not null then
        -- En caso de tener el id del usuario debemos recuperar su nombre
        set v_nombre_producto = (SELECT CONCAT_WS(" ", p.nombre, p.marca, p.precio_actual, p.fotografia) FROM productos p WHERE id = NEW.producto_id);
    else
        SET v_nombre_producto = "Sin usuario asignado";
    end if;
    
    if new.producto_id is not null then
        -- En caso de tener el id del usuario debemos recuperar su nombre
        set v_nombre_producto2 = (SELECT CONCAT_WS(" ", p.nombre, p.marca, p.precio_actual, p.fotografia) FROM productos p WHERE id = NEW.producto_id);
    else
        SET v_nombre_producto2 = "Sin usuario asignado";
    end if;

    INSERT INTO bitacora VALUES(
        DEFAULT,
        USER(),
        "Update",
        "pedidos",
        CONCAT_WS(" ","Se han actualizado los datos del PEDIDO con el ID: ", NEW.ID,
        "con los siguientes datos:",
        "USUARIO ID = ", v_nombre_usuario2, "cambio a", v_nombre_usuario,
        "PRODUCTO ID = ",v_nombre_producto2, "cambio a", v_nombre_producto,
        "TOTAL =",OLD.total,"cambio a", NEW.total,
        "FECHA DE REGISTRO =",OLD.fecha_registro,"cambio a", NEW.fecha_registro,
        "ESTATUS = ", v_cadena_estatus2, "cambio a", v_cadena_estatus),
        NOW(),
        DEFAULT       
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `pedidos_AFTER_DELETE` AFTER DELETE ON `pedidos` FOR EACH ROW BEGIN
	INSERT INTO bitacora VALUES(
		DEFAULT,
        USER(),
        "Delete",
        "pedidos",
        CONCAT_WS(" ","Se ha eliminado un PEDIDO con el ID: ", OLD.ID),
        now(),
        DEFAULT
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `personas`
--

DROP TABLE IF EXISTS `personas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `personas` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `Titulo_Cortesia` varchar(20) DEFAULT NULL,
  `Nombre` varchar(80) NOT NULL,
  `Primer_Apellido` varchar(80) NOT NULL,
  `Segundo_Apellido` varchar(80) NOT NULL,
  `Fecha_Nacimiento` date NOT NULL,
  `Fotografia` varchar(100) DEFAULT NULL,
  `Genero` enum('M','F','N/B') DEFAULT NULL,
  `Tipo_Sangre` enum('A+','A-','B+','B-','AB+','AB-','O+','O-') NOT NULL,
  `Estatus` bit(1) DEFAULT b'1',
  `Fecha_Registro` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Fecha_Actualizacion` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=201 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `personas`
--

LOCK TABLES `personas` WRITE;
/*!40000 ALTER TABLE `personas` DISABLE KEYS */;
INSERT INTO `personas` VALUES (1,NULL,'Juan','Vázquez','Morales','1978-07-28',NULL,'M','A-',_binary '','2024-04-04 11:02:56',NULL),(2,NULL,'Paola','Gutiérrez','Medina','1978-06-07',NULL,'F','O+',_binary '','2020-10-01 11:11:14',NULL),(3,NULL,'Edgar','Luna','Pérez','1961-02-04',NULL,'M','O+',_binary '','2020-06-06 19:42:41',NULL),(4,NULL,'Luz','Álvarez','Gutiérrez','1973-12-08',NULL,'F','B+',_binary '','2024-02-08 16:00:07',NULL),(5,NULL,'Gustavo','Ruíz','López','1969-05-05',NULL,'M','O+',_binary '','2022-01-13 18:59:06',NULL),(6,'Sgto.','Adalid','De la Cruz','Luna','2003-08-11',NULL,'M','O-',_binary '','2020-01-07 10:17:05',NULL),(7,NULL,'Carlos','Medina','Hernández','1959-11-07',NULL,'M','A+',_binary '','2024-03-29 19:05:22',NULL),(8,NULL,'Estrella','Méndez','Santiago','2000-03-28',NULL,'F','B-',_binary '','2023-11-09 08:33:03',NULL),(9,NULL,'Luz','Estrada','Jiménez','1995-04-30',NULL,'F','O+',_binary '','2022-08-29 17:36:08',NULL),(10,'Sr.','Federico','Velázquez','Jiménez','1971-04-02',NULL,'M','B+',_binary '','2022-11-25 14:23:36',NULL),(11,NULL,'Lorena','Ruíz','Santiago','1969-12-24',NULL,'F','B-',_binary '','2022-07-04 14:53:38',NULL),(12,'Sra.','Paola','Gómes',' González','1998-01-25',NULL,'F','AB-',_binary '','2024-01-14 16:31:10',NULL),(13,NULL,'Bertha',' Rivera','Domínguez','1982-10-26',NULL,'F','B-',_binary '','2023-06-29 16:33:41',NULL),(14,'Sr.','Juan','García','Santiago','1977-11-06',NULL,'M','A-',_binary '','2020-01-03 11:55:00',NULL),(15,NULL,'Fernando','Cortés','Cortes','1967-05-11',NULL,'M','A-',_binary '','2021-06-21 10:32:57',NULL),(16,'Ing.','Suri','Ramírez','Díaz','1972-11-06',NULL,'F','B+',_binary '','2023-02-08 16:12:49',NULL),(17,NULL,'Gerardo','Contreras','Cruz','1985-12-29',NULL,'M','A-',_binary '','2020-03-13 17:51:51',NULL),(18,NULL,'Juan','López','Cruz','1996-03-30',NULL,'M','A-',_binary '','2023-01-29 19:57:06',NULL),(19,NULL,'Gerardo','Pérez','Chávez','1984-06-07',NULL,'M','O+',_binary '','2023-07-06 13:40:47',NULL),(20,NULL,'Marco','Juárez','Hernández','1969-12-27',NULL,'M','A+',_binary '','2022-11-06 09:30:43',NULL),(21,NULL,'Suri','Moreno','Velázquez','1983-04-14',NULL,'F','A+',_binary '','2020-05-31 09:43:51',NULL),(22,NULL,'Karla','Aguilar','Cruz','1992-08-26',NULL,'F','O+',_binary '','2020-04-02 17:59:39',NULL),(23,NULL,'Gustavo','Guerrero','De la Cruz','1969-03-14',NULL,'M','AB-',_binary '','2023-01-08 14:21:51',NULL),(24,NULL,'Daniel','Castillo','Méndez','1974-02-15',NULL,'M','O+',_binary '','2021-05-01 08:13:51',NULL),(25,'Mtra','Jazmin','Moreno','Velázquez','1981-03-16',NULL,'F','O-',_binary '','2021-07-12 19:31:37',NULL),(26,NULL,'Flor','Moreno','Martínez','2002-01-16',NULL,'F','A-',_binary '','2021-04-10 19:12:29',NULL),(27,NULL,' Agustin','Álvarez','Pérez','2007-06-24',NULL,'M','AB+',_binary '','2024-04-11 10:32:29',NULL),(28,'Mtra','Lucía','Salazar','Guzmán','1970-06-09',NULL,'F','O-',_binary '','2023-09-01 14:33:26',NULL),(29,'Med.','Ricardo','Gutiérrez','Cortes','2004-04-13',NULL,'M','O-',_binary '','2020-05-15 14:19:09',NULL),(30,NULL,'Hugo','Salazar',' González','2006-07-12',NULL,'M','AB+',_binary '','2023-12-23 19:16:14',NULL),(31,NULL,'Luz','Gómes','Luna','1987-08-17',NULL,'F','B+',_binary '','2023-08-05 10:52:00',NULL),(32,NULL,'Jazmin','Gutiérrez','Díaz','1990-12-28',NULL,'F','A-',_binary '','2024-01-30 10:35:11',NULL),(33,NULL,'Iram','Mendoza','Guzmán','1984-09-23',NULL,'M','B+',_binary '','2020-05-31 13:52:12',NULL),(34,'Sr.','Aldair','Salazar','Morales','1996-06-16',NULL,'M','A+',_binary '','2023-12-07 13:32:35',NULL),(35,NULL,'Jesus',' González','Soto','1994-02-22',NULL,'M','AB+',_binary '','2023-03-20 08:10:11',NULL),(36,NULL,'Samuel','Ruíz','Cortes','2002-03-10',NULL,'M','AB-',_binary '','2020-02-21 19:36:42',NULL),(37,NULL,'Flor','Castillo',' González','2007-06-25',NULL,'F','AB-',_binary '','2021-06-11 16:31:08',NULL),(38,NULL,'Ana','Castillo','Vargas','1967-01-25',NULL,'F','AB+',_binary '','2022-08-05 10:03:05',NULL),(39,'Mtra','Sofia','López','Contreras','1999-01-07',NULL,'F','AB-',_binary '','2023-04-16 18:55:36',NULL),(40,NULL,'Valeria','Sánchez','Santiago','2007-12-11',NULL,'F','B+',_binary '','2022-02-11 14:56:31',NULL),(41,NULL,'Jesus','Torres','Vázquez','1975-03-23',NULL,'M','O+',_binary '','2020-07-29 10:27:10',NULL),(42,NULL,'Maximiliano','Mendoza','Torres','1978-03-06',NULL,'M','O-',_binary '','2022-10-06 12:03:29',NULL),(43,NULL,'Monica','Santiago','Romero','2001-12-19',NULL,'F','O+',_binary '','2022-03-25 09:23:53',NULL),(44,'C.P.','Paola','Sánchez','Chávez','1981-02-26',NULL,'F','AB+',_binary '','2020-10-18 12:58:05',NULL),(45,NULL,'Juan','Ruíz','Velázquez','1992-10-16',NULL,'M','A+',_binary '','2021-09-13 16:33:04',NULL),(46,NULL,'Hortencia','Méndez',' González','1997-10-05',NULL,'F','AB-',_binary '','2024-04-02 19:18:52',NULL),(47,NULL,'Ameli','Castillo','De la Cruz','1979-05-21',NULL,'F','AB-',_binary '','2021-05-04 13:12:42',NULL),(48,NULL,'Monica','Guzmán','Castro','1974-03-11',NULL,'F','B-',_binary '','2020-03-25 09:04:05',NULL),(49,NULL,'Fernando',' González','Guzmán','1983-01-13',NULL,'M','A-',_binary '','2021-05-25 09:55:28',NULL),(50,NULL,'Brenda','Contreras','De la Cruz','1986-05-01',NULL,'F','B+',_binary '','2020-11-26 19:12:46',NULL),(51,'C.','Pedro','Ortega','Pérez','2004-02-01',NULL,'M','A-',_binary '','2022-02-28 17:14:08',NULL),(52,NULL,'Jazmin','Salazar','Medina','2003-09-24',NULL,'F','B-',_binary '','2023-01-06 08:41:23',NULL),(53,'Med.','Edgar','Velázquez','Guzmán','1981-08-13',NULL,'M','A+',_binary '','2023-03-26 16:17:49',NULL),(54,'Lic.','Adalid','Romero','Moreno','1997-01-21',NULL,'M','B-',_binary '','2024-03-05 13:52:57',NULL),(55,NULL,'Samuel','Gutiérrez',' González','1974-03-24',NULL,'M','B+',_binary '','2021-08-29 09:49:06',NULL),(56,NULL,'Guadalupe','Mendoza','Jiménez','1972-11-19',NULL,'F','B-',_binary '','2022-02-09 08:43:48',NULL),(57,NULL,'Monica','Moreno','Díaz','1974-07-28',NULL,'F','AB+',_binary '','2022-12-10 18:12:30',NULL),(58,NULL,'Karla','Martínez','Torres','1981-08-15',NULL,'F','B+',_binary '','2020-08-22 18:02:19',NULL),(59,NULL,'Suri','Rodríguez','Pérez','1965-07-20',NULL,'F','B+',_binary '','2020-10-07 19:27:58',NULL),(60,NULL,'Paola','Castro','Moreno','1967-02-27',NULL,'F','B-',_binary '','2022-08-13 17:28:28',NULL),(61,NULL,'Edgar','Pérez','Castillo','1965-08-14',NULL,'M','A-',_binary '','2022-02-03 18:56:46',NULL),(62,NULL,'Adalid','Jiménez','Moreno','1979-10-15',NULL,'M','AB-',_binary '','2020-08-30 16:43:20',NULL),(63,NULL,'Edgar','Contreras','Guerrero','1963-07-06',NULL,'M','AB-',_binary '','2021-06-24 14:43:26',NULL),(64,NULL,'Aldair','García','Jiménez','1980-07-08',NULL,'M','A-',_binary '','2023-12-08 18:12:37',NULL),(65,NULL,'Hortencia','Salazar','Ramos','1988-08-18',NULL,'F','A+',_binary '','2023-07-06 16:36:54',NULL),(66,NULL,'Paula','Cruz','Torres','1961-06-01',NULL,'F','A-',_binary '','2020-05-02 15:59:33',NULL),(67,'Joven','Juan','Aguilar','Bautista','1982-04-18',NULL,'M','AB+',_binary '','2020-06-18 08:21:41',NULL),(68,NULL,'Hortencia','García','Méndez','1991-04-10',NULL,'F','AB+',_binary '','2020-07-10 17:08:28',NULL),(69,NULL,'Maria','Cortés','Juárez','1968-04-16',NULL,'F','A+',_binary '','2023-03-24 14:52:58',NULL),(70,NULL,'Maria','Ramos','Bautista','2001-10-06',NULL,'F','B-',_binary '','2023-05-20 14:02:51',NULL),(71,NULL,'Esmeralda','Vargas','Herrera','1967-09-07',NULL,'F','O+',_binary '','2022-11-06 17:42:03',NULL),(72,'Med.','Luz','Cortes','Herrera','1996-06-08',NULL,'F','O+',_binary '','2022-06-23 14:52:39',NULL),(73,NULL,'Juan','Morales','Martínez','1982-02-28',NULL,'M','A-',_binary '','2022-05-19 10:22:48',NULL),(74,NULL,'Pedro','Santiago','Gómes','1982-10-20',NULL,'M','AB-',_binary '','2020-02-18 08:53:01',NULL),(75,NULL,'Hugo','Cortés','Santiago','1984-07-08',NULL,'M','O-',_binary '','2024-03-22 10:23:50',NULL),(76,'Sr.','Gustavo','Contreras','Torres','1970-04-29',NULL,'M','A-',_binary '','2024-02-25 13:21:47',NULL),(77,NULL,'Iram','Contreras','Guzmán','1973-03-07',NULL,'M','A-',_binary '','2020-02-20 15:35:18',NULL),(78,NULL,'Ricardo','Contreras','Castillo','2005-09-27',NULL,'M','B+',_binary '','2022-09-18 11:17:36',NULL),(79,NULL,'José','Luna','Gómes','1991-07-26',NULL,'M','AB+',_binary '','2023-12-22 18:36:47',NULL),(80,NULL,'Aldair','Ortega','Mendoza','1980-07-11',NULL,'M','O-',_binary '','2021-12-07 12:48:53',NULL),(81,NULL,'Monica','López','Jiménez','1977-10-19',NULL,'F','O-',_binary '','2022-04-18 18:28:29',NULL),(82,NULL,'Ameli','Ramírez','Morales','1995-03-01',NULL,'F','O-',_binary '','2021-06-02 19:13:50',NULL),(83,'C.P.','Dulce','Jiménez',' González','1987-10-21',NULL,'F','AB+',_binary '','2021-04-22 16:19:03',NULL),(84,NULL,'Dulce',' Rivera','Ramos','1976-08-03',NULL,'F','O-',_binary '','2021-05-15 19:36:20',NULL),(85,NULL,'Maria',' González','Díaz','1981-10-08',NULL,'F','A-',_binary '','2023-07-16 12:46:46',NULL),(86,NULL,'Mario','Domínguez','Estrada','1994-06-15',NULL,'M','O+',_binary '','2023-06-27 16:09:36',NULL),(87,'C.P.','Brenda','Cruz','Vargas','1965-06-10',NULL,'F','B-',_binary '','2023-04-09 14:16:46',NULL),(88,NULL,'Marco','Contreras','Martínez','1997-02-13',NULL,'M','AB-',_binary '','2021-04-09 11:44:46',NULL),(89,'Lic.','Marco','Guzmán','Velázquez','1988-12-30',NULL,'M','AB-',_binary '','2023-01-26 13:27:43',NULL),(90,'Sgto.','Hugo','Juárez','López','1985-09-07',NULL,'M','B-',_binary '','2022-12-15 08:41:16',NULL),(91,'C.','Samuel','Gómes','Gutiérrez','1964-01-29',NULL,'M','B-',_binary '','2023-02-10 12:55:18',NULL),(92,'Lic.','Samuel','Mendoza','Cortes','2001-11-09',NULL,'M','AB-',_binary '','2023-10-13 11:44:34',NULL),(93,NULL,'Ana','Herrera',' Rivera','2001-12-08',NULL,'F','AB+',_binary '','2021-11-27 12:38:00',NULL),(94,NULL,'Juan','Bautista','Méndez','2005-07-10',NULL,'M','A+',_binary '','2021-10-15 19:13:01',NULL),(95,NULL,'Lorena','Torres','Chávez','2000-04-02',NULL,'F','B-',_binary '','2024-03-19 12:56:21',NULL),(96,NULL,'Flor',' Rivera','Juárez','1974-02-28',NULL,'F','AB-',_binary '','2021-11-18 10:11:13',NULL),(97,NULL,'Esmeralda','Bautista','Santiago','1989-04-12',NULL,'F','B+',_binary '','2024-04-01 18:12:42',NULL),(98,NULL,'Daniel','Aguilar','Morales','2006-09-12',NULL,'M','A+',_binary '','2022-05-08 13:35:14',NULL),(99,'Dra.','Brenda','Salazar','Bautista','1971-06-09',NULL,'F','B-',_binary '','2021-05-12 12:11:09',NULL),(100,NULL,'Samuel','Medina','Medina','1978-06-10',NULL,'M','O+',_binary '','2020-09-15 10:40:07',NULL),(101,NULL,'Lorena','Herrera','Reyes','1981-02-26',NULL,'F','B+',_binary '','2021-07-24 17:33:41',NULL),(102,NULL,'Sofia','Jiménez','Estrada','1998-02-03',NULL,'F','A-',_binary '','2021-05-31 10:39:41',NULL),(103,NULL,'Diana','Aguilar','Guzmán','1980-10-20',NULL,'F','O-',_binary '','2022-05-20 18:11:47',NULL),(104,'Med.','Brenda','Díaz','Méndez','1993-05-24',NULL,'F','O+',_binary '','2020-02-10 15:56:45',NULL),(105,NULL,'Alondra','Chávez','Domínguez','1987-02-12',NULL,'F','O+',_binary '','2022-11-17 16:42:44',NULL),(106,NULL,'Esmeralda','Sánchez','Castro','1965-10-23',NULL,'F','AB+',_binary '','2021-02-18 16:40:19',NULL),(107,NULL,'Jazmin','Torres','Rodríguez','1994-08-18',NULL,'F','A-',_binary '','2023-07-07 14:00:40',NULL),(108,NULL,'Alondra','Ruíz','De la Cruz','1997-06-25',NULL,'F','AB+',_binary '','2021-04-22 19:13:51',NULL),(109,NULL,'Edgar','Guzmán',' Rivera','1996-11-18',NULL,'M','A+',_binary '','2023-10-31 12:08:35',NULL),(110,NULL,'Gerardo','Ramírez','Soto','1981-04-27',NULL,'M','B+',_binary '','2024-01-08 18:53:48',NULL),(111,NULL,'Dulce','Salazar','Herrera','2000-12-28',NULL,'F','B+',_binary '','2023-04-06 08:07:27',NULL),(112,'C.','Fernando','Hernández','Mendoza','1961-10-19',NULL,'M','A+',_binary '','2023-08-23 10:52:09',NULL),(113,'Mtro.','Jesus','Jiménez','Ramírez','2004-04-02',NULL,'M','A+',_binary '','2023-01-13 11:05:25',NULL),(114,'Sgto.','Fernando',' Rivera','Torres','2003-07-04',NULL,'M','B-',_binary '','2023-04-23 12:23:04',NULL),(115,NULL,'Mario','Juárez','Velázquez','1959-10-23',NULL,'M','O+',_binary '','2023-05-09 15:22:26',NULL),(116,NULL,'Jazmin','Bautista','Ramírez','1959-08-20',NULL,'F','AB+',_binary '','2022-10-06 15:25:41',NULL),(117,NULL,'Bertha','Cruz','Herrera','1995-10-25',NULL,'F','AB-',_binary '','2022-02-08 10:35:02',NULL),(118,NULL,'Pedro',' González','Pérez','1974-07-03',NULL,'M','A-',_binary '','2020-08-19 09:04:21',NULL),(119,NULL,'Diana','Juárez',' Rivera','1967-09-07',NULL,'F','A+',_binary '','2023-07-04 18:35:21',NULL),(120,'Pfra','Luz','Juárez','Vargas','2000-11-27',NULL,'F','A+',_binary '','2022-11-24 10:53:18',NULL),(121,NULL,'Paola','Velázquez','Vargas','1975-09-22',NULL,'F','AB+',_binary '','2022-02-27 08:05:02',NULL),(122,'Dra.','Paola','Medina','Reyes','1978-08-31',NULL,'F','A+',_binary '','2021-08-18 14:41:35',NULL),(123,NULL,'Valeria','Ramírez','García','1989-11-20',NULL,'F','A+',_binary '','2021-04-13 12:40:55',NULL),(124,NULL,'Carmen','Juárez','Martínez','1980-04-27',NULL,'F','O-',_binary '','2022-08-16 09:22:17',NULL),(125,NULL,'Sofia','Díaz','Pérez','1984-05-25',NULL,'F','A-',_binary '','2022-07-09 11:06:16',NULL),(126,NULL,'Aldair','Díaz','Guerrero','1984-08-23',NULL,'M','O+',_binary '','2022-12-28 19:10:45',NULL),(127,NULL,'Fernando','Cruz','Cruz','1976-05-03',NULL,'M','A-',_binary '','2024-01-25 09:41:25',NULL),(128,NULL,'Federico','López','Castro','1977-01-22',NULL,'M','AB-',_binary '','2021-06-14 15:37:18',NULL),(129,NULL,'Hugo','Sánchez','Medina','1959-09-13',NULL,'M','O-',_binary '','2023-04-17 19:29:55',NULL),(130,NULL,'Pedro','Mendoza','Velázquez','1987-06-06',NULL,'M','AB+',_binary '','2020-10-11 09:59:12',NULL),(131,NULL,'Diana','Jiménez','Pérez','1990-01-22',NULL,'F','O+',_binary '','2020-08-11 11:34:19',NULL),(132,NULL,'Gustavo','López','Domínguez','1959-05-12',NULL,'M','A+',_binary '','2021-07-15 14:52:36',NULL),(133,NULL,'Monica','Aguilar','Cortes','1994-04-23',NULL,'F','O-',_binary '','2022-11-20 13:38:16',NULL),(134,NULL,'Hugo','Castillo','Mendoza','1987-06-08',NULL,'M','AB-',_binary '','2022-06-09 18:21:38',NULL),(135,NULL,'Fernando','Ruíz','Gómes','2006-09-04',NULL,'M','A-',_binary '','2023-11-20 08:29:46',NULL),(136,NULL,'Ana','Herrera','Méndez','1996-04-22',NULL,'F','A+',_binary '','2021-06-28 12:24:43',NULL),(137,NULL,'Marco','Herrera','Reyes','1980-02-03',NULL,'M','B+',_binary '','2020-05-08 15:09:47',NULL),(138,'Sr.','Iram','Torres','Gutiérrez','1999-11-04',NULL,'M','A+',_binary '','2023-02-13 14:05:09',NULL),(139,NULL,'Luz','Herrera','Martínez','1970-11-21',NULL,'F','A+',_binary '','2021-10-05 19:43:51',NULL),(140,NULL,'Estrella','Juárez','Cruz','1967-02-05',NULL,'F','A-',_binary '','2022-05-01 09:13:18',NULL),(141,NULL,'Valeria','Santiago',' Rivera','1974-05-16',NULL,'F','O+',_binary '','2023-11-26 10:55:02',NULL),(142,NULL,'Gustavo','Martínez','Moreno','1967-07-13',NULL,'M','B-',_binary '','2023-02-09 11:22:13',NULL),(143,'C.P.','Yair','Ramos','Ramos','1970-03-08',NULL,'M','A-',_binary '','2022-06-30 09:52:08',NULL),(144,NULL,'Juan','Gómes','Estrada','1960-04-14',NULL,'M','B+',_binary '','2021-07-09 19:03:54',NULL),(145,NULL,'Bertha','Ortega',' González','2000-02-16',NULL,'F','O-',_binary '','2020-03-30 14:36:32',NULL),(146,NULL,'Suri','Díaz','Cruz','2005-10-10',NULL,'F','A-',_binary '','2024-01-19 10:54:38',NULL),(147,NULL,'Gustavo','Cruz','Rodríguez','1963-04-01',NULL,'M','A+',_binary '','2023-07-12 08:49:46',NULL),(148,NULL,'Aldair','De la Cruz','López','2005-06-02',NULL,'M','AB+',_binary '','2023-04-08 11:01:26',NULL),(149,NULL,'Luz','Salazar','Bautista','1969-06-02',NULL,'F','A-',_binary '','2021-08-14 11:26:19',NULL),(150,'Ing.','Jesus','Ramírez','Moreno','2003-02-01',NULL,'M','A+',_binary '','2022-01-03 10:58:57',NULL),(151,NULL,'Dulce','Salazar','Medina','2008-03-10',NULL,'F','O-',_binary '','2022-05-11 08:14:06',NULL),(152,'C.','Karla','Gómes','Gómes','1980-08-20',NULL,'F','AB+',_binary '','2020-12-17 15:12:20',NULL),(153,NULL,'Maximiliano','Romero','Salazar','1989-01-20',NULL,'M','AB+',_binary '','2023-10-13 17:23:14',NULL),(154,NULL,'Estrella',' González','Méndez','1981-02-10',NULL,'F','AB+',_binary '','2022-11-20 14:40:52',NULL),(155,NULL,'Flor','Torres','Jiménez','1984-06-09',NULL,'F','AB-',_binary '','2023-03-13 16:59:33',NULL),(156,'Med.','Dulce','Mendoza','Chávez','1991-01-16',NULL,'F','AB+',_binary '','2022-12-05 17:59:47',NULL),(157,NULL,'Carmen','Martínez','Reyes','1972-07-02',NULL,'F','B-',_binary '','2022-11-01 17:48:34',NULL),(158,NULL,'Flor','Cortés',' Rivera','1960-04-02',NULL,'F','B+',_binary '','2022-06-06 18:15:02',NULL),(159,'Srita','Paola','Bautista','Medina','1987-03-20',NULL,'F','O+',_binary '','2021-02-15 19:08:28',NULL),(160,'Med.','Guadalupe','Ortiz','Álvarez','1976-03-08',NULL,'F','A+',_binary '','2022-05-27 13:17:05',NULL),(161,NULL,'Pedro','Guerrero','Vázquez','1986-11-09',NULL,'M','A+',_binary '','2022-01-05 11:00:53',NULL),(162,NULL,'Brenda','Díaz','Moreno','1974-10-17',NULL,'F','A-',_binary '','2023-12-09 08:46:17',NULL),(163,NULL,'Flor','Moreno','Martínez','1999-11-16',NULL,'F','A+',_binary '','2022-04-27 16:13:02',NULL),(164,'Lic.','Esmeralda','Velázquez','Guerrero','1973-09-12',NULL,'F','AB-',_binary '','2023-01-06 12:18:02',NULL),(165,'Tnte.','Yair','Jiménez',' González','1984-01-07',NULL,'M','B+',_binary '','2023-06-23 11:00:59',NULL),(166,NULL,'Suri','Santiago','Salazar','1985-05-27',NULL,'F','A-',_binary '','2020-08-18 11:26:27',NULL),(167,'Srita','Paula','Bautista','Rodríguez','1997-07-14',NULL,'F','AB+',_binary '','2020-10-27 13:15:36',NULL),(168,'Ing.','Ameli','Méndez','Pérez','2005-03-03',NULL,'F','B+',_binary '','2023-07-24 09:56:18',NULL),(169,'C.','Ameli','Contreras','Torres','1969-05-06',NULL,'F','A+',_binary '','2022-09-04 19:40:44',NULL),(170,NULL,'Adalid','Luna','Martínez','1992-10-14',NULL,'M','B+',_binary '','2021-08-14 08:20:13',NULL),(171,NULL,'Gerardo','Gutiérrez','Estrada','1987-12-12',NULL,'M','A+',_binary '','2023-07-09 17:00:53',NULL),(172,'Lic.','Gustavo','Soto','Pérez','1989-05-02',NULL,'M','AB-',_binary '','2023-05-07 16:41:24',NULL),(173,NULL,'Lucía','Moreno','Estrada','1972-08-13',NULL,'F','AB+',_binary '','2023-10-20 17:40:00',NULL),(174,NULL,'Luz','Guerrero','Vázquez','1987-07-21',NULL,'F','A+',_binary '','2023-04-03 13:56:36',NULL),(175,'Sr.','Adan','Reyes','De la Cruz','1964-06-18',NULL,'M','A-',_binary '','2021-11-25 17:06:14',NULL),(176,'Lic.','Diana','Ruíz','Álvarez','1981-10-15',NULL,'F','AB-',_binary '','2021-03-30 10:59:12',NULL),(177,NULL,'Paola','Cortes','Soto','1971-06-11',NULL,'F','B+',_binary '','2023-03-04 17:37:09',NULL),(178,NULL,'Flor','Rodríguez','Torres','1973-07-20',NULL,'F','B-',_binary '','2021-07-29 13:53:06',NULL),(179,NULL,'Paula','Guzmán',' González','1969-09-25',NULL,'F','O+',_binary '','2021-03-08 08:21:43',NULL),(180,NULL,'Juan','Cortés','Castro','1989-12-17',NULL,'M','A+',_binary '','2020-09-11 17:26:28',NULL),(181,NULL,'Carlos','Álvarez','Vázquez','1995-10-20',NULL,'M','O-',_binary '','2021-06-12 19:16:40',NULL),(182,NULL,'Dulce','Castro','Ramírez','1993-11-05',NULL,'F','A+',_binary '','2024-02-20 17:13:20',NULL),(183,'Srita','Flor','Aguilar','Velázquez','1988-04-07',NULL,'F','AB-',_binary '','2021-07-26 19:16:58',NULL),(184,NULL,'Lucía','Moreno','Estrada','1971-11-08',NULL,'F','B-',_binary '','2022-08-16 15:30:54',NULL),(185,NULL,'Jorge','Castro','Gutiérrez','1992-05-23',NULL,'M','B+',_binary '','2021-11-18 11:45:32',NULL),(186,NULL,'Brenda','Díaz',' Rivera','2003-12-25',NULL,'F','O+',_binary '','2020-06-15 10:42:46',NULL),(187,NULL,'Karla','Díaz','Salazar','1965-06-14',NULL,'F','A-',_binary '','2021-04-19 09:15:51',NULL),(188,NULL,'Alejandro','García','Guzmán','1992-11-28',NULL,'M','A-',_binary '','2023-07-11 14:53:49',NULL),(189,NULL,'Hortencia','Cortés','Cruz','1960-10-18',NULL,'F','AB+',_binary '','2024-01-10 18:24:26',NULL),(190,NULL,'Brenda','Estrada','Moreno','1987-05-27',NULL,'F','B-',_binary '','2021-12-15 19:39:17',NULL),(191,NULL,'Maximiliano',' Rivera','Cortes','1973-05-01',NULL,'M','O+',_binary '','2020-05-01 08:18:43',NULL),(192,NULL,'Suri','Ruíz','Ruíz','1994-11-03',NULL,'F','B-',_binary '','2020-12-23 16:20:40',NULL),(193,NULL,'Diana','Domínguez','Guerrero','1988-03-12',NULL,'F','A-',_binary '','2021-06-30 08:50:54',NULL),(194,NULL,'Valeria','Soto',' González','1983-10-08',NULL,'F','A-',_binary '','2022-08-04 12:16:30',NULL),(195,NULL,'Diana','Romero','Gómes','1990-10-24',NULL,'F','B-',_binary '','2022-06-11 12:08:56',NULL),(196,NULL,'Brenda','Martínez','Bautista','1990-04-21',NULL,'F','B+',_binary '','2022-09-26 11:09:38',NULL),(197,'Mtra','Flor','Guzmán','Ruíz','1993-11-13',NULL,'F','B+',_binary '','2022-10-15 10:13:27',NULL),(198,'Ing.','Karla','Castro','Juárez','2007-01-21',NULL,'F','A+',_binary '','2020-10-27 18:40:27',NULL),(199,'Mtra','Luz','Ortiz','Cortés','1981-11-03',NULL,'F','B-',_binary '','2022-12-04 10:00:45',NULL),(200,NULL,'Federico','Pérez','Cortés','1986-04-06',NULL,'M','O+',_binary '','2022-02-09 19:39:13',NULL);
/*!40000 ALTER TABLE `personas` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `personas_AFTER_INSERT` AFTER INSERT ON `personas` FOR EACH ROW BEGIN
	INSERT INTO bitacora VALUES(
		DEFAULT,
        USER(),
        "Create",
        "personas",
        CONCAT_WS(" ","Se ha insertado una nueva persona con el ID: ",NEW.ID, 
        "con los siguientes datos:  TITULO CORTESIA = ", NEW.titulo_cortesia,
        "NOMBRE=", NEW.nombre,
        "PRIMER APELLIDO = ", NEW.primer_apellido,
        "SEGUNDO APELLIDO = ", NEW.segundo_apellido,
        "FECHA NACIMIENTO = ",  NEW.fecha_nacimiento,
        "FOTOGRAFIA = ", NEW.fotografia, 
        "GENERO = ", NEW.genero, 
        "TIPO SANGRE = ", NEW.tipo_sangre,
        "ESTATUS = ", NEW.estatus,
        "FECHA REGISTRO = ",  NEW.fecha_registro,
        "FECHA ACTUALIZACIÓN = ",  NEW.fecha_actualizacion),
        NOW(),
        DEFAULT
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `personas_AFTER_UPDATE` AFTER UPDATE ON `personas` FOR EACH ROW BEGIN
 INSERT INTO bitacora VALUES(
		DEFAULT,
        USER(),
        "Update",
        "personas",
        CONCAT_WS(" ","Se han actualizado los datos de la persona con el ID: ",NEW.ID, 
        "con los siguientes datos: TITULO CORTESIA = ", old.titulo_cortesia, " cambio a " ,NEW.titulo_cortesia,
        "NOMBRE=", OLD.nombre, " cambio a " ,NEW.nombre,
        "PRIMER APELLIDO = ", OLD.primer_apellido, " cambio a " , NEW.primer_apellido,
        "SEGUNDO APELLIDO = ", OLD.segundo_apellido, " cambio a " , NEW.segundo_apellido, 
        "FECHA NACIMIENTO = ",  OLD.fecha_nacimiento, " cambio a " ,NEW.fecha_nacimiento, 
        "FOTOGRAFIA = ",  OLD.fotografia, " cambio a " ,NEW.fotografia, 
        "GENERO = ", OLD.genero, " cambio a " , NEW.genero,
        "TIPO SANGRE = ", OLD.tipo_sangre, " cambio a " , NEW.tipo_sangre,
        "ESTATUS = ", OLD.estatus, " cambio a " ,  NEW.estatus,
        "FECHA REGISTRO = ", OLD.fecha_registro, " cambio a " ,   NEW.fecha_registro,
        "FECHA ACTUALIZACIÓN = ",  OLD.fecha_actualizacion, " cambio a " ,  NEW.fecha_actualizacion),
        NOW(),
        DEFAULT
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `personas_AFTER_DELETE` AFTER DELETE ON `personas` FOR EACH ROW BEGIN
	INSERT INTO bitacora VALUES(
		DEFAULT,
        USER(),
        "Delete",
        "personas",
        CONCAT_WS(" ","Se ha eliminado una persona con el ID: ", OLD.ID),
        now(),
        DEFAULT
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `productos`
--

DROP TABLE IF EXISTS `productos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `productos` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(200) NOT NULL,
  `Marca` varchar(300) DEFAULT NULL,
  `Precio_Actual` decimal(6,2) DEFAULT NULL,
  `Fotografia` varchar(100) DEFAULT NULL,
  `Estatus` bit(1) DEFAULT b'1',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=218 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productos`
--

LOCK TABLES `productos` WRITE;
/*!40000 ALTER TABLE `productos` DISABLE KEYS */;
INSERT INTO `productos` VALUES (1,'Barritas energéticas','MuscleFlow',10.00,NULL,_binary ''),(2,'Barritas energéticas','FlexiLoop',10.00,NULL,_binary ''),(3,'Bloque de espuma para estiramientos','SpeedGrip',60.00,NULL,_binary ''),(4,'Suplemento de creatina','PowerProtein',70.00,NULL,_binary ''),(5,'Bebida energética pre-entrenamiento','FlexiBlock',90.00,NULL,_binary ''),(6,'Suplemento de creatina','MuscleRecover',30.00,NULL,_binary ''),(7,'Barritas energéticas','FlexiMat',20.00,NULL,_binary ''),(8,'Banda elástica para ejercicios de resistencia','StaminaBoost',30.00,NULL,_binary ''),(9,'Barritas energéticas','FlexiRoll',20.00,NULL,_binary ''),(10,'Esterilla de yoga','PowerPulse',50.00,NULL,_binary ''),(11,'Barritas energéticas','MuscleFlow',100.00,NULL,_binary ''),(12,'Bebida energética pre-entrenamiento','MuscleEase',60.00,NULL,_binary ''),(13,'Barritas energéticas','PowerBurn',80.00,NULL,_binary ''),(14,'Cinturón de levantamiento de pesas','FlexiBottle',100.00,NULL,_binary ''),(15,'Bebida energética post-entrenamiento','SpeedWrap',70.00,NULL,_binary ''),(16,'Suplemento de creatina','MusclePatch',10.00,NULL,_binary ''),(17,'Bebida energética pre-entrenamiento','SpeedStep',30.00,NULL,_binary ''),(18,'Correa de estiramiento','FlexiSqueeze',40.00,NULL,_binary ''),(19,'Cinturón de levantamiento de pesas','FlexiRing',60.00,NULL,_binary ''),(20,'Magnesio para mejorar el agarre','FlexiWheel',50.00,NULL,_binary ''),(21,'Guantes para levantamiento de pesas','PowerLift',10.00,NULL,_binary ''),(22,'Banda elástica para ejercicios de resistencia','FlexiWheel',20.00,NULL,_binary ''),(23,'Barritas energéticas','FlexiSocks',40.00,NULL,_binary ''),(24,'Barritas energéticas','SpeedGrip',50.00,NULL,_binary ''),(25,'Rodillo de espuma para masaje muscular','FlexiPad',80.00,NULL,_binary ''),(26,'Bebida isotónica','MuscleFlow',40.00,NULL,_binary ''),(27,'Bebida energética post-entrenamiento','FlexiRoll',30.00,NULL,_binary ''),(28,'Termogénico para quemar grasa','FlexiRing',50.00,NULL,_binary ''),(29,'Batidos de proteínas','MuscleFlex',20.00,NULL,_binary ''),(30,'Suplemento de creatina','SpeedWrap',70.00,NULL,_binary ''),(31,'Cinturón de levantamiento de pesas','MuscleFlex',40.00,NULL,_binary ''),(32,'Bebida energética pre-entrenamiento','PowerGrip',50.00,NULL,_binary ''),(33,'Correa de estiramiento','FlexiBand',100.00,NULL,_binary ''),(34,'Termogénico para quemar grasa','PowerBands',40.00,NULL,_binary ''),(35,'Termogénico para quemar grasa','PowerLift',20.00,NULL,_binary ''),(36,'Bebida isotónica','FlexiPod',30.00,NULL,_binary ''),(37,'Suplemento pre-entrenamiento','FlexiSocks',20.00,NULL,_binary ''),(38,'Esterilla de yoga','FlexiBall',70.00,NULL,_binary ''),(39,'Bebida energética pre-entrenamiento','FlexiRing',20.00,NULL,_binary ''),(40,'Correa de estiramiento','FlexiBall',20.00,NULL,_binary ''),(41,'Magnesio para mejorar el agarre','PowerBands',50.00,NULL,_binary ''),(42,'Esterilla de yoga','SpeedStep',50.00,NULL,_binary ''),(43,'Termogénico para quemar grasa','MuscleFlow',90.00,NULL,_binary ''),(44,'Bebida energética pre-entrenamiento','MuscleRecover',20.00,NULL,_binary ''),(45,'Bloque de espuma para estiramientos','PowerStim',20.00,NULL,_binary ''),(46,'Termogénico para quemar grasa','FlexiRoll',70.00,NULL,_binary ''),(47,'Magnesio para mejorar el agarre','PowerPulse',70.00,NULL,_binary ''),(48,'Correa de estiramiento','FlexiBottle',30.00,NULL,_binary ''),(49,'Bebida isotónica','MuscleEase',60.00,NULL,_binary ''),(50,'Suplemento de creatina','FlexiRoll',20.00,NULL,_binary ''),(51,'Correa de estiramiento','StaminaBoost',90.00,NULL,_binary ''),(52,'Vendas para muñecas y tobillos','FlexiGel',60.00,NULL,_binary ''),(53,'Rodillo de espuma para masaje muscular','PowerLift',60.00,NULL,_binary ''),(54,'Magnesio para mejorar el agarre','SpeedWrap',40.00,NULL,_binary ''),(55,'Banda elástica para ejercicios de resistencia','PowerPulse',40.00,NULL,_binary ''),(56,'Banda elástica para ejercicios de resistencia','FlexiWheel',30.00,NULL,_binary ''),(57,'Bebida energética pre-entrenamiento','MuscleFlex',90.00,NULL,_binary ''),(58,'Batidos de proteínas','MuscleMax',30.00,NULL,_binary ''),(59,'Vendas para muñecas y tobillos','SpeedSpike',10.00,NULL,_binary ''),(60,'Suplemento de creatina','StaminaBoost',90.00,NULL,_binary ''),(61,'Banda de resistencia para entrenamiento','SpeedGrip',100.00,NULL,_binary ''),(62,'Vendas para muñecas y tobillos','FlexiLoop',20.00,NULL,_binary ''),(63,'Barritas energéticas','MusclePatch',90.00,NULL,_binary ''),(64,'Termogénico para quemar grasa','SpeedWrap',20.00,NULL,_binary ''),(65,'Bebida energética post-entrenamiento','PowerProtein',70.00,NULL,_binary ''),(66,'Esterilla de yoga','PowerStim',90.00,NULL,_binary ''),(67,'Batidos de proteínas','PowerGrip',80.00,NULL,_binary ''),(68,'Magnesio para mejorar el agarre','MuscleFlow',100.00,NULL,_binary ''),(69,'Magnesio para mejorar el agarre','PowerBar',60.00,NULL,_binary ''),(70,'Cinturón de levantamiento de pesas','SpeedSpike',10.00,NULL,_binary ''),(71,'Banda de resistencia para estiramientos','PowerSprint',60.00,NULL,_binary ''),(72,'Rodillo de espuma para masaje muscular','PowerBurn',70.00,NULL,_binary ''),(73,'Magnesio para mejorar el agarre','FlexiStick',90.00,NULL,_binary ''),(74,'Magnesio para mejorar el agarre','FlexiBall',100.00,NULL,_binary ''),(75,'Bebida isotónica','FlexiBlock',80.00,NULL,_binary ''),(76,'Correa de estiramiento','PowerSprint',100.00,NULL,_binary ''),(77,'Banda de resistencia para estiramientos','CardioCharge',40.00,NULL,_binary ''),(78,'Banda elástica para ejercicios de resistencia','SpeedJump',10.00,NULL,_binary ''),(79,'Correa de estiramiento','SpeedWrap',60.00,NULL,_binary ''),(80,'Batidos de proteínas','PowerBlitz',70.00,NULL,_binary ''),(81,'Guantes para levantamiento de pesas','FlexiFoam',90.00,NULL,_binary ''),(82,'Bebida energética post-entrenamiento','FlexiPod',30.00,NULL,_binary ''),(83,'Batidos de proteínas','FlexiSqueeze',90.00,NULL,_binary ''),(84,'Correa de estiramiento','FlexiRoll',20.00,NULL,_binary ''),(85,'Banda de resistencia para entrenamiento','PowerSprint',20.00,NULL,_binary ''),(86,'Banda de resistencia para entrenamiento','SpeedGrip',100.00,NULL,_binary ''),(87,'Rodillo de espuma para masaje muscular','FlexiBottle',20.00,NULL,_binary ''),(88,'Bebida energética pre-entrenamiento','FlexiGel',90.00,NULL,_binary ''),(89,'Magnesio para mejorar el agarre','PowerGrip',100.00,NULL,_binary ''),(90,'Barritas energéticas','SpeedWrap',60.00,NULL,_binary ''),(91,'Cinturón de levantamiento de pesas','SpeedSpike',10.00,NULL,_binary ''),(92,'Batidos de proteínas','FlexiStretch',60.00,NULL,_binary ''),(93,'Correa de estiramiento','FlexiBottle',30.00,NULL,_binary ''),(94,'Bebida isotónica','SpeedWrap',80.00,NULL,_binary ''),(95,'Bebida energética post-entrenamiento','PowerFuel',10.00,NULL,_binary ''),(96,'Banda de resistencia para estiramientos','MuscleRelief',30.00,NULL,_binary ''),(97,'Vendas para muñecas y tobillos','PowerBands',60.00,NULL,_binary ''),(98,'Bebida energética post-entrenamiento','MuscleFlow',30.00,NULL,_binary ''),(99,'Guantes para levantamiento de pesas','PowerBands',30.00,NULL,_binary ''),(100,'Correa de estiramiento','FlexiWheel',90.00,NULL,_binary ''),(101,'Suplemento de creatina','PowerHydrate',40.00,NULL,_binary ''),(102,'Bebida energética post-entrenamiento','PowerFuel',20.00,NULL,_binary ''),(103,'Guantes para levantamiento de pesas','FlexiSqueeze',70.00,NULL,_binary ''),(104,'Banda de resistencia para entrenamiento','PowerLift',10.00,NULL,_binary ''),(105,'Banda elástica para ejercicios de resistencia','FlexiBottle',80.00,NULL,_binary ''),(106,'Bebida energética post-entrenamiento','MuscleRelief',80.00,NULL,_binary ''),(107,'Batidos de proteínas','PowerLift',20.00,NULL,_binary ''),(108,'Bloque de espuma para estiramientos','PowerFuel',100.00,NULL,_binary ''),(109,'Bebida energética post-entrenamiento','PowerBar',100.00,NULL,_binary ''),(110,'Batidos de proteínas','PowerFuel',40.00,NULL,_binary ''),(111,'Suplemento pre-entrenamiento','PowerProtein',30.00,NULL,_binary ''),(112,'Banda de resistencia para estiramientos','FlexiStrap',20.00,NULL,_binary ''),(113,'Suplemento pre-entrenamiento','SpeedStep',90.00,NULL,_binary ''),(114,'Bloque de espuma para estiramientos','PowerBands',80.00,NULL,_binary ''),(115,'Batidos de proteínas','FlexiMat',80.00,NULL,_binary ''),(116,'Bebida energética post-entrenamiento','PowerSprint',10.00,NULL,_binary ''),(117,'Correa de estiramiento','FlexiPad',100.00,NULL,_binary ''),(118,'Correa de estiramiento','FlexiGrip',50.00,NULL,_binary ''),(119,'Colchoneta para ejercicios','FlexiGel',100.00,NULL,_binary ''),(120,'Magnesio para mejorar el agarre','MusclePatch',80.00,NULL,_binary ''),(121,'Bebida energética post-entrenamiento','PowerHydrate',50.00,NULL,_binary ''),(122,'Bebida energética pre-entrenamiento','FlexiRing',10.00,NULL,_binary ''),(123,'Suplemento pre-entrenamiento','FlexiSqueeze',10.00,NULL,_binary ''),(124,'Vendas para muñecas y tobillos','PowerBar',70.00,NULL,_binary ''),(125,'Rodillo de espuma para masaje muscular','CardioCharge',50.00,NULL,_binary ''),(126,'Bebida isotónica','FlexiBottle',40.00,NULL,_binary ''),(127,'Bloque de espuma para estiramientos','FlexiBand',80.00,NULL,_binary ''),(128,'Cinturón de levantamiento de pesas','MuscleEase',10.00,NULL,_binary ''),(129,'Bebida energética post-entrenamiento','PowerBeam',60.00,NULL,_binary ''),(130,'Correa de estiramiento','PowerBeam',40.00,NULL,_binary ''),(131,'Bebida energética post-entrenamiento','SpeedMate',100.00,NULL,_binary ''),(132,'Barritas energéticas','FlexiStretch',100.00,NULL,_binary ''),(133,'Correa de estiramiento','SpeedJump',60.00,NULL,_binary ''),(134,'Barritas energéticas','PowerSprint',100.00,NULL,_binary ''),(135,'Esterilla de yoga','PowerStim',70.00,NULL,_binary ''),(136,'Suplemento de creatina','FlexiBottle',30.00,NULL,_binary ''),(137,'Vendas para muñecas y tobillos','FlexiFoam',30.00,NULL,_binary ''),(138,'Suplemento de creatina','FlexiRing',100.00,NULL,_binary ''),(139,'Rodillo de espuma para masaje muscular','PowerBeam',30.00,NULL,_binary ''),(140,'Guantes para levantamiento de pesas','MusclePatch',30.00,NULL,_binary ''),(141,'Barritas energéticas','PowerGrip',10.00,NULL,_binary ''),(142,'Rodillo de espuma para masaje muscular','PowerLift',60.00,NULL,_binary ''),(143,'Banda de resistencia para entrenamiento','SpeedStep',50.00,NULL,_binary ''),(144,'Barritas energéticas','FlexiRing',80.00,NULL,_binary ''),(145,'Esterilla de yoga','MuscleFlow',60.00,NULL,_binary ''),(146,'Magnesio para mejorar el agarre','PowerStim',100.00,NULL,_binary ''),(147,'Banda elástica para ejercicios de resistencia','StaminaBoost',40.00,NULL,_binary ''),(148,'Banda de resistencia para estiramientos','PowerBeam',100.00,NULL,_binary ''),(149,'Bebida energética post-entrenamiento','PowerBeam',50.00,NULL,_binary ''),(150,'Colchoneta para ejercicios','PowerCord',80.00,NULL,_binary ''),(151,'Bebida energética post-entrenamiento','MuscleEase',50.00,NULL,_binary ''),(152,'Banda de resistencia para estiramientos','FlexiGrip',30.00,NULL,_binary ''),(153,'Guantes para levantamiento de pesas','FlexiPad',40.00,NULL,_binary ''),(154,'Vendas para muñecas y tobillos','FlexiFoam',30.00,NULL,_binary ''),(155,'Suplemento de creatina','FlexiBall',30.00,NULL,_binary ''),(156,'Colchoneta para ejercicios','PowerLift',10.00,NULL,_binary ''),(157,'Suplemento pre-entrenamiento','MuscleRecover',100.00,NULL,_binary ''),(158,'Suplemento de creatina','PowerGrip',20.00,NULL,_binary ''),(159,'Barritas energéticas','PowerFuel',100.00,NULL,_binary ''),(160,'Bebida energética post-entrenamiento','PowerStim',40.00,NULL,_binary ''),(161,'Termogénico para quemar grasa','StaminaBoost',50.00,NULL,_binary ''),(162,'Banda de resistencia para estiramientos','PowerLift',40.00,NULL,_binary ''),(163,'Colchoneta para ejercicios','MuscleRecover',30.00,NULL,_binary ''),(164,'Banda elástica para ejercicios de resistencia','PowerSprint',40.00,NULL,_binary ''),(165,'Colchoneta para ejercicios','FlexiStretch',40.00,NULL,_binary ''),(166,'Rodillo de espuma para masaje muscular','PowerLift',60.00,NULL,_binary ''),(167,'Banda de resistencia para entrenamiento','PowerStim',70.00,NULL,_binary ''),(168,'Esterilla de yoga','MuscleRelief',10.00,NULL,_binary ''),(169,'Bebida energética pre-entrenamiento','FlexiMat',60.00,NULL,_binary ''),(170,'Cinturón de levantamiento de pesas','FlexiBottle',100.00,NULL,_binary ''),(171,'Barritas energéticas','PowerBands',70.00,NULL,_binary ''),(172,'Termogénico para quemar grasa','PowerSprint',60.00,NULL,_binary ''),(173,'Magnesio para mejorar el agarre','MuscleEase',10.00,NULL,_binary ''),(174,'Bebida energética pre-entrenamiento','PowerBands',10.00,NULL,_binary ''),(175,'Bloque de espuma para estiramientos','MuscleMax',80.00,NULL,_binary ''),(176,'Banda de resistencia para entrenamiento','MuscleEase',70.00,NULL,_binary ''),(177,'Guantes para levantamiento de pesas','CardioCharge',100.00,NULL,_binary ''),(178,'Batidos de proteínas','PowerStim',80.00,NULL,_binary ''),(179,'Magnesio para mejorar el agarre','CardioCharge',30.00,NULL,_binary ''),(180,'Colchoneta para ejercicios','FlexiStretch',40.00,NULL,_binary ''),(181,'Bebida energética pre-entrenamiento','FlexiBand',10.00,NULL,_binary ''),(182,'Bebida energética post-entrenamiento','FlexiBlock',80.00,NULL,_binary ''),(183,'Esterilla de yoga','CardioCharge',10.00,NULL,_binary ''),(184,'Banda elástica para ejercicios de resistencia','SpeedWrap',10.00,NULL,_binary ''),(185,'Banda de resistencia para estiramientos','PowerBurn',30.00,NULL,_binary ''),(186,'Bebida isotónica','PowerSprint',10.00,NULL,_binary ''),(187,'Guantes para levantamiento de pesas','PowerLift',10.00,NULL,_binary ''),(188,'Cinturón de levantamiento de pesas','FlexiGrip',30.00,NULL,_binary ''),(189,'Colchoneta para ejercicios','SpeedSpike',60.00,NULL,_binary ''),(190,'Magnesio para mejorar el agarre','FlexiRing',70.00,NULL,_binary ''),(191,'Bebida isotónica','FlexiGel',100.00,NULL,_binary ''),(192,'Termogénico para quemar grasa','PowerBlitz',70.00,NULL,_binary ''),(193,'Bebida energética pre-entrenamiento','FlexiBottle',50.00,NULL,_binary ''),(194,'Correa de estiramiento','FlexiPad',100.00,NULL,_binary ''),(195,'Esterilla de yoga','MuscleMax',30.00,NULL,_binary ''),(196,'Guantes para levantamiento de pesas','MusclePatch',40.00,NULL,_binary ''),(197,'Cinturón de levantamiento de pesas','MuscleRelief',30.00,NULL,_binary ''),(198,'Suplemento de creatina','SpeedStep',10.00,NULL,_binary ''),(199,'Banda elástica para ejercicios de resistencia','PowerSprint',50.00,NULL,_binary ''),(200,'Banda de resistencia para estiramientos','FlexiStrap',100.00,NULL,_binary ''),(201,'Banda de resistencia para entrenamiento','PowerLift',100.00,NULL,_binary ''),(202,'Batidos de proteínas','FlexiGel',30.00,NULL,_binary ''),(203,'Vendas para muñecas y tobillos','FlexiRing',70.00,NULL,_binary ''),(204,'Rodillo de espuma para masaje muscular','PowerFuel',90.00,NULL,_binary ''),(205,'Vendas para muñecas y tobillos','FlexiGel',70.00,NULL,_binary ''),(206,'Colchoneta para ejercicios','MuscleEase',60.00,NULL,_binary ''),(207,'Correa de estiramiento','FlexiGrip',70.00,NULL,_binary ''),(208,'Esterilla de yoga','FlexiBall',70.00,NULL,_binary ''),(209,'Suplemento de creatina','FlexiRoll',20.00,NULL,_binary ''),(210,'Banda de resistencia para estiramientos','FlexiFoam',20.00,NULL,_binary ''),(211,'Correa de estiramiento','PowerBar',80.00,NULL,_binary ''),(212,'Guantes para levantamiento de pesas','FlexiPod',50.00,NULL,_binary ''),(213,'Vendas para muñecas y tobillos','FlexiBand',70.00,NULL,_binary ''),(214,'Guantes para levantamiento de pesas','MuscleRelief',90.00,NULL,_binary ''),(215,'Bebida energética pre-entrenamiento','PowerCharge',60.00,NULL,_binary ''),(216,'Guantes para levantamiento de pesas','PowerFuel',30.00,NULL,_binary ''),(217,'Barritas energéticas','FlexiStretch',100.00,NULL,_binary '');
/*!40000 ALTER TABLE `productos` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `productos_AFTER_INSERT` AFTER INSERT ON `productos` FOR EACH ROW BEGIN
	-- Declaración de variables
    DECLARE v_cadena_estatus varchar(15) default null;

    -- Iniciación de las variables
    IF new.estatus = b'1' then
        set v_cadena_estatus = "Activa";
    else
        set v_cadena_estatus = "Inactiva";
    end if;

    -- Insertar en la bitacora
    INSERT INTO bitacora VALUES(
        DEFAULT,
        USER(),
        "Create",
        "productos",
        CONCAT_WS(" ","Se ha insertado una nueva AREA con el ID: ",NEW.ID, 
        "con los siguientes datos: ",
        "NOMBRE = ", NEW.nombre,
        "MARCA = ", NEW.marca,
        "PRECIO ACTUAL = ", NEW.precio_actual,
        "FOTOGRAFÍA = ",  NEW.fotografia,
        "ESTATUS = ", v_cadena_estatus),
        NOW(),
        DEFAULT
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `productos_AFTER_UPDATE` AFTER UPDATE ON `productos` FOR EACH ROW BEGIN
	-- Declaración de variables
    DECLARE v_cadena_estatus VARCHAR(15) DEFAULT NULL;
    DECLARE v_cadena_estatus2 VARCHAR(15) DEFAULT NULL;

    -- Inicialización de las variables 
    IF NEW.estatus = b'1' THEN
		SET v_cadena_estatus= "Activa";
    ELSE
		SET v_cadena_estatus= "Inactiva";
    END IF; 
    
    IF OLD.estatus = b'1' THEN
		SET v_cadena_estatus2= "Activa";
    ELSE
		SET v_cadena_estatus2= "Inactiva";
    END IF; 
          
    INSERT INTO bitacora VALUES(
        DEFAULT,
        USER(),
        "Update",
        "productos",
        CONCAT_WS(" ","Se han actualizado los datos del PRODUCTO con el ID: ",NEW.ID,
        "con los siguientes datos:",
        "NOMBRE = ", OLD.nombre, " cambio a " ,NEW.nombre,
        "MARCA = ", OLD.marca, " cambio a " , NEW.marca, 
        "PRECIO ACTUAL = ",  OLD.precio_actual, " cambio a " ,NEW.precio_actual, 
        "FOTOGRAFÍA = ", OLD.fotografia, " cambio a " , NEW.fotografia,
        "ESTATUS = ", v_cadena_estatus2, "cambio a", v_cadena_estatus),
        NOW(),
        DEFAULT       
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `productos_AFTER_DELETE` AFTER DELETE ON `productos` FOR EACH ROW BEGIN
	INSERT INTO bitacora VALUES(
		DEFAULT,
        USER(),
        "Delete",
        "productos",
        CONCAT_WS(" ","Se ha eliminado un PRODUCTO con el ID: ", OLD.ID),
        now(),
        DEFAULT
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `programas_saludables`
--

DROP TABLE IF EXISTS `programas_saludables`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `programas_saludables` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(250) NOT NULL,
  `Usuario_ID` int unsigned NOT NULL,
  `Instructor_ID` int unsigned NOT NULL,
  `Fecha_Creacion` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Estatus` enum('Registrado','Sugerido','Aprobado por el Médico','Aprobado por el Usuario','Rechazado por el Médico','Rechazado por el Usuario','Terminado','Suspendido','Cancelado') NOT NULL DEFAULT 'Registrado',
  `Duracion` varchar(80) NOT NULL,
  `Porcentaje_Avance` decimal(5,2) NOT NULL DEFAULT '0.00',
  `Fecha_Ultima_Actualizacion` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_usuario_1` (`Usuario_ID`),
  KEY `fk_instructores_1` (`Instructor_ID`),
  CONSTRAINT `fk_instructores_1` FOREIGN KEY (`Instructor_ID`) REFERENCES `instructores` (`Empleado_ID`),
  CONSTRAINT `fk_usuario_1` FOREIGN KEY (`Usuario_ID`) REFERENCES `usuarios` (`Persona_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `programas_saludables`
--

LOCK TABLES `programas_saludables` WRITE;
/*!40000 ALTER TABLE `programas_saludables` DISABLE KEYS */;
/*!40000 ALTER TABLE `programas_saludables` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `programas_saludables_AFTER_INSERT` AFTER INSERT ON `programas_saludables` FOR EACH ROW BEGIN
	-- Declaración de variables
    DECLARE v_nombre_usuario varchar(60) default null;
    DECLARE v_nombre_instructor varchar(60) default null;

    -- Iniciación de las variables
    if new.usuario_id is not null then
        -- En caso de tener el id del usuario debemos recuperar su nombre
        set v_nombre_usuario = (SELECT CONCAT_WS(" ", p.titulo_cortesia, p.nombre, p.primer_apellido, p.segundo_Apellido) FROM personas p WHERE id = NEW.usuario_id);
    else
        SET v_nombre_usuario = "Sin usuario asignado";
    end if;

    if new.instructor_id is not null then
        -- En caso de tener el id del instructor debemos recuperar su nombre
        set v_nombre_instructor = (SELECT CONCAT_WS(" ", p.titulo_cortesia, p.nombre, p.primer_apellido, p.segundo_Apellido) FROM personas p WHERE id = NEW.instructor_id);
    else
        SET v_nombre_instructor = "Sin instructor asignado";
    end if;

    -- Insertar en la bitacora
    INSERT INTO bitacora VALUES(
        DEFAULT,
        USER(),
        "Create",
        "programas_saludables",
        CONCAT_WS(" ","Se ha insertado una nueva relación de PROGRAMAS SALUDABLES con el ID: ",NEW.ID, 
        "con los siguientes datos: ",
        "NOMBRE = ", NEW.nombre,
        "USUARIO ID = ", v_nombre_usuario,
        "INSTRUCTOR ID = ",  v_nombre_instructor,
        "FECHA DE CREACIÓN = ", NEW.fecha_creacion,
		"ESTATUS = ", NEW.estatus,
        "DURACIÓN = ", NEW.duracion, 
        "PORCENTAJE DE AVANCE = ", NEW.porcentaje_avance,
        "FECHA DE ULTIMA ACTUALIZACIÓN = ", NEW.fecha_ultima_actualizacion),
        NOW(),
        DEFAULT
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `programas_saludables_AFTER_UPDATE` AFTER UPDATE ON `programas_saludables` FOR EACH ROW BEGIN
	 -- Declaración de variables
    DECLARE v_nombre_usuario VARCHAR(100) DEFAULT NULL;
    DECLARE v_nombre_usuario2 VARCHAR(100) DEFAULT NULL;
    DECLARE v_nombre_instructor VARCHAR(60) DEFAULT NULL;
    DECLARE v_nombre_instructor2 VARCHAR(60) DEFAULT NULL;

    -- Inicialización de las variables
    IF NEW.usuario_id IS NOT NULL THEN 
		-- En caso de tener el id del usuario
		SET v_nombre_usuario = (SELECT CONCAT_WS(" ", p.titulo_cortesia, p.nombre, p.primer_apellido,p.segundo_apellido) FROM personas p WHERE id = NEW.usuario_id);
    ELSE
		SET v_nombre_usuario = "Sin usuario asignado.";
    END IF;
    
    IF OLD.usuario_id IS NOT NULL THEN 
		-- En caso de tener el id del usuario
		SET v_nombre_usuario2 = (SELECT CONCAT_WS(" ", p.titulo_cortesia, p.nombre, p.primer_apellido,p.segundo_apellido) FROM personas p WHERE id = OLD.usuario_id);
    ELSE
		SET v_nombre_usuario2 = "Sin usuario asignado.";
    END IF;

    IF NEW.instructor_id IS NOT NULL THEN 
		-- En caso de tener el id del instructor
		SET v_nombre_instructor = (SELECT CONCAT_WS(" ", p.titulo_cortesia, p.nombre, p.primer_apellido,p.segundo_apellido) FROM personas p WHERE id = NEW.instructor_id);
    ELSE
		SET v_nombre_instructor = "Sin instructor asignado.";
    END IF;

    IF OLD.instructor_id IS NOT NULL THEN 
		-- En caso de tener el id del instructor
		SET v_nombre_instructor2 = (SELECT CONCAT_WS(" ", p.titulo_cortesia, p.nombre, p.primer_apellido,p.segundo_apellido) FROM personas p WHERE id = OLD.instructor_id);
    ELSE
		SET v_nombre_instructor2 = "Sin instructor asignado.";
    END IF;
    
    INSERT INTO bitacora VALUES(
        DEFAULT,
        USER(),
        "Update",
        "programas_saludables",
        CONCAT_WS(" ","Se han actualizado los datos de la relación PROGRAMAS SALUDABLES con el ID: ",NEW.ID,
        "con los siguientes datos:",
        "NOMBRE = ", OLD.nombre, "cambio a", NEW.nombre,
        "USUARIO ID = ", v_nombre_usuario2, "cambio a", v_nombre_usuario,
        "INSTRUCTOR ID =",v_nombre_instructor2,"cambio a", v_nombre_instructor,
        "FECHA DE CREACIÓN = ", OLD.fecha_creacion, "cambio a", NEW.fecha_creacion,
        "ESTATUS = ", OLD.estatus, "cambio a", NEW.estatus,
        "DURACIÓN = ", OLD.duracion, "cambio a", NEW.duracion,
        "PORCENTAJE DE AVANCE = ", OLD.porcentaje_avance, "cambio a", NEW.porcentaje_avance,
        "FECHA DE ULTIMA ACTUALIZACIÓN = ", OLD.fecha_ultima_actualizacion, "cambio a", NEW.fecha_ultima_actualizacion),
        NOW(),
        DEFAULT       
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `programas_saludables_AFTER_DELETE` AFTER DELETE ON `programas_saludables` FOR EACH ROW BEGIN
	INSERT INTO bitacora VALUES(
		DEFAULT,
        USER(),
        "Delete",
        "programas_saludables",
        CONCAT_WS(" ","Se ha eliminado una relación en PROGRAMAS SALUDABLES con el ID: ", OLD.ID),
        now(),
        DEFAULT
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `promociones`
--

DROP TABLE IF EXISTS `promociones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `promociones` (
  `Producto_ID` int unsigned NOT NULL,
  `Tipo` enum('membresias','personalizado','complementarios','recompensas') DEFAULT NULL,
  `Aplicacion_en` enum('Membresia','Producto') DEFAULT NULL,
  `Estatus` bit(1) DEFAULT b'1',
  PRIMARY KEY (`Producto_ID`),
  CONSTRAINT `fk_productos_3` FOREIGN KEY (`Producto_ID`) REFERENCES `productos` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `promociones`
--

LOCK TABLES `promociones` WRITE;
/*!40000 ALTER TABLE `promociones` DISABLE KEYS */;
/*!40000 ALTER TABLE `promociones` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `promociones_AFTER_INSERT` AFTER INSERT ON `promociones` FOR EACH ROW BEGIN
-- Declaración de variables
    DECLARE v_cadena_estatus varchar(15) default null;
    DECLARE v_nombre_producto varchar(60) default null;

    -- Iniciación de las variables
    IF new.estatus = b'1' then
        set v_cadena_estatus = "Activa";
    else
        set v_cadena_estatus = "Inactiva";
    end if;

    if new.producto_id is not null then
        -- En caso de tener el id de la sucursal debemos recuperar su nombre
        set v_nombre_producto = (SELECT concat_ws(" ", p.nombre, p.marca) FROM productos p WHERE id = NEW.producto_id);
    else
        SET v_nombre_producto = "Sin producto asignado";
    end if;

    -- Insertar en la bitacora
    INSERT INTO bitacora VALUES(
        DEFAULT,
        USER(),
        "Create",
        "promociones",
        CONCAT_WS(" ","Se ha insertado una nueva PROMOCION con el ID: ",NEW.Producto_ID, 
        "con los siguientes datos: ",
        "TIPO DE PROMOCION = ", Tipo,
        "APLICA EN = ",  Aplicacion_en,
        "ESTATUS = ", v_cadena_estatus),
        NOW(),
        DEFAULT
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `promociones_AFTER_UPDATE` AFTER UPDATE ON `promociones` FOR EACH ROW BEGIN
 -- Declaración de variables
    DECLARE v_cadena_estatus VARCHAR(15) DEFAULT NULL;
    DECLARE v_cadena_estatus2 VARCHAR(15) DEFAULT NULL;
    DECLARE v_nombre_producto VARCHAR(60) DEFAULT NULL;
    DECLARE v_nombre_producto2 VARCHAR(60) DEFAULT NULL;

    -- Inicialización de las variables 
    IF NEW.estatus = b'1' THEN
		SET v_cadena_estatus= "Activa";
    ELSE
		SET v_cadena_estatus= "Inactiva";
    END IF; 
    
    IF OLD.estatus = b'1' THEN
		SET v_cadena_estatus2= "Activa";
    ELSE
		SET v_cadena_estatus2= "Inactiva";
    END IF; 
          
    IF NEW.producto_id IS NOT NULL THEN 
		-- En caso de tener el id del producto
        SET v_nombre_producto = (SELECT concat_ws(" ", p.nombre, p.marca) FROM productos p WHERE id = NEW.producto_id);
    ELSE
		SET v_nombre_producto = "Sin producto asignado.";
    END IF;

    IF OLD.producto_id IS NOT NULL THEN 
		-- En caso de tener el id del producto
        SET v_nombre_producto = (SELECT concat_ws(" ", p.nombre, p.marca) FROM productos p WHERE id = OLD.producto_id);
    ELSE
		SET v_nombre_producto2 = "Sin producto asignado.";
    END IF;
    
    INSERT INTO bitacora VALUES(
        DEFAULT,
        USER(),
        "Update",
        "promociones",
        CONCAT_WS(" ","Se han actualizado los datos de las PROMOCIONES con el ID: ",NEW.Producto_ID, 
        "con los siguientes datos:",
        "PRODUCTO ID =", v_nombre_producto2," cambio a ", v_nombre_producto,
        "TIPO DE PROMOCION = ", OLD.Tipo, "cambio a ", NEW.Tipo,
        "APLICA EN = ", OLD.Aplicacion_en, " cambio a ", NEW.Aplicacion_en,
        "ESTATUS = ", v_cadena_estatus2, " cambio a ", v_cadena_estatus),
        NOW(),
        DEFAULT       
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `promociones_AFTER_DELETE` AFTER DELETE ON `promociones` FOR EACH ROW BEGIN
INSERT INTO bitacora VALUES(
		DEFAULT,
        USER(),
        "Delete",
        "promociones",
        CONCAT_WS(" ","Se ha eliminado una PROMOCION con el ID: ", OLD.Producto_ID),
        now(),
        DEFAULT
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `rutinas`
--

DROP TABLE IF EXISTS `rutinas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rutinas` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `Instructor_ID` int unsigned NOT NULL,
  `Usuario_ID` int unsigned NOT NULL,
  `Fecha_Asignacion` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Fecha_Termino` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Tiempo_Aproximado` time DEFAULT NULL,
  `Estatus` enum('Concluido','Actual','Suspendida') DEFAULT NULL,
  `Resultados_Esperados` text,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rutinas`
--

LOCK TABLES `rutinas` WRITE;
/*!40000 ALTER TABLE `rutinas` DISABLE KEYS */;
/*!40000 ALTER TABLE `rutinas` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `rutinas_AFTER_INSERT` AFTER INSERT ON `rutinas` FOR EACH ROW BEGIN
	-- Declaración de variables
    DECLARE v_nombre_instructor varchar(60) default null;
    DECLARE v_nombre_usuario varchar(60) default null;

    -- Iniciación de las variables
    if new.instructor_id is not null then
        -- En caso de tener el id del empleado responsable debemos recuperar su nombre
        set v_nombre_instructor = (SELECT CONCAT_WS(" ", p.titulo_cortesia, p.nombre, p.primer_apellido, p.segundo_Apellido) FROM personas p WHERE id = NEW.instructor_id);
    else
        SET v_nombre_instructor = "Sin responsable asignado";
    end if;

    if new.usuario_id is not null then
        -- En caso de tener el id del usuario
        set v_nombre_usuario = (SELECT CONCAT_WS(" ", p.titulo_cortesia, p.nombre, p.primer_apellido, p.segundo_Apellido) FROM personas p WHERE id = NEW.usuario_id);
    else
        SET v_nombre_usuario = "Sin usuario asignado";
    end if;

    -- Insertar en la bitacora
    INSERT INTO bitacora VALUES(
        DEFAULT,
        USER(),
        "Create",
        "rutinas",
        CONCAT_WS(" ","Se ha insertado una nueva RUTINA con el ID: ",NEW.ID, 
        "con los siguientes datos: ",
        "INSTRUCTOR ID = ", v_nombre_instructor,
        "USUARIO ID = ", v_nombre_usuario,
        "FECHA DE ASIGNACIÓN = ", NEW.fecha_asignacion,
        "FECHA DE TERMINO = ", NEW.fecha_termino,
        "TIEMPO APROXIMADO = ", NEW.tiempo_Aproximado, 
        "ESTATUS = ", NEW.estatus,
        "RESULTADOS ESPERADOS = ", NEW.resultados_esperados),
        NOW(),
        DEFAULT
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `rutinas_AFTER_UPDATE` AFTER UPDATE ON `rutinas` FOR EACH ROW BEGIN
	-- Declaración de variables
    DECLARE v_nombre_instructor VARCHAR(100) DEFAULT NULL;
    DECLARE v_nombre_instructor2 VARCHAR(100) DEFAULT NULL;
    DECLARE v_nombre_usuario VARCHAR(60) DEFAULT NULL;
    DECLARE v_nombre_usuario2 VARCHAR(60) DEFAULT NULL;

    -- Inicialización de las variables
    IF NEW.instructor_id IS NOT NULL THEN 
		-- En caso de tener el id del empleado
		SET v_nombre_instructor = (SELECT CONCAT_WS(" ", p.titulo_cortesia, p.nombre, p.primer_apellido,p.segundo_apellido) FROM personas p WHERE id = NEW.instructor_id);
    ELSE
		SET v_nombre_instructor = "Sin responsable asignado.";
    END IF;
    
    IF OLD.instructor_id IS NOT NULL THEN 
		-- En caso de tener el id del empleado 
		SET v_nombre_instructor2 = (SELECT CONCAT_WS(" ", p.titulo_cortesia, p.nombre, p.primer_apellido,
		p.segundo_apellido) FROM personas p WHERE id = OLD.instructor_id);
    ELSE
		SET v_nombre_instructor2 = "Sin responsable asignado.";
    END IF;

    IF NEW.usuario_id IS NOT NULL THEN 
		-- En caso de tener el id del usuario
		SET v_nombre_usuario = (SELECT CONCAT_WS(" ", p.titulo_cortesia, p.nombre, p.primer_apellido,p.segundo_apellido) FROM personas p WHERE id = NEW.usuario_id);
    ELSE
		SET v_nombre_usuario = "Sin usuario asignado.";
    END IF;

    IF OLD.usuario_id IS NOT NULL THEN 
		-- En caso de tener el id del usuario
		SET v_nombre_usuario2 = (SELECT CONCAT_WS(" ", p.titulo_cortesia, p.nombre, p.primer_apellido, p.segundo_apellido) FROM personas p WHERE id = OLD.usuario_id);
    ELSE
		SET v_nombre_usuario2 = "Sin usuario asignado.";
    END IF;
    
    INSERT INTO bitacora VALUES(
        DEFAULT,
        USER(),
        "Update",
        "areas",
        CONCAT_WS(" ","Se han actualizado los datos del área con el ID: ",
        NEW.ID, "con los siguientes datos:",
        "INSTRUCTOR ID = ", v_nombre_instructor2, " cambio a ", v_nombre_instructor,
        "USUARIO ID =",v_nombre_usuario2," cambio a ", v_nombre_usuario,
        "FECHA DE ASIGNACIÓN = ", OLD.fecha_asignacion, "cambio a", NEW.fecha_asignacion,
        "FECHA DE TERMINO = ", OLD.fecha_termino, "cambio a", NEW.fecha_termino,
        "TIEMPO APROXIMADO = ", OLD.tiempo_aproximado, "cambio a", NEW.tiempo_aproximado,
        "ESTATUS = ", OLD.estatus, " cambio a ", NEW.estatus,
        "RESULTADOS ESPERADOS = ", OLD.resultados_esperados, " cambio a ", NEW.resultados_esperados),
        NOW(),
        DEFAULT       
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `rutinas_AFTER_DELETE` AFTER DELETE ON `rutinas` FOR EACH ROW BEGIN
	INSERT INTO bitacora VALUES(
		DEFAULT,
        USER(),
        "Delete",
        "rutinas",
        CONCAT_WS(" ","Se ha eliminado una RUTINA con el ID: ", OLD.ID),
        now(),
        DEFAULT
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `rutinas_ejercicios`
--

DROP TABLE IF EXISTS `rutinas_ejercicios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rutinas_ejercicios` (
  `Ejercicio_ID` int unsigned DEFAULT NULL,
  `Rutina_ID` int unsigned DEFAULT NULL,
  `Repeticiones` int unsigned DEFAULT NULL,
  `Tiempo` time DEFAULT NULL,
  `Estatus` bit(1) DEFAULT b'1',
  KEY `fk_ejercicio_1` (`Ejercicio_ID`),
  KEY `fk_rutina_2` (`Rutina_ID`),
  CONSTRAINT `fk_ejercicio_1` FOREIGN KEY (`Ejercicio_ID`) REFERENCES `ejercicios` (`ID`),
  CONSTRAINT `fk_rutina_2` FOREIGN KEY (`Rutina_ID`) REFERENCES `rutinas` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rutinas_ejercicios`
--

LOCK TABLES `rutinas_ejercicios` WRITE;
/*!40000 ALTER TABLE `rutinas_ejercicios` DISABLE KEYS */;
/*!40000 ALTER TABLE `rutinas_ejercicios` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `rutinas_ejercicios_AFTER_INSERT` AFTER INSERT ON `rutinas_ejercicios` FOR EACH ROW BEGIN
	-- Declaración de variables
    DECLARE v_cadena_estatus varchar(15) default null;
    DECLARE v_nombre_ejercicio varchar(60) default null;
    DECLARE v_nombre_rutina varchar(60) default null;

    -- Iniciación de las variables
    IF new.estatus = b'1' then
        set v_cadena_estatus = "Activa";
    else
        set v_cadena_estatus = "Inactiva";
    end if;

    if new.ejercicio_id is not null then
        -- En caso de tener el id del ejercicio
        set v_nombre_ejercicio = (SELECT CONCAT_WS(" ", e.nombre_formal, e.nombre_comun) FROM ejercicios e WHERE id = NEW.ejercicio_id);
    else
        SET v_nombre_ejercicio = "Sin ejercicio asignado";
    end if;

    if new.rutina_id is not null then
        -- En caso de tener el id de la rutina
        set v_nombre_rutina = (SELECT resultados_esperados FROM rutinas WHERE id = NEW.rutina_id);
    else
        SET v_nombre_rutina = "Sin rutina asignada";
    end if;

    -- Insertar en la bitacora
    INSERT INTO bitacora VALUES(
        DEFAULT,
        USER(),
        "Create",
        "rutinas_ejercicios",
        CONCAT_WS(" ","Se ha insertado una nueva relación RUTINAS EJERCICIOS con los IDs: Ejercicio - ", NEW.ejercicio_ID, ", Rutina - ", NEW.Rutina_ID , 
        "con los siguientes datos: ",
        "EJERCICIO ID = ", v_nombre_ejercicio,
        "RUTINA ID = ",  v_nombre_rutina,
        "REPETICIONES = ", NEW.repeticiones, 
		"TIEMPO = ", NEW.tiempo,
        "ESTATUS = ", v_cadena_estatus),
        NOW(),
        DEFAULT
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `rutinas_ejercicios_AFTER_UPDATE` AFTER UPDATE ON `rutinas_ejercicios` FOR EACH ROW BEGIN
	-- Declaración de variables
    DECLARE v_cadena_estatus VARCHAR(15) DEFAULT NULL;
    DECLARE v_nombre_ejercicio VARCHAR(100) DEFAULT NULL;
    DECLARE v_cadena_estatus2 VARCHAR(15) DEFAULT NULL;
    DECLARE v_nombre_ejercicio2 VARCHAR(100) DEFAULT NULL;
    DECLARE v_nombre_rutina VARCHAR(60) DEFAULT NULL;
    DECLARE v_nombre_rutina2 VARCHAR(60) DEFAULT NULL;

    -- Inicialización de las variables
    IF NEW.estatus = b'1' THEN
		SET v_cadena_estatus= "Activa";
    ELSE
		SET v_cadena_estatus= "Inactiva";
    END IF; 
    
    IF OLD.estatus = b'1' THEN
		SET v_cadena_estatus2= "Activa";
    ELSE
		SET v_cadena_estatus2= "Inactiva";
    END IF; 
          
    IF NEW.ejercicio_id IS NOT NULL THEN 
		-- En caso de tener el id del ejercicio
		SET v_nombre_ejercicio = (SELECT CONCAT_WS(" ", e.nombre_formal, e.nombre_comun) FROM ejercicios e WHERE id = NEW.ejercicio_id);
    ELSE
		SET v_nombre_ejercicio = "Sin ejercicio asignado.";
    END IF;
    
    IF OLD.ejercicio_id IS NOT NULL THEN 
		-- En caso de tener el id del ejercicio
		SET v_nombre_ejercicio2 = (SELECT CONCAT_WS(" ", e.nombre_formal, e.nombre_comun) FROM ejercicios e WHERE id = OLD.ejercicio_id);
    ELSE
		SET v_nombre_ejercicio2 = "Sin ejercicio asignado.";
    END IF;

    IF NEW.rutina_id IS NOT NULL THEN 
		-- En caso de tener el id de la rutina
		SET v_nombre_rutina = (SELECT resultados_esperados FROM rutinas WHERE id = NEW.rutina_id);
    ELSE
		SET v_nombre_rutina = "Sin rutina asignada.";
    END IF;

    IF OLD.rutina_id IS NOT NULL THEN 
		-- En caso de tener el id de la rutina
		SET v_nombre_rutina2 = (SELECT resultados_esperados FROM rutinas WHERE id = OLD.rutina_id);
    ELSE
		SET v_nombre_rutina2 = "Sin rutina asignada.";
    END IF;
    
    INSERT INTO bitacora VALUES(
        DEFAULT,
        USER(),
        "Update",
        "rutinas_ejercicios",
        CONCAT_WS(" ","Se han actualizado los datos de la relación RUTINAS EJERCICIOS con los IDs: Rutina -", NEW.Rutina_ID, "Ejercicio -", NEW.Ejercicio_ID, 
        "con los siguientes datos:",
        "EJERCICIO ID  = ", v_nombre_ejercicio2, " cambio a ", v_nombre_ejercicio,
        "RUTINA ID = ",v_nombre_rutina2," cambio a ", v_nombre_rutina,
        "REPETICIONES  = ", OLD.repeticiones, " cambio a ", NEW.repeticiones,
        "TIEMPO = ",OLD.tiempo," cambio a ", NEW.tiempo,
        "ESTATUS = ", v_cadena_estatus2, " cambio a ", v_cadena_estatus),
        NOW(),
        DEFAULT       
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `rutinas_ejercicios_AFTER_DELETE` AFTER DELETE ON `rutinas_ejercicios` FOR EACH ROW BEGIN
	INSERT INTO bitacora VALUES(
		DEFAULT,
        USER(),
        "Delete",
        "rutinas_ejercicios",
        CONCAT_WS(" ","Se ha eliminado una relación RUTINAS EJERCICIOS con los IDs: Ejercicio - ", OLD.ejercicio_ID, ", Rutina - ", OLD.Rutina_ID ),
        now(),
        DEFAULT
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `sucursales`
--

DROP TABLE IF EXISTS `sucursales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sucursales` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(150) NOT NULL,
  `Direccion` varchar(250) NOT NULL,
  `Responsable_ID` int unsigned DEFAULT NULL,
  `Total_Clientes_Atendidos` int unsigned NOT NULL DEFAULT '0',
  `Promedio_Clientes_X_Dia` int unsigned NOT NULL DEFAULT '0',
  `Capacidad_Maxima` int unsigned NOT NULL DEFAULT '0',
  `Total_Empleados` int unsigned DEFAULT '0',
  `Horario_Disponibilidad` text NOT NULL,
  `Estatus` bit(1) DEFAULT b'1',
  PRIMARY KEY (`ID`),
  KEY `fk_empleado_2` (`Responsable_ID`),
  CONSTRAINT `fk_empleado_2` FOREIGN KEY (`Responsable_ID`) REFERENCES `empleados` (`Persona_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sucursales`
--

LOCK TABLES `sucursales` WRITE;
/*!40000 ALTER TABLE `sucursales` DISABLE KEYS */;
INSERT INTO `sucursales` VALUES (1,'Xicotepec','Av. 5 de Mayo #75, Col. Centro',NULL,0,0,80,0,'08:00 a 24:00',_binary ''),(2,'Villa Ávila Camacho','Calle Asturinas #124, Col. del Rio',NULL,0,0,50,0,'08:00 a 20:00',_binary ''),(3,'San Isidro','Av. Lopez Mateoz #162 Col. Tierra Negra',NULL,1,1,90,0,'09:00 a 21:00',_binary ''),(4,'Seiva','Av. de las Torres #239, Col. Centro',NULL,0,0,50,0,'07:00 a 22:00',_binary '\0'),(5,'Huahuchinango','Calle Abasolo #25, Col.Barrio tibanco',NULL,0,0,56,0,'07:00 a 21:00',_binary '');
/*!40000 ALTER TABLE `sucursales` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `sucursales_AFTER_INSERT` AFTER INSERT ON `sucursales` FOR EACH ROW BEGIN
-- Declaración de variables
	DECLARE v_cadena_estatus varchar(15) default null;
    DECLARE v_nombre_responsable varchar(60) default null;
-- Iniciación de las variables
-- El estatus de la sucursal se almacena en un dato del tipo BIT, por
-- cuestiones de memoria, pero para registrar eventos en bitacora
-- se requiere ser más descriptivo con la redacción de los eventos
IF new.estatus = b'1' then
	set v_cadena_estatus = "Activa";
else
	set v_cadena_estatus = "Inactiva";
end if;

if new. responsable_id is not null then
-- En caso de tener el id del empleado responsable debemos recuperar su nombre
-- 
	set v_nombre_responsable = (SELECT CONCAT_WS(" ", p.titulo_cortesia, p.nombre, p.primer_apellido, p.segundo_Apellido) FROM personas p WHERE id = NEW.responsable_id);
else
	SET v_nombre_responsable = "Sin responsable asignado";
end if;
-- Insertar en la bitacora
INSERT INTO bitacora VALUES(
		DEFAULT,
        USER(),
        "Create",
        "sucursales",
        CONCAT_WS(" ","Se ha insertado una nueva SUCURSAL con el ID: ",NEW.ID, 
        "con los siguientes datos: ",
        "NOMBRE=", NEW.nombre,
        "DIRECCION = ", NEW.direccion,
        "RESPONSABLE ID = ", v_nombre_responsable,
        "TOTAL CLIENTES ATENDIDOS = ",  NEW.total_clientes_atendidos,
        "PROMEDIO CLIENTES POR DIA = ", NEW.promedio_clientes_x_dia, 
        "CAPACIDAD MAXIMA = ", NEW.capacidad_maxima, 
        "TOTAL EMPLEADOS = ", NEW.total_empleados,
        "HORARIO DISPONIBILIDAD = ", NEW.horario_disponibilidad,
        "ESTATUS = ",  v_cadena_estatus),
        NOW(),
        DEFAULT
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `sucursales_AFTER_UPDATE` AFTER UPDATE ON `sucursales` FOR EACH ROW BEGIN
	-- Declaración de variables
    DECLARE v_cadena_estatus VARCHAR(15) DEFAULT NULL;
    DECLARE v_nombre_responsable VARCHAR(100) DEFAULT NULL;
    DECLARE v_cadena_estatus2 VARCHAR(15) DEFAULT NULL;
    DECLARE v_nombre_responsable2 VARCHAR(100) DEFAULT NULL;

    -- Inicialización de las variables
    -- El estatus de la sucursa se almacena en un dato del tipo BIT, por
    -- cuestiones de memorìa, pero para registrar eventos en bitacora
    -- se requiere ser más descriptivo con las readcción de los eventos. 
    IF NEW.estatus = b'1' THEN
     SET v_cadena_estatus= "Activa";
	ELSE
	 SET v_cadena_estatus= "Inactiva";
    END IF; 
    
    IF OLD.estatus = b'1' THEN
     SET v_cadena_estatus2= "Activa";
	ELSE
	 SET v_cadena_estatus2= "Inactiva";
    END IF; 
          
	IF NEW.responsable_id IS NOT NULL THEN 
    -- En caso de tener el id del empleado responsable debemos recuperar su nombre
    -- para ingresarlo en la bitacora.
	SET v_nombre_responsable = (SELECT CONCAT_WS(" ", p.titulo_cortesia, p.nombre, p.primer_apellido,
    p.segundo_apellido) FROM personas p WHERE id = NEW.responsable_id);
	ELSE
    SET v_nombre_responsable = "Sin responsable asingado.";
    END IF;
    
    IF OLD.responsable_id IS NOT NULL THEN 
    -- En caso de tener el id del empleado responsable debemos recuperar su nombre
    -- para ingresarlo en la bitacora.
	SET v_nombre_responsable2 = (SELECT CONCAT_WS(" ", p.titulo_cortesia, p.nombre, p.primer_apellido,
    p.segundo_apellido) FROM personas p WHERE id = OLD.responsable_id);
	ELSE
    SET v_nombre_responsable2 = "Sin responsable asingado.";
    END IF;
    
    
    INSERT INTO bitacora VALUES(
		DEFAULT,
		USER(),
        "Update",
        "sucursales",
        CONCAT_WS(" ","Se ha modificado una SUCURSAL  existente con el ID: ",
        NEW.ID, "con los siguientes datos: NOMBRE =", OLD.nombre,"cambio a",NEW.nombre,
        "DIRECCION =", OLD.direccion,"cambio a",NEW.direccion,
        "RESPONSABLE = ", v_nombre_responsable2, "cambio a", v_nombre_responsable,
        "TOTAL CLIENTES ATENDIDOS  =",OLD.total_clientes_atendidos,"cambio a", NEW.total_clientes_atendidos,
        "PROMEDIO DE CLIENTES POR DIA =", OLD.promedio_clientes_x_dia,"cambio a",NEW.promedio_clientes_x_dia, 
        "CAPACIDAD MÀXIMA =", OLD.capacidad_maxima,"cambio a", NEW.capacidad_maxima,
        "TOTAL EMPLEADOS =", OLD.total_empleados, "cambio a", NEW.total_empleados,
        "HORARIO_DISPONIBILIDAD =", OLD.horario_disponibilidad, "cambio a", NEW.horario_disponibilidad, 
        "ESTATUS = ", v_cadena_estatus2, "cambio a", v_cadena_estatus),
        NOW(),
        DEFAULT       
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `sucursales_AFTER_DELETE` AFTER DELETE ON `sucursales` FOR EACH ROW BEGIN
	INSERT INTO bitacora VALUES(
		DEFAULT,
        USER(),
        "Delete",
        "sucursales",
        CONCAT_WS(" ","Se ha eliminado una SUCURSAL con el ID: ", OLD.ID),
        now(),
        DEFAULT
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios` (
  `Persona_ID` int unsigned NOT NULL,
  `Nombre_Usuario` int NOT NULL,
  `Password` blob,
  `Tipo` enum('Empleado','Visitante','Miembro','Instructor') DEFAULT NULL,
  `Estatus_Conexion` enum('Online','Offline','Banned') DEFAULT NULL,
  `Ultima_Conexion` datetime DEFAULT NULL,
  PRIMARY KEY (`Persona_ID`),
  UNIQUE KEY `Nombre_Usuario` (`Nombre_Usuario`),
  CONSTRAINT `fk_persona_3` FOREIGN KEY (`Persona_ID`) REFERENCES `personas` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (51,51,NULL,'Empleado','Offline','2022-12-22 18:41:31'),(52,52,NULL,'Empleado','Offline','2023-03-31 16:46:45'),(53,53,NULL,'Empleado','Offline','2023-06-11 19:03:58'),(54,54,NULL,'Empleado','Offline','2024-03-28 10:25:38'),(55,55,NULL,'Empleado','Offline','2023-03-28 14:27:16'),(56,56,NULL,'Empleado','Offline','2023-12-05 19:41:19'),(57,57,NULL,'Empleado','Offline','2023-03-18 13:22:12'),(58,58,NULL,'Empleado','Offline','2023-04-30 09:59:01'),(59,59,NULL,'Empleado','Offline','2021-08-15 12:07:43'),(60,60,NULL,'Empleado','Offline','2022-10-26 10:52:03'),(61,61,NULL,'Empleado','Offline','2022-04-23 17:04:41'),(62,62,NULL,'Empleado','Offline','2021-04-13 16:04:59'),(63,63,NULL,'Empleado','Offline','2023-08-23 09:56:17'),(64,64,NULL,'Empleado','Offline','2024-02-12 19:44:19'),(65,65,NULL,'Empleado','Offline','2023-08-14 14:26:30'),(66,66,NULL,'Empleado','Offline','2020-09-17 13:45:35'),(67,67,NULL,'Empleado','Offline','2023-08-19 08:31:03'),(68,68,NULL,'Empleado','Offline','2022-03-12 19:09:20'),(69,69,NULL,'Empleado','Offline','2023-11-19 12:15:05'),(70,70,NULL,'Empleado','Offline','2023-07-11 11:20:16'),(71,71,NULL,'Empleado','Offline','2022-12-04 18:06:10'),(72,72,NULL,'Empleado','Offline','2022-09-21 19:29:51'),(73,73,NULL,'Empleado','Offline','2023-01-04 08:36:26'),(74,74,NULL,'Empleado','Offline','2021-04-10 09:49:34'),(75,75,NULL,'Empleado','Offline','2024-03-23 15:45:09'),(76,76,NULL,'Empleado','Offline','2024-03-13 12:01:51'),(77,77,NULL,'Empleado','Offline','2020-05-28 13:06:43'),(78,78,NULL,'Empleado','Offline','2023-06-20 14:42:29'),(79,79,NULL,'Empleado','Offline','2024-03-07 14:59:31'),(80,80,NULL,'Empleado','Offline','2023-06-25 08:52:32'),(81,81,NULL,'Empleado','Offline','2023-10-25 10:11:48'),(82,82,NULL,'Empleado','Offline','2023-05-26 15:36:30'),(83,83,NULL,'Empleado','Offline','2022-12-15 16:09:07'),(84,84,NULL,'Empleado','Offline','2023-12-11 13:56:53'),(85,85,NULL,'Empleado','Offline','2023-12-07 12:54:02'),(86,86,NULL,'Empleado','Offline','2024-04-07 17:24:33'),(87,87,NULL,'Empleado','Offline','2023-08-11 09:08:06'),(88,88,NULL,'Empleado','Offline','2023-04-23 13:09:38'),(89,89,NULL,'Empleado','Offline','2023-03-25 11:26:56'),(90,90,NULL,'Empleado','Offline','2023-04-03 19:18:34'),(91,91,NULL,'Empleado','Offline','2024-02-25 09:56:44'),(92,92,NULL,'Empleado','Offline','2024-04-02 15:48:26'),(93,93,NULL,'Empleado','Offline','2023-05-04 18:03:21'),(94,94,NULL,'Empleado','Offline','2022-11-07 11:47:23'),(95,95,NULL,'Empleado','Offline','2024-03-22 12:05:24'),(96,96,NULL,'Empleado','Offline','2023-04-27 13:13:12'),(97,97,NULL,'Empleado','Offline','2024-04-05 18:36:01'),(98,98,NULL,'Empleado','Offline','2023-09-08 08:27:17'),(99,99,NULL,'Empleado','Offline','2023-09-09 19:01:23'),(100,100,NULL,'Empleado','Offline','2022-12-03 13:01:14'),(101,101,NULL,'Instructor','Online','2023-06-19 11:04:04'),(102,102,NULL,'Empleado','Banned','2022-06-18 19:45:47'),(103,103,NULL,'Miembro','Offline','2022-08-14 13:55:24'),(104,104,NULL,'Empleado','Online','2020-11-17 12:41:33'),(105,105,NULL,'Miembro','Banned','2023-12-11 19:55:28'),(106,106,NULL,'Instructor','Banned','2021-11-01 11:34:57'),(107,107,NULL,'Empleado','Banned','2023-12-26 17:13:29'),(108,108,NULL,'Instructor','Online','2023-10-14 08:50:33'),(109,109,NULL,'Empleado','Online','2024-04-02 18:59:14'),(110,110,NULL,'Miembro','Banned','2024-02-28 16:34:29'),(111,111,NULL,'Instructor','Banned','2024-02-22 17:10:33'),(112,112,NULL,'Miembro','Offline','2024-02-17 09:18:38'),(113,113,NULL,'Empleado','Online','2024-01-31 19:27:03'),(114,114,NULL,'Miembro','Offline','2024-03-01 18:45:03'),(115,115,NULL,'Miembro','Banned','2024-03-05 19:10:46'),(116,116,NULL,'Empleado','Banned','2023-04-10 17:13:05'),(117,117,NULL,'Miembro','Offline','2022-05-02 12:24:03'),(118,118,NULL,'Empleado','Banned','2023-06-12 14:50:31'),(119,119,NULL,'Instructor','Online','2024-04-09 12:03:06'),(120,120,NULL,'Empleado','Online','2023-05-10 09:26:13'),(121,121,NULL,'Miembro','Offline','2023-03-28 16:02:56'),(122,122,NULL,'Miembro','Offline','2024-02-26 19:56:27'),(123,123,NULL,'Empleado','Online','2022-05-10 13:38:01'),(124,124,NULL,'Miembro','Offline','2023-07-22 16:38:21'),(125,125,NULL,'Miembro','Banned','2024-01-19 15:37:36'),(126,126,NULL,'Miembro','Online','2023-09-20 15:36:46'),(127,127,NULL,'Instructor','Banned','2024-04-07 16:24:52'),(128,128,NULL,'Empleado','Banned','2021-07-06 12:52:02'),(129,129,NULL,'Visitante','Offline','2023-09-23 13:03:55'),(130,130,NULL,'Visitante','Banned','2023-05-20 19:24:08'),(131,131,NULL,'Empleado','Offline','2023-10-14 08:59:14'),(132,132,NULL,'Instructor','Online','2023-10-07 11:57:05'),(133,133,NULL,'Visitante','Online','2023-04-19 16:11:22'),(134,134,NULL,'Miembro','Offline','2023-06-27 12:34:45'),(135,135,NULL,'Visitante','Offline','2023-12-20 19:59:26'),(136,136,NULL,'Instructor','Banned','2021-07-17 13:22:16'),(137,137,NULL,'Miembro','Banned','2021-07-05 17:10:30'),(138,138,NULL,'Visitante','Online','2023-05-22 12:25:55'),(139,139,NULL,'Miembro','Offline','2023-10-29 08:00:20'),(140,140,NULL,'Instructor','Online','2023-12-27 19:06:27'),(141,141,NULL,'Visitante','Banned','2023-12-16 14:20:54'),(142,142,NULL,'Empleado','Online','2024-03-18 16:04:26'),(143,143,NULL,'Empleado','Banned','2023-04-28 09:52:05'),(144,144,NULL,'Miembro','Banned','2022-02-16 10:10:44'),(145,145,NULL,'Miembro','Online','2022-07-07 08:11:23'),(146,146,NULL,'Visitante','Online','2024-03-30 12:50:18'),(147,147,NULL,'Instructor','Online','2023-10-18 09:48:50'),(148,148,NULL,'Instructor','Online','2024-01-13 11:48:03'),(149,149,NULL,'Visitante','Offline','2022-07-16 17:14:25'),(150,150,NULL,'Instructor','Offline','2023-09-25 12:52:16'),(151,151,NULL,'Visitante','Online','2023-07-28 14:32:24'),(152,152,NULL,'Visitante','Banned','2021-11-20 17:55:22'),(153,153,NULL,'Visitante','Banned','2023-11-16 19:02:36'),(154,154,NULL,'Instructor','Online','2023-08-13 09:11:37'),(155,155,NULL,'Miembro','Online','2023-04-20 13:52:32'),(156,156,NULL,'Empleado','Online','2023-02-17 13:17:27'),(157,157,NULL,'Empleado','Online','2023-01-02 11:52:29'),(158,158,NULL,'Miembro','Online','2023-12-08 09:27:10'),(159,159,NULL,'Instructor','Offline','2023-12-12 19:42:30'),(160,160,NULL,'Miembro','Online','2024-02-24 16:37:21'),(161,161,NULL,'Instructor','Offline','2024-02-03 08:57:09'),(162,162,NULL,'Miembro','Offline','2024-02-25 08:15:44'),(163,163,NULL,'Instructor','Banned','2023-02-26 10:32:30'),(164,164,NULL,'Miembro','Offline','2023-12-14 15:01:46'),(165,165,NULL,'Instructor','Offline','2023-11-15 10:57:39'),(166,166,NULL,'Instructor','Online','2022-08-27 13:18:23'),(167,167,NULL,'Miembro','Banned','2024-04-14 16:08:46'),(168,168,NULL,'Visitante','Online','2024-01-13 18:18:49'),(169,169,NULL,'Instructor','Online','2023-03-12 13:00:46'),(170,170,NULL,'Empleado','Banned','2023-09-27 08:47:05'),(171,171,NULL,'Visitante','Online','2023-10-05 18:00:44'),(172,172,NULL,'Visitante','Online','2023-09-16 09:58:50'),(173,173,NULL,'Visitante','Offline','2023-11-07 10:15:59'),(174,174,NULL,'Empleado','Offline','2023-04-22 15:52:29'),(175,175,NULL,'Visitante','Online','2023-12-03 08:56:31'),(176,176,NULL,'Visitante','Online','2022-10-26 10:21:51'),(177,177,NULL,'Instructor','Offline','2023-08-29 13:45:39'),(178,178,NULL,'Visitante','Online','2022-08-08 08:20:25'),(179,179,NULL,'Visitante','Offline','2023-03-29 16:42:03'),(180,180,NULL,'Visitante','Banned','2020-11-05 14:57:58'),(181,181,NULL,'Miembro','Offline','2021-08-24 13:38:48'),(182,182,NULL,'Instructor','Offline','2024-03-16 17:57:58'),(183,183,NULL,'Miembro','Online','2022-04-06 15:33:58'),(184,184,NULL,'Visitante','Offline','2022-12-03 08:36:58'),(185,185,NULL,'Visitante','Online','2023-11-12 09:57:14'),(186,186,NULL,'Instructor','Offline','2022-03-26 10:05:53'),(187,187,NULL,'Miembro','Banned','2021-05-25 18:00:33'),(188,188,NULL,'Visitante','Offline','2023-11-16 11:12:26'),(189,189,NULL,'Miembro','Online','2024-03-04 16:12:36'),(190,190,NULL,'Visitante','Offline','2022-06-13 13:22:46'),(191,191,NULL,'Instructor','Offline','2021-09-11 14:01:10'),(192,192,NULL,'Instructor','Banned','2021-02-14 14:45:38'),(193,193,NULL,'Visitante','Online','2023-07-17 15:55:21'),(194,194,NULL,'Instructor','Banned','2022-08-12 16:34:21'),(195,195,NULL,'Empleado','Online','2022-12-25 10:58:16'),(196,196,NULL,'Visitante','Online','2024-04-09 10:26:37'),(197,197,NULL,'Instructor','Offline','2023-12-17 18:18:17'),(198,198,NULL,'Instructor','Banned','2023-10-03 09:44:47'),(199,199,NULL,'Instructor','Offline','2024-04-14 14:26:22'),(200,200,NULL,'Visitante','Banned','2023-12-04 09:59:38');
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `usuarios_AFTER_INSERT` AFTER INSERT ON `usuarios` FOR EACH ROW BEGIN
	-- Declaración de variables
    DECLARE v_nombre_usuario varchar(60) default null;

    -- Iniciación de las variables
    if new.nombre_usuario is not null then
        -- En caso de tener el id del usuario debemos recuperar su nombre
        set v_nombre_usuario = (SELECT CONCAT_WS(" ", p.titulo_cortesia, p.nombre, p.primer_apellido, p.segundo_Apellido) FROM personas p WHERE id = NEW.nombre_usuario);
    else
        SET v_nombre_usuario = "Sin usuario asignado";
    end if;

    -- Insertar en la bitacora
    INSERT INTO bitacora VALUES(
        DEFAULT,
        USER(),
        "Create",
        "usuarios",
        CONCAT_WS(" ","Se ha insertado un nuevo USUARIO con el ID: ",NEW.persona_id, 
        "con los siguientes datos: ",
        "NOMBRE USUARIO= ", v_nombre_usuario,
        "PASSWORD = ", NEW.password,
        "TIPO = ", NEW.tipo,
        "ESTATUS CONEXIÓN = ", NEW.estatus_conexion,
        "ULTIMA CONEXIÓN = ", NEW.ultima_conexion),
        NOW(),
        DEFAULT
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `usuarios_AFTER_UPDATE` AFTER UPDATE ON `usuarios` FOR EACH ROW BEGIN
	-- Declaración de variables
    DECLARE v_nombre_usuario varchar(60) default null;
    DECLARE v_nombre_usuario2 varchar(60) default null;

    -- Iniciación de las variables
    if new.nombre_usuario is not null then
        -- En caso de tener el id del usuario debemos recuperar su nombre
        set v_nombre_usuario = (SELECT CONCAT_WS(" ", p.titulo_cortesia, p.nombre, p.primer_apellido, p.segundo_Apellido) FROM personas p WHERE id = NEW.nombre_usuario);
    else
        SET v_nombre_usuario = "Sin usuario asignado";
    end if;
    
    IF OLD.nombre_usuario IS NOT NULL THEN 
		-- En caso de tener el id del usuario debemos recuperar su nombre
		SET v_nombre_usuario2 = (SELECT CONCAT_WS(" ", p.titulo_cortesia, p.nombre, p.primer_apellido, p.segundo_apellido) FROM personas p WHERE id = OLD.nombre_usuario);
    ELSE
		SET v_nombre_usuario2 = "Sin responsable asignado.";
    END IF;
    
    INSERT INTO bitacora VALUES(
        DEFAULT,
        USER(),
        "Update",
        "usuarios",
        CONCAT_WS(" ","Se han actualizado los datos del USUARIO con el ID: ",
        NEW.persona_id, "con los siguientes datos:",
        "NOMBRE USUARIO = ", v_nombre_usuario2, "cambio a", v_nombre_usuario,
        "PASSWORD =",OLD.password,"cambio a", NEW.password,
        "TIPO = ", OLD.tipo, "cambio a", NEW.tipo,
        "ESTATUS CONEXIÓN = ", OLD.estatus_conexion, "cambio a", NEW.estatus_conexion,
        "ULTIMA CONEXIÓN = ", OLD.ultima_conexion, "cambio a", NEW.ultima_conexion),
        NOW(),
        DEFAULT       
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `usuarios_AFTER_DELETE` AFTER DELETE ON `usuarios` FOR EACH ROW BEGIN
	INSERT INTO bitacora VALUES(
		DEFAULT,
        USER(),
        "Delete",
        "usuarios",
        CONCAT_WS(" ","Se ha eliminado un USUARIO con el ID: ", OLD.persona_id),
        now(),
        DEFAULT
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Temporary view structure for view `vw_genero_por_edad`
--

DROP TABLE IF EXISTS `vw_genero_por_edad`;
/*!50001 DROP VIEW IF EXISTS `vw_genero_por_edad`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_genero_por_edad` AS SELECT 
 1 AS `Genero`,
 1 AS `Total`,
 1 AS `Rango`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_miembros_tipo`
--

DROP TABLE IF EXISTS `vw_miembros_tipo`;
/*!50001 DROP VIEW IF EXISTS `vw_miembros_tipo`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_miembros_tipo` AS SELECT 
 1 AS `tipo`,
 1 AS `genero`,
 1 AS `count(*)`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_personas_por_genero`
--

DROP TABLE IF EXISTS `vw_personas_por_genero`;
/*!50001 DROP VIEW IF EXISTS `vw_personas_por_genero`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_personas_por_genero` AS SELECT 
 1 AS `genero`,
 1 AS `count(*)`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_personas_por_genero_tipo`
--

DROP TABLE IF EXISTS `vw_personas_por_genero_tipo`;
/*!50001 DROP VIEW IF EXISTS `vw_personas_por_genero_tipo`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_personas_por_genero_tipo` AS SELECT 
 1 AS `tipo`,
 1 AS `genero`,
 1 AS `Total`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping events for database 'bd_gimnasio_210519'
--

--
-- Dumping routines for database 'bd_gimnasio_210519'
--
/*!50003 DROP FUNCTION IF EXISTS `fn_calcular_edad` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_calcular_edad`(v_fecha_nacimiento date) RETURNS int
    DETERMINISTIC
BEGIN

RETURN timestampdiff(year, v_fecha_nacimiento, curdate());
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_calcular_fin` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_calcular_fin`(fecha_inicio DATETIME, v_tipo_plan VARCHAR(255)) RETURNS datetime
    DETERMINISTIC
BEGIN
  DECLARE fecha_final DATETIME;

  SET fecha_final = 
    CASE v_tipo_plan
      WHEN "Anual" THEN DATE_ADD(fecha_inicio, INTERVAL 1 YEAR)
      WHEN "Semestral" THEN DATE_ADD(fecha_inicio, INTERVAL 6 MONTH)
      WHEN "Trimestral" THEN DATE_ADD(fecha_inicio, INTERVAL 3 MONTH)
      WHEN "Bimestral" THEN DATE_ADD(fecha_inicio, INTERVAL 2 MONTH)
      WHEN "Mensual" THEN DATE_ADD(fecha_inicio, INTERVAL 1 MONTH)
      WHEN "Semanal" THEN DATE_ADD(fecha_inicio, INTERVAL 1 WEEK)
      WHEN "Diaria" THEN DATE_ADD(fecha_inicio, INTERVAL 1 DAY)
      ELSE fecha_inicio
    END;

  RETURN fecha_final;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_calcula_antiguedad` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_calcula_antiguedad`(fecha DATE) RETURNS varchar(200) CHARSET utf8mb4
    DETERMINISTIC
BEGIN
	DECLARE fecha_actual date;
    DECLARE anios INT;
    DECLARE meses INT;
    DECLARE semanas INT;
    DECLARE dias INT;
    DECLARE edad VARCHAR(200);
    
    -- Obtenemos la fecla actual
    SET fecha_actual = CURDATE();
    
    -- Calculamos la diferencia en años, mese, semanas, y dias
    SET anios = TIMESTAMPDIFF(YEAR, fecha, fecha_actual);
    SET meses = TIMESTAMPDIFF(MONTH, fecha, fecha_actual) - (12 * anios);
    SET dias = DATEDIFF(fecha_actual, DATE_ADD(fecha, INTERVAL anios YEAR) + INTERVAL meses MONTH);
    SET semanas = dias / 7;
    SET dias = dias % 7;
    
    -- Construimos el mensaje de la edad
    SET edad = concat_ws(" ", anios, "años, ", meses, "meses, ", semanas, "semanas y ", dias, "dias");
RETURN edad;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_generar_codigo_aleatorio` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_generar_codigo_aleatorio`(longitud INT) RETURNS varchar(255) CHARSET utf8mb4
    DETERMINISTIC
BEGIN
  DECLARE codigo_aleatorio VARCHAR(255) DEFAULT '';
  DECLARE caracteres VARCHAR(62) DEFAULT '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
  DECLARE i INT DEFAULT 0;
  
  WHILE i < longitud DO
    SET codigo_aleatorio = CONCAT(codigo_aleatorio, SUBSTRING(caracteres, FLOOR(RAND() * LENGTH(caracteres)) + 1, 1));
    SET i = i + 1;
  END WHILE;
  
  RETURN codigo_aleatorio;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_generar_contrasena_aleatoria` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_generar_contrasena_aleatoria`() RETURNS blob
    DETERMINISTIC
BEGIN
	DECLARE v_contrasena VARCHAR(255);
    DECLARE v_contrasena_blob BLOB;
  
	-- Genera una contraseña aleatoria
	SET v_contrasena = SUBSTRING(MD5(RAND()) FROM 1 FOR 8);

	-- Convierte la contraseña a BLOB
	SET v_contrasena_blob = UNHEX(SHA2(v_contrasena, 256));
RETURN v_contrasena_blob;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_genera_Apellido` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_genera_Apellido`() RETURNS varchar(60) CHARSET utf8mb4
    DETERMINISTIC
BEGIN
	DECLARE v_apellido_generado varchar(60) default null; 
	SET v_apellido_generado = ELT (fn_numero_aleatorio_rangos(1,50),
	"Hernández","García", "Martínez", "López"," González",
	"Pérez","Rodríguez", "Sánchez", "Ramírez","Cruz",
	"Cortes","Gómes","Morales", "Vázquez","Reyes",
	"Jiménez","Torres","Díaz", "Gutiérrez","Ruíz",
	"Mendoza","Aguilar","Ortiz","Moreno","Castillo",
	"Romero","Álvarez", "Méndez", "Chávez"," Rivera",
	"Juárez","Ramos", "Domínguez", "Herrera","Medina",
	"Castro","Vargas","Guzmán", "Velázquez","De la Cruz",
	"Contreras","Salazar","Luna", "Ortega","Santiago",
	"Guerrero","Estrada","Bautista","Cortés","Soto");
RETURN v_apellido_generado;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_genera_bandera_porcentaje` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_genera_bandera_porcentaje`(porcentaje int) RETURNS tinyint(1)
    DETERMINISTIC
BEGIN
	DECLARE num_generado int default 0;
    DECLARE bandera BOOLEAN;
	set num_generado = fn_numero_aleatorio_rangos(0, 100);
    
    if  num_generado <= porcentaje then
		set bandera = true;
	else 
		set bandera = false;
	end if;
 return bandera;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_genera_codigo_barras` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_genera_codigo_barras`() RETURNS int
    DETERMINISTIC
BEGIN
DECLARE v_codigo_barras_producto int default null; 
		SET v_codigo_barras_producto = ELT (fn_numero_aleatorio_rangos(1,5),
        105389073,385987635,450578976,123457354,190532901);
RETURN v_codigo_barras_producto;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_genera_descripcion_producto` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_genera_descripcion_producto`() RETURNS varchar(250) CHARSET utf8mb4
    DETERMINISTIC
BEGIN
	DECLARE v_descripcion_producto varchar(250) default null; 
		SET v_descripcion_producto = ELT (fn_numero_aleatorio_rangos(1,10),
        "Suplemento nutricional utilizado para aumentar la ingesta de proteínas, promover la recuperación muscular y el crecimiento después del entrenamiento.",
        "Fórmula diseñada para aumentar la energía, mejorar el enfoque mental y la resistencia durante el entrenamiento, generalmente contiene ingredientes como cafeína, beta-alanina y creatina.",
        "Suplemento que contiene los aminoácidos esenciales leucina, isoleucina y valina, que ayudan a promover la recuperación muscular, reducir la fatiga y preservar la masa muscular durante el ejercicio.",
        "Suplemento utilizado para aumentar la fuerza, la potencia y ​​la masa muscular, al mejorar la disponibilidad de energía en los músculos durante el ejercicio de alta intensidad.",
        "Snacks convenientes y portátiles que proporcionan una fuente rápida de proteínas y carbohidratos, ideales para consumir antes o después del entrenamiento para apoyar la recuperación muscular.",
        "Suplementos que contienen una variedad de vitaminas y minerales esenciales para apoyar la salud general, el metabolismo y la función muscular durante el ejercicio intenso.",
        "Suplemento que contiene ácidos grasos esenciales omega-3, conocidos por sus efectos antiinflamatorios y beneficios para la salud cardiovascular y articular.",
        "Equipos de soporte diseñados para proteger la espalda y mejorar la estabilidad durante los levantamientos de peso pesado, como sentadillas y peso muerto.",
        "Accesorios que protegen las manos de callosidades y proporcionan un mejor agarre durante el levantamiento de pesas y otros ejercicios de fuerza.",
        "Botellas diseñadas para mezclar fácilmente proteína en polvo con agua o leche, convenientes para consumir bebidas nutritivas antes o después del entrenamiento.");
RETURN v_descripcion_producto;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_genera_fecha` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_genera_fecha`(fecha_inicio date, fecha_fin date) RETURNS date
    DETERMINISTIC
BEGIN
	DECLARE dia int default null; 
	DECLARE mes int default null; 
	DECLARE anio int default null; 
	DECLARE fecha date default null;
    SET dia = fn_numero_aleatorio_rangos (EXTRACT(DAY FROM fecha_inicio),EXTRACT(DAY FROM fecha_fin));
    SET mes = fn_numero_aleatorio_rangos (EXTRACT(MONTH  FROM fecha_inicio),EXTRACT(MONTH  FROM fecha_fin));
    SET anio = fn_numero_aleatorio_rangos (EXTRACT(YEAR  FROM fecha_inicio),EXTRACT(YEAR  FROM fecha_fin));
    set fecha = concat(anio,'-',mes,'-',dia);
RETURN fecha;
RETURN 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_genera_fecha_nacimiento` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_genera_fecha_nacimiento`(fecha_inicio date, fecha_fin date) RETURNS date
    DETERMINISTIC
BEGIN
	DECLARE min_dias INT;
    DECLARE max_dias INT;
    DECLARE dias_aleatorios INT;
    DECLARE fecha_aleatoria DATE;
    
    set min_dias = datediff(fecha_inicio, '1900-01-01');
    set max_dias = datediff(fecha_fin, '1900-01-01');
    set dias_aleatorios = fn_numero_aleatorio_rangos(min_dias, max_dias);
    set fecha_aleatoria = date_add( '1900-01-01', interval dias_aleatorios DAY);
RETURN fecha_aleatoria;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_genera_fecha_registro` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_genera_fecha_registro`(fechaInicio date, fechaFin date, horaInicio time, horaFin time) RETURNS datetime
    DETERMINISTIC
BEGIN
	DECLARE fechaAleatoria DATE;
	DECLARE horaEntrada time;
    DECLARE horaSalida time;   
	DECLARE horaRegistro time;
	DECLARE fechaHoraGenerada datetime;
    
    SET fechaAleatoria = date_add(fechaInicio, INTERVAL floor(rand() * (datediff(fechaFin, fechaInicio) + 1)) DAY);
    
    SET horaRegistro = addtime(horaInicio, SEC_TO_TIME(FLOOR(RAND() * TIME_TO_SEC(TIMEDIFF(horaFin, horaInicio)))));
    
    set fechaHoraGenerada = concat(fechaAleatoria, " ", horaRegistro);
RETURN fechaHoraGenerada;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_genera_marca_producto` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_genera_marca_producto`() RETURNS varchar(100) CHARSET utf8mb4
    DETERMINISTIC
BEGIN
	DECLARE v_marca_producto_generado varchar(100) default null; 
		SET v_marca_producto_generado = ELT (fn_numero_aleatorio_rangos(1,50),
        "PowerProtein", "FlexiGrip", "CardioCharge", "MuscleMax", "StaminaBoost",
		"PowerFuel", "FlexiStretch", "FlexiRoll", "FlexiLoop", "PowerHydrate", 
        "FlexiStrap", "MuscleRelief", "SpeedGrip", "PowerBurn", "FlexiBand",
		"PowerPulse", "MuscleRecover", "FlexiBall", "FlexiMat", "PowerCharge",
		"FlexiFoam", "SpeedWrap", "PowerLift", "FlexiWheel", "PowerBar",
		"FlexiPad", "SpeedStep", "PowerGrip", "FlexiBottle", "MuscleEase",
		"PowerCord", "FlexiBlock", "SpeedJump","PowerBands", "FlexiRing",
		"MusclePatch", "PowerBlitz", "FlexiStick", "SpeedSpike", "PowerBeam",
		"FlexiSocks", "MuscleFlex", "PowerLift", "FlexiGel", "SpeedMate",
		"PowerSprint", "FlexiPod", "MuscleFlow", "PowerStim", "FlexiSqueeze");
RETURN v_marca_producto_generado;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_genera_nombre` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_genera_nombre`(v_genero CHAR(1)) RETURNS varchar(60) CHARSET utf8mb4
    DETERMINISTIC
BEGIN
	DECLARE v_nombre_generado varchar(60) default null; 
	if v_genero = 'M' THEN 
		SET v_nombre_generado = ELT (fn_numero_aleatorio_rangos(1,25),
        "Marco","Juan", "Pedro", "Alejandro"," Agustin",
        "Ricardo","Gustavo", "Gerardo", "Hugo","Adalid",
        "Mario","Jesus","Yair", "Adan","Maximiliano",
        "Aldair","José","Edgar", "Jorge","Iram",
        "Carlos","Federico","Fernando","Samuel","Daniel");
	else
		SET v_nombre_generado = ELT (fn_numero_aleatorio_rangos(1,25),
        "Lorena","Maria","Luz", "Dulce","Suri",
        "Ameli","Ana","Karla","Carmen","Alondra",
        "Bertha", "Diana","Jazmin","Hortencia", "Guadalupe",
        "Estrella","Monica", "Paola","Brenda", "Flor",
        "Lucía","Sofia","Paula","Valeria","Esmeralda");
	END IF;
RETURN v_nombre_generado;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_genera_nombre_productos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_genera_nombre_productos`() RETURNS varchar(200) CHARSET utf8mb4
    DETERMINISTIC
BEGIN
	DECLARE v_nombre_producto_generado varchar(200) default null; 
		SET v_nombre_producto_generado = ELT (fn_numero_aleatorio_rangos(1,20),
        "Batidos de proteínas","Guantes para levantamiento de pesas",
        "Bebida energética pre-entrenamiento","Suplemento de creatina",
        "Barritas energéticas","Suplemento pre-entrenamiento",
        "Banda de resistencia para estiramientos","Esterilla de yoga",
        "Banda de resistencia para entrenamiento","Bebida isotónica",
		"Correa de estiramiento","Rodillo de espuma para masaje muscular",
        "Magnesio para mejorar el agarre","Termogénico para quemar grasa",
        "Banda elástica para ejercicios de resistencia","Colchoneta para ejercicios",
        "Bebida energética post-entrenamiento","Bloque de espuma para estiramientos",
        "Vendas para muñecas y tobillos","Cinturón de levantamiento de pesas");
RETURN v_nombre_producto_generado;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_genera_precios` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_genera_precios`() RETURNS float
    DETERMINISTIC
BEGIN
DECLARE v_precio_producto_generado float default null; 
		SET v_precio_producto_generado = ELT (fn_numero_aleatorio_rangos(1,10),
        10,20,30,40,50,60,70,80,90,100);
RETURN v_precio_producto_generado;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_genera_presentacion_producto` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_genera_presentacion_producto`() RETURNS varchar(100) CHARSET utf8mb4
    DETERMINISTIC
BEGIN
	DECLARE v_presentacion_producto varchar(100) default null; 
		SET v_presentacion_producto = ELT (fn_numero_aleatorio_rangos(1,6),
        "Proteína Whey Gold Standard","C4 Original Pre-Workout)",
        "Quest Nutrition Protein Bar","Xtend BCAA Powder",
        " Optimum Nutrition Creatine Monohydrate","Nordic Naturals Ultimate Omega");

RETURN v_presentacion_producto;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_genera_productos_existencia` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_genera_productos_existencia`() RETURNS int
    DETERMINISTIC
BEGIN
DECLARE v_cantidad_producto int default null; 
		SET v_cantidad_producto = ELT (fn_numero_aleatorio_rangos(1,5),
        10,380,450,500,60);

RETURN v_cantidad_producto;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_genera_sangre` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_genera_sangre`() RETURNS varchar(10) CHARSET utf8mb4
    DETERMINISTIC
BEGIN
	DECLARE v_sangre_generado varchar(10) default null; 
	SET v_sangre_generado = ELT (fn_numero_aleatorio_rangos(1,8),
	"A+","A-","B+","B-","AB+","AB-","O+","O-");
RETURN v_sangre_generado;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_genera_titulo_cortesia` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_genera_titulo_cortesia`(v_genero CHAR(1) ) RETURNS varchar(20) CHARSET utf8mb4
    DETERMINISTIC
BEGIN
-- función de insertar personas
	declare  v_titulo varchar(20) default null;
    
	if v_genero = 'M' then
		set v_titulo = ELT(fn_numero_aleatorio_rangos(1,10), 
		"Ing.","Sr.", "Joven","Mtro.","Lic.",
		"Med.", "Sgto.", "Tnte.", "C.", "C.P.");
	else
		set v_titulo = ELT(fn_numero_aleatorio_rangos(1,10), 
		"Sra.","Srita", "Dra.","Mtra","Med.",
		"Ing.", "Lic.", "C.", "C.P.", "Pfra");
	end if;
	

RETURN v_titulo;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_genera_vandera_porcentaje` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_genera_vandera_porcentaje`(porcentaje int) RETURNS tinyint(1)
    DETERMINISTIC
BEGIN
	DECLARE num_generado int default 0;
    DECLARE bandera BOOLEAN;
	set num_generado = fn_numero_aleatorio_rangos(0, 100);
    
    if  num_generado <= porcentaje then
		set bandera = true;
	else 
		set bandera = false;
	end if;
 return bandera;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_numero_aleatorio_rangos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_numero_aleatorio_rangos`(v_limite_inferior int, v_limite_superior int) RETURNS int
    DETERMINISTIC
BEGIN	
	declare v_numero_generado INT 
    default floor(Rand()* (v_limite_superior - v_limite_inferior + 1) + v_limite_inferior);
    SET @numero_generado = v_numero_generado;
RETURN v_numero_generado;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `Saludar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `Saludar`() RETURNS varchar(50) CHARSET utf8mb4
    DETERMINISTIC
BEGIN
	DECLARE saludo VARCHAR(50);
	SET saludo = '¡Hola!';
	RETURN saludo;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `SaludarHora` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `SaludarHora`(nombre VARCHAR(50)) RETURNS varchar(100) CHARSET utf8mb4
    DETERMINISTIC
BEGIN
    DECLARE hora INT;
    DECLARE saludo VARCHAR(100);
    
    SET hora = HOUR(now());
	IF hora >= 6 AND hora< 12 THEN
        SET saludo = CONCAT('¡Buenos días ', nombre,'!');
    ELSEIF hora >= 12 AND hora < 18 THEN
        SET saludo = CONCAT('¡Buenas tardes ', nombre,'!');
    ELSE
        SET saludo = CONCAT('¡Buenas noches ', nombre,'!');
    END IF;
    RETURN saludo;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `SaludarHoraEspecifica` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `SaludarHoraEspecifica`(nombre VARCHAR(50), hora TIME) RETURNS varchar(100) CHARSET utf8mb4
    DETERMINISTIC
BEGIN
    DECLARE saludo VARCHAR(100);
    IF HOUR(hora) >= 6 AND HOUR(hora) < 12 THEN
        SET saludo = CONCAT('¡Buenos días ', nombre,'!');
    ELSEIF HOUR(hora) >= 12 AND HOUR(hora) < 18 THEN
        SET saludo = CONCAT('¡Buenas tardes ', nombre,'!');
    ELSE
        SET saludo = CONCAT('¡Buenas noches ', nombre,'!');
    END IF;
    RETURN saludo;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `SaludarNombre` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `SaludarNombre`(nombre VARCHAR(50)) RETURNS varchar(100) CHARSET utf8mb4
    DETERMINISTIC
BEGIN
    DECLARE saludo VARCHAR(100);
    SET saludo = CONCAT('¡Hola ', nombre, '! ');
    RETURN saludo;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_estatus_bd` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_estatus_bd`(v_password varchar(10))
    DETERMINISTIC
BEGIN
	if v_password = "abcde" then 
		(SELECT "areas" as Tabla, "Débil, Catálogo", (SELECT COUNT(*) FROM areas) as Total_Registros)
        UNION
        (SELECT "detalles_pedidos" as Tabla, "Débil, Derivada", (SELECT COUNT(*) FROM detalles_pedidos))
        UNION
        (SELECT "detalles_productos" as Tabla, "Débil, Derivada", (SELECT COUNT(*) FROM detalles_productos))
        UNION
        (SELECT "detalles_programas_saludables" as Tabla, "Débil, Derivada", (SELECT COUNT(*) FROM detalles_programas_saludables))
        UNION
        (SELECT "detalles_promociones" as Tabla, "Débil, Derivada", (SELECT COUNT(*) FROM detalles_promociones))
        UNION
        (SELECT "dietas" as Tabla, "Devil", (SELECT COUNT(*) FROM dietas))
        UNION
        (SELECT "ejercicios" as Tabla, "Fuerte, Catálogo", (SELECT COUNT(*) FROM ejercicios))
        UNION
        (SELECT "empleados" as Tabla, "Débil", (SELECT COUNT(*) FROM empleados))
        UNION
        (SELECT "equipos" as Tabla, "Débil, Derivada", (SELECT COUNT(*) FROM equipos))
        UNION
        (SELECT "equipos_existencias" as Tabla, "Débil, Derivada", (SELECT COUNT(*) FROM equipos_existencias))
        UNION
        (SELECT "instructores" as Tabla, "Débil", (SELECT COUNT(*) FROM instructores))
        UNION
        (SELECT "membresias_usuarios" as Tabla, "Débil, Derivada", (SELECT COUNT(*) FROM membresias_usuarios))
        UNION
        (SELECT "membresias" as Tabla, "Débil", (SELECT COUNT(*) FROM membresias))
        UNION
        (SELECT "miembros" as Tabla, "Débil", (SELECT COUNT(*) FROM miembros))
        UNION
        (SELECT "pedidos" as Tabla, "Débil", (SELECT COUNT(*) FROM pedidos))
        UNION
        (SELECT "personas" as Tabla, "Fuerte", (SELECT COUNT(*) FROM personas))
        UNION
        (SELECT "productos" as Tabla, "Fuerte", (SELECT COUNT(*) FROM productos))
        UNION
        (SELECT "programas_saludables" as Tabla, "Débil", (SELECT COUNT(*) FROM programas_saludables))
        UNION
        (SELECT "promociones" as Tabla, "Debil", (SELECT COUNT(*) FROM promociones))
        UNION
        (SELECT "rutinas" as Tabla, "Débil", (SELECT COUNT(*) FROM rutinas))
        UNION
        (SELECT "rutinas_ejercicios" as Tabla, "Débil, Derivada", (SELECT COUNT(*) FROM rutinas_ejercicios))
        UNION
        (SELECT "sucursales" as Tabla, "Débil, Catálogo", (SELECT COUNT(*) FROM sucursales))
        UNION
        (SELECT "usuarios" as Tabla, "Débil", (SELECT COUNT(*) FROM usuarios))
        UNION
        (SELECT "bitacora" as Tabla, "Isla", (SELECT COUNT(*) FROM bitacora));
	else
		select "La contraseña es incorrecta, no puedo mostrar el estatus de la BD" as Mensaje;
	end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_inserta_detalles_pedidos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_inserta_detalles_pedidos`(v_cuanto int, v_id_producto int)
    DETERMINISTIC
BEGIN
	-- Declaración de variables
    DECLARE i INT default 1;
    DECLARE v_id_pedido int;
    declare v_fecha_inicio_registro date;
    declare v_fecha_fin_registro date;
    DECLARE v_horario_inicio_registro TIME;
    DECLARE v_horario_fin_registro TIME;
    DECLARE v_fecha_entrega DATETIME;
    
    SET v_fecha_entrega = NOW();
    
     -- considerando que el gimnasio empezo a funcionar el 01 de Enero de 2020 y que continua en operación
    SET v_fecha_inicio_registro = "2020-01-01";
    SET v_fecha_fin_registro = curdate();
    -- considera que el área de membresias 
    set v_horario_inicio_registro = "08:00:00";
    set v_horario_fin_registro = "20:00:00";
    
    while i <= v_cuanto do
		call sp_inserta_pedidos(1);
		set v_id_pedido = last_insert_id();
		
		-- Insertar los datos
		INSERT INTO detalles_pedidos values (default,
												v_id_pedido,
                                                v_id_producto,
												fn_genera_productos_existencia(),
                                                fn_genera_precios(),
                                                fn_genera_fecha_registro(v_fecha_inicio_registro, v_fecha_fin_registro, 
                                                v_horario_inicio_registro,v_horario_fin_registro),
                                                v_fecha_entrega,
												default);
		set i = i+1;
    END WHILE;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_inserta_detalles_productos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_inserta_detalles_productos`(v_cuantos int)
    DETERMINISTIC
BEGIN
	DECLARE i INT default 1;
    DECLARE v_id_producto INT;
    
    while i <= v_cuantos do
		
		call sp_inserta_productos(1);
		set v_id_producto = last_insert_id();
	
		-- Ya que se tiene todos los datos del trabajador insertar en la subentidad
		INSERT INTO detalles_productos VALUES(v_id_producto,
												fn_genera_descripcion_producto(),
												fn_genera_codigo_barras(),
												fn_genera_presentacion_producto(),
                                                fn_genera_productos_existencia(),
												default);
		set i = i+1;
    END WHILE;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_inserta_empleados` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_inserta_empleados`(v_cuantos int, v_tipo varchar(15))
BEGIN
	DECLARE i INT default 1;
    DECLARE v_id_persona INT;
    DECLARE v_id_sucursal INT;
	DECLARE v_pos_sucursal INT DEFAULT 0;
    -- debemos conocer el total de sucursales activas
	DECLARE v_total_sucursales INT DEFAULT (select count(*) FROM sucursales WHERE estatus = b'1');
    
    DECLARE v_id_area INT;
    DECLARE v_pos_area INT DEFAULT 0;
    -- 
    DECLARE v_total_areas INT default null;
    DECLARE v_numero_empleados_sucursal INT default null;
	
    -- Para elegir a la sucursal a la que se le dasignara
    while i <= v_cuantos do
		-- Insertar los datos del la persona
        SET v_tipo = null;
        call sp_inserta_personas(1);
        set v_id_persona = last_insert_id();
        
        -- Determina la sucursal a la que pertenece el empleado
        sucursal:LOOP
        if v_total_sucursales > 1 then
			set v_pos_sucursal  = fn_numero_aleatorio_rangos(0, v_total_sucursales-1);
            SET v_id_sucursal = (SELECT id FROM sucursales LIMIT v_pos_sucursal,1);
            
            -- como ya se que sucursal, calcular el area a ala que le trabaja
            SET v_total_areas = (SELECT count(*) FROM areas WHERE sucursal_id = v_id_sucursal AND estatus = b'1');
            -- calcular el total de empleados de la sucursal
            SET v_numero_empleados_sucursal = (SELECT COUNT(*) FROM empleados WHERE sucursal_id = v_id_sucursal);
            
            -- si la sucursal no tiene areas, elegir una de las de la matriz
            IF v_total_areas = 0 THEN 
				set v_total_areas = (SELECT COUNT(*) FROM areas WHERE sucursal_id = 1 AND estatus = b'1');
                SET v_pos_area = fn_numero_aleatorio_rangos(0,v_total_areas-1);
                SET v_id_area = (SELECT id FROM areas WHERE  sucursal_id = 1 LIMIT v_pos_area,1);
            ELSE
				SET v_pos_area = fn_numero_aleatorio_rangos(0,v_total_areas-1);
                SET v_id_area = (SELECT id FROM areas WHERE  sucursal_id = v_id_sucursal LIMIT v_pos_area,1);
            END IF;
            LEAVE sucursal;
		ELSE 
			SELECT ("Al menos debería existir 1 sucursal") as MensajeError;
            LEAVE sucursal;
        end if;
        end loop;
        
        -- En caso de que no se diga que tipo de empleado creamos, se elige uno aleatorio
        if v_tipo IS NULL THEN
			set v_tipo = ELT(fn_numero_aleatorio_rangos(1,5), "Instructor","Administrativo","Intendecia", "Area Medicá","Directivo");
        END IF;
        
        -- Ya que se tiene todos los datos del trabajador insertar en la subentidad
        INSERT INTO empleados VALUES(v_id_persona,
									 v_tipo,
                                     v_id_area,
                                     v_numero_empleados_sucursal+1,
                                     v_id_sucursal,
                                     fn_genera_fecha_registro("2015-01-01", CURDATE(), "08:00:00", "20:00:00"));
        
		set i = i+1;
    end while;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_inserta_membresias` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_inserta_membresias`(v_cuantos INT, v_tipo varchar(20))
    DETERMINISTIC
BEGIN
	 -- Declaración de variables
    DECLARE i INT default 1;
    DECLARE v_id_persona INT;
	DECLARE v_lim_miembros INT;
    DECLARE v_id_membresia INT;
    DECLARE v_tipo_servicios VARCHAR(10);
    DECLARE v_tipo_plan VARCHAR(10);
    DECLARE v_nivel VARCHAR(10);
    DECLARE v_codigo varchar(50);
    DECLARE v_aleatorio BIT DEFAULT b'0';
    DECLARE v_fecha_inicio datetime default NULL;
    DECLARE v_fecha_fin DATETIME default NULL;
    DECLARE v_fecha_registro DATETIME DEFAULT NULL;
    
    -- Determinar si la membresia creada sera aleatoria
    IF v_tipo IS NULL THEN
		SET v_aleatorio = b'1';
    END IF;
    
    while i <= v_cuantos do
		IF v_aleatorio = b'1' THEN
            set v_tipo = ELT(fn_numero_aleatorio_rangos(1,3), "Individual","Familiar","Empresarial");
        END IF;
        
        SET v_tipo_servicios = NULL;
		SET v_tipo_plan = NULL;
		SET v_nivel = NULL;
        SET v_codigo = NULL;
        
        -- INSERTAR EN MEMBRESIAS, LUEGO PERSONAS, LUEGO USUARIOS, TAL VEZ EN MIEMBROS, MEMBRESIAS_USUARIOS
        
        CASE v_tipo
		  WHEN "Individual" THEN SET v_lim_miembros=1;
		  WHEN "Familiar" THEN SET v_lim_miembros= fn_numero_aleatorio_rangos(1,5);
		  WHEN "Empresarial" THEN SET v_lim_miembros = fn_numero_aleatorio_rangos(10,50);
          ELSE SET  v_lim_miembros=1;
		END case;
        
        -- Calcular el servicio aleoatoriamente
        if v_tipo_servicios IS NULL THEN
			set v_tipo_servicios = ELT(fn_numero_aleatorio_rangos(1,4), "Basicos","Completa","Coaching", "Nutriólogo");
        END IF;
        
        -- Calcular el codigo aleatoriamente
        IF v_codigo IS NULL THEN
			SET v_codigo = fn_generar_codigo_aleatorio(50);
        END IF;
        
        -- Calcular el plan aleatoriamente
        if v_tipo_plan IS NULL THEN
			set v_tipo_plan = ELT(fn_numero_aleatorio_rangos(1,7), "Anual","Semestral","Trimestral", "Bimestral", "Mensual", "Semanal", "Diaria");
        END IF;
        
        -- Calculamos la fecha de inicio de la membresia
        set v_fecha_inicio = fn_genera_fecha_registro("2015-01-01", CURDATE(), "08:00:00", "20:00:00");
        
        -- Culamos la fecha del fin de la membresia
        SET v_fecha_fin = fn_calcular_fin(v_fecha_inicio, v_tipo_plan);
        
        -- Calcular el nivel aleatoriamente
        if v_nivel IS NULL THEN
			set v_nivel = ELT(fn_numero_aleatorio_rangos(1,4), "Nuevo","Plata","Oro", "Diamante");
        END IF;
        
        -- Ingresamos la fecha de registro
        SET v_fecha_registro = v_fecha_inicio;
        
		-- Ya que se tiene todos los datos del usuario se inserta en la subentidad
        INSERT INTO membresias VALUES (default,
									   v_codigo,
									   v_tipo,
									   v_tipo_servicios,
									   v_tipo_plan,
                                       v_nivel,
                                       v_fecha_inicio,
                                       v_fecha_fin,
                                       default,
                                       v_fecha_registro,
                                       null);

		-- Obtenemos el ID de la membresia
		set v_id_membresia = last_insert_id();

        -- Insertamos en las relaciones
        call sp_inserta_membresias_usuarios(v_lim_miembros,v_id_membresia);

		set i = i+1;
    END WHILE;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_inserta_membresias_usuarios` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_inserta_membresias_usuarios`(v_cuantos int,v_id_membresia int)
    DETERMINISTIC
BEGIN
	-- Declaración de variables
    DECLARE i INT default 1;
    DECLARE v_id_usuario int;
	DECLARE v_fecha_conexion DATETIME;
    
    while i <= v_cuantos do
		call sp_inserta_miembros(1, null);
		set v_id_usuario = last_insert_id();
		-- Revisando la fecha de la ultima conexión
		SET v_fecha_conexion = (SELECT ultima_conexion from usuarios where persona_id = v_id_usuario );
		
		-- Insertar los datos
		INSERT INTO membresias_usuarios values (v_id_membresia,
												v_id_usuario,
												v_fecha_conexion,
												default);
		set i = i+1;
    END WHILE;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_inserta_miembros` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_inserta_miembros`(v_cuantos int, v_tipo varchar(15))
BEGIN
    -- Declaración de variables
    DECLARE i INT default 1;
    DECLARE v_id_persona INT;
    DECLARE v_tiempo DATETIME;
    DECLARE v_antiguedad VARCHAR(80);
    
    -- debemos conocer el total de personas activas
    DECLARE v_total_personas INT DEFAULT (select count(*) FROM personas WHERE estatus = b'1');
    
	while i <= v_cuantos do
		SET v_tipo = NULL;
        SET v_tiempo = NULL;
		
        -- obtener un id que no este repetido
        
        call sp_inserta_usuarios(1, null);
        set v_id_persona = last_insert_id();
        
        -- En caso de que no se diga que tipo de miembro creamos, se elige uno aleatorio
        if v_tipo IS NULL THEN
            set v_tipo = ELT(fn_numero_aleatorio_rangos(1,5), "Frecuente","Ocasional","Nuevo", "Esporádico","Una sola visita");
        END IF;
        
        personas:LOOP
        SET v_tiempo = (SELECT Fecha_Registro FROM personas WHERE ID=v_id_persona); 
		
		if TIMESTAMPDIFF(YEAR,v_tiempo,CURDATE()) < 1 THEN 
			SET v_antiguedad = concat_ws(" ", 'Miembro nuevo con ',fn_calcula_antiguedad(v_tiempo) );
            LEAVE personas;
		ELSEIF TIMESTAMPDIFF(YEAR,v_tiempo,CURDATE()) BETWEEN 1 AND 3 THEN 
			SET v_antiguedad = concat_ws(" ", 'Miembro regular con ',fn_calcula_antiguedad(v_tiempo) );
            LEAVE personas;
		ELSE 
			SET v_antiguedad = concat_ws(" ", 'Miembro antiguo con ',fn_calcula_antiguedad(v_tiempo) );
            LEAVE personas;
        END IF;
        END LOOP;

        -- Ya que se tiene todos los datos del usuario se inserta en la subentidad
        INSERT INTO miembros VALUES (v_id_persona,
									 v_tipo,
                                     default,
                                     v_antiguedad);
		set i = i+1;
    END WHILE;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_inserta_pedidos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_inserta_pedidos`(v_cuanto int)
    DETERMINISTIC
BEGIN
	DECLARE i INT default 1;
    DECLARE v_id_persona INT;
    DECLARE v_id_productos INT;
    declare v_fecha_inicio_registro date;
    declare v_fecha_fin_registro date;
    DECLARE v_horario_inicio_registro TIME;
    DECLARE v_horario_fin_registro TIME;
    
    -- considerando que el gimnasio empezo a funcionar el 01 de Enero de 2020 y que continua en operación
    SET v_fecha_inicio_registro = "2020-01-01";
    SET v_fecha_fin_registro = curdate();
    -- considera que el área de membresias 
    set v_horario_inicio_registro = "08:00:00";
    set v_horario_fin_registro = "20:00:00";
    while i <= v_cuanto do
		
		call sp_inserta_usuarios(1,null);
		set v_id_persona = last_insert_id();
        
        call sp_inserta_productos(1);
		set v_id_productos = last_insert_id();
	
		INSERT INTO pedidos 
        VALUES(default,
				v_id_persona,
                v_id_productos,
				fn_genera_precios(),
				fn_genera_fecha_registro(v_fecha_inicio_registro, v_fecha_fin_registro, v_horario_inicio_registro,v_horario_fin_registro),
				default);
		set i = i+1;
    END WHILE;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_inserta_personas` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_inserta_personas`(v_cuantos INT)
    DETERMINISTIC
BEGIN
	DECLARE i INT DEFAULT 1;
    DECLARE v_genero CHAR(1) default NULL;
    
    DECLARE v_titulo_porcentaje boolean DEFAULT NULL;
    declare  v_titulo varchar(20) default null;
    
    DECLARE v_fecha_actual DATE;
    DECLARE v_fecha_limite_16 DATE;
    DECLARE v_fecha_limite_65 DATE;
    declare v_fecha_inicio_registro date;
    declare v_fecha_fin_registro date;
    DECLARE v_horario_inicio_registro TIME;
    DECLARE v_horario_fin_registro TIME;
    
    set v_fecha_actual = curdate();
    set v_fecha_limite_16 = date_sub(v_fecha_actual, INTERVAL 16 YEAR);
	set v_fecha_limite_65 = date_sub(v_fecha_actual, INTERVAL 65 YEAR);
    
    -- considerando que el gimnasio empezo a funcionar el 01 de Enero de 2020 y que continua en operación
    SET v_fecha_inicio_registro = "2020-01-01";
    SET v_fecha_fin_registro = curdate();
    -- considera que el área de membresias 
    set v_horario_inicio_registro = "08:00:00";
    set v_horario_fin_registro = "20:00:00";
    
    while i <= v_cuantos DO
		set v_titulo_porcentaje= fn_genera_bandera_porcentaje(20);
        SET v_genero = ELT (fn_numero_aleatorio_rangos(1,2),"M","F");
        if v_titulo_porcentaje then
			set v_titulo = fn_genera_titulo_cortesia(v_genero);
		end if;
        
		INSERT INTO personas VALUES (
		default,
		v_titulo,
		fn_genera_nombre(v_genero),
		fn_genera_Apellido(),
		fn_genera_Apellido(),
        fn_genera_fecha_nacimiento(v_fecha_limite_65,v_fecha_limite_16),
		null,
		v_genero,
		fn_genera_sangre(),
		default,
		fn_genera_fecha_registro(v_fecha_inicio_registro, v_fecha_fin_registro, v_horario_inicio_registro,v_horario_fin_registro),
		NULL);
        set v_titulo = null;
        SET i = i +1;
	END while;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_inserta_productos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_inserta_productos`(v_cuanto int)
    DETERMINISTIC
BEGIN
	DECLARE i INT DEFAULT 1;
     while i <= v_cuanto DO
        
    insert into productos values(
    default,
    fn_genera_nombre_productos(),
    fn_genera_marca_producto(),
    fn_genera_precios(),
    null,
    default);
    
    SET i = i +1;
	END while;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_inserta_promociones` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_inserta_promociones`(v_cuanto int, v_tipo varchar(200))
    DETERMINISTIC
BEGIN
	DECLARE i INT DEFAULT 1;
    DECLARE v_id_productos INT;
    DECLARE v_aplica varchar(200) DEFAULT NULL;
    
     while i <= v_cuanto DO
	
			SET v_tipo = null;
			SET v_aplica = NULL;
            
			call sp_inserta_productos(1);
			set v_id_productos = last_insert_id();
        
		if v_tipo IS NULL THEN
			set v_tipo = ELT(fn_numero_aleatorio_rangos(1,4),'membresias','personalizado','complementarios','recompensas');
		END IF;
        
        if v_aplica IS NULL THEN
			set v_aplica = ELT(fn_numero_aleatorio_rangos(1,2), "Membresia","Producto");
		END IF;
        
		insert into promociones values(v_id_productos,
										v_tipo,
										v_aplica,
										default);
    SET i = i +1;
	END while;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_inserta_usuarios` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_inserta_usuarios`(v_cuantos int, v_tipo varchar(15))
    DETERMINISTIC
BEGIN
	DECLARE i INT default 1;
    DECLARE v_aleatorio BIT default b'0';
    DECLARE v_estatus_conexion varchar(50) DEFAULT NULL;
    DECLARE v_id_persona INT;
    
    IF v_tipo IS NULL THEN
		SET v_aleatorio = b'1';
    END IF;
    
    while i <= v_cuantos do
		-- SELECT concat("Entrando en el ciclo #", i) as MensajeError;
		IF v_aleatorio = b'1' then
			SET v_tipo = null;
			SET v_estatus_conexion = NULL;
		END IF;
		
		call sp_inserta_personas(1);
		set v_id_persona = last_insert_id();
		
		-- En caso de que no se diga que tipo de empleado creamos, se elige uno aleatorio
		if v_tipo IS NULL THEN
			set v_tipo = ELT(fn_numero_aleatorio_rangos(1,4), "Empleado","Visitante","Miembro", "Instructor");
		END IF;
		
		-- En caso de que no se diga la ultima conexión, se elige uno aleatorio
		if v_estatus_conexion IS NULL THEN
			set v_estatus_conexion = ELT(fn_numero_aleatorio_rangos(1,3), "Online","Offline","Banned");
		END IF;
		
		-- Ya que se tiene todos los datos del trabajador insertar en la subentidad
		INSERT INTO usuarios VALUES(v_id_persona,
									 v_id_persona,
									 default,
									 v_tipo,
									 v_estatus_conexion,
									 fn_genera_fecha_registro( (SELECT fecha_registro FROM 
                                     personas WHERE id= v_id_persona), CURDATE(), "08:00:00", "20:00:00"));
		set i = i+1;
    END WHILE;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_limpia_bd` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_limpia_bd`(v_password varchar(10))
    DETERMINISTIC
BEGIN
	if v_password = "abcde" then 
		-- Antes de poder eliminart a las personas tengo que asegurarme que ninguna sucurse
        UPDATE sucursales set responsable_id = null;
        -- Despues de haber eliminado a los responsables de las sucursales, eliminamos a los empleados
        
        -- eliminamos los mienbros 
        -- UPDATE miembros set persona_id = null;
        
        -- eliminamos la relación de membresias y usuarios
        
        -- eliminamos las membresias 
        -- delete from membresias;
        -- ALTER TABLE membresias AUTO_INCREMENT = 1;
        
        -- delete from membresias_usuarios;
        -- delete from empleados;
        -- delete from miembros;
        
        delete from detalles_productos;
        ALTER TABLE detalles_productos AUTO_INCREMENT = 1;
        
        delete from detalles_pedidos;
        ALTER TABLE detalles_pedidos AUTO_INCREMENT = 1;

        delete from pedidos;
        ALTER TABLE pedidos AUTO_INCREMENT = 1;
        
        delete from productos;
        ALTER TABLE productos AUTO_INCREMENT = 1;
        
        -- eliminamos los usuarios 
		-- UPDATE usuarios set nombre_usuario = null;
        delete from usuarios;
        ALTER TABLE usuarios AUTO_INCREMENT = 1;
        
         -- entonces procedemos alimpiar a las personas
		delete from personas;
        ALTER TABLE personas AUTO_INCREMENT = 1;
	else
		select "La contraseña es incorrecta" as Mensaje;
	end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_poblar_bd` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_poblar_bd`(v_password varchar(10))
    DETERMINISTIC
BEGIN
	if v_password = "abcde" then 
		/*call sp_inserta_empleados(199, null);
        CALL sp_inserta_membresias(50, null);
		CALL sp_inserta_membresias(122, 'Individual');
		CALL sp_inserta_membresias(100, 'Familiar');
		CALL sp_inserta_membresias(42, 'Empresarial');*/
        call sp_inserta_personas(10);
        call sp_inserta_usuarios(10, 1);
        call sp_inserta_productos(10);
        call sp_inserta_detalles_productos(10);
        call sp_inserta_pedidos(10);
        call sp_inserta_detalles_pedidos(10,1);
        
	else
		select "La contraseña es incorrecta, no se poblo la BD" as Mensaje;
	end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `vw_genero_por_edad`
--

/*!50001 DROP VIEW IF EXISTS `vw_genero_por_edad`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_genero_por_edad` AS select `personas`.`Genero` AS `Genero`,count(0) AS `Total`,'16-20' AS `Rango` from `personas` where ((`FN_CALCULAR_EDAD`(`personas`.`Fecha_Nacimiento`) >= 16) and (`FN_CALCULAR_EDAD`(`personas`.`Fecha_Nacimiento`) <= 20)) group by `personas`.`Genero` union select `personas`.`Genero` AS `Genero`,count(0) AS `Total`,'21-30' AS `Rango` from `personas` where ((`FN_CALCULAR_EDAD`(`personas`.`Fecha_Nacimiento`) >= 21) and (`FN_CALCULAR_EDAD`(`personas`.`Fecha_Nacimiento`) <= 30)) group by `personas`.`Genero` union select `personas`.`Genero` AS `Genero`,count(0) AS `Total`,'31-40' AS `Rango` from `personas` where ((`FN_CALCULAR_EDAD`(`personas`.`Fecha_Nacimiento`) >= 31) and (`FN_CALCULAR_EDAD`(`personas`.`Fecha_Nacimiento`) <= 40)) group by `personas`.`Genero` union select `personas`.`Genero` AS `Genero`,count(0) AS `Total`,'41-50' AS `Rango` from `personas` where ((`FN_CALCULAR_EDAD`(`personas`.`Fecha_Nacimiento`) >= 41) and (`FN_CALCULAR_EDAD`(`personas`.`Fecha_Nacimiento`) <= 50)) group by `personas`.`Genero` union select `personas`.`Genero` AS `Genero`,count(0) AS `Total`,'+50' AS `Rango` from `personas` where (`FN_CALCULAR_EDAD`(`personas`.`Fecha_Nacimiento`) >= 51) group by `personas`.`Genero` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_miembros_tipo`
--

/*!50001 DROP VIEW IF EXISTS `vw_miembros_tipo`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_miembros_tipo` AS select `m`.`Tipo` AS `tipo`,`p`.`Genero` AS `genero`,count(0) AS `count(*)` from ((((`personas` `p` join `usuarios` `u` on((`p`.`ID` = `u`.`Persona_ID`))) join `miembros` `mi` on((`mi`.`Persona_ID` = `p`.`ID`))) join `membresias_usuarios` `mu` on((`mu`.`Usuarios_ID` = `p`.`ID`))) join `membresias` `m` on((`mu`.`Membresia_ID` = `m`.`ID`))) where (`mi`.`Membresia_Activa` = 0x01) group by `m`.`Tipo`,`p`.`Genero` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_personas_por_genero`
--

/*!50001 DROP VIEW IF EXISTS `vw_personas_por_genero`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_personas_por_genero` AS select `personas`.`Genero` AS `genero`,count(0) AS `count(*)` from `personas` group by `personas`.`Genero` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_personas_por_genero_tipo`
--

/*!50001 DROP VIEW IF EXISTS `vw_personas_por_genero_tipo`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_personas_por_genero_tipo` AS select 'Empleados' AS `tipo`,`personas`.`Genero` AS `genero`,count(0) AS `Total` from (`empleados` join `personas` on((`personas`.`ID` = `empleados`.`Persona_ID`))) group by `personas`.`Genero` union select 'Clientes' AS `tipo`,`personas`.`Genero` AS `genero`,count(0) AS `Total` from (`miembros` join `personas` on((`personas`.`ID` = `miembros`.`Persona_ID`))) group by `personas`.`Genero` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-04-18  0:54:17
