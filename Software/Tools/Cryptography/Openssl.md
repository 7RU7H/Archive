# `openssl`




```bash
# Use xxd to format string to plain hexdump style with 0 octets
echo $Key | base64 -d | xxd -p -c 0
echo $IV | base64 -d | xxd -p -c 0
openssl enc -$algorithm -d -in $encrypted.$file -out $decrypted.$file -K $Key -iv $IV
```