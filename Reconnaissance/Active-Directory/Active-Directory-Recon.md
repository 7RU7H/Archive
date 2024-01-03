# Active Directory Recon


#### [[Local-Setup]] issues

`/etc/hosts` should always have `$dcName...` first!
```bash
echo "$IP $dcName.$domain.$tld $domain.$tld" | sudo tee -a /etc/hosts
```