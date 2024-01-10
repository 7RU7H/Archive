# Faketime

[faketime](https://manpages.ubuntu.com/manpages/trusty/man1/faketime.1.html) *maniuplate the system time for a given command. The given command will be tricked into believing that the current system time is the one specified in the  timestamp. Filesystem timestamps will also be reported relative to this timestamp. The wall clock will  continue to run from this date and time unless specified otherwise (see advanced options). Actually,  faketime is a simple wrapper for libfaketime, which uses the LD_PRELOAD mechanism to load a small library  which intercepts system calls to functions such as time(2) and fstat(2). This wrapper exposes only a sub‐  set of libfaketime's functionality; please refer to the README file that came with faketime for qmore de‐  tails and advanced options, or have a look at https://github.com/wolfcw/libfaketime.*


This is very useful in [[Attacking-Kerberos]] and [[Local-Setup]] as work-around for `ntp` related lack of presence in remote or your Linux Distribution for Network OPSEC and Packet economy. For example using `impacket` - [[Impacket-Cheatsheet]]:
```bash 
faketime -f '+10h' impacket-getTGT -dc-ip 10.10.10.10 -hashes 1D8FD23873EBC8933BF8DFC56112CC87:1D8FD23873EBC8933BF8DFC56112CC87 $vulnadDomain.$tld/svc_compromised
```

It can also be used after [[Proxychains]]
```bash
proxychains faketime -f '+10h' impacket-getTGT -dc-ip 10.10.10.10 -hashes 1D8FD23873EBC8933BF8DFC56112CC87:1D8FD23873EBC8933BF8DFC56112CC87 $vulnadDomain.$tld/svc_compromised
```
#### Usage

```bash
faketime

# Usage: faketime [switches] <timestamp> <program with arguments>

# This will run the specified 'program' with the given 'arguments'. The program will be tricked into seeing the given 'timestamp' as its starting date and time. The clock will continue to run from this timestamp. Please see the manpage (man faketime) for advanced options, such as stopping the wall clock and make it run faster or slower.

The optional switches are:
  -m                  : Use the multi-threaded version of libfaketime
  -f                  : Use the advanced timestamp specification format (see manpage)
  --exclude-monotonic : Prevent monotonic clock from drifting (not the raw monotonic one)
  -p PID              : Pretend that the program\'s process ID is PID
  --date-prog PROG    : Use specified GNU-compatible implementation of 'date' program

# Advanced Timestamp format

# Freeze clock at absolute timestamp: "YYYY-MM-DD hh:mm:ss"
# Relative time offset: "[+/-]123[m/h/d/y]", e.g., "+60m", "+2y"
# Start-at timestamps: "@YYYY-MM-DD hh:mm:ss"

Examples:
faketime 'last friday 5 pm' /bin/date
faketime '2008-12-24 08:15:42' /bin/date
faketime -f '+2,5y x10,0' /bin/bash -c 'date; while true; do echo $SECONDS ; sleep 1 ; done'
faketime -f '+2,5y x0,50' /bin/bash -c 'date; while true; do echo $SECONDS ; sleep 1 ; done'
faketime -f '+2,5y i2,0' /bin/bash -c 'date; while true; do date; sleep 1 ; done' # In this single case all spawned processes will use the same global clock without restarting it at the start of each process.

# (Please note that it depends on your locale settings whether . or , has to be used for fractions)
```

## References

[faketime - manpages.ubuntu](https://manpages.ubuntu.com/manpages/trusty/man1/faketime.1.html) 
[GitHub - libfaketime](https://github.com/wolfcw/libfaketime)