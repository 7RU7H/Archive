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

The `.deb` is the combination of a file archive and of meta-information is directly visible in the structure of a `.deb` file, which is simply an `ar` archive; the `.deb` three files: the debian binary (contains a single version number describing the format of the archive) , `control` (archive contains meta-information) and `data` (an archive with varying compression format contain actual files to be installed) files with the latter two commonly compressed.

```bash
ar t $x_amd64.deb # display contents of the archive
ar p # print file(s) found iun the archive 
# Extract and print file paths, compression format may vary! 
ar p $x_amd64.deb control.tar.gz | tar -tzf -
ar p $x_amd64.deb data.tar.xz | tar -tJf -

dpk -I $x_amd64.deb control # view control file
```

## Control File

- The `control` archive file uses a structure similar to email headers and can be viewed with the `dpkg -I` command.

####  Package Dependencies != Pre-Dependencies 

Generally you should always install the recommended packages unless you know exactly why you do not need them.

These Fields below declare the interationship depend packages [RTFM](https://www.debian.org/doc/debian-policy/ch-relationships.html)

- The package dependencies are defined in the `Depends` field in the package header. 
- Pre-dependencies adds a strict constraint on the ordering of the packages to be installed by `apt` before the dependencies, unless otherwise changed by system administrator - install them unless you know exactly why you do not need them. Pre-dependencies are listed in the `Pre-Depend` field must be unpacked and configured before execution of the pre-installation script of the package declaring the pre-dependency, that is before its installation.  
- The `Recommends` and `Suggests` fields describe dependencies that are optional; 
	- `Recommends` dependencies are not indispensable, considerably improve the functionality
	- `Suggests` dependencies are of secondary importance, improve utility, but operational without.
		- The `Enhances` field describes a `Suggests`, located in the suggested package indicating to it is possible to add a suggestion without having to modify the package that is concerned.
- The `Conflicts` field indicates when a package cannot be installed simultaneously with another. 
- The `Breaks` field is similiar to `Conflicts` signals that when package will break another package. 
- The `Provides` fields provides *virtual package* a substitution package without having to use the same package name.
	 - A "virtual package" - associates a generic service with it (the package provides the service) and second indicates that a package completely replaces another, therefore satisy the dependencies that other would satisfy. 
- The `replaces` field indicates that the package contains files that are also present in another package and that package can replace them. Without this field `dpkg` fails as will overwrite by default.; it help maintainers identify potential problems and research whether this field is required. The use of this field is justified when package names change or when a package is included in another or when a maintainer decides to distribute files differently among various binary packages produced from the same source package.
`apt` compares versioning logically with `&` and `|`  with the header being a list of conditions. Version comparison operators: 
-   `<<` - less than.
-   `<=` - less than or equal to.
-   `=` - equal to (note that "`2.6.1`" is not equal to "`2.6.1-1`").
-   `>=` - greater than or equal to.
-   `>>` - greater than.
The exception is the Provides field, for which only `=` is allowed. [2](https://www.debian.org/doc/debian-policy/ch-relationships.html#id9)


## Configuration Scripts

`dpkg` may call the scripts: 
- `postinst`: executed after the installation of a package
- `postrm`: invoked after removal of a package
- `preinst`: executed prior to installation of a package
- `prerm`: invoked before removal of a package
- `old-prerm`: the `prerm` script contained in the old version of the package (installed before the update)
- `new-postinst`:  the `postinst` script contained in the new version (installed by the update)

They called at different stages in package processing. `dpkg -I` to show these files as they reside in a `.deb` package archive, descibe in detail here: [Debian Policy](https://www.debian.org/doc/debian-policy/ch-maintainerscripts.html). [Manoj Srivastava made some diagrams](https://people.debian.org/~srivasta/MaintainerScripts.html) explaining how the configuration scripts are called by `dpkg`.


#### Installation and Upgrade Script Sequence

1.  For an update, `dpkg` calls the `old-prerm upgrade new-version`.
2.  `dpkg` then executes `new-preinst upgrade old-version`; for a first installation, it executes `new-preinst install`. 
	- It may add the old version in the last parameter if the package has already been installed and removed (but not purged, the configuration files having been retained).
3.  The new package files are then unpacked. If a file already exists, it is replaced, but a backup copy is made and temporarily stored.
4.  For an update, `dpkg` executes `old-postrm upgrade new-version`.
5.  `dpkg` updates all of the internal data (file list, configuration scripts, etc.) and removes the backups of the replaced files. 
	- **Warning** at this point `dpkg` can no longer has access to all of the elements necessary to return to the previous state.
6.  `dpkg` will update the configuration files, prompting you to decide if it is unable to automatically manage this task. The details of this procedure are discussed in [_Checksums, Conffiles_](https://portal.offensive-security.com/courses/pen-103/books-and-videos/modal/modules/debian-package-management/apt-package-reference-digging-deeper-into-the-debian-package-system/configuration-scripts#sect.conffiles).
7.  Finally, `dpkg` configures the package by executing `new-postinst configure last-version-configured`.

#### Package Removal

1.  `dpkg` calls `prerm remove`.
2.  `dpkg` removes all of the package's files 
	- except of the configuration files and configuration scripts.
1.  `dpkg` executes `postrm remove`. All of the configuration scripts, except `postrm`, are removed. 
	1. If you have not used the purge option, the process stops here.
	2.  For a complete purge of the package (command issued with `dpkg --purge` or `dpkg -P`), the configuration files are also deleted, as well as a certain number of copies (`*.dpkg-tmp`, `*.dpkg-old`, `*.dpkg-new`) and temporary files; `dpkg` then executes `postrm purge`.

Caveats:
- a package might use `debconf` to require configuration information which is acquired with an additional configuration script with response recorded inside the `debconf`. 

#### `debconf` tool

The `debconf` tool was created to resolve a recurring problem that all Debian packages unable to function without a minimum of configuration used to ask questions with calls to the `echo` and `read` commands in `postinst` shell scripts. This forces uses to babysit the installations or updates. Instead it requires the developer to specify user interaction allowing localization of all the displayed strings stored in a `templates` file. All of the questions can then be presented in a row, all at once, prior to starting a long installation or update process. Hurray!

#### Checksums and Conffiles

`dpkg --verify` .md5sums from a `control.tar.gz` archive contain a file calld md5sums, when it does not exist `dpkg` will generate it dynamically at installation time.

`conffiles` lists package files that must be handled as configuration files these can be edited by an administrator. `dpkg` offers to display a `diff` to assit in decision making between the new versions `.dpkg-dist` suffix and the old version with `.dpkg-old` suffix:
If the standard configuration file has not changed between the two versions:
- `dpkg` will do nothing. 
If the file has changed:
- `dpkg` will try to update this file.
If  the administrator has not touched this configuration file:
- `dpkg` automatically installs the new version
If the file has been modified:
- `dpkg` asks the administrator which version to use  - the old with modifications or the new provided by the package

Configuration file updates are time consuming use - although most administrators will work with [[APT-And-Other-Non-Host-Distributions]] with `DPkg::options::="`; These options can be stored directly in `apt`'s configuration int the `/etc/apt/apt.conf.d/local` file.
- `--force-confold` option retains the old version of the file
- `--force-confnew` will use the new version
- `--force-confdef` option tells `dpkg` to decide by itself when possible
- `--force-confask` option instructs `dpkg` to display the questions about the configuration files


#### Alternatives to APT

See [[Common-Linux-Administration-Alternatives]]


## References

https://snapshot.debian.org/
https://bugs.debian.org/package
[Aptitude](https://wiki.debian.org/Aptitude)
[Synaptic](https://wiki.debian.org/Synaptic)