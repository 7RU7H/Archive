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
```bash
# Beware the pickiness of editing this file.
visudo
```

Counter Hidden Bash Shells
```bash
# Restore stdin and stdout of hidden bash shell in/output
exec >/dev/tty
```

Defending against ssh session spying - [infosecmatter blog on ssh sniffing](https://www.infosecmatter.com/ssh-sniffing-ssh-spying-methods-and-defense/)
```bash
# is ptrace enabled?
sysctl kernel.yama.ptrace_scope
# ptrace only allows for one observer at a time!
ps axwwf | grep -B2 $$
```

#### Networking 

If you need to kill a specific process using a given port
```bash
ps aux | grep $app # or..
pgrep $app
sudo fuser -k 445/tcp
```

#### File system

File permission of the earliest to latest files in the a directory
```bash
ls -la --sort=time -r
```

**BEWARE** the Linux File ACLs and Attributes - 
```bash
getfacls
chattr
lsattr
```

#### Services

```bash
# Inspect cron log file for running jobs
grep "CRON" /var/log/syslog
```

#### Replace Vulnerable functions in services

```bash
grep -r -e 'system(\|exec(' 2>/dev/null
# Nuke the files
sed -i 's/exec(/passthru(/g' $file
sed -i 's/system(/passthru(/g' $file
```

PHP - see [[PHP]]
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

[ethicalhackerclub](https://ethicalhackers.club/hack-the-box-battlegrounds-cyber-mayhem-attack-defense-review-strategies-tips-and-tricks/)
[infosecmatter blog on ssh sniffing](https://www.infosecmatter.com/ssh-sniffing-ssh-spying-methods-and-defense/)
[haax.fr linux-systems/tricks/](https://cheatsheet.haax.fr/linux-systems/tricks/)