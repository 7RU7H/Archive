# Password Files

Important password file paths on Linux:
```bash
/etc/passwd
/etc/shadow

# /etc/pam.d/common-password - password-related modules common to all services
/etc/pam.d/common-password

# This file is included from other service-specific PAM config files,
# and should contain a list of modules that define the services to be
# used to change user passwords.  The default is pam_unix.
```

Important password file paths on Windows:
```powershell
C:\Windows\System32\config\*SAM
```

## References

[THM Room Introduction to Cryptography](https://tryhackme.com/room/cryptographyintr)
[github.com/FusionAuth/security-scripts - ubuntu-16.04/common-password](https://github.com/FusionAuth/security-scripts/blob/main/template/ubuntu-16.04/common-password)