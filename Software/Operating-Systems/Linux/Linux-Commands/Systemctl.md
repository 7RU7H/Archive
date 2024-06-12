# `systemctl`

The `systemctl` command is used for Service Management on some Linux distributions.. [[journalctl]] is used for log manipulation, monitoring, etc. Normally `x.service` is in the `/etc/systemd/system/` directory.
```bash
systemctl status <service>
systemctl enable <service>
systemctl disable <service>
systemctl restart <service>
systemctl start <service>
systemctl stop <service>

# System Commands:
is-system-running # Check whether system is fully running
default # Enter system default mode
rescue # Enter system rescue mode
emergency # Enter system emergency mode
halt # Shut down and halt the system
poweroff # Shut down and power-off the system
reboot # Shut down and reboot the system
kexec # Shut down and reboot the system with kexec
exit [EXIT_CODE] #Request user instance or container exit
switch-root ROOT [INIT] # Change to a different root file system
suspend # Suspend the system
hibernate # Hibernate the system
hybrid-sleep # Hibernate and suspend the system suspend-then-hibernateSuspend the system, wake after a period of time, and hibernate



# Use `systemctl` to iterate and query all the services on the system
systemctl list-units --all --type=service
# q to exit
# Same as above but only running services
systemctl list-units --type=service --state=running
```

Example of what the configuration for a service looks sort of like:
```bash
[Unit]
Description=Description goes here
After=network.target

[Service]
Type=simple
ExecStart=/path/to/binary/or/script
Restart=always

[Install]
WantedBy=multi-user.target
```

Starting
```bash
sudo systemctl start application.service

# or simply

sudo systemctl start application
```
Stopping
```bash
sudo systemctl stop application.service
```
Restarting and Reloading
```bash
sudo systemctl restart application.service
```
If the application in question is able to reload its configuration files (without restarting), you can issue the reload command to initiate that process:
```bash
sudo systemctl reload application.service
```
Enabling and Disabling Services

The above commands are useful for starting or stopping commands during the current session.
``` bash
sudo systemctl enable application.service
sudo systemctl disable application.service
```
Checking the Status of Services
```bash
systemctl status application.service
systemctl is-active application.service
systemctl is-enabled application.service
systemctl is-failed application.service
```
Verify a service file
```bash
sudo systemd-analyze verify application.service
```
Following the logs for those services
```bash
sudo journalctl -u application.service
```

Use `systemctl` to iterate and query all the services on the system
```bash
systemctl list-units --all --type=service
```


## References

[THM Linux Process Analysis Room](https://tryhackme.com/r/room/linuxprocessanalysis)