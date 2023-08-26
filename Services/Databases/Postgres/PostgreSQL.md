# PostgreSQL Cheatsheet

**Warning part of this article were created with ChatGTP 3.5 consulting the [PostgreSQL Documentation](https://www.postgresql.org/docs/)** 

Connect
```bash
psql -h $ipAddress -p 5432 -U postgres
```

Basic Commands and tricks
```sql
-- Get Help
\?

-- List databases
\l
-- Connect to database
\c
-- Show all tables in database
\dt
\dt+ -- show size and description

-- Case insensitive
select * from $tableName
```

Creating and Managing Databases
```sql
-- Create a new database
CREATE DATABASE database_name;
-- Drop a database
DROP DATABASE database_name;
-- Create a new table
CREATE TABLE table_name (
    column_name1 datatype,
    column_name2 datatype,
    ...
);
```

Creating and Managing Databases 
```sql
-- Delete a table
DROP TABLE table_name;
-- Insert data into a table
INSERT INTO table_name (column1, column2, ...) VALUES (value1, value2, ...);
```

Querying Data 
```sql
-- Retrieve all records from a table
SELECT * FROM table_name;
-- Retrieve specific columns and filter results
SELECT column1, column2 FROM table_name WHERE condition;
-- Aggregate functions (e.g., SUM, AVG, COUNT)
SELECT AVG(column) FROM table_name;
-- Joining tables
SELECT column1, column2 FROM table1 JOIN table2 ON table1.column = table2.column;
```

Updating and Deleting
```sql
-- Update records
UPDATE table_name SET column = value WHERE condition;
-- Delete records
DELETE FROM table_name WHERE condition;
```

Indexes
```sql
-- Create an index
CREATE INDEX index_name ON table_name (column_name);
-- Drop an index
DROP INDEX index_name;
```

User Management
```sql
-- Create a new user
CREATE USER username WITH PASSWORD 'password';
-- Grant privileges to a user
GRANT privilege ON table_name TO username;
-- Revoke privileges from a user
REVOKE privilege ON table_name FROM username;
-- Change a user's password
ALTER USER username WITH PASSWORD 'new_password';
```

Backup and Restore
```bash
# Create a backup
pg_dump -h hostname -d database_name -U username -f backup.sql
# Restore from backup
psql -h hostname -d database_name -U username -f backup.sql
```

## References

[PostgreSQL Documentation](https://www.postgresql.org/docs/)
[postgresqltutorial](https://www.postgresqltutorial.com/postgresql-administration/postgresql-show-tables/)