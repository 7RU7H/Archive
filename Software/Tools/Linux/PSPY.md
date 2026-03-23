# pspy

[pspy](https://github.com/DominicBreuker/pspy)  *"is a command line tool designed to snoop on processes without need for root permissions. It allows you to see commands run by other users, cron jobs, etc. as they execute. Great for enumeration of Linux systems in CTFs. Also great to demonstrate your colleagues why passing secrets as arguments on the command line is a bad idea. The tool gathers the info from procfs scans. Inotify watchers placed on selected parts of the file system trigger these scans to catch short-lived processes."*

32 and 64bit download links
- 32 bit big, static version: `pspy32` [download](https://github.com/DominicBreuker/pspy/releases/download/v1.2.1/pspy32)
- 64 bit big, static version: `pspy64` [download](https://github.com/DominicBreuker/pspy/releases/download/v1.2.1/pspy64)
- 32 bit small version: `pspy32s` [download](https://github.com/DominicBreuker/pspy/releases/download/v1.2.1/pspy32s)
- 64 bit small version: `pspy64s` [download](https://github.com/DominicBreuker/pspy/releases/download/v1.2.1/pspy64s)

```go]
Usage:
  pspy [flags]

Flags:
  -c, --color                        color the printed events (default true)
      --debug                        print detailed error messages
  -d, --dirs stringArray             watch these dirs
  -f, --fsevents                     print file system events to stdout
  -h, --help                         help for pspy
  -i, --interval int                 scan every 'interval' milliseconds for new processes (default 100)
      --ppid                         record process ppids
  -p, --procevents                   print new processes to stdout (default true)
  -r, --recursive_dirs stringArray   watch these dirs recursively (default [/usr,/tmp,/etc,/home,/var,/opt])
  -t, --truncate int                 truncate process cmds longer than this (default 2048)
```
## References

[pspy -  GitHub](https://github.com/DominicBreuker/pspy) 