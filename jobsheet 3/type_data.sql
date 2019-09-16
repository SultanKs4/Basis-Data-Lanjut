-- Connect Database
USE [TSQL]
GO

-- Soal 1
SELECT GETDATE() AS currentdatetime,
    CONVERT([time], GETDATE()) AS currentdate,
    YEAR(GETDATE()) AS currentyear,
    MONTH(GETDATE()) AS currentmonth,
    DAY(SYSDATETIME()) AS currentday,
    DATEPART(WEEK, GETDATE()) AS currentweeknumber,
    DATENAME(MONTH, GETDATE()) AS currentmonthname
GO

-- Soal 2 (Bisa saja karena currentdatetime adalah nama alias sehingga bebas digunakan dimana saja)
SELECT GETDATE() AS currentdate,
    CONVERT([time], GETDATE()) AS currentdatetime,
    YEAR(GETDATE()) AS currentyear,
    MONTH(GETDATE()) AS currentmonth,
    DAY(GETDATE()) AS currentday,
    DATEPART(WEEK, GETDATE()) AS currentweeknumber,
    DATENAME(MONTH, GETDATE()) AS currentmonthname
GO

-- Soal 3
DECLARE @date DATETIME
SET @date = '1945-08-17 10:00:00'

SELECT CAST(@date as [date]) AS Somedate
GO

SELECT CONVERT([date], @date) AS Somedate
GO

SELECT FORMAT(@date, 'yyyy-MM-dd') as Somedate
GO

-- Soal 4
DECLARE @date DATETIME
SET @date = '1945-08-17 10:00:00'
DECLARE @date2 DATETIME
SET @date2 = '2018-10-1 10:00:00'
SELECT DATEADD(MONTH, 3, GETDATE()) AS threemonths,
    DATEDIFF(DAY, GETDATE(), DATEADD(MONTH, 3 , GETDATE())) AS diffsdays,
    DATEDIFF(WEEK, @date, @date2) AS diffsweek,
    DATEADD(DAY, -DAY(GETDATE() - 1), GETDATE()) AS firstday
GO

-- Soal 5 
CREATE TABLE Sales.Somedates
(
    isitdate varchar(9)
);
GO

INSERT INTO Sales.Somedates
    (isitdate)
VALUES
    ('20110101'),
    ('20110102'),
    ('20110103X'),
    ('20110104'),
    ('20110105'),
    ('20110106'),
    ('20110107Y'),
    ('20110108');
GO

SELECT sd.isitdate, IIF(ISDATE(sd.isitdate) = 1, CONVERT([date], sd.isitdate), NULL) AS converteddate
FROM Sales.Somedates AS sd
GO

-- Soal 6 (fungsi sysdatetime lebih presisi dibanding current_timestamp)
SELECT SYSDATETIME() AS SDT, CURRENT_TIMESTAMP AS TIMESTAMP
GO

-- Soal 8
SELECT DISTINCT o.custid
FROM Sales.Orders AS o
WHERE YEAR(o.orderdate) = 2008 AND MONTH(o.orderdate) = 2
GO

-- Soal 9
SELECT SYSDATETIME() AS [Tanggal Waktu Saat Ini],
    DATEADD(DAY, 1, EOMONTH(GETDATE(), -1)) AS [Tanggal Awal Bulan ini],
    EOMONTH(GETDATE()) AS [Tanggal Terakhir Bulan Ini]
GO

-- Soal 10
SELECT o.orderid, o.custid, o.orderdate
FROM Sales.Orders AS o
WHERE DATEDIFF(DAY, o.orderdate, EOMONTH(o.orderdate)) < 5
GO

-- Soal 11
SELECT DISTINCT od.productid
FROM Sales.Orders AS o INNER JOIN Sales.OrderDetails AS od ON o.orderid = od.orderid
WHERE DATEPART(WEEK, o.orderdate) <= 10 AND YEAR(o.orderdate) = 2007
GO

-- Soal 12
SELECT c.contactname + (' (City: ') + c.city + (')') AS contactwithcity
FROM Sales.Customers AS c
GO

-- Soal 13
SELECT c.contactname + (' (City: ') + c.city + (', region: ') + COALESCE(c.region, '') + (')') AS contactwithcity
FROM Sales.Customers AS c
GO

-- Soal 14
SELECT c.contactname, c.contacttitle
FROM Sales.Customers AS c
WHERE contactname LIKE '[A-G]%'
GO

-- Soal 15
SELECT REPLACE(c.contactname, ',', ''), SUBSTRING(c.contactname, 0, CHARINDEX(',', c.contactname)) AS lastname
FROM Sales.Customers AS c
GO

-- Soal 16
SELECT REPLACE(c.contactname, ',', ''), SUBSTRING(c.contactname, CHARINDEX(',', c.contactname) + 2, LEN(c.contactname))
FROM Sales.Customers AS c
GO

-- Soal 17
SELECT c.custid, 'C' + RIGHT(REPLICATE('0', 5) + CAST(custid AS varchar(5)), 5)
FROM Sales.Customers AS c
GO

-- Soal 18
SELECT c.contactname, LEN(c.contactname) - LEN(REPLACE(c.contactname, 'A', '')) AS numberofa
FROM Sales.Customers AS c
GO