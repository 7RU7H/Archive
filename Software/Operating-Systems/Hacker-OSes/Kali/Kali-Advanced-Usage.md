
For any advanced usage of Kali Linux the [[Debian-Package-Management]] article contains details regarding the structure and administration of packages, cross checking the actualities of how Debian and Kali manage packages is critical for most adavnced usage. As Kali has been built as a highly modular and customizable penetration testing platform and allows for some fairly advanced customization and usage. This article will focus Kali customization, usage and administration


#### Modifying Kali Packages

1. Get the Source
	1. Git or Kali Repository? 
	- Specific versions? - Go to https://pkg.kali.org/ - may need to:
		- `dget`
		- `dpkg-source -x dsc-file`
		- With potentially:
			- Force the source package extraction by passing the `--allow-unauthenticated` or `-u` option
			- `--download-only` to skip the source package extraction step.
	- The main file is the Debian Source Control file `*.dsc` - lists compressed files
	- The source packages are stored on Kali mirrors that are available over HTTP
	- Add a `deb-src` line in the `/etc/apt/sources.list` file and the run `apt update`
	- Use `apt source $source_package_name` command. 
3. Install Build Dependencies - sources packages declares its build dependencies in the `Build-Depends` field pf `debian/control` file.
	1. `sudo apt build-dep ./`
4. Make Changes - [Learn Debian Packaging](https://wiki.debian.org/Packaging)
	- Tweaking build options requires customization of parametres set at build time through a `./configure` option or set variables in the build environment.    
	- New Upstream Version? - Extract new source tarball next to current, copy the `debian` directory from current to new and the change the version in `debian/changelog`
```bash
# Some useful commands, definately not all you will need
dch # Debian Changelog from devscripts package, runs EDITOR or VISUAL env or /usr/bin/editor
dch --local $yourname
# Set these env temporarily or in a .profile or .*rc
export DEBFULLNAME
export DEBEMAIL 
# Apply patch
patch -p1 < patch-file
# Commit package
dpkg-source --commit
# Bear in mind there are other patch management - quilt, git 
```
	
1. Start the Build


## References

[https://pkg.kali.org/](https://pkg.kali.org/)
[Debian Packaging](https://wiki.debian.org/Packaging)