# Decrypting RDP From Pcap 

[seguranca - Extraction certs/private keys from Windows using mimikatz and intercepting calls with burpsuite](https://gitbook.seguranca-informatica.pt/credentials-exfiltration/extracting-certs-private-keys-from-windows-using-mimikatz-and-intercepting-calls-with-burpsuite)

```bash
openssl pkcs12 -in $file.pfx -nocerts -out $key.pem -nodes
openssl rsa 0in $key.pem -out $key.key
```
In WireShark:`Edit -> Preferences→Protocols -> TLS→Edit… (RSA keys list)`
- IP 
- Set protocol to `tpkt` and the port to `3389`
- Add the `$key.key` file above

With a `rdp` as the filter export a **pcap** file  
- `File -> Export PDUs to File...`, under `Display filter:` type `rdp` and select `OSI layer 7`
Then use [[pyrdp]] and [[Docker]] running the [[pyrdp]] player.
```bash
python3 -m venv 
source 
cd pyrdp/
pip install .
cd ../
python pyrdp-convert.py --list-only ../rdp_pdus.pcap
python3 pyrdp/pyrdp/bin/convert.py -o py_rdp_output rdp_pdu.pcap
# Then use docker to view the rdp playback
sudo docker run -v "$PWD/py_rdp_output:/pwd" -e DISPLAY=$DISPLAY -e QT_X11_NO_MITSHM=1 --net=host gosecure/pyrdp pyrdp-player`
```
## References

[seguranca - Extraction certs/private keys from Windows using mimikatz and intercepting calls with burpsuite](https://gitbook.seguranca-informatica.pt/credentials-exfiltration/extracting-certs-private-keys-from-windows-using-mimikatz-and-intercepting-calls-with-burpsuite)