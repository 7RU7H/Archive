## Cryptography Glossary

AES: 128-bit symmetric-key block cipher with three fixed key size variants.

Asymmetric encryption: Model of encryption that uses the recipient's public key to encrypt a message, and the recipient's private key to decrypt a message.

Attestation: [OWASP Cryptography](https://owasp.org/www-project-developer-guide/draft/foundations/crypto_principles/): *"Attestation is the act of “bearing witness” or certifying something for a particular use or purpose."*

Bit: The smallest unit of binary data. Must be either 0 or 1.

[Blinding](https://en.wikipedia.org/wiki/Blinding_(cryptography)) is a technique to mitigate [[Side-Channel-Attacks]] by obfuscating or encoding input to some other compute that does not strictly know the input.

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

Entropy: The amount of unpredictability in a given cipher text. Entropy colloquially refers to how close the cipher text is to ideal randomly generated text.

Fundamental Theorem of Arithmetic: The mathematical statement that every natural number greater than 1 must be either prime or a product of unique prime factors. Forms the basis of many asymmetric cryptography implementations.

Hash: The output of a hashing algorithm. Synonym for "digest".

Hashing algorithm: A one-way function that takes arbitrary input and produces fixed-length output, such that every unique input produces unique output with very high probability.

MD5: Widely used hashing function that produces a 128-bit digest. Although MD5 was initially designed to be used as a cryptographic hash function, it has been found to suffer from extensive vulnerabilities. It can still be used as a checksum to verify data integrity.

Nibble: Four bits of binary data. There are 16 (2^4) potential values.

Plain text: Human-legible text. Can be transformed into cipher text via an encryption algorithm.

Salt: A string appended to a password to create a unique digest when run through a hashing algorithm.

Stream Cipher: An encryption algorithm that operates on one bit of plaintext at a time. Contrast with Block Cipher.

Substitution Cipher: An encryption algorithm that operates by replace each character of a plain text set of characters with another, the key would be the rotation or identifier for character sets that replace the plain text.

Symmetric-key encryption: Model of encryption that uses the same shared key for both encryption and decryption.

Transposition cipher: Rearranges the order of the characters of a plain text by key the ordering of encrypted output.


## References

[THM Room Introduction to Cryptography](https://tryhackme.com/room/cryptographyintr)
[OWASP Cryptography](https://owasp.org/www-project-developer-guide/draft/foundations/crypto_principles/)