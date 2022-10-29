
## Alternative for ATP

`axi-cache search term` uses the _Xapian_ search engine and is part of the `apt-xapian-index` package, which indexes all package information, knows about tags and returns results in a matter of milliseconds.

[Aptitude](https://wiki.debian.org/Aptitude) 
- Aptitude does not have `apt autoremove` because it removes them automatically as soon as they are identified
- `aptitude markauto` and `aptitude unmarkauto`, for package marking
- `aptitude why $package` for rational behind why a package is on your system - `apt` does not have this
[Synaptic](https://wiki.debian.org/Synaptic)