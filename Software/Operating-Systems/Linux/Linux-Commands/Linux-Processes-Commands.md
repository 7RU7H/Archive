# Linux Processes Commands



Useful in [[Linux-Process-Analysis]]

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
ps -A # view all running processes
ps axjf # view process tree
ps aux # view processes for all users
ps -eFH # All processes hierarchically displayed EXTRA FULL
ps -ef # (e) display all processes (f) for full format
ps -C # select by command name
```

#### `pgrep`

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

#### `pstree`

`pstree` to display a tree of processes. `grep`-ing with `1pstree` is not advised
```bash
# Show all PIDs,GPIDs comma delimitered good for referencing later
pstree -p -g 
```
#### `lsof` 

`lsof` lists information about files opened by processes on a system
```bash

lsof -p $PID
```

#### `top` 

`top` has real-time monitoring capabilities
```bash
# realtime stats about processes running
top -h 
# -d update every 5 seconds
# -H show process threads
# -c command paths
# -p  can be a comma delimited list --pid=PIDLIST : -p 1,2,3
top -d 5 -c -H -p $PID
```

#### Linux Signals
`kill`
```bash
kill $PID # kill + PID will 
```

SIGNALS
```bash
SIGTERM  #  Kill the process, but allow it to do some cleanup tasks beforehand
SIGKILL  #  Kill the process - #doesn't do any cleanup after the fact
SIGSTOP  #  Stop/suspend a process
systemstl # allows interaction with systemd process/daemon
		 # start, stop, enable, disable : enable and disable interact at bootup!
ctrl+z # to background
ctrl+c  # to close
fg # bring and gives us a reference to use when writing reports for clients.g a background process back inot use on the terminal
fg
bg | ctrl+z

kill -9 $PID # sigkill
```

#### `fg` and `bg`

Foregrounding and backgrounding
```bash
fg|bg %number # job number
fg|bg %string # beginning of the suspended command's name
fg|bg %+ # OR %% current job
fg|bg %- # previous job

fg 1
bg tmux
```

#### `fuser`

This is useful for forcing USBs to `umount` or figuring out why something is not responding
```bash
# Show which processes use the named files, sockets, or filesystems.
sudo fuser -v <portnumber>/<protocol> 
```
See [Veronica Explains fuser -  Youtube](https://www.youtube.com/watch?v=xF8uttDarG0)
#### `nsenter` 
```bash
nsenter # [option] [program[args] execute start processes and place them within the same namespace as another
```


## References

[THM Linux Process Analysis Room](https://tryhackme.com/r/room/linuxprocessanalysis)
 [Veronica Explains fuser -  Youtube](https://www.youtube.com/watch?v=xF8uttDarG0)