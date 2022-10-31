The Debian package is a canonical way to make software available to end-users. 

A Debian package is a compressed archive of a software application. A `.deb` file is binary package that   contains the source code for the software and instructions required for building a binary package. It contains the application files, metadata (including dependcies names), scripts enabling execution of package maintaince (installing, upgrading, removal, etc). The internal Debian Pakckage database is located `/var/lib/dpkg`, configuration scripts (`/var/lib/dpkg/info`), a list of files the package installed (`/var/lib/dpkg/info/*.list`), and the status of each package that has been installed (`/var/lib/dpkg/status`).

```bash
dpkg # process and installs .deb packages, list missing dependencies
apt # The adavnced package tool - addresses shortcomings of dpkg

dpkg -i $package.deb # direct use of debian package manager - unpacks and runs configuration scripts automatically
dpkg --unpack
dpkg --configure $package.deb
dpkg --print-architecture # print host architecture
dpkg --add-architecture # add an architecture 
dpkg --print-architecture # remove an architecture

#  If dpkg fails to install a package and return an error - ignore it with:
dpkg -i --force-overwrite 
dpkg -i --force-help # display all options of --force-* just in case!

dpkg -P $package # completely remove package and data 

# Inspecting packages
dpkg -L $package # --listfiles $package queries the /var/lib/dpkg/info database
dpkg -S $file # --search $file finds any packages containing the file or path passed 
dpkg -s $packe # --status $package command displays the headers of an installed package
dpkg -l "core*" # --list displays the list of packages known to the system and their installation status - can be used with wildcard and piped to grep
dpkg -c $file.deb # --contents list all the files inside a .deb file
dpkg -I $file.deb # --info display $file.deb's headers 
# Compare versions
# use comparison operators lt,le,eq,ne,ge,gt
# pre denotes prerelease, but is just string to dpkg - for alphabetical sorting
# ~ get package number 
dpkg --compare-versions 3.2-3~pre3.3.9 gt 3.1-4 
echo $?

# Either 
apt -o Dpkg::Options::="--force-overwrite" install 
# or in /etc/apt/apt.conf.d/99local - either local or 99local
Dpkg::Options {
   "--force-overwrite";
}
# if you can only access the web through a proxy, add a line like to the above file
Acquire::http::proxy "http://yourproxy:$portnum" 
# For an FTP proxy
Acquire::ftp::proxy "ftp://yourproxy"
```

`apt` retrieves its packages from a repository. `apt` drop packages the downloaded files once installed.
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

`apt-cache` queries and displays available information about installed and installable packages stored in `apt`'s internal database gathered from `sources.list` files during the `apt update` operation. Locally searching is performed on stored a copy of `Packages` files located on Debian mirrors in `/var/lib/apt/lists/`.  To avoid redownload, cached copies of already downloaded packages are found at `/var/cache/apt/archives/`, which  regularly sorted with `apt clean` and `apt-get clean`. Note that the configuration parameter `APT::Clean-Installed` can be used to prevent the removal of `.deb` files that are currently installed.

## Configuring APT

Every file in `/etc/apt/apt.conf.d/` are instructions for the configuration of APT, each subdirectory represents a configuration file that is split into multiple files. End users don't have to manually follow multiple package configuration instructions typically found in the package's `/usr/share/doc/package/README.Debian` file, because the installer can drop in configuration files and the structuring brings flexibility for co-existing configurations of package maintainers. Although...

**Beware of Configuration Files Generated from `.d` Directories**

APT has native support of its `/etc/apt/apt.conf.d` directory, some applications the `.d` directory is a Debian-specific addition used as input to dynamically generate the canonical configuration file used by the application. For these applications **do not manually edit** the main configuration file as your changes will be lost on the next execution of the `update-*` command

Tracking packages is a best practice imvolving marking for automatic removal any package you do not require directly. `apt-mark auto package` to mark the given package as automatic, whereas `apt-mark manual package` does the opposite.

Enabling Multi-Architecture support to define foriegn architectures on a host can be done with `dpkg --print-architecture` to print host architecture, `dpkg --add-architecture`  to add an architecture and `dpkg --print-architecture` to remove an architecture. Finally foriehgn packages can then be installed with `apt install package:architecture`. To make multi-arch actually useful and usable, libraries had to be repackaged and moved to an architecture-specific directory so that multiple copies (targeting different architectures) can be installed alongside one another. Such updated packages contain the `Multi-Arch: same` header field to tell the packaging system that the various architectures of the package can be safely co-installed (and that those packages can only satisfy dependencies of packages of the same architecture). `Multi-Arch: same` packages must have their **names qualified with their architecture** to be unambiguously identifiable and **package must be the same version** to be upgraded together. These packages may also share files with other instances of the same package; `dpkg` ensures that all packages have bit-for-bit identical files when they are shared. Satisfying a dependency requires either a package marked `Multi-Arch: foreign` or a package whose architecture matches the one of the package declaring the dependency (in this dependency resolution process, architecture-independent packages are assumed to be of the same architecture as the host). It can be weakened with `package:any`, if foreign only if it is marked `Multi-Arch: allowed`. 

## Package Prioritization

Package Context | Priority Value
--- | ---
Installed package | 100
Non-Installed package | 500
Non-Installed package part of a target release | 990

- Target release (defined with the `-t` command-line option or the `APT::Default-Release`
- You can modify the priorities by adding entries in the `/etc/apt/preferences` file.
	- If several generic entries exist, the first match is used.
	- Every package source is identified by the information contained in a `Release` file and downloads together with the `Packages` files.
- APT will never install an older version of a package - with value lower than any on the table above or greater than 1000.
- If two packages have the same priority, APT installs the newest one
- Priority Value between 100 and 500, the package will only be installed if there is no other newer version installed or available in another distribution.
- Priority between 501 and 990 will only be installed if there is no newer version installed or available in the target distribution.

For Debian experiement or Debian-based bleeding edge: `apt install $package/experimental`
```bash
# You can, but it's not advised specify in /etc/apt/preferences the following:
Package: *
Pin: release a=experimental
Pin-Priority: 500
```

For more exotic package mixing see [[APT-And-Other-Non-Host-Distributions]]

## Troubleshooting

- See [[Troubleshooting]] generally. 
- For bugs reports - https://bugs.debian.org/package
- For downgrading - find old .deb in `apt`'s cache `/var/cache/apt/archives/`, check https://snapshot.debian.org/. 
- Upgrades sometimes get interrupted because one of the package maintainer scripts fails - frequently `postint` - you maybe have to edit the script..
	- `set -x` after shebang, arrange rerunning of script with `dpkg --configure -a` for `postinst` provides more output 
	- Either fix the underlying problem or add `|| true` at the end of the line of the failing command
- The `dpkg` tool keeps a log of all of its actions in `/var/log/dpkg.log`, it is very verbose - it tracks: 
	- package details at all stages
	- `dpkg`'s behaviour
	- history of development of the system
	- time keeping of installations or updates
	- crossed-checked with information from `changelog.Debian.gz`
- The use of `--force-*` option or some other malfunction can lead to a system where `apt` family of commands will refuse to function. Just reinstall OS, this maybe too much, but **if in extereme cases and this ugly solution not for long term use after:**
	- Run `apt full-upgrade` to check unmet dependencies, and fix...
- Damage from removal or modification can be fixed with a simple: `apt --reinstall install $package` 
- **Do Not Use `apt --reinstall` to Recover from an Attack**
	- Quarantine from networking - change in bios, remove networking cards, etc
	- Do not panic, investigate the extent of the damage
	- Wipe and reinstall OS
	- For the paranoid - buy new a motherboard, remove and quarantine the old motherboard, remove all networking capabilities on the board and anything that connected with it own instruction set or long term storage - learn from investigating it in isolation to other systems. 

#### Alternatives to APT

See [[Common-Linux-Administration-Alternatives]]


## References

https://snapshot.debian.org/
https://bugs.debian.org/package
[Aptitude](https://wiki.debian.org/Aptitude)
[Synaptic](https://wiki.debian.org/Synaptic)