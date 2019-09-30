
-- Select Database
USE [TSQL];
GO

-- Soal 1
SELECT o.custid, c.contactname
FROM Sales.Orders AS o
    INNER JOIN Sales.Customers AS c ON o.custid = c.custid
WHERE o.empid >= 0
GROUP BY o.custid, c.contactname;
GO

SELECT custid, contactname, city
FROM Sales.Customers
WHERE custid IN(
    SELECT custid
FROM Sales.Orders
WHERE empid >= 0);

-- Soal 2
SELECT o.custid, c.contactname, c.city
FROM Sales.Orders AS o
    INNER JOIN Sales.Customers AS c ON o.custid = c.custid
GROUP BY o.custid, c.contactname, o.empid
HAVING o.empid = 5;
GO

-- Soal 4
SELECT o.custid, c.contactname, c.city
FROM Sales.Orders AS o
    INNER JOIN Sales.Customers AS c ON o.custid = c.custid
GROUP BY o.custid, c.contactname, o.empid, c.city
HAVING o.empid = 5;
GO

-- Soal 5
SELECT o.custid, YEAR(o.orderdate) AS orderyear
FROM Sales.Orders AS o
GROUP BY o.custid, YEAR(o.orderdate), o.empid
HAVING o.empid = 5;
GO

-- Soal 6
SELECT c.categoryid, c.categoryname
FROM Production.Categories AS c
    INNER JOIN Production.Products AS p ON p.categoryid = c.categoryid
    INNER JOIN Sales.OrderDetails AS od ON od.productid = p.productid
    INNER JOIN Sales.Orders AS o ON o.orderid = od.orderid
GROUP BY c.categoryid, c.categoryname, YEAR(o.orderdate)
HAVING YEAR(o.orderdate) = 2008
ORDER BY c.categoryid ASC;
GO

SELECT c.categoryid, c.categoryname
FROM Production.Categories AS c
WHERE c.categoryid IN(SELECT p.categoryid
FROM Production.Products AS p
WHERE p.productid IN(SELECT od.productid
FROM Sales.OrderDetails AS od
WHERE od.orderid IN(SELECT o.orderid
FROM Sales.Orders AS o
WHERE YEAR(o.orderdate) = 2008)))
GROUP BY c.categoryid, c.categoryname
ORDER BY c.categoryid ASC;
GO

-- Soal 7
SELECT o.orderid, o.orderdate,
    SUM(od.qty * od.unitprice) AS salesamount
FROM Sales.Orders AS o
    INNER JOIN Sales.OrderDetails AS od ON o.orderid = od.orderid
GROUP BY o.orderid, o.orderdate
ORDER BY salesamount DESC;
GO

-- Soal 8
SELECT o.orderid, o.orderdate,
    SUM(od.qty * od.unitprice) AS salesamount,
    COUNT(o.orderid) AS noofoderlines,
    AVG(od.qty * od.unitprice) AS avgsalesamountperorderline
FROM Sales.Orders AS o
    INNER JOIN Sales.OrderDetails AS od ON o.orderid = od.orderid
GROUP BY o.orderid, o.orderdate
ORDER BY salesamount DESC;
GO

-- Soal 9
SELECT FORMAT(o.orderdate, 'yyyyMM') AS yearmonthno,
    SUM(od.qty * od.unitprice) AS salesamountpermonth
FROM Sales.Orders AS o
    INNER JOIN Sales.OrderDetails AS od ON o.orderid = od.orderid
GROUP BY FORMAT(o.orderdate, 'yyyyMM')
ORDER BY yearmonthno;
GO

-- Soal 10
SELECT c.custid, c.contactname,
    SUM(s.qty * s.unitprice) AS totalsalesamount,
    MAX(s.qty * s.unitprice) AS maxsalesamountorderline,
    COUNT(*) AS numberofrows,
    COUNT(o.orderid) AS nmberofline
FROM Sales.Customers AS c
    LEFT OUTER JOIN Sales.Orders AS o ON o.custid = c.custid
    LEFT OUTER JOIN Sales.OrderDetails AS s ON o.orderid = s.orderid
GROUP BY c.custid, c.contactname
ORDER BY totalsalesamount;
GO

-- Soal 11
SELECT
    YEAR(orderdate) AS orderyear,
    COUNT(orderid) AS nooforders,
    COUNT(custid) AS noofcustomers
FROM Sales.Orders
GROUP BY YEAR(orderdate);
GO

-- Soal 12
SELECT
    YEAR(orderdate) AS orderyear,
    COUNT(orderid) AS nooforders,
    COUNT(DISTINCT custid) AS noofcustomers
FROM Sales.Orders
GROUP BY YEAR(orderdate);
GO

-- Soal 13
SELECT
    SUBSTRING(c.contactname,1,1) AS firstletter,
    COUNT(DISTINCT o.custid) AS noofcustomers,
    COUNT(o.orderid) AS nooforders
FROM Sales.Customers AS c LEFT OUTER JOIN Sales.Orders AS o ON c.custid = o.custid
GROUP BY SUBSTRING(contactname,1,1)
ORDER BY firstletter;

-- Soal 14
SELECT c.categoryid, c.categoryname,
    SUM(d.qty * d.unitprice) AS totalsalesmount,
    COUNT(DISTINCT o.orderid) AS nooforders,
    SUM(d.qty * d.unitprice) / COUNT(DISTINCT o.orderid) AS avgsalesamountperorder
FROM Sales.Orders AS o
    INNER JOIN Sales.OrderDetails AS d ON d.orderid=o.orderid
    INNER JOIN Production.Products AS p ON p.productid=d.productid
    INNER JOIN Production.Categories AS c ON c.categoryid=p.categoryid
WHERE YEAR(o.orderdate) = 2008
GROUP BY c.categoryid, c.categoryname
ORDER BY c.categoryid;
GO

-- Soal 15
SELECT TOP(5)
    o.custid,
    SUM(d.qty * d.unitprice) AS totalsalesamount
FROM Sales.Orders AS o
    INNER JOIN Sales.OrderDetails AS d ON o.orderid = d.orderid
GROUP BY o.custid
HAVING SUM(d.qty * d.unitprice) > 10000
ORDER BY totalsalesamount DESC;

-- Soal 16
SELECT o.orderid, o.empid,
    SUM(d.qty * d.unitprice) AS totalsalesamount
FROM Sales.Orders AS o
    INNER JOIN Sales.OrderDetails AS d ON o.orderid=d.orderid
GROUP BY o.orderid, o.empid, o.orderdate
HAVING YEAR(o.orderdate) = 2008;

-- Soal 17
SELECT o.orderid, o.empid,
    SUM(d.qty * d.unitprice) AS totalsalesamount
FROM Sales.Orders AS o
    INNER JOIN Sales.OrderDetails AS d ON o.orderid = d.orderid
GROUP BY o.orderid, o.empid, o.orderdate
HAVING YEAR(o.orderdate) = 2008
    AND SUM(d.qty*d.unitprice) > 10000;

-- Soal 18
SELECT o.orderid, o.empid,
    SUM(d.qty * d.unitprice) AS totalsalesamount
FROM Sales.Orders AS o
    INNER JOIN Sales.OrderDetails AS d ON o.orderid=d.orderid
GROUP BY o.orderid, o.empid, o.orderdate
HAVING YEAR(o.orderdate) = 2008
    AND SUM(d.qty*d.unitprice) > 10000
    AND o.empid = 3;
GO

-- Soal 19
SELECT o.custid,
    MAX(o.orderdate) AS lastorderdate,
    SUM(d.qty * unitprice) AS totalsalesamount
FROM Sales.Orders AS o
    INNER JOIN Sales.OrderDetails AS d ON o.orderid=d.orderid
GROUP BY o.custid
HAVING COUNT(distinct o.orderid) > 25
ORDER BY totalsalesamount DESC;
GO

-- Soal 20
SELECT MAX(o.orderdate) AS lastorderdate
FROM Sales.Orders AS o;
GO

-- Soal 21
SELECT o.orderid, o.orderdate, o.empid, o.custid
FROM Sales.Orders AS o
WHERE o.orderdate = (SELECT MAX(o.orderdate) AS lastorderdate
FROM Sales.Orders AS o );
GO

-- Soal 22 Master
SELECT
    orderid, orderdate, empid, custid
FROM Sales.Orders
WHERE
custid =
(
       SELECT custid
FROM Sales.Customers
WHERE contactname LIKE N'I%'
);
GO

-- Soal 22 Salah
SELECT
    orderid, orderdate, empid, custid
FROM Sales.Orders
WHERE
custid =
(
       SELECT custid
FROM Sales.Customers
WHERE contactname LIKE N'B%'
);
GO

-- Soal 24
SELECT
    orderid, orderdate, empid, custid
FROM Sales.Orders
WHERE
custid IN ( SELECT custid
FROM Sales.Customers
WHERE contactname LIKE N'B%');
GO

-- Soal 25
SELECT o.orderid,
    SUM(d.qty * d.unitprice) AS totalsalesamount,
    SUM(d.qty * d.unitprice) / (SELECT SUM(d.qty * d.unitprice)
    FROM Sales.Orders AS o
        INNER JOIN Sales.OrderDetails AS d ON d.orderid = o.orderid
    WHERE o.orderdate >= '20080501' AND orderdate < '20080601') * 100 AS salespctoftotal
FROM Sales.Orders AS o
    INNER JOIN Sales.OrderDetails AS d
    ON d.orderid = o.orderid
WHERE o.orderdate >= '20080501' AND orderdate<'20080601'
GROUP BY o.orderid;

-- Soal 26
SELECT p.productid, p.productname
FROM Production.Products AS p
WHERE p.productid IN (SELECT od.productid
FROM Sales.OrderDetails AS od
WHERE od.qty > 100);

-- Soal 27
SELECT custid, contactname
FROM Sales.Customers
WHERE custid NOT IN(SELECT custid
FROM Sales.Orders);

-- Soal 28
INSERT INTO Sales.Orders
    (custid, empid, orderdate, requireddate, shippeddate, shipperid, freight,
    shipname, shipaddress, shipcity, shipregion, shippostalcode, shipcountry)
VALUES
    (NULL, 1, '20111231', '20111231', '20111231', 1, 0,
        'ShipOne', 'ShipAddress', 'ShipCity', 'RA', '1000', 'USA');
GO

-- Soal 29
SELECT custid, contactname
FROM Sales.Customers
WHERE custid NOT IN(SELECT custid
FROM Sales.Orders
WHERE custid IS NOT NULL);

-- Soal 30
SELECT custid, contactname,
    (SELECT MAX(orderdate)
    FROM Sales.Orders) AS lastorderdate
FROM Sales.Customers;

-- Soal 31
SELECT c.custid, c.contactname
FROM Sales.Customers AS c
WHERE NOT EXISTS (SELECT *
FROM Sales.Orders AS o
WHERE o.custid=c.custid);

-- Soal 32
SELECT c.custid, c.contactname
FROM Sales.Customers AS c
WHERE EXISTS (SELECT *
FROM Sales.Orders AS o
    INNER JOIN Sales.OrderDetails AS d ON d.orderid=o.orderid
WHERE o.custid=c.custid
    AND d.unitprice>100 AND o.orderdate>='20080401');

-- Soal 33
SELECT
    YEAR(o.orderdate) AS orderyear,
    SUM(d.qty * d.unitprice) AS totalsalesamount,
    (SELECT SUM(de.qty * de.unitprice)
    FROM Sales.Orders AS ord
        INNER JOIN Sales.OrderDetails AS de ON ord.orderid = de.orderid
    WHERE YEAR(ord.orderdate) <= YEAR(o.orderdate) ) AS runsale
FROM Sales.Orders AS o
    INNER JOIN Sales.OrderDetails AS d ON o.orderid = d.orderid
GROUP BY YEAR(o.orderdate)
ORDER BY orderyear;
GO