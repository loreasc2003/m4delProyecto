CREATE DATABASE  IF NOT EXISTS `bd_gimnasio_210519` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `bd_gimnasio_210519`;
-- MySQL dump 10.13  Distrib 8.0.30, for Win64 (x86_64)
--
-- Host: localhost    Database: bd_gimnasio_210519
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
) ENGINE=InnoDB AUTO_INCREMENT=988 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bitacora`
--

LOCK TABLES `bitacora` WRITE;
/*!40000 ALTER TABLE `bitacora` DISABLE KEYS */;
INSERT INTO `bitacora` VALUES (1,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  1 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Bertha PRIMER APELLIDO =  Morales SEGUNDO APELLIDO =  Soto FECHA NACIMIENTO =  1968-01-20 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  O- ESTATUS =   FECHA REGISTRO =  2020-10-22 09:15:52 FECHA ACTUALIZACIÓN = ','2024-04-18 13:28:02',_binary ''),(2,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  2 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Aldair PRIMER APELLIDO =  Álvarez SEGUNDO APELLIDO =  Contreras FECHA NACIMIENTO =  1983-07-29 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  A+ ESTATUS =   FECHA REGISTRO =  2022-12-12 11:53:31 FECHA ACTUALIZACIÓN = ','2024-04-18 13:28:02',_binary ''),(3,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  3 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Guadalupe PRIMER APELLIDO =  Reyes SEGUNDO APELLIDO =  Vargas FECHA NACIMIENTO =  1996-08-05 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  AB- ESTATUS =   FECHA REGISTRO =  2023-10-24 14:24:11 FECHA ACTUALIZACIÓN = ','2024-04-18 13:28:02',_binary ''),(4,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  4 con los siguientes datos:  TITULO CORTESIA =  Sr. NOMBRE= Adalid PRIMER APELLIDO =  Álvarez SEGUNDO APELLIDO =  Moreno FECHA NACIMIENTO =  1997-06-01 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  B- ESTATUS =   FECHA REGISTRO =  2020-03-08 17:28:32 FECHA ACTUALIZACIÓN = ','2024-04-18 13:28:02',_binary ''),(5,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  5 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Suri PRIMER APELLIDO =  Domínguez SEGUNDO APELLIDO =  De la Cruz FECHA NACIMIENTO =  2006-09-19 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  B- ESTATUS =   FECHA REGISTRO =  2022-01-11 19:13:09 FECHA ACTUALIZACIÓN = ','2024-04-18 13:28:02',_binary ''),(6,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  6 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= José PRIMER APELLIDO =  Ortega SEGUNDO APELLIDO =  Jiménez FECHA NACIMIENTO =  1959-04-23 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  A+ ESTATUS =   FECHA REGISTRO =  2021-01-11 08:38:37 FECHA ACTUALIZACIÓN = ','2024-04-18 13:28:02',_binary ''),(7,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  7 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Karla PRIMER APELLIDO =  Domínguez SEGUNDO APELLIDO =  Ortiz FECHA NACIMIENTO =  1971-07-12 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  O- ESTATUS =   FECHA REGISTRO =  2023-06-24 11:43:27 FECHA ACTUALIZACIÓN = ','2024-04-18 13:28:02',_binary ''),(8,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  8 con los siguientes datos:  TITULO CORTESIA =  Sra. NOMBRE= Alondra PRIMER APELLIDO =  Méndez SEGUNDO APELLIDO =  Castro FECHA NACIMIENTO =  2000-08-04 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  A+ ESTATUS =   FECHA REGISTRO =  2024-03-07 14:45:43 FECHA ACTUALIZACIÓN = ','2024-04-18 13:28:02',_binary ''),(9,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  9 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Carmen PRIMER APELLIDO =  Cortes SEGUNDO APELLIDO =  Pérez FECHA NACIMIENTO =  2002-01-01 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  A+ ESTATUS =   FECHA REGISTRO =  2022-08-17 19:01:51 FECHA ACTUALIZACIÓN = ','2024-04-18 13:28:02',_binary ''),(10,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  10 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Marco PRIMER APELLIDO =  Ortega SEGUNDO APELLIDO =  Reyes FECHA NACIMIENTO =  2000-07-13 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  B+ ESTATUS =   FECHA REGISTRO =  2020-12-27 09:10:48 FECHA ACTUALIZACIÓN = ','2024-04-18 13:28:02',_binary ''),(11,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  11 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Dulce PRIMER APELLIDO =  Juárez SEGUNDO APELLIDO =   Rivera FECHA NACIMIENTO =  1965-09-17 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  O- ESTATUS =   FECHA REGISTRO =  2020-02-18 13:59:51 FECHA ACTUALIZACIÓN = ','2024-04-18 13:28:02',_binary ''),(12,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  11 con los siguientes datos:  NOMBRE USUARIO=  Dulce Juárez  Rivera PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Offline ULTIMA CONEXIÓN =  2022-05-10 13:22:34','2024-04-18 13:28:02',_binary ''),(13,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  12 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Carmen PRIMER APELLIDO =  Ramírez SEGUNDO APELLIDO =  Luna FECHA NACIMIENTO =  1994-05-22 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  A+ ESTATUS =   FECHA REGISTRO =  2024-04-16 18:51:40 FECHA ACTUALIZACIÓN = ','2024-04-18 13:28:02',_binary ''),(14,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  12 con los siguientes datos:  NOMBRE USUARIO=  Carmen Ramírez Luna PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Offline ULTIMA CONEXIÓN =  2024-04-17 19:11:03','2024-04-18 13:28:02',_binary ''),(15,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  13 con los siguientes datos:  TITULO CORTESIA =  Ing. NOMBRE= Karla PRIMER APELLIDO =  Castro SEGUNDO APELLIDO =  Ramos FECHA NACIMIENTO =  1960-08-15 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  A- ESTATUS =   FECHA REGISTRO =  2020-09-18 09:00:49 FECHA ACTUALIZACIÓN = ','2024-04-18 13:28:02',_binary ''),(16,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  13 con los siguientes datos:  NOMBRE USUARIO=  Ing. Karla Castro Ramos PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Offline ULTIMA CONEXIÓN =  2024-01-08 12:18:01','2024-04-18 13:28:02',_binary ''),(17,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  14 con los siguientes datos:  TITULO CORTESIA =  Sr. NOMBRE= Edgar PRIMER APELLIDO =  Soto SEGUNDO APELLIDO =  Luna FECHA NACIMIENTO =  1970-12-29 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  AB- ESTATUS =   FECHA REGISTRO =  2022-10-18 10:48:14 FECHA ACTUALIZACIÓN = ','2024-04-18 13:28:02',_binary ''),(18,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  14 con los siguientes datos:  NOMBRE USUARIO=  Sr. Edgar Soto Luna PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Offline ULTIMA CONEXIÓN =  2023-02-13 12:32:44','2024-04-18 13:28:02',_binary ''),(19,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  15 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Jorge PRIMER APELLIDO =  Ruíz SEGUNDO APELLIDO =  Castro FECHA NACIMIENTO =  1980-05-31 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  A+ ESTATUS =   FECHA REGISTRO =  2023-03-08 16:10:26 FECHA ACTUALIZACIÓN = ','2024-04-18 13:28:02',_binary ''),(20,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  15 con los siguientes datos:  NOMBRE USUARIO=  Jorge Ruíz Castro PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Offline ULTIMA CONEXIÓN =  2023-05-22 18:35:33','2024-04-18 13:28:02',_binary ''),(21,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  16 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Estrella PRIMER APELLIDO =  Gómes SEGUNDO APELLIDO =  Reyes FECHA NACIMIENTO =  1994-07-06 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  AB- ESTATUS =   FECHA REGISTRO =  2022-04-09 13:09:52 FECHA ACTUALIZACIÓN = ','2024-04-18 13:28:02',_binary ''),(22,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  16 con los siguientes datos:  NOMBRE USUARIO=  Estrella Gómes Reyes PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Offline ULTIMA CONEXIÓN =  2023-06-03 14:33:05','2024-04-18 13:28:02',_binary ''),(23,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  17 con los siguientes datos:  TITULO CORTESIA =  Lic. NOMBRE= Maximiliano PRIMER APELLIDO =  Herrera SEGUNDO APELLIDO =  Ramos FECHA NACIMIENTO =  1963-07-31 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  AB+ ESTATUS =   FECHA REGISTRO =  2022-06-28 10:17:24 FECHA ACTUALIZACIÓN = ','2024-04-18 13:28:02',_binary ''),(24,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  17 con los siguientes datos:  NOMBRE USUARIO=  Lic. Maximiliano Herrera Ramos PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Offline ULTIMA CONEXIÓN =  2022-11-18 14:08:03','2024-04-18 13:28:02',_binary ''),(25,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  18 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Ana PRIMER APELLIDO =  Jiménez SEGUNDO APELLIDO =  Guzmán FECHA NACIMIENTO =  2001-09-27 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  A+ ESTATUS =   FECHA REGISTRO =  2023-01-02 11:47:55 FECHA ACTUALIZACIÓN = ','2024-04-18 13:28:02',_binary ''),(26,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  18 con los siguientes datos:  NOMBRE USUARIO=  Ana Jiménez Guzmán PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Offline ULTIMA CONEXIÓN =  2023-08-19 13:45:01','2024-04-18 13:28:02',_binary ''),(27,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  19 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Jesus PRIMER APELLIDO =  Méndez SEGUNDO APELLIDO =  Díaz FECHA NACIMIENTO =  1963-04-08 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  B+ ESTATUS =   FECHA REGISTRO =  2022-09-04 19:56:06 FECHA ACTUALIZACIÓN = ','2024-04-18 13:28:02',_binary ''),(28,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  19 con los siguientes datos:  NOMBRE USUARIO=  Jesus Méndez Díaz PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Offline ULTIMA CONEXIÓN =  2022-11-04 14:27:26','2024-04-18 13:28:02',_binary ''),(29,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  20 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Ricardo PRIMER APELLIDO =  Díaz SEGUNDO APELLIDO =  Hernández FECHA NACIMIENTO =  1960-10-29 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  A+ ESTATUS =   FECHA REGISTRO =  2022-03-31 10:54:32 FECHA ACTUALIZACIÓN = ','2024-04-18 13:28:02',_binary ''),(30,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  20 con los siguientes datos:  NOMBRE USUARIO=  Ricardo Díaz Hernández PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Offline ULTIMA CONEXIÓN =  2023-07-27 13:57:13','2024-04-18 13:28:02',_binary ''),(31,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  1 con los siguientes datos:  NOMBRE =  Correa de estiramiento MARCA =  SpeedGrip PRECIO ACTUAL =  60.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:28:02',_binary ''),(32,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  2 con los siguientes datos:  NOMBRE =  Suplemento de creatina MARCA =  FlexiStrap PRECIO ACTUAL =  50.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:28:02',_binary ''),(33,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  3 con los siguientes datos:  NOMBRE =  Bebida energética post-entrenamiento MARCA =  PowerGrip PRECIO ACTUAL =  40.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:28:02',_binary ''),(34,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  4 con los siguientes datos:  NOMBRE =  Cinturón de levantamiento de pesas MARCA =  PowerSprint PRECIO ACTUAL =  70.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:28:02',_binary ''),(35,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  5 con los siguientes datos:  NOMBRE =  Suplemento pre-entrenamiento MARCA =  FlexiBlock PRECIO ACTUAL =  30.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:28:02',_binary ''),(36,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  6 con los siguientes datos:  NOMBRE =  Rodillo de espuma para masaje muscular MARCA =  FlexiSqueeze PRECIO ACTUAL =  30.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:28:02',_binary ''),(37,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  7 con los siguientes datos:  NOMBRE =  Barritas energéticas MARCA =  FlexiWheel PRECIO ACTUAL =  60.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:28:02',_binary ''),(38,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  8 con los siguientes datos:  NOMBRE =  Correa de estiramiento MARCA =  PowerStim PRECIO ACTUAL =  30.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:28:02',_binary ''),(39,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  9 con los siguientes datos:  NOMBRE =  Suplemento pre-entrenamiento MARCA =  MusclePatch PRECIO ACTUAL =  70.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:28:02',_binary ''),(40,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  10 con los siguientes datos:  NOMBRE =  Suplemento pre-entrenamiento MARCA =  SpeedWrap PRECIO ACTUAL =  30.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:28:02',_binary ''),(41,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  11 con los siguientes datos:  NOMBRE =  Vendas para muñecas y tobillos MARCA =  SpeedMate PRECIO ACTUAL =  70.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:28:02',_binary ''),(42,'root@localhost','Create','detalles_productos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  1 con los siguientes datos:  PRODUCTO ID =  Vendas para muñecas y tobillos SpeedMate DESCRIPCION =  Accesorios que protegen las manos de callosidades y proporcionan un mejor agarre durante el levantamiento de pesas y otros ejercicios de fuerza. CODIGO DE BARRAS =  190532901 PRESENTACION =  Xtend BCAA Powder ESTATUS =  Activa','2024-04-18 13:28:02',_binary ''),(43,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  12 con los siguientes datos:  NOMBRE =  Bebida isotónica MARCA =  SpeedJump PRECIO ACTUAL =  80.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:28:02',_binary ''),(44,'root@localhost','Create','detalles_productos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  2 con los siguientes datos:  PRODUCTO ID =  Bebida isotónica SpeedJump DESCRIPCION =  Botellas diseñadas para mezclar fácilmente proteína en polvo con agua o leche, convenientes para consumir bebidas nutritivas antes o después del entrenamiento. CODIGO DE BARRAS =  385987635 PRESENTACION =   Optimum Nutrition Creatine Monohydrate ESTATUS =  Activa','2024-04-18 13:28:02',_binary ''),(45,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  13 con los siguientes datos:  NOMBRE =  Suplemento de creatina MARCA =  PowerHydrate PRECIO ACTUAL =  50.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:28:02',_binary ''),(46,'root@localhost','Create','detalles_productos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  3 con los siguientes datos:  PRODUCTO ID =  Suplemento de creatina PowerHydrate DESCRIPCION =  Snacks convenientes y portátiles que proporcionan una fuente rápida de proteínas y carbohidratos, ideales para consumir antes o después del entrenamiento para apoyar la recuperación muscular. CODIGO DE BARRAS =  385987635 PRESENTACION =  Xtend BCAA Powder ESTATUS =  Activa','2024-04-18 13:28:02',_binary ''),(47,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  14 con los siguientes datos:  NOMBRE =  Banda de resistencia para estiramientos MARCA =  FlexiMat PRECIO ACTUAL =  90.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:28:02',_binary ''),(48,'root@localhost','Create','detalles_productos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  4 con los siguientes datos:  PRODUCTO ID =  Banda de resistencia para estiramientos FlexiMat DESCRIPCION =  Fórmula diseñada para aumentar la energía, mejorar el enfoque mental y la resistencia durante el entrenamiento, generalmente contiene ingredientes como cafeína, beta-alanina y creatina. CODIGO DE BARRAS =  105389073 PRESENTACION =   Optimum Nutrition Creatine Monohydrate ESTATUS =  Activa','2024-04-18 13:28:02',_binary ''),(49,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  15 con los siguientes datos:  NOMBRE =  Cinturón de levantamiento de pesas MARCA =  CardioCharge PRECIO ACTUAL =  30.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:28:02',_binary ''),(50,'root@localhost','Create','detalles_productos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  5 con los siguientes datos:  PRODUCTO ID =  Cinturón de levantamiento de pesas CardioCharge DESCRIPCION =  Fórmula diseñada para aumentar la energía, mejorar el enfoque mental y la resistencia durante el entrenamiento, generalmente contiene ingredientes como cafeína, beta-alanina y creatina. CODIGO DE BARRAS =  190532901 PRESENTACION =  Proteína Whey Gold Standard ESTATUS =  Activa','2024-04-18 13:28:02',_binary ''),(51,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  16 con los siguientes datos:  NOMBRE =  Banda de resistencia para entrenamiento MARCA =  SpeedStep PRECIO ACTUAL =  50.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:28:02',_binary ''),(52,'root@localhost','Create','detalles_productos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  6 con los siguientes datos:  PRODUCTO ID =  Banda de resistencia para entrenamiento SpeedStep DESCRIPCION =  Suplemento que contiene ácidos grasos esenciales omega-3, conocidos por sus efectos antiinflamatorios y beneficios para la salud cardiovascular y articular. CODIGO DE BARRAS =  105389073 PRESENTACION =  Quest Nutrition Protein Bar ESTATUS =  Activa','2024-04-18 13:28:02',_binary ''),(53,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  17 con los siguientes datos:  NOMBRE =  Banda de resistencia para estiramientos MARCA =  PowerBar PRECIO ACTUAL =  50.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:28:02',_binary ''),(54,'root@localhost','Create','detalles_productos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  7 con los siguientes datos:  PRODUCTO ID =  Banda de resistencia para estiramientos PowerBar DESCRIPCION =  Botellas diseñadas para mezclar fácilmente proteína en polvo con agua o leche, convenientes para consumir bebidas nutritivas antes o después del entrenamiento. CODIGO DE BARRAS =  450578976 PRESENTACION =  Quest Nutrition Protein Bar ESTATUS =  Activa','2024-04-18 13:28:02',_binary ''),(55,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  18 con los siguientes datos:  NOMBRE =  Termogénico para quemar grasa MARCA =  PowerLift PRECIO ACTUAL =  20.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:28:02',_binary ''),(56,'root@localhost','Create','detalles_productos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  8 con los siguientes datos:  PRODUCTO ID =  Termogénico para quemar grasa PowerLift DESCRIPCION =  Suplemento que contiene los aminoácidos esenciales leucina, isoleucina y valina, que ayudan a promover la recuperación muscular, reducir la fatiga y preservar la masa muscular durante el ejercicio. CODIGO DE BARRAS =  190532901 PRESENTACION =  Proteína Whey Gold Standard ESTATUS =  Activa','2024-04-18 13:28:02',_binary ''),(57,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  19 con los siguientes datos:  NOMBRE =  Bebida energética post-entrenamiento MARCA =  FlexiBand PRECIO ACTUAL =  100.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:28:02',_binary ''),(58,'root@localhost','Create','detalles_productos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  9 con los siguientes datos:  PRODUCTO ID =  Bebida energética post-entrenamiento FlexiBand DESCRIPCION =  Botellas diseñadas para mezclar fácilmente proteína en polvo con agua o leche, convenientes para consumir bebidas nutritivas antes o después del entrenamiento. CODIGO DE BARRAS =  123457354 PRESENTACION =  Xtend BCAA Powder ESTATUS =  Activa','2024-04-18 13:28:02',_binary ''),(59,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  20 con los siguientes datos:  NOMBRE =  Suplemento de creatina MARCA =  PowerFuel PRECIO ACTUAL =  10.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:28:02',_binary ''),(60,'root@localhost','Create','detalles_productos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  10 con los siguientes datos:  PRODUCTO ID =  Suplemento de creatina PowerFuel DESCRIPCION =  Botellas diseñadas para mezclar fácilmente proteína en polvo con agua o leche, convenientes para consumir bebidas nutritivas antes o después del entrenamiento. CODIGO DE BARRAS =  123457354 PRESENTACION =  Xtend BCAA Powder ESTATUS =  Activa','2024-04-18 13:28:02',_binary ''),(61,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  21 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Aldair PRIMER APELLIDO =  De la Cruz SEGUNDO APELLIDO =  Rodríguez FECHA NACIMIENTO =  1970-03-12 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  AB- ESTATUS =   FECHA REGISTRO =  2020-04-09 08:57:05 FECHA ACTUALIZACIÓN = ','2024-04-18 13:28:02',_binary ''),(62,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  21 con los siguientes datos:  NOMBRE USUARIO=  Aldair De la Cruz Rodríguez PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Banned ULTIMA CONEXIÓN =  2021-08-19 11:47:58','2024-04-18 13:28:02',_binary ''),(63,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  21 con los siguientes datos:  NOMBRE =  Rodillo de espuma para masaje muscular MARCA =  SpeedMate PRECIO ACTUAL =  80.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:28:02',_binary ''),(64,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  1 con los siguientes datos:  USUARIO ID =  Aldair De la Cruz Rodríguez PRODUCTO ID =  Rodillo de espuma para masaje muscular SpeedMate 80.00 TOTAL =  20.00 FECHA REGISTRO =  2022-08-06 13:33:41 ESTATUS =  Activa','2024-04-18 13:28:03',_binary ''),(65,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  22 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Alejandro PRIMER APELLIDO =  Díaz SEGUNDO APELLIDO =  Vázquez FECHA NACIMIENTO =  1976-03-28 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  O- ESTATUS =   FECHA REGISTRO =  2022-01-13 15:56:19 FECHA ACTUALIZACIÓN = ','2024-04-18 13:28:03',_binary ''),(66,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  22 con los siguientes datos:  NOMBRE USUARIO=  Alejandro Díaz Vázquez PASSWORD =  TIPO =  Instructor ESTATUS CONEXIÓN =  Offline ULTIMA CONEXIÓN =  2023-05-14 15:04:41','2024-04-18 13:28:03',_binary ''),(67,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  22 con los siguientes datos:  NOMBRE =  Suplemento de creatina MARCA =  FlexiRoll PRECIO ACTUAL =  30.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:28:03',_binary ''),(68,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  2 con los siguientes datos:  USUARIO ID =  Alejandro Díaz Vázquez PRODUCTO ID =  Suplemento de creatina FlexiRoll 30.00 TOTAL =  80.00 FECHA REGISTRO =  2023-12-12 12:52:27 ESTATUS =  Activa','2024-04-18 13:28:03',_binary ''),(69,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  23 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Daniel PRIMER APELLIDO =  Gutiérrez SEGUNDO APELLIDO =  Cortés FECHA NACIMIENTO =  1992-10-07 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  AB+ ESTATUS =   FECHA REGISTRO =  2022-08-10 13:17:38 FECHA ACTUALIZACIÓN = ','2024-04-18 13:28:03',_binary ''),(70,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  23 con los siguientes datos:  NOMBRE USUARIO=  Daniel Gutiérrez Cortés PASSWORD =  TIPO =  Visitante ESTATUS CONEXIÓN =  Offline ULTIMA CONEXIÓN =  2024-01-17 13:23:32','2024-04-18 13:28:03',_binary ''),(71,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  23 con los siguientes datos:  NOMBRE =  Termogénico para quemar grasa MARCA =  FlexiStretch PRECIO ACTUAL =  60.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:28:03',_binary ''),(72,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  3 con los siguientes datos:  USUARIO ID =  Daniel Gutiérrez Cortés PRODUCTO ID =  Termogénico para quemar grasa FlexiStretch 60.00 TOTAL =  40.00 FECHA REGISTRO =  2021-04-23 12:05:42 ESTATUS =  Activa','2024-04-18 13:28:03',_binary ''),(73,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  24 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Karla PRIMER APELLIDO =  Domínguez SEGUNDO APELLIDO =  Ruíz FECHA NACIMIENTO =  2008-01-14 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  O+ ESTATUS =   FECHA REGISTRO =  2020-02-16 16:51:47 FECHA ACTUALIZACIÓN = ','2024-04-18 13:28:03',_binary ''),(74,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  24 con los siguientes datos:  NOMBRE USUARIO=  Karla Domínguez Ruíz PASSWORD =  TIPO =  Miembro ESTATUS CONEXIÓN =  Banned ULTIMA CONEXIÓN =  2021-02-03 16:46:28','2024-04-18 13:28:03',_binary ''),(75,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  24 con los siguientes datos:  NOMBRE =  Cinturón de levantamiento de pesas MARCA =  PowerCord PRECIO ACTUAL =  20.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:28:03',_binary ''),(76,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  4 con los siguientes datos:  USUARIO ID =  Karla Domínguez Ruíz PRODUCTO ID =  Cinturón de levantamiento de pesas PowerCord 20.00 TOTAL =  100.00 FECHA REGISTRO =  2021-11-13 10:39:07 ESTATUS =  Activa','2024-04-18 13:28:03',_binary ''),(77,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  25 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Gerardo PRIMER APELLIDO =  Romero SEGUNDO APELLIDO =   Rivera FECHA NACIMIENTO =  1983-03-09 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  AB- ESTATUS =   FECHA REGISTRO =  2023-02-24 16:58:39 FECHA ACTUALIZACIÓN = ','2024-04-18 13:28:03',_binary ''),(78,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  25 con los siguientes datos:  NOMBRE USUARIO=  Gerardo Romero  Rivera PASSWORD =  TIPO =  Miembro ESTATUS CONEXIÓN =  Offline ULTIMA CONEXIÓN =  2023-12-09 08:34:47','2024-04-18 13:28:03',_binary ''),(79,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  25 con los siguientes datos:  NOMBRE =  Suplemento de creatina MARCA =  FlexiStick PRECIO ACTUAL =  30.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:28:03',_binary ''),(80,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  5 con los siguientes datos:  USUARIO ID =  Gerardo Romero  Rivera PRODUCTO ID =  Suplemento de creatina FlexiStick 30.00 TOTAL =  100.00 FECHA REGISTRO =  2020-08-18 17:31:24 ESTATUS =  Activa','2024-04-18 13:28:03',_binary ''),(81,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  26 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Edgar PRIMER APELLIDO =  Guzmán SEGUNDO APELLIDO =  Herrera FECHA NACIMIENTO =  1964-06-07 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  B- ESTATUS =   FECHA REGISTRO =  2020-09-07 11:44:36 FECHA ACTUALIZACIÓN = ','2024-04-18 13:28:03',_binary ''),(82,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  26 con los siguientes datos:  NOMBRE USUARIO=  Edgar Guzmán Herrera PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Offline ULTIMA CONEXIÓN =  2021-02-18 10:25:31','2024-04-18 13:28:03',_binary ''),(83,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  26 con los siguientes datos:  NOMBRE =  Magnesio para mejorar el agarre MARCA =  FlexiBottle PRECIO ACTUAL =  100.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:28:03',_binary ''),(84,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  6 con los siguientes datos:  USUARIO ID =  Edgar Guzmán Herrera PRODUCTO ID =  Magnesio para mejorar el agarre FlexiBottle 100.00 TOTAL =  10.00 FECHA REGISTRO =  2021-10-09 18:46:18 ESTATUS =  Activa','2024-04-18 13:28:03',_binary ''),(85,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  27 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Maria PRIMER APELLIDO =  Álvarez SEGUNDO APELLIDO =  Méndez FECHA NACIMIENTO =  1968-03-21 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  A- ESTATUS =   FECHA REGISTRO =  2022-09-06 13:01:09 FECHA ACTUALIZACIÓN = ','2024-04-18 13:28:03',_binary ''),(86,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  27 con los siguientes datos:  NOMBRE USUARIO=  Maria Álvarez Méndez PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Banned ULTIMA CONEXIÓN =  2023-07-24 10:21:00','2024-04-18 13:28:03',_binary ''),(87,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  27 con los siguientes datos:  NOMBRE =  Banda de resistencia para estiramientos MARCA =  FlexiLoop PRECIO ACTUAL =  80.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:28:03',_binary ''),(88,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  7 con los siguientes datos:  USUARIO ID =  Maria Álvarez Méndez PRODUCTO ID =  Banda de resistencia para estiramientos FlexiLoop 80.00 TOTAL =  30.00 FECHA REGISTRO =  2020-11-28 10:04:19 ESTATUS =  Activa','2024-04-18 13:28:03',_binary ''),(89,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  28 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Bertha PRIMER APELLIDO =  Cruz SEGUNDO APELLIDO =  Vargas FECHA NACIMIENTO =  1962-08-10 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  A- ESTATUS =   FECHA REGISTRO =  2022-06-05 12:21:49 FECHA ACTUALIZACIÓN = ','2024-04-18 13:28:03',_binary ''),(90,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  28 con los siguientes datos:  NOMBRE USUARIO=  Bertha Cruz Vargas PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Offline ULTIMA CONEXIÓN =  2022-12-03 16:56:55','2024-04-18 13:28:03',_binary ''),(91,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  28 con los siguientes datos:  NOMBRE =  Vendas para muñecas y tobillos MARCA =  SpeedWrap PRECIO ACTUAL =  40.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:28:03',_binary ''),(92,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  8 con los siguientes datos:  USUARIO ID =  Bertha Cruz Vargas PRODUCTO ID =  Vendas para muñecas y tobillos SpeedWrap 40.00 TOTAL =  40.00 FECHA REGISTRO =  2022-12-04 13:01:24 ESTATUS =  Activa','2024-04-18 13:28:03',_binary ''),(93,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  29 con los siguientes datos:  TITULO CORTESIA =  C. NOMBRE= Gerardo PRIMER APELLIDO =  Cortés SEGUNDO APELLIDO =  Guerrero FECHA NACIMIENTO =  1989-07-26 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  B+ ESTATUS =   FECHA REGISTRO =  2020-02-01 19:42:16 FECHA ACTUALIZACIÓN = ','2024-04-18 13:28:03',_binary ''),(94,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  29 con los siguientes datos:  NOMBRE USUARIO=  C. Gerardo Cortés Guerrero PASSWORD =  TIPO =  Instructor ESTATUS CONEXIÓN =  Online ULTIMA CONEXIÓN =  2021-07-25 11:16:53','2024-04-18 13:28:03',_binary ''),(95,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  29 con los siguientes datos:  NOMBRE =  Banda de resistencia para estiramientos MARCA =  FlexiStick PRECIO ACTUAL =  90.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:28:03',_binary ''),(96,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  9 con los siguientes datos:  USUARIO ID =  C. Gerardo Cortés Guerrero PRODUCTO ID =  Banda de resistencia para estiramientos FlexiStick 90.00 TOTAL =  80.00 FECHA REGISTRO =  2022-04-15 11:26:01 ESTATUS =  Activa','2024-04-18 13:28:03',_binary ''),(97,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  30 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Juan PRIMER APELLIDO =  Ruíz SEGUNDO APELLIDO =  Vargas FECHA NACIMIENTO =  1981-10-03 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  A- ESTATUS =   FECHA REGISTRO =  2021-02-12 19:01:52 FECHA ACTUALIZACIÓN = ','2024-04-18 13:28:03',_binary ''),(98,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  30 con los siguientes datos:  NOMBRE USUARIO=  Juan Ruíz Vargas PASSWORD =  TIPO =  Instructor ESTATUS CONEXIÓN =  Online ULTIMA CONEXIÓN =  2021-08-22 18:17:28','2024-04-18 13:28:03',_binary ''),(99,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  30 con los siguientes datos:  NOMBRE =  Colchoneta para ejercicios MARCA =  PowerCharge PRECIO ACTUAL =  60.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:28:03',_binary ''),(100,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  10 con los siguientes datos:  USUARIO ID =  Juan Ruíz Vargas PRODUCTO ID =  Colchoneta para ejercicios PowerCharge 60.00 TOTAL =  70.00 FECHA REGISTRO =  2023-04-11 16:39:31 ESTATUS =  Activa','2024-04-18 13:28:03',_binary ''),(101,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  31 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Gustavo PRIMER APELLIDO =  Santiago SEGUNDO APELLIDO =  Castro FECHA NACIMIENTO =  2000-12-16 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  A- ESTATUS =   FECHA REGISTRO =  2020-10-20 13:55:19 FECHA ACTUALIZACIÓN = ','2024-04-18 13:28:03',_binary ''),(102,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  31 con los siguientes datos:  NOMBRE USUARIO=  Gustavo Santiago Castro PASSWORD =  TIPO =  Instructor ESTATUS CONEXIÓN =  Online ULTIMA CONEXIÓN =  2022-08-20 13:42:18','2024-04-18 13:28:03',_binary ''),(103,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  31 con los siguientes datos:  NOMBRE =  Bebida energética post-entrenamiento MARCA =  MuscleEase PRECIO ACTUAL =  60.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:28:03',_binary ''),(104,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  11 con los siguientes datos:  USUARIO ID =  Gustavo Santiago Castro PRODUCTO ID =  Bebida energética post-entrenamiento MuscleEase 60.00 TOTAL =  20.00 FECHA REGISTRO =  2023-04-23 14:31:27 ESTATUS =  Activa','2024-04-18 13:28:03',_binary ''),(105,'root@localhost','Create','detalles_pedidos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  1 con los siguientes datos:  PEDIDO ID =  31 20.00 2023-04-23 14:31:27 PRODUCTO ID =  Correa de estiramiento SpeedGrip CANTIDAD =  450 TOTAL PARCIAL =  50.00 FECHA REGISTRO =  2023-08-15 19:38:46 FECHA ENTREGA =  2024-04-18 13:28:03 ESTATUS =  Activa','2024-04-18 13:28:03',_binary ''),(106,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  32 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Guadalupe PRIMER APELLIDO =  Luna SEGUNDO APELLIDO =  Ortiz FECHA NACIMIENTO =  1995-05-12 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  B+ ESTATUS =   FECHA REGISTRO =  2021-05-23 16:24:21 FECHA ACTUALIZACIÓN = ','2024-04-18 13:28:03',_binary ''),(107,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  32 con los siguientes datos:  NOMBRE USUARIO=  Guadalupe Luna Ortiz PASSWORD =  TIPO =  Miembro ESTATUS CONEXIÓN =  Offline ULTIMA CONEXIÓN =  2021-11-16 10:08:45','2024-04-18 13:28:03',_binary ''),(108,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  32 con los siguientes datos:  NOMBRE =  Esterilla de yoga MARCA =  SpeedWrap PRECIO ACTUAL =  100.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:28:03',_binary ''),(109,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  12 con los siguientes datos:  USUARIO ID =  Guadalupe Luna Ortiz PRODUCTO ID =  Esterilla de yoga SpeedWrap 100.00 TOTAL =  60.00 FECHA REGISTRO =  2020-04-03 14:00:30 ESTATUS =  Activa','2024-04-18 13:28:03',_binary ''),(110,'root@localhost','Create','detalles_pedidos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  2 con los siguientes datos:  PEDIDO ID =  32 60.00 2020-04-03 14:00:30 PRODUCTO ID =  Correa de estiramiento SpeedGrip CANTIDAD =  380 TOTAL PARCIAL =  20.00 FECHA REGISTRO =  2022-08-31 16:56:34 FECHA ENTREGA =  2024-04-18 13:28:03 ESTATUS =  Activa','2024-04-18 13:28:03',_binary ''),(111,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  33 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Federico PRIMER APELLIDO =  López SEGUNDO APELLIDO =  Castro FECHA NACIMIENTO =  1976-08-20 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  AB- ESTATUS =   FECHA REGISTRO =  2020-09-07 18:21:56 FECHA ACTUALIZACIÓN = ','2024-04-18 13:28:03',_binary ''),(112,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  33 con los siguientes datos:  NOMBRE USUARIO=  Federico López Castro PASSWORD =  TIPO =  Instructor ESTATUS CONEXIÓN =  Offline ULTIMA CONEXIÓN =  2022-09-02 18:52:07','2024-04-18 13:28:03',_binary ''),(113,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  33 con los siguientes datos:  NOMBRE =  Bloque de espuma para estiramientos MARCA =  PowerBands PRECIO ACTUAL =  80.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:28:03',_binary ''),(114,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  13 con los siguientes datos:  USUARIO ID =  Federico López Castro PRODUCTO ID =  Bloque de espuma para estiramientos PowerBands 80.00 TOTAL =  70.00 FECHA REGISTRO =  2020-12-25 08:48:55 ESTATUS =  Activa','2024-04-18 13:28:03',_binary ''),(115,'root@localhost','Create','detalles_pedidos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  3 con los siguientes datos:  PEDIDO ID =  33 70.00 2020-12-25 08:48:55 PRODUCTO ID =  Correa de estiramiento SpeedGrip CANTIDAD =  500 TOTAL PARCIAL =  10.00 FECHA REGISTRO =  2021-06-27 14:35:13 FECHA ENTREGA =  2024-04-18 13:28:03 ESTATUS =  Activa','2024-04-18 13:28:03',_binary ''),(116,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  34 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Karla PRIMER APELLIDO =  Velázquez SEGUNDO APELLIDO =  Martínez FECHA NACIMIENTO =  2002-02-17 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  A- ESTATUS =   FECHA REGISTRO =  2022-08-02 11:16:32 FECHA ACTUALIZACIÓN = ','2024-04-18 13:28:03',_binary ''),(117,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  34 con los siguientes datos:  NOMBRE USUARIO=  Karla Velázquez Martínez PASSWORD =  TIPO =  Miembro ESTATUS CONEXIÓN =  Banned ULTIMA CONEXIÓN =  2022-12-27 10:45:54','2024-04-18 13:28:03',_binary ''),(118,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  34 con los siguientes datos:  NOMBRE =  Banda de resistencia para entrenamiento MARCA =  SpeedStep PRECIO ACTUAL =  40.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:28:03',_binary ''),(119,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  14 con los siguientes datos:  USUARIO ID =  Karla Velázquez Martínez PRODUCTO ID =  Banda de resistencia para entrenamiento SpeedStep 40.00 TOTAL =  100.00 FECHA REGISTRO =  2023-02-04 17:55:23 ESTATUS =  Activa','2024-04-18 13:28:03',_binary ''),(120,'root@localhost','Create','detalles_pedidos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  4 con los siguientes datos:  PEDIDO ID =  34 100.00 2023-02-04 17:55:23 PRODUCTO ID =  Correa de estiramiento SpeedGrip CANTIDAD =  60 TOTAL PARCIAL =  40.00 FECHA REGISTRO =  2020-03-02 08:12:54 FECHA ENTREGA =  2024-04-18 13:28:03 ESTATUS =  Activa','2024-04-18 13:28:03',_binary ''),(121,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  35 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Luz PRIMER APELLIDO =  Ramírez SEGUNDO APELLIDO =  Castillo FECHA NACIMIENTO =  2006-08-25 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  B+ ESTATUS =   FECHA REGISTRO =  2023-07-29 09:25:01 FECHA ACTUALIZACIÓN = ','2024-04-18 13:28:03',_binary ''),(122,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  35 con los siguientes datos:  NOMBRE USUARIO=  Luz Ramírez Castillo PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Online ULTIMA CONEXIÓN =  2023-10-31 12:44:31','2024-04-18 13:28:03',_binary ''),(123,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  35 con los siguientes datos:  NOMBRE =  Vendas para muñecas y tobillos MARCA =  FlexiBall PRECIO ACTUAL =  10.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:28:03',_binary ''),(124,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  15 con los siguientes datos:  USUARIO ID =  Luz Ramírez Castillo PRODUCTO ID =  Vendas para muñecas y tobillos FlexiBall 10.00 TOTAL =  100.00 FECHA REGISTRO =  2023-09-27 13:05:34 ESTATUS =  Activa','2024-04-18 13:28:03',_binary ''),(125,'root@localhost','Create','detalles_pedidos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  5 con los siguientes datos:  PEDIDO ID =  35 100.00 2023-09-27 13:05:34 PRODUCTO ID =  Correa de estiramiento SpeedGrip CANTIDAD =  450 TOTAL PARCIAL =  30.00 FECHA REGISTRO =  2023-12-15 16:42:21 FECHA ENTREGA =  2024-04-18 13:28:03 ESTATUS =  Activa','2024-04-18 13:28:03',_binary ''),(126,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  36 con los siguientes datos:  TITULO CORTESIA =  NOMBRE=  Agustin PRIMER APELLIDO =  Moreno SEGUNDO APELLIDO =  De la Cruz FECHA NACIMIENTO =  1983-10-11 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  A- ESTATUS =   FECHA REGISTRO =  2021-02-23 18:31:33 FECHA ACTUALIZACIÓN = ','2024-04-18 13:28:03',_binary ''),(127,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  36 con los siguientes datos:  NOMBRE USUARIO=   Agustin Moreno De la Cruz PASSWORD =  TIPO =  Miembro ESTATUS CONEXIÓN =  Online ULTIMA CONEXIÓN =  2023-04-21 14:42:40','2024-04-18 13:28:03',_binary ''),(128,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  36 con los siguientes datos:  NOMBRE =  Banda elástica para ejercicios de resistencia MARCA =  CardioCharge PRECIO ACTUAL =  100.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:28:03',_binary ''),(129,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  16 con los siguientes datos:  USUARIO ID =   Agustin Moreno De la Cruz PRODUCTO ID =  Banda elástica para ejercicios de resistencia CardioCharge 100.00 TOTAL =  80.00 FECHA REGISTRO =  2024-02-02 13:01:47 ESTATUS =  Activa','2024-04-18 13:28:03',_binary ''),(130,'root@localhost','Create','detalles_pedidos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  6 con los siguientes datos:  PEDIDO ID =  36 80.00 2024-02-02 13:01:47 PRODUCTO ID =  Correa de estiramiento SpeedGrip CANTIDAD =  380 TOTAL PARCIAL =  100.00 FECHA REGISTRO =  2020-02-19 11:38:52 FECHA ENTREGA =  2024-04-18 13:28:03 ESTATUS =  Activa','2024-04-18 13:28:03',_binary ''),(131,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  37 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Iram PRIMER APELLIDO =  Jiménez SEGUNDO APELLIDO =  Cortes FECHA NACIMIENTO =  1965-06-15 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  O- ESTATUS =   FECHA REGISTRO =  2022-04-04 16:12:19 FECHA ACTUALIZACIÓN = ','2024-04-18 13:28:03',_binary ''),(132,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  37 con los siguientes datos:  NOMBRE USUARIO=  Iram Jiménez Cortes PASSWORD =  TIPO =  Instructor ESTATUS CONEXIÓN =  Online ULTIMA CONEXIÓN =  2022-11-19 08:26:32','2024-04-18 13:28:03',_binary ''),(133,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  37 con los siguientes datos:  NOMBRE =  Suplemento pre-entrenamiento MARCA =  PowerHydrate PRECIO ACTUAL =  20.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:28:03',_binary ''),(134,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  17 con los siguientes datos:  USUARIO ID =  Iram Jiménez Cortes PRODUCTO ID =  Suplemento pre-entrenamiento PowerHydrate 20.00 TOTAL =  30.00 FECHA REGISTRO =  2023-05-02 09:24:41 ESTATUS =  Activa','2024-04-18 13:28:03',_binary ''),(135,'root@localhost','Create','detalles_pedidos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  7 con los siguientes datos:  PEDIDO ID =  37 30.00 2023-05-02 09:24:41 PRODUCTO ID =  Correa de estiramiento SpeedGrip CANTIDAD =  380 TOTAL PARCIAL =  100.00 FECHA REGISTRO =  2024-03-25 08:43:20 FECHA ENTREGA =  2024-04-18 13:28:03 ESTATUS =  Activa','2024-04-18 13:28:03',_binary ''),(136,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  38 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Flor PRIMER APELLIDO =  Rodríguez SEGUNDO APELLIDO =  Jiménez FECHA NACIMIENTO =  1970-11-04 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  A- ESTATUS =   FECHA REGISTRO =  2021-09-11 11:45:22 FECHA ACTUALIZACIÓN = ','2024-04-18 13:28:03',_binary ''),(137,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  38 con los siguientes datos:  NOMBRE USUARIO=  Flor Rodríguez Jiménez PASSWORD =  TIPO =  Visitante ESTATUS CONEXIÓN =  Banned ULTIMA CONEXIÓN =  2023-06-17 13:58:03','2024-04-18 13:28:03',_binary ''),(138,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  38 con los siguientes datos:  NOMBRE =  Bebida isotónica MARCA =  SpeedSpike PRECIO ACTUAL =  60.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:28:03',_binary ''),(139,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  18 con los siguientes datos:  USUARIO ID =  Flor Rodríguez Jiménez PRODUCTO ID =  Bebida isotónica SpeedSpike 60.00 TOTAL =  30.00 FECHA REGISTRO =  2022-06-20 10:33:34 ESTATUS =  Activa','2024-04-18 13:28:03',_binary ''),(140,'root@localhost','Create','detalles_pedidos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  8 con los siguientes datos:  PEDIDO ID =  38 30.00 2022-06-20 10:33:34 PRODUCTO ID =  Correa de estiramiento SpeedGrip CANTIDAD =  380 TOTAL PARCIAL =  10.00 FECHA REGISTRO =  2021-06-29 14:08:23 FECHA ENTREGA =  2024-04-18 13:28:03 ESTATUS =  Activa','2024-04-18 13:28:03',_binary ''),(141,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  39 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= José PRIMER APELLIDO =  Gómes SEGUNDO APELLIDO =  Pérez FECHA NACIMIENTO =  2000-04-13 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  O- ESTATUS =   FECHA REGISTRO =  2023-10-27 17:40:35 FECHA ACTUALIZACIÓN = ','2024-04-18 13:28:03',_binary ''),(142,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  39 con los siguientes datos:  NOMBRE USUARIO=  José Gómes Pérez PASSWORD =  TIPO =  Visitante ESTATUS CONEXIÓN =  Offline ULTIMA CONEXIÓN =  2024-04-06 13:03:02','2024-04-18 13:28:03',_binary ''),(143,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  39 con los siguientes datos:  NOMBRE =  Banda de resistencia para estiramientos MARCA =  FlexiBall PRECIO ACTUAL =  90.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:28:03',_binary ''),(144,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  19 con los siguientes datos:  USUARIO ID =  José Gómes Pérez PRODUCTO ID =  Banda de resistencia para estiramientos FlexiBall 90.00 TOTAL =  10.00 FECHA REGISTRO =  2023-04-06 15:51:23 ESTATUS =  Activa','2024-04-18 13:28:03',_binary ''),(145,'root@localhost','Create','detalles_pedidos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  9 con los siguientes datos:  PEDIDO ID =  39 10.00 2023-04-06 15:51:23 PRODUCTO ID =  Correa de estiramiento SpeedGrip CANTIDAD =  60 TOTAL PARCIAL =  10.00 FECHA REGISTRO =  2020-05-30 13:08:41 FECHA ENTREGA =  2024-04-18 13:28:03 ESTATUS =  Activa','2024-04-18 13:28:03',_binary ''),(146,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  40 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Bertha PRIMER APELLIDO =  García SEGUNDO APELLIDO =  Guerrero FECHA NACIMIENTO =  1983-05-24 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  AB- ESTATUS =   FECHA REGISTRO =  2020-08-04 14:14:33 FECHA ACTUALIZACIÓN = ','2024-04-18 13:28:03',_binary ''),(147,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  40 con los siguientes datos:  NOMBRE USUARIO=  Bertha García Guerrero PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Offline ULTIMA CONEXIÓN =  2021-11-05 14:36:52','2024-04-18 13:28:03',_binary ''),(148,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  40 con los siguientes datos:  NOMBRE =  Banda elástica para ejercicios de resistencia MARCA =  CardioCharge PRECIO ACTUAL =  10.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:28:03',_binary ''),(149,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  20 con los siguientes datos:  USUARIO ID =  Bertha García Guerrero PRODUCTO ID =  Banda elástica para ejercicios de resistencia CardioCharge 10.00 TOTAL =  100.00 FECHA REGISTRO =  2022-07-19 10:12:34 ESTATUS =  Activa','2024-04-18 13:28:03',_binary ''),(150,'root@localhost','Create','detalles_pedidos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  10 con los siguientes datos:  PEDIDO ID =  40 100.00 2022-07-19 10:12:34 PRODUCTO ID =  Correa de estiramiento SpeedGrip CANTIDAD =  10 TOTAL PARCIAL =  20.00 FECHA REGISTRO =  2021-08-03 12:27:46 FECHA ENTREGA =  2024-04-18 13:28:03 ESTATUS =  Activa','2024-04-18 13:28:03',_binary ''),(151,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  41 con los siguientes datos:  NOMBRE =  Banda elástica para ejercicios de resistencia MARCA =  FlexiBlock PRECIO ACTUAL =  100.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:28:03',_binary ''),(152,'root@localhost','Create','promociones','Se ha insertado una nueva PROMOCION con el ID:  1 con los siguientes datos:  PRODUCTO ID =  Banda elástica para ejercicios de resistencia FlexiBlock TIPO DE PROMOCION =  complementarios APLICA EN =  Producto ESTATUS =  Activa','2024-04-18 13:28:03',_binary ''),(153,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  42 con los siguientes datos:  NOMBRE =  Banda elástica para ejercicios de resistencia MARCA =  FlexiGrip PRECIO ACTUAL =  100.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:28:03',_binary ''),(154,'root@localhost','Create','promociones','Se ha insertado una nueva PROMOCION con el ID:  2 con los siguientes datos:  PRODUCTO ID =  Banda elástica para ejercicios de resistencia FlexiGrip TIPO DE PROMOCION =  complementarios APLICA EN =  Membresia ESTATUS =  Activa','2024-04-18 13:28:03',_binary ''),(155,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  43 con los siguientes datos:  NOMBRE =  Banda de resistencia para estiramientos MARCA =  FlexiLoop PRECIO ACTUAL =  100.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:28:03',_binary ''),(156,'root@localhost','Create','promociones','Se ha insertado una nueva PROMOCION con el ID:  3 con los siguientes datos:  PRODUCTO ID =  Banda de resistencia para estiramientos FlexiLoop TIPO DE PROMOCION =  membresias APLICA EN =  Membresia ESTATUS =  Activa','2024-04-18 13:28:03',_binary ''),(157,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  44 con los siguientes datos:  NOMBRE =  Correa de estiramiento MARCA =  SpeedMate PRECIO ACTUAL =  90.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:28:03',_binary ''),(158,'root@localhost','Create','promociones','Se ha insertado una nueva PROMOCION con el ID:  4 con los siguientes datos:  PRODUCTO ID =  Correa de estiramiento SpeedMate TIPO DE PROMOCION =  complementarios APLICA EN =  Producto ESTATUS =  Activa','2024-04-18 13:28:03',_binary ''),(159,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  45 con los siguientes datos:  NOMBRE =  Suplemento de creatina MARCA =  FlexiBall PRECIO ACTUAL =  30.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:28:03',_binary ''),(160,'root@localhost','Create','promociones','Se ha insertado una nueva PROMOCION con el ID:  5 con los siguientes datos:  PRODUCTO ID =  Suplemento de creatina FlexiBall TIPO DE PROMOCION =  recompensas APLICA EN =  Membresia ESTATUS =  Activa','2024-04-18 13:28:03',_binary ''),(161,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  46 con los siguientes datos:  NOMBRE =  Suplemento de creatina MARCA =  SpeedGrip PRECIO ACTUAL =  80.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:28:03',_binary ''),(162,'root@localhost','Create','promociones','Se ha insertado una nueva PROMOCION con el ID:  6 con los siguientes datos:  PRODUCTO ID =  Suplemento de creatina SpeedGrip TIPO DE PROMOCION =  recompensas APLICA EN =  Producto ESTATUS =  Activa','2024-04-18 13:28:03',_binary ''),(163,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  47 con los siguientes datos:  NOMBRE =  Bebida isotónica MARCA =  FlexiRoll PRECIO ACTUAL =  30.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:28:03',_binary ''),(164,'root@localhost','Create','promociones','Se ha insertado una nueva PROMOCION con el ID:  7 con los siguientes datos:  PRODUCTO ID =  Bebida isotónica FlexiRoll TIPO DE PROMOCION =  recompensas APLICA EN =  Producto ESTATUS =  Activa','2024-04-18 13:28:03',_binary ''),(165,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  48 con los siguientes datos:  NOMBRE =  Vendas para muñecas y tobillos MARCA =  SpeedWrap PRECIO ACTUAL =  40.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:28:03',_binary ''),(166,'root@localhost','Create','promociones','Se ha insertado una nueva PROMOCION con el ID:  8 con los siguientes datos:  PRODUCTO ID =  Vendas para muñecas y tobillos SpeedWrap TIPO DE PROMOCION =  complementarios APLICA EN =  Producto ESTATUS =  Activa','2024-04-18 13:28:03',_binary ''),(167,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  49 con los siguientes datos:  NOMBRE =  Colchoneta para ejercicios MARCA =  PowerSprint PRECIO ACTUAL =  20.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:28:03',_binary ''),(168,'root@localhost','Create','promociones','Se ha insertado una nueva PROMOCION con el ID:  9 con los siguientes datos:  PRODUCTO ID =  Colchoneta para ejercicios PowerSprint TIPO DE PROMOCION =  recompensas APLICA EN =  Membresia ESTATUS =  Activa','2024-04-18 13:28:03',_binary ''),(169,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  50 con los siguientes datos:  NOMBRE =  Banda de resistencia para estiramientos MARCA =  FlexiSqueeze PRECIO ACTUAL =  100.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:28:03',_binary ''),(170,'root@localhost','Create','promociones','Se ha insertado una nueva PROMOCION con el ID:  10 con los siguientes datos:  PRODUCTO ID =  Banda de resistencia para estiramientos FlexiSqueeze TIPO DE PROMOCION =  recompensas APLICA EN =  Membresia ESTATUS =  Activa','2024-04-18 13:28:03',_binary ''),(171,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  51 con los siguientes datos:  NOMBRE =  Colchoneta para ejercicios MARCA =  FlexiSocks PRECIO ACTUAL =  80.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:28:03',_binary ''),(172,'root@localhost','Create','promociones','Se ha insertado una nueva PROMOCION con el ID:  11 con los siguientes datos:  PRODUCTO ID =  Colchoneta para ejercicios FlexiSocks TIPO DE PROMOCION =  membresias APLICA EN =  Producto ESTATUS =  Activa','2024-04-18 13:28:03',_binary ''),(173,'root@localhost','Create','detalles_promociones','Se ha insertado una nueva PROMOCION con el ID:  1 con los siguientes datos:  PROMOCIONES ID =  membresias FECHA DE INICIO =  2016-05-06 17:48:12 FECHA DE FINALIZACION =  2022-10-18 17:37:35 ESTATUS =  Inactiva','2024-04-18 13:28:03',_binary ''),(174,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  52 con los siguientes datos:  NOMBRE =  Guantes para levantamiento de pesas MARCA =  SpeedMate PRECIO ACTUAL =  30.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:28:03',_binary ''),(175,'root@localhost','Create','promociones','Se ha insertado una nueva PROMOCION con el ID:  12 con los siguientes datos:  PRODUCTO ID =  Guantes para levantamiento de pesas SpeedMate TIPO DE PROMOCION =  complementarios APLICA EN =  Producto ESTATUS =  Activa','2024-04-18 13:28:03',_binary ''),(176,'root@localhost','Create','detalles_promociones','Se ha insertado una nueva PROMOCION con el ID:  2 con los siguientes datos:  PROMOCIONES ID =  complementarios FECHA DE INICIO =  2023-09-15 18:42:54 FECHA DE FINALIZACION =  2022-10-27 15:13:40 ESTATUS =  Inactiva','2024-04-18 13:28:03',_binary ''),(177,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  53 con los siguientes datos:  NOMBRE =  Batidos de proteínas MARCA =  FlexiFoam PRECIO ACTUAL =  100.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:28:03',_binary ''),(178,'root@localhost','Create','promociones','Se ha insertado una nueva PROMOCION con el ID:  13 con los siguientes datos:  PRODUCTO ID =  Batidos de proteínas FlexiFoam TIPO DE PROMOCION =  personalizado APLICA EN =  Producto ESTATUS =  Activa','2024-04-18 13:28:03',_binary ''),(179,'root@localhost','Create','detalles_promociones','Se ha insertado una nueva PROMOCION con el ID:  3 con los siguientes datos:  PROMOCIONES ID =  personalizado FECHA DE INICIO =  2019-10-09 18:27:49 FECHA DE FINALIZACION =  2023-07-12 13:50:37 ESTATUS =  Inactiva','2024-04-18 13:28:03',_binary ''),(180,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  54 con los siguientes datos:  NOMBRE =  Cinturón de levantamiento de pesas MARCA =  FlexiFoam PRECIO ACTUAL =  20.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:28:03',_binary ''),(181,'root@localhost','Create','promociones','Se ha insertado una nueva PROMOCION con el ID:  14 con los siguientes datos:  PRODUCTO ID =  Cinturón de levantamiento de pesas FlexiFoam TIPO DE PROMOCION =  personalizado APLICA EN =  Membresia ESTATUS =  Activa','2024-04-18 13:28:03',_binary ''),(182,'root@localhost','Create','detalles_promociones','Se ha insertado una nueva PROMOCION con el ID:  4 con los siguientes datos:  PROMOCIONES ID =  personalizado FECHA DE INICIO =  2016-05-23 09:19:04 FECHA DE FINALIZACION =  2020-06-06 10:03:17 ESTATUS =  Inactiva','2024-04-18 13:28:03',_binary ''),(183,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  55 con los siguientes datos:  NOMBRE =  Rodillo de espuma para masaje muscular MARCA =  PowerBurn PRECIO ACTUAL =  70.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:28:03',_binary ''),(184,'root@localhost','Create','promociones','Se ha insertado una nueva PROMOCION con el ID:  15 con los siguientes datos:  PRODUCTO ID =  Rodillo de espuma para masaje muscular PowerBurn TIPO DE PROMOCION =  personalizado APLICA EN =  Membresia ESTATUS =  Activa','2024-04-18 13:28:03',_binary ''),(185,'root@localhost','Create','detalles_promociones','Se ha insertado una nueva PROMOCION con el ID:  5 con los siguientes datos:  PROMOCIONES ID =  personalizado FECHA DE INICIO =  2015-01-26 14:31:24 FECHA DE FINALIZACION =  2022-12-27 18:08:47 ESTATUS =  Inactiva','2024-04-18 13:28:03',_binary ''),(186,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  56 con los siguientes datos:  NOMBRE =  Bebida energética pre-entrenamiento MARCA =  FlexiLoop PRECIO ACTUAL =  50.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:28:03',_binary ''),(187,'root@localhost','Create','promociones','Se ha insertado una nueva PROMOCION con el ID:  16 con los siguientes datos:  PRODUCTO ID =  Bebida energética pre-entrenamiento FlexiLoop TIPO DE PROMOCION =  complementarios APLICA EN =  Membresia ESTATUS =  Activa','2024-04-18 13:28:03',_binary ''),(188,'root@localhost','Create','detalles_promociones','Se ha insertado una nueva PROMOCION con el ID:  6 con los siguientes datos:  PROMOCIONES ID =  complementarios FECHA DE INICIO =  2017-07-15 10:13:37 FECHA DE FINALIZACION =  2020-06-20 19:51:51 ESTATUS =  Inactiva','2024-04-18 13:28:03',_binary ''),(189,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  57 con los siguientes datos:  NOMBRE =  Magnesio para mejorar el agarre MARCA =  PowerFuel PRECIO ACTUAL =  80.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:28:03',_binary ''),(190,'root@localhost','Create','promociones','Se ha insertado una nueva PROMOCION con el ID:  17 con los siguientes datos:  PRODUCTO ID =  Magnesio para mejorar el agarre PowerFuel TIPO DE PROMOCION =  personalizado APLICA EN =  Membresia ESTATUS =  Activa','2024-04-18 13:28:03',_binary ''),(191,'root@localhost','Create','detalles_promociones','Se ha insertado una nueva PROMOCION con el ID:  7 con los siguientes datos:  PROMOCIONES ID =  personalizado FECHA DE INICIO =  2018-10-16 11:20:22 FECHA DE FINALIZACION =  2020-09-21 08:04:51 ESTATUS =  Inactiva','2024-04-18 13:28:03',_binary ''),(192,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  58 con los siguientes datos:  NOMBRE =  Correa de estiramiento MARCA =  FlexiBlock PRECIO ACTUAL =  60.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:28:03',_binary ''),(193,'root@localhost','Create','promociones','Se ha insertado una nueva PROMOCION con el ID:  18 con los siguientes datos:  PRODUCTO ID =  Correa de estiramiento FlexiBlock TIPO DE PROMOCION =  recompensas APLICA EN =  Membresia ESTATUS =  Activa','2024-04-18 13:28:03',_binary ''),(194,'root@localhost','Create','detalles_promociones','Se ha insertado una nueva PROMOCION con el ID:  8 con los siguientes datos:  PROMOCIONES ID =  recompensas FECHA DE INICIO =  2018-08-17 18:43:53 FECHA DE FINALIZACION =  2021-04-18 17:54:35 ESTATUS =  Inactiva','2024-04-18 13:28:03',_binary ''),(195,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  59 con los siguientes datos:  NOMBRE =  Barritas energéticas MARCA =  SpeedJump PRECIO ACTUAL =  60.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:28:03',_binary ''),(196,'root@localhost','Create','promociones','Se ha insertado una nueva PROMOCION con el ID:  19 con los siguientes datos:  PRODUCTO ID =  Barritas energéticas SpeedJump TIPO DE PROMOCION =  recompensas APLICA EN =  Membresia ESTATUS =  Activa','2024-04-18 13:28:03',_binary ''),(197,'root@localhost','Create','detalles_promociones','Se ha insertado una nueva PROMOCION con el ID:  9 con los siguientes datos:  PROMOCIONES ID =  recompensas FECHA DE INICIO =  2021-09-05 19:51:05 FECHA DE FINALIZACION =  2023-05-14 19:25:39 ESTATUS =  Inactiva','2024-04-18 13:28:03',_binary ''),(198,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  60 con los siguientes datos:  NOMBRE =  Banda de resistencia para entrenamiento MARCA =  FlexiStrap PRECIO ACTUAL =  80.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:28:03',_binary ''),(199,'root@localhost','Create','promociones','Se ha insertado una nueva PROMOCION con el ID:  20 con los siguientes datos:  PRODUCTO ID =  Banda de resistencia para entrenamiento FlexiStrap TIPO DE PROMOCION =  personalizado APLICA EN =  Membresia ESTATUS =  Activa','2024-04-18 13:28:03',_binary ''),(200,'root@localhost','Create','detalles_promociones','Se ha insertado una nueva PROMOCION con el ID:  10 con los siguientes datos:  PROMOCIONES ID =  personalizado FECHA DE INICIO =  2018-03-13 19:06:45 FECHA DE FINALIZACION =  2022-07-29 10:36:26 ESTATUS =  Inactiva','2024-04-18 13:28:03',_binary ''),(201,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  41 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Luz PRIMER APELLIDO =  Rodríguez SEGUNDO APELLIDO =  Torres FECHA NACIMIENTO =  1974-02-23 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  AB+ ESTATUS =   FECHA REGISTRO =  2022-07-30 13:55:16 FECHA ACTUALIZACIÓN = ','2024-04-18 13:34:15',_binary ''),(202,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  42 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Karla PRIMER APELLIDO =  Ortega SEGUNDO APELLIDO =  Romero FECHA NACIMIENTO =  2004-10-23 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  A+ ESTATUS =   FECHA REGISTRO =  2023-04-04 13:31:57 FECHA ACTUALIZACIÓN = ','2024-04-18 13:34:15',_binary ''),(203,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  43 con los siguientes datos:  TITULO CORTESIA =  C.P. NOMBRE= Paola PRIMER APELLIDO =  Hernández SEGUNDO APELLIDO =  Bautista FECHA NACIMIENTO =  1997-11-03 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  A+ ESTATUS =   FECHA REGISTRO =  2024-01-01 13:44:38 FECHA ACTUALIZACIÓN = ','2024-04-18 13:34:15',_binary ''),(204,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  44 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Maria PRIMER APELLIDO =  Méndez SEGUNDO APELLIDO =  Juárez FECHA NACIMIENTO =  1979-08-06 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  A- ESTATUS =   FECHA REGISTRO =  2023-09-26 16:08:33 FECHA ACTUALIZACIÓN = ','2024-04-18 13:34:15',_binary ''),(205,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  45 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Luz PRIMER APELLIDO =  Contreras SEGUNDO APELLIDO =  De la Cruz FECHA NACIMIENTO =  1983-08-11 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  A+ ESTATUS =   FECHA REGISTRO =  2020-05-05 08:42:43 FECHA ACTUALIZACIÓN = ','2024-04-18 13:34:15',_binary ''),(206,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  46 con los siguientes datos:  TITULO CORTESIA =  Mtro. NOMBRE= Mario PRIMER APELLIDO =  Pérez SEGUNDO APELLIDO =  Reyes FECHA NACIMIENTO =  1964-04-05 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  AB- ESTATUS =   FECHA REGISTRO =  2023-09-21 13:07:36 FECHA ACTUALIZACIÓN = ','2024-04-18 13:34:15',_binary ''),(207,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  47 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Jesus PRIMER APELLIDO =  Cortés SEGUNDO APELLIDO =  Álvarez FECHA NACIMIENTO =  1995-06-21 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  A+ ESTATUS =   FECHA REGISTRO =  2021-04-03 09:51:36 FECHA ACTUALIZACIÓN = ','2024-04-18 13:34:15',_binary ''),(208,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  48 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Jesus PRIMER APELLIDO =  Morales SEGUNDO APELLIDO =  De la Cruz FECHA NACIMIENTO =  1972-06-05 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  O- ESTATUS =   FECHA REGISTRO =  2023-12-28 17:37:58 FECHA ACTUALIZACIÓN = ','2024-04-18 13:34:15',_binary ''),(209,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  49 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Esmeralda PRIMER APELLIDO =  Castro SEGUNDO APELLIDO =  Juárez FECHA NACIMIENTO =  2005-06-15 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  O+ ESTATUS =   FECHA REGISTRO =  2022-01-27 17:55:55 FECHA ACTUALIZACIÓN = ','2024-04-18 13:34:15',_binary ''),(210,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  50 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Flor PRIMER APELLIDO =  Soto SEGUNDO APELLIDO =   Rivera FECHA NACIMIENTO =  2006-04-12 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  A+ ESTATUS =   FECHA REGISTRO =  2021-07-25 16:07:13 FECHA ACTUALIZACIÓN = ','2024-04-18 13:34:15',_binary ''),(211,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  51 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Gustavo PRIMER APELLIDO =  Cortés SEGUNDO APELLIDO =   González FECHA NACIMIENTO =  1984-12-03 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  B+ ESTATUS =   FECHA REGISTRO =  2021-01-27 09:54:48 FECHA ACTUALIZACIÓN = ','2024-04-18 13:34:15',_binary ''),(212,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  51 con los siguientes datos:  NOMBRE USUARIO=  Gustavo Cortés  González PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Online ULTIMA CONEXIÓN =  2023-07-05 15:37:56','2024-04-18 13:34:15',_binary ''),(213,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  52 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Guadalupe PRIMER APELLIDO =  Santiago SEGUNDO APELLIDO =  Castro FECHA NACIMIENTO =  2004-01-07 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  B- ESTATUS =   FECHA REGISTRO =  2021-06-20 13:31:14 FECHA ACTUALIZACIÓN = ','2024-04-18 13:34:15',_binary ''),(214,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  52 con los siguientes datos:  NOMBRE USUARIO=  Guadalupe Santiago Castro PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Online ULTIMA CONEXIÓN =  2022-03-31 19:58:27','2024-04-18 13:34:15',_binary ''),(215,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  53 con los siguientes datos:  TITULO CORTESIA =  Lic. NOMBRE= Guadalupe PRIMER APELLIDO =  López SEGUNDO APELLIDO =  Ramos FECHA NACIMIENTO =  2006-11-12 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  O- ESTATUS =   FECHA REGISTRO =  2023-04-14 08:10:44 FECHA ACTUALIZACIÓN = ','2024-04-18 13:34:15',_binary ''),(216,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  53 con los siguientes datos:  NOMBRE USUARIO=  Lic. Guadalupe López Ramos PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Online ULTIMA CONEXIÓN =  2024-01-29 18:23:23','2024-04-18 13:34:15',_binary ''),(217,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  54 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Aldair PRIMER APELLIDO =  Cortes SEGUNDO APELLIDO =  Ramírez FECHA NACIMIENTO =  1971-08-08 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  AB- ESTATUS =   FECHA REGISTRO =  2023-07-28 08:03:35 FECHA ACTUALIZACIÓN = ','2024-04-18 13:34:15',_binary ''),(218,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  54 con los siguientes datos:  NOMBRE USUARIO=  Aldair Cortes Ramírez PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Online ULTIMA CONEXIÓN =  2023-12-16 15:42:28','2024-04-18 13:34:15',_binary ''),(219,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  55 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Samuel PRIMER APELLIDO =  Morales SEGUNDO APELLIDO =  Ruíz FECHA NACIMIENTO =  1970-11-07 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  O- ESTATUS =   FECHA REGISTRO =  2021-02-26 12:18:39 FECHA ACTUALIZACIÓN = ','2024-04-18 13:34:15',_binary ''),(220,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  55 con los siguientes datos:  NOMBRE USUARIO=  Samuel Morales Ruíz PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Online ULTIMA CONEXIÓN =  2024-04-06 18:24:55','2024-04-18 13:34:15',_binary ''),(221,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  56 con los siguientes datos:  TITULO CORTESIA =  NOMBRE=  Agustin PRIMER APELLIDO =   González SEGUNDO APELLIDO =  Estrada FECHA NACIMIENTO =  1976-07-20 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  O- ESTATUS =   FECHA REGISTRO =  2023-11-12 14:16:10 FECHA ACTUALIZACIÓN = ','2024-04-18 13:34:15',_binary ''),(222,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  56 con los siguientes datos:  NOMBRE USUARIO=   Agustin  González Estrada PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Online ULTIMA CONEXIÓN =  2024-04-05 08:04:31','2024-04-18 13:34:15',_binary ''),(223,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  57 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Ricardo PRIMER APELLIDO =  Ortega SEGUNDO APELLIDO =  Medina FECHA NACIMIENTO =  1998-06-09 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  O- ESTATUS =   FECHA REGISTRO =  2021-06-10 18:03:12 FECHA ACTUALIZACIÓN = ','2024-04-18 13:34:15',_binary ''),(224,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  57 con los siguientes datos:  NOMBRE USUARIO=  Ricardo Ortega Medina PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Online ULTIMA CONEXIÓN =  2021-12-17 12:48:41','2024-04-18 13:34:15',_binary ''),(225,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  58 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Marco PRIMER APELLIDO =  Ortega SEGUNDO APELLIDO =  Jiménez FECHA NACIMIENTO =  2004-10-02 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  AB- ESTATUS =   FECHA REGISTRO =  2023-03-21 15:29:32 FECHA ACTUALIZACIÓN = ','2024-04-18 13:34:15',_binary ''),(226,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  58 con los siguientes datos:  NOMBRE USUARIO=  Marco Ortega Jiménez PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Online ULTIMA CONEXIÓN =  2024-02-29 14:04:00','2024-04-18 13:34:15',_binary ''),(227,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  59 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Ameli PRIMER APELLIDO =  Cruz SEGUNDO APELLIDO =  Reyes FECHA NACIMIENTO =  2000-08-04 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  B+ ESTATUS =   FECHA REGISTRO =  2021-01-26 10:08:54 FECHA ACTUALIZACIÓN = ','2024-04-18 13:34:15',_binary ''),(228,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  59 con los siguientes datos:  NOMBRE USUARIO=  Ameli Cruz Reyes PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Online ULTIMA CONEXIÓN =  2021-07-19 10:25:40','2024-04-18 13:34:15',_binary ''),(229,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  60 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Jesus PRIMER APELLIDO =  Juárez SEGUNDO APELLIDO =  Domínguez FECHA NACIMIENTO =  1980-07-28 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  A- ESTATUS =   FECHA REGISTRO =  2023-05-22 11:25:33 FECHA ACTUALIZACIÓN = ','2024-04-18 13:34:15',_binary ''),(230,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  60 con los siguientes datos:  NOMBRE USUARIO=  Jesus Juárez Domínguez PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Online ULTIMA CONEXIÓN =  2023-06-12 13:31:57','2024-04-18 13:34:15',_binary ''),(231,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  61 con los siguientes datos:  NOMBRE =  Bebida energética pre-entrenamiento MARCA =  PowerHydrate PRECIO ACTUAL =  70.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:34:15',_binary ''),(232,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  62 con los siguientes datos:  NOMBRE =  Bebida isotónica MARCA =  SpeedStep PRECIO ACTUAL =  30.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:34:15',_binary ''),(233,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  63 con los siguientes datos:  NOMBRE =  Rodillo de espuma para masaje muscular MARCA =  PowerHydrate PRECIO ACTUAL =  20.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:34:15',_binary ''),(234,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  64 con los siguientes datos:  NOMBRE =  Esterilla de yoga MARCA =  PowerPulse PRECIO ACTUAL =  40.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:34:15',_binary ''),(235,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  65 con los siguientes datos:  NOMBRE =  Guantes para levantamiento de pesas MARCA =  FlexiStrap PRECIO ACTUAL =  90.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:34:15',_binary ''),(236,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  66 con los siguientes datos:  NOMBRE =  Bebida isotónica MARCA =  PowerLift PRECIO ACTUAL =  90.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:34:15',_binary ''),(237,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  67 con los siguientes datos:  NOMBRE =  Vendas para muñecas y tobillos MARCA =  FlexiGel PRECIO ACTUAL =  60.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:34:15',_binary ''),(238,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  68 con los siguientes datos:  NOMBRE =  Esterilla de yoga MARCA =  FlexiGrip PRECIO ACTUAL =  10.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:34:15',_binary ''),(239,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  69 con los siguientes datos:  NOMBRE =  Bebida energética pre-entrenamiento MARCA =  SpeedWrap PRECIO ACTUAL =  90.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:34:15',_binary ''),(240,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  70 con los siguientes datos:  NOMBRE =  Batidos de proteínas MARCA =  FlexiWheel PRECIO ACTUAL =  40.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:34:15',_binary ''),(241,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  71 con los siguientes datos:  NOMBRE =  Bebida energética pre-entrenamiento MARCA =  PowerCord PRECIO ACTUAL =  80.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:34:15',_binary ''),(242,'root@localhost','Create','detalles_productos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  11 con los siguientes datos:  PRODUCTO ID =  Bebida energética pre-entrenamiento PowerCord DESCRIPCION =  Accesorios que protegen las manos de callosidades y proporcionan un mejor agarre durante el levantamiento de pesas y otros ejercicios de fuerza. CODIGO DE BARRAS =  105389073 PRESENTACION =  Xtend BCAA Powder ESTATUS =  Activa','2024-04-18 13:34:15',_binary ''),(243,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  72 con los siguientes datos:  NOMBRE =  Rodillo de espuma para masaje muscular MARCA =  PowerStim PRECIO ACTUAL =  20.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:34:15',_binary ''),(244,'root@localhost','Create','detalles_productos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  12 con los siguientes datos:  PRODUCTO ID =  Rodillo de espuma para masaje muscular PowerStim DESCRIPCION =  Accesorios que protegen las manos de callosidades y proporcionan un mejor agarre durante el levantamiento de pesas y otros ejercicios de fuerza. CODIGO DE BARRAS =  123457354 PRESENTACION =   Optimum Nutrition Creatine Monohydrate ESTATUS =  Activa','2024-04-18 13:34:15',_binary ''),(245,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  73 con los siguientes datos:  NOMBRE =  Vendas para muñecas y tobillos MARCA =  PowerLift PRECIO ACTUAL =  50.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:34:15',_binary ''),(246,'root@localhost','Create','detalles_productos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  13 con los siguientes datos:  PRODUCTO ID =  Vendas para muñecas y tobillos PowerLift DESCRIPCION =  Accesorios que protegen las manos de callosidades y proporcionan un mejor agarre durante el levantamiento de pesas y otros ejercicios de fuerza. CODIGO DE BARRAS =  105389073 PRESENTACION =  Xtend BCAA Powder ESTATUS =  Activa','2024-04-18 13:34:15',_binary ''),(247,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  74 con los siguientes datos:  NOMBRE =  Bebida isotónica MARCA =  FlexiFoam PRECIO ACTUAL =  80.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:34:15',_binary ''),(248,'root@localhost','Create','detalles_productos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  14 con los siguientes datos:  PRODUCTO ID =  Bebida isotónica FlexiFoam DESCRIPCION =  Suplemento utilizado para aumentar la fuerza, la potencia y ​​la masa muscular, al mejorar la disponibilidad de energía en los músculos durante el ejercicio de alta intensidad. CODIGO DE BARRAS =  123457354 PRESENTACION =  Quest Nutrition Protein Bar ESTATUS =  Activa','2024-04-18 13:34:15',_binary ''),(249,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  75 con los siguientes datos:  NOMBRE =  Banda elástica para ejercicios de resistencia MARCA =  FlexiBlock PRECIO ACTUAL =  100.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:34:15',_binary ''),(250,'root@localhost','Create','detalles_productos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  15 con los siguientes datos:  PRODUCTO ID =  Banda elástica para ejercicios de resistencia FlexiBlock DESCRIPCION =  Botellas diseñadas para mezclar fácilmente proteína en polvo con agua o leche, convenientes para consumir bebidas nutritivas antes o después del entrenamiento. CODIGO DE BARRAS =  123457354 PRESENTACION =  Nordic Naturals Ultimate Omega ESTATUS =  Activa','2024-04-18 13:34:15',_binary ''),(251,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  76 con los siguientes datos:  NOMBRE =  Bebida energética post-entrenamiento MARCA =  MuscleEase PRECIO ACTUAL =  50.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:34:15',_binary ''),(252,'root@localhost','Create','detalles_productos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  16 con los siguientes datos:  PRODUCTO ID =  Bebida energética post-entrenamiento MuscleEase DESCRIPCION =  Snacks convenientes y portátiles que proporcionan una fuente rápida de proteínas y carbohidratos, ideales para consumir antes o después del entrenamiento para apoyar la recuperación muscular. CODIGO DE BARRAS =  123457354 PRESENTACION =  Xtend BCAA Powder ESTATUS =  Activa','2024-04-18 13:34:15',_binary ''),(253,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  77 con los siguientes datos:  NOMBRE =  Banda de resistencia para entrenamiento MARCA =  PowerFuel PRECIO ACTUAL =  40.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:34:15',_binary ''),(254,'root@localhost','Create','detalles_productos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  17 con los siguientes datos:  PRODUCTO ID =  Banda de resistencia para entrenamiento PowerFuel DESCRIPCION =  Suplemento utilizado para aumentar la fuerza, la potencia y ​​la masa muscular, al mejorar la disponibilidad de energía en los músculos durante el ejercicio de alta intensidad. CODIGO DE BARRAS =  123457354 PRESENTACION =  C4 Original Pre-Workout) ESTATUS =  Activa','2024-04-18 13:34:15',_binary ''),(255,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  78 con los siguientes datos:  NOMBRE =  Magnesio para mejorar el agarre MARCA =  PowerBurn PRECIO ACTUAL =  50.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:34:15',_binary ''),(256,'root@localhost','Create','detalles_productos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  18 con los siguientes datos:  PRODUCTO ID =  Magnesio para mejorar el agarre PowerBurn DESCRIPCION =  Suplementos que contienen una variedad de vitaminas y minerales esenciales para apoyar la salud general, el metabolismo y la función muscular durante el ejercicio intenso. CODIGO DE BARRAS =  450578976 PRESENTACION =  Xtend BCAA Powder ESTATUS =  Activa','2024-04-18 13:34:15',_binary ''),(257,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  79 con los siguientes datos:  NOMBRE =  Vendas para muñecas y tobillos MARCA =  FlexiStrap PRECIO ACTUAL =  40.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:34:15',_binary ''),(258,'root@localhost','Create','detalles_productos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  19 con los siguientes datos:  PRODUCTO ID =  Vendas para muñecas y tobillos FlexiStrap DESCRIPCION =  Suplemento que contiene los aminoácidos esenciales leucina, isoleucina y valina, que ayudan a promover la recuperación muscular, reducir la fatiga y preservar la masa muscular durante el ejercicio. CODIGO DE BARRAS =  385987635 PRESENTACION =  Xtend BCAA Powder ESTATUS =  Activa','2024-04-18 13:34:15',_binary ''),(259,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  80 con los siguientes datos:  NOMBRE =  Suplemento pre-entrenamiento MARCA =  FlexiBand PRECIO ACTUAL =  80.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:34:15',_binary ''),(260,'root@localhost','Create','detalles_productos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  20 con los siguientes datos:  PRODUCTO ID =  Suplemento pre-entrenamiento FlexiBand DESCRIPCION =  Suplemento que contiene ácidos grasos esenciales omega-3, conocidos por sus efectos antiinflamatorios y beneficios para la salud cardiovascular y articular. CODIGO DE BARRAS =  385987635 PRESENTACION =  Proteína Whey Gold Standard ESTATUS =  Activa','2024-04-18 13:34:15',_binary ''),(261,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  61 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Monica PRIMER APELLIDO =  Vargas SEGUNDO APELLIDO =  Vargas FECHA NACIMIENTO =  1982-11-23 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  A- ESTATUS =   FECHA REGISTRO =  2022-04-05 08:33:10 FECHA ACTUALIZACIÓN = ','2024-04-18 13:34:15',_binary ''),(262,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  61 con los siguientes datos:  NOMBRE USUARIO=  Monica Vargas Vargas PASSWORD =  TIPO =  Miembro ESTATUS CONEXIÓN =  Online ULTIMA CONEXIÓN =  2023-08-26 08:21:29','2024-04-18 13:34:15',_binary ''),(263,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  81 con los siguientes datos:  NOMBRE =  Guantes para levantamiento de pesas MARCA =  FlexiFoam PRECIO ACTUAL =  80.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:34:15',_binary ''),(264,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  21 con los siguientes datos:  USUARIO ID =  Monica Vargas Vargas PRODUCTO ID =  Guantes para levantamiento de pesas FlexiFoam 80.00 TOTAL =  60.00 FECHA REGISTRO =  2021-03-17 18:43:27 ESTATUS =  Activa','2024-04-18 13:34:15',_binary ''),(265,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  62 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Hugo PRIMER APELLIDO =  Mendoza SEGUNDO APELLIDO =  Cortés FECHA NACIMIENTO =  1989-04-10 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  A- ESTATUS =   FECHA REGISTRO =  2020-01-29 14:56:53 FECHA ACTUALIZACIÓN = ','2024-04-18 13:34:15',_binary ''),(266,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  62 con los siguientes datos:  NOMBRE USUARIO=  Hugo Mendoza Cortés PASSWORD =  TIPO =  Instructor ESTATUS CONEXIÓN =  Offline ULTIMA CONEXIÓN =  2023-06-20 15:26:45','2024-04-18 13:34:15',_binary ''),(267,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  82 con los siguientes datos:  NOMBRE =  Termogénico para quemar grasa MARCA =  PowerCord PRECIO ACTUAL =  100.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:34:15',_binary ''),(268,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  22 con los siguientes datos:  USUARIO ID =  Hugo Mendoza Cortés PRODUCTO ID =  Termogénico para quemar grasa PowerCord 100.00 TOTAL =  100.00 FECHA REGISTRO =  2023-07-07 11:25:53 ESTATUS =  Activa','2024-04-18 13:34:15',_binary ''),(269,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  63 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Ricardo PRIMER APELLIDO =  Soto SEGUNDO APELLIDO =  Vázquez FECHA NACIMIENTO =  1979-02-16 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  A- ESTATUS =   FECHA REGISTRO =  2023-08-23 15:11:50 FECHA ACTUALIZACIÓN = ','2024-04-18 13:34:15',_binary ''),(270,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  63 con los siguientes datos:  NOMBRE USUARIO=  Ricardo Soto Vázquez PASSWORD =  TIPO =  Visitante ESTATUS CONEXIÓN =  Offline ULTIMA CONEXIÓN =  2023-09-05 17:49:44','2024-04-18 13:34:15',_binary ''),(271,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  83 con los siguientes datos:  NOMBRE =  Vendas para muñecas y tobillos MARCA =  PowerHydrate PRECIO ACTUAL =  20.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:34:15',_binary ''),(272,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  23 con los siguientes datos:  USUARIO ID =  Ricardo Soto Vázquez PRODUCTO ID =  Vendas para muñecas y tobillos PowerHydrate 20.00 TOTAL =  40.00 FECHA REGISTRO =  2021-02-03 10:05:53 ESTATUS =  Activa','2024-04-18 13:34:15',_binary ''),(273,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  64 con los siguientes datos:  TITULO CORTESIA =  C. NOMBRE= Juan PRIMER APELLIDO =  Castro SEGUNDO APELLIDO =  Moreno FECHA NACIMIENTO =  1969-12-10 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  AB- ESTATUS =   FECHA REGISTRO =  2022-10-27 11:34:15 FECHA ACTUALIZACIÓN = ','2024-04-18 13:34:15',_binary ''),(274,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  64 con los siguientes datos:  NOMBRE USUARIO=  C. Juan Castro Moreno PASSWORD =  TIPO =  Miembro ESTATUS CONEXIÓN =  Banned ULTIMA CONEXIÓN =  2024-03-17 15:12:08','2024-04-18 13:34:15',_binary ''),(275,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  84 con los siguientes datos:  NOMBRE =  Suplemento de creatina MARCA =  PowerFuel PRECIO ACTUAL =  10.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:34:15',_binary ''),(276,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  24 con los siguientes datos:  USUARIO ID =  C. Juan Castro Moreno PRODUCTO ID =  Suplemento de creatina PowerFuel 10.00 TOTAL =  80.00 FECHA REGISTRO =  2023-03-28 13:43:47 ESTATUS =  Activa','2024-04-18 13:34:15',_binary ''),(277,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  65 con los siguientes datos:  TITULO CORTESIA =  Sgto. NOMBRE= Adan PRIMER APELLIDO =  Luna SEGUNDO APELLIDO =  Ramos FECHA NACIMIENTO =  1989-01-02 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  A+ ESTATUS =   FECHA REGISTRO =  2023-06-15 15:43:47 FECHA ACTUALIZACIÓN = ','2024-04-18 13:34:15',_binary ''),(278,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  65 con los siguientes datos:  NOMBRE USUARIO=  Sgto. Adan Luna Ramos PASSWORD =  TIPO =  Instructor ESTATUS CONEXIÓN =  Online ULTIMA CONEXIÓN =  2023-08-03 13:23:31','2024-04-18 13:34:15',_binary ''),(279,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  85 con los siguientes datos:  NOMBRE =  Colchoneta para ejercicios MARCA =  FlexiWheel PRECIO ACTUAL =  10.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:34:15',_binary ''),(280,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  25 con los siguientes datos:  USUARIO ID =  Sgto. Adan Luna Ramos PRODUCTO ID =  Colchoneta para ejercicios FlexiWheel 10.00 TOTAL =  100.00 FECHA REGISTRO =  2022-03-12 16:34:56 ESTATUS =  Activa','2024-04-18 13:34:15',_binary ''),(281,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  66 con los siguientes datos:  TITULO CORTESIA =  Joven NOMBRE= Daniel PRIMER APELLIDO =  Cruz SEGUNDO APELLIDO =  Hernández FECHA NACIMIENTO =  1984-05-23 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  AB+ ESTATUS =   FECHA REGISTRO =  2024-03-27 12:58:00 FECHA ACTUALIZACIÓN = ','2024-04-18 13:34:15',_binary ''),(282,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  66 con los siguientes datos:  NOMBRE USUARIO=  Joven Daniel Cruz Hernández PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Online ULTIMA CONEXIÓN =  2024-04-02 13:16:13','2024-04-18 13:34:15',_binary ''),(283,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  86 con los siguientes datos:  NOMBRE =  Banda de resistencia para estiramientos MARCA =  SpeedWrap PRECIO ACTUAL =  10.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:34:15',_binary ''),(284,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  26 con los siguientes datos:  USUARIO ID =  Joven Daniel Cruz Hernández PRODUCTO ID =  Banda de resistencia para estiramientos SpeedWrap 10.00 TOTAL =  20.00 FECHA REGISTRO =  2021-08-22 14:25:19 ESTATUS =  Activa','2024-04-18 13:34:15',_binary ''),(285,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  67 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= José PRIMER APELLIDO =  Rodríguez SEGUNDO APELLIDO =  Herrera FECHA NACIMIENTO =  1959-08-09 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  O- ESTATUS =   FECHA REGISTRO =  2024-02-13 17:38:44 FECHA ACTUALIZACIÓN = ','2024-04-18 13:34:15',_binary ''),(286,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  67 con los siguientes datos:  NOMBRE USUARIO=  José Rodríguez Herrera PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Online ULTIMA CONEXIÓN =  2024-02-21 16:44:05','2024-04-18 13:34:15',_binary ''),(287,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  87 con los siguientes datos:  NOMBRE =  Barritas energéticas MARCA =  PowerProtein PRECIO ACTUAL =  40.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:34:15',_binary ''),(288,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  27 con los siguientes datos:  USUARIO ID =  José Rodríguez Herrera PRODUCTO ID =  Barritas energéticas PowerProtein 40.00 TOTAL =  60.00 FECHA REGISTRO =  2023-10-05 16:09:51 ESTATUS =  Activa','2024-04-18 13:34:15',_binary ''),(289,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  68 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Sofia PRIMER APELLIDO =  Ortega SEGUNDO APELLIDO =  Medina FECHA NACIMIENTO =  2003-05-04 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  B- ESTATUS =   FECHA REGISTRO =  2021-03-06 10:16:19 FECHA ACTUALIZACIÓN = ','2024-04-18 13:34:15',_binary ''),(290,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  68 con los siguientes datos:  NOMBRE USUARIO=  Sofia Ortega Medina PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Online ULTIMA CONEXIÓN =  2023-12-04 11:00:02','2024-04-18 13:34:15',_binary ''),(291,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  88 con los siguientes datos:  NOMBRE =  Magnesio para mejorar el agarre MARCA =  FlexiBand PRECIO ACTUAL =  70.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:34:15',_binary ''),(292,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  28 con los siguientes datos:  USUARIO ID =  Sofia Ortega Medina PRODUCTO ID =  Magnesio para mejorar el agarre FlexiBand 70.00 TOTAL =  50.00 FECHA REGISTRO =  2020-08-22 13:31:55 ESTATUS =  Activa','2024-04-18 13:34:15',_binary ''),(293,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  69 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Valeria PRIMER APELLIDO =  Guerrero SEGUNDO APELLIDO =  Contreras FECHA NACIMIENTO =  1973-04-07 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  A+ ESTATUS =   FECHA REGISTRO =  2020-10-26 19:06:59 FECHA ACTUALIZACIÓN = ','2024-04-18 13:34:15',_binary ''),(294,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  69 con los siguientes datos:  NOMBRE USUARIO=  Valeria Guerrero Contreras PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Offline ULTIMA CONEXIÓN =  2022-03-31 13:59:53','2024-04-18 13:34:15',_binary ''),(295,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  89 con los siguientes datos:  NOMBRE =  Suplemento pre-entrenamiento MARCA =  MuscleFlex PRECIO ACTUAL =  40.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:34:15',_binary ''),(296,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  29 con los siguientes datos:  USUARIO ID =  Valeria Guerrero Contreras PRODUCTO ID =  Suplemento pre-entrenamiento MuscleFlex 40.00 TOTAL =  50.00 FECHA REGISTRO =  2023-12-19 12:23:25 ESTATUS =  Activa','2024-04-18 13:34:15',_binary ''),(297,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  70 con los siguientes datos:  TITULO CORTESIA =  C. NOMBRE= José PRIMER APELLIDO =  Herrera SEGUNDO APELLIDO =  Mendoza FECHA NACIMIENTO =  1960-07-11 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  O- ESTATUS =   FECHA REGISTRO =  2021-12-21 14:53:53 FECHA ACTUALIZACIÓN = ','2024-04-18 13:34:15',_binary ''),(298,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  70 con los siguientes datos:  NOMBRE USUARIO=  C. José Herrera Mendoza PASSWORD =  TIPO =  Visitante ESTATUS CONEXIÓN =  Banned ULTIMA CONEXIÓN =  2022-09-09 11:09:25','2024-04-18 13:34:15',_binary ''),(299,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  90 con los siguientes datos:  NOMBRE =  Esterilla de yoga MARCA =  FlexiLoop PRECIO ACTUAL =  70.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:34:15',_binary ''),(300,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  30 con los siguientes datos:  USUARIO ID =  C. José Herrera Mendoza PRODUCTO ID =  Esterilla de yoga FlexiLoop 70.00 TOTAL =  70.00 FECHA REGISTRO =  2022-01-23 12:30:51 ESTATUS =  Activa','2024-04-18 13:34:15',_binary ''),(301,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  71 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Juan PRIMER APELLIDO =  López SEGUNDO APELLIDO =  Rodríguez FECHA NACIMIENTO =  1982-04-13 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  O- ESTATUS =   FECHA REGISTRO =  2021-07-29 19:37:30 FECHA ACTUALIZACIÓN = ','2024-04-18 13:34:15',_binary ''),(302,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  71 con los siguientes datos:  NOMBRE USUARIO=  Juan López Rodríguez PASSWORD =  TIPO =  Miembro ESTATUS CONEXIÓN =  Banned ULTIMA CONEXIÓN =  2023-11-06 16:48:03','2024-04-18 13:34:15',_binary ''),(303,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  91 con los siguientes datos:  NOMBRE =  Suplemento de creatina MARCA =  PowerCord PRECIO ACTUAL =  60.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:34:15',_binary ''),(304,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  31 con los siguientes datos:  USUARIO ID =  Juan López Rodríguez PRODUCTO ID =  Suplemento de creatina PowerCord 60.00 TOTAL =  10.00 FECHA REGISTRO =  2022-12-07 09:46:23 ESTATUS =  Activa','2024-04-18 13:34:15',_binary ''),(305,'root@localhost','Create','detalles_pedidos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  11 con los siguientes datos:  PEDIDO ID =  71 10.00 2022-12-07 09:46:23 PRODUCTO ID =  Correa de estiramiento SpeedGrip CANTIDAD =  500 TOTAL PARCIAL =  10.00 FECHA REGISTRO =  2024-03-12 18:13:02 FECHA ENTREGA =  2024-04-18 13:34:15 ESTATUS =  Activa','2024-04-18 13:34:15',_binary ''),(306,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  72 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Jesus PRIMER APELLIDO =  López SEGUNDO APELLIDO =  Cortés FECHA NACIMIENTO =  1991-02-27 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  B+ ESTATUS =   FECHA REGISTRO =  2022-10-27 11:48:25 FECHA ACTUALIZACIÓN = ','2024-04-18 13:34:15',_binary ''),(307,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  72 con los siguientes datos:  NOMBRE USUARIO=  Jesus López Cortés PASSWORD =  TIPO =  Miembro ESTATUS CONEXIÓN =  Online ULTIMA CONEXIÓN =  2024-01-14 16:32:11','2024-04-18 13:34:15',_binary ''),(308,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  92 con los siguientes datos:  NOMBRE =  Guantes para levantamiento de pesas MARCA =  PowerPulse PRECIO ACTUAL =  30.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:34:15',_binary ''),(309,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  32 con los siguientes datos:  USUARIO ID =  Jesus López Cortés PRODUCTO ID =  Guantes para levantamiento de pesas PowerPulse 30.00 TOTAL =  40.00 FECHA REGISTRO =  2023-07-02 09:46:53 ESTATUS =  Activa','2024-04-18 13:34:15',_binary ''),(310,'root@localhost','Create','detalles_pedidos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  12 con los siguientes datos:  PEDIDO ID =  72 40.00 2023-07-02 09:46:53 PRODUCTO ID =  Correa de estiramiento SpeedGrip CANTIDAD =  380 TOTAL PARCIAL =  10.00 FECHA REGISTRO =  2021-06-24 14:54:49 FECHA ENTREGA =  2024-04-18 13:34:15 ESTATUS =  Activa','2024-04-18 13:34:15',_binary ''),(311,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  73 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Lorena PRIMER APELLIDO =   Rivera SEGUNDO APELLIDO =  Santiago FECHA NACIMIENTO =  1993-08-12 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  O+ ESTATUS =   FECHA REGISTRO =  2024-01-11 11:10:13 FECHA ACTUALIZACIÓN = ','2024-04-18 13:34:15',_binary ''),(312,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  73 con los siguientes datos:  NOMBRE USUARIO=  Lorena  Rivera Santiago PASSWORD =  TIPO =  Miembro ESTATUS CONEXIÓN =  Banned ULTIMA CONEXIÓN =  2024-02-02 18:38:23','2024-04-18 13:34:15',_binary ''),(313,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  93 con los siguientes datos:  NOMBRE =  Banda elástica para ejercicios de resistencia MARCA =  StaminaBoost PRECIO ACTUAL =  20.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:34:15',_binary ''),(314,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  33 con los siguientes datos:  USUARIO ID =  Lorena  Rivera Santiago PRODUCTO ID =  Banda elástica para ejercicios de resistencia StaminaBoost 20.00 TOTAL =  80.00 FECHA REGISTRO =  2020-01-13 18:32:02 ESTATUS =  Activa','2024-04-18 13:34:15',_binary ''),(315,'root@localhost','Create','detalles_pedidos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  13 con los siguientes datos:  PEDIDO ID =  73 80.00 2020-01-13 18:32:02 PRODUCTO ID =  Correa de estiramiento SpeedGrip CANTIDAD =  380 TOTAL PARCIAL =  20.00 FECHA REGISTRO =  2023-10-27 18:12:45 FECHA ENTREGA =  2024-04-18 13:34:15 ESTATUS =  Activa','2024-04-18 13:34:15',_binary ''),(316,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  74 con los siguientes datos:  TITULO CORTESIA =  NOMBRE=  Agustin PRIMER APELLIDO =  Contreras SEGUNDO APELLIDO =  Ortiz FECHA NACIMIENTO =  1998-03-26 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  AB- ESTATUS =   FECHA REGISTRO =  2023-08-04 10:57:26 FECHA ACTUALIZACIÓN = ','2024-04-18 13:34:15',_binary ''),(317,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  74 con los siguientes datos:  NOMBRE USUARIO=   Agustin Contreras Ortiz PASSWORD =  TIPO =  Miembro ESTATUS CONEXIÓN =  Banned ULTIMA CONEXIÓN =  2023-10-10 15:43:26','2024-04-18 13:34:15',_binary ''),(318,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  94 con los siguientes datos:  NOMBRE =  Banda de resistencia para entrenamiento MARCA =  SpeedGrip PRECIO ACTUAL =  100.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:34:15',_binary ''),(319,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  34 con los siguientes datos:  USUARIO ID =   Agustin Contreras Ortiz PRODUCTO ID =  Banda de resistencia para entrenamiento SpeedGrip 100.00 TOTAL =  90.00 FECHA REGISTRO =  2021-07-25 12:23:16 ESTATUS =  Activa','2024-04-18 13:34:15',_binary ''),(320,'root@localhost','Create','detalles_pedidos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  14 con los siguientes datos:  PEDIDO ID =  74 90.00 2021-07-25 12:23:16 PRODUCTO ID =  Correa de estiramiento SpeedGrip CANTIDAD =  500 TOTAL PARCIAL =  60.00 FECHA REGISTRO =  2023-01-07 17:10:48 FECHA ENTREGA =  2024-04-18 13:34:15 ESTATUS =  Activa','2024-04-18 13:34:15',_binary ''),(321,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  75 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Hugo PRIMER APELLIDO =  De la Cruz SEGUNDO APELLIDO =  Guerrero FECHA NACIMIENTO =  1968-04-19 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  A- ESTATUS =   FECHA REGISTRO =  2021-12-04 15:42:17 FECHA ACTUALIZACIÓN = ','2024-04-18 13:34:15',_binary ''),(322,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  75 con los siguientes datos:  NOMBRE USUARIO=  Hugo De la Cruz Guerrero PASSWORD =  TIPO =  Instructor ESTATUS CONEXIÓN =  Offline ULTIMA CONEXIÓN =  2022-11-20 17:53:26','2024-04-18 13:34:15',_binary ''),(323,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  95 con los siguientes datos:  NOMBRE =  Vendas para muñecas y tobillos MARCA =  CardioCharge PRECIO ACTUAL =  60.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:34:15',_binary ''),(324,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  35 con los siguientes datos:  USUARIO ID =  Hugo De la Cruz Guerrero PRODUCTO ID =  Vendas para muñecas y tobillos CardioCharge 60.00 TOTAL =  80.00 FECHA REGISTRO =  2023-05-20 17:54:16 ESTATUS =  Activa','2024-04-18 13:34:15',_binary ''),(325,'root@localhost','Create','detalles_pedidos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  15 con los siguientes datos:  PEDIDO ID =  75 80.00 2023-05-20 17:54:16 PRODUCTO ID =  Correa de estiramiento SpeedGrip CANTIDAD =  500 TOTAL PARCIAL =  40.00 FECHA REGISTRO =  2022-01-21 11:56:08 FECHA ENTREGA =  2024-04-18 13:34:15 ESTATUS =  Activa','2024-04-18 13:34:15',_binary ''),(326,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  76 con los siguientes datos:  TITULO CORTESIA =  Med. NOMBRE= José PRIMER APELLIDO =  Chávez SEGUNDO APELLIDO =  Guerrero FECHA NACIMIENTO =  2001-08-22 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  AB+ ESTATUS =   FECHA REGISTRO =  2021-04-29 17:38:30 FECHA ACTUALIZACIÓN = ','2024-04-18 13:34:15',_binary ''),(327,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  76 con los siguientes datos:  NOMBRE USUARIO=  Med. José Chávez Guerrero PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Online ULTIMA CONEXIÓN =  2024-02-20 15:12:42','2024-04-18 13:34:15',_binary ''),(328,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  96 con los siguientes datos:  NOMBRE =  Suplemento de creatina MARCA =  FlexiGrip PRECIO ACTUAL =  70.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:34:15',_binary ''),(329,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  36 con los siguientes datos:  USUARIO ID =  Med. José Chávez Guerrero PRODUCTO ID =  Suplemento de creatina FlexiGrip 70.00 TOTAL =  10.00 FECHA REGISTRO =  2021-09-24 18:08:32 ESTATUS =  Activa','2024-04-18 13:34:15',_binary ''),(330,'root@localhost','Create','detalles_pedidos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  16 con los siguientes datos:  PEDIDO ID =  76 10.00 2021-09-24 18:08:32 PRODUCTO ID =  Correa de estiramiento SpeedGrip CANTIDAD =  10 TOTAL PARCIAL =  60.00 FECHA REGISTRO =  2023-01-30 19:03:33 FECHA ENTREGA =  2024-04-18 13:34:15 ESTATUS =  Activa','2024-04-18 13:34:15',_binary ''),(331,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  77 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Ana PRIMER APELLIDO =  Domínguez SEGUNDO APELLIDO =  Romero FECHA NACIMIENTO =  1988-08-15 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  B- ESTATUS =   FECHA REGISTRO =  2022-04-30 11:40:31 FECHA ACTUALIZACIÓN = ','2024-04-18 13:34:15',_binary ''),(332,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  77 con los siguientes datos:  NOMBRE USUARIO=  Ana Domínguez Romero PASSWORD =  TIPO =  Instructor ESTATUS CONEXIÓN =  Offline ULTIMA CONEXIÓN =  2023-01-02 18:33:49','2024-04-18 13:34:15',_binary ''),(333,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  97 con los siguientes datos:  NOMBRE =  Esterilla de yoga MARCA =  FlexiStrap PRECIO ACTUAL =  100.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:34:15',_binary ''),(334,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  37 con los siguientes datos:  USUARIO ID =  Ana Domínguez Romero PRODUCTO ID =  Esterilla de yoga FlexiStrap 100.00 TOTAL =  20.00 FECHA REGISTRO =  2023-06-30 15:53:11 ESTATUS =  Activa','2024-04-18 13:34:15',_binary ''),(335,'root@localhost','Create','detalles_pedidos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  17 con los siguientes datos:  PEDIDO ID =  77 20.00 2023-06-30 15:53:11 PRODUCTO ID =  Correa de estiramiento SpeedGrip CANTIDAD =  60 TOTAL PARCIAL =  30.00 FECHA REGISTRO =  2023-05-13 09:24:36 FECHA ENTREGA =  2024-04-18 13:34:15 ESTATUS =  Activa','2024-04-18 13:34:15',_binary ''),(336,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  78 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Hortencia PRIMER APELLIDO =  López SEGUNDO APELLIDO =  Velázquez FECHA NACIMIENTO =  1992-12-05 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  A+ ESTATUS =   FECHA REGISTRO =  2021-10-11 17:24:41 FECHA ACTUALIZACIÓN = ','2024-04-18 13:34:15',_binary ''),(337,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  78 con los siguientes datos:  NOMBRE USUARIO=  Hortencia López Velázquez PASSWORD =  TIPO =  Miembro ESTATUS CONEXIÓN =  Online ULTIMA CONEXIÓN =  2022-04-23 18:51:33','2024-04-18 13:34:15',_binary ''),(338,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  98 con los siguientes datos:  NOMBRE =  Bloque de espuma para estiramientos MARCA =  PowerBlitz PRECIO ACTUAL =  10.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:34:15',_binary ''),(339,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  38 con los siguientes datos:  USUARIO ID =  Hortencia López Velázquez PRODUCTO ID =  Bloque de espuma para estiramientos PowerBlitz 10.00 TOTAL =  90.00 FECHA REGISTRO =  2021-03-07 17:23:32 ESTATUS =  Activa','2024-04-18 13:34:15',_binary ''),(340,'root@localhost','Create','detalles_pedidos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  18 con los siguientes datos:  PEDIDO ID =  78 90.00 2021-03-07 17:23:32 PRODUCTO ID =  Correa de estiramiento SpeedGrip CANTIDAD =  10 TOTAL PARCIAL =  10.00 FECHA REGISTRO =  2020-11-19 16:57:50 FECHA ENTREGA =  2024-04-18 13:34:15 ESTATUS =  Activa','2024-04-18 13:34:15',_binary ''),(341,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  79 con los siguientes datos:  TITULO CORTESIA =  Mtro. NOMBRE= Carlos PRIMER APELLIDO =  Soto SEGUNDO APELLIDO =  Romero FECHA NACIMIENTO =  1987-07-23 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  B+ ESTATUS =   FECHA REGISTRO =  2024-04-16 19:28:03 FECHA ACTUALIZACIÓN = ','2024-04-18 13:34:15',_binary ''),(342,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  79 con los siguientes datos:  NOMBRE USUARIO=  Mtro. Carlos Soto Romero PASSWORD =  TIPO =  Instructor ESTATUS CONEXIÓN =  Online ULTIMA CONEXIÓN =  2024-04-18 11:00:32','2024-04-18 13:34:15',_binary ''),(343,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  99 con los siguientes datos:  NOMBRE =  Magnesio para mejorar el agarre MARCA =  FlexiMat PRECIO ACTUAL =  100.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:34:15',_binary ''),(344,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  39 con los siguientes datos:  USUARIO ID =  Mtro. Carlos Soto Romero PRODUCTO ID =  Magnesio para mejorar el agarre FlexiMat 100.00 TOTAL =  70.00 FECHA REGISTRO =  2020-10-28 09:55:10 ESTATUS =  Activa','2024-04-18 13:34:15',_binary ''),(345,'root@localhost','Create','detalles_pedidos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  19 con los siguientes datos:  PEDIDO ID =  79 70.00 2020-10-28 09:55:10 PRODUCTO ID =  Correa de estiramiento SpeedGrip CANTIDAD =  380 TOTAL PARCIAL =  70.00 FECHA REGISTRO =  2022-03-07 15:34:58 FECHA ENTREGA =  2024-04-18 13:34:15 ESTATUS =  Activa','2024-04-18 13:34:15',_binary ''),(346,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  80 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Adan PRIMER APELLIDO =  De la Cruz SEGUNDO APELLIDO =  Gutiérrez FECHA NACIMIENTO =  1981-08-29 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  A- ESTATUS =   FECHA REGISTRO =  2022-04-30 09:57:31 FECHA ACTUALIZACIÓN = ','2024-04-18 13:34:15',_binary ''),(347,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  80 con los siguientes datos:  NOMBRE USUARIO=  Adan De la Cruz Gutiérrez PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Offline ULTIMA CONEXIÓN =  2023-10-11 11:32:11','2024-04-18 13:34:15',_binary ''),(348,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  100 con los siguientes datos:  NOMBRE =  Suplemento pre-entrenamiento MARCA =  PowerLift PRECIO ACTUAL =  50.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:34:15',_binary ''),(349,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  40 con los siguientes datos:  USUARIO ID =  Adan De la Cruz Gutiérrez PRODUCTO ID =  Suplemento pre-entrenamiento PowerLift 50.00 TOTAL =  90.00 FECHA REGISTRO =  2024-03-24 12:01:21 ESTATUS =  Activa','2024-04-18 13:34:15',_binary ''),(350,'root@localhost','Create','detalles_pedidos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  20 con los siguientes datos:  PEDIDO ID =  80 90.00 2024-03-24 12:01:21 PRODUCTO ID =  Correa de estiramiento SpeedGrip CANTIDAD =  500 TOTAL PARCIAL =  70.00 FECHA REGISTRO =  2023-11-23 16:11:01 FECHA ENTREGA =  2024-04-18 13:34:15 ESTATUS =  Activa','2024-04-18 13:34:15',_binary ''),(351,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  101 con los siguientes datos:  NOMBRE =  Termogénico para quemar grasa MARCA =  FlexiFoam PRECIO ACTUAL =  10.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:34:15',_binary ''),(352,'root@localhost','Create','promociones','Se ha insertado una nueva PROMOCION con el ID:  21 con los siguientes datos:  PRODUCTO ID =  Termogénico para quemar grasa FlexiFoam TIPO DE PROMOCION =  recompensas APLICA EN =  Producto ESTATUS =  Activa','2024-04-18 13:34:15',_binary ''),(353,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  102 con los siguientes datos:  NOMBRE =  Colchoneta para ejercicios MARCA =  FlexiPad PRECIO ACTUAL =  20.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:34:15',_binary ''),(354,'root@localhost','Create','promociones','Se ha insertado una nueva PROMOCION con el ID:  22 con los siguientes datos:  PRODUCTO ID =  Colchoneta para ejercicios FlexiPad TIPO DE PROMOCION =  membresias APLICA EN =  Producto ESTATUS =  Activa','2024-04-18 13:34:15',_binary ''),(355,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  103 con los siguientes datos:  NOMBRE =  Colchoneta para ejercicios MARCA =  MusclePatch PRECIO ACTUAL =  30.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:34:15',_binary ''),(356,'root@localhost','Create','promociones','Se ha insertado una nueva PROMOCION con el ID:  23 con los siguientes datos:  PRODUCTO ID =  Colchoneta para ejercicios MusclePatch TIPO DE PROMOCION =  personalizado APLICA EN =  Producto ESTATUS =  Activa','2024-04-18 13:34:15',_binary ''),(357,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  104 con los siguientes datos:  NOMBRE =  Banda elástica para ejercicios de resistencia MARCA =  PowerCharge PRECIO ACTUAL =  90.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:34:15',_binary ''),(358,'root@localhost','Create','promociones','Se ha insertado una nueva PROMOCION con el ID:  24 con los siguientes datos:  PRODUCTO ID =  Banda elástica para ejercicios de resistencia PowerCharge TIPO DE PROMOCION =  recompensas APLICA EN =  Producto ESTATUS =  Activa','2024-04-18 13:34:15',_binary ''),(359,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  105 con los siguientes datos:  NOMBRE =  Colchoneta para ejercicios MARCA =  PowerPulse PRECIO ACTUAL =  30.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:34:15',_binary ''),(360,'root@localhost','Create','promociones','Se ha insertado una nueva PROMOCION con el ID:  25 con los siguientes datos:  PRODUCTO ID =  Colchoneta para ejercicios PowerPulse TIPO DE PROMOCION =  membresias APLICA EN =  Producto ESTATUS =  Activa','2024-04-18 13:34:15',_binary ''),(361,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  106 con los siguientes datos:  NOMBRE =  Esterilla de yoga MARCA =  MuscleMax PRECIO ACTUAL =  30.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:34:15',_binary ''),(362,'root@localhost','Create','promociones','Se ha insertado una nueva PROMOCION con el ID:  26 con los siguientes datos:  PRODUCTO ID =  Esterilla de yoga MuscleMax TIPO DE PROMOCION =  recompensas APLICA EN =  Membresia ESTATUS =  Activa','2024-04-18 13:34:15',_binary ''),(363,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  107 con los siguientes datos:  NOMBRE =  Bebida isotónica MARCA =  FlexiLoop PRECIO ACTUAL =  60.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:34:15',_binary ''),(364,'root@localhost','Create','promociones','Se ha insertado una nueva PROMOCION con el ID:  27 con los siguientes datos:  PRODUCTO ID =  Bebida isotónica FlexiLoop TIPO DE PROMOCION =  membresias APLICA EN =  Producto ESTATUS =  Activa','2024-04-18 13:34:15',_binary ''),(365,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  108 con los siguientes datos:  NOMBRE =  Bebida energética post-entrenamiento MARCA =  MuscleRecover PRECIO ACTUAL =  20.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:34:15',_binary ''),(366,'root@localhost','Create','promociones','Se ha insertado una nueva PROMOCION con el ID:  28 con los siguientes datos:  PRODUCTO ID =  Bebida energética post-entrenamiento MuscleRecover TIPO DE PROMOCION =  recompensas APLICA EN =  Membresia ESTATUS =  Activa','2024-04-18 13:34:15',_binary ''),(367,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  109 con los siguientes datos:  NOMBRE =  Colchoneta para ejercicios MARCA =  PowerLift PRECIO ACTUAL =  100.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:34:15',_binary ''),(368,'root@localhost','Create','promociones','Se ha insertado una nueva PROMOCION con el ID:  29 con los siguientes datos:  PRODUCTO ID =  Colchoneta para ejercicios PowerLift TIPO DE PROMOCION =  complementarios APLICA EN =  Producto ESTATUS =  Activa','2024-04-18 13:34:15',_binary ''),(369,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  110 con los siguientes datos:  NOMBRE =  Colchoneta para ejercicios MARCA =  FlexiLoop PRECIO ACTUAL =  60.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:34:15',_binary ''),(370,'root@localhost','Create','promociones','Se ha insertado una nueva PROMOCION con el ID:  30 con los siguientes datos:  PRODUCTO ID =  Colchoneta para ejercicios FlexiLoop TIPO DE PROMOCION =  personalizado APLICA EN =  Producto ESTATUS =  Activa','2024-04-18 13:34:15',_binary ''),(371,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  111 con los siguientes datos:  NOMBRE =  Suplemento pre-entrenamiento MARCA =  PowerBar PRECIO ACTUAL =  70.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:34:15',_binary ''),(372,'root@localhost','Create','promociones','Se ha insertado una nueva PROMOCION con el ID:  31 con los siguientes datos:  PRODUCTO ID =  Suplemento pre-entrenamiento PowerBar TIPO DE PROMOCION =  recompensas APLICA EN =  Membresia ESTATUS =  Activa','2024-04-18 13:34:15',_binary ''),(373,'root@localhost','Create','detalles_promociones','Se ha insertado una nueva PROMOCION con el ID:  11 con los siguientes datos:  PROMOCIONES ID =  recompensas FECHA DE INICIO =  2018-11-05 14:15:46 FECHA DE FINALIZACION =  2021-08-02 11:21:12 ESTATUS =  Inactiva','2024-04-18 13:34:15',_binary ''),(374,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  112 con los siguientes datos:  NOMBRE =  Suplemento pre-entrenamiento MARCA =  PowerCord PRECIO ACTUAL =  20.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:34:15',_binary ''),(375,'root@localhost','Create','promociones','Se ha insertado una nueva PROMOCION con el ID:  32 con los siguientes datos:  PRODUCTO ID =  Suplemento pre-entrenamiento PowerCord TIPO DE PROMOCION =  membresias APLICA EN =  Membresia ESTATUS =  Activa','2024-04-18 13:34:15',_binary ''),(376,'root@localhost','Create','detalles_promociones','Se ha insertado una nueva PROMOCION con el ID:  12 con los siguientes datos:  PROMOCIONES ID =  membresias FECHA DE INICIO =  2023-01-26 10:18:41 FECHA DE FINALIZACION =  2021-07-18 10:39:05 ESTATUS =  Inactiva','2024-04-18 13:34:15',_binary ''),(377,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  113 con los siguientes datos:  NOMBRE =  Batidos de proteínas MARCA =  FlexiWheel PRECIO ACTUAL =  30.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:34:15',_binary ''),(378,'root@localhost','Create','promociones','Se ha insertado una nueva PROMOCION con el ID:  33 con los siguientes datos:  PRODUCTO ID =  Batidos de proteínas FlexiWheel TIPO DE PROMOCION =  recompensas APLICA EN =  Membresia ESTATUS =  Activa','2024-04-18 13:34:15',_binary ''),(379,'root@localhost','Create','detalles_promociones','Se ha insertado una nueva PROMOCION con el ID:  13 con los siguientes datos:  PROMOCIONES ID =  recompensas FECHA DE INICIO =  2021-06-22 09:54:54 FECHA DE FINALIZACION =  2023-01-18 08:47:59 ESTATUS =  Inactiva','2024-04-18 13:34:15',_binary ''),(380,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  114 con los siguientes datos:  NOMBRE =  Barritas energéticas MARCA =  MuscleFlex PRECIO ACTUAL =  60.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:34:15',_binary ''),(381,'root@localhost','Create','promociones','Se ha insertado una nueva PROMOCION con el ID:  34 con los siguientes datos:  PRODUCTO ID =  Barritas energéticas MuscleFlex TIPO DE PROMOCION =  membresias APLICA EN =  Membresia ESTATUS =  Activa','2024-04-18 13:34:15',_binary ''),(382,'root@localhost','Create','detalles_promociones','Se ha insertado una nueva PROMOCION con el ID:  14 con los siguientes datos:  PROMOCIONES ID =  membresias FECHA DE INICIO =  2022-11-14 12:55:29 FECHA DE FINALIZACION =  2022-03-15 11:58:14 ESTATUS =  Inactiva','2024-04-18 13:34:15',_binary ''),(383,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  115 con los siguientes datos:  NOMBRE =  Bebida energética pre-entrenamiento MARCA =  MuscleEase PRECIO ACTUAL =  70.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:34:15',_binary ''),(384,'root@localhost','Create','promociones','Se ha insertado una nueva PROMOCION con el ID:  35 con los siguientes datos:  PRODUCTO ID =  Bebida energética pre-entrenamiento MuscleEase TIPO DE PROMOCION =  personalizado APLICA EN =  Producto ESTATUS =  Activa','2024-04-18 13:34:15',_binary ''),(385,'root@localhost','Create','detalles_promociones','Se ha insertado una nueva PROMOCION con el ID:  15 con los siguientes datos:  PROMOCIONES ID =  personalizado FECHA DE INICIO =  2016-06-21 19:42:21 FECHA DE FINALIZACION =  2021-09-24 09:03:20 ESTATUS =  Inactiva','2024-04-18 13:34:15',_binary ''),(386,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  116 con los siguientes datos:  NOMBRE =  Barritas energéticas MARCA =  SpeedMate PRECIO ACTUAL =  80.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:34:15',_binary ''),(387,'root@localhost','Create','promociones','Se ha insertado una nueva PROMOCION con el ID:  36 con los siguientes datos:  PRODUCTO ID =  Barritas energéticas SpeedMate TIPO DE PROMOCION =  membresias APLICA EN =  Membresia ESTATUS =  Activa','2024-04-18 13:34:15',_binary ''),(388,'root@localhost','Create','detalles_promociones','Se ha insertado una nueva PROMOCION con el ID:  16 con los siguientes datos:  PROMOCIONES ID =  membresias FECHA DE INICIO =  2024-03-29 13:50:29 FECHA DE FINALIZACION =  2021-12-11 17:36:40 ESTATUS =  Inactiva','2024-04-18 13:34:15',_binary ''),(389,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  117 con los siguientes datos:  NOMBRE =  Magnesio para mejorar el agarre MARCA =  MuscleFlex PRECIO ACTUAL =  30.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:34:15',_binary ''),(390,'root@localhost','Create','promociones','Se ha insertado una nueva PROMOCION con el ID:  37 con los siguientes datos:  PRODUCTO ID =  Magnesio para mejorar el agarre MuscleFlex TIPO DE PROMOCION =  complementarios APLICA EN =  Producto ESTATUS =  Activa','2024-04-18 13:34:15',_binary ''),(391,'root@localhost','Create','detalles_promociones','Se ha insertado una nueva PROMOCION con el ID:  17 con los siguientes datos:  PROMOCIONES ID =  complementarios FECHA DE INICIO =  2019-09-16 12:42:58 FECHA DE FINALIZACION =  2021-12-01 08:36:45 ESTATUS =  Inactiva','2024-04-18 13:34:15',_binary ''),(392,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  118 con los siguientes datos:  NOMBRE =  Vendas para muñecas y tobillos MARCA =  SpeedWrap PRECIO ACTUAL =  50.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:34:15',_binary ''),(393,'root@localhost','Create','promociones','Se ha insertado una nueva PROMOCION con el ID:  38 con los siguientes datos:  PRODUCTO ID =  Vendas para muñecas y tobillos SpeedWrap TIPO DE PROMOCION =  recompensas APLICA EN =  Producto ESTATUS =  Activa','2024-04-18 13:34:15',_binary ''),(394,'root@localhost','Create','detalles_promociones','Se ha insertado una nueva PROMOCION con el ID:  18 con los siguientes datos:  PROMOCIONES ID =  recompensas FECHA DE INICIO =  2020-10-24 12:30:19 FECHA DE FINALIZACION =  2020-01-03 18:34:22 ESTATUS =  Inactiva','2024-04-18 13:34:15',_binary ''),(395,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  119 con los siguientes datos:  NOMBRE =  Banda de resistencia para entrenamiento MARCA =  FlexiMat PRECIO ACTUAL =  70.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:34:15',_binary ''),(396,'root@localhost','Create','promociones','Se ha insertado una nueva PROMOCION con el ID:  39 con los siguientes datos:  PRODUCTO ID =  Banda de resistencia para entrenamiento FlexiMat TIPO DE PROMOCION =  recompensas APLICA EN =  Producto ESTATUS =  Activa','2024-04-18 13:34:15',_binary ''),(397,'root@localhost','Create','detalles_promociones','Se ha insertado una nueva PROMOCION con el ID:  19 con los siguientes datos:  PROMOCIONES ID =  recompensas FECHA DE INICIO =  2020-08-15 12:25:47 FECHA DE FINALIZACION =  2020-02-19 08:35:43 ESTATUS =  Inactiva','2024-04-18 13:34:15',_binary ''),(398,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  120 con los siguientes datos:  NOMBRE =  Suplemento de creatina MARCA =  FlexiBlock PRECIO ACTUAL =  70.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:34:15',_binary ''),(399,'root@localhost','Create','promociones','Se ha insertado una nueva PROMOCION con el ID:  40 con los siguientes datos:  PRODUCTO ID =  Suplemento de creatina FlexiBlock TIPO DE PROMOCION =  personalizado APLICA EN =  Producto ESTATUS =  Activa','2024-04-18 13:34:15',_binary ''),(400,'root@localhost','Create','detalles_promociones','Se ha insertado una nueva PROMOCION con el ID:  20 con los siguientes datos:  PROMOCIONES ID =  personalizado FECHA DE INICIO =  2023-09-03 11:26:36 FECHA DE FINALIZACION =  2022-09-26 11:51:02 ESTATUS =  Inactiva','2024-04-18 13:34:15',_binary ''),(401,'root@localhost','Update','sucursales','Se ha modificado una SUCURSAL  existente con el ID:  1 con los siguientes datos: NOMBRE = Xicotepec cambio a Xicotepec DIRECCION = Av. 5 de Mayo #75, Col. Centro cambio a Av. 5 de Mayo #75, Col. Centro RESPONSABLE =  Sin responsable asingado. cambio a Sin responsable asingado. TOTAL CLIENTES ATENDIDOS  = 0 cambio a 0 PROMEDIO DE CLIENTES POR DIA = 0 cambio a 0 CAPACIDAD MÀXIMA = 80 cambio a 80 TOTAL EMPLEADOS = 0 cambio a 0 HORARIO_DISPONIBILIDAD = 08:00 a 24:00 cambio a 08:00 a 24:00 ESTATUS =  Activa cambio a Activa','2024-04-18 13:36:05',_binary ''),(402,'root@localhost','Update','sucursales','Se ha modificado una SUCURSAL  existente con el ID:  2 con los siguientes datos: NOMBRE = Villa Ávila Camacho cambio a Villa Ávila Camacho DIRECCION = Calle Asturinas #124, Col. del Rio cambio a Calle Asturinas #124, Col. del Rio RESPONSABLE =  Sin responsable asingado. cambio a Sin responsable asingado. TOTAL CLIENTES ATENDIDOS  = 0 cambio a 0 PROMEDIO DE CLIENTES POR DIA = 0 cambio a 0 CAPACIDAD MÀXIMA = 50 cambio a 50 TOTAL EMPLEADOS = 0 cambio a 0 HORARIO_DISPONIBILIDAD = 08:00 a 20:00 cambio a 08:00 a 20:00 ESTATUS =  Activa cambio a Activa','2024-04-18 13:36:05',_binary ''),(403,'root@localhost','Update','sucursales','Se ha modificado una SUCURSAL  existente con el ID:  3 con los siguientes datos: NOMBRE = San Isidro cambio a San Isidro DIRECCION = Av. Lopez Mateoz #162 Col. Tierra Negra cambio a Av. Lopez Mateoz #162 Col. Tierra Negra RESPONSABLE =  Sin responsable asingado. cambio a Sin responsable asingado. TOTAL CLIENTES ATENDIDOS  = 1 cambio a 1 PROMEDIO DE CLIENTES POR DIA = 1 cambio a 1 CAPACIDAD MÀXIMA = 90 cambio a 90 TOTAL EMPLEADOS = 0 cambio a 0 HORARIO_DISPONIBILIDAD = 09:00 a 21:00 cambio a 09:00 a 21:00 ESTATUS =  Activa cambio a Activa','2024-04-18 13:36:05',_binary ''),(404,'root@localhost','Update','sucursales','Se ha modificado una SUCURSAL  existente con el ID:  4 con los siguientes datos: NOMBRE = Seiva cambio a Seiva DIRECCION = Av. de las Torres #239, Col. Centro cambio a Av. de las Torres #239, Col. Centro RESPONSABLE =  Sin responsable asingado. cambio a Sin responsable asingado. TOTAL CLIENTES ATENDIDOS  = 0 cambio a 0 PROMEDIO DE CLIENTES POR DIA = 0 cambio a 0 CAPACIDAD MÀXIMA = 50 cambio a 50 TOTAL EMPLEADOS = 0 cambio a 0 HORARIO_DISPONIBILIDAD = 07:00 a 22:00 cambio a 07:00 a 22:00 ESTATUS =  Inactiva cambio a Inactiva','2024-04-18 13:36:05',_binary ''),(405,'root@localhost','Update','sucursales','Se ha modificado una SUCURSAL  existente con el ID:  5 con los siguientes datos: NOMBRE = Huahuchinango cambio a Huahuchinango DIRECCION = Calle Abasolo #25, Col.Barrio tibanco cambio a Calle Abasolo #25, Col.Barrio tibanco RESPONSABLE =  Sin responsable asingado. cambio a Sin responsable asingado. TOTAL CLIENTES ATENDIDOS  = 0 cambio a 0 PROMEDIO DE CLIENTES POR DIA = 0 cambio a 0 CAPACIDAD MÀXIMA = 56 cambio a 56 TOTAL EMPLEADOS = 0 cambio a 0 HORARIO_DISPONIBILIDAD = 07:00 a 21:00 cambio a 07:00 a 21:00 ESTATUS =  Activa cambio a Activa','2024-04-18 13:36:05',_binary ''),(406,'root@localhost','Delete','detalles_promociones','Se ha eliminado un DETALLE_PROMOCION con el ID:  1','2024-04-18 13:36:05',_binary ''),(407,'root@localhost','Delete','detalles_promociones','Se ha eliminado un DETALLE_PROMOCION con el ID:  2','2024-04-18 13:36:05',_binary ''),(408,'root@localhost','Delete','detalles_promociones','Se ha eliminado un DETALLE_PROMOCION con el ID:  3','2024-04-18 13:36:05',_binary ''),(409,'root@localhost','Delete','detalles_promociones','Se ha eliminado un DETALLE_PROMOCION con el ID:  4','2024-04-18 13:36:05',_binary ''),(410,'root@localhost','Delete','detalles_promociones','Se ha eliminado un DETALLE_PROMOCION con el ID:  5','2024-04-18 13:36:05',_binary ''),(411,'root@localhost','Delete','detalles_promociones','Se ha eliminado un DETALLE_PROMOCION con el ID:  6','2024-04-18 13:36:05',_binary ''),(412,'root@localhost','Delete','detalles_promociones','Se ha eliminado un DETALLE_PROMOCION con el ID:  7','2024-04-18 13:36:05',_binary ''),(413,'root@localhost','Delete','detalles_promociones','Se ha eliminado un DETALLE_PROMOCION con el ID:  8','2024-04-18 13:36:05',_binary ''),(414,'root@localhost','Delete','detalles_promociones','Se ha eliminado un DETALLE_PROMOCION con el ID:  9','2024-04-18 13:36:05',_binary ''),(415,'root@localhost','Delete','detalles_promociones','Se ha eliminado un DETALLE_PROMOCION con el ID:  10','2024-04-18 13:36:05',_binary ''),(416,'root@localhost','Delete','detalles_promociones','Se ha eliminado un DETALLE_PROMOCION con el ID:  11','2024-04-18 13:36:05',_binary ''),(417,'root@localhost','Delete','detalles_promociones','Se ha eliminado un DETALLE_PROMOCION con el ID:  12','2024-04-18 13:36:05',_binary ''),(418,'root@localhost','Delete','detalles_promociones','Se ha eliminado un DETALLE_PROMOCION con el ID:  13','2024-04-18 13:36:05',_binary ''),(419,'root@localhost','Delete','detalles_promociones','Se ha eliminado un DETALLE_PROMOCION con el ID:  14','2024-04-18 13:36:05',_binary ''),(420,'root@localhost','Delete','detalles_promociones','Se ha eliminado un DETALLE_PROMOCION con el ID:  15','2024-04-18 13:36:05',_binary ''),(421,'root@localhost','Delete','detalles_promociones','Se ha eliminado un DETALLE_PROMOCION con el ID:  16','2024-04-18 13:36:05',_binary ''),(422,'root@localhost','Delete','detalles_promociones','Se ha eliminado un DETALLE_PROMOCION con el ID:  17','2024-04-18 13:36:05',_binary ''),(423,'root@localhost','Delete','detalles_promociones','Se ha eliminado un DETALLE_PROMOCION con el ID:  18','2024-04-18 13:36:05',_binary ''),(424,'root@localhost','Delete','detalles_promociones','Se ha eliminado un DETALLE_PROMOCION con el ID:  19','2024-04-18 13:36:05',_binary ''),(425,'root@localhost','Delete','detalles_promociones','Se ha eliminado un DETALLE_PROMOCION con el ID:  20','2024-04-18 13:36:05',_binary ''),(426,'root@localhost','Delete','promociones','Se ha eliminado una PROMOCION con el ID:  1','2024-04-18 13:36:05',_binary ''),(427,'root@localhost','Delete','promociones','Se ha eliminado una PROMOCION con el ID:  2','2024-04-18 13:36:05',_binary ''),(428,'root@localhost','Delete','promociones','Se ha eliminado una PROMOCION con el ID:  3','2024-04-18 13:36:05',_binary ''),(429,'root@localhost','Delete','promociones','Se ha eliminado una PROMOCION con el ID:  4','2024-04-18 13:36:05',_binary ''),(430,'root@localhost','Delete','promociones','Se ha eliminado una PROMOCION con el ID:  5','2024-04-18 13:36:05',_binary ''),(431,'root@localhost','Delete','promociones','Se ha eliminado una PROMOCION con el ID:  6','2024-04-18 13:36:05',_binary ''),(432,'root@localhost','Delete','promociones','Se ha eliminado una PROMOCION con el ID:  7','2024-04-18 13:36:05',_binary ''),(433,'root@localhost','Delete','promociones','Se ha eliminado una PROMOCION con el ID:  8','2024-04-18 13:36:05',_binary ''),(434,'root@localhost','Delete','promociones','Se ha eliminado una PROMOCION con el ID:  9','2024-04-18 13:36:05',_binary ''),(435,'root@localhost','Delete','promociones','Se ha eliminado una PROMOCION con el ID:  10','2024-04-18 13:36:05',_binary ''),(436,'root@localhost','Delete','promociones','Se ha eliminado una PROMOCION con el ID:  11','2024-04-18 13:36:05',_binary ''),(437,'root@localhost','Delete','promociones','Se ha eliminado una PROMOCION con el ID:  12','2024-04-18 13:36:05',_binary ''),(438,'root@localhost','Delete','promociones','Se ha eliminado una PROMOCION con el ID:  13','2024-04-18 13:36:05',_binary ''),(439,'root@localhost','Delete','promociones','Se ha eliminado una PROMOCION con el ID:  14','2024-04-18 13:36:05',_binary ''),(440,'root@localhost','Delete','promociones','Se ha eliminado una PROMOCION con el ID:  15','2024-04-18 13:36:05',_binary ''),(441,'root@localhost','Delete','promociones','Se ha eliminado una PROMOCION con el ID:  16','2024-04-18 13:36:05',_binary ''),(442,'root@localhost','Delete','promociones','Se ha eliminado una PROMOCION con el ID:  17','2024-04-18 13:36:05',_binary ''),(443,'root@localhost','Delete','promociones','Se ha eliminado una PROMOCION con el ID:  18','2024-04-18 13:36:05',_binary ''),(444,'root@localhost','Delete','promociones','Se ha eliminado una PROMOCION con el ID:  19','2024-04-18 13:36:05',_binary ''),(445,'root@localhost','Delete','promociones','Se ha eliminado una PROMOCION con el ID:  20','2024-04-18 13:36:05',_binary ''),(446,'root@localhost','Delete','promociones','Se ha eliminado una PROMOCION con el ID:  21','2024-04-18 13:36:05',_binary ''),(447,'root@localhost','Delete','promociones','Se ha eliminado una PROMOCION con el ID:  22','2024-04-18 13:36:05',_binary ''),(448,'root@localhost','Delete','promociones','Se ha eliminado una PROMOCION con el ID:  23','2024-04-18 13:36:05',_binary ''),(449,'root@localhost','Delete','promociones','Se ha eliminado una PROMOCION con el ID:  24','2024-04-18 13:36:05',_binary ''),(450,'root@localhost','Delete','promociones','Se ha eliminado una PROMOCION con el ID:  25','2024-04-18 13:36:05',_binary ''),(451,'root@localhost','Delete','promociones','Se ha eliminado una PROMOCION con el ID:  26','2024-04-18 13:36:05',_binary ''),(452,'root@localhost','Delete','promociones','Se ha eliminado una PROMOCION con el ID:  27','2024-04-18 13:36:05',_binary ''),(453,'root@localhost','Delete','promociones','Se ha eliminado una PROMOCION con el ID:  28','2024-04-18 13:36:05',_binary ''),(454,'root@localhost','Delete','promociones','Se ha eliminado una PROMOCION con el ID:  29','2024-04-18 13:36:05',_binary ''),(455,'root@localhost','Delete','promociones','Se ha eliminado una PROMOCION con el ID:  30','2024-04-18 13:36:05',_binary ''),(456,'root@localhost','Delete','promociones','Se ha eliminado una PROMOCION con el ID:  31','2024-04-18 13:36:05',_binary ''),(457,'root@localhost','Delete','promociones','Se ha eliminado una PROMOCION con el ID:  32','2024-04-18 13:36:05',_binary ''),(458,'root@localhost','Delete','promociones','Se ha eliminado una PROMOCION con el ID:  33','2024-04-18 13:36:05',_binary ''),(459,'root@localhost','Delete','promociones','Se ha eliminado una PROMOCION con el ID:  34','2024-04-18 13:36:05',_binary ''),(460,'root@localhost','Delete','promociones','Se ha eliminado una PROMOCION con el ID:  35','2024-04-18 13:36:05',_binary ''),(461,'root@localhost','Delete','promociones','Se ha eliminado una PROMOCION con el ID:  36','2024-04-18 13:36:05',_binary ''),(462,'root@localhost','Delete','promociones','Se ha eliminado una PROMOCION con el ID:  37','2024-04-18 13:36:05',_binary ''),(463,'root@localhost','Delete','promociones','Se ha eliminado una PROMOCION con el ID:  38','2024-04-18 13:36:05',_binary ''),(464,'root@localhost','Delete','promociones','Se ha eliminado una PROMOCION con el ID:  39','2024-04-18 13:36:05',_binary ''),(465,'root@localhost','Delete','promociones','Se ha eliminado una PROMOCION con el ID:  40','2024-04-18 13:36:05',_binary ''),(466,'root@localhost','Delete','detalles_pedidos','Se ha eliminado una relación DETALLES_PEDIDOS con el ID:  1','2024-04-18 13:36:05',_binary ''),(467,'root@localhost','Delete','detalles_pedidos','Se ha eliminado una relación DETALLES_PEDIDOS con el ID:  2','2024-04-18 13:36:05',_binary ''),(468,'root@localhost','Delete','detalles_pedidos','Se ha eliminado una relación DETALLES_PEDIDOS con el ID:  3','2024-04-18 13:36:05',_binary ''),(469,'root@localhost','Delete','detalles_pedidos','Se ha eliminado una relación DETALLES_PEDIDOS con el ID:  4','2024-04-18 13:36:05',_binary ''),(470,'root@localhost','Delete','detalles_pedidos','Se ha eliminado una relación DETALLES_PEDIDOS con el ID:  5','2024-04-18 13:36:05',_binary ''),(471,'root@localhost','Delete','detalles_pedidos','Se ha eliminado una relación DETALLES_PEDIDOS con el ID:  6','2024-04-18 13:36:05',_binary ''),(472,'root@localhost','Delete','detalles_pedidos','Se ha eliminado una relación DETALLES_PEDIDOS con el ID:  7','2024-04-18 13:36:05',_binary ''),(473,'root@localhost','Delete','detalles_pedidos','Se ha eliminado una relación DETALLES_PEDIDOS con el ID:  8','2024-04-18 13:36:05',_binary ''),(474,'root@localhost','Delete','detalles_pedidos','Se ha eliminado una relación DETALLES_PEDIDOS con el ID:  9','2024-04-18 13:36:05',_binary ''),(475,'root@localhost','Delete','detalles_pedidos','Se ha eliminado una relación DETALLES_PEDIDOS con el ID:  10','2024-04-18 13:36:05',_binary ''),(476,'root@localhost','Delete','detalles_pedidos','Se ha eliminado una relación DETALLES_PEDIDOS con el ID:  11','2024-04-18 13:36:05',_binary ''),(477,'root@localhost','Delete','detalles_pedidos','Se ha eliminado una relación DETALLES_PEDIDOS con el ID:  12','2024-04-18 13:36:05',_binary ''),(478,'root@localhost','Delete','detalles_pedidos','Se ha eliminado una relación DETALLES_PEDIDOS con el ID:  13','2024-04-18 13:36:05',_binary ''),(479,'root@localhost','Delete','detalles_pedidos','Se ha eliminado una relación DETALLES_PEDIDOS con el ID:  14','2024-04-18 13:36:05',_binary ''),(480,'root@localhost','Delete','detalles_pedidos','Se ha eliminado una relación DETALLES_PEDIDOS con el ID:  15','2024-04-18 13:36:05',_binary ''),(481,'root@localhost','Delete','detalles_pedidos','Se ha eliminado una relación DETALLES_PEDIDOS con el ID:  16','2024-04-18 13:36:05',_binary ''),(482,'root@localhost','Delete','detalles_pedidos','Se ha eliminado una relación DETALLES_PEDIDOS con el ID:  17','2024-04-18 13:36:05',_binary ''),(483,'root@localhost','Delete','detalles_pedidos','Se ha eliminado una relación DETALLES_PEDIDOS con el ID:  18','2024-04-18 13:36:05',_binary ''),(484,'root@localhost','Delete','detalles_pedidos','Se ha eliminado una relación DETALLES_PEDIDOS con el ID:  19','2024-04-18 13:36:05',_binary ''),(485,'root@localhost','Delete','detalles_pedidos','Se ha eliminado una relación DETALLES_PEDIDOS con el ID:  20','2024-04-18 13:36:05',_binary ''),(486,'root@localhost','Delete','pedidos','Se ha eliminado un PEDIDO con el ID:  1','2024-04-18 13:36:05',_binary ''),(487,'root@localhost','Delete','pedidos','Se ha eliminado un PEDIDO con el ID:  2','2024-04-18 13:36:05',_binary ''),(488,'root@localhost','Delete','pedidos','Se ha eliminado un PEDIDO con el ID:  3','2024-04-18 13:36:05',_binary ''),(489,'root@localhost','Delete','pedidos','Se ha eliminado un PEDIDO con el ID:  4','2024-04-18 13:36:05',_binary ''),(490,'root@localhost','Delete','pedidos','Se ha eliminado un PEDIDO con el ID:  5','2024-04-18 13:36:05',_binary ''),(491,'root@localhost','Delete','pedidos','Se ha eliminado un PEDIDO con el ID:  6','2024-04-18 13:36:05',_binary ''),(492,'root@localhost','Delete','pedidos','Se ha eliminado un PEDIDO con el ID:  7','2024-04-18 13:36:05',_binary ''),(493,'root@localhost','Delete','pedidos','Se ha eliminado un PEDIDO con el ID:  8','2024-04-18 13:36:05',_binary ''),(494,'root@localhost','Delete','pedidos','Se ha eliminado un PEDIDO con el ID:  9','2024-04-18 13:36:05',_binary ''),(495,'root@localhost','Delete','pedidos','Se ha eliminado un PEDIDO con el ID:  10','2024-04-18 13:36:05',_binary ''),(496,'root@localhost','Delete','pedidos','Se ha eliminado un PEDIDO con el ID:  11','2024-04-18 13:36:05',_binary ''),(497,'root@localhost','Delete','pedidos','Se ha eliminado un PEDIDO con el ID:  12','2024-04-18 13:36:05',_binary ''),(498,'root@localhost','Delete','pedidos','Se ha eliminado un PEDIDO con el ID:  13','2024-04-18 13:36:05',_binary ''),(499,'root@localhost','Delete','pedidos','Se ha eliminado un PEDIDO con el ID:  14','2024-04-18 13:36:05',_binary ''),(500,'root@localhost','Delete','pedidos','Se ha eliminado un PEDIDO con el ID:  15','2024-04-18 13:36:05',_binary ''),(501,'root@localhost','Delete','pedidos','Se ha eliminado un PEDIDO con el ID:  16','2024-04-18 13:36:05',_binary ''),(502,'root@localhost','Delete','pedidos','Se ha eliminado un PEDIDO con el ID:  17','2024-04-18 13:36:05',_binary ''),(503,'root@localhost','Delete','pedidos','Se ha eliminado un PEDIDO con el ID:  18','2024-04-18 13:36:05',_binary ''),(504,'root@localhost','Delete','pedidos','Se ha eliminado un PEDIDO con el ID:  19','2024-04-18 13:36:05',_binary ''),(505,'root@localhost','Delete','pedidos','Se ha eliminado un PEDIDO con el ID:  20','2024-04-18 13:36:05',_binary ''),(506,'root@localhost','Delete','pedidos','Se ha eliminado un PEDIDO con el ID:  21','2024-04-18 13:36:05',_binary ''),(507,'root@localhost','Delete','pedidos','Se ha eliminado un PEDIDO con el ID:  22','2024-04-18 13:36:05',_binary ''),(508,'root@localhost','Delete','pedidos','Se ha eliminado un PEDIDO con el ID:  23','2024-04-18 13:36:05',_binary ''),(509,'root@localhost','Delete','pedidos','Se ha eliminado un PEDIDO con el ID:  24','2024-04-18 13:36:05',_binary ''),(510,'root@localhost','Delete','pedidos','Se ha eliminado un PEDIDO con el ID:  25','2024-04-18 13:36:05',_binary ''),(511,'root@localhost','Delete','pedidos','Se ha eliminado un PEDIDO con el ID:  26','2024-04-18 13:36:05',_binary ''),(512,'root@localhost','Delete','pedidos','Se ha eliminado un PEDIDO con el ID:  27','2024-04-18 13:36:05',_binary ''),(513,'root@localhost','Delete','pedidos','Se ha eliminado un PEDIDO con el ID:  28','2024-04-18 13:36:05',_binary ''),(514,'root@localhost','Delete','pedidos','Se ha eliminado un PEDIDO con el ID:  29','2024-04-18 13:36:05',_binary ''),(515,'root@localhost','Delete','pedidos','Se ha eliminado un PEDIDO con el ID:  30','2024-04-18 13:36:05',_binary ''),(516,'root@localhost','Delete','pedidos','Se ha eliminado un PEDIDO con el ID:  31','2024-04-18 13:36:05',_binary ''),(517,'root@localhost','Delete','pedidos','Se ha eliminado un PEDIDO con el ID:  32','2024-04-18 13:36:05',_binary ''),(518,'root@localhost','Delete','pedidos','Se ha eliminado un PEDIDO con el ID:  33','2024-04-18 13:36:05',_binary ''),(519,'root@localhost','Delete','pedidos','Se ha eliminado un PEDIDO con el ID:  34','2024-04-18 13:36:05',_binary ''),(520,'root@localhost','Delete','pedidos','Se ha eliminado un PEDIDO con el ID:  35','2024-04-18 13:36:05',_binary ''),(521,'root@localhost','Delete','pedidos','Se ha eliminado un PEDIDO con el ID:  36','2024-04-18 13:36:05',_binary ''),(522,'root@localhost','Delete','pedidos','Se ha eliminado un PEDIDO con el ID:  37','2024-04-18 13:36:05',_binary ''),(523,'root@localhost','Delete','pedidos','Se ha eliminado un PEDIDO con el ID:  38','2024-04-18 13:36:05',_binary ''),(524,'root@localhost','Delete','pedidos','Se ha eliminado un PEDIDO con el ID:  39','2024-04-18 13:36:05',_binary ''),(525,'root@localhost','Delete','pedidos','Se ha eliminado un PEDIDO con el ID:  40','2024-04-18 13:36:05',_binary ''),(526,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  1','2024-04-18 13:36:05',_binary ''),(527,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  2','2024-04-18 13:36:05',_binary ''),(528,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  3','2024-04-18 13:36:05',_binary ''),(529,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  4','2024-04-18 13:36:05',_binary ''),(530,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  5','2024-04-18 13:36:05',_binary ''),(531,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  6','2024-04-18 13:36:05',_binary ''),(532,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  7','2024-04-18 13:36:05',_binary ''),(533,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  8','2024-04-18 13:36:05',_binary ''),(534,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  9','2024-04-18 13:36:05',_binary ''),(535,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  10','2024-04-18 13:36:05',_binary ''),(536,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  11','2024-04-18 13:36:05',_binary ''),(537,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  12','2024-04-18 13:36:05',_binary ''),(538,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  13','2024-04-18 13:36:05',_binary ''),(539,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  14','2024-04-18 13:36:05',_binary ''),(540,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  15','2024-04-18 13:36:05',_binary ''),(541,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  16','2024-04-18 13:36:05',_binary ''),(542,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  17','2024-04-18 13:36:05',_binary ''),(543,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  18','2024-04-18 13:36:05',_binary ''),(544,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  19','2024-04-18 13:36:05',_binary ''),(545,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  20','2024-04-18 13:36:05',_binary ''),(546,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  21','2024-04-18 13:36:05',_binary ''),(547,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  22','2024-04-18 13:36:05',_binary ''),(548,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  23','2024-04-18 13:36:05',_binary ''),(549,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  24','2024-04-18 13:36:05',_binary ''),(550,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  25','2024-04-18 13:36:05',_binary ''),(551,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  26','2024-04-18 13:36:05',_binary ''),(552,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  27','2024-04-18 13:36:05',_binary ''),(553,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  28','2024-04-18 13:36:05',_binary ''),(554,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  29','2024-04-18 13:36:05',_binary ''),(555,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  30','2024-04-18 13:36:05',_binary ''),(556,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  31','2024-04-18 13:36:05',_binary ''),(557,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  32','2024-04-18 13:36:05',_binary ''),(558,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  33','2024-04-18 13:36:05',_binary ''),(559,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  34','2024-04-18 13:36:05',_binary ''),(560,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  35','2024-04-18 13:36:05',_binary ''),(561,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  36','2024-04-18 13:36:05',_binary ''),(562,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  37','2024-04-18 13:36:05',_binary ''),(563,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  38','2024-04-18 13:36:05',_binary ''),(564,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  39','2024-04-18 13:36:05',_binary ''),(565,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  40','2024-04-18 13:36:05',_binary ''),(566,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  41','2024-04-18 13:36:05',_binary ''),(567,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  42','2024-04-18 13:36:05',_binary ''),(568,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  43','2024-04-18 13:36:05',_binary ''),(569,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  44','2024-04-18 13:36:05',_binary ''),(570,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  45','2024-04-18 13:36:05',_binary ''),(571,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  46','2024-04-18 13:36:05',_binary ''),(572,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  47','2024-04-18 13:36:05',_binary ''),(573,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  48','2024-04-18 13:36:05',_binary ''),(574,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  49','2024-04-18 13:36:05',_binary ''),(575,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  50','2024-04-18 13:36:05',_binary ''),(576,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  51','2024-04-18 13:36:05',_binary ''),(577,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  52','2024-04-18 13:36:05',_binary ''),(578,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  53','2024-04-18 13:36:05',_binary ''),(579,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  54','2024-04-18 13:36:05',_binary ''),(580,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  55','2024-04-18 13:36:05',_binary ''),(581,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  56','2024-04-18 13:36:05',_binary ''),(582,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  57','2024-04-18 13:36:05',_binary ''),(583,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  58','2024-04-18 13:36:05',_binary ''),(584,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  59','2024-04-18 13:36:05',_binary ''),(585,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  60','2024-04-18 13:36:05',_binary ''),(586,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  61','2024-04-18 13:36:05',_binary ''),(587,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  62','2024-04-18 13:36:05',_binary ''),(588,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  63','2024-04-18 13:36:05',_binary ''),(589,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  64','2024-04-18 13:36:05',_binary ''),(590,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  65','2024-04-18 13:36:05',_binary ''),(591,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  66','2024-04-18 13:36:05',_binary ''),(592,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  67','2024-04-18 13:36:05',_binary ''),(593,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  68','2024-04-18 13:36:05',_binary ''),(594,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  69','2024-04-18 13:36:05',_binary ''),(595,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  70','2024-04-18 13:36:05',_binary ''),(596,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  71','2024-04-18 13:36:05',_binary ''),(597,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  72','2024-04-18 13:36:05',_binary ''),(598,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  73','2024-04-18 13:36:05',_binary ''),(599,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  74','2024-04-18 13:36:05',_binary ''),(600,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  75','2024-04-18 13:36:05',_binary ''),(601,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  76','2024-04-18 13:36:05',_binary ''),(602,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  77','2024-04-18 13:36:05',_binary ''),(603,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  78','2024-04-18 13:36:05',_binary ''),(604,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  79','2024-04-18 13:36:05',_binary ''),(605,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  80','2024-04-18 13:36:05',_binary ''),(606,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  81','2024-04-18 13:36:05',_binary ''),(607,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  82','2024-04-18 13:36:05',_binary ''),(608,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  83','2024-04-18 13:36:05',_binary ''),(609,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  84','2024-04-18 13:36:05',_binary ''),(610,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  85','2024-04-18 13:36:05',_binary ''),(611,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  86','2024-04-18 13:36:05',_binary ''),(612,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  87','2024-04-18 13:36:05',_binary ''),(613,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  88','2024-04-18 13:36:05',_binary ''),(614,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  89','2024-04-18 13:36:05',_binary ''),(615,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  90','2024-04-18 13:36:05',_binary ''),(616,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  91','2024-04-18 13:36:05',_binary ''),(617,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  92','2024-04-18 13:36:05',_binary ''),(618,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  93','2024-04-18 13:36:05',_binary ''),(619,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  94','2024-04-18 13:36:05',_binary ''),(620,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  95','2024-04-18 13:36:05',_binary ''),(621,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  96','2024-04-18 13:36:05',_binary ''),(622,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  97','2024-04-18 13:36:05',_binary ''),(623,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  98','2024-04-18 13:36:05',_binary ''),(624,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  99','2024-04-18 13:36:05',_binary ''),(625,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  100','2024-04-18 13:36:05',_binary ''),(626,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  101','2024-04-18 13:36:05',_binary ''),(627,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  102','2024-04-18 13:36:05',_binary ''),(628,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  103','2024-04-18 13:36:05',_binary ''),(629,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  104','2024-04-18 13:36:05',_binary ''),(630,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  105','2024-04-18 13:36:05',_binary ''),(631,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  106','2024-04-18 13:36:05',_binary ''),(632,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  107','2024-04-18 13:36:05',_binary ''),(633,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  108','2024-04-18 13:36:05',_binary ''),(634,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  109','2024-04-18 13:36:05',_binary ''),(635,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  110','2024-04-18 13:36:05',_binary ''),(636,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  111','2024-04-18 13:36:05',_binary ''),(637,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  112','2024-04-18 13:36:05',_binary ''),(638,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  113','2024-04-18 13:36:05',_binary ''),(639,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  114','2024-04-18 13:36:05',_binary ''),(640,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  115','2024-04-18 13:36:05',_binary ''),(641,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  116','2024-04-18 13:36:05',_binary ''),(642,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  117','2024-04-18 13:36:05',_binary ''),(643,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  118','2024-04-18 13:36:05',_binary ''),(644,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  119','2024-04-18 13:36:05',_binary ''),(645,'root@localhost','Delete','productos','Se ha eliminado un PRODUCTO con el ID:  120','2024-04-18 13:36:05',_binary ''),(646,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  11','2024-04-18 13:36:05',_binary ''),(647,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  12','2024-04-18 13:36:05',_binary ''),(648,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  13','2024-04-18 13:36:05',_binary ''),(649,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  14','2024-04-18 13:36:05',_binary ''),(650,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  15','2024-04-18 13:36:05',_binary ''),(651,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  16','2024-04-18 13:36:05',_binary ''),(652,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  17','2024-04-18 13:36:05',_binary ''),(653,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  18','2024-04-18 13:36:05',_binary ''),(654,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  19','2024-04-18 13:36:05',_binary ''),(655,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  20','2024-04-18 13:36:05',_binary ''),(656,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  21','2024-04-18 13:36:05',_binary ''),(657,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  22','2024-04-18 13:36:05',_binary ''),(658,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  23','2024-04-18 13:36:05',_binary ''),(659,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  24','2024-04-18 13:36:05',_binary ''),(660,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  25','2024-04-18 13:36:05',_binary ''),(661,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  26','2024-04-18 13:36:05',_binary ''),(662,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  27','2024-04-18 13:36:05',_binary ''),(663,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  28','2024-04-18 13:36:05',_binary ''),(664,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  29','2024-04-18 13:36:05',_binary ''),(665,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  30','2024-04-18 13:36:05',_binary ''),(666,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  31','2024-04-18 13:36:05',_binary ''),(667,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  32','2024-04-18 13:36:05',_binary ''),(668,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  33','2024-04-18 13:36:05',_binary ''),(669,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  34','2024-04-18 13:36:05',_binary ''),(670,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  35','2024-04-18 13:36:05',_binary ''),(671,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  36','2024-04-18 13:36:05',_binary ''),(672,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  37','2024-04-18 13:36:05',_binary ''),(673,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  38','2024-04-18 13:36:05',_binary ''),(674,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  39','2024-04-18 13:36:05',_binary ''),(675,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  40','2024-04-18 13:36:05',_binary ''),(676,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  51','2024-04-18 13:36:05',_binary ''),(677,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  52','2024-04-18 13:36:05',_binary ''),(678,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  53','2024-04-18 13:36:05',_binary ''),(679,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  54','2024-04-18 13:36:05',_binary ''),(680,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  55','2024-04-18 13:36:05',_binary ''),(681,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  56','2024-04-18 13:36:05',_binary ''),(682,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  57','2024-04-18 13:36:05',_binary ''),(683,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  58','2024-04-18 13:36:05',_binary ''),(684,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  59','2024-04-18 13:36:05',_binary ''),(685,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  60','2024-04-18 13:36:05',_binary ''),(686,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  61','2024-04-18 13:36:05',_binary ''),(687,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  62','2024-04-18 13:36:05',_binary ''),(688,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  63','2024-04-18 13:36:05',_binary ''),(689,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  64','2024-04-18 13:36:05',_binary ''),(690,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  65','2024-04-18 13:36:05',_binary ''),(691,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  66','2024-04-18 13:36:05',_binary ''),(692,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  67','2024-04-18 13:36:05',_binary ''),(693,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  68','2024-04-18 13:36:05',_binary ''),(694,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  69','2024-04-18 13:36:05',_binary ''),(695,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  70','2024-04-18 13:36:05',_binary ''),(696,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  71','2024-04-18 13:36:05',_binary ''),(697,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  72','2024-04-18 13:36:05',_binary ''),(698,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  73','2024-04-18 13:36:05',_binary ''),(699,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  74','2024-04-18 13:36:05',_binary ''),(700,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  75','2024-04-18 13:36:05',_binary ''),(701,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  76','2024-04-18 13:36:05',_binary ''),(702,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  77','2024-04-18 13:36:05',_binary ''),(703,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  78','2024-04-18 13:36:05',_binary ''),(704,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  79','2024-04-18 13:36:05',_binary ''),(705,'root@localhost','Delete','usuarios','Se ha eliminado un USUARIO con el ID:  80','2024-04-18 13:36:05',_binary ''),(706,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  1','2024-04-18 13:36:05',_binary ''),(707,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  2','2024-04-18 13:36:05',_binary ''),(708,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  3','2024-04-18 13:36:05',_binary ''),(709,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  4','2024-04-18 13:36:05',_binary ''),(710,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  5','2024-04-18 13:36:05',_binary ''),(711,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  6','2024-04-18 13:36:05',_binary ''),(712,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  7','2024-04-18 13:36:05',_binary ''),(713,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  8','2024-04-18 13:36:05',_binary ''),(714,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  9','2024-04-18 13:36:05',_binary ''),(715,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  10','2024-04-18 13:36:05',_binary ''),(716,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  11','2024-04-18 13:36:05',_binary ''),(717,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  12','2024-04-18 13:36:05',_binary ''),(718,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  13','2024-04-18 13:36:05',_binary ''),(719,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  14','2024-04-18 13:36:05',_binary ''),(720,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  15','2024-04-18 13:36:05',_binary ''),(721,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  16','2024-04-18 13:36:05',_binary ''),(722,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  17','2024-04-18 13:36:05',_binary ''),(723,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  18','2024-04-18 13:36:05',_binary ''),(724,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  19','2024-04-18 13:36:05',_binary ''),(725,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  20','2024-04-18 13:36:05',_binary ''),(726,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  21','2024-04-18 13:36:05',_binary ''),(727,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  22','2024-04-18 13:36:05',_binary ''),(728,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  23','2024-04-18 13:36:05',_binary ''),(729,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  24','2024-04-18 13:36:05',_binary ''),(730,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  25','2024-04-18 13:36:05',_binary ''),(731,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  26','2024-04-18 13:36:05',_binary ''),(732,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  27','2024-04-18 13:36:05',_binary ''),(733,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  28','2024-04-18 13:36:05',_binary ''),(734,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  29','2024-04-18 13:36:05',_binary ''),(735,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  30','2024-04-18 13:36:05',_binary ''),(736,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  31','2024-04-18 13:36:05',_binary ''),(737,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  32','2024-04-18 13:36:05',_binary ''),(738,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  33','2024-04-18 13:36:05',_binary ''),(739,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  34','2024-04-18 13:36:05',_binary ''),(740,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  35','2024-04-18 13:36:05',_binary ''),(741,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  36','2024-04-18 13:36:05',_binary ''),(742,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  37','2024-04-18 13:36:05',_binary ''),(743,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  38','2024-04-18 13:36:05',_binary ''),(744,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  39','2024-04-18 13:36:05',_binary ''),(745,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  40','2024-04-18 13:36:05',_binary ''),(746,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  41','2024-04-18 13:36:05',_binary ''),(747,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  42','2024-04-18 13:36:05',_binary ''),(748,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  43','2024-04-18 13:36:05',_binary ''),(749,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  44','2024-04-18 13:36:05',_binary ''),(750,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  45','2024-04-18 13:36:05',_binary ''),(751,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  46','2024-04-18 13:36:05',_binary ''),(752,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  47','2024-04-18 13:36:05',_binary ''),(753,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  48','2024-04-18 13:36:05',_binary ''),(754,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  49','2024-04-18 13:36:05',_binary ''),(755,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  50','2024-04-18 13:36:05',_binary ''),(756,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  51','2024-04-18 13:36:05',_binary ''),(757,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  52','2024-04-18 13:36:05',_binary ''),(758,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  53','2024-04-18 13:36:05',_binary ''),(759,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  54','2024-04-18 13:36:05',_binary ''),(760,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  55','2024-04-18 13:36:05',_binary ''),(761,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  56','2024-04-18 13:36:05',_binary ''),(762,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  57','2024-04-18 13:36:05',_binary ''),(763,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  58','2024-04-18 13:36:05',_binary ''),(764,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  59','2024-04-18 13:36:05',_binary ''),(765,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  60','2024-04-18 13:36:05',_binary ''),(766,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  61','2024-04-18 13:36:05',_binary ''),(767,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  62','2024-04-18 13:36:05',_binary ''),(768,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  63','2024-04-18 13:36:05',_binary ''),(769,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  64','2024-04-18 13:36:05',_binary ''),(770,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  65','2024-04-18 13:36:05',_binary ''),(771,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  66','2024-04-18 13:36:05',_binary ''),(772,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  67','2024-04-18 13:36:05',_binary ''),(773,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  68','2024-04-18 13:36:05',_binary ''),(774,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  69','2024-04-18 13:36:05',_binary ''),(775,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  70','2024-04-18 13:36:05',_binary ''),(776,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  71','2024-04-18 13:36:05',_binary ''),(777,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  72','2024-04-18 13:36:05',_binary ''),(778,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  73','2024-04-18 13:36:05',_binary ''),(779,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  74','2024-04-18 13:36:05',_binary ''),(780,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  75','2024-04-18 13:36:05',_binary ''),(781,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  76','2024-04-18 13:36:05',_binary ''),(782,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  77','2024-04-18 13:36:05',_binary ''),(783,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  78','2024-04-18 13:36:05',_binary ''),(784,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  79','2024-04-18 13:36:05',_binary ''),(785,'root@localhost','Delete','personas','Se ha eliminado una persona con el ID:  80','2024-04-18 13:36:05',_binary ''),(786,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  1 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Jazmin PRIMER APELLIDO =  Santiago SEGUNDO APELLIDO =  Bautista FECHA NACIMIENTO =  1964-05-07 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  AB- ESTATUS =   FECHA REGISTRO =  2020-02-24 10:00:21 FECHA ACTUALIZACIÓN = ','2024-04-18 13:36:07',_binary ''),(787,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  2 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Maximiliano PRIMER APELLIDO =  Moreno SEGUNDO APELLIDO =   Rivera FECHA NACIMIENTO =  1985-08-15 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  O- ESTATUS =   FECHA REGISTRO =  2024-03-03 09:13:13 FECHA ACTUALIZACIÓN = ','2024-04-18 13:36:07',_binary ''),(788,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  3 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Estrella PRIMER APELLIDO =   González SEGUNDO APELLIDO =   Rivera FECHA NACIMIENTO =  1992-12-11 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  AB- ESTATUS =   FECHA REGISTRO =  2020-09-24 18:58:29 FECHA ACTUALIZACIÓN = ','2024-04-18 13:36:07',_binary ''),(789,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  4 con los siguientes datos:  TITULO CORTESIA =  Lic. NOMBRE= Diana PRIMER APELLIDO =  Torres SEGUNDO APELLIDO =  Jiménez FECHA NACIMIENTO =  1988-04-11 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  A+ ESTATUS =   FECHA REGISTRO =  2021-04-04 13:04:32 FECHA ACTUALIZACIÓN = ','2024-04-18 13:36:07',_binary ''),(790,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  5 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Sofia PRIMER APELLIDO =   Rivera SEGUNDO APELLIDO =  Gutiérrez FECHA NACIMIENTO =  1961-09-03 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  A- ESTATUS =   FECHA REGISTRO =  2022-06-21 13:17:57 FECHA ACTUALIZACIÓN = ','2024-04-18 13:36:07',_binary ''),(791,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  6 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Marco PRIMER APELLIDO =  Contreras SEGUNDO APELLIDO =  Cortés FECHA NACIMIENTO =  1978-09-02 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  A+ ESTATUS =   FECHA REGISTRO =  2021-04-09 10:16:09 FECHA ACTUALIZACIÓN = ','2024-04-18 13:36:07',_binary ''),(792,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  7 con los siguientes datos:  TITULO CORTESIA =  Med. NOMBRE= Luz PRIMER APELLIDO =  López SEGUNDO APELLIDO =  Pérez FECHA NACIMIENTO =  1973-08-07 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  A- ESTATUS =   FECHA REGISTRO =  2023-11-13 08:24:42 FECHA ACTUALIZACIÓN = ','2024-04-18 13:36:07',_binary ''),(793,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  8 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Federico PRIMER APELLIDO =  Méndez SEGUNDO APELLIDO =  Ramírez FECHA NACIMIENTO =  1967-06-18 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  B+ ESTATUS =   FECHA REGISTRO =  2020-11-22 08:10:47 FECHA ACTUALIZACIÓN = ','2024-04-18 13:36:07',_binary ''),(794,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  9 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Edgar PRIMER APELLIDO =  Ortega SEGUNDO APELLIDO =  Gómes FECHA NACIMIENTO =  1987-03-20 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  A- ESTATUS =   FECHA REGISTRO =  2020-02-10 16:16:18 FECHA ACTUALIZACIÓN = ','2024-04-18 13:36:07',_binary ''),(795,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  10 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Flor PRIMER APELLIDO =  Castillo SEGUNDO APELLIDO =  Ramírez FECHA NACIMIENTO =  1977-08-01 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  B+ ESTATUS =   FECHA REGISTRO =  2022-11-18 11:19:39 FECHA ACTUALIZACIÓN = ','2024-04-18 13:36:07',_binary ''),(796,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  11 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Pedro PRIMER APELLIDO =  Ruíz SEGUNDO APELLIDO =  Domínguez FECHA NACIMIENTO =  1960-10-23 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  A- ESTATUS =   FECHA REGISTRO =  2020-04-02 15:15:26 FECHA ACTUALIZACIÓN = ','2024-04-18 13:36:07',_binary ''),(797,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  11 con los siguientes datos:  NOMBRE USUARIO=  Pedro Ruíz Domínguez PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Banned ULTIMA CONEXIÓN =  2021-12-08 14:32:15','2024-04-18 13:36:07',_binary ''),(798,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  12 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Ana PRIMER APELLIDO =  López SEGUNDO APELLIDO =  Chávez FECHA NACIMIENTO =  1992-06-15 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  AB- ESTATUS =   FECHA REGISTRO =  2021-01-19 11:06:14 FECHA ACTUALIZACIÓN = ','2024-04-18 13:36:07',_binary ''),(799,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  12 con los siguientes datos:  NOMBRE USUARIO=  Ana López Chávez PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Banned ULTIMA CONEXIÓN =  2022-11-13 08:14:10','2024-04-18 13:36:07',_binary ''),(800,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  13 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Daniel PRIMER APELLIDO =  Castro SEGUNDO APELLIDO =  Juárez FECHA NACIMIENTO =  2004-05-22 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  O+ ESTATUS =   FECHA REGISTRO =  2020-09-19 13:45:57 FECHA ACTUALIZACIÓN = ','2024-04-18 13:36:07',_binary ''),(801,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  13 con los siguientes datos:  NOMBRE USUARIO=  Daniel Castro Juárez PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Banned ULTIMA CONEXIÓN =  2023-12-10 08:42:03','2024-04-18 13:36:07',_binary ''),(802,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  14 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Dulce PRIMER APELLIDO =  Mendoza SEGUNDO APELLIDO =  Méndez FECHA NACIMIENTO =  1985-07-29 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  A+ ESTATUS =   FECHA REGISTRO =  2022-07-09 17:47:06 FECHA ACTUALIZACIÓN = ','2024-04-18 13:36:07',_binary ''),(803,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  14 con los siguientes datos:  NOMBRE USUARIO=  Dulce Mendoza Méndez PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Banned ULTIMA CONEXIÓN =  2023-01-31 09:41:39','2024-04-18 13:36:07',_binary ''),(804,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  15 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Jesus PRIMER APELLIDO =  Vázquez SEGUNDO APELLIDO =  Bautista FECHA NACIMIENTO =  2004-03-02 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  O+ ESTATUS =   FECHA REGISTRO =  2020-02-09 18:19:58 FECHA ACTUALIZACIÓN = ','2024-04-18 13:36:07',_binary ''),(805,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  15 con los siguientes datos:  NOMBRE USUARIO=  Jesus Vázquez Bautista PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Banned ULTIMA CONEXIÓN =  2021-01-27 14:51:04','2024-04-18 13:36:07',_binary ''),(806,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  16 con los siguientes datos:  TITULO CORTESIA =  Ing. NOMBRE= Jorge PRIMER APELLIDO =  Juárez SEGUNDO APELLIDO =  Luna FECHA NACIMIENTO =  1982-07-25 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  O+ ESTATUS =   FECHA REGISTRO =  2022-06-16 13:32:04 FECHA ACTUALIZACIÓN = ','2024-04-18 13:36:07',_binary ''),(807,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  16 con los siguientes datos:  NOMBRE USUARIO=  Ing. Jorge Juárez Luna PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Banned ULTIMA CONEXIÓN =  2023-07-18 14:50:04','2024-04-18 13:36:07',_binary ''),(808,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  17 con los siguientes datos:  TITULO CORTESIA =  Srita NOMBRE= Estrella PRIMER APELLIDO =  Castro SEGUNDO APELLIDO =  Domínguez FECHA NACIMIENTO =  1967-11-28 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  O- ESTATUS =   FECHA REGISTRO =  2020-03-01 13:25:37 FECHA ACTUALIZACIÓN = ','2024-04-18 13:36:07',_binary ''),(809,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  17 con los siguientes datos:  NOMBRE USUARIO=  Srita Estrella Castro Domínguez PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Banned ULTIMA CONEXIÓN =  2020-10-07 12:29:40','2024-04-18 13:36:07',_binary ''),(810,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  18 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Samuel PRIMER APELLIDO =  Romero SEGUNDO APELLIDO =  Vargas FECHA NACIMIENTO =  1965-05-23 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  B- ESTATUS =   FECHA REGISTRO =  2023-08-22 18:49:20 FECHA ACTUALIZACIÓN = ','2024-04-18 13:36:07',_binary ''),(811,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  18 con los siguientes datos:  NOMBRE USUARIO=  Samuel Romero Vargas PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Banned ULTIMA CONEXIÓN =  2024-04-11 09:40:06','2024-04-18 13:36:07',_binary ''),(812,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  19 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Ana PRIMER APELLIDO =  Vargas SEGUNDO APELLIDO =  Salazar FECHA NACIMIENTO =  2006-11-27 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  B- ESTATUS =   FECHA REGISTRO =  2024-03-06 16:46:04 FECHA ACTUALIZACIÓN = ','2024-04-18 13:36:07',_binary ''),(813,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  19 con los siguientes datos:  NOMBRE USUARIO=  Ana Vargas Salazar PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Banned ULTIMA CONEXIÓN =  2024-04-07 13:49:31','2024-04-18 13:36:07',_binary ''),(814,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  20 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Guadalupe PRIMER APELLIDO =  Estrada SEGUNDO APELLIDO =  Cortés FECHA NACIMIENTO =  1959-10-09 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  A- ESTATUS =   FECHA REGISTRO =  2023-02-26 10:33:56 FECHA ACTUALIZACIÓN = ','2024-04-18 13:36:07',_binary ''),(815,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  20 con los siguientes datos:  NOMBRE USUARIO=  Guadalupe Estrada Cortés PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Banned ULTIMA CONEXIÓN =  2024-02-22 16:15:15','2024-04-18 13:36:07',_binary ''),(816,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  1 con los siguientes datos:  NOMBRE =  Bebida energética post-entrenamiento MARCA =  FlexiRoll PRECIO ACTUAL =  20.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:36:07',_binary ''),(817,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  2 con los siguientes datos:  NOMBRE =  Rodillo de espuma para masaje muscular MARCA =  FlexiStrap PRECIO ACTUAL =  40.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:36:07',_binary ''),(818,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  3 con los siguientes datos:  NOMBRE =  Suplemento pre-entrenamiento MARCA =  SpeedGrip PRECIO ACTUAL =  40.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:36:07',_binary ''),(819,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  4 con los siguientes datos:  NOMBRE =  Barritas energéticas MARCA =  FlexiGrip PRECIO ACTUAL =  50.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:36:07',_binary ''),(820,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  5 con los siguientes datos:  NOMBRE =  Guantes para levantamiento de pesas MARCA =  MuscleMax PRECIO ACTUAL =  20.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:36:07',_binary ''),(821,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  6 con los siguientes datos:  NOMBRE =  Bebida isotónica MARCA =  FlexiSqueeze PRECIO ACTUAL =  60.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:36:07',_binary ''),(822,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  7 con los siguientes datos:  NOMBRE =  Termogénico para quemar grasa MARCA =  FlexiSocks PRECIO ACTUAL =  100.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:36:07',_binary ''),(823,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  8 con los siguientes datos:  NOMBRE =  Banda de resistencia para entrenamiento MARCA =  PowerHydrate PRECIO ACTUAL =  80.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:36:07',_binary ''),(824,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  9 con los siguientes datos:  NOMBRE =  Vendas para muñecas y tobillos MARCA =  FlexiBlock PRECIO ACTUAL =  40.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:36:07',_binary ''),(825,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  10 con los siguientes datos:  NOMBRE =  Magnesio para mejorar el agarre MARCA =  FlexiLoop PRECIO ACTUAL =  10.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:36:07',_binary ''),(826,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  11 con los siguientes datos:  NOMBRE =  Banda elástica para ejercicios de resistencia MARCA =  PowerCharge PRECIO ACTUAL =  90.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:36:07',_binary ''),(827,'root@localhost','Create','detalles_productos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  1 con los siguientes datos:  PRODUCTO ID =  Banda elástica para ejercicios de resistencia PowerCharge DESCRIPCION =  Botellas diseñadas para mezclar fácilmente proteína en polvo con agua o leche, convenientes para consumir bebidas nutritivas antes o después del entrenamiento. CODIGO DE BARRAS =  105389073 PRESENTACION =  C4 Original Pre-Workout) ESTATUS =  Activa','2024-04-18 13:36:07',_binary ''),(828,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  12 con los siguientes datos:  NOMBRE =  Cinturón de levantamiento de pesas MARCA =  FlexiPod PRECIO ACTUAL =  80.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:36:07',_binary ''),(829,'root@localhost','Create','detalles_productos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  2 con los siguientes datos:  PRODUCTO ID =  Cinturón de levantamiento de pesas FlexiPod DESCRIPCION =  Suplemento nutricional utilizado para aumentar la ingesta de proteínas, promover la recuperación muscular y el crecimiento después del entrenamiento. CODIGO DE BARRAS =  190532901 PRESENTACION =  Proteína Whey Gold Standard ESTATUS =  Activa','2024-04-18 13:36:07',_binary ''),(830,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  13 con los siguientes datos:  NOMBRE =  Termogénico para quemar grasa MARCA =  FlexiStick PRECIO ACTUAL =  80.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:36:07',_binary ''),(831,'root@localhost','Create','detalles_productos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  3 con los siguientes datos:  PRODUCTO ID =  Termogénico para quemar grasa FlexiStick DESCRIPCION =  Suplemento que contiene los aminoácidos esenciales leucina, isoleucina y valina, que ayudan a promover la recuperación muscular, reducir la fatiga y preservar la masa muscular durante el ejercicio. CODIGO DE BARRAS =  385987635 PRESENTACION =  C4 Original Pre-Workout) ESTATUS =  Activa','2024-04-18 13:36:07',_binary ''),(832,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  14 con los siguientes datos:  NOMBRE =  Correa de estiramiento MARCA =  PowerBlitz PRECIO ACTUAL =  10.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:36:07',_binary ''),(833,'root@localhost','Create','detalles_productos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  4 con los siguientes datos:  PRODUCTO ID =  Correa de estiramiento PowerBlitz DESCRIPCION =  Botellas diseñadas para mezclar fácilmente proteína en polvo con agua o leche, convenientes para consumir bebidas nutritivas antes o después del entrenamiento. CODIGO DE BARRAS =  450578976 PRESENTACION =   Optimum Nutrition Creatine Monohydrate ESTATUS =  Activa','2024-04-18 13:36:07',_binary ''),(834,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  15 con los siguientes datos:  NOMBRE =  Bebida isotónica MARCA =  MuscleRelief PRECIO ACTUAL =  90.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:36:07',_binary ''),(835,'root@localhost','Create','detalles_productos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  5 con los siguientes datos:  PRODUCTO ID =  Bebida isotónica MuscleRelief DESCRIPCION =  Suplemento utilizado para aumentar la fuerza, la potencia y ​​la masa muscular, al mejorar la disponibilidad de energía en los músculos durante el ejercicio de alta intensidad. CODIGO DE BARRAS =  385987635 PRESENTACION =  Proteína Whey Gold Standard ESTATUS =  Activa','2024-04-18 13:36:07',_binary ''),(836,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  16 con los siguientes datos:  NOMBRE =  Rodillo de espuma para masaje muscular MARCA =  FlexiBand PRECIO ACTUAL =  80.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:36:07',_binary ''),(837,'root@localhost','Create','detalles_productos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  6 con los siguientes datos:  PRODUCTO ID =  Rodillo de espuma para masaje muscular FlexiBand DESCRIPCION =  Suplemento que contiene ácidos grasos esenciales omega-3, conocidos por sus efectos antiinflamatorios y beneficios para la salud cardiovascular y articular. CODIGO DE BARRAS =  105389073 PRESENTACION =   Optimum Nutrition Creatine Monohydrate ESTATUS =  Activa','2024-04-18 13:36:07',_binary ''),(838,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  17 con los siguientes datos:  NOMBRE =  Magnesio para mejorar el agarre MARCA =  FlexiGel PRECIO ACTUAL =  60.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:36:07',_binary ''),(839,'root@localhost','Create','detalles_productos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  7 con los siguientes datos:  PRODUCTO ID =  Magnesio para mejorar el agarre FlexiGel DESCRIPCION =  Suplemento que contiene los aminoácidos esenciales leucina, isoleucina y valina, que ayudan a promover la recuperación muscular, reducir la fatiga y preservar la masa muscular durante el ejercicio. CODIGO DE BARRAS =  450578976 PRESENTACION =  Nordic Naturals Ultimate Omega ESTATUS =  Activa','2024-04-18 13:36:07',_binary ''),(840,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  18 con los siguientes datos:  NOMBRE =  Banda elástica para ejercicios de resistencia MARCA =  FlexiBand PRECIO ACTUAL =  40.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:36:07',_binary ''),(841,'root@localhost','Create','detalles_productos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  8 con los siguientes datos:  PRODUCTO ID =  Banda elástica para ejercicios de resistencia FlexiBand DESCRIPCION =  Suplemento que contiene ácidos grasos esenciales omega-3, conocidos por sus efectos antiinflamatorios y beneficios para la salud cardiovascular y articular. CODIGO DE BARRAS =  385987635 PRESENTACION =   Optimum Nutrition Creatine Monohydrate ESTATUS =  Activa','2024-04-18 13:36:07',_binary ''),(842,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  19 con los siguientes datos:  NOMBRE =  Banda de resistencia para entrenamiento MARCA =  FlexiBand PRECIO ACTUAL =  10.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:36:07',_binary ''),(843,'root@localhost','Create','detalles_productos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  9 con los siguientes datos:  PRODUCTO ID =  Banda de resistencia para entrenamiento FlexiBand DESCRIPCION =  Suplementos que contienen una variedad de vitaminas y minerales esenciales para apoyar la salud general, el metabolismo y la función muscular durante el ejercicio intenso. CODIGO DE BARRAS =  123457354 PRESENTACION =  Quest Nutrition Protein Bar ESTATUS =  Activa','2024-04-18 13:36:07',_binary ''),(844,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  20 con los siguientes datos:  NOMBRE =  Magnesio para mejorar el agarre MARCA =  FlexiBall PRECIO ACTUAL =  90.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:36:07',_binary ''),(845,'root@localhost','Create','detalles_productos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  10 con los siguientes datos:  PRODUCTO ID =  Magnesio para mejorar el agarre FlexiBall DESCRIPCION =  Suplemento que contiene los aminoácidos esenciales leucina, isoleucina y valina, que ayudan a promover la recuperación muscular, reducir la fatiga y preservar la masa muscular durante el ejercicio. CODIGO DE BARRAS =  123457354 PRESENTACION =  Nordic Naturals Ultimate Omega ESTATUS =  Activa','2024-04-18 13:36:07',_binary ''),(846,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  21 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Iram PRIMER APELLIDO =  Rodríguez SEGUNDO APELLIDO =  Díaz FECHA NACIMIENTO =  1973-11-19 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  B- ESTATUS =   FECHA REGISTRO =  2021-09-26 15:41:37 FECHA ACTUALIZACIÓN = ','2024-04-18 13:36:07',_binary ''),(847,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  21 con los siguientes datos:  NOMBRE USUARIO=  Iram Rodríguez Díaz PASSWORD =  TIPO =  Instructor ESTATUS CONEXIÓN =  Online ULTIMA CONEXIÓN =  2022-05-21 09:31:12','2024-04-18 13:36:07',_binary ''),(848,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  21 con los siguientes datos:  NOMBRE =  Bloque de espuma para estiramientos MARCA =  FlexiSqueeze PRECIO ACTUAL =  30.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:36:07',_binary ''),(849,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  1 con los siguientes datos:  USUARIO ID =  Iram Rodríguez Díaz PRODUCTO ID =  Bloque de espuma para estiramientos FlexiSqueeze 30.00 TOTAL =  60.00 FECHA REGISTRO =  2023-01-12 19:43:37 ESTATUS =  Activa','2024-04-18 13:36:07',_binary ''),(850,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  22 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Karla PRIMER APELLIDO =  Herrera SEGUNDO APELLIDO =  Ortiz FECHA NACIMIENTO =  1974-01-19 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  A- ESTATUS =   FECHA REGISTRO =  2023-04-19 13:13:11 FECHA ACTUALIZACIÓN = ','2024-04-18 13:36:07',_binary ''),(851,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  22 con los siguientes datos:  NOMBRE USUARIO=  Karla Herrera Ortiz PASSWORD =  TIPO =  Instructor ESTATUS CONEXIÓN =  Online ULTIMA CONEXIÓN =  2023-12-19 10:02:30','2024-04-18 13:36:07',_binary ''),(852,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  22 con los siguientes datos:  NOMBRE =  Bebida energética post-entrenamiento MARCA =  MusclePatch PRECIO ACTUAL =  10.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:36:07',_binary ''),(853,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  2 con los siguientes datos:  USUARIO ID =  Karla Herrera Ortiz PRODUCTO ID =  Bebida energética post-entrenamiento MusclePatch 10.00 TOTAL =  20.00 FECHA REGISTRO =  2021-12-31 19:20:43 ESTATUS =  Activa','2024-04-18 13:36:07',_binary ''),(854,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  23 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Luz PRIMER APELLIDO =  López SEGUNDO APELLIDO =  Soto FECHA NACIMIENTO =  1998-01-02 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  O- ESTATUS =   FECHA REGISTRO =  2021-12-18 12:40:44 FECHA ACTUALIZACIÓN = ','2024-04-18 13:36:07',_binary ''),(855,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  23 con los siguientes datos:  NOMBRE USUARIO=  Luz López Soto PASSWORD =  TIPO =  Miembro ESTATUS CONEXIÓN =  Banned ULTIMA CONEXIÓN =  2023-12-25 09:57:27','2024-04-18 13:36:07',_binary ''),(856,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  23 con los siguientes datos:  NOMBRE =  Barritas energéticas MARCA =  FlexiBlock PRECIO ACTUAL =  50.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:36:07',_binary ''),(857,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  3 con los siguientes datos:  USUARIO ID =  Luz López Soto PRODUCTO ID =  Barritas energéticas FlexiBlock 50.00 TOTAL =  40.00 FECHA REGISTRO =  2022-04-01 13:56:21 ESTATUS =  Activa','2024-04-18 13:36:07',_binary ''),(858,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  24 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Jesus PRIMER APELLIDO =  Reyes SEGUNDO APELLIDO =  Cortés FECHA NACIMIENTO =  1960-08-10 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  A- ESTATUS =   FECHA REGISTRO =  2024-02-22 10:18:25 FECHA ACTUALIZACIÓN = ','2024-04-18 13:36:07',_binary ''),(859,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  24 con los siguientes datos:  NOMBRE USUARIO=  Jesus Reyes Cortés PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Banned ULTIMA CONEXIÓN =  2024-03-30 19:27:54','2024-04-18 13:36:07',_binary ''),(860,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  24 con los siguientes datos:  NOMBRE =  Bebida energética post-entrenamiento MARCA =  PowerHydrate PRECIO ACTUAL =  60.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:36:07',_binary ''),(861,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  4 con los siguientes datos:  USUARIO ID =  Jesus Reyes Cortés PRODUCTO ID =  Bebida energética post-entrenamiento PowerHydrate 60.00 TOTAL =  20.00 FECHA REGISTRO =  2020-03-31 18:27:56 ESTATUS =  Activa','2024-04-18 13:36:07',_binary ''),(862,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  25 con los siguientes datos:  TITULO CORTESIA =  Ing. NOMBRE= Ricardo PRIMER APELLIDO =  Bautista SEGUNDO APELLIDO =  Sánchez FECHA NACIMIENTO =  2002-07-02 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  O- ESTATUS =   FECHA REGISTRO =  2020-08-05 17:51:32 FECHA ACTUALIZACIÓN = ','2024-04-18 13:36:07',_binary ''),(863,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  25 con los siguientes datos:  NOMBRE USUARIO=  Ing. Ricardo Bautista Sánchez PASSWORD =  TIPO =  Miembro ESTATUS CONEXIÓN =  Banned ULTIMA CONEXIÓN =  2024-01-02 15:13:32','2024-04-18 13:36:07',_binary ''),(864,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  25 con los siguientes datos:  NOMBRE =  Barritas energéticas MARCA =  PowerLift PRECIO ACTUAL =  50.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:36:07',_binary ''),(865,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  5 con los siguientes datos:  USUARIO ID =  Ing. Ricardo Bautista Sánchez PRODUCTO ID =  Barritas energéticas PowerLift 50.00 TOTAL =  100.00 FECHA REGISTRO =  2022-04-18 16:36:15 ESTATUS =  Activa','2024-04-18 13:36:07',_binary ''),(866,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  26 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Paula PRIMER APELLIDO =  Pérez SEGUNDO APELLIDO =  Estrada FECHA NACIMIENTO =  1972-05-14 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  AB+ ESTATUS =   FECHA REGISTRO =  2020-03-08 14:06:19 FECHA ACTUALIZACIÓN = ','2024-04-18 13:36:07',_binary ''),(867,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  26 con los siguientes datos:  NOMBRE USUARIO=  Paula Pérez Estrada PASSWORD =  TIPO =  Visitante ESTATUS CONEXIÓN =  Offline ULTIMA CONEXIÓN =  2022-03-26 18:07:28','2024-04-18 13:36:07',_binary ''),(868,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  26 con los siguientes datos:  NOMBRE =  Banda elástica para ejercicios de resistencia MARCA =  StaminaBoost PRECIO ACTUAL =  30.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:36:07',_binary ''),(869,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  6 con los siguientes datos:  USUARIO ID =  Paula Pérez Estrada PRODUCTO ID =  Banda elástica para ejercicios de resistencia StaminaBoost 30.00 TOTAL =  20.00 FECHA REGISTRO =  2020-03-15 16:11:12 ESTATUS =  Activa','2024-04-18 13:36:07',_binary ''),(870,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  27 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= José PRIMER APELLIDO =  Mendoza SEGUNDO APELLIDO =  Pérez FECHA NACIMIENTO =  1974-09-15 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  A- ESTATUS =   FECHA REGISTRO =  2020-11-27 12:21:16 FECHA ACTUALIZACIÓN = ','2024-04-18 13:36:07',_binary ''),(871,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  27 con los siguientes datos:  NOMBRE USUARIO=  José Mendoza Pérez PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Banned ULTIMA CONEXIÓN =  2022-09-26 10:58:49','2024-04-18 13:36:07',_binary ''),(872,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  27 con los siguientes datos:  NOMBRE =  Magnesio para mejorar el agarre MARCA =  FlexiMat PRECIO ACTUAL =  100.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:36:07',_binary ''),(873,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  7 con los siguientes datos:  USUARIO ID =  José Mendoza Pérez PRODUCTO ID =  Magnesio para mejorar el agarre FlexiMat 100.00 TOTAL =  80.00 FECHA REGISTRO =  2020-03-23 18:21:32 ESTATUS =  Activa','2024-04-18 13:36:07',_binary ''),(874,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  28 con los siguientes datos:  TITULO CORTESIA =  Med. NOMBRE= Pedro PRIMER APELLIDO =  Ortega SEGUNDO APELLIDO =   González FECHA NACIMIENTO =  1998-06-20 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  AB- ESTATUS =   FECHA REGISTRO =  2021-03-26 10:40:12 FECHA ACTUALIZACIÓN = ','2024-04-18 13:36:07',_binary ''),(875,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  28 con los siguientes datos:  NOMBRE USUARIO=  Med. Pedro Ortega  González PASSWORD =  TIPO =  Visitante ESTATUS CONEXIÓN =  Offline ULTIMA CONEXIÓN =  2021-11-25 11:40:14','2024-04-18 13:36:07',_binary ''),(876,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  28 con los siguientes datos:  NOMBRE =  Bloque de espuma para estiramientos MARCA =  PowerLift PRECIO ACTUAL =  70.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:36:07',_binary ''),(877,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  8 con los siguientes datos:  USUARIO ID =  Med. Pedro Ortega  González PRODUCTO ID =  Bloque de espuma para estiramientos PowerLift 70.00 TOTAL =  90.00 FECHA REGISTRO =  2022-04-17 19:39:55 ESTATUS =  Activa','2024-04-18 13:36:07',_binary ''),(878,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  29 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Alejandro PRIMER APELLIDO =  Méndez SEGUNDO APELLIDO =  Díaz FECHA NACIMIENTO =  1962-09-19 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  B+ ESTATUS =   FECHA REGISTRO =  2021-06-17 17:13:41 FECHA ACTUALIZACIÓN = ','2024-04-18 13:36:07',_binary ''),(879,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  29 con los siguientes datos:  NOMBRE USUARIO=  Alejandro Méndez Díaz PASSWORD =  TIPO =  Instructor ESTATUS CONEXIÓN =  Banned ULTIMA CONEXIÓN =  2023-04-06 16:30:41','2024-04-18 13:36:07',_binary ''),(880,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  29 con los siguientes datos:  NOMBRE =  Magnesio para mejorar el agarre MARCA =  MuscleMax PRECIO ACTUAL =  50.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:36:07',_binary ''),(881,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  9 con los siguientes datos:  USUARIO ID =  Alejandro Méndez Díaz PRODUCTO ID =  Magnesio para mejorar el agarre MuscleMax 50.00 TOTAL =  10.00 FECHA REGISTRO =  2022-11-16 12:08:21 ESTATUS =  Activa','2024-04-18 13:36:07',_binary ''),(882,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  30 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Estrella PRIMER APELLIDO =  Mendoza SEGUNDO APELLIDO =  Morales FECHA NACIMIENTO =  2005-11-05 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  A+ ESTATUS =   FECHA REGISTRO =  2021-04-02 12:28:34 FECHA ACTUALIZACIÓN = ','2024-04-18 13:36:07',_binary ''),(883,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  30 con los siguientes datos:  NOMBRE USUARIO=  Estrella Mendoza Morales PASSWORD =  TIPO =  Instructor ESTATUS CONEXIÓN =  Banned ULTIMA CONEXIÓN =  2021-11-01 13:31:55','2024-04-18 13:36:07',_binary ''),(884,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  30 con los siguientes datos:  NOMBRE =  Banda elástica para ejercicios de resistencia MARCA =  PowerBurn PRECIO ACTUAL =  20.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:36:07',_binary ''),(885,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  10 con los siguientes datos:  USUARIO ID =  Estrella Mendoza Morales PRODUCTO ID =  Banda elástica para ejercicios de resistencia PowerBurn 20.00 TOTAL =  100.00 FECHA REGISTRO =  2020-07-30 19:15:13 ESTATUS =  Activa','2024-04-18 13:36:07',_binary ''),(886,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  31 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Suri PRIMER APELLIDO =   González SEGUNDO APELLIDO =  Guerrero FECHA NACIMIENTO =  1972-07-24 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  AB- ESTATUS =   FECHA REGISTRO =  2021-05-23 16:52:04 FECHA ACTUALIZACIÓN = ','2024-04-18 13:36:07',_binary ''),(887,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  31 con los siguientes datos:  NOMBRE USUARIO=  Suri  González Guerrero PASSWORD =  TIPO =  Miembro ESTATUS CONEXIÓN =  Offline ULTIMA CONEXIÓN =  2023-09-28 18:16:51','2024-04-18 13:36:07',_binary ''),(888,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  31 con los siguientes datos:  NOMBRE =  Bloque de espuma para estiramientos MARCA =  PowerBlitz PRECIO ACTUAL =  10.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:36:07',_binary ''),(889,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  11 con los siguientes datos:  USUARIO ID =  Suri  González Guerrero PRODUCTO ID =  Bloque de espuma para estiramientos PowerBlitz 10.00 TOTAL =  10.00 FECHA REGISTRO =  2023-12-03 14:38:30 ESTATUS =  Activa','2024-04-18 13:36:07',_binary ''),(890,'root@localhost','Create','detalles_pedidos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  1 con los siguientes datos:  PEDIDO ID =  31 10.00 2023-12-03 14:38:30 PRODUCTO ID =  Bebida energética post-entrenamiento FlexiRoll CANTIDAD =  10 TOTAL PARCIAL =  50.00 FECHA REGISTRO =  2021-08-07 12:36:32 FECHA ENTREGA =  2024-04-18 13:36:07 ESTATUS =  Activa','2024-04-18 13:36:07',_binary ''),(891,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  32 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Paula PRIMER APELLIDO =  Guerrero SEGUNDO APELLIDO =  Salazar FECHA NACIMIENTO =  1981-08-05 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  O+ ESTATUS =   FECHA REGISTRO =  2022-02-19 10:00:43 FECHA ACTUALIZACIÓN = ','2024-04-18 13:36:07',_binary ''),(892,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  32 con los siguientes datos:  NOMBRE USUARIO=  Paula Guerrero Salazar PASSWORD =  TIPO =  Visitante ESTATUS CONEXIÓN =  Online ULTIMA CONEXIÓN =  2022-05-29 19:09:28','2024-04-18 13:36:07',_binary ''),(893,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  32 con los siguientes datos:  NOMBRE =  Suplemento pre-entrenamiento MARCA =  FlexiBottle PRECIO ACTUAL =  10.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:36:07',_binary ''),(894,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  12 con los siguientes datos:  USUARIO ID =  Paula Guerrero Salazar PRODUCTO ID =  Suplemento pre-entrenamiento FlexiBottle 10.00 TOTAL =  40.00 FECHA REGISTRO =  2023-01-08 13:44:28 ESTATUS =  Activa','2024-04-18 13:36:07',_binary ''),(895,'root@localhost','Create','detalles_pedidos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  2 con los siguientes datos:  PEDIDO ID =  32 40.00 2023-01-08 13:44:28 PRODUCTO ID =  Bebida energética post-entrenamiento FlexiRoll CANTIDAD =  380 TOTAL PARCIAL =  100.00 FECHA REGISTRO =  2020-05-02 13:11:42 FECHA ENTREGA =  2024-04-18 13:36:07 ESTATUS =  Activa','2024-04-18 13:36:07',_binary ''),(896,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  33 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Samuel PRIMER APELLIDO =  Vargas SEGUNDO APELLIDO =  Contreras FECHA NACIMIENTO =  2001-06-16 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  O+ ESTATUS =   FECHA REGISTRO =  2023-01-27 19:57:41 FECHA ACTUALIZACIÓN = ','2024-04-18 13:36:07',_binary ''),(897,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  33 con los siguientes datos:  NOMBRE USUARIO=  Samuel Vargas Contreras PASSWORD =  TIPO =  Instructor ESTATUS CONEXIÓN =  Online ULTIMA CONEXIÓN =  2023-09-14 19:22:48','2024-04-18 13:36:07',_binary ''),(898,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  33 con los siguientes datos:  NOMBRE =  Barritas energéticas MARCA =  FlexiLoop PRECIO ACTUAL =  30.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:36:07',_binary ''),(899,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  13 con los siguientes datos:  USUARIO ID =  Samuel Vargas Contreras PRODUCTO ID =  Barritas energéticas FlexiLoop 30.00 TOTAL =  60.00 FECHA REGISTRO =  2020-05-19 17:50:53 ESTATUS =  Activa','2024-04-18 13:36:07',_binary ''),(900,'root@localhost','Create','detalles_pedidos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  3 con los siguientes datos:  PEDIDO ID =  33 60.00 2020-05-19 17:50:53 PRODUCTO ID =  Bebida energética post-entrenamiento FlexiRoll CANTIDAD =  60 TOTAL PARCIAL =  80.00 FECHA REGISTRO =  2020-06-22 12:33:38 FECHA ENTREGA =  2024-04-18 13:36:07 ESTATUS =  Activa','2024-04-18 13:36:07',_binary ''),(901,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  34 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Flor PRIMER APELLIDO =  Santiago SEGUNDO APELLIDO =  Hernández FECHA NACIMIENTO =  1981-06-17 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  A- ESTATUS =   FECHA REGISTRO =  2022-10-31 16:12:29 FECHA ACTUALIZACIÓN = ','2024-04-18 13:36:07',_binary ''),(902,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  34 con los siguientes datos:  NOMBRE USUARIO=  Flor Santiago Hernández PASSWORD =  TIPO =  Visitante ESTATUS CONEXIÓN =  Online ULTIMA CONEXIÓN =  2023-07-30 08:28:28','2024-04-18 13:36:07',_binary ''),(903,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  34 con los siguientes datos:  NOMBRE =  Termogénico para quemar grasa MARCA =  MuscleRelief PRECIO ACTUAL =  20.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:36:07',_binary ''),(904,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  14 con los siguientes datos:  USUARIO ID =  Flor Santiago Hernández PRODUCTO ID =  Termogénico para quemar grasa MuscleRelief 20.00 TOTAL =  20.00 FECHA REGISTRO =  2021-02-20 18:15:22 ESTATUS =  Activa','2024-04-18 13:36:07',_binary ''),(905,'root@localhost','Create','detalles_pedidos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  4 con los siguientes datos:  PEDIDO ID =  34 20.00 2021-02-20 18:15:22 PRODUCTO ID =  Bebida energética post-entrenamiento FlexiRoll CANTIDAD =  450 TOTAL PARCIAL =  90.00 FECHA REGISTRO =  2022-11-28 19:02:27 FECHA ENTREGA =  2024-04-18 13:36:07 ESTATUS =  Activa','2024-04-18 13:36:07',_binary ''),(906,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  35 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Jorge PRIMER APELLIDO =  Díaz SEGUNDO APELLIDO =  Juárez FECHA NACIMIENTO =  2007-08-28 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  A+ ESTATUS =   FECHA REGISTRO =  2022-05-10 13:12:40 FECHA ACTUALIZACIÓN = ','2024-04-18 13:36:07',_binary ''),(907,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  35 con los siguientes datos:  NOMBRE USUARIO=  Jorge Díaz Juárez PASSWORD =  TIPO =  Miembro ESTATUS CONEXIÓN =  Offline ULTIMA CONEXIÓN =  2022-07-17 13:39:53','2024-04-18 13:36:07',_binary ''),(908,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  35 con los siguientes datos:  NOMBRE =  Guantes para levantamiento de pesas MARCA =  MuscleFlow PRECIO ACTUAL =  60.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:36:07',_binary ''),(909,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  15 con los siguientes datos:  USUARIO ID =  Jorge Díaz Juárez PRODUCTO ID =  Guantes para levantamiento de pesas MuscleFlow 60.00 TOTAL =  80.00 FECHA REGISTRO =  2020-09-13 15:03:38 ESTATUS =  Activa','2024-04-18 13:36:07',_binary ''),(910,'root@localhost','Create','detalles_pedidos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  5 con los siguientes datos:  PEDIDO ID =  35 80.00 2020-09-13 15:03:38 PRODUCTO ID =  Bebida energética post-entrenamiento FlexiRoll CANTIDAD =  450 TOTAL PARCIAL =  50.00 FECHA REGISTRO =  2020-07-09 09:25:35 FECHA ENTREGA =  2024-04-18 13:36:07 ESTATUS =  Activa','2024-04-18 13:36:07',_binary ''),(911,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  36 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Karla PRIMER APELLIDO =  Pérez SEGUNDO APELLIDO =  Herrera FECHA NACIMIENTO =  2006-06-10 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  O+ ESTATUS =   FECHA REGISTRO =  2021-02-10 17:41:56 FECHA ACTUALIZACIÓN = ','2024-04-18 13:36:07',_binary ''),(912,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  36 con los siguientes datos:  NOMBRE USUARIO=  Karla Pérez Herrera PASSWORD =  TIPO =  Visitante ESTATUS CONEXIÓN =  Banned ULTIMA CONEXIÓN =  2023-04-18 16:51:29','2024-04-18 13:36:07',_binary ''),(913,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  36 con los siguientes datos:  NOMBRE =  Magnesio para mejorar el agarre MARCA =  PowerStim PRECIO ACTUAL =  100.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:36:07',_binary ''),(914,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  16 con los siguientes datos:  USUARIO ID =  Karla Pérez Herrera PRODUCTO ID =  Magnesio para mejorar el agarre PowerStim 100.00 TOTAL =  80.00 FECHA REGISTRO =  2023-09-30 10:01:40 ESTATUS =  Activa','2024-04-18 13:36:07',_binary ''),(915,'root@localhost','Create','detalles_pedidos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  6 con los siguientes datos:  PEDIDO ID =  36 80.00 2023-09-30 10:01:40 PRODUCTO ID =  Bebida energética post-entrenamiento FlexiRoll CANTIDAD =  380 TOTAL PARCIAL =  70.00 FECHA REGISTRO =  2022-03-12 15:35:23 FECHA ENTREGA =  2024-04-18 13:36:07 ESTATUS =  Activa','2024-04-18 13:36:07',_binary ''),(916,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  37 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Mario PRIMER APELLIDO =  Morales SEGUNDO APELLIDO =  López FECHA NACIMIENTO =  1987-09-03 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  AB- ESTATUS =   FECHA REGISTRO =  2022-11-19 11:42:43 FECHA ACTUALIZACIÓN = ','2024-04-18 13:36:07',_binary ''),(917,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  37 con los siguientes datos:  NOMBRE USUARIO=  Mario Morales López PASSWORD =  TIPO =  Miembro ESTATUS CONEXIÓN =  Banned ULTIMA CONEXIÓN =  2023-01-15 11:54:01','2024-04-18 13:36:07',_binary ''),(918,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  37 con los siguientes datos:  NOMBRE =  Suplemento pre-entrenamiento MARCA =  PowerBar PRECIO ACTUAL =  60.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:36:07',_binary ''),(919,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  17 con los siguientes datos:  USUARIO ID =  Mario Morales López PRODUCTO ID =  Suplemento pre-entrenamiento PowerBar 60.00 TOTAL =  50.00 FECHA REGISTRO =  2021-09-04 16:03:33 ESTATUS =  Activa','2024-04-18 13:36:07',_binary ''),(920,'root@localhost','Create','detalles_pedidos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  7 con los siguientes datos:  PEDIDO ID =  37 50.00 2021-09-04 16:03:33 PRODUCTO ID =  Bebida energética post-entrenamiento FlexiRoll CANTIDAD =  10 TOTAL PARCIAL =  100.00 FECHA REGISTRO =  2020-03-23 13:56:11 FECHA ENTREGA =  2024-04-18 13:36:07 ESTATUS =  Activa','2024-04-18 13:36:07',_binary ''),(921,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  38 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Yair PRIMER APELLIDO =  Reyes SEGUNDO APELLIDO =  Santiago FECHA NACIMIENTO =  1988-09-05 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  B+ ESTATUS =   FECHA REGISTRO =  2023-07-19 09:48:05 FECHA ACTUALIZACIÓN = ','2024-04-18 13:36:07',_binary ''),(922,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  38 con los siguientes datos:  NOMBRE USUARIO=  Yair Reyes Santiago PASSWORD =  TIPO =  Visitante ESTATUS CONEXIÓN =  Banned ULTIMA CONEXIÓN =  2024-02-29 11:40:54','2024-04-18 13:36:07',_binary ''),(923,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  38 con los siguientes datos:  NOMBRE =  Guantes para levantamiento de pesas MARCA =  FlexiWheel PRECIO ACTUAL =  10.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:36:07',_binary ''),(924,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  18 con los siguientes datos:  USUARIO ID =  Yair Reyes Santiago PRODUCTO ID =  Guantes para levantamiento de pesas FlexiWheel 10.00 TOTAL =  10.00 FECHA REGISTRO =  2020-06-21 11:45:41 ESTATUS =  Activa','2024-04-18 13:36:07',_binary ''),(925,'root@localhost','Create','detalles_pedidos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  8 con los siguientes datos:  PEDIDO ID =  38 10.00 2020-06-21 11:45:41 PRODUCTO ID =  Bebida energética post-entrenamiento FlexiRoll CANTIDAD =  380 TOTAL PARCIAL =  30.00 FECHA REGISTRO =  2022-03-15 17:56:56 FECHA ENTREGA =  2024-04-18 13:36:07 ESTATUS =  Activa','2024-04-18 13:36:07',_binary ''),(926,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  39 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Valeria PRIMER APELLIDO =  Soto SEGUNDO APELLIDO =  Rodríguez FECHA NACIMIENTO =  1994-03-27 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  A- ESTATUS =   FECHA REGISTRO =  2023-01-17 08:25:23 FECHA ACTUALIZACIÓN = ','2024-04-18 13:36:07',_binary ''),(927,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  39 con los siguientes datos:  NOMBRE USUARIO=  Valeria Soto Rodríguez PASSWORD =  TIPO =  Empleado ESTATUS CONEXIÓN =  Online ULTIMA CONEXIÓN =  2023-10-04 12:57:35','2024-04-18 13:36:07',_binary ''),(928,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  39 con los siguientes datos:  NOMBRE =  Esterilla de yoga MARCA =  PowerGrip PRECIO ACTUAL =  80.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:36:07',_binary ''),(929,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  19 con los siguientes datos:  USUARIO ID =  Valeria Soto Rodríguez PRODUCTO ID =  Esterilla de yoga PowerGrip 80.00 TOTAL =  100.00 FECHA REGISTRO =  2021-09-13 10:59:48 ESTATUS =  Activa','2024-04-18 13:36:07',_binary ''),(930,'root@localhost','Create','detalles_pedidos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  9 con los siguientes datos:  PEDIDO ID =  39 100.00 2021-09-13 10:59:48 PRODUCTO ID =  Bebida energética post-entrenamiento FlexiRoll CANTIDAD =  10 TOTAL PARCIAL =  60.00 FECHA REGISTRO =  2022-08-05 12:07:36 FECHA ENTREGA =  2024-04-18 13:36:07 ESTATUS =  Activa','2024-04-18 13:36:07',_binary ''),(931,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  40 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Sofia PRIMER APELLIDO =  Vargas SEGUNDO APELLIDO =  López FECHA NACIMIENTO =  1966-09-07 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  AB+ ESTATUS =   FECHA REGISTRO =  2021-05-28 19:36:41 FECHA ACTUALIZACIÓN = ','2024-04-18 13:36:07',_binary ''),(932,'root@localhost','Create','usuarios','Se ha insertado un nuevo USUARIO con el ID:  40 con los siguientes datos:  NOMBRE USUARIO=  Sofia Vargas López PASSWORD =  TIPO =  Instructor ESTATUS CONEXIÓN =  Offline ULTIMA CONEXIÓN =  2022-05-20 14:33:17','2024-04-18 13:36:07',_binary ''),(933,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  40 con los siguientes datos:  NOMBRE =  Banda elástica para ejercicios de resistencia MARCA =  MuscleFlow PRECIO ACTUAL =  60.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:36:07',_binary ''),(934,'root@localhost','Create','pedidos','Se ha insertado un nuevo PEDIDO con el ID:  20 con los siguientes datos:  USUARIO ID =  Sofia Vargas López PRODUCTO ID =  Banda elástica para ejercicios de resistencia MuscleFlow 60.00 TOTAL =  100.00 FECHA REGISTRO =  2021-01-05 10:42:11 ESTATUS =  Activa','2024-04-18 13:36:07',_binary ''),(935,'root@localhost','Create','detalles_pedidos','Se ha insertado una nuevo DETALLE_PEDIDO con el ID:  10 con los siguientes datos:  PEDIDO ID =  40 100.00 2021-01-05 10:42:11 PRODUCTO ID =  Bebida energética post-entrenamiento FlexiRoll CANTIDAD =  450 TOTAL PARCIAL =  50.00 FECHA REGISTRO =  2023-08-15 19:25:49 FECHA ENTREGA =  2024-04-18 13:36:07 ESTATUS =  Activa','2024-04-18 13:36:07',_binary ''),(936,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  41 con los siguientes datos:  NOMBRE =  Barritas energéticas MARCA =  PowerPulse PRECIO ACTUAL =  90.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:36:07',_binary ''),(937,'root@localhost','Create','promociones','Se ha insertado una nueva PROMOCION con el ID:  1 con los siguientes datos:  PRODUCTO ID =  Barritas energéticas PowerPulse TIPO DE PROMOCION =  personalizado APLICA EN =  Producto ESTATUS =  Activa','2024-04-18 13:36:07',_binary ''),(938,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  42 con los siguientes datos:  NOMBRE =  Bebida energética pre-entrenamiento MARCA =  SpeedWrap PRECIO ACTUAL =  80.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:36:07',_binary ''),(939,'root@localhost','Create','promociones','Se ha insertado una nueva PROMOCION con el ID:  2 con los siguientes datos:  PRODUCTO ID =  Bebida energética pre-entrenamiento SpeedWrap TIPO DE PROMOCION =  complementarios APLICA EN =  Membresia ESTATUS =  Activa','2024-04-18 13:36:07',_binary ''),(940,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  43 con los siguientes datos:  NOMBRE =  Termogénico para quemar grasa MARCA =  SpeedMate PRECIO ACTUAL =  40.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:36:07',_binary ''),(941,'root@localhost','Create','promociones','Se ha insertado una nueva PROMOCION con el ID:  3 con los siguientes datos:  PRODUCTO ID =  Termogénico para quemar grasa SpeedMate TIPO DE PROMOCION =  personalizado APLICA EN =  Membresia ESTATUS =  Activa','2024-04-18 13:36:07',_binary ''),(942,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  44 con los siguientes datos:  NOMBRE =  Bebida energética pre-entrenamiento MARCA =  FlexiBall PRECIO ACTUAL =  40.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:36:07',_binary ''),(943,'root@localhost','Create','promociones','Se ha insertado una nueva PROMOCION con el ID:  4 con los siguientes datos:  PRODUCTO ID =  Bebida energética pre-entrenamiento FlexiBall TIPO DE PROMOCION =  recompensas APLICA EN =  Membresia ESTATUS =  Activa','2024-04-18 13:36:07',_binary ''),(944,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  45 con los siguientes datos:  NOMBRE =  Colchoneta para ejercicios MARCA =  FlexiPod PRECIO ACTUAL =  40.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:36:07',_binary ''),(945,'root@localhost','Create','promociones','Se ha insertado una nueva PROMOCION con el ID:  5 con los siguientes datos:  PRODUCTO ID =  Colchoneta para ejercicios FlexiPod TIPO DE PROMOCION =  membresias APLICA EN =  Membresia ESTATUS =  Activa','2024-04-18 13:36:07',_binary ''),(946,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  46 con los siguientes datos:  NOMBRE =  Bloque de espuma para estiramientos MARCA =  PowerStim PRECIO ACTUAL =  40.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:36:07',_binary ''),(947,'root@localhost','Create','promociones','Se ha insertado una nueva PROMOCION con el ID:  6 con los siguientes datos:  PRODUCTO ID =  Bloque de espuma para estiramientos PowerStim TIPO DE PROMOCION =  complementarios APLICA EN =  Membresia ESTATUS =  Activa','2024-04-18 13:36:07',_binary ''),(948,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  47 con los siguientes datos:  NOMBRE =  Banda elástica para ejercicios de resistencia MARCA =  SpeedGrip PRECIO ACTUAL =  20.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:36:07',_binary ''),(949,'root@localhost','Create','promociones','Se ha insertado una nueva PROMOCION con el ID:  7 con los siguientes datos:  PRODUCTO ID =  Banda elástica para ejercicios de resistencia SpeedGrip TIPO DE PROMOCION =  recompensas APLICA EN =  Producto ESTATUS =  Activa','2024-04-18 13:36:07',_binary ''),(950,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  48 con los siguientes datos:  NOMBRE =  Batidos de proteínas MARCA =  MuscleMax PRECIO ACTUAL =  30.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:36:07',_binary ''),(951,'root@localhost','Create','promociones','Se ha insertado una nueva PROMOCION con el ID:  8 con los siguientes datos:  PRODUCTO ID =  Batidos de proteínas MuscleMax TIPO DE PROMOCION =  membresias APLICA EN =  Membresia ESTATUS =  Activa','2024-04-18 13:36:07',_binary ''),(952,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  49 con los siguientes datos:  NOMBRE =  Colchoneta para ejercicios MARCA =  MuscleFlow PRECIO ACTUAL =  50.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:36:07',_binary ''),(953,'root@localhost','Create','promociones','Se ha insertado una nueva PROMOCION con el ID:  9 con los siguientes datos:  PRODUCTO ID =  Colchoneta para ejercicios MuscleFlow TIPO DE PROMOCION =  membresias APLICA EN =  Producto ESTATUS =  Activa','2024-04-18 13:36:07',_binary ''),(954,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  50 con los siguientes datos:  NOMBRE =  Bebida energética post-entrenamiento MARCA =  PowerLift PRECIO ACTUAL =  80.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:36:07',_binary ''),(955,'root@localhost','Create','promociones','Se ha insertado una nueva PROMOCION con el ID:  10 con los siguientes datos:  PRODUCTO ID =  Bebida energética post-entrenamiento PowerLift TIPO DE PROMOCION =  personalizado APLICA EN =  Producto ESTATUS =  Activa','2024-04-18 13:36:07',_binary ''),(956,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  51 con los siguientes datos:  NOMBRE =  Batidos de proteínas MARCA =  PowerHydrate PRECIO ACTUAL =  90.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:36:07',_binary ''),(957,'root@localhost','Create','promociones','Se ha insertado una nueva PROMOCION con el ID:  11 con los siguientes datos:  PRODUCTO ID =  Batidos de proteínas PowerHydrate TIPO DE PROMOCION =  recompensas APLICA EN =  Producto ESTATUS =  Activa','2024-04-18 13:36:07',_binary ''),(958,'root@localhost','Create','detalles_promociones','Se ha insertado una nueva PROMOCION con el ID:  1 con los siguientes datos:  PROMOCIONES ID =  recompensas FECHA DE INICIO =  2023-01-18 14:33:42 FECHA DE FINALIZACION =  2020-08-03 08:32:23 ESTATUS =  Activa','2024-04-18 13:36:07',_binary ''),(959,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  52 con los siguientes datos:  NOMBRE =  Bebida energética post-entrenamiento MARCA =  FlexiPod PRECIO ACTUAL =  30.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:36:07',_binary ''),(960,'root@localhost','Create','promociones','Se ha insertado una nueva PROMOCION con el ID:  12 con los siguientes datos:  PRODUCTO ID =  Bebida energética post-entrenamiento FlexiPod TIPO DE PROMOCION =  personalizado APLICA EN =  Producto ESTATUS =  Activa','2024-04-18 13:36:07',_binary ''),(961,'root@localhost','Create','detalles_promociones','Se ha insertado una nueva PROMOCION con el ID:  2 con los siguientes datos:  PROMOCIONES ID =  personalizado FECHA DE INICIO =  2024-01-07 18:22:06 FECHA DE FINALIZACION =  2021-10-06 13:30:51 ESTATUS =  Activa','2024-04-18 13:36:07',_binary ''),(962,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  53 con los siguientes datos:  NOMBRE =  Guantes para levantamiento de pesas MARCA =  MuscleFlow PRECIO ACTUAL =  60.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:36:07',_binary ''),(963,'root@localhost','Create','promociones','Se ha insertado una nueva PROMOCION con el ID:  13 con los siguientes datos:  PRODUCTO ID =  Guantes para levantamiento de pesas MuscleFlow TIPO DE PROMOCION =  membresias APLICA EN =  Membresia ESTATUS =  Activa','2024-04-18 13:36:07',_binary ''),(964,'root@localhost','Create','detalles_promociones','Se ha insertado una nueva PROMOCION con el ID:  3 con los siguientes datos:  PROMOCIONES ID =  membresias FECHA DE INICIO =  2019-09-28 15:36:16 FECHA DE FINALIZACION =  2022-09-30 11:31:14 ESTATUS =  Activa','2024-04-18 13:36:07',_binary ''),(965,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  54 con los siguientes datos:  NOMBRE =  Rodillo de espuma para masaje muscular MARCA =  FlexiGel PRECIO ACTUAL =  80.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:36:07',_binary ''),(966,'root@localhost','Create','promociones','Se ha insertado una nueva PROMOCION con el ID:  14 con los siguientes datos:  PRODUCTO ID =  Rodillo de espuma para masaje muscular FlexiGel TIPO DE PROMOCION =  recompensas APLICA EN =  Membresia ESTATUS =  Activa','2024-04-18 13:36:07',_binary ''),(967,'root@localhost','Create','detalles_promociones','Se ha insertado una nueva PROMOCION con el ID:  4 con los siguientes datos:  PROMOCIONES ID =  recompensas FECHA DE INICIO =  2019-01-04 18:19:41 FECHA DE FINALIZACION =  2020-01-16 13:37:27 ESTATUS =  Activa','2024-04-18 13:36:07',_binary ''),(968,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  55 con los siguientes datos:  NOMBRE =  Banda de resistencia para estiramientos MARCA =  FlexiRoll PRECIO ACTUAL =  90.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:36:07',_binary ''),(969,'root@localhost','Create','promociones','Se ha insertado una nueva PROMOCION con el ID:  15 con los siguientes datos:  PRODUCTO ID =  Banda de resistencia para estiramientos FlexiRoll TIPO DE PROMOCION =  recompensas APLICA EN =  Membresia ESTATUS =  Activa','2024-04-18 13:36:07',_binary ''),(970,'root@localhost','Create','detalles_promociones','Se ha insertado una nueva PROMOCION con el ID:  5 con los siguientes datos:  PROMOCIONES ID =  recompensas FECHA DE INICIO =  2021-12-25 13:36:04 FECHA DE FINALIZACION =  2020-05-06 08:01:38 ESTATUS =  Activa','2024-04-18 13:36:07',_binary ''),(971,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  56 con los siguientes datos:  NOMBRE =  Colchoneta para ejercicios MARCA =  PowerLift PRECIO ACTUAL =  100.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:36:07',_binary ''),(972,'root@localhost','Create','promociones','Se ha insertado una nueva PROMOCION con el ID:  16 con los siguientes datos:  PRODUCTO ID =  Colchoneta para ejercicios PowerLift TIPO DE PROMOCION =  recompensas APLICA EN =  Membresia ESTATUS =  Activa','2024-04-18 13:36:07',_binary ''),(973,'root@localhost','Create','detalles_promociones','Se ha insertado una nueva PROMOCION con el ID:  6 con los siguientes datos:  PROMOCIONES ID =  recompensas FECHA DE INICIO =  2015-12-16 18:36:03 FECHA DE FINALIZACION =  2020-06-18 18:40:15 ESTATUS =  Activa','2024-04-18 13:36:07',_binary ''),(974,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  57 con los siguientes datos:  NOMBRE =  Bebida energética pre-entrenamiento MARCA =  MuscleFlow PRECIO ACTUAL =  40.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:36:07',_binary ''),(975,'root@localhost','Create','promociones','Se ha insertado una nueva PROMOCION con el ID:  17 con los siguientes datos:  PRODUCTO ID =  Bebida energética pre-entrenamiento MuscleFlow TIPO DE PROMOCION =  recompensas APLICA EN =  Producto ESTATUS =  Activa','2024-04-18 13:36:07',_binary ''),(976,'root@localhost','Create','detalles_promociones','Se ha insertado una nueva PROMOCION con el ID:  7 con los siguientes datos:  PROMOCIONES ID =  recompensas FECHA DE INICIO =  2020-10-03 08:04:42 FECHA DE FINALIZACION =  2020-10-02 18:18:16 ESTATUS =  Activa','2024-04-18 13:36:07',_binary ''),(977,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  58 con los siguientes datos:  NOMBRE =  Colchoneta para ejercicios MARCA =  SpeedGrip PRECIO ACTUAL =  100.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:36:07',_binary ''),(978,'root@localhost','Create','promociones','Se ha insertado una nueva PROMOCION con el ID:  18 con los siguientes datos:  PRODUCTO ID =  Colchoneta para ejercicios SpeedGrip TIPO DE PROMOCION =  membresias APLICA EN =  Producto ESTATUS =  Activa','2024-04-18 13:36:07',_binary ''),(979,'root@localhost','Create','detalles_promociones','Se ha insertado una nueva PROMOCION con el ID:  8 con los siguientes datos:  PROMOCIONES ID =  membresias FECHA DE INICIO =  2019-03-27 19:17:44 FECHA DE FINALIZACION =  2021-06-18 18:33:21 ESTATUS =  Activa','2024-04-18 13:36:07',_binary ''),(980,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  59 con los siguientes datos:  NOMBRE =  Esterilla de yoga MARCA =  SpeedGrip PRECIO ACTUAL =  10.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:36:07',_binary ''),(981,'root@localhost','Create','promociones','Se ha insertado una nueva PROMOCION con el ID:  19 con los siguientes datos:  PRODUCTO ID =  Esterilla de yoga SpeedGrip TIPO DE PROMOCION =  complementarios APLICA EN =  Membresia ESTATUS =  Activa','2024-04-18 13:36:07',_binary ''),(982,'root@localhost','Create','detalles_promociones','Se ha insertado una nueva PROMOCION con el ID:  9 con los siguientes datos:  PROMOCIONES ID =  complementarios FECHA DE INICIO =  2022-01-01 11:27:37 FECHA DE FINALIZACION =  2020-10-13 08:34:43 ESTATUS =  Activa','2024-04-18 13:36:07',_binary ''),(983,'root@localhost','Create','productos','Se ha insertado una nueva AREA con el ID:  60 con los siguientes datos:  NOMBRE =  Termogénico para quemar grasa MARCA =  MuscleRecover PRECIO ACTUAL =  60.00 FOTOGRAFÍA =  ESTATUS =  Activa','2024-04-18 13:36:07',_binary ''),(984,'root@localhost','Create','promociones','Se ha insertado una nueva PROMOCION con el ID:  20 con los siguientes datos:  PRODUCTO ID =  Termogénico para quemar grasa MuscleRecover TIPO DE PROMOCION =  complementarios APLICA EN =  Producto ESTATUS =  Activa','2024-04-18 13:36:07',_binary ''),(985,'root@localhost','Create','detalles_promociones','Se ha insertado una nueva PROMOCION con el ID:  10 con los siguientes datos:  PROMOCIONES ID =  complementarios FECHA DE INICIO =  2022-08-18 17:39:58 FECHA DE FINALIZACION =  2022-06-08 12:59:05 ESTATUS =  Activa','2024-04-18 13:36:07',_binary ''),(986,'root@localhost','Delete','detalles_productos','Se ha eliminado una relación DETALLES_PRODUCTOS con el ID:  1','2024-04-18 13:47:37',_binary ''),(987,'root@localhost','Delete','detalles_productos','Se ha eliminado una relación DETALLES_PRODUCTOS con el ID:  2','2024-04-18 13:47:37',_binary '');
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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detalles_pedidos`
--

LOCK TABLES `detalles_pedidos` WRITE;
/*!40000 ALTER TABLE `detalles_pedidos` DISABLE KEYS */;
INSERT INTO `detalles_pedidos` VALUES (1,11,1,10,50.00,'2021-08-07 12:36:32','2024-04-18 13:36:07',_binary ''),(2,12,1,380,100.00,'2020-05-02 13:11:42','2024-04-18 13:36:07',_binary ''),(3,13,1,60,80.00,'2020-06-22 12:33:38','2024-04-18 13:36:07',_binary ''),(4,14,1,450,90.00,'2022-11-28 19:02:27','2024-04-18 13:36:07',_binary ''),(5,15,1,450,50.00,'2020-07-09 09:25:35','2024-04-18 13:36:07',_binary ''),(6,16,1,380,70.00,'2022-03-12 15:35:23','2024-04-18 13:36:07',_binary ''),(7,17,1,10,100.00,'2020-03-23 13:56:11','2024-04-18 13:36:07',_binary ''),(8,18,1,380,30.00,'2022-03-15 17:56:56','2024-04-18 13:36:07',_binary ''),(9,19,1,10,60.00,'2022-08-05 12:07:36','2024-04-18 13:36:07',_binary ''),(10,20,1,450,50.00,'2023-08-15 19:25:49','2024-04-18 13:36:07',_binary '');
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
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `Producto_ID` int unsigned NOT NULL,
  `Descripcion` text,
  `Codigo_Barras` int DEFAULT NULL,
  `Presentacion` text,
  `Productos_existencia` int DEFAULT NULL,
  `Estatus` bit(1) NOT NULL DEFAULT b'1',
  PRIMARY KEY (`ID`),
  KEY `fk_productos_5` (`Producto_ID`),
  CONSTRAINT `fk_productos_5` FOREIGN KEY (`Producto_ID`) REFERENCES `productos` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detalles_productos`
--

LOCK TABLES `detalles_productos` WRITE;
/*!40000 ALTER TABLE `detalles_productos` DISABLE KEYS */;
INSERT INTO `detalles_productos` VALUES (3,13,'Suplemento que contiene los aminoácidos esenciales leucina, isoleucina y valina, que ayudan a promover la recuperación muscular, reducir la fatiga y preservar la masa muscular durante el ejercicio.',385987635,'C4 Original Pre-Workout)',500,_binary ''),(4,14,'Botellas diseñadas para mezclar fácilmente proteína en polvo con agua o leche, convenientes para consumir bebidas nutritivas antes o después del entrenamiento.',450578976,' Optimum Nutrition Creatine Monohydrate',380,_binary ''),(5,15,'Suplemento utilizado para aumentar la fuerza, la potencia y ​​la masa muscular, al mejorar la disponibilidad de energía en los músculos durante el ejercicio de alta intensidad.',385987635,'Proteína Whey Gold Standard',450,_binary ''),(6,16,'Suplemento que contiene ácidos grasos esenciales omega-3, conocidos por sus efectos antiinflamatorios y beneficios para la salud cardiovascular y articular.',105389073,' Optimum Nutrition Creatine Monohydrate',380,_binary ''),(7,17,'Suplemento que contiene los aminoácidos esenciales leucina, isoleucina y valina, que ayudan a promover la recuperación muscular, reducir la fatiga y preservar la masa muscular durante el ejercicio.',450578976,'Nordic Naturals Ultimate Omega',10,_binary ''),(8,18,'Suplemento que contiene ácidos grasos esenciales omega-3, conocidos por sus efectos antiinflamatorios y beneficios para la salud cardiovascular y articular.',385987635,' Optimum Nutrition Creatine Monohydrate',60,_binary ''),(9,19,'Suplementos que contienen una variedad de vitaminas y minerales esenciales para apoyar la salud general, el metabolismo y la función muscular durante el ejercicio intenso.',123457354,'Quest Nutrition Protein Bar',60,_binary ''),(10,20,'Suplemento que contiene los aminoácidos esenciales leucina, isoleucina y valina, que ayudan a promover la recuperación muscular, reducir la fatiga y preservar la masa muscular durante el ejercicio.',123457354,'Nordic Naturals Ultimate Omega',380,_binary '');
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
        CONCAT_WS(" ","Se ha insertado una nuevo DETALLE_PEDIDO con el ID: ",NEW.ID, 
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
        CONCAT_WS(" ","Se han actualizado los datos de los DETALLES_PRODUCTOS con el ID: ",NEW.ID, 
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
-- /*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `detalles_productos_AFTER_DELETE` AFTER DELETE ON `detalles_productos` FOR EACH ROW INSERT INTO bitacora VALUES(
-- 		DEFAULT,
--         USER(),
--         "Delete",
--         "detalles_productos",
--         CONCAT_WS(" ","Se ha eliminado una relación DETALLES_PRODUCTOS con el ID: ", OLD.ID),
--        now(),
--        DEFAULT
--    ); */;;
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
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `Promociones_ID` int unsigned NOT NULL,
  `Fecha_Inicio` datetime DEFAULT NULL,
  `Fecha_Fin` datetime DEFAULT NULL,
  `Estatus` bit(1) DEFAULT b'1',
  PRIMARY KEY (`ID`),
  KEY `fk_promociones_2_idx` (`Promociones_ID`),
  CONSTRAINT `fk_promociones_2` FOREIGN KEY (`Promociones_ID`) REFERENCES `promociones` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detalles_promociones`
--

LOCK TABLES `detalles_promociones` WRITE;
/*!40000 ALTER TABLE `detalles_promociones` DISABLE KEYS */;
INSERT INTO `detalles_promociones` VALUES (1,11,'2023-01-18 14:33:42','2020-08-03 08:32:23',_binary ''),(2,12,'2024-01-07 18:22:06','2021-10-06 13:30:51',_binary ''),(3,13,'2019-09-28 15:36:16','2022-09-30 11:31:14',_binary ''),(4,14,'2019-01-04 18:19:41','2020-01-16 13:37:27',_binary ''),(5,15,'2021-12-25 13:36:04','2020-05-06 08:01:38',_binary ''),(6,16,'2015-12-16 18:36:03','2020-06-18 18:40:15',_binary ''),(7,17,'2020-10-03 08:04:42','2020-10-02 18:18:16',_binary ''),(8,18,'2019-03-27 19:17:44','2021-06-18 18:33:21',_binary ''),(9,19,'2022-01-01 11:27:37','2020-10-13 08:34:43',_binary ''),(10,20,'2022-08-18 17:39:58','2022-06-08 12:59:05',_binary '');
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
    DECLARE v_nombre_promocion varchar(60) default null;

    -- Iniciación de las variables
    IF new.estatus = b'1' then
        set v_cadena_estatus = "Activa";
    else
        set v_cadena_estatus = "Inactiva";
    end if;

    if new.promociones_id is not null then
        -- En caso de tener el id de la sucursal debemos recuperar su nombre
        set v_nombre_promocion = (SELECT concat_ws(" ", p.tipo) FROM promociones p WHERE id = NEW.promociones_id);
    else
        SET v_nombre_promocion = "Sin promoción asignada";
    end if;

    -- Insertar en la bitacora
    INSERT INTO bitacora VALUES(
        DEFAULT,
        USER(),
        "Create",
        "detalles_promociones",
        CONCAT_WS(" ","Se ha insertado una nueva PROMOCION con el ID: ",NEW.ID, 
        "con los siguientes datos: ",
        "PROMOCIONES ID = ", v_nombre_promocion,
        "FECHA DE INICIO = ", NEW.Fecha_Inicio,
        "FECHA DE FINALIZACION = ",  NEW.Fecha_Fin,
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
    
    DECLARE v_nombre_promocion varchar(60) default null;
    DECLARE v_nombre_promocion2 VARCHAR(60) DEFAULT NULL;

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
        SET v_nombre_promocion = (SELECT concat_ws(" ", p.tipo) FROM promociones p WHERE id = NEW.promociones_id);
    ELSE
		SET v_nombre_promocion = "Sin promoción asignada.";
    END IF;

    IF OLD.promociones_id IS NOT NULL THEN 
		-- En caso de tener el id del producto
        SET v_nombre_promocion2 = (SELECT concat_ws(" ", p.tipo) FROM promociones p WHERE id = OLD.promociones_id);
    ELSE
		SET v_nombre_promocion2 = "Sin promoción asignada.";
    END IF;
    
    INSERT INTO bitacora VALUES(
        DEFAULT,
        USER(),
        "Update",
        "detalles_promociones",
        CONCAT_WS(" ","Se han actualizado los datos de los DETALLES_PROMOCIONES con el ID: ",NEW.Promociones_ID, 
        "con los siguientes datos:",
        "PROMOCIONES ID =",v_nombre_promocion2," cambio a ", v_nombre_promocion,
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
        CONCAT_WS(" ","Se ha eliminado un DETALLE_PROMOCION con el ID: ", OLD.ID),
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
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedidos`
--

LOCK TABLES `pedidos` WRITE;
/*!40000 ALTER TABLE `pedidos` DISABLE KEYS */;
INSERT INTO `pedidos` VALUES (1,21,21,60.00,'2023-01-12 19:43:37',_binary ''),(2,22,22,20.00,'2021-12-31 19:20:43',_binary ''),(3,23,23,40.00,'2022-04-01 13:56:21',_binary ''),(4,24,24,20.00,'2020-03-31 18:27:56',_binary ''),(5,25,25,100.00,'2022-04-18 16:36:15',_binary ''),(6,26,26,20.00,'2020-03-15 16:11:12',_binary ''),(7,27,27,80.00,'2020-03-23 18:21:32',_binary ''),(8,28,28,90.00,'2022-04-17 19:39:55',_binary ''),(9,29,29,10.00,'2022-11-16 12:08:21',_binary ''),(10,30,30,100.00,'2020-07-30 19:15:13',_binary ''),(11,31,31,10.00,'2023-12-03 14:38:30',_binary ''),(12,32,32,40.00,'2023-01-08 13:44:28',_binary ''),(13,33,33,60.00,'2020-05-19 17:50:53',_binary ''),(14,34,34,20.00,'2021-02-20 18:15:22',_binary ''),(15,35,35,80.00,'2020-09-13 15:03:38',_binary ''),(16,36,36,80.00,'2023-09-30 10:01:40',_binary ''),(17,37,37,50.00,'2021-09-04 16:03:33',_binary ''),(18,38,38,10.00,'2020-06-21 11:45:41',_binary ''),(19,39,39,100.00,'2021-09-13 10:59:48',_binary ''),(20,40,40,100.00,'2021-01-05 10:42:11',_binary '');
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
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `personas`
--

LOCK TABLES `personas` WRITE;
/*!40000 ALTER TABLE `personas` DISABLE KEYS */;
INSERT INTO `personas` VALUES (1,NULL,'Jazmin','Santiago','Bautista','1964-05-07',NULL,'F','AB-',_binary '','2020-02-24 10:00:21',NULL),(2,NULL,'Maximiliano','Moreno',' Rivera','1985-08-15',NULL,'M','O-',_binary '','2024-03-03 09:13:13',NULL),(3,NULL,'Estrella',' González',' Rivera','1992-12-11',NULL,'F','AB-',_binary '','2020-09-24 18:58:29',NULL),(4,'Lic.','Diana','Torres','Jiménez','1988-04-11',NULL,'F','A+',_binary '','2021-04-04 13:04:32',NULL),(5,NULL,'Sofia',' Rivera','Gutiérrez','1961-09-03',NULL,'F','A-',_binary '','2022-06-21 13:17:57',NULL),(6,NULL,'Marco','Contreras','Cortés','1978-09-02',NULL,'M','A+',_binary '','2021-04-09 10:16:09',NULL),(7,'Med.','Luz','López','Pérez','1973-08-07',NULL,'F','A-',_binary '','2023-11-13 08:24:42',NULL),(8,NULL,'Federico','Méndez','Ramírez','1967-06-18',NULL,'M','B+',_binary '','2020-11-22 08:10:47',NULL),(9,NULL,'Edgar','Ortega','Gómes','1987-03-20',NULL,'M','A-',_binary '','2020-02-10 16:16:18',NULL),(10,NULL,'Flor','Castillo','Ramírez','1977-08-01',NULL,'F','B+',_binary '','2022-11-18 11:19:39',NULL),(11,NULL,'Pedro','Ruíz','Domínguez','1960-10-23',NULL,'M','A-',_binary '','2020-04-02 15:15:26',NULL),(12,NULL,'Ana','López','Chávez','1992-06-15',NULL,'F','AB-',_binary '','2021-01-19 11:06:14',NULL),(13,NULL,'Daniel','Castro','Juárez','2004-05-22',NULL,'M','O+',_binary '','2020-09-19 13:45:57',NULL),(14,NULL,'Dulce','Mendoza','Méndez','1985-07-29',NULL,'F','A+',_binary '','2022-07-09 17:47:06',NULL),(15,NULL,'Jesus','Vázquez','Bautista','2004-03-02',NULL,'M','O+',_binary '','2020-02-09 18:19:58',NULL),(16,'Ing.','Jorge','Juárez','Luna','1982-07-25',NULL,'M','O+',_binary '','2022-06-16 13:32:04',NULL),(17,'Srita','Estrella','Castro','Domínguez','1967-11-28',NULL,'F','O-',_binary '','2020-03-01 13:25:37',NULL),(18,NULL,'Samuel','Romero','Vargas','1965-05-23',NULL,'M','B-',_binary '','2023-08-22 18:49:20',NULL),(19,NULL,'Ana','Vargas','Salazar','2006-11-27',NULL,'F','B-',_binary '','2024-03-06 16:46:04',NULL),(20,NULL,'Guadalupe','Estrada','Cortés','1959-10-09',NULL,'F','A-',_binary '','2023-02-26 10:33:56',NULL),(21,NULL,'Iram','Rodríguez','Díaz','1973-11-19',NULL,'M','B-',_binary '','2021-09-26 15:41:37',NULL),(22,NULL,'Karla','Herrera','Ortiz','1974-01-19',NULL,'F','A-',_binary '','2023-04-19 13:13:11',NULL),(23,NULL,'Luz','López','Soto','1998-01-02',NULL,'F','O-',_binary '','2021-12-18 12:40:44',NULL),(24,NULL,'Jesus','Reyes','Cortés','1960-08-10',NULL,'M','A-',_binary '','2024-02-22 10:18:25',NULL),(25,'Ing.','Ricardo','Bautista','Sánchez','2002-07-02',NULL,'M','O-',_binary '','2020-08-05 17:51:32',NULL),(26,NULL,'Paula','Pérez','Estrada','1972-05-14',NULL,'F','AB+',_binary '','2020-03-08 14:06:19',NULL),(27,NULL,'José','Mendoza','Pérez','1974-09-15',NULL,'M','A-',_binary '','2020-11-27 12:21:16',NULL),(28,'Med.','Pedro','Ortega',' González','1998-06-20',NULL,'M','AB-',_binary '','2021-03-26 10:40:12',NULL),(29,NULL,'Alejandro','Méndez','Díaz','1962-09-19',NULL,'M','B+',_binary '','2021-06-17 17:13:41',NULL),(30,NULL,'Estrella','Mendoza','Morales','2005-11-05',NULL,'F','A+',_binary '','2021-04-02 12:28:34',NULL),(31,NULL,'Suri',' González','Guerrero','1972-07-24',NULL,'F','AB-',_binary '','2021-05-23 16:52:04',NULL),(32,NULL,'Paula','Guerrero','Salazar','1981-08-05',NULL,'F','O+',_binary '','2022-02-19 10:00:43',NULL),(33,NULL,'Samuel','Vargas','Contreras','2001-06-16',NULL,'M','O+',_binary '','2023-01-27 19:57:41',NULL),(34,NULL,'Flor','Santiago','Hernández','1981-06-17',NULL,'F','A-',_binary '','2022-10-31 16:12:29',NULL),(35,NULL,'Jorge','Díaz','Juárez','2007-08-28',NULL,'M','A+',_binary '','2022-05-10 13:12:40',NULL),(36,NULL,'Karla','Pérez','Herrera','2006-06-10',NULL,'F','O+',_binary '','2021-02-10 17:41:56',NULL),(37,NULL,'Mario','Morales','López','1987-09-03',NULL,'M','AB-',_binary '','2022-11-19 11:42:43',NULL),(38,NULL,'Yair','Reyes','Santiago','1988-09-05',NULL,'M','B+',_binary '','2023-07-19 09:48:05',NULL),(39,NULL,'Valeria','Soto','Rodríguez','1994-03-27',NULL,'F','A-',_binary '','2023-01-17 08:25:23',NULL),(40,NULL,'Sofia','Vargas','López','1966-09-07',NULL,'F','AB+',_binary '','2021-05-28 19:36:41',NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productos`
--

LOCK TABLES `productos` WRITE;
/*!40000 ALTER TABLE `productos` DISABLE KEYS */;
INSERT INTO `productos` VALUES (1,'Bebida energética post-entrenamiento','FlexiRoll',20.00,NULL,_binary ''),(2,'Rodillo de espuma para masaje muscular','FlexiStrap',40.00,NULL,_binary ''),(3,'Suplemento pre-entrenamiento','SpeedGrip',40.00,NULL,_binary ''),(4,'Barritas energéticas','FlexiGrip',50.00,NULL,_binary ''),(5,'Guantes para levantamiento de pesas','MuscleMax',20.00,NULL,_binary ''),(6,'Bebida isotónica','FlexiSqueeze',60.00,NULL,_binary ''),(7,'Termogénico para quemar grasa','FlexiSocks',100.00,NULL,_binary ''),(8,'Banda de resistencia para entrenamiento','PowerHydrate',80.00,NULL,_binary ''),(9,'Vendas para muñecas y tobillos','FlexiBlock',40.00,NULL,_binary ''),(10,'Magnesio para mejorar el agarre','FlexiLoop',10.00,NULL,_binary ''),(11,'Banda elástica para ejercicios de resistencia','PowerCharge',90.00,NULL,_binary ''),(12,'Cinturón de levantamiento de pesas','FlexiPod',80.00,NULL,_binary ''),(13,'Termogénico para quemar grasa','FlexiStick',80.00,NULL,_binary ''),(14,'Correa de estiramiento','PowerBlitz',10.00,NULL,_binary ''),(15,'Bebida isotónica','MuscleRelief',90.00,NULL,_binary ''),(16,'Rodillo de espuma para masaje muscular','FlexiBand',80.00,NULL,_binary ''),(17,'Magnesio para mejorar el agarre','FlexiGel',60.00,NULL,_binary ''),(18,'Banda elástica para ejercicios de resistencia','FlexiBand',40.00,NULL,_binary ''),(19,'Banda de resistencia para entrenamiento','FlexiBand',10.00,NULL,_binary ''),(20,'Magnesio para mejorar el agarre','FlexiBall',90.00,NULL,_binary ''),(21,'Bloque de espuma para estiramientos','FlexiSqueeze',30.00,NULL,_binary ''),(22,'Bebida energética post-entrenamiento','MusclePatch',10.00,NULL,_binary ''),(23,'Barritas energéticas','FlexiBlock',50.00,NULL,_binary ''),(24,'Bebida energética post-entrenamiento','PowerHydrate',60.00,NULL,_binary ''),(25,'Barritas energéticas','PowerLift',50.00,NULL,_binary ''),(26,'Banda elástica para ejercicios de resistencia','StaminaBoost',30.00,NULL,_binary ''),(27,'Magnesio para mejorar el agarre','FlexiMat',100.00,NULL,_binary ''),(28,'Bloque de espuma para estiramientos','PowerLift',70.00,NULL,_binary ''),(29,'Magnesio para mejorar el agarre','MuscleMax',50.00,NULL,_binary ''),(30,'Banda elástica para ejercicios de resistencia','PowerBurn',20.00,NULL,_binary ''),(31,'Bloque de espuma para estiramientos','PowerBlitz',10.00,NULL,_binary ''),(32,'Suplemento pre-entrenamiento','FlexiBottle',10.00,NULL,_binary ''),(33,'Barritas energéticas','FlexiLoop',30.00,NULL,_binary ''),(34,'Termogénico para quemar grasa','MuscleRelief',20.00,NULL,_binary ''),(35,'Guantes para levantamiento de pesas','MuscleFlow',60.00,NULL,_binary ''),(36,'Magnesio para mejorar el agarre','PowerStim',100.00,NULL,_binary ''),(37,'Suplemento pre-entrenamiento','PowerBar',60.00,NULL,_binary ''),(38,'Guantes para levantamiento de pesas','FlexiWheel',10.00,NULL,_binary ''),(39,'Esterilla de yoga','PowerGrip',80.00,NULL,_binary ''),(40,'Banda elástica para ejercicios de resistencia','MuscleFlow',60.00,NULL,_binary ''),(41,'Barritas energéticas','PowerPulse',90.00,NULL,_binary ''),(42,'Bebida energética pre-entrenamiento','SpeedWrap',80.00,NULL,_binary ''),(43,'Termogénico para quemar grasa','SpeedMate',40.00,NULL,_binary ''),(44,'Bebida energética pre-entrenamiento','FlexiBall',40.00,NULL,_binary ''),(45,'Colchoneta para ejercicios','FlexiPod',40.00,NULL,_binary ''),(46,'Bloque de espuma para estiramientos','PowerStim',40.00,NULL,_binary ''),(47,'Banda elástica para ejercicios de resistencia','SpeedGrip',20.00,NULL,_binary ''),(48,'Batidos de proteínas','MuscleMax',30.00,NULL,_binary ''),(49,'Colchoneta para ejercicios','MuscleFlow',50.00,NULL,_binary ''),(50,'Bebida energética post-entrenamiento','PowerLift',80.00,NULL,_binary ''),(51,'Batidos de proteínas','PowerHydrate',90.00,NULL,_binary ''),(52,'Bebida energética post-entrenamiento','FlexiPod',30.00,NULL,_binary ''),(53,'Guantes para levantamiento de pesas','MuscleFlow',60.00,NULL,_binary ''),(54,'Rodillo de espuma para masaje muscular','FlexiGel',80.00,NULL,_binary ''),(55,'Banda de resistencia para estiramientos','FlexiRoll',90.00,NULL,_binary ''),(56,'Colchoneta para ejercicios','PowerLift',100.00,NULL,_binary ''),(57,'Bebida energética pre-entrenamiento','MuscleFlow',40.00,NULL,_binary ''),(58,'Colchoneta para ejercicios','SpeedGrip',100.00,NULL,_binary ''),(59,'Esterilla de yoga','SpeedGrip',10.00,NULL,_binary ''),(60,'Termogénico para quemar grasa','MuscleRecover',60.00,NULL,_binary '');
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
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `Producto_ID` int unsigned NOT NULL,
  `Tipo` enum('membresias','personalizado','complementarios','recompensas') DEFAULT NULL,
  `Aplicacion_en` enum('Membresia','Producto') DEFAULT NULL,
  `Estatus` bit(1) DEFAULT b'1',
  PRIMARY KEY (`ID`),
  KEY `fk_productos_3_idx` (`Producto_ID`),
  CONSTRAINT `fk_productos_3` FOREIGN KEY (`Producto_ID`) REFERENCES `productos` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `promociones`
--

LOCK TABLES `promociones` WRITE;
/*!40000 ALTER TABLE `promociones` DISABLE KEYS */;
INSERT INTO `promociones` VALUES (1,41,'personalizado','Producto',_binary ''),(2,42,'complementarios','Membresia',_binary ''),(3,43,'personalizado','Membresia',_binary ''),(4,44,'recompensas','Membresia',_binary ''),(5,45,'membresias','Membresia',_binary ''),(6,46,'complementarios','Membresia',_binary ''),(7,47,'recompensas','Producto',_binary ''),(8,48,'membresias','Membresia',_binary ''),(9,49,'membresias','Producto',_binary ''),(10,50,'personalizado','Producto',_binary ''),(11,51,'recompensas','Producto',_binary ''),(12,52,'personalizado','Producto',_binary ''),(13,53,'membresias','Membresia',_binary ''),(14,54,'recompensas','Membresia',_binary ''),(15,55,'recompensas','Membresia',_binary ''),(16,56,'recompensas','Membresia',_binary ''),(17,57,'recompensas','Producto',_binary ''),(18,58,'membresias','Producto',_binary ''),(19,59,'complementarios','Membresia',_binary ''),(20,60,'complementarios','Producto',_binary '');
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
        CONCAT_WS(" ","Se ha insertado una nueva PROMOCION con el ID: ",NEW.ID, 
        "con los siguientes datos: ",
        "PRODUCTO ID = ", v_nombre_producto,
        "TIPO DE PROMOCION = ", NEW.Tipo,
        "APLICA EN = ",  NEW.Aplicacion_en,
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
        CONCAT_WS(" ","Se ha eliminado una PROMOCION con el ID: ", OLD.ID),
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
INSERT INTO `usuarios` VALUES (11,11,NULL,'Empleado','Banned','2021-12-08 14:32:15'),(12,12,NULL,'Empleado','Banned','2022-11-13 08:14:10'),(13,13,NULL,'Empleado','Banned','2023-12-10 08:42:03'),(14,14,NULL,'Empleado','Banned','2023-01-31 09:41:39'),(15,15,NULL,'Empleado','Banned','2021-01-27 14:51:04'),(16,16,NULL,'Empleado','Banned','2023-07-18 14:50:04'),(17,17,NULL,'Empleado','Banned','2020-10-07 12:29:40'),(18,18,NULL,'Empleado','Banned','2024-04-11 09:40:06'),(19,19,NULL,'Empleado','Banned','2024-04-07 13:49:31'),(20,20,NULL,'Empleado','Banned','2024-02-22 16:15:15'),(21,21,NULL,'Instructor','Online','2022-05-21 09:31:12'),(22,22,NULL,'Instructor','Online','2023-12-19 10:02:30'),(23,23,NULL,'Miembro','Banned','2023-12-25 09:57:27'),(24,24,NULL,'Empleado','Banned','2024-03-30 19:27:54'),(25,25,NULL,'Miembro','Banned','2024-01-02 15:13:32'),(26,26,NULL,'Visitante','Offline','2022-03-26 18:07:28'),(27,27,NULL,'Empleado','Banned','2022-09-26 10:58:49'),(28,28,NULL,'Visitante','Offline','2021-11-25 11:40:14'),(29,29,NULL,'Instructor','Banned','2023-04-06 16:30:41'),(30,30,NULL,'Instructor','Banned','2021-11-01 13:31:55'),(31,31,NULL,'Miembro','Offline','2023-09-28 18:16:51'),(32,32,NULL,'Visitante','Online','2022-05-29 19:09:28'),(33,33,NULL,'Instructor','Online','2023-09-14 19:22:48'),(34,34,NULL,'Visitante','Online','2023-07-30 08:28:28'),(35,35,NULL,'Miembro','Offline','2022-07-17 13:39:53'),(36,36,NULL,'Visitante','Banned','2023-04-18 16:51:29'),(37,37,NULL,'Miembro','Banned','2023-01-15 11:54:01'),(38,38,NULL,'Visitante','Banned','2024-02-29 11:40:54'),(39,39,NULL,'Empleado','Online','2023-10-04 12:57:35'),(40,40,NULL,'Instructor','Offline','2022-05-20 14:33:17');
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
		INSERT INTO detalles_productos VALUES(	default,
												v_id_producto,
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
/*!50003 DROP PROCEDURE IF EXISTS `sp_inserta_detalles_promociones` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_inserta_detalles_promociones`(v_cuanto int)
    DETERMINISTIC
BEGIN
	DECLARE i INT DEFAULT 1;
    DECLARE v_id_promociones INT;
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
    
     while i <= v_cuanto DO
	
			call sp_inserta_promociones(1, null);
			set v_id_promociones = last_insert_id();
        
		insert into detalles_promociones values(default,
												v_id_promociones,
												fn_genera_fecha_registro("2015-01-01", CURDATE(), "08:00:00", "20:00:00"),
												fn_genera_fecha_registro(v_fecha_inicio_registro, v_fecha_fin_registro, v_horario_inicio_registro,v_horario_fin_registro),
												default);
											SET i = i +1;
	END while;
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
			set v_tipo = ELT(fn_numero_aleatorio_rangos(1,4), "membresias","personalizado","complementarios", "recompensas");
		END IF;
        
        if v_aplica IS NULL THEN
			set v_aplica = ELT(fn_numero_aleatorio_rangos(1,2), "Membresia","Producto");
		END IF;
        
		insert into promociones values(default,
										v_id_productos,
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
        
        delete from detalles_promociones;
        ALTER TABLE detalles_promociones AUTO_INCREMENT = 1;
        
        delete from promociones;
        ALTER TABLE promociones AUTO_INCREMENT = 1;
        
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
        call sp_inserta_promociones(10, 'membresias');
        call sp_inserta_detalles_promociones(10);
        
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

-- Dump completed on 2024-04-18 13:48:29
