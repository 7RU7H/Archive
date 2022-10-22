Kali uses `systemd` as its init system; [Wikipedia init](https://en.wikipedia.org/wiki/Init) *"in Unix-based computer operating systems, init is the first process started during booting of the computer system. Init is a daemon process that continues running until the system is shut down.*"*

`systemd` can be queried and controlled with `systemctl`, which without arguements  `systemctl` output a list of active units. Each services is represented by a service unit described by a service file usually shipped in `/lib/systemd/system/` (or `/run/systemd/system/`, or `/etc/systemd/system/`. In which ever directory the service unit is shipped it can be modified with `service-name.service.d/*.conf` file while the unit files are in plain text, using a key-value pair( `key = value` ), grouped between `[section]` headers  similiar to Windows `*.ini` files. For example:
```
# Contents of /etc/systemd/system/myservice.service
[Unit]
Description=My Service
After=network.target

[Service]
EnvironmentFile=-/etc/default/myservice
Type=simple
Restart=on-failure
ExecStart=/usr/local/bin/myservice
ExecReload=/bin/kill -HUP $MAINPID

[Install]
WantedBy=multi-user.target
Alias=myservice.service
```
[Debian Documentation on Systemd Services](https://wiki.debian.org/systemd/Services), modified for more explainatory purposes. Target units group dependencies on other unit and represent a *desired* state of activated units. From system boot:
1. Enables the units required to reach the `default.target` - symlinked to `graphical.target`, which is dependent on `multi-user.target`
2. Dependencies are expressed with `Wants` directive on target unit
	- User is not required to edit the target unit to add new dependencies 
	- User can create a symlink pointing to the dependent unit in the `/etc/systemd/system/target-name.target.wants/`
		- This is what `systemctl enable x.service` does
		- `systemctl disable x.service` drops the dependency 


## `systemd` - `systemctl` Commands

```bash
systemctl list-units # Same as systemctl without arguments
systemctl status # hierarchial overview of running servies
systemctl enable x.service # Influences next boot 
systemctl disable x.service # Influences next boot 
systemctl start x.service
systemctl stop x.service
systemctl status x.service # Current status - includes the latest lines of the associated log
systemctl reload x.service
systemctl restart x.service
```



## References

[Wikipedia init](https://en.wikipedia.org/wiki/Init)
[Debian Documentation on Systemd Services](https://wiki.debian.org/systemd/Services)