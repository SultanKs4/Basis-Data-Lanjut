CREATE VIEW Sales.CategoryQtyYear
AS
    SELECT c.categoryname AS Category,
        od.qty AS Qty,
        YEAR(o.orderdate) AS Orderyear
    FROM
        Production.Categories AS c
        INNER JOIN Production.Products AS p ON c.categoryid = p.categoryid
        INNER JOIN Sales.OrderDetails AS od ON p.productid = od.productid
        INNER JOIN Sales.Orders AS o ON od.orderid = o.orderid;
GO

SELECT Category, [2006], [2007], [2008]
FROM (
SELECT Category, Qty, Orderyear
    FROM Sales.CategoryQtyYear) AS D
PIVOT(SUM(Qty) FOR orderyear IN ([2006],[2007],[2008])) AS pvt
ORDER BY Category;

SELECT *
FROM Sales.CategoryQtyYear
ORDER BY Category

