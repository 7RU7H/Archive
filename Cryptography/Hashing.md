# Hashing


Various hashing functions each outputs in hexadecimal format.
```bash
md5sum
sha1sum
sha256sum
sha512sum


hexdump
```

#### Hash collisions

[THM Hashing Basics Room](https://tryhackme.com/room/hashingbasics): *"The **pigeonhole effect** states that the number of items (_pigeons_) is more than the number of containers (_pigeonholes_); some containers must hold more than one item."*

[MD5 Collision Demo](https://www.mscs.dal.ca/~selinger/md5collision/)

SHA1 collision attack at [Shattered](https://shattered.io/)

#### Rainbow Tables

[CrackStation](https://crackstation.net/) 
[Hashes.com](https://hashes.com/en/decrypt/hash)

#### Cracking

[[Cracking-Files-And-Directories]]

[[Hashcat-Cheatsheet]] or [[John-The-Ripper-Cheatsheet]]

#### Linux Passwords

Table from 
[THM Hashing Basics Room](https://tryhackme.com/room/hashingbasics): 

| Prefix                         | Algorithm                                                                                                                                                                                        |
| ------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `$y$`                          | yescrypt is a scalable hashing scheme and is the default and recommended choice in new systems                                                                                                   |
| `$gy$`                         | gost-yescrypt uses the GOST R 34.11-2012 hash function and the yescrypt hashing method                                                                                                           |
| `$7$`                          | scrypt is a password-based key derivation function                                                                                                                                               |
| `$2b$`, `$2y$`, `$2a$`, `$2x$` | bcrypt is a hash based on the Blowfish block cipher originally developed for OpenBSD but supported on a recent version of FreeBSD, NetBSD, Solaris 10 and newer, and several Linux distributions |
| `$6$`                          | sha512crypt is a hash based on SHA-2 with 512-bit output originally developed for GNU libc and commonly used on (older) Linux systems                                                            |
| `$md5`                         | SunMD5 is a hash based on the MD5 algorithm originally developed for Solaris                                                                                                                     |
| `$1$`                          | md5crypt is a hash based on the MD5 algorithm originally developed for FreeBSD                                                                                                                   |
## References

[THM Hashing Basics Room](https://tryhackme.com/room/hashingbasics)