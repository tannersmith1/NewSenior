CREATE DATABASE  IF NOT EXISTS `senior` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `senior`;
-- MySQL dump 10.13  Distrib 5.6.13, for Win32 (x86)
--
-- Host: localhost    Database: senior
-- ------------------------------------------------------
-- Server version	5.6.12-log

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
-- Table structure for table `competition`
--

DROP TABLE IF EXISTS `competition`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `competition` (
  `competitionid` mediumint(9) NOT NULL AUTO_INCREMENT,
  `partyid` mediumint(9) NOT NULL,
  `startdate` datetime NOT NULL,
  `enddate` datetime NOT NULL,
  `iselimination` tinyint(1) NOT NULL,
  `frequency` varchar(45) NOT NULL,
  `cycles` int(11) NOT NULL,
  PRIMARY KEY (`competitionid`),
  KEY `partyid` (`partyid`),
  CONSTRAINT `competition_ibfk_1` FOREIGN KEY (`partyid`) REFERENCES `party` (`partyid`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `competition`
--

LOCK TABLES `competition` WRITE;
/*!40000 ALTER TABLE `competition` DISABLE KEYS */;
INSERT INTO `competition` VALUES (2,2,'2014-02-26 07:06:06','2014-07-26 07:06:06',1,'Monthly',5),(5,5,'2014-03-14 12:05:02','2014-03-28 12:05:02',1,'Weekly',2);
/*!40000 ALTER TABLE `competition` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `coordinates`
--

DROP TABLE IF EXISTS `coordinates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `coordinates` (
  `coordinatesid` mediumint(9) NOT NULL AUTO_INCREMENT,
  `routeid` mediumint(9) NOT NULL,
  `latitude` double NOT NULL,
  `longitude` double NOT NULL,
  PRIMARY KEY (`coordinatesid`),
  KEY `coordinates_ibfk_1` (`routeid`),
  CONSTRAINT `coordinates_ibfk_1` FOREIGN KEY (`routeid`) REFERENCES `route` (`routeid`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=136 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `coordinates`
--

LOCK TABLES `coordinates` WRITE;
/*!40000 ALTER TABLE `coordinates` DISABLE KEYS */;
INSERT INTO `coordinates` VALUES (1,1,42.22809982299805,-121.7789077758789),(2,1,42.25680923461914,-121.78640747070312),(3,2,42.25230026245117,-121.7853775024414),(4,2,42.23139190673828,-121.77774047851562),(5,2,42.23221,-121.8114),(6,4,42.230795,-121.786693),(7,4,42.230795,-121.786693),(8,4,42.230742,-121.786713),(9,4,42.23075,-121.786703),(10,5,42.230682,-121.786578),(11,5,42.230681,-121.786545),(12,5,42.230719,-121.7865),(13,5,42.230757,-121.786548),(15,6,42.228463,-121.78325),(16,6,42.228355,-121.782922),(17,6,42.228178,-121.782631),(18,6,42.227975,-121.782298),(19,6,42.227793,-121.781999),(20,6,42.227585,-121.781653),(21,6,42.227437,-121.781406),(22,6,42.227323,-121.781215),(23,6,42.22706,-121.781517),(24,6,42.226822,-121.781773),(25,6,42.226532,-121.782083),(26,6,42.226334,-121.782291),(27,6,42.2261,-121.782546),(28,6,42.22586,-121.782809),(29,6,42.2256,-121.783094),(30,6,42.225372,-121.783344),(31,6,42.225144,-121.783592),(32,6,42.22491,-121.783845),(33,6,42.224706,-121.784067),(34,6,42.224603,-121.784178),(35,6,42.224566,-121.784123),(36,6,42.224423,-121.783898),(37,6,42.224242,-121.783609),(38,6,42.224075,-121.783327),(39,6,42.223838,-121.783007),(40,6,42.223716,-121.782734),(41,6,42.22362,-121.782582),(42,6,42.223607,-121.782612),(43,6,42.223607,-121.782612),(44,6,42.223597,-121.782542),(45,6,42.223418,-121.782278),(46,6,42.223228,-121.781946),(47,6,42.223022,-121.781637),(48,6,42.222767,-121.781253),(49,6,42.22253,-121.780862),(50,6,42.222297,-121.780484),(51,6,42.222057,-121.780074),(52,6,42.221834,-121.779699),(53,6,42.221637,-121.779371),(54,6,42.221436,-121.779032),(55,6,42.221223,-121.778658),(56,6,42.221021,-121.778305),(57,6,42.220828,-121.777876),(58,6,42.220805,-121.777374),(59,6,42.220825,-121.777203),(60,6,42.220896,-121.776748),(61,6,42.220942,-121.776236),(62,6,42.220841,-121.775987),(63,6,42.220628,-121.775642),(64,6,42.220458,-121.775305),(65,6,42.22029,-121.775054),(66,6,42.220205,-121.774939),(67,6,42.219892,-121.774635),(68,6,42.219559,-121.774344),(69,6,42.219222,-121.77395),(70,6,42.218918,-121.773529),(71,6,42.21865,-121.773046),(72,6,42.218438,-121.772521),(73,6,42.218258,-121.77197),(74,6,42.218085,-121.771413),(75,6,42.217915,-121.770864),(76,6,42.217742,-121.770296),(77,6,42.217562,-121.769715),(78,6,42.217314,-121.769155),(79,6,42.217039,-121.76861),(80,6,42.216778,-121.768085),(81,6,42.216516,-121.767564),(82,6,42.21626,-121.767063),(83,6,42.216027,-121.766569),(84,6,42.215794,-121.766068),(85,6,42.215588,-121.765648),(86,6,42.215489,-121.765439),(87,6,42.215439,-121.765329),(88,6,42.215375,-121.765232),(89,6,42.215223,-121.764923),(90,6,42.215018,-121.764492),(91,6,42.214787,-121.764065),(92,6,42.214563,-121.763631),(93,6,42.214338,-121.763221),(94,6,42.214137,-121.762835),(95,6,42.213951,-121.762455),(96,6,42.213756,-121.762067),(97,6,42.213549,-121.761658),(98,6,42.213329,-121.76125),(99,6,42.213115,-121.760819),(100,6,42.212896,-121.760391),(101,6,42.212663,-121.759932),(102,6,42.212445,-121.759492),(103,6,42.212231,-121.759061),(104,6,42.212018,-121.758628),(105,6,42.211794,-121.758216),(106,6,42.211613,-121.757849),(107,6,42.211494,-121.757598),(108,6,42.211453,-121.757502),(109,6,42.211431,-121.757434),(110,6,42.211306,-121.757174),(111,6,42.211124,-121.756831),(112,6,42.210948,-121.756493),(113,6,42.210767,-121.756139),(114,6,42.210622,-121.755783),(115,6,42.210482,-121.755461),(116,6,42.210375,-121.755267),(117,6,42.210358,-121.755219),(118,6,42.210323,-121.75516),(119,6,42.210346,-121.754954),(120,6,42.210387,-121.754879),(121,6,42.210591,-121.754682),(122,6,42.210836,-121.754468),(123,6,42.211075,-121.754278),(124,6,42.2113,-121.754102),(125,6,42.211516,-121.75392),(126,6,42.211622,-121.753764),(127,6,42.211606,-121.753706),(128,6,42.211567,-121.753606),(129,6,42.211489,-121.753441),(130,6,42.21144,-121.75333),(131,6,42.211403,-121.753193),(132,6,42.211454,-121.753127),(133,6,42.211501,-121.753095),(134,6,42.211558,-121.753099),(135,6,42.211602,-121.753153);
/*!40000 ALTER TABLE `coordinates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `party`
--

DROP TABLE IF EXISTS `party`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `party` (
  `partyid` mediumint(9) NOT NULL AUTO_INCREMENT,
  `partyName` varchar(45) NOT NULL,
  `leader` varchar(45) NOT NULL,
  `passphrase` varchar(45) NOT NULL,
  `isprivate` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`partyid`),
  UNIQUE KEY `partyName_UNIQUE` (`partyName`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `party`
--

LOCK TABLES `party` WRITE;
/*!40000 ALTER TABLE `party` DISABLE KEYS */;
INSERT INTO `party` VALUES (2,'scoreboardT','scoreboard','',0),(5,'z','z','z',0);
/*!40000 ALTER TABLE `party` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `player`
--

DROP TABLE IF EXISTS `player`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `player` (
  `playerid` mediumint(9) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `player_password` varchar(50) NOT NULL,
  PRIMARY KEY (`playerid`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `player`
--

LOCK TABLES `player` WRITE;
/*!40000 ALTER TABLE `player` DISABLE KEYS */;
INSERT INTO `player` VALUES (1,'z','z'),(2,'t','t'),(3,'scoreboard','z'),(4,'gain','z'),(5,'loss','z'),(6,'ppp','z'),(7,'l','l');
/*!40000 ALTER TABLE `player` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `player_party`
--

DROP TABLE IF EXISTS `player_party`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `player_party` (
  `playerID` mediumint(9) NOT NULL,
  `partyID` mediumint(9) NOT NULL,
  PRIMARY KEY (`playerID`,`partyID`),
  KEY `player_party_ibfk_2` (`partyID`),
  CONSTRAINT `player_party_ibfk_1` FOREIGN KEY (`playerID`) REFERENCES `player` (`playerid`),
  CONSTRAINT `player_party_ibfk_2` FOREIGN KEY (`partyID`) REFERENCES `party` (`partyid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `player_party`
--

LOCK TABLES `player_party` WRITE;
/*!40000 ALTER TABLE `player_party` DISABLE KEYS */;
INSERT INTO `player_party` VALUES (3,2),(4,2),(5,2),(7,2),(1,5);
/*!40000 ALTER TABLE `player_party` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `route`
--

DROP TABLE IF EXISTS `route`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `route` (
  `routeid` mediumint(9) NOT NULL AUTO_INCREMENT,
  `playerid` mediumint(9) NOT NULL,
  `datesubmitted` datetime NOT NULL,
  `meterstravelled` float NOT NULL,
  PRIMARY KEY (`routeid`),
  KEY `route_ibfk_1` (`playerid`),
  CONSTRAINT `route_ibfk_1` FOREIGN KEY (`playerid`) REFERENCES `player` (`playerid`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `route`
--

LOCK TABLES `route` WRITE;
/*!40000 ALTER TABLE `route` DISABLE KEYS */;
INSERT INTO `route` VALUES (1,1,'2014-03-13 00:00:00',3701.49),(2,1,'2014-03-12 00:00:00',701.49),(4,1,'2014-03-13 00:00:00',7.3),(5,1,'2014-03-13 00:00:00',18.76),(6,1,'2014-03-13 00:00:00',3799.14);
/*!40000 ALTER TABLE `route` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `scoresheet`
--

DROP TABLE IF EXISTS `scoresheet`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `scoresheet` (
  `scoresheetid` mediumint(9) NOT NULL AUTO_INCREMENT,
  `competitionid` mediumint(9) NOT NULL,
  `playerid` mediumint(9) NOT NULL,
  `datesubmitted` datetime NOT NULL,
  `isverified` tinyint(1) NOT NULL,
  `scoreType` varchar(45) NOT NULL,
  `score` float DEFAULT NULL,
  PRIMARY KEY (`scoresheetid`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scoresheet`
--

LOCK TABLES `scoresheet` WRITE;
/*!40000 ALTER TABLE `scoresheet` DISABLE KEYS */;
INSERT INTO `scoresheet` VALUES (2,1,1,'2014-02-25 17:45:30',0,'Weight',NULL),(3,1,2,'2014-02-25 17:46:36',0,'Weight',NULL),(4,2,3,'2014-02-26 07:06:31',1,'Weight',150),(5,2,4,'2014-02-26 07:11:23',1,'Weight',180),(6,2,5,'2014-02-26 07:12:34',1,'Weight',200),(7,2,4,'2014-03-26 00:00:00',1,'weight',190),(8,2,5,'2014-03-26 00:00:00',1,'weight',185),(9,2,7,'2014-02-26 09:02:15',1,'Weight',145),(10,5,1,'2014-03-14 12:05:40',1,'Weight',112);
/*!40000 ALTER TABLE `scoresheet` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'senior'
--
/*!50003 DROP PROCEDURE IF EXISTS `check_for_existing_scoresheets` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `check_for_existing_scoresheets`( ipartyname VARCHAR(45), iusername VARCHAR(45), icyclestart DATETIME, icycleend DATETIME)
begin
select scoresheet.scoresheetid
from player
join player_party on player.playerid = player_party.playerid
join party on party.partyid = player_party.partyid
join competition on competition.partyid = party.partyid
join scoresheet on scoresheet.competitionid = competition.competitionid
where party.partyname = ipartyname and player.username = iusername and scoresheet.playerid = player.playerid and (scoresheet.datesubmitted BETWEEN icyclestart and icycleend);
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `check_for_existing_scorsheets` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `check_for_existing_scorsheets`( ipartyname VARCHAR(45), iusername VARCHAR(45), icyclestart DATETIME, icycleend DATETIME )
begin
select @partyID := partyid from party where party.partyname = ipartyname;
select @competitionID := competitionid from competition where competition.partyid = @partyID;
select @playerID := playerid from player where player.username = iusername;
select * from scoresheet where competitionid = @competitionid AND playerid = @playerid and ( datesubmitted BETWEEN icyclestart and icycleend );
SET @partyID = null;
SET @playerID = null;
SET @competitionID = null;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `create_competition` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `create_competition`( ipartyname VARCHAR(45), istartdate DATETIME, ienddate DATETIME, ifreq VARCHAR(45), icycles INT(11), iiselimination TINYINT(1))
begin
select @partyID := partyid from party where party.partyname = ipartyname;
insert into competition (partyid, startdate, enddate,iselimination, frequency, cycles) values (@partyID, istartdate, ienddate, iiselimination, ifreq, icycles);
SET @partyID = null;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_competition` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_competition`( ipartyname VARCHAR(45) )
begin
select startdate, enddate, frequency, cycles, iselimination 
from competition 
where partyid = (select partyid from party where partyName = ipartyname);
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `join_party` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `join_party`( iplayername VARCHAR(45), ipartyname VARCHAR(45))
begin
select @playerID := playerid from player where player.username = iplayername;
select @partyID := partyid from party where party.partyname = ipartyname;
insert into player_party (playerID, partyID) values (@playerID, @partyID);
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `new_party` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `new_party`( ipartyname VARCHAR(45), ileader VARCHAR(45), ipassword VARCHAR(45), iisprivate TINYINT(1))
begin
insert into party (partyName, leader, passphrase, isprivate) values (ipartyname, ileader, ipassword, iisprivate);
call join_party(ileader, ipartyname);
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `party_members` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `party_members`( ipartyname VARCHAR(45))
begin
select player.username, party.leader
from player
inner join player_party on player.playerID = player_party.playerID
inner join party on party.partyid = player_party.partyID
where  party.partyName = ipartyname;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `remove_member` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `remove_member`( iplayername VARCHAR(45), ipartyname VARCHAR(45))
begin
select @playerID := playerid from player where player.username = iplayername;
select @partyID := partyid from party where party.partyname = ipartyname;
delete from player_party where player_party.playerID = @playerID and player_party.partyID = @partyID;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `submit_weight` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `submit_weight`( ipartyname VARCHAR(45), iusername VARCHAR(45), idatesubmitted DATETIME)
begin
select @partyID := partyid from party where party.partyname = ipartyname;
select @competitionID := competitionid from competition where competition.partyid = @partyID;
select @playerID := playerid from player where player.username = iusername;
insert into scoresheet (competitionid, playerid, datesubmitted, isverified, scoretype) values (@competitionID, @playerID, idatesubmitted, 0, 'Weight');
SET @partyID = null;
SET @playerID = null;
SET @competitionID = null;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2014-03-14 12:39:15
