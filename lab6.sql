--The lovely queries of lab 6
--Author: Phil Kirwin

--Question 1
SELECT c.name, p.city
FROM (SELECT count(city) AS citycount
      FROM products
      GROUP BY city
     )cc,
customers c INNER JOIN products p ON c.city = p.city
GROUP BY c.name, p.city
HAVING MAX(citycount) = COUNT(p.city)/MAX(citycount);

--Question 2
SELECT name
FROM products
WHERE priceUSD < (SELECT AVG(priceUSD)
		          FROM products
		         )
ORDER BY name DESC;

--Question 3
SELECT c.name, o.pid, o.totalUSD
FROM orders o INNER JOIN customers c ON o.cid = c.cid
ORDER BY o.totalUSD ASC;

--Question 4
SELECT c.name, COALESCE(SUM(o.totalUSD), 0) AS total
FROM orders o RIGHT OUTER JOIN customers c ON o.cid = c.cid
GROUP BY c.cid
ORDER BY c.name ASC;

--Question 5
SELECT c.name, p.name, a.name
FROM orders o INNER JOIN customers c ON o.cid = c.cid
	          INNER JOIN products p ON o.pid = p.pid
	          INNER JOIN agents a ON o.aid = a.aid
WHERE a.city = 'New York';

--Question 6
SELECT o.ordnum, o.totalUSD
FROM orders o INNER JOIN products p ON o.pid = p.pid
	          INNER JOIN customers c ON o.cid = c.cid
WHERE o.totalUSD = (p.priceUSD * o.qty) - ((p.priceUSD * o.qty) * c.discount / 100)
