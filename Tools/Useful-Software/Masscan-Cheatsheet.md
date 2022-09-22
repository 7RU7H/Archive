# Masscan Cheatsheet

Beware you cannot use [[Proxies]] with masscan as it has its own TCP Stack.

```bash
sudo masscan -p0-65535 -oG masscan.log --rate=$beware -e $interface $ip/cidr
```