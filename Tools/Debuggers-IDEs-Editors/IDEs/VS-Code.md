# VS-Code ...and Variants

Not to be confused with [[Microsoft-Visual-Studios]] ... it hurts or [vscodium](https://vscodium.com/)

Migrate from codium to code to codium to code to infinite
```bash
code --list-extensions | awk '{print "codium --install-extension "$1}'
codium --list-extensions | awk '{print "code --install-extension "$1}'
```
## [vscodium](https://vscodium.com/)

[vscodium](https://vscodium.com/) is a *"VSCodium is a community-driven, freely-licensed binary distribution of Microsoft’s editor VS Code."* It was started due to *"Microsoft’s `vscode` source code is open source (MIT-licensed), but the product available for download (Visual Studio Code) is licensed under [this not-FLOSS license](https://code.visualstudio.com/license) and contains **telemetry/tracking**."*

For [[Kali]]
```bash
# Add GPG key of repoisitory
wget -qO - https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg \
    | gpg --dearmor \
    | sudo dd of=/usr/share/keyrings/vscodium-archive-keyring.gpg
# Add repository
echo 'deb [ signed-by=/usr/share/keyrings/vscodium-archive-keyring.gpg ] https://download.vscodium.com/debs vscodium main' \
    | sudo tee /etc/apt/sources.list.d/vscodium.list

# Install vscodium
sudo apt update && sudo apt install codium
```

Comes with [[ParrotOS]] by default! As seen on [Ippsec.Rocks](https://ippsec.rocks), but if not:
```bash
sudo apt update && sudo apt install codium
```
## Plugins

For security and development of any kind just get:
- [Snyk plugin](https://snyk.io/platform/ide-plugins/) for all variants of VS-Code, it is very powerful. 

## Keybindings, tricks ,etc

`F5 -> launcher.json` - define how to run and debug code with vs code


## References

[Snyk plugin](https://snyk.io/platform/ide-plugins/) 
[Ippsec.Rocks](https://ippsec.rocks)
[vscodium](https://vscodium.com/)