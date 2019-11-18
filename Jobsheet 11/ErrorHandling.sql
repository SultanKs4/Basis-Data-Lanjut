-- Soal 1
DECLARE @num INT = 5;
SELECT @num AS mynumber;

-- Soal 2
DECLARE @num INT = 4, @num2 INT = 6;
SELECT SUM(@num+@num2) AS totalnum;

-- Soal 3
DECLARE @empname AS nvarchar(30);
SELECT @empname = e.firstname + ' ' + e.lastname
FROM HR.Employees e
WHERE e.empid = 1;
SELECT @empname AS employee;

-- Soal 4
DECLARE @empname AS nvarchar(30);
SELECT @empname = e.firstname + ' ' + e.lastname
FROM HR.Employees e;
SELECT @empname AS employee;

SELECT e.firstname+' '+e.lastname AS [All Employee]
FROM HR.Employees e;

-- Soal 5
DECLARE @empname AS nvarchar(30), @empid AS INT = 5;
SELECT @empname = e.firstname + ' ' + e.lastname
FROM HR.Employees e
WHERE e.empid = @empid;
SELECT @empname AS employee;

-- Soal 6
DECLARE @empname AS nvarchar(30), @empid AS INT = 5;
SELECT @empname = e.firstname+' '+e.lastname
FROM HR.Employees e
WHERE e.empid = @empid;
GO
SELECT @empname AS employee;

-- Soal 7
DECLARE @result nvarchar(20), @i INT = 8;
IF @i < 5
    SET @result = 'Kurang dari 5';
ELSE IF @i >= 5 AND @i < 10
    SET @result = 'Antara 5 dan 10';
ELSE IF @i > 10
    SET @result = 'Lebih dari 10';
ELSE
    SET @result = 'Unknown';
SELECT @result result;

-- Soal 8
DECLARE @result nvarchar(20), @i INT = 8;
SELECT @result =
    CASE
        WHEN @i < 5 THEN 'Kurang dari 5'
        WHEN @i >=5 AND @i < 10 THEN 'Antara 5 dan 10'
        WHEN @i > 10 THEN 'Lebih dari 10'
        ELSE 'Unknown'
    END
SELECT @result AS result;

-- Soal 9
DECLARE @birthdate DATE, @cmpdate DATE;
SELECT @birthdate = e.birthdate
FROM HR.Employees e
WHERE e.empid=5;
SET @cmpdate = '1970-01-01';
IF @birthdate < @cmpdate
    PRINT 'Karyawan dilahirkan sebelum Januari 1, 1970';
ELSE
    PRINT 'Karyawan dilahirkan sesudah Januari 1, 1970';
SELECT @birthdate birthdate, @cmpdate cmpdate;

-- Soal 10
CREATE PROCEDURE Sales.CheckPersonBirthDate
    @empid INT,
    @cmpdate DATE
AS
DECLARE @birthdate DATE;
SET @birthdate=(SELECT birthdate
FROM HR.Employees
WHERE empid = @empid);
IF @birthdate < @cmpdate
    PRINT 'Karyawan dilahirkan sebelum ' + FORMAT(@cmpdate, 'MMMM d, yyyy','en-US');
ELSE
    PRINT 'Karyawan dilahirkan pada atau setelah '+ FORMAT(@cmpdate, 'MMMM d, yyyy','en-US');

EXEC Sales.CheckPersonBirthDate 3,'January 1, 1990';

-- Soal 11
DECLARE @i INT = 1;
WHILE @i <= 10
BEGIN
    PRINT @i;
    SET @i += 1;
END;

-- Soal 12
DECLARE @SQLstr nvarchar(200);
SET @SQLstr = 'SELECT empid, firstname, lastname FROM HR.Employees';
EXEC sys.sp_executesql @SQLstr;

-- Soal 13
DECLARE @SQLstr nvarchar(200), @SQLParam nvarchar(100);
SET @SQLParam = '@empid INT';
SET @SQLstr = 'SELECT empid, firstname, lastname FROM HR.Employees WHERE empid = @empid';
EXEC sys.sp_executesql @SQLstr, @SQLParam, @empid = 5;

-- Soal 14
CREATE SYNONYM dbo.Pelanggan
FOR Sales.Customers;
GO
SELECT contacttitle, contactname
FROM Pelanggan p;

-- Soal 15
BEGIN TRY
    SELECT CAST('i wanna die' AS date);
END TRY
BEGIN CATCH
    Print 'Error';
END CATCH

-- Soal 16
DECLARE @num varchar(20) = '0';
BEGIN TRY
    PRINT 5. / CAST (@num AS numeric(10,4));
END TRY
BEGIN CATCH
END CATCH

-- Soal 17
DECLARE @num varchar(20) = '0';
BEGIN TRY
    PRINT 5. / CAST (@num AS numeric(10,4));
END TRY
BEGIN CATCH
    PRINT 'Error Number: '+ CAST(ERROR_NUMBER() AS varchar);
    PRINT 'Error Message: '+ CAST(ERROR_MESSAGE() AS varchar);
END CATCH

-- Soal 18
DECLARE @num varchar(20) = 'A';
BEGIN TRY
    PRINT 5. / CAST (@num AS numeric(10,4));
END TRY
BEGIN CATCH
    IF CAST(ERROR_NUMBER() AS varchar) = 245 OR CAST(ERROR_NUMBER() AS varchar) = 8114
        PRINT 'Handling conversion error...';
    ELSE
        PRINT 'Handling NON conversion error...';
    PRINT 'Error Number: '+ CAST(ERROR_NUMBER() AS varchar);
    PRINT 'Error Message: '+ CAST(ERROR_MESSAGE() AS varchar);
END CATCH

-- Soal 19
CREATE PROCEDURE dbo.GetErrorInfo
AS
PRINT 'Error Number: ' + CAST(ERROR_NUMBER() AS varchar(10));
PRINT 'Error Message: ' + ERROR_MESSAGE();
PRINT 'Error Severity: ' + CAST(ERROR_SEVERITY() AS varchar(10));
PRINT 'Error State: ' + CAST(ERROR_STATE() AS varchar(10));
PRINT 'Error Line: ' + CAST(ERROR_LINE() AS varchar(10));
PRINT 'Error Proc: ' + COALESCE(ERROR_PROCEDURE(),'Not within procedure');

DECLARE @num varchar(20) = '0';
BEGIN TRY
    PRINT 5. / CAST (@num AS numeric(10,4));
END TRY
BEGIN CATCH
    EXEC dbo.GetErrorInfo;
END CATCH

-- Soal 20
DECLARE @num varchar(20) = '0';
BEGIN TRY
    PRINT 5 / CAST (@num AS numeric(10,4));
END TRY
BEGIN CATCH
    EXEC dbo.GetErrorInfo;
    THROW;
END CATCH

-- Soal 21 A
DECLARE @num varchar(20) = 'A';
BEGIN TRY
    PRINT 5 / CAST (@num AS numeric);
END TRY
BEGIN CATCH
    EXEC dbo.GetErrorInfo;
    IF CAST(ERROR_NUMBER() AS VARCHAR) = 8134
        PRINT 'Handling division by zero...';
    ELSE
        PRINT 'Throwing original error...';
    THROW;
END CATCH

-- Soal 21 B
DECLARE @msg AS varchar(2048);
SET @msg = 'Anda sedang mengerjakan Jobsheet 14 pada ' + 
    FORMAT(CURRENT_TIMESTAMP, 'MMMM d, yyyy','en-US') + 
    '. Ini bukan error, bosque';
THROW 50001, @msg, 1;