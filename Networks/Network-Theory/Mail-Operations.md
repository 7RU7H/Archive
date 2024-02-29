# Mail Operations 

[[Network-Protocols-Hub]] and especially [[Network-Protocols]] are required for some differentiation as to later workflow like Recon for harvesting see [[Email-Harvesting]].

Mail delivery:
```c
# Telnet
mail user agent
mail server agent
mail transfer agent
mail delivery agent
simple mail transfer protocol
# Mail Transfer Agent MTA
# User Agent UA
# Mail User Agent MUA
# Mail Delivery Agent MDA
MUA -(smtp)-> MSA/MTA -> SMTP -> MTA/MDA -(POP3/IMAP)-> MUA
```

SMTP(S) uses TLS/SSL - [[SSL-TLS]]
- SMTP is an “Email Push Protocol” used to transfer email messages from the client to the server
	- SMTP End-to-End: Email communication between organizations
		 - Sender-side SMTP client initiates an SMTP connection
	- SMTP Store-and-Forward: Email communication within an organization. 
		 - SMTP server will maintain the copy of the mail until the copy is forwarded to the receiver.
POP3(S)
- POP3 is used to download email messages from the server to the client.
- Emails are processed locally
- transmission in clear text

POP3S
```goat
Email Client -> TCP Handshake -> Email Server
Email Client <- 220 Ready <- Email Server
Email Client -> EHLO -> Email Server
Email Client <- 250 STARTTLS <- Email Server
Email Client -> STARTTLS -> Email Server
			 <- 220 GO Ahead
			 <- TLS Negotiation 
			 Encrypted Email -> 
```

[OpenPGP](https://www.openpgp.org/) is *"Email encryption. For all operating systems. Standing the test of time... OpenPGP is the most widely used email encryption standard. It is defined by the OpenPGP Working Group of the Internet Engineering Task Force (IETF) as a Proposed Standard in [RFC 4880](https://tools.ietf.org/html/rfc4880). OpenPGP was originally derived from the PGP software, created by [Phil Zimmermann](https://philzimmermann.com)."* 

Using `gpg` (Gnu Privacy Guard)
```bash
gpg --gen-key
# For a message.txt
# --sing : sing with private key
# --armor : ASCII instead of binary
# -r : recipient
gpg --encrypt --sign --armor -r recipent@someemail.tld message.txt
```

## References

[THM Network Security Protocols](https://tryhackme.com/room/networksecurityprotocols)
[Wikipedia OpenPGP](https://en.wikipedia.org/wiki/Pretty_Good_Privacy)
[OpenPGP Official](https://www.openpgp.org/)