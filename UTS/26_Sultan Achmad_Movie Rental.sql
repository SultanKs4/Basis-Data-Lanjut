USE MovieRental;

-- Soal 1

SELECT C.First_Name AS [First Name], C.Last_Name AS [Last Name], C.Address AS Alamat
FROM Sales.Customer AS C;

-- Soal 2

SELECT *
FROM Mv.Film AS a, Mv.Film AS b
WHERE a.Title = b.Title

-- Soal 3

SELECT s.ID, s.First_Name AS [First Name], s.Username
FROM HR.Staff AS s
ORDER BY [First Name] DESC;

-- Soal 4

SELECT s.ID, s.First_Name AS [First Name], s.Username
FROM HR.Staff AS s
ORDER BY [First Name] DESC OFFSET 0 ROWS FETCH FIRST 5 ROWS ONLY;

-- Soal 5

SELECT CONVERT([varchar], c.Create_Date) AS date, DATENAME(MONTH, c.Create_Date) AS monthname
FROM Sales.Customer AS c

-- Soal 6

SELECT s.First_Name + (' - ') + s.Last_Name + (' - ') + s.Username + (' - ') + s.Email AS concatdata,
    LEN(s.First_Name + (' - ') + s.Last_Name + (' - ') + s.Username + (' - ') + s.Email) - LEN(REPLACE(s.First_Name + (' - ') + s.Last_Name + (' - ') + s.Username + (' - ') + s.Email, 'A', '')) AS numberofa
FROM HR.Staff AS s

-- Soal 7
SELECT TOP(1)
    r.ID, r.CustomerID, r.Rental_Date, r.Return_Date, r.Amount
FROM Sales.Rental AS r
WHERE  r.CustomerID IN (SELECT c.ID
FROM Sales.Customer AS c)
ORDER BY Rental_Date DESC

-- Soal 8

CREATE VIEW Sales.Soal8UTS
AS
    SELECT SUM(r.Amount / i.Stock) AS Sum_Amount_Stock, AVG(i.Stock) AS Avg_Stock, COUNT(r.Amount) AS Count_Amount, MIN(r.Amount) AS Min_Amount, MAX(r.Amount) AS Max_Amount
    FROM Sales.Rental AS r
        INNER JOIN Sales.Inventory AS i ON r.InventoryID = i.ID

SELECT *
FROM Sales.Soal8UTS

-- Soal 9

SELECT COUNT(r.Amount) AS Amount, r.Rental_Date
FROM Sales.Rental AS r
GROUP BY r.Rental_Date

-- Soal 10

SELECT COUNT(r.Amount) AS Amount, r.Rental_Date AS tanggal_mulai
FROM Sales.Rental AS r
WHERE r.Rental_Date >= '2019-05-01'
GROUP BY r.Rental_Date

SELECT COUNT(r.Amount) AS Amount, r.Rental_Date AS tanggal_mulai
FROM Sales.Rental AS r
GROUP BY r.Rental_Date
HAVING r.Rental_Date >= '2019-05-01'

-- Soal 11

SELECT p.TotalAbalAbal, p.Amount, p.Stock, p.Rental_Date
FROM (
	SELECT SUM(r.Amount * i.Stock) AS TotalAbalAbal, r.Amount, i.Stock, r.Rental_Date
    FROM Sales.Rental AS r INNER JOIN Sales.Inventory AS i ON r.InventoryID = i.ID
    WHERE YEAR(Rental_Date) >= 2019
    GROUP BY r.Amount, i.Stock, r.Rental_Date
) AS p

-- Soal 12

WITH
    UTS12_CTE
    AS
    (
        SELECT SUM(r.Amount * i.Stock) AS TotalAbalAbal, r.Amount, i.Stock, r.Rental_Date
        FROM Sales.Rental AS r INNER JOIN Sales.Inventory AS i ON r.InventoryID = i.ID
        WHERE YEAR(Rental_Date) >= 2019
        GROUP BY r.Amount, i.Stock, r.Rental_Date
    )

SELECT TotalAbalAbal, Amount, Rental_Date, Stock
FROM UTS12_CTE
WHERE MONTH(Rental_Date) = 10

-- Soal 13

    SELECT ID
    FROM Mv.MainActor
EXCEPT
    SELECT MainActorID
    FROM Mv.Film
    WHERE Release_Year = 2019

-- Soal 14

CREATE TRIGGER trgPrintDateAfterAdd ON Sales.Inventory
AFTER INSERT
AS
    PRINT 'TRIGGER trgPrintDateAfterAdd dipanggil';

    DECLARE @Filmid INT = (SELECT FilmID
FROM inserted);
    DECLARE @Stock INT = (SELECT Stock
FROM inserted);

    INSERT INTO Sales.Inventory
VALUES
    (@Filmid, @Stock);

    PRINT 'Data baru ditambahkan secara otomatis ke tabel Sales.Inventory pada : ' + CAST(GETDATE() AS VARCHAR);
GO

INSERT INTO Sales.Inventory
    (FilmID,Stock)
VALUES
    (5, 50)