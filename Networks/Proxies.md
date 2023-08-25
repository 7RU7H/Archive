# Proxies

A proxy server, or proxy, is an application that intercepts requests and responses between a client and a server. Proxy servers offer ways to interact with web APIs, and WebSockets using web browsers, mobile applications, and other types of client software.

Proxy servers are useful in several different ways:
- They give us a better understanding of the inner workings of a web or mobile application.
- They help us find flaws within an application's back-end. 
- They can circumvent certain limitations imposed by firewalls or client protection.

On the offensive side, proxies are useful for the following reasons:
- They help us learn what kind of traffic an application generates and receives.
- They dissect raw requests or responses to bypass certain client-side validation protection.
- Proxies make it easier to find vulnerabilities.
- They allow us to perform faster repetitive testing tasks or manually dig deeper into the HTTP(S) traffic.


## FoxyProxy

For [[FoxyProxy]] information follow the link
## Firefox Proxy

- `Firefox menu -> Settings -> Network Settings click Settings`
- Select manual proxy configuration:
    - HTTP proxy: 127.0.0.1
    - Uncheck: Also use this proxy for FTP and HTTPS # unless you need a HTTPS proxy
    - Delete: ANYTHING in the "No proxy for" field

#### CA Certificate 

Certificate Authority (CA) is a entity that issues digital certificates. With HTTPS, the certificate authenticates the server by checking the browser is communicating with a legitimate website. `"Find in settings":"Certificates" -> click View Certificates... -> Authorities`

## SOCKS Tunnels

To circumvent firewall protections, we need to tunnel our traffic to another network in a secure manner. Socket Secure (SOCKS) is network protocol which allow communication with servers through a firewall by tunnelling network traffic to actual server on the behalf of a client.

Sock5 proxy supports tunnelling for UDP traffic, however not all proxifier tools support this.

#### SOCKS5 Proxy 

See [[SOCKS5-Protocol]]
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

## Proxifiers

A category of software applications that can force other programs to send traffic through a proxy server. Useful when a application is not proxy aware and cannot configured to use a proxy.

### Proxychains

[[Proxychains]] for a full cheatsheet and breakdown, `proxychains` examples
```bash
proxychains ssh $USER@$IP
proxychains xfreerdp /u:$USER /p:$PASSWORD /v:$IP
proxychains evil-winrm -i $IP -u $USER -p $PASSWORD    
```

Using `proxychains` in [[Port-Redirection-And-Tunnelling]] workflows
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

#### Web Filtering 

Web filter also known as internet or content filter; it a is proxy where the traffic from all the clients in a network is sent towards the internet through this proxy. The main role of a proxy is to restrict or control the content an external user is allowed to access, the content can allowed without inspection, blocked, or inspected more in depth till further action. It protects against blacklisted sources of malware or anything unrelated to clients required activity. It can be integrated with Data Loss Prevention (DLP) software, to prevent data leakage from within the company.

#### Access Classifcation

Proxy Administrators can choose what categories are allowed, which are blocked, and which inspected further. if there is no deep packet inspection with HTTPS decryption of traffic access is made either by DNS requests or by filtering via Server Name Indication(SNI). SNI is the full domain name that is queried by the browser, accessible by proxy due to the query being clear text before the traffic is switched from HTTP HTTPS.

#### Deep Packet Inspection

If clients have access to file uploadable sites, to prevent data leakages the proxy can either block the action and/or alert the administrator, via a classification system. confidential material. Due to HTTPS, breaking the SSL channel in order to inspect this kind of traffic, for performance HTTPS Inspection hardware appliances are used. Proxying like Burpsuite inspecting and then forwarding or dropping traffic.

#### SSH 

```
ssh USER@FINAL_DEST -o "ProxyCommand=nc -X connect -x PROXYHOST:PROXYPORT %h %p"
```

