create database myproj;
use myproj;

CREATE TABLE customer (
	customerID INT auto_increment PRIMARY KEY,
	name VARCHAR(64) NOT NULL,
	address VARCHAR (256),
	telephone VARCHAR(20),
	email VARCHAR(64) NOT NULL,
    password varchar(64) NOT NULL, 
	creditCard VARCHAR(32) NOT NULL
);

CREATE TABLE gameStore (
	gameID VARCHAR(10) PRIMARY KEY,
	gameTitle VARCHAR(64) NOT NULL,
	gameDescription VARCHAR(256),
	price DECIMAL(65, 2) NOT NULL,
	discount INTEGER DEFAULT 0,
    CHECK (discount >= 0 AND discount <= 100),
	releaseDate date
);

CREATE TABLE gameGenre ( 
	gameID VARCHAR(10) REFERENCES gamestore(gameID) ON DELETE CASCADE ON UPDATE CASCADE, 
	gameGenre VARCHAR(16) CHECK(gameGenre = 'Horror' OR gameGenre = 'FPS' OR
	gameGenre = 'RPG' OR gameGenre = 'Puzzle' OR gameGenre = 'Tactical' OR 
	gameGenre = 'Simulator' OR gameGenre = 'Story'), 
	PRIMARY KEY (gameID, gameGenre)
);

CREATE TABLE gamePlatform(
	gameID VARCHAR(10) REFERENCES gameStore(gameID) ON DELETE CASCADE ON UPDATE CASCADE,
	platform VARCHAR(16) CHECK (platform = 'PC' OR platform = 'IOS' OR platform = 'Android' OR platform = 'Xbox' OR platform = 'Play Station' OR platform = 'Nintendo Switch'),
	PRIMARY KEY (gameID, platform)
);

CREATE TABLE shoppingCart (
	customerID INT REFERENCES customer(customerID),
	gameID VARCHAR(10) REFERENCES gameStore(gameID)
);

CREATE TABLE transactionHistory (
	transactionID VARCHAR(10) PRIMARY KEY,
	gameID VARCHAR(10) NOT NULL,
	customerID INT REFERENCES customer(customerID) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE wishList ( 
	customerID INT REFERENCES customer(customerID),
	gameID VARCHAR(10) REFERENCES gamestore(gameID)
);



