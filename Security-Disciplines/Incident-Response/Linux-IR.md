# Linux IR

```bash
crontab -l

# list services with systemctl looking for enabled services
# 
systemctl list-unit-files | grep enabled

systemctl status $badservice
systemctl stop $badservice
# Check if it is actually stopped as it could be being continuously respawned
systemctl status $badservice
```

## References

[THM Advert of Cyber 2023](https://tryhackme.com/room/adventofcyber2023)