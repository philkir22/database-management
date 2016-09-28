--Queries from Lab 4
--Author: Phil Kirwin

--Question 1
SELECT city
FROM Agents
WHERE aid IN (SELECT aid
	          FROM Orders
	          WHERE cid = 'c006'
	         );
		 
--Question 2
SELECT DISTINCT pid
FROM Orders
WHERE aid IN (SELECT aid
	          FROM Orders
	          WHERE cid IN(SELECT cid
			               FROM Customers
			               WHERE city = 'Kyoto'
			              )
	          )
ORDER BY pid DESC;

--Question 3
SELECT cid, name
FROM Customers
WHERE cid NOT IN (SELECT cid
		          FROM Orders
		          WHERE aid = 'a03'
				 );
				 
--Question 4
SELECT DISTINCT cid
FROM Orders
WHERE pid = 'p01'
  AND cid IN (SELECT cid
	          FROM Orders
	          WHERE pid = 'p07'
	         );
			 
--Question 5
SELECT DISTINCT pid
FROM Orders
WHERE cid NOT IN (SELECT cid
	              FROM Orders
	              WHERE aid = 'a08'
	             )
ORDER BY pid DESC;

--Question 6
SELECT name, discount, city
FROM Customers
WHERE cid IN(SELECT cid
	         FROM Orders
	         WHERE aid IN (SELECT aid
			               FROM Agents
						   WHERE city = 'Dallas'
						   OR city = 'New York'
						  )
			);
			
--Question 7
SELECT DISTINCT cid
FROM Customers
WHERE discount IN (SELECT discount
				   FROM Customers
				   WHERE city = 'Dallas'
					OR city = 'London'
				  );
				  