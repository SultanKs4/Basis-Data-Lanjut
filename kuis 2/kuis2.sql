USE TSQL
GO

-- Soal 1
SELECT country, [A], [B], [C]
FROM
    (
		SELECT custgroup, custid, country
    FROM
        Sales.CustGroups) AS D
		PIVOT 
			( 
				COUNT(custid) FOR custgroup IN ([A], [B], [C])
			) AS pvt
ORDER BY country;

-- Soal 2
DECLARE @result nvarchar(20), @i INT = 8;
IF @i < 5
    SET @result = 'Kurang dari 5';
ELSE IF @i >= 5 AND @i < 10
    SET @result = 'Antara 5 dan 10';
ELSE IF @i > 10
    SET @result = 'Lebih dari 10';
ELSE
    SET @result = 'Unknown';

SELECT @result AS result;
