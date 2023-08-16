# Linux Crons
## Linux Filesystem Location
Crons are located in various places in the [[Linux-File-System]]

```bash
grep "CRON" /var/log/cron.log
```

## Reading Crontab
" * " is wildcard for non entered cron formatting
MIN	What minute to execute at
HOUR	What hour to execute at
DOM	What day of the month to execute at
MON	What month of the year to execute at
DOW	What day of the week to execute at
CMD	The actual command that will be executed.

## Crontab.guru

[Crontab.guru](https://crontab.guru/) is *The quick and simple editor for cron schedule expressions by* [Cronitor](https://cronitor.io/cron-job-monitoring?utm_source=crontabguru&utm_campaign=cronitor_top "Cron job monitoring and observability").