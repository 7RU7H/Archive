# Cryptography 

# Under restructuring


For terminology: [[Cryptography-Glossary]]


For a list of commands related to cryptography try here: [[De-Or-En-Cryption]]


## Tooling 


- Mathematics:
	- [yafu](https://sourceforge.net/projects/yafu/) - Helps factor large numbers
	- [Factordb](http://factordb.com) - Database of large factored numbers
- Rainbow tables
	- [Rapid Tables](https://www.rapidtables.com)
- Cryptanalysis:
	- [featherduster](https://github.com/nccgroup/featherduster) - An automated, modular cryptanalysis tool; i.e., a Weapon of Math Destruction
- Bitwise 
	- [1xor](https://github.com/droberson/1xor) - Helps solve 1 byte XOR puzzles
- Conversion
	- Large hex/decimal conversion @ [ss64.com](http://ss64.com/convert.html)
- Probably Everything
	- [dcode.fr](https://www.dcode.fr/tools-list) - [[Puzzle-Solution-Tools]]

- [HashID](https://github.com/psypanda/hashID) - Identify hash types
- [John the Ripper](https://github.com/magnumripper/JohnTheRipper) - JtR w/ Jumbo patches -  [[John-The-Ripper-Cheatsheet]]
- [Hashcat ](https://hashcat.net/hashcat/) - [[Hashcat-Cheatsheet]]

## Encoding

**CALCULATOR IS YOUR FRIEND**

Decimal  | Binary |	Hexadecimal
--- | --- | ---
0   | 0b0 | 0x0
1 | 0b1 | 0x1
2 | 0b10 | 0x2
3 | 0b11 | 0x3
4 | 0b100 | 0x4
5 | 0b101 | 0x5
6 | 0b110 | 0x6
7 | 0b111 | 0x7
8 | 0b1000 | 0x8
9 | 0b1001 | 0x9
10 | 0b1010 | 0xa
11 | 0b1011 | 0xb
12 | 0b1100 | 0xc
13 | 0b1101 | 0xd
14 | 0b1110 | 0xe
15  | 0b1111 | 0xf
.. | .. | ..
255	 | 	0b11111111 | 0xff

File format conversion:
```bash
iconv
```

Encoding
```bash 
# beware of characters like newlines no the cmdline 
# -w0 wrap amount
base64 (-d for decode) | base64 -d -w0 
```

## Checksums

Linux Checksum commands
```
md5sum
shasum
sha256sum
sha512sum
```

## Cryptographic Hashing

A cryptographic hash function is an algorithm that takes data of arbitrary size as its input and returns a fixed size value, called  digest or checksum, as its output. Cryptographic hash function is a type of hashing function is used to protect the integrity of data as it attempt guarantee security properties. Mathematical entails that easy to compute to cipher, but without the key values it makes it as difficult as possible to reverse the computation.

[Hashcat Examples is your friend](https://hashcat.net/wiki/doku.php?id=example_hashes)
```bash
john --list=foramt | grep
```
- Or try tools like `hashid`, `hash-identifier`, `haiti`
- Or a site like [Crackstation](https://crackstation.net/), if your are working for an organisation get permission before trying hashes against any online rainbow table.

#### Salt

A salt is an preferably random, uique generated string, it mixed with cleartext input, then the hash is calculated for the mixed string. It is useful as the same password will produce the same hash, so to store user passwords with the potential for same password use can be avoid with salting.Salting protects against rainbow table attacks.o

Hashing passwords:
```
import hashlib
string = "saltedpassword"
hashlib.sha256(string.encode()).hexdigest()
```
Unix has different variations of `mkpasswd`
```
mkpasswd -m SHA-512 foobar salt
```

sha512 crypt
```
$y$j9T$F5Jx5fExrKuPp53xLKQ..1$X3DX6M94c7o.9agCG9G317fhZg9SqC.5i5rd.RhAtQ7
```
1. id - y
1. param - j9T
1. salt - F5Jx5fExrKuPp53xLKQ..1
1. hash - X3DX6M94c7o.9agCG9G317fhZg9SqC.5i5rd.RhAtQ7

#### HMAC

Hash-based message authentication code (HMAC) is a message authentication code (MAC) that uses a cryptographic key in addition to a hash function. [RFC2104](https://www.rfc-editor.org/rfc/rfc2104) outlines HMAC as:
HMAC requires:
- secret key
- inner pad (ipad) a constant string. (RFC2104 uses the byte `0x36` repeated B times. The value of B depends on the chosen hash function.)
- outer pad (opad) a constant string. (RFC2104 uses the byte `0x5C` repeated B times.)

Calculating the HMAC follows the following steps as shown on [THM cryptography 101 Room](https://tryhackme.com/room/cryptographyintro):
1. Append zeroes to the key to make it of length B, i.e., to make its length match that of the ipad.
2. Using bitwise exclusive-OR (XOR), represented by ⊕, calculate key ⊕ ipad.
3. Append the message to the XOR output from step 2.
4. Apply the hash function to the resulting stream of bytes (in step 3).
5. Using XOR, calculate key ⊕ opad.
6. Append the hash function output from step 4 to the XOR output from step 5.
7. Apply the hash function to the resulting stream of bytes (in step 6) to get the HMAC.

```bash
# Beware hmac is not part of any Kali metapackages for good reason...
hmac256 $key $file
```


## Symmetric-Key Encryption

Symmetric Key Algorithms use the same key for encrypting the plaintext into ciphertext and for decrypting the ciphertext back into plaintext. Key is sometimes "passphrase" synonymous with "key". Maintaining the key's secrecy is vital, if public anyone can decrypt with it - harms confidentiality as transmission of the key not the data is the issue.

- Beware Cipher type: Block (2d array) Cipher and Stream (1d array) Cipher

National Institute of Standard and Technology (NIST) published the Data Encryption Standard (DES) in 1977. DES is a symmetric encryption algorithm that uses a key size of 56 bits. As a replacement for triple DES NIST published the Advanced Encryption Standard (AES) in 2001 using a key 128,192,256 bits. It has four transformations that  reoccur multiple times:
-   KeyExpansion – round keys are derived from the cipher key using the [AES key schedule](https://en.wikipedia.org/wiki/AES_key_schedule "AES key schedule"). AES requires a separate 128-bit round key block for each round plus one more. [Wikipedia - AES High-level description of the algorithm](https://en.wikipedia.org/wiki/Advanced_Encryption_Standard):
-   Initial round key addition:
    1.  AddRoundKey – each byte of the state is combined with a byte of the round key using [bitwise xor](https://en.wikipedia.org/wiki/Bitwise_xor "Bitwise xor").
-   9, 11 or 13 rounds:
    1.  SubBytes – a [non-linear](https://en.wikipedia.org/wiki/Linear_map "Linear map") substitution step where each byte is replaced with another according to a [lookup table](https://en.wikipedia.org/wiki/Rijndael_S-box "Rijndael S-box").
    2.  ShiftRows – a transposition step where the last three rows of the state are shifted cyclically a certain number of steps.
    3.  MixColumns – a linear mixing operation which operates on the columns of the state, combining the four bytes in each column.
    4.  AddRoundKey
-   Final round (making 10, 12 or 14 rounds in total):
    1.  SubBytes
    2.  ShiftRows
    3.  AddRoundKey

For the AES Standard read: [FIPS PUB 197](https://csrc.nist.gov/publications/detail/fips/197/final)

GNU Privacy Guard 
```bash
# with symmetric encryption using a $CIPHER encrypt message.txt 
gpg --symmetric --cipher-algo $CIPHER message.txt
# Armour flag for ASCCII armoured output
--armor
# Decrypt with
gpg --output original_message.txt --decrypt message.gpg
```

OpenSSL Project
```bash
# Openssl is a powerful tool 
openssl <(standard|message digest|cipher)-command> <flags>
# Encrypting
openssl aes-256-cbc -e -in message.txt -out encrypted_message
# Decrypting
openssl aes-256-cbc -d -in encrypted_message -out original_message.txt

# improving encryption with iterations and using Password-Based Key Derivation Function 2 (PBKDF2);
openssl aes-256-cbc -pbkdf2 -iter 10000 -e -in message.txt -out encrypted_message
# the decryption will require the same flags that changed the encryption method
openssl aes-256-cbc -pbkdf2 -iter 10000 -d -in encrypted_message -out original_message.txt
```



#### PKI SSL/TLS

SSL encryption procedures leverages both asymmetric and symmetric encryption. To prevent [[MITM-Attacks]], Public Key Infrastructure (PKI)
1. Server and client agree on a symmetric session key encrypted by the client with a server's public key
1. Session key is transmitted over the network to the server.
1. The server uses its private key to decrypt the session key.

It bypasses the weakness of symmetric encryption by using asymmetric encryption to transmit the symmetric key. But, has several problems.

Transport layer security (TLS) - [[SSL-TLS]]

Use `openssl` for SSL/TLS workflow
```bash
# Generate a certificate
openssl req -new -nodes -newkey rsa:4096 -keyout key.pem -out cert.csr
# req -new create a new certificate signing request
# -nodes save private key without a passphrase
# -newkey generate a new private key
# rsa:4096 generate an RSA key of size 4096 bits
# -keyout specify where to save the key
# -out save the certificate signing request
#
# Create a self-signed certificate
openssl req -x509 -newkey -nodes rsa:4096 -keyout key.pem -out cert.pem -sha256 -days 365
# View this certificate
openssl x509 -in cert.pem -text
```


## Ciphers

#### Block Ciphers

Algorithm that use a dimensional array to encrypt data

#### Stream Ciphers

Algorithm that use a 1 dimensional array to encrypt data

#### Caesar Ciphers

ROT-13 with tr
```bash
tr 'A-Za-z' 'N-ZA-Mn-za-m' # encode
tr 'N-ZA-Mn-za-m' 'A-Za-z' # decode
```

#### XOR Cipher

Xor cipher is based off the bitwise XOR operation.
A xor 0  = A
A xor A = 0
A xor B = B xor A
(A xor B) xor C = A xor (B xor C)
(B xor A) xor A = B xor 0 xor B

XOR Cipher Trace Table 

Plaintext | Key | Ciphertext
--- | --- | ---
0 | 0 | 0
0 | 1 | 1
1 | 0 | 1
1 | 1 | 0 

#### Blowfish

64 bit block cipher 
```bash
gpg -c --cipher-algo blowfish blowfish.plain
gpg --decrypt blowfish.plain.gpg
```


## References

[THM Room Introduction to Cryptography](https://tryhackme.com/room/cryptographyintr)
[Public Key Cryptography - Computerphile](https://www.youtube.com/watch?v=GSIDS_lvRv4)
[AES Explained (Advanced Encryption Standard) - Computerphile](https://www.youtube.com/watch?v=O4xNJsjtN6E)
[Encryption & Entropy - Computerphile](https://www.youtube.com/watch?v=8VSuwDG4bhw)
[Wikipedia - AES](https://en.wikipedia.org/wiki/Advanced_Encryption_Standard)
[Wikipedia Discrete log problem](https://en.wikipedia.org/wiki/Discrete_logarithm)
[RFC2104](https://www.rfc-editor.org/rfc/rfc2104) 
