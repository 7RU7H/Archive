# Cryptography 

- Note Split out

For a list of commands related to cryptography try here: [[De-Or-En-Cryption]]

## Glossary

AES: 128-bit symmetric-key block cipher with three fixed key size variants.

Asymmetric encryption: Model of encryption that uses the recipient's public key to encrypt a message, and the recipient's private key to decrypt a message.

Bit: The smallest unit of binary data. Must be either 0 or 1.

Block Cipher: An encryption algorithm that operates on a group of bit at once rather than only one bit at a time. Contrast with Stream Cipher.

Blowfish: 64-bit symmetric-key block cipher with variable key size.

Byte: Eight bits of binary data. There are 256 (2^8) potential values.

Cipher text: Text that has been transformed into an unreadable message via some encryption algorithm.

Clear text: Human-legible text. Can be transformed into cipher text via an encryption algorithm. Synonym of "plain text".

Cryptographic key: A string of bits used by a cryptographic algorithm to transform plain text into cipher text or vice versa.

Decoding: The opposite of encoding.

Decryption: The opposite of encryption.

Digest: The output of a hashing algorithm. Synonym for "hash".

Encoding: A means of transforming data from one format to another.

Encryption: The process of scrambling data or messages, making it unreadable and secret.

Entropy: The amount of unpredictability in a given ciphertext. Entropy colloquially refers to how close the ciphertext is to ideal randomly generated text.

Fundamental Theorem of Arithmetic: The mathematical statement that every natural number greater than 1 must be either prime or a product of unique prime factors. Forms the basis of many asymmetric cryptography implementations.

Hash: The output of a hashing algorithm. Synonym for "digest".

Hashing algorithm: A one-way function that takes arbitrary input and produces fixed-length output, such that every unique input produces unique output with very high probability.

MD5:1 Widely used hashing function that produces a 128-bit digest. Although MD5 was initially designed to be used as a cryptographic hash function, it has been found to suffer from extensive vulnerabilities. It can still be used as a checksum to verify data integrity.

Nibble: Four bits of binary data. There are 16 (2^4) potential values.

Plain text: Human-legible text. Can be transformed into cipher text via an encryption algorithm.

Salt: A string appended to a password to create a unique digest when run through a hashing algorithm.

Stream Cipher: An encryption algorithm that operates on one bit of plaintext at a time. Contrast with Block Cipher.

Substitution Cipher: An encryption algorithm that operates by replace each chracter of a plaintext set of characters with another, the key would be the rotation or identifier for character sets that replace the plain text.

Symmetric-key encryption: Model of encryption that uses the same shared key for both encryption and decryption.

Transposition cipher: Rearranges the order of the characters of a plain text by key the ordering of encrypted output.


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
md5sum
shasum
sha256
sha512sum
```

Important password file paths:
```
/etc/passwrd
/etc/shadow
/etc/pam.d/commonc-pasword

C:\Windows\System32\config\*SAM
```


## Password Hashing Algorithms

Where hashing is often used to protect the integrity of data. 
[Hashcat Examples is your friend](https://hashcat.net/wiki/doku.php?id=example_hashes)
```bash
john --list=foramt | grep
```
- Or try tools like `hashid`, `hash-identifier`, `haiti`
- Or a site like [Crackstation](https://crackstation.net/), if your are working for an organisation get permission before trying hashes against any online rainbow table.

#### Salt

A salt is an preferably random, nuique generated string, it mixed with cleartext input, then the hash is calculated for the mixed string. It is useful as the same password will produce the same hash, so to store user passwords with the potential for same password use can be avoid with salting.Salting protects against rainbow table attacks.o

Hashing passwords:
```
import hashlib
string = "saltedpassword"
hashlib.sha256(string.encode()).hexdigest()
```
Unix has different variations of mkpasswd
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

## Symmetric-Key Encryption

Symmetic Key Algorithms use the same key for encrypting the plaintext into ciphertext and for decrypting the ciphertext back into plaintext. Key is sometimes "passphrase" synonymous with "key". Maintaining the key's secrecy is vital, if public anyone can decrypt with it - harms confidentiality as transmission of the key not the data is the issue.

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

## Asymmetric Encryption

Asymmetric encryption can solve integrity, authenticity and nonrepudiation

Theory
- Public key to distribute 
- Private key is kept confidential
- `$A` (Holds prviate to decrypt, and public key to distribute) ` -> exchange  ->` `$B` (Holds public key to encrypt) 
```bash
gpg --gen-key
gpg --output example-pub.asc --armor --export Offsec # armor flag for output being in ASCII

echo "Asymmetric encryption example" > asymmetry.txt
gpg --recipient Offsec --encrypt asymmetry.txt
# transfer file
gpg --decrypt asymmetry.txt.gpg # requires passphrase

```
It can sometimes be tricky to recall who has to use which keys to encrypt and decrypt messages with asymmetric encryption. We can use the following mnemonics to help us remember: 
SUPER 
1. S = Sender 
1. U = Uses 
1. P = Public
1. E = Encryption-key of 
1. R = Receiver.

```goat
Alice -> Bob
1. Alice encrypts with Bob's public key
2. Bob decrypts with Bob's private key
Bob  -> Alice
1. Bob encrypts with Alice's public key
2. Alice decrypts with Alice's private key
```

Asymmetric key-pairs can also be used to sign and verify messages.
A will sign the message with private key and B verifies it with the public key - Signing != sending the private key!!

#### Asymmetric Encryption Mathematics

RSA got its name from its inventors, Rivest, Shamir, and Adleman

Prime Factorisation:
```bash
x * y = z # z being the unqiue product of two prime numbers, so for:
primes={p,q}
product=n

# Using n as base:
# Perform additional maths to output two special numbers e and d 
# !! such that their properties are relative to n
# Public key as a:
tuple(n,e)
# Private key as a: 
tuple(n,d)

# THM - to see real values for p and q:
# Generate a RSA
openssl genrsa -out private-key.pem 2048
# Using RSA make public key from private key
openssl rsa -in private-key.pem -pubout -out public-key.pem
# For the values of:
# p, q, n, e, d := prime1, prime2, modulus, publicExponent, publicExponent
# in the following command
openssl rsa -in private-key.pem -text -noout
```

#### Asymmetric Encrypted Bind Shells

Encrypted communication rely on the Secure Sockets Layer(SSL)

```bash
openssl req -newkey rsa:2048 -nodes -keyout bind_shell.key -x509 -days 30 -out bind_shell.crt

# req = create a new certificate
# -newkey generate a new private key
# rsa:2048 defines the encryption algorithm we want to use. This is similar to the --cipher-algo flag used by gpg. In this case, we're using the RSA algorithm with a 2048-bit key length.
# -nodes create the private key without a passphrase
# -key save the generated private key to an output file in Base64 format.
# -x509 ensures that our certificate is self-signed; an  alternative is to use an existing certificate authority
# -days certificate is valid for
# -out saves the certificate to file, also in Base64 format
# This creates a bind_shell.crt(certificate) and bind_shell.key(private key)

socat OPENSSL-LISTEN:443,cert=bind_shell.pem,verify=0,fork EXEC:/bin//bash

# Host certificate with socat 

socat - OPENSSL:$IP:$PORT,verify=0 <cmd>
```

#### SSL and HTTPS

SSL encryption procedures leverage both asymmetric and symmetric encryption. 
1. Server and client agree on a symmetric session key encrypted by the client with a server's public key
1. Session key is transmitted over the network to the server.
1. The server uses its private key to decrypt the session key.

It bypasses the weakness of symmetric encryption by using asymmetric encryption to transmit the symmetric key. But, has several problems.

Transport layer security(TLS) - [[TLS-SSL]]

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
[Secret Key Exchange (Diffie-Hellman) - Computerphile](https://www.youtube.com/watch?v=NmM9HA2MQGI)
[Wikipedia - AES](https://en.wikipedia.org/wiki/Advanced_Encryption_Standard)