-- MySQL dump 10.13  Distrib 5.5.38, for Linux (i686)
--
-- Host: localhost    Database: zm
-- ------------------------------------------------------
-- Server version	5.5.38

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
-- Table structure for table `Monitors`
--

DROP TABLE IF EXISTS `Monitors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Monitors` (
  `Id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Name` varchar(64) NOT NULL DEFAULT '',
  `Type` enum('Local','Remote','File','Ffmpeg','Libvlc','cURL') NOT NULL DEFAULT 'Local',
  `Function` enum('None','Monitor','Modect','Record','Mocord','Nodect') NOT NULL DEFAULT 'Monitor',
  `Enabled` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `LinkedMonitors` varchar(255) NOT NULL DEFAULT '',
  `Triggers` set('X10') NOT NULL DEFAULT '',
  `Device` tinytext NOT NULL,
  `Channel` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `Format` int(10) unsigned NOT NULL DEFAULT '0',
  `V4LMultiBuffer` tinyint(1) unsigned DEFAULT NULL,
  `V4LCapturesPerFrame` tinyint(3) unsigned DEFAULT NULL,
  `Protocol` varchar(16) NOT NULL DEFAULT '',
  `Method` varchar(16) NOT NULL DEFAULT '',
  `Host` varchar(64) NOT NULL DEFAULT '',
  `Port` varchar(8) NOT NULL DEFAULT '',
  `SubPath` varchar(64) NOT NULL DEFAULT '',
  `Path` varchar(255) NOT NULL DEFAULT '',
  `Options` varchar(255) NOT NULL DEFAULT '',
  `User` varchar(64) NOT NULL DEFAULT '',
  `Pass` varchar(64) NOT NULL DEFAULT '',
  `Width` smallint(5) unsigned NOT NULL DEFAULT '0',
  `Height` smallint(5) unsigned NOT NULL DEFAULT '0',
  `Colours` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `Palette` int(10) unsigned NOT NULL DEFAULT '0',
  `Orientation` enum('0','90','180','270','hori','vert') NOT NULL DEFAULT '0',
  `Deinterlacing` int(10) unsigned NOT NULL DEFAULT '0',
  `Brightness` mediumint(7) NOT NULL DEFAULT '-1',
  `Contrast` mediumint(7) NOT NULL DEFAULT '-1',
  `Hue` mediumint(7) NOT NULL DEFAULT '-1',
  `Colour` mediumint(7) NOT NULL DEFAULT '-1',
  `EventPrefix` varchar(32) NOT NULL DEFAULT 'Event-',
  `LabelFormat` varchar(64) NOT NULL DEFAULT '%N - %y/%m/%d %H:%M:%S',
  `LabelX` smallint(5) unsigned NOT NULL DEFAULT '0',
  `LabelY` smallint(5) unsigned NOT NULL DEFAULT '0',
  `ImageBufferCount` smallint(5) unsigned NOT NULL DEFAULT '100',
  `WarmupCount` smallint(5) unsigned NOT NULL DEFAULT '25',
  `PreEventCount` smallint(5) unsigned NOT NULL DEFAULT '10',
  `PostEventCount` smallint(5) unsigned NOT NULL DEFAULT '10',
  `StreamReplayBuffer` int(10) unsigned NOT NULL DEFAULT '1000',
  `AlarmFrameCount` smallint(5) unsigned NOT NULL DEFAULT '1',
  `SectionLength` int(10) unsigned NOT NULL DEFAULT '600',
  `FrameSkip` smallint(5) unsigned NOT NULL DEFAULT '0',
  `MotionFrameSkip` smallint(5) unsigned NOT NULL DEFAULT '0',
  `MaxFPS` decimal(5,2) DEFAULT NULL,
  `AlarmMaxFPS` decimal(5,2) DEFAULT NULL,
  `FPSReportInterval` smallint(5) unsigned NOT NULL DEFAULT '250',
  `RefBlendPerc` tinyint(3) unsigned NOT NULL DEFAULT '6',
  `AlarmRefBlendPerc` tinyint(3) unsigned NOT NULL DEFAULT '6',
  `Controllable` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `ControlId` int(10) unsigned NOT NULL DEFAULT '0',
  `ControlDevice` varchar(255) DEFAULT NULL,
  `ControlAddress` varchar(255) DEFAULT NULL,
  `AutoStopTimeout` decimal(5,2) DEFAULT NULL,
  `TrackMotion` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `TrackDelay` smallint(5) unsigned NOT NULL DEFAULT '0',
  `ReturnLocation` tinyint(3) NOT NULL DEFAULT '-1',
  `ReturnDelay` smallint(5) unsigned NOT NULL DEFAULT '0',
  `DefaultView` enum('Events','Control') NOT NULL DEFAULT 'Events',
  `DefaultRate` smallint(5) unsigned NOT NULL DEFAULT '100',
  `DefaultScale` smallint(5) unsigned NOT NULL DEFAULT '100',
  `SignalCheckColour` varchar(32) NOT NULL DEFAULT '#0000BE',
  `WebColour` varchar(32) NOT NULL DEFAULT 'red',
  `Sequence` smallint(5) unsigned DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Monitors`
--

LOCK TABLES `Monitors` WRITE;
/*!40000 ALTER TABLE `Monitors` DISABLE KEYS */;
INSERT INTO `Monitors` VALUES (1,'Logitech-C200','Local','Monitor',1,'','','/dev/video-C200-0',0,255,0,1,'','v4l2','','80','','','','','',320,240,3,0,'0',0,-1,-1,-1,-1,'Event-','%N - %d/%m/%y %H:%M:%S',0,0,50,25,25,25,1000,1,600,0,0,0.00,0.00,1000,6,6,0,0,NULL,NULL,NULL,0,0,-1,0,'Events',100,100,'#0000c0','red',1),(2,'Logitech-Quickcam','Local','Monitor',1,'','','/dev/video-quickcam-0',0,255,0,1,'','v4l2','','80','','','','','',320,240,3,0,'0',0,-1,-1,-1,-1,'Event-','%N - %d/%m/%y %H:%M:%S',0,0,50,25,25,25,1000,1,600,0,0,0.00,0.00,1000,6,6,0,0,NULL,NULL,NULL,0,0,-1,0,'Events',100,100,'#0000c0','red',2);
/*!40000 ALTER TABLE `Monitors` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-02-28 23:27:22
