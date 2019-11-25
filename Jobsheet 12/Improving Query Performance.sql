--Soal No 1--
IF OBJECT_ID('Sales.TempOrders') IS NOT NULL 
DROP TABLE Sales.TempOrders;
SELECT
	orderid, custid, empid,
	orderdate, requireddate, shippeddate,
	shipperid, freight, shipname,
	shipaddress, shipcity, shipregion,
	shippostalcode, shipcountry
INTO 
	Sales.TempOrders
FROM Sales.Orders as o 
	CROSS JOIN dbo.Nums as n
WHERE n.n <= 120;

--Soal No 2--
SELECT orderid, custid, orderdate
FROM Sales.TempOrders;

--Soal No 6--
SELECT TOP(1)
	orderid, custid, orderdate
FROM Sales.TempOrders;

--Soal No 8--
SELECT orderid, custid, orderdate
FROM Sales.TempOrders;

SELECT TOP(1)
	orderid, custid, orderdate
FROM Sales.TempOrders;

CREATE CLUSTERED INDEX CX_Sales_TempOrders_orderdate ON Sales.TempOrders(orderdate ASC);
--Soal No 9--
SELECT orderid, custid, orderdate
FROM Sales.TempOrders
WHERE YEAR(orderdate) = 2017 AND MONTH(orderdate) = 6;

--Soal No 10--
SET STATISTICS IO ON
GO
SELECT orderid, custid, orderdate
FROM Sales.TempOrders
WHERE YEAR(orderdate) = 2017 AND MONTH(orderdate) = 6;

--Soal No 11--
SELECT orderid, custid, orderdate
FROM Sales.TempOrders
WHERE orderdate >= '20170601' AND orderdate < '20170701';

--Soal No 12--
SELECT orderid, custid, orderdate
FROM Sales.TempOrders
WHERE YEAR(orderdate) = 2017 AND MONTH(orderdate) = 6;

SELECT orderid, custid, orderdate
FROM Sales.TempOrders
WHERE orderdate >= '20170601' AND orderdate < '20170701';

--Soal No 14--
SET STATISTICS IO OFF
GO
