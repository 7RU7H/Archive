
When two remote site what to exchange information, one safe way is virtual connect with vpn encrypted tunnel. 

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

## References

[What is IPSec?](https://www.youtube.com/watch?v=tuDVWQOG0C0)