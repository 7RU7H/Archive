# Padding Oracle Attack

Padding in cryptography is a obfuscation technique that also has to deobfuscated by decrypting Cryptographic Algorithm. It is an attempt to create variation in cipher text (symbol usage, cipher and clear text lengths, etc) to prevent Hash Identification to narrow down targets for Brute Force Decryption.

[Wikipedia - Padding Oracle Attack](https://en.wikipedia.org/wiki/Padding_oracle_attack) : *"In cryptography, a padding oracle attack is an attack which uses the [padding](https://en.wikipedia.org/wiki/Padding_(cryptography) "Padding (cryptography)") validation of a cryptographic message to decrypt the ciphertext. In cryptography, variable-length plaintext messages often have to be padded (expanded) to be compatible with the underlying [cryptographic primitive](https://en.wikipedia.org/wiki/Cryptographic_primitive "Cryptographic primitive"). The attack relies on having a "padding [oracle](https://en.wikipedia.org/wiki/Oracle_machine "Oracle machine")" who freely responds to queries about whether a message is correctly padded or not."* - Requires [[Side-Channels-Attacks]] or direct exposure to the information.

[Wikipedia - POODLE](https://en.wikipedia.org/wiki/POODLE) - Padding Oracle On Downgraded Legacy Encryption, where the vulnerability occurred due to the fallback to SSL 3.0 ([[SSL-TLS]]), where SSL 3.0 could be requested leak data. More exactly, rephrasing [GitHub - flast101/padding-oracle-attack-explained](https://github.com/flast101/padding-oracle-attack-explained#5--padding-oracle-attack) only *"256 SSL 3.0 requests to reveal one byte of encrypted messages.*" if *"able to obtain a response from the server"*, which *"will serve as an Oracle*"... data used to perform future transformations on other data to some end result ...". This will allow an attack to be *able to decrypt the entire message except the first block, unless we know the initialization vector.* The mitigation: do not use this version of SSL - disable SSL 3.0.b

## References

[Wikipedia - Padding Oracle Attack](https://en.wikipedia.org/wiki/Padding_oracle_attack) 
[GitHub - flast101/padding-oracle-attack-explained](https://github.com/flast101/padding-oracle-attack-explained#5--padding-oracle-attack)
[Wikipedia - POODLE](https://en.wikipedia.org/wiki/POODLE) 