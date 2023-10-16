create database myproj;
use myproj;

-- MySQL dump 10.13  Distrib 8.0.21, for Win64 (x86_64)
--
-- Host: localhost    Database: myproj
-- ------------------------------------------------------
-- Server version	5.6.49-log

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
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer` (
  `customerID` INT NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `address` varchar(256) DEFAULT NULL,
  `telephone` varchar(32) DEFAULT NULL,
  `email` varchar(64) NOT NULL,
  `password` varchar(64) NOT NULL,
  `creditCard` varchar(32) DEFAULT NULL,
  `DOB` DATE NOT NULL, 
  PRIMARY KEY (`customerID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES (1,'Faiz','blk123','98761234','1234@mail.com','1','1234 5678 9012 3456','1995-7-04'),(2,'Bob','second block','1234','abc@mail.com','password','12345678', '1990-6-05'),(3,'George','home','9876','123@m.com','pw','2345', '1992-12-11');
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;


--
-- Table structure for table `admin`
--

DROP TABLE IF EXISTS `admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admin` (
  `adminID` INT NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `email` varchar(64) NOT NULL,
  `password` varchar(64) NOT NULL,
  PRIMARY KEY (`adminID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin`
--

LOCK TABLES `admin` WRITE;
/*!40000 ALTER TABLE `admin` DISABLE KEYS */;
INSERT INTO `admin` VALUES (1,'Mike','4567@mail.com','password'),(2,'Thomas','def@mail.com','password1');
/*!40000 ALTER TABLE `admin` ENABLE KEYS */;
UNLOCK TABLES;


--
-- Table structure for table `gamegenre`
--

DROP TABLE IF EXISTS `gamegenre`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gamegenre` (
  `gameID` varchar(10) NOT NULL DEFAULT '',
  `gameGenre` varchar(32) NOT NULL DEFAULT '',
  PRIMARY KEY (`gameID`,`gameGenre`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gamegenre`
--

LOCK TABLES `gamegenre` WRITE;
/*!40000 ALTER TABLE `gamegenre` DISABLE KEYS */;
INSERT INTO `gamegenre` VALUES ('1','Battle Royal'),('1','Funny'),('1','Multiplayer'),('1','Online Co-Op'),('10','Action'),('10','Indie'),('10','Metroidvania'),('10','RPG'),('10','Souls-like'),('11','Action'),('11','FPS'),('11','Horror'),('11','Shooter'),('11','Story Rich'),('11','VR'),('12','Action'),('12','Action RPG'),('12','Adventure'),('12','Loot'),('12','RPG'),('2','Action'),('2','Anime'),('2','Free to Play'),('2','MMORPG'),('2','RPG'),('3','Action'),('3','Adventure'),('3','Driving'),('3','Multiplayer'),('3','Racing'),('4','Board Game'),('4','Party'),('4','Party Game'),('4','Word Game'),('5','Real Time Tactics'),('5','Stealth'),('5','Strategy'),('5','World War II'),('6','FPS'),('6','Free to Play'),('6','Looter Shooter'),('6','Multiplayer'),('7','2D'),('7','Choose Your Own Adventure'),('7','Funny'),('7','Memes'),('8','Action'),('8','Dinosaurs'),('8','Early Access'),('8','FPS'),('8','Violent'),('9','Action'),('9','Adventure'),('9','Co-op'),('9','Multiplayer'),('9','Pirates');
/*!40000 ALTER TABLE `gamegenre` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gameplatform`
--

DROP TABLE IF EXISTS `gameplatform`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gameplatform` (
  `gameID` varchar(10) NOT NULL DEFAULT '',
  `platform` varchar(16) NOT NULL DEFAULT '',
  PRIMARY KEY (`gameID`,`platform`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gameplatform`
--

LOCK TABLES `gameplatform` WRITE;
/*!40000 ALTER TABLE `gameplatform` DISABLE KEYS */;
/*!40000 ALTER TABLE `gameplatform` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gamestore`
--

DROP TABLE IF EXISTS `gamestore`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gamestore` (
  `gameID` varchar(10) NOT NULL,
  `gameTitle` varchar(64) NOT NULL,
  `gameDescription` longtext,
  `price` decimal(65,2) NOT NULL,
  `discount` int(11) DEFAULT '0',
  `releaseDate` date DEFAULT NULL,
  `gameImage` longtext,
  PRIMARY KEY (`gameID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gamestore`
--

LOCK TABLES `gamestore` WRITE;
/*!40000 ALTER TABLE `gamestore` DISABLE KEYS */;
INSERT INTO `gamestore` VALUES ('1','Fall Guys: Ultimate Knockout','Fall Guys is a massively multiplayer party game with up to 60 players online in a free-for-all struggle through round after round of escalating chaos until one victor remains!',18.50,0,'2020-08-04','fguk.jpg'),('10','Vigil: The Longest Night','Battle through the longest night as Leila a member of the Vigilant Order and uncover the truth behind the eternal darkness, Leila\'s mysterious sister, and the eldritch horrors that stalk her in a world that has forgotten daylight.',20.50,0,'2020-10-15','vtln.jpg'),('11','Half-Life: Alyx','Half-Life: Alyx is Valve?s VR return to the Half-Life series. It?s the story of an impossible fight against a vicious alien race known as the Combine, set between the events of Half-Life and Half-Life 2. Playing as Alyx Vance, you are humanity?s only chance for survival.',49.00,0,'2020-03-24','hla.jpg'),('12','Torchlight III','In Torchlight III, Novastraia is again under threat of invasion and it?s up to you to defend against the Netherim and its allies. Gather your wits and brave the frontier to find fame, glory, and new adventures!',34.00,0,'2020-10-13','tiii.jpg'),('2','Phantasy Star Online 2','The long awaited Free-To-Play Online RPG Phantasy Star Online 2 has finally arrived! PSO2 features revolutionary gameplay features, such as endless adventures, Hybrid Custom Action, and unprecedented character customization. Become an ARKS Operative today! Adventure awaits!',0.00,0,'2020-08-05','pso2.jpg'),('3','Need for Speed? Heat','Hustle by day and risk it all at night in Need for Speed? Heat Deluxe Edition, a white-knuckle street racer, where the lines of the law fade as the sun starts to set.',94.90,0,'2019-11-08','nfsh.jpg'),('4','The Jackbox Party Pack 7','Five new games: the hit threequel Quiplash 3, the collaborative chaos of The Devils and the Details, the fierce drawing game Champ?d Up, the speech game Talking Points and the guessing game Blather \'Round. Use phones or tablets as controllers and play with up to 8 players, and an audience of 10,000!',26.00,0,'2020-10-15','tjpp7.jpg'),('5','Partisans 1941','Partisans 1941 is a real-time tactics game with stealth elements, set on the eastern front of WW II. As an army commander behind enemy lines you gather a group of Partisans to wage guerilla warfare against the German occupants.',26.00,0,'2020-10-14','p1941.jpg'),('6','Destiny 2','Destiny 2 is an action MMO with a single evolving world that you and your friends can join anytime, anywhere, absolutely free.',0.00,0,'2019-10-01','d2.jpg'),('7','The Henry Stickmin Collection','A choose-your-own-path where failing is more fun than succeeding.',14.50,0,'2020-08-07','thsc.jpg'),('8','Second Extinction?','Big map. Big dinosaurs. Big guns. With friends or solo, you face an ever changing threat level. Second Extinction is an online FPS with bite.',22.00,0,'2020-10-13','se.jpg'),('9','Sea of Thieves','Sea of Thieves offers the essential pirate experience, from sailing and fighting to exploring and looting ? everything you need to live the pirate life and become a legend in your own right. With no set roles, you have complete freedom to approach the world, and other players, however you choose.',49.50,0,'2020-06-03','sot.jpg');
/*!40000 ALTER TABLE `gamestore` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shoppingcart`
--

DROP TABLE IF EXISTS `shoppingcart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `shoppingcart` (
  `customerID` INT DEFAULT NULL,
  `gameID` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shoppingcart`
--

LOCK TABLES `shoppingcart` WRITE;
/*!40000 ALTER TABLE `shoppingcart` DISABLE KEYS */;
/*!40000 ALTER TABLE `shoppingcart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transactionhistory`
--

DROP TABLE IF EXISTS `transactionhistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transactionhistory` (
  `transactionID` INT NOT NULL AUTO_INCREMENT,
  `gameID` varchar(10) DEFAULT NULL,
  `customerID` INT DEFAULT NULL,
  `PurchaseDate` DATE DEFAULT NULL,
  PRIMARY KEY (`transactionID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transactionhistory`
--

LOCK TABLES `transactionhistory` WRITE;
/*!40000 ALTER TABLE `transactionhistory` DISABLE KEYS */;
/*!40000 ALTER TABLE `transactionhistory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wishlist`
--

DROP TABLE IF EXISTS `wishlist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wishlist` (
  `customerID` INT DEFAULT NULL,
  `gameID` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wishlist`
--

LOCK TABLES `wishlist` WRITE;
/*!40000 ALTER TABLE `wishlist` DISABLE KEYS */;
/*!40000 ALTER TABLE `wishlist` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-10-19 20:41:54
