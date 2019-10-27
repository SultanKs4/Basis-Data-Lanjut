USE [TSQL]
GO

-- Soal 1
SELECT ov.orderid, ov.orderdate, ov.val,
    ROW_NUMBER() OVER(ORDER BY ov.orderdate) AS rowno
FROM Sales.OrderValues AS ov;

-- Soal 2
SELECT ov.orderid, ov.orderdate, ov.val,
    ROW_NUMBER() OVER(ORDER BY ov.orderdate) AS rowno,
    RANK() OVER(ORDER BY ov.orderdate) AS rankno
FROM Sales.OrderValues AS ov;

-- Soal 4
SELECT ov.orderid, ov.orderdate, ov.custid, ov.val,
    RANK() OVER(PARTITION BY ov.custid ORDER BY ov.val DESC) AS orderrankno
FROM Sales.OrderValues AS ov;

-- Soal 5
SELECT ov.custid, ov.val,
    YEAR(ov.orderdate) AS orderyear,
    RANK() OVER(PARTITION BY ov.custid, YEAR(ov.orderdate) ORDER BY ov.val DESC) AS orderrankno
FROM Sales.OrderValues AS ov;

-- Soal 6
WITH
    Soal6
    AS
    (
        SELECT ov.custid, ov.val,
            YEAR(ov.orderdate) AS orderyear,
            RANK() OVER(PARTITION BY ov.custid, YEAR(ov.orderdate) ORDER BY ov.val DESC) AS orderrankno
        FROM Sales.OrderValues AS ov
    )

SELECT s.custid, s.orderyear, s.orderrankno, s.val
FROM Soal6 AS s
WHERE s.orderrankno <3;

-- Soal 7
WITH
    OrderRows
    AS
    (
        SELECT ov.orderid, ov.orderdate, ov.val,
            ROW_NUMBER() OVER(ORDER BY orderdate, orderid) AS rowno
        FROM Sales.OrderValues AS ov
    )

-- Soal 8
SELECT o.orderid, o.orderdate, o.val,
    o2.val AS prevval,
    o.val - o2.val AS diffval
FROM OrderRows AS o
    LEFT JOIN OrderRows AS o2 ON o2.rowno + 1 = o.rowno;

-- Soal 9
SELECT ov.orderid, ov.orderdate, ov.val,
    LAG(ov.val, 1) OVER(ORDER BY orderdate, orderid) AS prevval,
    ov.val - LAG(ov.val, 1) OVER(ORDER BY orderdate, orderid) AS diffval
FROM Sales.OrderValues AS ov;

-- Soal 10
WITH
    SalesMonth2007
    AS
    (
        SELECT MONTH(ov.orderdate) AS monthno, SUM(ov.val) AS val
        FROM Sales.OrderValues AS ov
        WHERE YEAR(ov.orderdate) = 2007
        GROUP BY MONTH(ov.orderdate)
    )

-- Soal 11
SELECT s.monthno, s.val,
    (LAG(s.val, 1, 0) OVER(ORDER BY s.monthno) + 
    LAG(s.val, 2, 0) OVER(ORDER BY s.monthno) + 
    LAG(s.val, 3, 0) OVER(ORDER BY s.monthno)) / 3 AS avglast3months,
    s.val - FIRST_VALUE(s.val) OVER(ORDER BY s.monthno) AS diffjanuary,
    LEAD(s.val, 1, 0) OVER(ORDER BY s.monthno) AS nextval
FROM SalesMonth2007 AS s;


-- Soal 12
SELECT ov.custid, ov.orderid, ov.orderdate, ov.val,
    100 * ov.val / SUM(ov.val) OVER(PARTITION BY ov.custid) AS percoftotalcust
FROM Sales.OrderValues AS ov
ORDER BY ov.custid, percoftotalcust DESC;

-- Edited for develop
SELECT ov.custid, ov.orderid, ov.orderdate, ov.val,
    100 * val / SUM(val) OVER(PARTITION BY custid) AS percoftotalcust,
    FORMAT(val / SUM(val) OVER(PARTITION BY custid), 'p') AS percof
FROM Sales.OrderValues AS ov
ORDER BY ov.custid, percoftotalcust DESC;

-- Soal 13
SELECT ov.custid, ov.orderid, ov.orderdate, ov.val,
    100 * ov.val / SUM(ov.val) OVER(PARTITION BY ov.custid) AS percoftotalcust,
    SUM(ov.val) OVER(PARTITION by ov.custid ORDER BY ov.orderdate) AS runval
FROM Sales.OrderValues AS ov;

-- Soal 14
WITH
    SalesMonth2007
    AS
    (
        SELECT MONTH(ov.orderdate) AS monthno, SUM(ov.val) AS val
        FROM Sales.OrderValues AS ov
        WHERE YEAR(ov.orderdate) = 2007
        GROUP BY MONTH(ov.orderdate)
    )

SELECT s.monthno, s.val,
    AVG(s.val) OVER(ORDER BY s.monthno ROWS BETWEEN 3 PRECEDING AND CURRENT ROW) AS avglast3months,
    SUM(s.val) OVER(ORDER BY s.monthno) AS ytdval
FROM SalesMonth2007 AS s;