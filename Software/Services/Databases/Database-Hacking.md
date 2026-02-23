# Database Hacking

Just a friendly reminder to use `searchsploit`, Databases don't just hold credentials!


## Introduction to Databases

A Database is an application that can store and retrieve data. This data is store in a structured manner like a table or a graph. Data is organised in various ways depending on outside application of data or for management of how it is store relates to its use or relation to other data in the database. A query language is used to perform actions on the data inside the database. Databases can then be queried by other applications to access the database in someway.

- Database Management System (DBMS) serve the purpose of interaction between database and users, human and machine
- Primary Keys are typical the 0th column and row.
- Some tables can have **Foreign Keys** that point to another table in the database or another database. 

Sometimes we wear different IT hats as the internet is a black box with blinky red LED light on top, do not just dork the question:
- Write down 
	- the context of table 
	- WTF are you doing
	- WTF are trying to do

MySQL 
```sql
CREATE DATABASE database_name;
SHOW DATABASES;
USE database_name;
DROP database_name; -- stop using a database
SHOW TABLES;
CREATE TABLE example_table_name (
    example_column1 data_type,
    example_column2 data_type,
    example_column3 data_type
);

DESCRIBE example_table_name;
ALTER example_table_name;
DROP example_table_name; -- remember to stop altering a table 

-- C
INSERT INTO example_table_name (example_column1, example_column2, example_column3);
-- R
SELECT * FROM example_table_name; --  read all
SELECT example_column1 FROM example_table_name; -- read a column
-- U
UPDATE example_table_name; -- Save alterations made to a table
-- D
DELETE FROM example_table_name WHERE example_column3 = 1;

-- CLAUSEs
DISTINCT
GROUP BY 
ORDER BY
HAVING

SELECT DISTINCT example_column FROM example_table_name; -- Unique entrys from a column

SELECT example_column1, COUNT(*) FROM exmaple_table_name GROUP BY example_column1; -- also count total
 
SELECT exmaple_column1 FROM example_table_name ORDER BY exmaple_column2, DESC; -- also add a description 

SELECT example_column1 FROM example_table_name GROUP BY exmaple_column2 HAVING example_column1 LIKE '%Hack%'; -- find all entries that have the characters like with in the '' 

-- OPERATOR

... WHERE something LIKE "%SQL%";
... AND ...
... OR ...
... NOT ...
... BETWEEN 1 AND 10; -- test value between a defined range
WHERE something = "Something"
WHERE something != "Something"
-- probably different by version, lanague
WHERE something < "Something" -- need to confirm measurements
WHERE something > "Something" -- need to confirm measurements
WHERE something <= "Something" -- need to confirm measurements
WHERE something >= "Something" -- need to confirm measurements

-- FUNCTIONs

-- CONCAT()
SELECT CONCAT(example_column1, " is a type of" example_column2, " book.") AS example_column3 FROM example_table_name;
-- GROUP_CONCAT
SELECT example_column1 GROUP_CONCAT(example_column1, " is a type of" example_column2, " book.") AS example_column3 FROM example_table_name GROUP BY example_column1;
-- SUBSTRING()
-- WHERE 1 and 4 are substring lengths
SELECT SUBSTRING(example_column1, 1, 4) AS example_column2 FROM example_table_name;
-- LENGTH()
SELECT LENGTH(example_column1) AS example_column2 FROM example_table_name;

-- Aggregate Function
-- COUNT()
SELECT COUNT(*) example_column1 FROM example_table_name;
-- SUM()
SELECT SUM(example_column1) AS example_column2 FROM example_table_name;
-- MAX()
SELECT MAX(example_column1) AS example_column1 FROM example_table_name;
-- MIN() 
SELECT MIN(example_column1) AS example_column2 FROM example_table_name;
```

Useful Combinations
```sql
-- Output all entries by those not ending in a 0 by a specific column
SELECT * FROM example_column1 WHERE SUBSTRING(example_column1, LENGTH(example_column1), 1) <> '0'
```
## Database Cheatsheets and Helpsheets

[[MariaDB-Hacking]]
[[MSSQL-Hacking]]
[[MySQL-Cheatsheet]]
[[Redis]]
[[SQLite-Hacking]]

## SQLi Cheatsheets

[[Introduction-to-SQL]]
[[SQL-Injection]]
[[NoSQLInjection]]
[[MySQL-Hacking]]
[[SQLmap-CheatSheet]]
[THM SQL fundamentals](https://tryhackme.com/room/sqlfundamentals)