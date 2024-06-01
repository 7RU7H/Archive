# Linux Process Analysis

## Processes

Linux has a number of different binaries to display information about processes (see [[Linux-Processes-Commands]]). For [[Linux-IR]], finding the *abnormal is actually to establish a baseline for normal behaviour specific to your systems, environment, and organisation.*

Consider Data sets
- Baseline normal
- True-Negatives
- False-Positives
- Real world examples: open source known malicious; [[MITRE-ATT&CK]] framework, etc

#### `ps`
Beware the `ps` dash and non-dash commands!
```bash
# WARNING THESE ARE VERY DIFFERENT
 -a                #   all with tty, except session leaders
  a                #   all with tty, including other users
# If you are here you want the non-dash  
```

```bash
# `ps` read the /proc directory
ps 
ps --help all # for all the help we all need
# From a specific user
ps -u $username 
# All processes hierarchically displayed EXTRA FULL
ps -eFH
```

`pgrep` `grep` for processes
```bash
pgrep [options] pattern # Grep for process IDs
pkill [options] pattern # Kill process by default SIGTERM
pidwait [options] pattern # Wait for each process instead of listing them on stdout
	-u #uid!
	-e # echo display name of PID pkill only
	-s # session id
	-O # only match processes whose parent process ID is listed  
```

`pstree` to display a tree of processes. `grep`-ing with `1pstree` is not advised
```bash
# Show all PIDs,GPIDs comma delimitered good for referencing later
pstree -p -g 
```

`lsof` lists information about files opened by processes on a system
```bash

lsof -p $PID
```

`top` has real-time monitoring capabilities
```bash
top -h
# -d update every 5 seconds
# -H show process threads
# -c command paths
# -p  can be a comma delimited list --pid=PIDLIST : -p 1,2,3
top -d 5 -c -H -p $PID
```

Use offensive tool [pspy](https://github.com/DominicBreuker/pspy) for defensive purposes (used in [[Red-KOTH-Battlegrounds-Cheatsheet-Linux]], local tool page: [[PSPY]])
## Cronjobs

[[Linux-Cronjobs]]
- main crontab file at `/etc/crontab` governs system-wide cronjobs.
- users crontab files stored: `/var/spool/cron/crontabs/`
- `/etc/` contains cronjob related by the unit of time directories:
	- `/etc/cron.hourly/` - System cronjobs that run once per hour.
	- `/etc/cron.daily/` - System cronjobs that run once per day.
	- `/etc/cron.weekly/` - System cronjobs that run once per week.
	- `/etc/cron.monthly/` - System cronjobs that run once per month.
	- `/etc/cron.d/` - Additional custom system cronjobs.

cronjob execution logs
- Debian-like logging at `/var/log/syslog` 
- Red Hat Enterprise Linux (RHEL) and CentOS, etc logs to `/var/log/cron`

```bash
sudo grep cron /var/log/syslog | grep -E 'failed|error|fatal'
```

```bash
sudo bash -c 'for user in $(cut -f1 -d: /etc/passwd); do entries=$(crontab -u $user -l 2>/dev/null | grep -v "^#"); if [ -n "$entries" ]; then echo "$user: Crontab entry found!"; echo "$entries"; echo; fi; done'
```

[[PSPY]] again is good! Use offensive tool [pspy](https://github.com/DominicBreuker/pspy) for defensive purposes (used in [[Red-KOTH-Battlegrounds-Cheatsheet-Linux]], local tool page: [[PSPY]]). [THM Linux Process Analysis Room](https://tryhackme.com/r/room/linuxprocessanalysis):*"without the need for root privileges. It is designed to capture and display real-time information about running processes, including their execution commands, user IDs, process IDs (PIDs), parent process IDs (PPIDs), timestamps, and other relevant details. It operates by reading data directly from the `/proc` virtual filesystem, providing real-time insights into process activity without modifying system files or requiring elevated permissions."*

## Services

Depending on the distribution, services are managed by the system's service management utility. For a more authoritative description from [baeldung](https://www.baeldung.com/linux/differences-systemctl-service) of *the two most relevant init systems*:
 - [SysVInit](https://wiki.archlinux.org/title/SysVinit) is the classic initialization process in Linux. The initialization process relies on the individual service to install relevant scripts on the _/etc/init.d_ directory. Additionally, the scripts must support the standard commands such as _start_, _stop_, and _status_. One of the main characteristics of this init system is that it is a start-once process and does not track the individual services afterward. The [_service_](https://linux.die.net/man/8/service) command is used for running these init scripts from the terminal.
- [SystemD](https://man7.org/linux/man-pages/man1/systemd.1.html), on the other hand, is a recent initialization system that aims to replace SysVInit. In fact, most Linux distributions such as Debian and Red Hat are already using SystemD as their init system out of the box. In contrast to SysVInit, SystemD continues to run as a daemon process after the initialization is completed. Additionally, they are also actively tracking the services through their _cgroups_. The [systemctl](https://www.man7.org/linux/man-pages/man1/systemctl.1.html) command is the entry point for users to interact and configures the SystemD.

Normally `x.service` is in the `/etc/systemd/system/` directory.
```bash
systemctl status <service>
systemctl enable <service>
systemctl disable <service>
systemctl restart <service>
systemctl start <service>
systemctl stop <service>

# Use `systemctl` to iterate and query all the services on the system
systemctl list-units --all --type=service
# q to exit
# Same as above but only running services
systemctl list-units --type=service --state=running
```

Example of what the configuration for a service looks sort of like:
```bash
[Unit]
Description=Description goes here
After=network.target

[Service]
Type=simple
ExecStart=/path/to/binary/or/script
Restart=always

[Install]
WantedBy=multi-user.target
```

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
## Autostart scripting

## Application Artefacts


## References

[THM Linux Process Analysis Room](https://tryhackme.com/r/room/linuxprocessanalysis)
[pspy - GitHub](https://github.com/DominicBreuker/pspy) 
[baeldung Linux systemctl service differences](https://www.baeldung.com/linux/differences-systemctl-service) 
[digitalocean - journalctl article](https://www.digitalocean.com/community/tutorials/how-to-use-journalctl-to-view-and-manipulate-systemd-logs)
## Appendix

`ps` usage.
```bash
Usage:
 ps [options]

Basic options:
 -A, -e               all processes
 -a                   all with tty, except session leaders
  a                   all with tty, including other users
 -d                   all except session leaders
 -N, --deselect       negate selection
  r                   only running processes
  T                   all processes on this terminal
  x                   processes without controlling ttys

Selection by list:
 -C <command>         command name
 -G, --Group <GID>    real group id or name
 -g, --group <group>  session or effective group name
 -p, p, --pid <PID>   process id
        --ppid <PID>  parent process id
 -q, q, --quick-pid <PID>
                      process id (quick mode)
 -s, --sid <session>  session id
 -t, t, --tty <tty>   terminal
 -u, U, --user <UID>  effective user id or name
 -U, --User <UID>     real user id or name

  The selection options take as their argument either:
    a comma-separated list e.g. '-u root,nobody' or
    a blank-separated list e.g. '-p 123 4567'

Output formats:
 -D <format>          date format for lstart
 -F                   extra full
 -f                   full-format, including command lines
  f, --forest         ascii art process tree
 -H                   show process hierarchy
 -j                   jobs format
  j                   BSD job control format
 -l                   long format
  l                   BSD long format
 -M, Z                add security data (for SELinux)
 -O <format>          preloaded with default columns
  O <format>          as -O, with BSD personality
 -o, o, --format <format>
                      user-defined format
  -P                  add psr column
  s                   signal format
  u                   user-oriented format
  v                   virtual memory format
  X                   register format
 -y                   do not show flags, show rss vs. addr (used with -l)
     --context        display security context (for SELinux)
     --headers        repeat header lines, one per page
     --no-headers     do not print header at all
     --cols, --columns, --width <num>
                      set screen width
     --rows, --lines <num>
                      set screen height
     --signames       display signal masks using signal names

Show threads:
  H                   as if they were processes
 -L                   possibly with LWP and NLWP columns
 -m, m                after processes
 -T                   possibly with SPID column

Miscellaneous options:
 -c                   show scheduling class with -l option
  c                   show true command name
  e                   show the environment after command
  k,    --sort        specify sort order as: [+|-]key[,[+|-]key[,...]]
  L                   show format specifiers
  n                   display numeric uid and wchan
  S,    --cumulative  include some dead child process data
 -y                   do not show flags, show rss (only with -l)
 -V, V, --version     display version information and exit
 -w, w                unlimited output width

        --help <simple|list|output|threads|misc|all>
```

`top` usage
```bash
# Usage:
top [options]

# Options:
 -b, --batch-mode                # run in non-interactive batch mode
 -c, --cmdline-toggle            # reverse last remembered 'c' state
 -d, --delay =SECS [.TENTHS]     # iterative delay as SECS [.TENTHS]
 -E, --scale-summary-mem =SCALE  # set mem as: k,m,g,t,p,e for SCALE
 -e, --scale-task-mem =SCALE     # set mem with: k,m,g,t,p for SCALE
 -H, --threads-show              # show tasks plus all their threads
 -i, --idle-toggle               # reverse last remembered 'i' state
 -n, --iterations =NUMBER        # exit on maximum iterations NUMBER
 -O, --list-fields               # output all field names, then exit
 -o, --sort-override =FIELD      # force sorting on this named FIELD
 -p, --pid =PIDLIST              # monitor only the tasks in PIDLIST
 -S, --accum-time-toggle         # reverse last remembered 'S' state
 -s, --secure-mode               # run with secure mode restrictions
 -U, --filter-any-user =USER     # show only processes owned by USER
 -u, --filter-only-euser =USER   # show only processes owned by USER
 -w, --width [=COLUMNS]          # change print width [,use COLUMNS]
 -1, --single-cpu-toggle         # reverse last remembered '1' state

 -h, --help                      # display this help text, then exit
 -V, --version                   # output version information & exit

# For more details see top(1).
```