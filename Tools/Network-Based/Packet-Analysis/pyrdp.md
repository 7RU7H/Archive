# pyrdp


[pyrdp](https://github.com/GoSecure/pyrdp) *RDP monster-in-the-middle (mitm) and library for Python with the ability to watch connections live or after the fact.*

- RDP Monster-in-the-Middle
    - Logs plaintext credentials or NetNTLM hashes used when connecting
    - Steals data copied to the clipboard
    - Saves a copy of the files transferred over the network
    - Crawls shared drives in the background and saves them locally
    - Saves replays of connections so you can look at them later
    - Runs console commands or PowerShell payloads automatically on new connections
- RDP Player:
    - See live RDP connections coming from the MITM
    - View replays of RDP connections
    - Take control of active RDP sessions while hiding your actions
    - List the client's mapped drives and download files from them during active sessions
- Converter tool:
    - Convert RDP replays to videos for easier sharing
    - Convert RDP replays to a sequence of low-level events serialized in JSON format
    - Convert PCAPs to replays, videos or JSON events
    - Convert decrypted PCAPs (L7 PDUs) to replays, videos or JSON events
- RDP Certificate Cloner:
    - Create a self-signed X509 certificate with the same fields as an RDP server's certificate


Requires decrypted [[RDP]] traffic in a .pcap file format - try [[Wireshark]] and [[Decrypting-RDP-From-Pcap]].

```bash
python3 -m venv 
source 
cd pyrdp/
pip install .
cd ../
python pyrdp-convert.py --list-only ../rdp_pdus.pcap
python3 pyrdp/pyrdp/bin/convert.py -o py_rdp_output rdp_pdu.pcap
# Then use docker to view the rdp playback
sudo docker run -v "$PWD/py_rdp_output:/pwd" -e DISPLAY=$DISPLAY -e QT_X11_NO_MITSHM=1 --net=host gosecure/pyrdp pyrdp-player
#  Open the `/pwd` folder
```

## References

[GitHub - pyrdp](https://github.com/GoSecure/pyrdp)