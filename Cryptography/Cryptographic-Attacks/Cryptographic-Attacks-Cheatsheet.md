# Cryptographic-Attacks-Cheatsheet

[[Cryptography]] and [[Cryptography-Glossary]] for general understanding about Cryptography, this page is more for solving challenges in CTFs that require techniques and understanding about failed implementation of Cryptography.

#### RSA Attacks

Strong Keys require:
- Length
- Entropy
- Uniqueness

The [paper](https://www.cl.cam.ac.uk/archive/rja14/Papers/psandqs.pdf) "P's and Q's" by Ross Anderson and Serge Vaudenay explores how poor randomness in RSA key generation can lead to severe vulnerabilities.

[FactorDB](https://factordb.com/) to search for the prime numbers of the (n)

Encrypted messages often are padded with random data (e.g., PKCS#1 or OAEP) to prevent mathematical attacks.

#### Cracking Hashes

[[John-The-Ripper-Cheatsheet]]
[[Hashcat-Cheatsheet]]

#### Exposed Keys

In exposed in source code 

[[Openssl]]
```bash
# Use xxd to format string to plain hexdump style with 0 octets
echo $Key | base64 -d | xxd -p -c 0
echo $IV | base64 -d | xxd -p -c 0
openssl enc -$algorithm -d -in $encrypted.$file -out $decrypted.$file -K $Key -iv $IV
```

[[CyberChef]]
`From base64` -> `decrypt AES`


[[Padding-Oracle-Attack]]

## References

[THM Room Breaking Crypto The Simple Way](https://tryhackme.com/room/breakingcryptothesimpleway)
 [paper](https://www.cl.cam.ac.uk/archive/rja14/Papers/psandqs.pdf) 