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