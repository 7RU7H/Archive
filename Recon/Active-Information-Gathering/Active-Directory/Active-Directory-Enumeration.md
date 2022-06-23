# Active Directory Enumeration

For exploitation see [[AD-Exploitation-Hub]] or general theory and definitions [[Active-Directory-Defined]]. For commands cheatsheet [[Active-Directory-Commands]] or for Privilege Escalation see [[Active-Directory-Privilege-Escalation]].

## Microsoft Management Console
If access to RDP you can enumerate with Microsoft Management Console (MMC) with the [Remote Server Administration Tools'](https://docs.microsoft.com/en-us/powershell/module/activedirectory/?view=windowsserver2022-ps) (RSAT) AD Snap-Ins
1.  Press **Start**
2.  Search **"Apps & Features"** and press enter
3.  Click **Manage Optional Features**
4.  Click **Add a feature**
5.  Search for **"RSAT"**
6.  Select "**RSAT: Active Directory Domain Services and Lightweight Directory Tools"** and click **Install**

## References
[THM Enumerating AD room](https://tryhackme.com/room/adenumeration)
[Remote Server Administration Tools'](https://docs.microsoft.com/en-us/powershell/module/activedirectory/?view=windowsserver2022-ps)