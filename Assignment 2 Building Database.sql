CREATE DATABASE iTunesDB;

CREATE TABLE Customer(
  CustomerID bigint NOT NULL PRIMARY KEY,
  FirstName varchar(50) NOT NULL,
  LastName varchar(50) NOT NULL,
  Birthday date NOT NULL,
  Gender varchar(6) NOT NULL,
  Address varchar (50) NOT NULL,
  CreditCardID bigint NOT NULL);

CREATE TABLE Credit_Card(
  CreditCardID bigint NOT NULL PRIMARY KEY,
  Card_Number bigint NOT NULL,
  Card_Type varchar(50) NOT NULL,
  Expiration_Date date NOT NULL);

ALTER TABLE Customer ADD CONSTRAINT FK_Customer_CreditCard 
FOREIGN KEY (CreditCardID) REFERENCES Credit_Card(CreditCardID);

CREATE TABLE Order_Header(
  OrderID bigint NOT NULL PRIMARY KEY,
  Order_Date date NOT NULL,
  CustomerID bigint NOT NULL,
  CreditCardID bigint NOT NULL);

ALTER TABLE Order_Header ADD CONSTRAINT FK_Order_Header_Customer 
FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID);

ALTER TABLE Order_Header ADD CONSTRAINT FK_Order_Header_CreditCard 
FOREIGN KEY (CreditCardID) REFERENCES Credit_Card(CreditCardID);

CREATE TABLE Order_Detail(
  OrderDetailID bigint NOT NULL PRIMARY KEY,
  OrderID bigint NOT NULL,
  SongID bigint NOT NULL,
  AlbumID bigint NOT NULL,
  LineTotal bigint NOT NULL);

ALTER TABLE Order_Detail ADD CONSTRAINT FK_Order_Detail_Order
FOREIGN KEY (OrderID) REFERENCES Order_Header(OrderID);

INSERT INTO Customer (CustomerID, FirstName, LastName, Birthday, Gender, Address, CreditCardID) VALUES
(1, 'Jose', 'Gonzalez', '1997-07-22', 'Male', '21 Babson College Drive, Wellesley MA', 1),
(2, 'Dennis', 'Kim', '1997-01-01', 'Male', '22 Babson College Drive, Wellesley MA', 2),
(3, 'Jane', 'Doe', '1997-02-01', 'Female', '23 Babson College Drive, Wellesley MA', 3),
(4, 'John', 'Doe', '1998-01-01', 'Male', '24 Babson College Drive, Wellesley MA', 4),
(5, 'Margaret', 'Thatcher', '1925-10-13', 'Female', '1 Picadilly, London UK', 5),
(6, 'Donald', 'Trump', '1946-06-14', 'Male', '1600 Pennsylvania Ave NW, Washington, DC', 6),
(7, 'Michelle', 'Obama', '1964-01-17', 'Female', '1601 Pennsylvania Ave NW, Washington, DC', 7),
(8, 'Barack', 'Obama', '1961-08-04', 'Male', '1601 Pennsylvania Ave NW, Washington, DC', 8),
(9, 'Melania', 'Trump', '1970-04-26', 'Female', '1600 Pennsylvania Ave NW, Washington, DC', 9),
(10, 'Hillary', 'Clinton', '1947-08-26', 'Female', '1599 Pennsylvania Ave NW, Washington, DC', 10);

INSERT INTO Credit_Card(CreditCardID, Card_Number, Card_Type, Expiration_Date) VALUES
(1, 0000000000000001, 'Visa', '2018-01-01'),
(2, 0000000000000011, 'MasterCard', '2018-02-01'),
(3, 0000000000000111, 'American Express', '2018-01-02'),
(4, 0000000000001111, 'Visa', '2019-01-01'),
(5, 0000000000011111, 'MasterCard', '2019-01-02'),
(6, 0000000000111111, 'American Express', '2019-02-01'),
(7, 0000000001111111, 'Visa', '2020-01-01'),
(8, 0000000011111111, 'MasterCard', '2020-02-02'),
(9, 0000000111111111, 'American Express', '2019-03-02'),
(10, 0000001111111111, 'Visa', '2019-01-03');

INSERT INTO Order_Header(OrderID, Order_Date, CustomerID, CreditCardID) VALUES
(1, '2018-01-01', 1, 1),
(2, '2018-01-02', 2, 2),
(3, '2018-05-03', 3, 3),
(4, '2018-05-04', 4, 4),
(5, '2018-06-05', 5, 5),
(6, '2018-06-06', 6, 6),
(7, '2018-07-07', 7, 7),
(8, '2018-07-03', 8, 8),
(9, '2018-07-03', 9, 9),
(10, '2018-01-10', 10, 10);

ALTER TABLE Order_Detail ALTER COLUMN SongID bigint NULL;

ALTER TABLE Order_Detail ALTER COLUMN AlbumID bigint NULL;

INSERT INTO Order_Detail(OrderDetailID, OrderID, SongID, AlbumID, LineTotal) VALUES
(1, 1, 1, NULL, .99),
(2, 1, 2, 1, .99),
(3, 2, 1, NULL, .99),
(4, 3, 1, NULL, .99),
(5, 4, 3, 2, .99),
(6, 5, 4, 3, .99),
(7, 6, NULL, 4, 12.99),
(8, 6, NULL, 5, 12.99),
(9, 7, 5, 5, .99),
(10, 8, 6, 6, .99),
(11, 9, 7, 7, .99),
(12, 10, 8, NULL, 12.99);

UPDATE Order_Detail
SET SongID = NULL, AlbumID = 8
WHERE OrderDetailID = 12;

CREATE TABLE Songs(
  SongID bigint NOT NULL PRIMARY KEY,
  Song_Name varchar(50) NOT NULL,
  Release_Date date NOT NULL,
  ArtistID bigint NOT NULL,
  List_Price bigint NOT NULL,
  AlbumID bigint,
  Genre varchar(50) NOT NULL);

INSERT INTO Songs(SongID, Song_Name, Release_Date, ArtistID, List_Price, AlbumID, Genre) VALUES
(1, 'Gods Plan', '2018-01-01', 1, .99, NULL, 'Rap'),
(2, 'One Dance', '2017-01-01', 1, .99, 1, 'Rap'),
(3, 'River', '2018-02-02', 2, .99, 2, 'Rap'),
(4, 'The Middle', '2018-03-03', 3, .99, 3, 'Electronic'),
(5, 'Easier', '2016-04-04', 4, .99, 5, 'Electronic'),
(6, 'Lucid', '2015-05-05', 5, .99, 6, 'Electronic'),
(7, 'Bruises', '2014-06-06', 6, .99, 7, 'Indie'),
(8, 'These Are the Days', '2013-07-07', 7, .99, 8, 'Indie'),
(9, 'Thunderstruck', '2012-08-08', 8, .99, 8, 'Rock'),
(10, 'Back in Black', '2011-09-09', 9, .99, 9, 'Rock');

CREATE TABLE Artist(
  ArtistID bigint NOT NULL PRIMARY KEY,
  Artist_Name varchar(50) NOT NULL,
  Date_of_Birth date NOT NULL,
  Gender varchar(6) NOT NULL,
  Record_Label varchar(50));

ALTER TABLE Artist ALTER COLUMN Date_of_Birth date NULL;

ALTER TABLE Artist ALTER COLUMN Gender varchar(6) NULL;

INSERT INTO Artist(ArtistID, Artist_Name, Date_of_Birth, Gender, Record_Label) VALUES
(1, 'Drake', '1980-01-01', 'Male', 'OVO'),
(2, 'Eminem', '1972-10-17', 'Male', 'Aftermath'),
(3, 'Zedd', '1990-02-02', 'Female', NULL),
(4, 'Mansionair', '1995-03-03', 'Female', NULL),
(5, 'Cloudsz', '1996-04-04', 'Male', NULL),
(6, 'Lewis Capaldi', '1975-05-05', 'Male', NULL),
(7, 'Zach Winters', '1985-06-06', 'Male', NULL),
(8, 'ACDC', NULL, NULL, 'Atlantic Records'),
(9, 'Taylor Swift', '1992-07-07', 'Female', 'Big Machine Records'),
(10, 'Adele', '1987-08-08', 'Female', 'XL Recordings');

CREATE TABLE Album(
  AlbumID bigint NOT NULL PRIMARY KEY,
  Album_Name varchar(50) NOT NULL,
  Release_Date date NOT NULL,
  ArtistID bigint NOT NULL,
  List_Price bigint NOT NULL);

INSERT INTO Album(AlbumID, Album_Name, Release_Date, ArtistID, List_Price) VALUES
(1, 'Views', '2016-01-01', 1, 12.99),
(2, 'River', '2018-02-02', 2, 12.99),
(3, 'The Middle', '2018-01-01', 3, 12.99),
(4, 'Reputation', '2017-03-03', 9, 12.99),
(5, 'Easier', '2016-04-04', 4, 12.99),
(6, 'Lucid', '2016-05-05', 5, 12.99),
(7, 'Bloom', '2017-06-06', 6, 12.99),
(8, 'Monarch', '2014-07-07', 7, 12.99),
(9, 'The Razors Edge', '1990-08-08', 8, 12.99),
(10, '25', '2016-09-09', 10, 12.99);

ALTER TABLE Order_Detail ADD CONSTRAINT FK_Order_Detail_Songs 
FOREIGN KEY (SongID) REFERENCES Songs(SongID);

ALTER TABLE Order_Detail ADD CONSTRAINT FK_Order_Detail_Album 
FOREIGN KEY (AlbumID) REFERENCES Album(AlbumID);

ALTER TABLE Songs ADD CONSTRAINT FK_Songs_Artist
FOREIGN KEY (ArtistID) REFERENCES Artist(ArtistID);

ALTER TABLE Songs ADD CONSTRAINT FK_Songs_Album
FOREIGN KEY (AlbumID) REFERENCES Album(AlbumID);

ALTER TABLE Album ADD CONSTRAINT FK_Album_Artist
FOREIGN KEY (ArtistID) REFERENCES Artist(ArtistID);