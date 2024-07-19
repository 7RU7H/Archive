# TALK Understand Cryptography for Offensive-Security with Ayub Yusuf

[YouTube - Understanding Cryptography for Offensive Security w/ Ayub Yusuf](https://www.youtube.com/watch?v=S8esOtKmFDc)
Description: *"One of the most common findings we discover during penetration tests, red teams, and security audits are those related to cryptographic flaws. Weak Transport Layer Security, Certificate Errors, and the like show up on our pentest reports time and time again. The goal of this free one-hour Black Hills Information Security (BHIS) webcast, with Ayub Yusuf, is to provide a foundational understanding of cryptography and get to the root cause of the flaws we see over and over again. You'll walk away understanding the basics of encoding, hashing, encryption, signatures, and certificates. Additionally, you'll gain insights into the practicality of exploiting cryptographic flaws."*

TryHackMe room: https://tryhackme.com/r/room/pineappleonpizza

#### Notes

- Do not Bing [[CyberChef]]
- [GitHub - mattnotmax/cyberchef-recipes](https://github.com/mattnotmax/cyberchef-recipes)

Regarding has collisions there is a great Computerphile video explaining it visually with a clock to represent modular arithmetic involved in hashing, can't find it 

![](charstillcrackgraph-securitydotorg.png)
[YouTube - Understanding Cryptography for Offensive Security w/ Ayub Yusuf](https://www.youtube.com/watch?v=S8esOtKmFDc) cites Source: https://www.security.org/


Salts prevent same password enumeration by hash collision 

Linux Hashing

 ID   | Method | Hashcat (-m {#}) | John the Ripper (--format={name})
--- | --- | ---  | --- 
 `$1$`  | MD5 | 500 | md5crypt
 `$2*$` | Blowfish | 3200 | bcrypt
`$5$` | SHA-256 | 7400 | sha256crypt
`$6$` | SHA-512 | 1800 | sha512crypt
`$y$` | yescript | N/a | crypt

Windows Hashing

Method | Hashcat (`-m {#}`) | John the Ripper (`--format={name}`)
--- | --- | --- 
LM | 3000 | LM
NT | 1000 | NT
NetNTMLv1 | 5500 | netntlm
NetNTLMv2 | 5600 | netntlmv2
Kerberos 5 AS-REQ | 18200 | krb5asrep
Kerberos RC4 | 13100 | krb5tgs
https://www.baeldung.com/linux/list-ca-ssl-certificates

Block Cipher Modes
• Electronic Codebook (ECB)
• Cipher Block Chaining (CBC)
• Galois/Counter Mode (GCM)

[[SSL-TLS]]: SSL/TLS versioning - source [YouTube - Understanding Cryptography for Offensive Security w/ Ayub Yusuf](https://www.youtube.com/watch?v=S8esOtKmFDc)

Version | Status              
--- | -
SSLv2 | Depreciated in 2011 
SSLv3 | Depreciated in 2015 
TLS 1.0 | Depreciated in 2021 
TLS 1.1 | Depreciated in 2021 
TLS 1.2 | Active since 2008   
TLS 1.3 | Active since 2018   
