The Debian package is a canonical way to make software available to end-users. 

A Debian package is a compressed archive of a software application. A `.deb` file is binary package that   contains the source code for the software and instructions required for building a binary package. It contains the application files, metadata (including dependcies names), scripts enabling execution of package maintaince (installing, upgrading, removal, etc).

```bash
dpkg # process and installs .deb packages, list missing dependencies
apt # The adavnced package tool - addresses shortcomings of dpkg
apt-get # These help manage Debian Packages
apt-cdrom # for CD ROM installed packages - executed mostly with the "add" parametre

apt install
apt search
apt update
apt upgrade
```

APT retrieves its packages from a repository.
*"source package"*:  a package containing the source code of program
*"package source"*: a repository that contains a packages.
The `/etc/apt/sources.list` file lists different repositories (or sources) that publish Debian Packages and it the configuration file for defining package sources. Syntax of this file:
- Each active line of the `/etc/apt/sources.list` file (and of the `/etc/apt/sources.list.d/*.list` files) contains:
	- Description of a source; three parts seperated by spaces
	- Comment lines begin with `#`
	1. First field
		-   `deb` for binary packages.
		-   `deb-src` for source packages.
	2. Second field 
		- Gives the base url of source
			- `file://` to indicate source installed in the system's file hierarchy
			- `http://` to indicate a source accessible from a web server
			- `ftp://` to indicate a avaliable on a FTP server
			- `cdrom:` for CD/DVD-ROM/Blu-ray disc-based installations
				- This **entry** is not always avaliable - one disc at a time - they need `apt-cdrom`
	3. Third field
		- Dependent on the structure of the repository 
			- to indicate Subdirectories use a trailing slash 
			- `./` indicate absence of subdirectories
Debian uses three sections to differentiate packages according to the licenses chosen by the authors of each work. To differentiate packages Debian has only `main` enabled by default