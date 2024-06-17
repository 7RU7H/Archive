# (De|En)cryption

For definitions and concepts try here: [[Cryptography]]

## `gpg` and others...

[ubuntu - GnuPrivacyGuardHowto](https://help.ubuntu.com/community/GnuPrivacyGuardHowto) helps with terminological distinctions required:
- **OpenPGP** is technically a _proposed standard_, although it is widely used. OpenPGP is not a program, and shouldn't be referred to as such. PGP and GnuPG are computer programs that implement the OpenPGP standard.
- **PGP** is an acronym for Pretty Good Privacy, a computer program which provides cryptographic privacy and authentication. For more information, see this [Wikipedia](http://en.wikipedia.org/wiki/Pretty_Good_Privacy) article.
- **GnuPG** (aka **GPG**) is an acronym for GNU Privacy Guard, another computer program which provides cryptographic privacy and authentication. For further information on GnuPG, see this [Wikipedia](http://en.wikipedia.org/wiki/GNU_Privacy_Guard) article.

[GnuPG or GPG](https://gnupg.org/) is an Open Source implementation of PGP from the GNU project.
```bash
# Decrypt a file with a GPG key
gpg --import $key.$file
gpg -d $filetodecrypt.file

# Change Passphrase for a key
gpg --edit-key <key-id>
# Backup keys
gpg -ao $somekey.kay --export <key-id>

# Generate a key - display menu and slection process
gpg --gen-key

# Encryption capabilities for RSA sign only 
gpg --cert-digest-algo=SHA256 --edit-key $GPGKEY

# Create a revocation certificate to revoke a certificate you want change to another
gpg --output revoke.asc --gen-revoke $GPGKEY

# Create ASCII armored version of your public key
gpg --output mykey.asc --export --armor $GPGKEY

# Restart the gpg-agent
killall -q gpg-agent
eval $(gpg-agent --daemon)
# set a default gpg for session
export GPGKEY=$HEXKEY

gpg -c --cipher-algo aes256 aes256.plain
gpg --decrypt aes256.plain.gpg

gpg -c --cipher-algo blowfish blowfish.plain
gpg --decrypt blowfish.plain.gpg

gpg --import public.key


# Keys Signing
# List your private keys
gpg --list-secret-keys
gpg --recv-keys $key_hex 
gpg --sign-key $key_hex 
gpg --armor --export $key_hex --output $file.asc
gpg --send-keys $key_hex --keyserver $server
gpg --import $key_hex-signed-by.someone.asc

# Restoring a keypair
gpg --import $public.key
gpg --import $private.key

# Revoke a keypair
gpg --gen-revoke $key_hex > revoke.asc
# Import your revocation certificate:
gpg --import revoke.asc
# Then upload to keyserver
gpg --send-keys $key_hex --keyserver $server

# Un-revoke a keypair 
gpg --export <key-id> > key.gpg
gpgsplit key.gpg # Split key
# find which file contains the revocation certificate. In most cases, it is 000002-002.sig, however you should make sure by using the following. If the sigclass is 0x20, you have the right file. Delete it.
gpg --list-packets 000002-002.sig 
# Fix key 
cat 0000* > fixedkey.gpg
# Remove old key
gpg --expert --delete-key key-id
gpg --import fixedkey.gpg
#
#
# Example of not having the public key?
gpg --keyid-format long --verify SHA256SUMS.gpg SHA256SUMS
# No public key
gpg --keyid-format long --keyserver hkp://keyserver.ubuntu.com --recv-keys 0x$KEYinAbove
# You can now inspect the key fingerprints by running:
gpg --keyid-format long --list-keys --with-fingerprint 0x$KEYinAbove
# I have tested with and without 0x and both work..
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
[Ubuntu Tutorials](https://ubuntu.com/tutorials/how-to-verify-ubuntu#4-retrieve-the-correct-signature-key)