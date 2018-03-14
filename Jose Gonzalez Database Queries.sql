/* Team/Team Member: Jose Gonzalez */

USE iTunesDB;

/* Select * queries for each table*/

SELECT *
FROM Album;

SELECT *
FROM Customer;

SELECT *
FROM Artist;

SELECT *
FROM Credit_Card;

SELECT *
FROM Order_Detail;

SELECT *
FROM Order_Header;

SELECT *
FROM Songs;

/* Query with Aggregate function: Count of all songs purchased that were singles (AlbumID IS Null) */

SELECT COUNT(OrderDetailID) AS 'Singles Purchased'
FROM Order_Detail
WHERE Order_Detail.AlbumID IS NULL;

/* Query that selects records from multiple tables with INNER JOIN: Names of all customers and their type of credit card */

SELECT Customer.FirstName, Customer.LastName, Credit_Card.Card_Type
FROM Customer
INNER JOIN Credit_Card
  ON Customer.CreditCardID = Credit_Card.CreditCardID;

/* Query that selects records from multiple tables with LEFT JOIN: Names of all albums purchased as a single unit (SondID IS NULL).
LEFT JOIN necessary because not all orders have an AlbumID associated with them */

SELECT Album.Album_Name
FROM Album
LEFT JOIN Order_Detail
  ON Album.AlbumID = Order_Detail.AlbumID
WHERE Order_Detail.OrderDetailID IS NULL;

/* Query that uses a subquery: OrderIDs of orders with individual items more expensive than the average individual cost of items ordered */

SELECT OrderID, LineTotal
FROM Order_Detail
WHERE LineTotal > (
  SELECT AVG(LineTotal)
  FROM Order_Detail);