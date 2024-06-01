# `journalctl`

`journalctl` is used in systemd logging workflow, configuration file found `/etc/systemd/journald.conf`; [digitalocean - journalctl article](https://www.digitalocean.com/community/tutorials/how-to-use-journalctl-to-view-and-manipulate-systemd-logs)
```bash
man systemd.journal-fields
# UTC timestamps
journalctl --utc
# Logs from current boot
journalctl -b
journalctl -b -1 # From the relative pointer
journalctl -b 879206e3d1ce473753459a2fb8875bbe # boot ID
journalctl -p err -b # By priority
# Saved previous boots
journalctl --list-boots
# Most recent logs
journalctl -n $int # by some number
# Follow logs as they are being writen
journalctl -f
# Disk usage metrics
journalctl --disk-usage
# Entries from timestamp(s)
journalctl --since "2015-01-10 17:15:00"
journalctl --since "2015-01-10" --until "2015-01-11 03:00"
journalctl --since yesterday
journalctl --since 09:00 --until "1 hour ago"
# Filter by service, can provide multiple -u $serviceA -u $serviceB
journalctl -u $serviceName.service
# Filter by _PID, _UID _GUID
journalctl _PID=8088
# view group IDs
journalctl -F _GID
# By component
journalctl /usr/bin/bash
# Kernel messages
journalctl -k
journalctl -k -b -5 # From 5 boots ago..
# Modifying display
journalctl --no-full # ... where information is removed
journalctl -a # all information
journalctl --no-pager # easy to read (do not use with automation of text manipulationm tools)
# Outputs
journalctl -b -u $service.service -o json # For JeSON
```

## References

[THM Linux Process Analysis Room](https://tryhackme.com/r/room/linuxprocessanalysis)
[digitalocean - journalctl article](https://www.digitalocean.com/community/tutorials/how-to-use-journalctl-to-view-and-manipulate-systemd-logs)