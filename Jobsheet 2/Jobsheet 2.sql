-- Soal 1
SELECT p.productname, c.categoryname FROM Production.Products AS p INNER JOIN Production.Categories AS c ON p.categoryid = c.categoryid

-- Soal 4
SELECT Customers.custid, Customers.contactname, Orders.orderid
FROM Sales.Customers  
INNER JOIN Sales.Orders ON Customers.custid = Orders.custid

-- Soal 6
-- SELECT Customers.custid, Customers.contactname, Orders.orderid
-- FROM Sales.Customers AS c
-- INNER JOIN Sales.Orders AS o ON Customers.custid = Orders.custid

-- Soal 8
SELECT c.custid, c.contactname, o.orderid
FROM Sales.Customers AS c
INNER JOIN Sales.Orders AS o ON c.custid = o.custid

-- Soal 9
SELECT c.custid, c.contactname, o.orderid, od.productid, od.qty, od.unitprice
FROM Sales.Customers AS c
INNER JOIN Sales.Orders AS o ON c.custid = o.custid 
INNER JOIN Sales.OrderDetails as od ON od.orderid = o.orderid

-- Soal 11
SELECT e.empid, e.lastname, e.firstname, e.title, e.mgrid FROM HR.Employees AS e

-- Soal 13
SELECT e.empid, e.lastname, e.firstname, e.title, e.mgrid,
mgr.lastname AS mgrlastname, mgr.firstname AS mgrfirstname FROM HR.Employees AS e, HR.Employees AS mgr WHERE e.mgrid = mgr.empid

-- Soal 16
SELECT c.custid, c.contactname, o.orderid FROM Sales.Customers AS c LEFT OUTER JOIN Sales.Orders AS o ON c.custid = o.custid

-- Soal 18
SELECT c.custid, c.contactname, o.orderid FROM Sales.Customers AS c LEFT OUTER JOIN Sales.Orders AS o ON c.custid = o.custid 
WHERE o.orderid IS NULL

-- Task 5
SET NOCOUNT ON;

IF OBJECT_ID('HR.Calendar') IS NOT NULL 
	DROP TABLE HR.Calendar;

CREATE TABLE HR.Calendar (
	calendardate DATE CONSTRAINT PK_Calendar PRIMARY KEY
);

DECLARE 
	@startdate DATE = DATEFROMPARTS(YEAR(SYSDATETIME()), 1, 1),
	@enddate DATE = DATEFROMPARTS(YEAR(SYSDATETIME()), 12, 31);

WHILE @startdate <= @enddate
BEGIN
	INSERT INTO HR.Calendar (calendardate)
	VALUES (@startdate);

	SET @startdate = DATEADD(DAY, 1, @startdate);
END;

SET NOCOUNT OFF;

GO
-- observe the HR.Calendar table
SELECT 
	calendardate
FROM HR.Calendar;

-- Soal 20
SELECT emp.empid, emp.firstname, emp.lastname, cal.calendardate FROM HR.Employees AS emp CROSS JOIN HR.Calendar AS cal

-- Soal 23
SELECT custid, companyname, contactname, address, city, country, phone
FROM Sales.Customers WHERE country = N'Brazil'

-- Soal 24
SELECT custid, companyname, contactname, address, city, country, phone
FROM Sales.Customers WHERE country IN(N'Brazil', N'UK', N'USA')

-- Soal 26
SELECT custid, companyname, contactname, address, city, country, phone
FROM Sales.Customers WHERE contactname LIKE 'A%'

-- Soal 28 Master
SELECT c.custid, c.companyname, o.orderid
FROM Sales.Customers AS c
LEFT OUTER JOIN Sales.Orders AS o ON c.custid = o.custid AND c.city = 'Paris'

-- Soal 28 Modifikasi
SELECT c.custid, c.companyname, o.orderid
FROM Sales.Customers AS c
LEFT OUTER JOIN Sales.Orders AS o ON c.custid = o.custid WHERE c.city = 'Paris'

-- Soal 30
SELECT cust.custid AS ID, cust.companyname AS [Company Name] FROM Sales.Customers AS cust WHERE cust.custid 
NOT IN(SELECT o.custid FROM Sales.Orders AS o)

-- Soal 32
SELECT cust.custid AS ID, cust.contactname AS Name, o.orderid AS [Order ID], o.orderdate AS [Order Date]
FROM Sales.Customers AS cust
INNER JOIN Sales.Orders AS o ON cust.custid = o.custid
WHERE o.orderdate > '2008-04-01' OR o.orderdate = '2008-04-01' ORDER BY cust.custid ASC, o.orderdate DESC;

-- Soal 34 Master
-- SELECT e.empid, e.lastname, e.firstname, e.title, e.mgrid, m.lastname AS mgrlastname, m.firstname AS mgrfirstname
-- FROM HR.Employees AS e INNER JOIN HR.Employees AS m ON e.mgrid = m.empid WHERE mgrlastname = N'Buck'

-- Soal 35
SELECT e.empid, e.lastname, e.firstname, e.title, e.mgrid, m.lastname AS mgrlastname, m.firstname AS mgrfirstname
FROM HR.Employees AS e INNER JOIN HR.Employees AS m ON e.mgrid = m.empid WHERE m.lastname = N'Buck'

-- Soal 36
SELECT e.empid, e.lastname, e.firstname, e.title, e.mgrid, m.lastname AS mgrlastname, m.firstname AS mgrfirstname
FROM HR.Employees AS e INNER JOIN HR.Employees AS m ON e.mgrid = m.empid ORDER BY m.firstname

-- Soal 36
SELECT e.empid, e.lastname, e.firstname, e.title, e.mgrid, m.lastname AS mgrlastname, m.firstname AS mgrfirstname
FROM HR.Employees AS e INNER JOIN HR.Employees AS m ON e.mgrid = m.empid ORDER BY mgrfirstname

-- Soal 38
SELECT TOP(20) orderid, orderdate FROM Sales.Orders ORDER BY orderdate DESC

-- Soal 39
SELECT orderid, orderdate FROM Sales.Orders ORDER BY orderdate DESC OFFSET 0 ROW FETCH FIRST 20 ROWS ONLY

-- Soal 40
SELECT prod.productname AS [Product Name], prod.unitprice AS [Unit Price] FROM Production.Products AS prod
ORDER BY [Unit Price] DESC

-- Soal 41
SELECT TOP(10) PERCENT prod.productname AS [Product Name], prod.unitprice AS [Unit Price] FROM Production.Products AS prod
ORDER BY [Unit Price] DESC

-- Soal 43
SELECT ord.custid, ord.orderid, ord.orderdate FROM Sales.Orders AS ord ORDER BY orderdate,
orderid OFFSET 0 ROWS FETCH FIRST 20 ROWS ONLY

-- Soal 44
SELECT ord.custid, ord.orderid, ord.orderdate FROM Sales.Orders AS ord ORDER BY orderdate,
orderid OFFSET 20 ROWS FETCH NEXT 20 ROWS ONLY
