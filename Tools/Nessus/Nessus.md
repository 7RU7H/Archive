# Nessus

## Installing Nessus
[Find the appropriate version for your operating system](https://www.tenable.com/downloads/nessus), checksum the version with `sha256sum <Nessus>` and finally follow the relevant installation instruction for your OS. For  Kali:

```bash
sudo apt install ./<path and version of Nessus>
# Depending on version either:
sudo /bin/systemctl start nessusd.service
sudo /etc/init.d/nesssusd start
# goto https://localhost:8834
# Add exception for Nessus Certificate -> Confirm security exception
# Select deploy option
# Activation stuff...
```

## Scanning with Nessus
Provide a name and Target `<IP>`

Under the `Settings -> Discovery tab -> custom configuration of Host discovery, Port scanning and Service discovery` is avaliable.

Scanning with a specific plugin  `Plugins -> Enable/Disable`