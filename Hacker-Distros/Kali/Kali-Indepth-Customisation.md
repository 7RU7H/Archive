Note: Potential restructure.

Firstly the non in-depth apt usage requires [[Debian-Package-Management]] article

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