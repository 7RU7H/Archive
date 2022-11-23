
When two remote site what to exchange information, one safe way is virtual connect with vpn encrypted tunnel. Troubleshooot IPsec with [https://docs.netgate.com/pfsense/en/latest/troubleshooting/ipsec.html](https://docs.netgate.com/pfsense/en/latest/troubleshooting/ipsec.html), suggested by [Ippsec](https://www.youtube.com/watch?v=1ae64CdwLHE)

Prior to connection - Establishing of cryptographic settings - Internet Key Exchange (IKE) occurs
- Sometimes called IKE Profiles or Policy
		- Two Phases:
			1. IKE Phase One
				1. The same IKE settings go to the opposing host
				2. Establish a gateway - identify one another called Establish a Security Association
				- UDP port 500 
				- Pneumonic:
					-  H - Hash
					- A - Auth
					- G - DiffieHellman Group asymetric
					- L - Lifetime
					- E - Encryption symetric blunk data transfer
			1. IKE Phase Two 
				1. IPsec cryptosettings 
					- both must match on both peers; 
					- These setting feed into a tunnel interface.
					- Inbetween these two interfaces the symmetrically encrypted traffic can traverse.]
					- IP Protocol 50

Ipsec Traffic

- Hit a routing table
	- Either gateway or tunnel interface to be encrypted
		- Cleartext -> `[IP Header][TCP|UDP Header][Payload]`
		- Encrypted Modes:
			- Transport - the original IP Header is not encrypted
				- `[IP Header][Unencrypted ESP Header][TCP|UDP Header][Payload][ESP Trailer][ESP AUTH]`
				- ESP Trailer encapsulated the ESP Payload
				- ESP Auth contains a hash to authenicate everything from ESP Header to Trailer
			- Tunnel - original IP is also encrypted
				- `[IP Header][ESP Header][IP Header][TCP|UDP Header][Payload][ESP Trailer][ESP AUTH]`
				- The first IP header is new
				- ESP Auth contains a hash to authenicate everything from ESP Header to Trailer

NAT Traveral

If there is NAT boudary between the two sites we must add a NAT traveral - add UDP Header behind the New IP Header - to translate between routes - for Tunnel with NAT Traversal
- UDP port 45500
`[IP Header][UDP Header][ESP HEADER][IP Header][TCP|UDP Header][Payload][ESP Trailer][ESP AUTH]`

## OpenVPN

## Strongswan

[Strongswan](https://en.wikipedia.org/wiki/StrongSwan) is apparently really complex and requires considerations about the configuration that must be exact, unlike OpenVPN you do not need to transfer configuration file. Refer to Troubleshooting IPsec with [https://docs.netgate.com/pfsense/en/latest/troubleshooting/ipsec.html]. Ipsec manual and Ipsec.secrets, the Strongswan documentation is pretty rough and dense.

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

## References

[Wikipedia](https://en.wikipedia.org/wiki/IPsec)
[What is IPSec?](https://www.youtube.com/watch?v=tuDVWQOG0C0)
[Troubleshoot Ipsec https://docs.netgate.com/pfsense/en/latest/troubleshooting/ipsec.html](https://docs.netgate.com/pfsense/en/latest/troubleshooting/ipsec.html)
[Ippsec Conceal Video discusses Ipsec](https://www.youtube.com/watch?v=1ae64CdwLHE)