# Blue Linux


Who is on box?
```bash
w
who
ps aux | grep pts
```

How is X on box?
```bash
ps -aef --forest # Wait before killing enumerate Adversary
ls -la /proc/$various | grep cwd # How adversary has foothold? - where shell is executed
ss -anp | grep $PID # Find the IP address of adversary
```

Patch sudoers file
```
# Beware the pickiness of editing this file.
```

Counter Hidden Bash Shells
```bash
# Restore stdin and stdout of hidden bash shell in/output
exec >/dev/tty
```

## Replace Vulnerable functions

PHP
```php
eval() -> get_file_contents

//Patching functions
strpos()
preg_match()
if (strpos($ip, ';') !== false) { 
	//what you want to do 
}
```



## References

[]()
[ethicalhackerclub](https://ethicalhackers.club/hack-the-box-battlegrounds-cyber-mayhem-attack-defense-review-strategies-tips-and-tricks/)