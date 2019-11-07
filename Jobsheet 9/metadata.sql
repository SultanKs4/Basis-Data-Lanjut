USE master;
GO

-- Soal 1
SELECT name, database_id, create_date
FROM sys.databases;

-- Soal 2
SELECT object_id, name, schema_id, type, type_desc, create_date, modify_date
FROM sys.objects
WHERE [type] = 'U';

-- Soal 3
SELECT object_id, name,
    SCHEMA_NAME() AS schema_name, [type],
    type_desc, create_date, modify_date
FROM sys.tables;

USE [TSQL]
GO

-- Soal 4
SELECT name AS column_name, column_id,
    TYPE_NAME(system_type_id) AS data_type,
    max_length, [precision], scale, collation_name
FROM sys.columns
WHERE OBJECT_NAME(object_id) = 'Customers';

-- Soal 5
SELECT DB_ID() AS database_id,
    DB_NAME() AS database_name,
    USER_ID(CURRENT_USER) AS user_id,
    CURRENT_USER AS user_name;

-- Soal 6
SELECT name, type_desc,
    OBJECT_NAME(object_id) AS object_id,
    SCHEMA_NAME(schema_id) AS schema_name
FROM sys.objects;

-- Soal 7
SELECT name AS column_name,
    OBJECT_NAME(object_id) AS table_name,
    OBJECT_SCHEMA_NAME(object_id) AS schema_name
FROM sys.columns
WHERE name LIKE '%name%'
    AND OBJECTPROPERTY(object_id, 'IsUserTable') = 1;

-- Soal 8
PRINT OBJECT_DEFINITION(OBJECT_ID('Sales.CustOrders'));

-- Soal 9
SELECT session_id, login_time, host_name, [language], login_name, date_format
FROM sys.dm_exec_sessions
WHERE host_name IS NOT NULL;

-- Soal 10
SELECT
    cpu_count AS [Logical CPU Count],
    hyperthread_ratio AS [Hyperthread Ratio],
    cpu_count / hyperthread_ratio AS [Physical CPU Count],
    physical_memory_kb / 1024 AS [RAM (MB)],
    sqlserver_start_time AS [Last SQL Server Start]
FROM
    sys.dm_os_sys_info;

-- Soal 11
SELECT total_physical_memory_kb / (1024 * 1024) AS [Total RAM (GB)],
    available_physical_memory_kb / (1024 * 1024) AS [Available RAM (GB)],
    total_page_file_kb / (1024 * 1024) AS [Total Page File (GB)],
    available_page_file_kb / (1024 * 1024) AS [Available Page File (GB)],
    system_memory_state_desc AS [RAM Availability Status]
FROM sys.dm_os_sys_memory;