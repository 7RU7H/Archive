# TryHackMe


Fix openvpn key error: `OPTIONS ERROR: failed to negotiate cipher with server.  Add the server's cipher ('AES-256-CBC') to --data-ciphers (currently 'AES-256-GCM:AES-128-GCM:CHACHA20-POLY1305') if you want to connect to this server.` 
```bash
sed -i 's/cipher AES-256-CBC/data-ciphers AES-256-CBC/' *.ovpn
```