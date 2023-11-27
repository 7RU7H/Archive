# `Systemctl`

The `systemctl` command is used for Service Management on some Linux distributions 

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
Following the logs dor those services
```bash
sudo journalctl -u application.service
```
