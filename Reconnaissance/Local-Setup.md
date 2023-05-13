
Everything is connected, but for you connect to it you need setup your connections to external networks and potential their internal networks


DNS for [[Active-Directory-Footholding]] Or [[DNS-Active-Recon]] and [[DNS-Recon-Passive]]
```bash
# AD 
echo "$IP domain.tld subdomain" | sudo tee -a /etc/hosts
# Web 
echo "$IP domain.tld subdomain.domain.tld subdomain.domain.tld" | sudo tee -a /etc/hosts
```