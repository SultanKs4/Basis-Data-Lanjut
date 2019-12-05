-- Soal 1
BEGIN TRAN
INSERT INTO HR.Employees
    (lastname, firstname, title, titleofcourtesy, birthdate,
    hiredate, address, city, region, postalcode, country, phone, mgrid)
VALUES
    (N'Johnson', N'Test 1', N'Sales Manager', N'Mr.', '19700101', '20110101',
        N'Some Address 18', N'Ljubljana', NULL, N'1000', N'Slovenia', N'(386) 113322', 2);

INSERT INTO HR.Employees
    (lastname, firstname, title, titleofcourtesy, birthdate,
    hiredate, address, city, region, postalcode, country, phone, mgrid)
VALUES
    (N'Robertson', N'Test 2', N'Sales Representative', N'Mr.', '19850101',
        '20110601', N'Some Address 22', N'Ljubljana', NULL, N'1000', N'Slovenia', N'(386)
553344', 10);
COMMIT TRAN

-- Soal 2
SELECT empid, lastname, firstname
FROM HR.Employees
ORDER BY empid DESC;

DELETE HR.Employees
WHERE empid IN (10, 11);
DBCC CHECKIDENT ('HR.Employees', RESEED, 9);

-- Soal 3
BEGIN TRAN
INSERT INTO HR.Employees
    (lastname, firstname, title, titleofcourtesy, birthdate,
    hiredate, address, city, region, postalcode, country, phone, mgrid)
VALUES
    (N'Johnson', N'Test 1', N'Sales Manager', N'Mr.', '19700101', '20110101',
        N'Some Address 18', N'Ljubljana', NULL, N'1000', N'Slovenia', N'(386) 113322', 2);

INSERT INTO HR.Employees
    (lastname, firstname, title, titleofcourtesy, birthdate,
    hiredate, address, city, region, postalcode, country, phone, mgrid)
VALUES
    (N'Robertson', N'Test 2', N'Sales Representative', N'Mr.', '19850101',
        '20110601', N'Some Address 22', N'Ljubljana', NULL, N'1000', N'Slovenia', N'(386)
553344', 10);

-- Soal 4
SELECT empid, lastname, firstname
from HR.Employees
ORDER BY empid DESC;

-- Soal 5
ROLLBACK TRAN;

SELECT empid, lastname, firstname
FROM HR.Employees
ORDER BY empid DESC;

DBCC CHECKIDENT ('HR.Employees', RESEED, 9);

-- Soal 7
BEGIN TRAN;
INSERT INTO HR.Employees
    (lastname, firstname, title, titleofcourtesy, birthdate,
    hiredate, address, city, region, postalcode, country, phone, mgrid)
VALUES
    (N'Johnson', N'Test 1', N'Sales Manager', N'Mr.', '19700101', '20110101',
        N'Some Address 18', N'Ljubljana', NULL, N'1000', N'Slovenia', N'(386) 113322', 2);
INSERT INTO HR.Employees
    (lastname, firstname, title, titleofcourtesy, birthdate,
    hiredate, address, city, region, postalcode, country, phone, mgrid)
VALUES
    (N'Robertson', N'Test 2', N'Sales Representative', N'Mr.', '19850101',
        '10110601', N'Some Address 22', N'Ljubljana', NULL, N'1000', N'Slovenia', N'(386)
553344', 10);
COMMIT TRAN;
GO

-- Soal 8
SELECT empid, lastname, firstname
FROM HR.Employees
ORDER BY empid DESC;

DELETE HR.Employees
WHERE empid IN (10, 11);
DBCC CHECKIDENT ('HR.Employees', RESEED, 9);

-- Soal 9
BEGIN TRY
BEGIN TRAN
INSERT INTO HR.Employees
    (lastname, firstname, title, titleofcourtesy, birthdate,
    hiredate, address, city, region, postalcode, country, phone, mgrid)
VALUES
    (N'Johnson', N'Test 1', N'Sales Manager', N'Mr.', '19700101', '20110101',
        N'Some Address 18', N'Ljubljana', NULL, N'1000', N'Slovenia', N'(386) 113322', 2);
INSERT INTO HR.Employees
    (lastname, firstname, title, titleofcourtesy, birthdate,
    hiredate, address, city, region, postalcode, country, phone, mgrid)
VALUES
    (N'Robertson', N'Test 2', N'Sales Representative', N'Mr.', '19850101',
        '10110601', N'Some Address 22', N'Ljubljana', NULL, N'1000', N'Slovenia', N'(386)
553344', 10);
END TRY
BEGIN CATCH
IF (@@ERROR > 1)
    BEGIN
    ROLLBACK TRAN
    PRINT 'Rollback the transaction...'
END
ELSE
    BEGIN
    COMMIT TRAN
    PRINT 'Commit the transaction';
END
END CATCH

DBCC CHECKIDENT ('HR.Employees', RESEED, 9);