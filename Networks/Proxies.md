# Proxies

A proxy server, or proxy, is an application that intercepts requests and responses between a client and a server. Proxy servers offer ways to interact with web APIs, and WebSockets using web browsers, mobile applications, and other types of client software.

Proxy servers are useful in several different ways:

They give us a better understanding of the inner workings of a web or mobile application.
They help us find flaws within an application's back-end.
They can circumvent certain limitations imposed by firewalls or client protection.

On the offensive side, proxies are useful for the following reasons:

They help us learn what kind of traffic an application generates and receives.
They dissect raw requests or responses to bypass certain client-side validation4 protection.
Proxies make it easier to find vulnerabilities.
They allow us to perform faster repetitive testing tasks or manually dig deeper into the HTTP(S) traffic.


# HTTP/HTTPS with FoxyProxy/Firefox proxy
Firefox menu -> Settings -> Network Settings click Settings
Select manual proxy configuration:
        HTTP proxy: 127.0.0.1
        uncheck: Also use this proxy for FTP and HTTPS # unless you need a HTTPS proxy
        delete: ANYTHING in the "No proxy for" field

# CA Certificate 
Certificate Authority (CA) is a entity that issues digital certificates. With HTTPS, the certificate authenicates the server by checking the browser is communicating with a legitmate website.
"Find in settings":"Certificates" -> click View Certificates... ->  Authorities

# SOCKS Tunnel

To circumvent firewall protections, we need to tunnel our traffic to another network in a secure manner.
Socket Secure (SOCKS) is network protoocl which allow communication wuth servers through a firewall by tunneling network traffic to atual server on the behalf of a client.

Sock5 proxy supports tunneing for UDP traffic, however not all proxifier tools support this.

## SOCKS5 Proxy 
```bash
systemctl start ssh # Start ssh
systemctl enable ssh # Enable ssh

bash -c "echo 1 > /proc/sys/net/ipv4/iP_forward" # Setting up Remote routing

ssh -D 1337 -q -C -N <user>@kali # Setup the SSH Tunnel 
#       ^-= a Dynamic Port 
# -D open a TCP port & use it as a SOCKS5 proxy to connect to ssh server
# -C compress data to save bandwidth(optional)
# -q quiet mode, no local ouput!
# -N do not execute remote commands!

ssh -D 1337 -q -C -f -N <user>@kali
# -f to run in background

ss -tulpn | grep 1337 # check kali listening ports
```

## Proxychains port forwarding:
```bash
vim /etc/proxychains
# comment out socks4 127.0.0.0 <port>
# add 
socks5 127.0.0.1 1337
# port scan through proxychains to enumerate internal ports on the server using proxychains:
proxychains nmap -flags 127.0.0.1
# find the port the webserver, perform local port forwarding to port using ssh 
-i id_rsa -L 80:127.0.0.1:<remote port> # may need sudo!
```

# Proxifiers

A category of software applications that can force other programs to send thraffic through a proxy server. Useful when a application is not proxy aware and cannot configured to use a proxy.

# Proxy chains

A proxifier tool that is pre-installed on Kali linux, configured to tunnel traffic over one or more proxies, Proxychains support SOCKS4, SOCKS5, and HTTP(S) proxies.
```
vim /etc/proxychains4.conf
socks 127.0.0.1 1337
proxychains nikto -h http://sitetoscan
proxychains -q nikto -h http://sitetoscan # quite proxychains output 
```

There are multiple types of proxychain options: 
	chain_len, option to specify the number of proxies to be used.	
```
dynamic_chain

Dynamic - Each connection will be done via chained proxies
all proxies chained in the order as they appear in the list
at least one proxy must be online to play in chain
(dead proxies are skipped)
otherwise EINTR is returned to the app

Strict_chain

Strict - Each connection will be done via chained proxies
all proxies chained in the order as they appear in the list
all proxies must be online to play in chain
otherwise EINTR is returned to the app

round_robin_chain

Round Robin - Each connection will be done via chained proxies
of chain_len length
all proxies chained in the order as they appear in the list
at least one proxy must be online to play in chain
(dead proxies are skipped).
the start of the current proxy chain is the proxy after the last
proxy in the previously invoked proxy chain.
if the end of the proxy chain is reached while looking for proxies
start at the beginning again.
otherwise EINTR is returned to the app
These semantics are not guaranteed in a multithreaded environment.

random_chain

Random - Each connection will be done via random proxy
(or proxy chain, see  chain_len) from the list.
this option is good to test your IDS :)
```

## Examples
```bash
proxychains ssh $USER@$IP
proxychains xfreerdp /u:$USER /p:$PASSWORD /v:$IP
proxychains evil-winrm -i $IP -u $USER -p $PASSWORD    
```


# Web Filtering 

Web filter also known as internet or content filter; it a is proxy where the traffic from al the clients in a network si sent towards the internet through this proxy. The main role of a proxy is to restrict or control the content an external user is alllowed to access, the content can allowed without inspection, blocked, or inspected more in depth till futher action. It proctects against blacklisted sources of malware or anything unrelated to clients required activity. It can be intergrated with Data Loss Prevention(DLP) software, to prevent data leakage from within the company.

# Access Classifcation

Proxy Administrators can chooose what categories are allowed, which are blocked, and which inspected further. if there is no deep packet inspection with HTTPS decryption of traffic access is made iether by DNS requests or by filtering via Server Name Indication(SNI). SNI is the full domain name that is queried by the browser, accessibale by proxy due to the query being clear text before the traffic is swtiched from HTTP HTTPS.

# Deep Packet Inspection

If clients have access to file uploadable sites, to prevent data leakages the proxy can either block the action and/or alert the administrator, via a classification system. confidential material. Due to HTTPS, breaking the SSL channel in order to inspect this lind of traffic, for performance HTTPS Inspection hardware appliciances are used. Proxying like Burpsuite inspecting and then forwarding or dropping traffic.

# SSH 

```
ssh USER@FINAL_DEST -o "ProxyCommand=nc -X connect -x PROXYHOST:PROXYPORT %h %p"
```
