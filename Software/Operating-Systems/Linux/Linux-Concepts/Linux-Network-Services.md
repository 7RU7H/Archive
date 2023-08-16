# Network Services

!!KALI DOES NOT USE SysV init

SysV init == Legacy; Systemd == Backwards compatible with SysV init

## Runlevels

Runlevels are designations set to how a linux system starts and what services are running.
```bash
runlevel/
```


Runlevel 0 	OFF, called on to execute system shutdown
Runlevel 1 AKA:	Single User Mode: Networking disabled, cli for root can into the system to conduct admin tasks:
Runlevel 2 AKA: Multiuser Mode: Networking disabled and cli is used
Runlevel 3 AKA: Multiuser Mode with Networking: cli is used
Runlevel 4 AKA: Undefined Mode BY DEFAULT: custom runlevel if required
Runlevel 5 AKA: Multiuser Mode with GUI: Networking enabled - default runlevel on any linux disto with a GUI
Runlevel 6	restart the linux host, called to execute a system restart

## SysV Init

Default Runlevel configuration file: /etc/inittab
Each runlevel will have a respective /etc/rc#.d/ directory associated with it. 
This is used to add the services that will be started for that runlevel in the form of scripts.
The service scripts are located, by default on a SysV Init system in: /etc/init.d/
```bash
service <arg> <service-name>  
```

###  Systemd (systemctl)

Systemd uses a utility called systemctl like service for SysV Init
```bash
systemctl <arg> <service-name>
stop 		will stop a service.
status		will show the running status of a service.
reload 		will reload the configuration files for a service without the need to stop the service.
enable/disable 	will mark the service to run at a system boot or not.
```

Regarding /etc/rc#.d/:
Systemd improved upon this design through the utilization of target-units.
Target-units are like runlevels:
	Define what services run at aeach target-unit level
	Can define more than 7 classifications
# IMPORTANT:	
*Target-units and services can be found in /usr/lib/systemd/system/*

These files are made up of UNIT, SERVICE, INSTALL; each with variables like Documentation=man:blah_config();KillMode=process; WantedBy=multi-user.target		
```bash
sudo systemctl list-units --type=target --all
```

LOAD   = Reflects whether the unit definition was properly loaded.
ACTIVE = The high-level unit activation state, i.e. generalization of SUB.
SUB    = The low-level unit activation state, values depend on unit type.


# ssh Server:
```bash
netstat -antp | grep sshd
systemctl enable ssh
systemctl disable ssh
```

# http Server:
systemctl
```bash
netstat -antp | grep apache
systemctl start apache2
systemctl stop apache2
```
with python
```python
python -m SimpleHTTPServer 1234
python3 -m http.server 1234
```

# ftp Server
```bash
sudo apt update && sudo apt install pure-ftpd
cat ./setup-ftp.sh
chmod +x setup-ftp.sh
sudo ./setup-ftp.sh
```
