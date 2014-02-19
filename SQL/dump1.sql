CREATE DATABASE  IF NOT EXISTS `senior` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `senior`;
-- MySQL dump 10.13  Distrib 5.6.13, for osx10.6 (i386)
--
-- Host: 127.0.0.1    Database: senior
-- ------------------------------------------------------
-- Server version	5.5.33

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
-- Table structure for table `Player`
--

DROP TABLE IF EXISTS `Player`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Player` (
  `playerid` mediumint(9) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `player_password` varchar(50) NOT NULL,
  PRIMARY KEY (`playerid`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Player`
--

LOCK TABLES `Player` WRITE;
/*!40000 ALTER TABLE `Player` DISABLE KEYS */;
INSERT INTO `Player` VALUES (1,'Tanner','password'),(2,'Ted','PW2'),(3,'t','t'),(4,'tann','k'),(5,'',''),(6,'b','b'),(7,'tempa','a'),(8,'duh','d'),(9,'r','r'),(10,'o','o'),(11,'z','z');
/*!40000 ALTER TABLE `Player` ENABLE KEYS */;
UNLOCK TABLES;

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
  CONSTRAINT `competition_ibfk_1` FOREIGN KEY (`partyid`) REFERENCES `party` (`partyid`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `competition`
--

LOCK TABLES `competition` WRITE;
/*!40000 ALTER TABLE `competition` DISABLE KEYS */;
INSERT INTO `competition` VALUES (9,13,'2020-02-18 00:00:00','2014-03-18 00:00:00',1,'Monthly',1),(10,11,'2014-02-21 04:00:23','2014-03-28 03:00:23',1,'Weekly',5),(11,25,'2014-02-19 04:00:33','2014-03-26 03:00:33',1,'Weekly',5),(12,21,'2014-02-19 05:00:38','2014-05-19 04:00:38',1,'Monthly',3);
/*!40000 ALTER TABLE `competition` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `party`
--

LOCK TABLES `party` WRITE;
/*!40000 ALTER TABLE `party` DISABLE KEYS */;
INSERT INTO `party` VALUES (11,'Chimps','tanner','2',0),(13,'ukl','tanner','',1),(21,'teamb','b','',0),(25,'teamz','z','',0);
/*!40000 ALTER TABLE `party` ENABLE KEYS */;
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
  CONSTRAINT `player_party_ibfk_1` FOREIGN KEY (`playerID`) REFERENCES `Player` (`playerid`),
  CONSTRAINT `player_party_ibfk_2` FOREIGN KEY (`partyID`) REFERENCES `Party` (`partyid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `player_party`
--

LOCK TABLES `player_party` WRITE;
/*!40000 ALTER TABLE `player_party` DISABLE KEYS */;
INSERT INTO `player_party` VALUES (1,11),(1,21),(6,21),(11,25);
/*!40000 ALTER TABLE `player_party` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'senior'
--
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
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2014-02-18 21:10:50