# Linux Cronjobs


Crons are located in various places in the [[Linux-File-System]]
- main crontab file at `/etc/crontab` governs system-wide cronjobs.
- users crontab files stored: `/var/spool/cron/crontabs`

`/etc/` contains cronjob related by the unit of time directories:
- `/etc/cron.hourly/` - System cronjobs that run once per hour.
- `/etc/cron.daily/` - System cronjobs that run once per day.
- `/etc/cron.weekly/` - System cronjobs that run once per week.
- `/etc/cron.monthly/` - System cronjobs that run once per month.
- `/etc/cron.d/` - Additional custom system cronjobs.

Write cronjobs the legitimate way
```bash
crontab -e 
```
There are various way to write them for [[Linux-Persistence]]

#### Reading Crontab

```bash
1 * * * * root /bin/bash echo "hello idiot every minute"
1 1 1 1 1 root /bin/bash echo "At 01:01 on day-of-month 1 and on Monday in January."
" * "   # is wildcard for non entered cron formatting
MIN	    # What minute to execute at
HOUR	# What hour to execute at
DOM	    # What day of the month to execute at
MON	    # What month of the year to execute at
DOW	    # What day of the week to execute at
CMD	    # The actual command that will be executed.
```
#### Crontab.guru

[Crontab.guru](https://crontab.guru/) is *The quick and simple editor for cron schedule expressions by* [Cronitor](https://cronitor.io/cron-job-monitoring?utm_source=crontabguru&utm_campaign=cronitor_top "Cron job monitoring and observability").
#### Logging and Monitoring

For [[Linux-IR]] and [[Linux-Process-Analysis]]

cronjob execution logs
- Debian-like logging at `/var/log/syslog` 
- Red Hat Enterprise Linux (RHEL) and CentOS, etc logs to `/var/log/cron`

```bash
sudo grep cron /var/log/syslog | grep -E 'failed|error|fatal'
```

[[PSPY]] again is good! Use offensive tool [pspy](https://github.com/DominicBreuker/pspy) for defensive purposes (used in [[Red-KOTH-Battlegrounds-Cheatsheet-Linux]], local tool page: [[PSPY]]) [THM Linux Process Analysis Room](https://tryhackme.com/r/room/linuxprocessanalysis):*"without the need for root privileges. It is designed to capture and display real-time information about running processes, including their execution commands, user IDs, process IDs (PIDs), parent process IDs (PPIDs), timestamps, and other relevant details. It operates by reading data directly from the `/proc` virtual filesystem, providing real-time insights into process activity without modifying system files or requiring elevated permissions."*

## References

[THM Linux Process Analysis Room](https://tryhackme.com/r/room/linuxprocessanalysis)
[Crontab.guru](https://crontab.guru/) 
[Cronitor](https://cronitor.io/cron-job-monitoring?utm_source=crontabguru&utm_campaign=cronitor_top "Cron job monitoring and observability").