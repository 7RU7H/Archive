Firstly the non indepth apt usage requires [[Debian-Package-Management]] article

The `.deb` is the combination of a file archive and of meta-information is directly visible in the structure of a `.deb` file, which is simply an `ar` archive; the `.deb` three files: the debian binary (contains a single version number describing the format of the archive) , `control` (archive contains meta-information) and `data` (an archive with varying compression format contain actual files to be installed) files with the latter two commonly compressed.

```bash
ar t $x_amd64.deb # display contents of the archive
ar p # print file(s) found iun the archive 
# Extract and print file paths, compression format may vary! 
ar p $x_amd64.deb control.tar.gz | tar -tzf -
ar p $x_amd64.deb data.tar.xz | tar -tJf -

dpk -I $x_amd64.deb control # view control file
```

- The `control` archive file uses a structure similar to email headers and can be viewed with the `dpkg -I` command.

####  Package Dependencies != Pre-Dependencies 

Generally you should always install the recommended packages unless you know exactly why you do not need them.

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
`apt` compares versioning logically with `&` and `|`  with the header being a list of conditions. Version comparison operators: 
-   `<<` - less than.
-   `<=` - less than or equal to.
-   `=` - equal to (note that "`2.6.1`" is not equal to "`2.6.1-1`").
-   `>=` - greater than or equal to.
-   `>>` - greater than.

