# Linux DNS Configuration

# Targeting DNS 

#### File editing
Edit the `/etc/systemd/resolved.conf`, uncomment the `#DNS=` by remove ing the `#` symbol and enter the IP address to resolve, for [[Active-Directory-Enumeration]] and  [[Active-Directory-Footholding]] set this IP to the most front facing DC's IP. Use `systemctl restart systemd-resolved` to restart the local service and use `nslookup <domain>` to test that DNS is working.

#### Network Manager
Network Manager:
1. GUI: `Network Manager -> Advanced Network Configuration -> Your Connection -> IPv4 Settings`
1. Set your DNS IP here as recommended above
1. Add another DNS such as 1.1.1.1 or similar to ensure you still have internet access
1. `sudo systemctl restart NetworkManager` and test with `nslookup <domain>` 
