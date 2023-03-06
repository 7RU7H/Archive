# Linux Forensics


Artificat Gathering
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
# Sudo/Whell group information from the sudoers file
sudo cat /etc/sudoers
# Login information
sudo last -f /var/log/wtmp
# Authenication logs
cat /var/log/auth.log | tail
# Hostname
cat /etc/hostname
# Timezone information
cat /etc/timezone
# Network information
cat /etc/network/interfaces
ip a 
ip address show
ifconfig # legacy
netstat -natp # Active network connections
ss -tulnp # Listening ports
# Process information
# pspy is a great tool for this
ps aux
# DNS information
cat /etc/hosts
cat /etc/resolv.conf

# Logs
# Syslog
cat /var/log/syslog*
# Auth logs
cat /var/log/auth.log*
# Third party logs
ls -la /var/log

# Evidence of execution
# sudo execution history
cat /var/log/auth.log* |grep -i COMMAND|tail
# .bash_history - beware logs get nuked and various other shell
cat ~/.bash_history
# Vim file access evidence
# beware some people like nano and emacs
cat ~/.viminfo
```



In [[Linux-Persistence]] article details as many persistence mechanisms used be attacks, the below are example articfact gather commands
```bash
# Crons
cat /etc/crontab
# Service Startup
ls /etc/init.d
# .bashrc
cat ~/.bashrc
```

