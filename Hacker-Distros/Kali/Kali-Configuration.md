# Kali Configuration

## Network Related

- **NetworkManager**
The default network configuration relies on DHCP to obtain an IP address, DNS server, and gateway. Must check _network-manager-*_ packages as some are not installed by default.

For introductory information about DNS visit: [[DNS-Defined]]. Base Kali has NetworkManager as a default DNS manager. To display current configuration of resolv.conf

```bash
cat /etc/resolv.conf
```

```bash
sudo systemctl restart NetworkManager
```


Singh's Alternative written about on [Singh's infrabytes blog](http://www.infrabytes.com/change-dns-in-kali) is `resolvconf`.

- **ifupdown**
`ifupdown` package contains  `ifup` and `ifdown`, which read definitions from the `/etc/network/interfaces` configuration file. They central at boot time in configuration of the network with the `/etc/init.d/networking` init script.
```bash
ifdown network-device # Deconfigure network device
# You can now modify /etc/network/interfaces
ifup network-device # Spin up network with any modifications that may have been made
# Directives
auto network-device # Automatically configure the network interface once it is available
iface <network-device> inet/inet6 <type> # configure interface when avaliable

``` 
For wireless interfaces, you must have the `wpasupplicant` package (included in Kali by default),

- **systemd-networkd**
[Systemd-networkd](https://wiki.archlinux.org/title/Systemd-networkd) *"is a system daemon that manages network configurations"*.  On Kali it is disabled by default it requires enabling and a symlink-ing the systemd-networkd DNS resolution file
To configure place `.network` files into `/etc/systemd/network/` directory. 

```bash
systemctl enable systemd-networkd
systemctl enable systemd-resolved
systemctl start systemd-networkd
systemctl start systemd-resolved
ln -sf /run/systemd/resolve/resolv.conf /etc/resolv.conf
```
- Alternatively - `/lib/systemd/network/` for packaged files or `/run/systemd/network/` for files generated at run-time. 

Beware lacks in integrated support for wireless networks.

## User and Group Management

Use `vipw` and `vigr` to edit to avoid accidental harm.
Important File and Location | Purpose
--- | --- 
`/etc/passwd` | list of users
`/etc/shadow` | encrypted passwords user
`/etc/group` | list of groups
`/etc/gshadow` | encrypted group passwords

`getent` command checks the system databases using the appropriate library functions that call the name service switch (NSS) modules configured in the `/etc/nsswitch.conf` file.

Command | Task | Configuration
--- | --- | ---
`adduser` | adds user | /etc/adduser.conf
`addgroup` | add group | /etc/group 
`delgroup` | delete group |
`groupmod` | modifiers a group information |
`gpasswd group` | add password for group |  
`gpasswd -r group` | deletes password for group |
`newgrp` | start new shell `sg` to executs a command using the suppplied alternate group | 
 `setgid` | set the `setgid` bit on a directory that causes all files to belong automatically to that group  |
`id` | current state of a user and its personal and group identifiers `uid` and `gid`  | 

Creation of an account triggers the populatiojn of the user's home directory with content sof `/etc/skel`. 

**Modification**
-   `passwd` —permits a regular user to change their password, which in turn, updates the `/etc/shadow` file.
-  `passwd -l $user`—Disables the account of the user.
-   `chfn`—(CHange Full Name), reserved for the super-user (root), modifies the `GECOS`, or "general information" field.
-   `chsh`—(CHange SHell) changes the user's login shell. However, available choices will be limited to those listed in `/etc/shells`; the administrator, on the other hand, is not bound by this restriction and can set the shell to any program chosen.
-   `chage`—(CHange AGE) allows the administrator to change the password expiration settings by passing the user name as an argument or list current settings using the `-l user` option. Alternatively, you can also force the expiration of a password using the `passwd -e user` command, which forces the user to change their password the next time they log in.

## Service Configuration

Services sometimes called daemons, or programs have configurable configuration files.
Kali Linux's policy is to have any network services disabled by default, which is a different behavior to other Linux operating systems. For more information see [_Kali Linux Policies_](https://portal.offensive-security.com/courses/pen-103/books-and-videos/modal/modules/about-kali-linux/kali-linux-policies/network-services-disabled-by-default).

RTFM: `/usr/share/doc/package/README.Debian` is good initial research location. `dpkg -L package` lists files included in the package `dpkg -s package` displays the package meta-data and shows any possible recommended or suggested packages. Configuration files are often self-doucmented, examples of configuration files are provided in `/usr/share/doc/package/examples/`.

#### SSH Configuration
For usage see [[SSH-Cheatsheet]]. While the `openssh-server` package is installed by default, the SSH service `sshd`  is disabled by default and thus is not started at boot time. Use:
```bash
systemctl enable ssh
systemctl start ssh
```

Ideally regardless and regardless on the use of the above service. 
```bash
# Editing /etc/ssh/sshd_config
# Requires:
systemctl reload ssh
```

Generating new `ssh` host keys are stored `/etc/ssh/ssh_host_*`  new images may comes with pre-generated hosts!
```bash
rm /etc/ssh/ssh_host_*
dpkg-reconfigure openssh-server
systemct restart ssh
```

#### Configuring PostgreSQL Databases

PostgreSQL is a database server used in combination with other servicdes to store data.
```bash
systemctl start postgresql
```

Multiple Version Support is avalible configuration file is `/etc/postgresql/version/cluster-name/`. Each cluster is originally an empty file shell called `postgresql.service` with each new cluster being assign the next port from `5433`, with its own unit: postgresql@version-cluster.service

By default, PostgreSQL listens for incoming connections in two ways: on TCP port 5432 of the localhost interface and on file-based socket `/var/run/postgresql/.s.PGSQL.5432`, configured in `postgresql.conf` with various directives `listen_addresses` addresses to listen to, `port` for the TCP port and `unix_socket_directories` to define the directory where the file-based sockets are created.

The `postgres` user is special and has full administrative privileges over all databases. Client authentication depends on connection type defined in the `pg_hba.conf` configuration file. By default, connections on the file-based socket use the Unix user account as the name of the PostgreSQL user, and it assumes that no further authentication is required. On the TCP connection, PostgreSQL requires the user to authenticate with a username and a password (though not a Unix username/password but rather one managed by PostgreSQL itself).

```sql
createuser -- create user -P prompt for password once created
dropuser -- removes users
createdb -- create database
dropdb -- removes database
-- create a database with some options:
createdb -T database_template -E <encoding(UTF-8)> -0 <owner_username
-- connect to a database with user
psql -h localhost -U username username -- on first logon username used as password
```

"PostgreSQL cluster" is a [Debian-specific addition](https://wiki.debian.org/PostgreSql) and that you will not find any reference to this term in the [official PostgreSQL documentation](https://www.postgresql.org/docs/). Debian's `postgresql-common` package provides multiple tools to manage such clusters: 
**IMPORTANT**  
Whennew major version of PostgreSQL get installed, it will create a new cluster run on the next port(5433), keeping old versiuon util you migrate your databases from old cluster to new one.
```bash
pg_createcluster # create cluster
pg_dropcluster # drop cluster
pg_ctlcluster # 
pg_upgradecluster old-version cluster-name # migrate old cluster
# May need the below for the above to be successful
pg_dropcluster new-version cluster-name 
# Before dropping cluster during migration of a cluster checked it has actually migrated
pg_renamecluster # rename cluster
pg_lsclusters # list clusters
```

#### Configuring Apache 2

The `apache2` package is disable by default, but a default package for Kali. It is a modular server with external module providing function after being loaded during initialization of apache. These module create  or delete symbolic links in `/etc/apache2/mods-enabled/`, pointing at the actual files (stored in `/etc/apache2/mods-available/`).
```bash
systemctl start apache2
as2enmod _module_ # enable new module
asdismod module # disable module
a2ensite www.domain.com # enable a virtual host
```

Useful modules: 
-  [Full list of standard Apache modules](https://httpd.apache.org/docs/2.4/mod/index.html)
- `libapache-mod-php` - PHP module 
- `ssl` - SSL for HTTPS configured `/etc/apache2/sites-available/default-ssl.conf`
	- See [Apache SSL configuration documentation](https://httpd.apache.org/docs/2.4/mod/mod_ssl.html)

Default configuration:
- Listen on port 80 - configured `/etc/apache2/ports.conf`
- Serves pages from `/var/www/html` - configured `/etc/apache2/sites-enabled/000-default.conf`
Virtual Hosting

Default configuration of for Apache 2 enables name-based virtual hosts, defined in `/etc/apache2/sites-enabled/000-default.conf`. **Be aware**: requests concerning unknown virtual hosts will always be served by the first defined virtual host, which is why the package ships a `000-default.conf` configuration file, which is sorted first among all other files that you might create. Each additional virtual host is described by a file stored in `/etc/apache2/sites-available/`, as `.conf`. Minimal configuration example: 

Website files stored at: `/srv/www.kali.org/www/`, defined with the `DocumentRoot` options:
```
<VirtualHost *:80>
ServerName www.kali.org
ServerAlias kali.org
DocumentRoot /srv/www.kali.org/www
</VirtualHost>
```

[CustomLog and ErrorLog Directives](https://httpd.apache.org/docs/2.4/logs.html) 


## References
[Systemd-networkd Arch Wiki](https://wiki.archlinux.org/title/Systemd-networkd) 
[PEN-103]()
[Kali Linux Policies](https://portal.offensive-security.com/courses/pen-103/books-and-videos/modal/modules/about-kali-linux/kali-linux-policies/network-services-disabled-by-default).