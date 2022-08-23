
# Linux Tricks

## /etc/hosts management for Hackers
```bash
sudo cp /etc/hosts /etc/hosts.bak
sudo echo "$IP $DOMAINSTR" | sudo tee -a /etc/hosts
# Revert to clean
sudo cat /etc/hosts.bak > /etc/hosts.bak
```