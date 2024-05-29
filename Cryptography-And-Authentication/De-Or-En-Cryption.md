# (De|En)cryption

For definitions and concepts try here: [[Cryptography]]

## `gpg`

[GnuPG or GPG](https://gnupg.org/) is an Open Source implementation of PGP from the GNU project.
```bash
killall gpg-agent

gpg -d filetodecrypt
gpg --import key.file

gpg -c --cipher-algo aes256 aes256.plain
gpg --decrypt aes256.plain.gpg

gpg -c --cipher-algo blowfish blowfish.plain
gpg --decrypt blowfish.plain.gpg

gpg --import public.key
```

Have no public key?
```bash
gpg --keyid-format long --verify SHA256SUMS.gpg SHA256SUMS
# No public key
gpg --keyid-format long --keyserver hkp://keyserver.ubuntu.com --recv-keys 0x$KEYinAbove
# You can now inspect the key fingerprints by running:
gpg --keyid-format long --list-keys --with-fingerprint 0x$KEYinAbove
# I have test with and without 0x and both work..
```
[Best simple way of explaining GPG-age from Ubuntu Tutorials](https://ubuntu.com/tutorials/how-to-verify-ubuntu#4-retrieve-the-correct-signature-key)
## `openssl`
```bash

openssl genrsa -aes256 -out private.key 8912
openssl rsa -in private.key -pubout -out public.key
openssl rsautl -encrypt -pubin -inkey public.key -in plaintext.txt -out encrypted.txt
openssl rsautl -decrypt -inkey private.key -in encrypted.txt -out plaintext.txt

# openssl passwd  
# -6                  SHA512-based password algorithm
# -5                  SHA256-based password algorithm
# -writerand outfile  Write random data to the specified file
# -salt val           Use provided salt
```

## `ssh-keygen`
```bash
ssh-keygen
ssh-copy-id -i /.ssh/id_rsa.pub kali@localhost # send to remote server
ssh -i .ssh/id_rsa kali@localhost # logon to remote server with key
```


## Cracking Files
Consider [[Cracking-Files]]

Weird string in a file? Screenshot each! Retain originals
```bash
file $file 
cp $file $file.bak
cat $file # beware escape characters for the terminal
```

## Cryptogram solving

[quipqiup](https://www.quipqiup.com/) *"a fast and automated cryptogram solver by [Edwin Olson](http://april.eecs.umich.edu/people/ebolson). It can solve simple substitution ciphers often found in newspapers, including puzzles like cryptoquips (in which word boundaries are preserved) and patristocrats (inwhi chwor dboun darie saren t).*"*

## References

[quipqiup](https://www.quipqiup.com/) 
[THM Encryption 101 Room](https://tryhackme.com/r/room/encryptioncrypto101)
[THM Intro to Cryptography Room](https://tryhackme.com/r/room/cryptographyintro)
[THM Linux Strength Training Room](https://tryhackme.com/r/room/linuxstrengthtraining)