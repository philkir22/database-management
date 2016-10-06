--Queries from lab 5
--Author: Phil Kirwin

--Qeustion 1
SELECT a.city
FROM agents a INNER JOIN orders o ON a.aid = o.aid
WHERE o.cid = 'c006';

--Question 2
SELECT DISTINCT o.pid
FROM orders o INNER JOIN (orders o2 INNER JOIN customers c ON o2.cid = c.cid 
														   AND c.city = 'Kyoto') 
						 ON o.aid = o2.aid
ORDER BY o.pid DESC;

--Question 3
SELECT DISTINCT name
FROM customers
WHERE cid NOT IN (SELECT cid 
				  FROM orders
				 )
				 
--Question 4
SELECT DISTINCT c.name
FROM customers c LEFT OUTER JOIN orders o ON c.cid = o.cid
WHERE o.cid IS null;

--Question 5
SELECT DISTINCT c.name, a.name
FROM orders o INNER JOIN customers c ON o.cid = c.cid
	          INNER JOIN agents a ON o.aid = a.aid
WHERE a.city = c.city;

--Question 6
SELECT DISTINCT c.name, a.name, c.city
FROM customers c INNER JOIN agents a ON c.city = a.city;

--Question 7
SELECT c.name, p.city, count(p.city)
FROM customers c INNER JOIN products p ON c.city = p.city
GROUP BY c.name, p.city
ORDER BY count(p.city) ASC;