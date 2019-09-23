-- PPT
SELECT COUNT(*) FROM HR.Employees
GO

SELECT AVG(unitprice) AS avg_price, MIN(qty) AS min_qty, MAX(discount) AS max_discount FROM Sales.OrderDetails
GO

SELECT MIN(orderdate) AS earliest, MAX(orderdate) AS latest FROM Sales.Orders
GO

SELECT custid, COUNT(*) AS count_orders FROM Sales.Orders GROUP BY custid HAVING COUNT(*) >= 10
GO

SELECT orderid, productid, unitprice, qty FROM Sales.OrderDetails WHERE orderid = (SELECT MAX(orderid) AS lastorder FROM Sales.Orders)
GO