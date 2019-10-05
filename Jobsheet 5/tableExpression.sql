-- Soal 1
SELECT productid, productname, supplierid, unitprice, discontinued
FROM Production.Products
WHERE categoryid = 1;
GO

-- Soal 2
CREATE VIEW Production.ProductsBeverages
AS
	SELECT productid, productname, supplierid, unitprice, discontinued
	FROM Production.Products
	WHERE categoryid = 1;
GO

-- Soal 3
SELECT productid, productname
FROM Production.ProductsBeverages
WHERE supplierid = 1;
GO

-- Soal 4
ALTER VIEW Production.ProductsBeverages
AS
	SELECT
		productid, productname, supplierid, unitprice, discontinued
	FROM Production.Products
	WHERE categoryid = 1
	ORDER BY productname;

-- ALTER VIEW Production.ProductsBeverages AS
SELECT TOP(100) PERCENT
	productid, productname, supplierid, unitprice, discontinued
FROM Production.Products
WHERE categoryid = 1
ORDER BY productname;

-- Soal 6
ALTER VIEW Production.ProductsBeverages
AS
	SELECT
		productid, productname, supplierid, unitprice, discontinued,
		CASE WHEN unitprice > 100.	THEN N'high' ELSE N'normal' END
	FROM Production.Products
	WHERE categoryid = 1;

-- Soal 7
ALTER VIEW Production.ProductsBeverages
AS
	SELECT
		productid, productname, supplierid, unitprice, discontinued,
		CASE WHEN unitprice > 100. THEN N'high' ELSE N'normal' END AS pricetype
	FROM Production.Products
	WHERE categoryid = 1;

-- Soal 8
SELECT p.productid, p.productname
FROM (
	SELECT productid, productname, supplierid, unitprice, discontinued,
		CASE WHEN unitprice > 100. THEN N'high' ELSE N'normal' END AS pricetype
	FROM Production.Products
	WHERE categoryid = 1
) AS p
WHERE pricetype = 'high'
ORDER BY productid

-- Soal 9
SELECT
	a.custid,
	SUM(a.total) AS totalsalesamount,
	AVG(a.total) AS avgsalesamount
FROM (
	SELECT
		so.custid, so.orderid, SUM(sod.qty*sod.unitprice) AS total
	FROM Sales.Orders AS so
		JOIN Sales.OrderDetails AS sod
		ON so.orderid = sod.orderid
	GROUP BY so.custid, so.orderid) AS a
GROUP BY a.custid

--soal no 10
SELECT
	a.orderyear,
	a.totalsalesamount AS curtotalsales,
	b.totalsalesamount AS prevtotalsales
FROM (
	SELECT
		YEAR(orderdate) AS orderyear,
		SUM (val) AS totalsalesamount
	FROM Sales.OrderValues
	GROUP BY YEAR(orderdate)) AS a
	LEFT JOIN (
	SELECT
		YEAR(orderdate) AS orderyear,
		SUM (val) AS totalsalesamount
	FROM Sales.OrderValues
	GROUP BY YEAR(orderdate)
	) AS b
	ON a.orderyear = b.orderyear + 1
ORDER BY a.orderyear

--soal no 11
WITH
	ProductBeverages
	AS
	(
		SELECT productid, productname, supplierid, unitprice, discontinued,
			CASE WHEN unitprice > 100.	THEN N'high' ELSE N'normal' END AS pricetype
		FROM Production.Products
		WHERE categoryid = 1
	)
SELECT
	productid, productname
FROM ProductBeverages
WHERE pricetype = 'high'

--soal no 12
WITH
	c2008 (custid, salesamt2008)
	AS
	(
		SELECT custid, SUM(val)
		FROM Sales.OrderValues
		WHERE YEAR(orderdate) = 2008
		GROUP BY custid
	)
SELECT
	sc.custid, sc.contactname, c.salesamt2008
FROM Sales.Customers AS sc
	LEFT JOIN c2008 AS c
	ON sc.custid = c.custid

--soal no 13
WITH
	c2008 (custid, salesamt2008)
	AS
	(
		SELECT custid, SUM(val)
		FROM Sales.OrderValues
		WHERE YEAR(orderdate) = 2008
		GROUP BY custid
	),
	c2007 (custid, salesamt2007)
	AS
	(
		SELECT custid, SUM(val)
		FROM Sales.OrderValues
		WHERE YEAR(orderdate) = 2007
		GROUP BY custid
	)

SELECT
	sc.custid, sc.contactname, c8.salesamt2008, c7.salesamt2007,
	coalesce((c8.salesamt2008 - c7.salesamt2007) / c7.salesamt2007 * 100., 0) AS percentgrowth
FROM Sales.Customers AS sc
	LEFT JOIN c2008 AS c8
	ON sc.custid = c8.custid
	LEFT JOIN c2007 AS c7
	ON sc.custid = c7.custid
ORDER BY percentgrowth DESC

--soal no 14
SELECT
	custid, SUM(val) AS totalsalesamount
FROM Sales.OrderValues
WHERE YEAR(orderdate) = 2007
GROUP BY custid

DROP FUNCTION

--soal no 15
CREATE FUNCTION dbo.fnGetSalesByCustomer
(@orderyear AS INT) RETURNS TABLE
AS 
RETURN
SELECT
	custid, SUM(val) AS totalsalesamount
FROM Sales.OrderValues
WHERE YEAR(orderdate) = 2007
GROUP BY custid

--soal no 16
CREATE FUNCTION dbo.fnGetSalesByCustomer
(@orderyear AS INT) RETURNS TABLE
AS 
RETURN
SELECT
	custid, SUM(val) AS totalsalesamount
FROM Sales.OrderValues
WHERE YEAR(orderdate) = @orderyear
GROUP BY custid

--soal no 17
SELECT custid, totalsalesamount
FROM dbo.fnGetSalesByCustomer(2007)

--soal no 18
SELECT top(3)
	sod.productid,
	MAX(p.productname) AS productname,
	SUM(sod.qty * sod.unitprice) AS totalsalesamount
FROM Sales.Orders AS so
	JOIN Sales.OrderDetails AS sod
	ON so.orderid = sod.orderid
	JOIN Production.Products AS p
	ON p.productid = sod.productid
WHERE so.custid = 1
GROUP BY sod.productid
ORDER BY totalsalesamount DESC


--soal no 19
CREATE FUNCTION dbo.fnGetTop3ProductsForCustomer
(@custid AS INT) RETURNS TABLE
AS
RETURN
SELECT top(3)
	sod.productid,
	MAX(p.productname) AS productname,
	SUM(sod.qty * sod.unitprice) AS totalsalesamount
FROM Sales.Orders AS so
	JOIN Sales.OrderDetails AS sod
	ON so.orderid = sod.orderid
	JOIN Production.Products AS p
	ON p.productid = sod.productid
WHERE so.custid = @custid
GROUP BY sod.productid
ORDER BY totalsalesamount DESC

--soal no 20
SELECT *
FROM dbo.fnGetTop3ProductsForCustomer(1)
