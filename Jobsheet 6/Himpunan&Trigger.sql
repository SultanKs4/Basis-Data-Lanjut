-- Connect Database

USE [TSQL]
GO

-- Praktikum 1
SELECT productid, productname
FROM Production.Products
WHERE categoryid = 4;

SELECT P.productid, P.productname
FROM Production.Products AS P
    INNER JOIN Sales.OrderDetails AS OD ON P.productid = OD.productid
GROUP BY P.productid, P.productname
HAVING SUM(OD.qty * OD.unitprice) > 50000;

-- Soal 1
    SELECT productid, productname
    FROM Production.Products
    WHERE categoryid = 4
UNION
    SELECT P.productid, P.productname
    FROM Production.Products AS P
        INNER JOIN Sales.OrderDetails AS OD ON P.productid = OD.productid
    GROUP BY P.productid, P.productname
    HAVING SUM(OD.qty*OD.unitprice) > 50000;

-- Soal 2
    SELECT productid, productname
    FROM Production.Products
    WHERE categoryid = 4
UNION ALL
    SELECT P.productid, P.productname
    FROM Production.Products AS P
        INNER JOIN Sales.OrderDetails AS OD ON P.productid = OD.productid
    GROUP BY P.productid, P.productname
    HAVING SUM(OD.qty*OD.unitprice) > 50000;

-- Soal 3
    SELECT c.custid, c.contactname, c.orderdate, c.val
    FROM (
    SELECT TOP(10)
            c.custid, c.contactname, ov.orderdate, ov.val
        FROM Sales.Customers AS c
            INNER JOIN Sales.OrderValues AS ov ON c.custid = ov.custid
        WHERE ov.orderdate >= '20080101' AND ov.orderdate < '20080201'
        ORDER BY ov.val DESC
) AS c
UNION
    SELECT c2.custid, c2.contactname, c2.orderdate, c2.val
    FROM(
    SELECT TOP(10)
            c.custid, c.contactname, ov.orderdate, ov.val
        FROM Sales.Customers AS c
            INNER JOIN Sales.OrderValues AS ov ON c.custid = ov.custid
        WHERE ov.orderdate >= '20080201' AND ov.orderdate < '20080301'
        ORDER BY ov.val DESC
) AS c2

-- Praktikum 2
SELECT p.productid, p.productname, o.orderid
FROM Production.Products AS p
CROSS APPLY 
(
	SELECT TOP(2)
        d.orderid
    FROM Sales.OrderDetails AS d
    WHERE d.productid = p.productid
    ORDER BY d.orderid DESC
) o
ORDER BY p.productid;


IF OBJECT_ID('dbo.fnGetTop3ProductsForCustomer') IS NOT NULL
	DROP FUNCTION dbo.fnGetTop3ProductsForCustomer;
GO
CREATE FUNCTION dbo.fnGetTop3ProductsForCustomer
(@custid AS INT) RETURNS TABLE
AS
RETURN
SELECT TOP(3)
    d.productid,
    p.productname,
    SUM(d.qty * d.unitprice) AS totalsalesamount
FROM Sales.Orders AS o
    INNER JOIN Sales.OrderDetails AS d ON d.orderid = o.orderid
    INNER JOIN Production.Products AS p ON p.productid = d.productid
WHERE custid = @custid
GROUP BY d.productid, p.productname;
GO

SELECT c.custid, c.contactname, p.productid, p.productname,
    p.totalsalesamount
FROM Sales.Customers AS c
CROSS APPLY dbo.fnGetTop3ProductsForCustomer (c.custid) AS p
ORDER BY c.custid;

-- Soal 5
SELECT c.custid, c.contactname, p.productid, p.productname,
    p.totalsalesamount
FROM Sales.Customers AS c
OUTER APPLY dbo.fnGetTop3ProductsForCustomer (c.custid) AS p
ORDER BY c.custid;

-- Soal 6
SELECT c.custid, c.contactname, p.productid, p.productname,
    p.totalsalesamount
FROM Sales.Customers AS c
OUTER APPLY dbo.fnGetTop3ProductsForCustomer (c.custid) AS p
WHERE p.productid IS NULL
ORDER BY c.custid;

-- Drop function (follow jobsheet) execute line 74-76

-- Praktikum 3.1
SELECT o.custid
FROM Sales.Orders AS o
    INNER JOIN Sales.OrderDetails AS d ON d.orderid = o.orderid
GROUP BY o.custid
HAVING COUNT(DISTINCT d.productid) > 20;

-- Soal 7
    SELECT custid
    FROM Sales.Customers
    WHERE country = 'USA'
EXCEPT
    SELECT o.custid
    FROM Sales.Orders AS o
        INNER JOIN Sales.OrderDetails AS d ON d.orderid = o.orderid
    GROUP BY o.custid
    HAVING COUNT(DISTINCT d.productid) > 20;

-- Praktikum 3.3
SELECT o.custid
FROM Sales.Orders AS o
    INNER JOIN Sales.OrderDetails AS d ON d.orderid = o.orderid
GROUP BY o.custid
HAVING SUM(d.qty * d.unitprice) > 10000;

-- Soal 8
    SELECT custid
    FROM Sales.Customers
EXCEPT
    SELECT o.custid
    FROM Sales.Orders AS o
        INNER JOIN Sales.OrderDetails AS d ON d.orderid = o.orderid
    GROUP BY o.custid
    HAVING COUNT(DISTINCT d.productid) > 20
INTERSECT
    SELECT o.custid
    FROM Sales.Orders AS o
        INNER JOIN Sales.OrderDetails AS d ON d.orderid = o.orderid
    GROUP BY o.custid
    HAVING SUM(d.qty * d.unitprice) > 10000;

-- Soal 9 isian

-- Soal 10
    (
        SELECT custid
    FROM Sales.Customers
EXCEPT
    SELECT o.custid
    FROM Sales.Orders AS o
        INNER JOIN Sales.OrderDetails AS d ON d.orderid = o.orderid
    GROUP BY o.custid
    HAVING COUNT(DISTINCT d.productid) > 20)
INTERSECT
    SELECT o.custid
    FROM Sales.Orders AS o
        INNER JOIN Sales.OrderDetails AS d ON d.orderid = o.orderid
    GROUP BY o.custid
    HAVING SUM(d.qty * d.unitprice) > 10000;

-- Soal 11 Isian

-- Praktikum 4.1

IF OBJECT_ID('Sales.trgAutoAddOrderDetailsForOrder') IS NOT NULL
    DROP TRIGGER Sales.trgAutoAddOrderDetailsForOrder;
GO

CREATE TRIGGER trgAutoAddOrderDetailsForOrder ON Sales.Orders
AFTER INSERT
AS
    PRINT 'TRIGGER trgAutoAddOrderDetailsForOrder dipanggil';

    DECLARE @orderid INT = (SELECT orderid
FROM inserted);
    DECLARE @productid INT = 1;
    DECLARE @unitprice MONEY = 0;
    DECLARE @qty SMALLINT = 1;
    DECLARE @discount NUMERIC(4,3) = 0;

    INSERT INTO Sales.OrderDetails
VALUES
    (@orderid, @productid, @unitprice, @qty, @discount);

    PRINT 'Data kosong ditambahkan secara otomatis ke tabel Sales.OrderDetails';
GO

INSERT INTO Sales.Orders
    (custid, empid, orderdate, requireddate, shipperid, freight, shipname, shipaddress, shipcity, shipcountry)
VALUES
    (85, 5, GETDATE(), GETDATE(), 3, 100, 'Kapal Api', 'Jl. Soekarno-Hatta', 'Malang', 'Indonesia');

SELECT *
FROM Sales.OrderDetails
ORDER BY orderid DESC

-- Praktikum 4.2
IF OBJECT_ID('Production.trgAutoUpdateOrderDetailUnitPrice') IS NOT NULL
    DROP TRIGGER Production.trgAutoUpdateOrderDetailUnitPrice
GO

CREATE TRIGGER trgAutoUpdateOrderDetailUnitPrice ON Production.Products
AFTER UPDATE
AS
    PRINT 'Trigger trgAutoUpdateOrderDetailUnitPrice DIPANGGIL!'

    DECLARE @productid INT = (SELECT productid
FROM inserted);
    DECLARE @unitprice MONEY = COALESCE((SELECT unitprice FROM inserted), 0.0);

    UPDATE Sales.OrderDetails SET unitprice = @unitprice
    WHERE productid = @productid

    PRINT 'Harga di tabel Sales.OrderDetails secara otomatis disesuaikan..'
GO

UPDATE Production.Products SET unitprice = 100 WHERE productid = 11;

SELECT *
FROM Production.Products
WHERE productid = 11;
SELECT *
FROM Sales.OrderDetails
WHERE productid = 11;

-- Soal 12
IF OBJECT_ID('Sales.trgAutoProductDiscontinue') IS NOT NULL
	DROP TRIGGER Sales.trgAutoProductDiscontinue;
GO

CREATE TRIGGER trgAutoProductDiscontinue ON Sales.OrderDetails
AFTER DELETE
AS
	PRINT 'Trigger trgAutoProductDiscontinue DIPANGGIL!';
	DECLARE @productid INT = (SELECT top(1)
    productid
FROM deleted);

	UPDATE Production.Products SET discontinued = 1
	WHERE productid=@productid;

	PRINT 'Men-discontinue product dengan id: ' + CAST(@productid AS VARCHAR);


DELETE FROM Sales.OrderDetails WHERE productid = 10;
SELECT *
FROM Production.Products
WHERE productid = 10;

-- Praktikum 5.1
CREATE TABLE HR.EmployeesBackup
(
    empid INT NOT NULL IDENTITY,
    lastname NVARCHAR(20) NOT NULL,
    firstname NVARCHAR(10) NOT NULL,
    title NVARCHAR(30) NOT NULL,
    titleofcourtesy NVARCHAR(25) NOT NULL,
    birthdate DATETIME NOT NULL,
    hiredate DATETIME NOT NULL,
    address NVARCHAR(60) NOT NULL,
    city NVARCHAR(15) NOT NULL,
    region NVARCHAR(15) NULL,
    postalcode NVARCHAR(10) NULL,
    country NVARCHAR(15) NOT NULL,
    phone NVARCHAR(24) NOT NULL,
    mgrid INT NULL
);

INSERT INTO HR.EmployeesBackup
    (lastname, firstname, title, titleofcourtesy, birthdate, hiredate, [address], city,
    region, postalcode, country, phone, mgrid)
SELECT
    lastname, firstname, title, titleofcourtesy, birthdate, hiredate, [address], city,
    region, postalcode, country, phone, mgrid
FROM HR.Employees;

SELECT *
FROM HR.EmployeesBackup;


-- Praktikum 5.2
IF OBJECT_ID('HR.trgDivertInsertEmployeeToBackup') IS NOT NULL
	DROP TRIGGER HR.trgDivertInsertEmployeeToBackup
GO

CREATE TRIGGER trgDivertInsertEmployeeToBackup ON HR.Employees
INSTEAD OF INSERT
AS
	PRINT 'TRIGGER trgDivertInsertEmployeeToBackup DIPANGGIL!';

	INSERT INTO HR.EmployeesBackup
    (lastname, firstname, title, titleofcourtesy, birthdate, hiredate, [address], city,
    region, postalcode, country, phone, mgrid)
SELECT
    lastname, firstname, title, titleofcourtesy, birthdate, hiredate, [address], city,
    region, postalcode, country, phone, mgrid
FROM inserted;

	PRINT 'Employee baru disimpan di table HR.BEmployesBackup';
GO

INSERT INTO HR.Employees
VALUES
    ('Santoso', 'Adi', 'Staff', 'Mr. ', '19830101', '20170101',
        'Jl Soekarno-Hatta', 'Malang', 'HJawa Timur', '65150', 'Indonesia',
        '(085) 123-456', 1)

SELECT *
FROM HR.Employees;

-- Soal 13

IF OBJECT_ID('HR.trgDivertUpdateEmployeeToBackup') IS NOT NULL
	DROP TRIGGER HR.trgDivertUpdateEmployeeToBackup
GO

CREATE TRIGGER trgDivertUpdateEmployeeToBackup ON HR.Employees
INSTEAD OF UPDATE
AS
	PRINT 'TRIGGER trgDivertUpdateEmployeeToBackup DIPANGGIL!';
	DECLARE @firstname VARCHAR(15) = (SELECT firstname
FROM inserted);
	DECLARE @lastname VARCHAR(15) = (SELECT lastname
FROM inserted);
	DECLARE @title VARCHAR(5) = (SELECT title
FROM inserted);
	DECLARE @titleofcourtesy VARCHAR(5) = (SELECT titleofcourtesy
FROM inserted);
	DECLARE @birthdate DATETIME = (SELECT birthdate
FROM inserted);
	DECLARE @hiredate DATETIME = (SELECT hiredate
FROM inserted);
	DECLARE @address VARCHAR(100) = (SELECT [address]
FROM inserted);
	DECLARE @city VARCHAR(15) = (SELECT city
FROM inserted);
	DECLARE @region VARCHAR(7) = (SELECT region
FROM inserted);
	DECLARE @postalcode VARCHAR(6) = (SELECT postalcode
FROM inserted);
	DECLARE @country VARCHAR(10) = (SELECT country
FROM inserted);
	DECLARE @phone VARCHAR(15) = (SELECT phone
FROM inserted);
	DECLARE @mgrid VARCHAR(15) = (SELECT mgrid
FROM inserted);
	DECLARE @empid INT = (SELECT empid
FROM inserted);

	UPDATE HR.EmployeesBackup SET firstname = @firstname, lastname = @lastname, title=@title,
	titleofcourtesy = @titleofcourtesy, birthdate = @birthdate, hiredate = @hiredate,
	[address] = @address, city = @city, region = @region, postalcode = @postalcode, 
	country = @country, phone = @phone, mgrid = @mgrid WHERE empid = @empid;
	
	PRINT 'Karyawan dengan empid: ' + CAST(@empid AS VARCHAR) + ' yang ada di 
	HR.EmployeesBackup yang diupdate.';

UPDATE HR.Employees SET firstname ='DEPAN', lastname = 'BELAKANG'
WHERE firstname = 'Adi';

SELECT *
FROM HR.EmployeesBackup;

SELECT * FROM Hr.Employees

-- Soal 14

IF OBJECT_ID('HR.trgDivertDeleteEmployeeToBackup') IS NOT NULL
	DROP TRIGGER HR.trgDivertDeleteEmployeeToBackup
GO

CREATE TRIGGER trgDivertDeleteEmployeeToBackup ON HR.Employees
INSTEAD OF DELETE
AS
	PRINT 'TRIGGER trgDivertDeleteEmployeeToBackup DIPANGGIL!';
	DECLARE @empid INT = (SELECT empid
FROM deleted);
	DECLARE @firstname VARCHAR(15) = (SELECT firstname
FROM deleted);
	DECLARE @lastname VARCHAR(15) = (SELECT lastname
FROM deleted);

	DELETE FROM HR.EmployeesBackup WHERE empid=@empid;

	PRINT 'Karyawan dengan nama ' + @firstname + ' ' + @lastname + ' dihapus 
	di HR.EmployeesBackup saja. Di tabel aslinya tetap.';

DELETE FROM HR.Employees WHERE firstname = 'Maria';

SELECT *
FROM HR.EmployeesBackup;

-- Reset seed
dbcc checkident('HR.Employees',reseed,9);