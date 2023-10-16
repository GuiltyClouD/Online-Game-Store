CREATE DATABASE  IF NOT EXISTS `myproj` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `myproj`;
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
-- Table structure for table `admin`
--

DROP TABLE IF EXISTS `admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admin` (
  `adminID` int(11) NOT NULL AUTO_INCREMENT,
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
INSERT INTO `admin` VALUES (1,'Mike','4567@mail.com','password'),(2,'Thomas','def@mail.com','password1'),(3,'admin5','admin5@mail.com','5');
/*!40000 ALTER TABLE `admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer` (
  `customerID` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `address` varchar(256) DEFAULT NULL,
  `telephone` varchar(32) DEFAULT NULL,
  `email` varchar(64) NOT NULL,
  `password` varchar(64) NOT NULL,
  `creditCard` varchar(32) DEFAULT NULL,
  `DOB` date NOT NULL,
  PRIMARY KEY (`customerID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES (1,'Faiz','blk123','98761234','1234@mail.com','1','1234 5678 9012 3456','1995-07-04'),(2,'Bob','second block','1234','abc@mail.com','password','12345678','1990-06-05'),(3,'George','home','9876','123@m.com','pw','2345','1992-12-11'),(4,'Tester',NULL,NULL,'1@mail.com','c4ca4238a0b923820dcc509a6f75849b',NULL,'2020-01-01');
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
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
INSERT INTO `gamegenre` VALUES ('1','Battle Royal'),('1','Funny'),('1','Multiplayer'),('1','Online Co-Op'),('10','Action'),('10','Indie'),('10','Metroidvania'),('10','RPG'),('10','Souls-like'),('11','Action'),('11','FPS'),('11','Horror'),('11','Shooter'),('11','Story Rich'),('11','VR'),('12','Action'),('12','Action RPG'),('12','Adventure'),('12','Loot'),('12','RPG'),('13','Free to Play'),('13','RPG'),('13','VR'),('14','CRPG'),('14','Dystopian'),('14','RPG'),('14','Sci-fi'),('15','Anime'),('15','Free to Play'),('15','Music'),('15','Rhythm'),('16','2D'),('16','Action'),('16','Co-op'),('16','Indie'),('16','Online Co-Op'),('16','RPG'),('17','2D'),('17','CRPG'),('17','Exploration'),('17','Open World'),('17','Real-Time'),('18','Farming'),('18','Indie'),('18','Simulation'),('18','Survival'),('19','4X'),('19','RTS'),('19','Sci-fi'),('19','Singleplayer'),('19','Space'),('19','Strategy'),('2','Action'),('2','Anime'),('2','Free to Play'),('2','MMORPG'),('2','RPG'),('20','Action'),('20','Adventure'),('20','Indie'),('20','Rhythm'),('20','Shooter'),('21','Indie'),('22','Adventure'),('22','Casual'),('22','Indie'),('22','Simulation'),('23','Real Time Tactics'),('23','RTS'),('23','Strategy'),('23','Tower Defense'),('24','Competitive'),('24','Massively Multiplayer'),('24','Soccer'),('24','Sports'),('25','Adventure'),('25','Arcade'),('25','Casual'),('25','Platformer'),('25','Strategy'),('26','2D'),('26','Cartoony'),('26','Colorful'),('26','Strategy'),('26','Tower Defense'),('27','Adventure'),('27','Horror'),('27','Indie'),('27','Point & Click'),('27','Puzzle'),('28','2D Platformer'),('28','Indie'),('28','Platformer'),('28','Singleplayer'),('29','3D Fighter'),('29','FPS'),('29','PvE'),('29','Third-Person Shooter'),('3','Action'),('3','Adventure'),('3','Driving'),('3','Multiplayer'),('3','Racing'),('30','Electronic Music'),('30','Experimental'),('30','Music'),('30','Rhythm'),('31','Casual'),('31','Exploration'),('31','FPS'),('31','Horror'),('31','Investigation'),('32','3D'),('32','3D Platformer'),('32','Casual'),('32','Precision Platformer'),('33','Adventure'),('33','Casual'),('33','Simulation'),('34','Action'),('34','Co-op'),('34','Multiplayer'),('34','Open World'),('34','RPG'),('35','Early Access'),('35','Horror'),('35','Multiplayer'),('35','Survival Horror'),('36','Action'),('36','Early Access'),('36','Horror'),('36','Online Co-Op'),('37','Action RPG'),('37','Exploration'),('37','FPS'),('37','Open World'),('38','CRPG'),('38','Dungeons & Dragons'),('38','Early Access'),('38','RPG'),('39','Dark Comedy'),('39','Open World'),('39','Post-Apocalyptic'),('39','RPG'),('4','Board Game'),('4','Party'),('4','Party Game'),('4','Word Game'),('40','Horror'),('40','Multiplayer'),('40','Online Co-Op'),('40','Survival'),('41','Automation'),('41','Base Building'),('41','Crafting'),('41','Open World'),('42','Football'),('42','PVP'),('42','Runner'),('42','Soccer'),('42','Sports'),('43','Casual'),('43','Comedy'),('43','Dating Sim'),('43','Indie'),('43','Multiplayer'),('44','Action'),('44','Cyberpunk'),('44','Fast-Paced'),('44','First-Person'),('45','Cyberpunk'),('45','Futuristic'),('45','Open World'),('45','RPG'),('46','Historical'),('46','Medieval'),('46','RPG'),('46','Simulation'),('46','Strategy'),('47','Destruction'),('47','Heist'),('47','Physics'),('47','Sandbox'),('47','Voxel'),('48','Horror'),('48','Multiple Endings'),('48','Survival'),('48','Survival Horror'),('49','Action'),('49','Fight'),('49','Multiplayer'),('49','Sci-fi'),('49','Space'),('49','VR'),('5','Real Time Tactics'),('5','Stealth'),('5','Strategy'),('5','World War II'),('50','Action'),('50','Demons'),('50','FPS'),('50','Gore'),('50','Great Soundtrack'),('6','FPS'),('6','Free to Play'),('6','Looter Shooter'),('6','Multiplayer'),('7','2D'),('7','Choose Your Own Adventure'),('7','Funny'),('7','Memes'),('8','Action'),('8','Dinosaurs'),('8','Early Access'),('8','FPS'),('8','Violent'),('9','Action'),('9','Adventure'),('9','Co-op'),('9','Multiplayer'),('9','Pirates');
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
  `gameGenre` longtext,
  PRIMARY KEY (`gameID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gamestore`
--

LOCK TABLES `gamestore` WRITE;
/*!40000 ALTER TABLE `gamestore` DISABLE KEYS */;
INSERT INTO `gamestore` VALUES ('1','Fall Guys: Ultimate Knockout','Fall Guys is a massively multiplayer party game with up to 60 players online in a free-for-all struggle through round after round of escalating chaos until one victor remains!',18.50,0,'2020-08-04','fguk.jpg','Multiplayer, Funny, Battle Royal, Online Co-Op'),('10','Vigil: The Longest Night','Battle through the longest night as Leila a member of the Vigilant Order and uncover the truth behind the eternal darkness, Leilas mysterious sister, and the eldritch horrors that stalk her in a world that has forgotten daylight.',20.50,0,'2020-10-15','vtln.jpg','Action, Indie, RPG, Metroidvania, Souls-like'),('11','Half-Life: Alyx','Half-Life: Alyx is Valve?s VR return to the Half-Life series. It?s the story of an impossible fight against a vicious alien race known as the Combine, set between the events of Half-Life and Half-Life 2. Playing as Alyx Vance, you are humanity?s only chance for survival.',49.00,0,'2020-03-24','hla.jpg','VR, FPS, Story Rich, Shooter, Horror, Action'),('12','Torchlight III','In Torchlight III, Novastraia is again under threat of invasion and it?s up to you to defend against the Netherim and its allies. Gather your wits and brave the frontier to find fame, glory, and new adventures!',34.00,0,'2020-10-13','tiii.jpg','RPG, Adventure, Action, Action RPG, Loot'),('13','The Mind Hero','A free, unique comic/anime-style visual novel containing both action and dating elements, The Mind Hero weaves in actual psychology which you can apply to your own life as well.',10.00,0,'2020-12-01','tmh.jpg','Free to Play, RPG, VR'),('14','Paranoia: Happiness is Mandatory','Lead a team of four Troubleshooters of dubious loyalty, who (mostly) obey orders from Friend Computer, a paranoid and irrational artificial intelligence. Inspired by the classic games of the CRPG genre, experience the first official adaptation of the cult role-playing game!',25.00,0,'2020-12-02','phis.jpg','RPG, CRPG, Sci-fi, Dystopian'),('15','Project: Bits','Project: Bits (Pronounced Beats) is a complimentary music and rhythm game. It is primary goal functions as a distribution platform for various songs and steps. Listen to the music. Feel the groove. Hit the arrows.',25.00,0,'2020-12-03','pb.jpg','Free to Play, Rhythm, Anime, Music'),('16','Alien Hominid Invasion','Alien Hominid Invasion is a co-op run ‘n’ gun game packed with chaos, mayhem, and a whole lot of explosions. Beam down to invade randomly-assembled neighborhoods and face the unending swarm of enemy Agents!',39.00,0,'2020-12-04','ahi.jpg','Indie, Co-op, RPG, Online Co-Op, Action, 2D'),('17','Light of the Locked World','Light of the Locked World is a role-playing game in which a portal malfunction takes you to the world of Kayos. Unable to return home, you have to start a new life and face challenges that will redefine you.',19.50,0,'2020-12-05','lotlw.jpg','CRPG, Exploration, Open World, Real-Time, 2D'),('18','Orcish Inn','Orcish Inn is a farming, survival and tavern simulation game in which you raise crops, brew beer and build a tavern for your orcish guests!',5.00,0,'2020-12-06','oi.jpg','Indie, Simulation, Survival, Farming'),('19','Age of Space','Evolve from being a nobody to being the center of power! Age of space combines real time resource management with tactical combat. Work as a mercenary for clients in our solar system as you gradually get dragged into a liberation war between the Martians and the UEA. Who will you side with?',4.90,0,'2020-12-07','aos.jpg','Strategy, Space, RTS, Singleplayer, 4X, Sci-fi'),('2','Phantasy Star Online 2','The long awaited Free-To-Play Online RPG Phantasy Star Online 2 has finally arrived! PSO2 features revolutionary gameplay features, such as endless adventures, Hybrid Custom Action, and unprecedented character customization. Become an ARKS Operative today! Adventure awaits!',0.00,0,'2020-08-05','pso2.jpg','Free to Play, Action, RPG, MMORPG, Anime'),('20','Mariachi Undead','Mariachi Undead is a hand drawn, rhythm, cover based shoot-em-up, action side scrolling platformer where you can even play with a guitar and controller at the same time.',9.90,0,'2020-12-08','mu.jpg','Action, Adventure, Indie, Rhythm, Shooter'),('21','Monsty Corp','A sci-fi story-based puzzle game, Monsty Corp will have you exploring the facility known as \"Monsty Corp\" after you wake up with no idea where you are or why you are there.',10.00,0,'2020-12-09','mc.jpg','Indie'),('22','Soda Story - Brewing Tycoon','Soda Story - Brewing Tycoon is a Casual / Management game that lets you brew and sell your own soda as part of a Reality TV show called \"Prisoneers\".',19.90,0,'2020-12-10','ssbt.jpg','Simulation, Casual, Adventure, Indie'),('23','Sphere Invasion','Sphere Invasion is Sci-Fi Tower Defence. Build your own road and defend it with 7 unique towers.',6.50,0,'2020-10-30','si.jpg','Strategy, RTS, Tower Defense, Real Time Tactics'),('24','World of Soccer RELOADED','Unlike other similar soccer games, the user controls a single player instead of an entire team! World of Soccer RELOADED combines individuality and team play!',0.00,0,'2020-10-28','wosr.jpg','Sports, Massively Multiplayer, Competitive, Soccer'),('25','The mouse and the cheese','An arcade-style strategy / maze game!! Collect all the cheeses to pass the level !!',2.10,0,'2020-10-17','tmatc.jpg','Adventure, Casual, Strategy, Arcade, Platformer'),('26','Slime Pandemic TD','Defend the galaxy against a slimey pandemic in this classic Tower Defence game.',4.20,0,'2020-10-08','spt.jpg','Strategy, Tower Defense, 2D, Cartoony, Colorful'),('27','Almost My Floor: Prologue','A Prologue to Almost My Floor, an upcoming horror-themed point and click adventure. Alex is a real fan of creepy stuff and horror movies, but he never expected to experience it himself just by taking the elevator back home! Can he avoid the madness and deal with the evil he is up against?',0.00,0,'2020-10-05','amfp.jpg','Indie, Point & Click, Adventure, Puzzle, Horror'),('28','Square vs Triangles','Square vs Triangles is a old school 2D platformer with a minimalistic and beautiful art style and challenging gameplay mechanics inspired by 90s classics.',10.00,0,'2020-10-21','svt.jpg','Indie, 2D Platformer, Singleplayer, Platformer'),('29','The Unreal Story','Welcome to The Unreal Story. There is game mode like Campaign, Multiplayer Beta, and Outbreak. We might add more game modes in the future if you guys want more.',14.50,0,'2020-10-16','tus.jpg','3D Fighter, FPS, Third-Person Shooter, PvE'),('3','Need for Speed? Heat','Hustle by day and risk it all at night in Need for Speed? Heat Deluxe Edition, a white-knuckle street racer, where the lines of the law fade as the sun starts to set.',94.90,0,'2019-11-08','nfsh.jpg','Racing, Action, Adventure, Driving, Multiplayer'),('30','Hexagroove: Tactical DJ','A truly creative musical strategy game. Follow 6 rules of music making to clear the stage. Perform DJ tricks to maximize your score. Combine music from 13 dance genres in 7 clubs. Customize your play with 600 instrumental loops. Free demo available.',23.40,10,'2019-10-03','htd.jpg','Rhythm, Experimental, Music, Electronic Music'),('31','Harthorn','It os winter break 1994 and schools out at Harthorn High School, but not all is silent in its empty classrooms and dark hallways...',3.80,0,'2020-10-28','h.jpg','Casual, Horror, FPS, Investigation, Exploration'),('32','MEGAJUMP','Only some will reach the top. Will you be one of them? in this precision 3D platformer where every jump is a risk and easy to learn-hard to master controls you will certainly feel rewarded once you start climbing from the Pit of Despair. Just do not fall.',3.20,0,'2020-10-19','m.jpg','Casual, Precision Platformer, 3D Platformer, 3D'),('33','Kirakira stars idol project Reika','The E-mote Engine brings character portraits to life with life-like, natural animations. Enjoy the story in English, Japanese, or Chinese (Simplified), with full voice acting from the main characters in the Japanese version.',9.70,25,'2020-10-29','ksipr.jpg','Adventure, Casual, Simulation'),('34','Monster Hunter: World','Welcome to a new world! In Monster Hunter: World, the latest installment in the series, you can enjoy the ultimate hunting experience, using everything at your disposal to hunt monsters in a new world teeming with surprises and excitement.',1.60,25,'2018-08-10','mhw.jpg','Co-op, Multiplayer, Action, Open World, RPG'),('35','In Silence','In Silence is a multiplayer horror game. One player takes on the role of the monster who has hypersensitive hearing abilities and is almost completely blind. The other players(2-6) play as survivors, trying to escape or hunting the monster.',10.00,0,'2020-10-17','is.jpg','Early Access, Horror, Multiplayer, Survival Horror'),('36','GTFO','GTFO is a hardcore 4 player cooperative first-person shooter, with a focus on team play and atmosphere. It features edge-of-your-seat suspense, team-based puzzle-solving and high-intensity combat.',49.50,20,'2019-12-10','g.jpg','Early Access, Horror, Online Co-Op, Action'),('37','The Outer Worlds','The Outer Worlds is an award-winning single-player RPG from Obsidian Entertainment and Private Division. As you explore a space colony, the character you decide to become will determine how this player-driven story unfolds. In the colony corporate equation, you are the unplanned variable.',40.90,50,'2020-10-23','tow.jpg','Action RPG, Open World, Exploration, FPS'),('38','Baldur Gate 3','Gather your party, and return to the Forgotten Realms in a tale of fellowship and betrayal, sacrifice and survival, and the lure of absolute power.',69.00,0,'2020-10-07','bg3.jpg','Early Access, RPG, Dungeons & Dragons, CRPG'),('39','Fallout 76','Experience One Wasteland with rebalanced creatures and loot for your level, so anyone can explore Appalachia together. Rank up and claim rewards with the Armor Ace S.C.O.R.E.board, play repeatable Daily Ops missions, and unlock powerful Legendary Perks at Level 50+ !',54.00,0,'2020-04-14','f76.jpg','Dark Comedy, RPG, Open World, Post-Apocalyptic'),('4','The Jackbox Party Pack 7','Five new games: the hit threequel Quiplash 3, the collaborative chaos of The Devils and the Details, the fierce drawing game Champ?d Up, the speech game Talking Points and the guessing game Blather Round. Use phones or tablets as controllers and play with up to 8 players, and an audience of 10,000!',26.00,0,'2020-10-15','tjpp7.jpg','Party Game, Party, Word Game, Board Game'),('40','Hunt: Showdown','Hunt: Showdown is a competitive first-person PvP bounty hunting game with heavy PvE elements, from the makers of Crysis. Set in the darkest corners of the world, it packs the thrill of survival games into a match-based format.',24.50,50,'2019-08-27','hs.jpg','Multiplayer, Survival, Horror, Online Co-Op'),('41','Satisfactory','Satisfactory is a first-person open-world factory building game with a dash of exploration and combat. Play alone or with friends, explore an alien planet, create multi-story factories, and enter conveyor belt heaven!',20.00,20,'2020-06-09','s.jpg','Base Building, Automation, Open World, Crafting'),('42','EA SPORTS™ FIFA 21','Football is back with EA SPORTS™ FIFA 21, featuring more ways to team up on the street or in the stadium to enjoy even bigger victories with friends.',79.90,0,'2020-10-09','esf21.jpg','Sports, Soccer, Runner, PVP, Football'),('43','Monster Prom 2: Monster Camp','\"Monster Prom 2: Monster Camp\" brings you more of the world best (and maybe only?) multiplayer dating sim; but in a way you have never expected!',10.80,10,'2020-10-23','mp2mc.jpg','Indie, Dating Sim, Multiplayer, Comedy, Casual'),('44','Ghostrunner','Ghostrunner offers a unique single-player experience: fast-paced, violent combat, and an original setting that blends science fiction with post-apocalyptic themes. It tells the story of a world that has already ended and its inhabitants who fight to survive.',32.00,20,'2020-10-28','gr.jpg','Action, Cyberpunk, First-Person, Fast-Paced'),('45','Cyberpunk 2077','Cyberpunk 2077 is an open-world, action-adventure story set in Night City, a megalopolis obsessed with power, glamour and body modification. You play as V, a mercenary outlaw going after a one-of-a-kind implant that is the key to immortality.',69.00,0,'2020-12-10','c2077.jpg','Cyberpunk, Open World, RPG, Futuristic'),('46','Crusader Kings III','Paradox Development Studio brings you the sequel to one of the most popular strategy games ever made. Crusader Kings III is the heir to a long legacy of historical grand strategy experiences and arrives with a host of new ways to ensure the success of your royal house.',42.00,0,'2020-09-02','ckiii.jpg','Strategy, RPG, Simulation, Medieval, Historical'),('47','Teardown','Prepare the perfect heist in this simulated and fully destructible voxel world. Tear down walls with vehicles or explosives to create shortcuts. Stack objects to reach higher. Use the environment to your advantage in the most creative way you can think of.',19.90,0,'2020-10-29','t.jpg','Destruction, Voxel, Physics, Sandbox, Heist'),('48','The Dark Pictures Anthology: Little Hope','Trapped and isolated in the abandoned town of Little Hope, 4 college students and their teacher must escape the nightmarish apparitions that relentlessly pursue them through an impenetrable fog.',39.90,0,'2020-10-30','tdpalh.jpg','Horror, Survival Horror, Survival, Multiple Endings'),('49','STAR WARS™: Squadrons','Master the art of starfighter combat in the authentic piloting experience STAR WARS™: Squadrons. Feel the adrenaline of first-person multiplayer space dogfights alongside your squadron, and buckle up in a thrilling STAR WARS™ story.',41.10,25,'2020-10-01','sws.jpg','Fight, Space, Multiplayer, Sci-fi, VR, Action'),('5','Partisans 1941','Partisans 1941 is a real-time tactics game with stealth elements, set on the eastern front of WW II. As an army commander behind enemy lines you gather a group of Partisans to wage guerilla warfare against the German occupants.',26.00,0,'2020-10-14','p1941.jpg','Strategy, Real Time Tactics, World War II, Stealth'),('50','DOOM Eternal','Hell’s armies have invaded Earth. Become the Slayer in an epic single-player campaign to conquer demons across dimensions and stop the final destruction of humanity. The only thing they fear... is you.',40.65,50,'2020-03-20','de.jpg','Action, FPS, Great Soundtrack, Gore, Demons'),('6','Destiny 2','Destiny 2 is an action MMO with a single evolving world that you and your friends can join anytime, anywhere, absolutely free.',0.00,0,'2019-10-01','d2.jpg','Free to Play, Looter Shooter, Multiplayer, FPS'),('7','The Henry Stickmin Collection','A choose-your-own-path where failing is more fun than succeeding.',14.50,0,'2020-08-07','thsc.jpg','Funny, Choose Your Own Adventure, Memes, 2D'),('8','Second Extinction?','Big map. Big dinosaurs. Big guns. With friends or solo, you face an ever changing threat level. Second Extinction is an online FPS with bite.',22.00,0,'2020-10-13','se.jpg','Action, Violent, Dinosaurs, Early Access, FPS'),('9','Sea of Thieves','Sea of Thieves offers the essential pirate experience, from sailing and fighting to exploring and looting ? everything you need to live the pirate life and become a legend in your own right. With no set roles, you have complete freedom to approach the world, and other players, however you choose.',49.50,0,'2020-06-03','sot.jpg','Adventure, Action, Multiplayer, Pirates, Co-op');
/*!40000 ALTER TABLE `gamestore` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shoppingcart`
--

DROP TABLE IF EXISTS `shoppingcart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `shoppingcart` (
  `customerID` int(11) DEFAULT NULL,
  `gameID` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shoppingcart`
--

LOCK TABLES `shoppingcart` WRITE;
/*!40000 ALTER TABLE `shoppingcart` DISABLE KEYS */;
INSERT INTO `shoppingcart` VALUES (4,'1');
/*!40000 ALTER TABLE `shoppingcart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transactionhistory`
--

DROP TABLE IF EXISTS `transactionhistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transactionhistory` (
  `transactionID` int(11) NOT NULL AUTO_INCREMENT,
  `gameID` varchar(10) DEFAULT NULL,
  `customerID` int(11) DEFAULT NULL,
  `PurchaseDate` date DEFAULT NULL,
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
  `customerID` int(11) DEFAULT NULL,
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

-- Dump completed on 2020-11-01 21:37:55
