-- Kuis 1

-- Soal 32
SELECT cust.custid, cust.contactname, o.orderid, o.orderdate
FROM Sales.Customers AS cust
	INNER JOIN Sales.Orders AS o ON cust.custid = o.custid
WHERE o.orderdate >= '2008-04-01'
ORDER BY cust.custid ASC, o.orderdate DESC;
GO

-- Soal 37 lisan

-- Soal 40
SELECT productname, unitprice
FROM Production.Products
ORDER BY unitprice DESC;
GO