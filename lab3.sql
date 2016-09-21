--Queries from lab 3
--Author: Phil Kirwin

--Question 1
SELECT ordnum, totalUSD
FROM Orders;

--Question 2
SELECT name, city
FROM Agents
WHERE name = 'Smith';

--Question 3
SELECT pid, name, priceUSD
FROM Products
WHERE quantity > 201000;

--Question 4
SELECT name, city
FROM Customers
WHERE city = 'Duluth';

--Question 5
SELECT name
FROM Agents
WHERE city <> 'New York' 
  AND city <> 'Duluth';

--Question 6
SELECT *
FROM Products
WHERE city <> 'Dallas' 
  AND city <> 'Duluth'
  AND priceUSD >= 1;

--Question 7
SELECT *
FROM Orders
WHERE mon = 'feb' 
   OR mon = 'mar';
   
--Question 8
SELECT *
FROM Orders
WHERE mon = 'feb' 
  AND totalUSD >= 600;
  
--Question 9
SELECT *
FROM Orders
WHERE cid = 'c005';
