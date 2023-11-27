# Linux Processes

```bash
ps # provide a list of the currently runnning processes
ps -A # view all running processes
ps axjf # view process tree
ps aux # view processes for all users
ps -ef # (e) display all processes (f) for full format
ps -C # select by command name
top # realtime stats about processes running
kill # kill + PID will 
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

kill -9 processnumber # sigkill

fg|bg %number # job number
fg|bg %string # beginning of the suspended command's name
fg|bg %+ # OR %% current job
fg|bg %- # previous job

```

## Fuser

```bash
# Show which processes use the named files, sockets, or filesystems.
sudo fuser -v <portnumber>/<protocol> 
```

## PGREP
```bash
pgrep [options] pattern # Grep for process IDs
pkill [options] pattern # Kill process by default SIGTERM
pidwait [options] pattern # Wait for each process instead of listing them on stdout
	-u #uid!
	-e # echo display name of PID pkill only
	-s # session id
	-O # only match processes whose parent process ID is listed  

```

## nsenter 
```bash
nsenter # [option] [program[args] execute start processes and place them within the same namespace as another
```
