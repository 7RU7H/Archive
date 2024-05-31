# Linux Forensics

Mitigate security risk by using mounted file system containing essential library files, binaries, etc and exporting `PATH` variables to prevent inadvertently executing malicious code or compromised utilities on system. 
```bash
export PATH=/mnt/usb/bin:/mnt/usb/sbin
export LD_LIBRARY_PATH=/mnt/usb/lib:/mnt/usb/lib64
```

Use Checksums! - submit them to a malware detection service like [VirusTotal](https://www.virustotal.com/gui/home/upload) ( local description, tricks and usage page: [[VirusTotal]]) for further analysis. 
```bash
sha -a $ALG $file
md5sum $file
sha256sum $file
```

#### Artefact Gathering
```bash
# OS release information
cat /etc/os-release
# Kernel
cat /etc/issue
uname -a
# User accounts
cat /etc/passwd | column -t -s :
# Group information
cat /etc/group
# List all members of a specific group
getent group $groupNameOrID


# Sudo/Whell group information from the sudoers file
sudo cat /etc/sudoers

# Login information
who

sudo last -f /var/log/wtmp
lastlog /var/log/lastlog
# Failed logins
lastb

# Authentication logs
cat /var/log/auth.log | tail
cat /var/log/secure # CentOS or RedHat

# Hostname
cat /etc/hostname
# Timezone information
cat /etc/timezone
```
####  Network information
```bash
cat /etc/network/interfaces
ip a 
ip address show
ifconfig # legacy
netstat -natp # Active network connections
ss -tulnp # Listening ports
# Process information
# pspy is a great tool for this
ps aux
```
####  DNS information
```bash
cat /etc/hosts
cat /etc/resolv.conf
```


#### Processs

See [[Linux-Process-Analysis]] for [[Persistence]] methods used by attackers.

#### Directories and Files; Permissions and Timestamping

`stat` command displays:
- `mtime` - modified timestamp - change in the file contents
- `ctime` - change timestamp - change in the file metadata
- `atime` - accessed timestamp - last accessed 

```bash
# Display and Files Permissions
ls -la $directoryOrFile
# Wildcards usage:
ls -la *.txt
ls -la $specificDir/*

# Display and Files Timestamping
stat # See all at once
ls -l # mtime
ls -lc # ctime
ls -lu # atime

# Current user will be pass as argument with this environment variable - replace with specific username if required
find / -type f -user $USER  2>/dev/null
find / -type d -group $$GROUPNAME 2>/dev/null
# All World writable  
find / -type d -perm -o+w 2>/dev/null
# All files created in the last five minutes
find / -type f -cmin -5 2>/dev/null

# File metadata is sometimes not stripped!
exiftool $file
```

User Directories and Files
```bash
ls -la /home
# SSH backdoors:
ls -la /home/$username/.ssh && cat /home/$username/.ssh/authorized_keys 
# Timelining is important!
stat /home/$username/.ssh/authorized_keys
```

#### Logs - And evidence of execution
```bash
# Syslog
cat /var/log/syslog*
# Auth logs
cat /var/log/auth.log*
# Third party logs
ls -la /var/log
# Bash History
cat /home/$user/.bash_history
# Vim History
cat /home/$user/.vimifno
```
#### Evidence of execution
```bash
# Find executables - use more flags and arguments to narrow focus
find / -type f -executable 2>/dev/null

strings $weirdBinary # Check encoding! -h
# Debian-based System verifis integrity of installed packages
debsums -e -s # ONLY performs checks on configruation file and silences error NOT FULL METHODICALLY SOUND

# Find SETUID and SETGUID bit - NEVER FORGET SETGUID - run seperately seperately!
find / -type f -perm -u=s 2>/dev/null
find / -type f -perm -g=s 2>/dev/null

# sudo execution history
cat /var/log/auth.log* |grep -i COMMAND|tail
# .bash_history - beware logs get nuked and various other shell
cat ~/.bash_history
# Vim file access evidence
# beware some people like nano and emacs
cat ~/.viminfo
```

In [[Linux-Persistence]] article details as many persistence mechanisms used be attacks, the below are example artefact gather commands
```bash
# Crons
cat /etc/crontab
# Service Startup
ls /etc/init.d
# .bashrc for each user
cat ~/.bashrc
# System wide settings
cat /etc/profile
```

[[Rootkits]] are a [[Persistence]] binary that affects the OS's kernel, function at a kind of Ring 0+0 where it has root or almost root access, while being manipulate system calls that the kernel makes to prevent discovery - Use:
- [Chkrootkit (Check Rootkit)](https://www.chkrootkit.org/)
- [RKHunter (Rootkit Hunter)](https://rkhunter.sourceforge.net/) 

These are by no means a definitive proof-based mechanism to determine if you have a rootkit just an application that may provide data to which you have analyse  
```bash
sudo chkrootkit
sudo rkhunter -c -sk
```
## References

[THM Linux File System Analysis Room](https://tryhackme.com/r/room/linuxfilesystemanalysis)
[VirusTotal](https://www.virustotal.com/gui/home/upload) 