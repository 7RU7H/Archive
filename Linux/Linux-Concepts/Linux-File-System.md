# Linux File System

## Host related

Path | Description | OS Details | Notes
--- | --- | --- | --- 
`/etc/os-release` | OS release information |  |
`/etc/hostname` | hostname | | 
`/etc/timezone` | Timezone information | | `ip`; legacy is `ifconfig` 

## Network related

Path | Description | OS Details
--- | --- | --- | --- 
`/etc/network/interfaces` | network interfaces information | |
`netstat` or `ss` | active network connecitons | |
`/etc/hosts` | | |
`/etc/resolv.conf` | DNS resolution data host has made | | `cat`

## Execution history related

Path | Description | OS Details
--- | --- | --- | ---
`/var/log/auth.log` | log authenticated execution attempts | |
`~/.bash_history` |||
`.viminfo` | command line history from vim | | 

## Process related

Path | Description | OS Details
--- | --- | --- | --- 
`/proc` | | |
`ps` | display running processes | | [pspy tool](https://github.com/DominicBreuker/pspy) 

## User related

Path | Description | OS Details | Notes
--- | --- | --- | --- 
`/etc/passwd` | account information | | 
`/etc/group` | user groups information | | 
`/etc/sudoers` | sudoers configuration | |
`/etc/shadow` |  password information | |

## Log related
Use `var/log/$LOGNAME*` to display rotated logs

Path | Description | OS Details | Notes
--- | --- | --- | --- 
`/var/log/wtmp` | historic login data | | 
`/var/log/btmp` | failed logins data | |
`/var/log/auth.log` | logs of all authenication onto/within box |Redhat and Centos use: `/var/log/secure` | Included in execution history
`/var/log/syslog` | logs genric system activity | | 
`/var/log/boot.log ` | boot and system startup information | |
`/var/log/dmesg` | kernel ring buffer messages | |
`/var/log/kern.log` | kernel logs | | 
`/var/log/httpd` | Apache server logs | |
`/var/log/(mysqld.log | mysql.log)` | MySQL database log | |

## Persistence related

Path | Description | OS Details | Notes
--- | --- | --- | --- 
`/etc/crontab` | scheduled tasks | |
``/var/log/cron.log` | running crons | |
`/etc/init.d` | service startup | |
`~/.bashrc` | bash shell configuration |

## References
[eurovps](https://www.eurovps.com/blog/important-linux-log-files-you-must-be-monitoring/) - Does contain erroreous information!
[Tryhackme Linux Forensics](https://tryhackme.com/room/linuxforensics)