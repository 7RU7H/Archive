# Blue Linux


```bash
ps -aef --forest # Wait before killing enumerate Adversary
ls -la /proc/$various | grep cwd # How adversary has foothold? - where shell is executed
ss -anp | grep $PID # Find the IP address of adversary
```


## Replace Vulnerable functions

PHP
```php
eval() -> get_file_contents
```
