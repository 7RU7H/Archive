# Linux Logging

[CrowdStrike:](https://www.crowdstrike.com/guides/linux-logging/advanced-concepts/) *"Linux uses a daemon called rsyslogd to process messages using the syslog protocol. This service evolved from the regular syslog daemon to the current enterprise-level logging system."* Its configuration file can be found at `/etc/rsyslog.conf` on Red Hat, Debian-based including [[Kali]], and Fedora. Its directives are located in `/etc/rsyslog.d/*.conf`

[syslog-ng](https://github.com/syslog-ng/syslog-ng) *"is an enhanced log daemon, supporting a wide range of input and output methods: syslog, unstructured text, queueing, SQL & NoSQL."*

Consider [[Linux-Hardening]]

Types of Logs:
- **System logs**: contain information about the general health and operation of the system
- **Application logs**: contain information about the specific applications running on the system
- **Security logs**: contain information about security-related events

```bash
/var/log
/var/log/httpd  # Contains HTTP Request  / Response and error logs.
/var/log/cron   # Events related to cron jobs are stored in this location.
/var/log/auth.log # Stores authentication related logs. 
/var/log/secure # Stores authentication related logs.     
/var/log/kern # This file stores kernel related events.
```

Audit logs with `aureport` and `ausearch`
```bash
aureport # Get a full summary
aureport --summary
aureport --failed 

# Return successful logins
ausearch --message USER_LOGIN --success yes --interpret
# Return unsuccessful logins
ausearch --message USER_LOGIN --success no --interpret

--message # Includes: `USER_LOGIN`, `DEL_USER`, `ADD_GROUP`, `USER_CHAUTHTOK`, `DEL_GROUP`, `CHGRP_ID`, `ROLE_ASSIGN`, and `ROLE_REMOVE`

# Count the unsuccessful root logins
ausearch --message USER_LOGIN --success no --interpret | grep ct=root | wc -l
```

`logrotate` archives or disposes of old logs to prevent excessive disk usage. Beware this can be used for [[Linux-Privilege-Escalation]] if run as root or privileged user log file write permissions and has vulnerable versions:
- 3.8.6
- 3.11.0
- 3.15.0
- 3.18.0
```bash
man logrotate
logrotate --help
# The configuration file is located:
cat /etc/logrotate.conf
# Confirguation files per service 
ls -la /etc/logrotate.d/*

logrotate [OPTION...] <configfile>
# Forcing new rotation by set the date after the individual log files in the status file:
cat /var/lib/logrotate.status # or...
logrotate -f # --force to force rotation 
```

## References

[THM Auditing and Monitoring Room](https://tryhackme.com/room/auditingandmonitoringse)
[THM Intro to SIEM](https://tryhackme.com/room/introtosiem)
[Crowdstrike Advanced Linux Logging](https://www.crowdstrike.com/guides/linux-logging/advanced-concepts/)
[Wikipedia syslog-ng](https://github.com/syslog-ng/syslog-ng)
[HTB Academy Logrotate](https://academy.hackthebox.com)