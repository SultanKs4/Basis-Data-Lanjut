-- Connect Database
USE [TSQL]
GO

-- SOAL 1 BEGIN
-- BAGIAN 1 LANGKAH 1
SELECT * FROM Sales.Customers
GO

-- BAGIAN 1 LANGKAH 2
SELECT custid, companyname, contactname, contacttitle, address, city, region, postalcode, country, phone, fax FROM Sales.Customers
GO

-- SOAL 1 END

-- BAGIAN 2 LANGKAH 1
SELECT contactname, address, postalcode, city, country FROM Sales.Customers
GO

-- SOAL 2 & 3 BEGIN
-- BAGIAN 3 LANGKAH 3 (Soal 2)
SELECT country FROM Sales.Customers
GO

-- BAGIAN 3 LANGKAH 4 (Soal 3)
SELECT DISTINCT country FROM Sales.Customers
GO

-- SOAL 2 & 3 END

-- SOAL 4 BEGIN
-- BAGIAN 4 LANGKAH 1
SELECT c.contactname, c.contacttitle FROM Sales.Customers AS c
GO

-- BAGIAN 4 LANGKAH 3
SELECT c.contactname AS Name, c.contacttitle AS Title, c.companyname AS [Company Name] FROM Sales.Customers AS c
GO

-- SOAL 4 END

-- SOAL 5, 6, 7, 8 BEGIN
-- BAGIAN 5 LANGKAH 1
SELECT p.categoryid, p.productname FROM Production.Products AS p
GO

-- BAGIAN 5 LANGKAH 3 (Soal 5)
SELECT p.categoryid, p.productname, 
    CASE
        WHEN p.categoryid = 1 THEN 'Bevarages'
        WHEN p.categoryid = 2 THEN 'Condiments'
        WHEN p.categoryid = 3 THEN 'Confections'
        WHEN p.categoryid = 4 THEN 'Dairy Products'
        WHEN p.categoryid = 5 THEN 'Grainy/Cereals'
        WHEN p.categoryid = 6 THEN 'Meat/Poultry'
        WHEN p.categoryid = 7 THEN 'Produce'
        WHEN p.categoryid = 8 THEN 'Seafood'
        ELSE 'Other'
    END AS categoryname
FROM Production.Products AS p
GO

-- BAGIAN 5 LANGKAH 6 (Soal 6)
SELECT p.categoryid, p.productname, 
    CASE
        WHEN p.categoryid = 1 THEN 'Bevarages'
        WHEN p.categoryid = 2 THEN 'Condiments'
        WHEN p.categoryid = 3 THEN 'Confections'
        WHEN p.categoryid = 4 THEN 'Dairy Products'
        WHEN p.categoryid = 5 THEN 'Grainy/Cereals'
        WHEN p.categoryid = 6 THEN 'Meat/Poultry'
        WHEN p.categoryid = 7 THEN 'Produce'
        WHEN p.categoryid = 8 THEN 'Seafood'
        ELSE 'Other'
    END AS categoryname,
    CASE
        WHEN p.categoryid IN (1, 7, 8) THEN 'Campaign Products'
        ELSE 'Non-Campaign Products'
    END AS iscampaign
FROM Production.Products AS p
GO

-- BAGIAN 5 LANGKAH 8 (Soal 7)
SELECT p.categoryid AS ID_KATEGORI, p.productname AS NAMA_PRODUK, 
    CASE
        WHEN p.categoryid = 1 THEN 'Bevarages'
        WHEN p.categoryid = 2 THEN 'Condiments'
        WHEN p.categoryid = 3 THEN 'Confections'
        WHEN p.categoryid = 4 THEN 'Dairy Products'
        WHEN p.categoryid = 5 THEN 'Grainy/Cereals'
        WHEN p.categoryid = 6 THEN 'Meat/Poultry'
        WHEN p.categoryid = 7 THEN 'Produce'
        WHEN p.categoryid = 8 THEN 'Seafood'
        ELSE 'Other'
    END AS NAMA_KATEGORI,
    CASE
        WHEN p.categoryid IN (1, 7, 8) THEN 'Campaign Products'
        ELSE 'Non-Campaign Products'
    END AS STATUS
FROM Production.Products AS p WHERE p.categoryid = 8 ORDER BY NAMA_PRODUK ASC
GO

-- BAGIAN 5 LANGKAH 9 (Soal 8)
SELECT emp.firstname AS FIRST_NAME, emp.lastname AS LAST_NAME, emp.city AS CITY, emp.country AS COUNTRY 
FROM HR.Employees AS emp WHERE emp.country = 'USA' AND emp.city = 'Seattle'
GO