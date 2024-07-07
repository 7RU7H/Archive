# Red Team Tooling


## Collections

[Flangvik/SharpCollection](https://github.com/Flangvik/SharpCollection) is a github repository that contains ..*"
Nightly builds of common C# offensive tools, fresh from their respective master branches built and released in a CDI fashion using Azure DevOps release pipelines."

[infosecn1nja/Red-Teaming-Toolkit](https://github.com/infosecn1nja/Red-Teaming-Toolkit#Payload%20Development) is github repository that is *"This repository contains cutting-edge open-source security tools (OST) that will help you during adversary simulation and as information intended for threat hunter can make detection and prevention control easier. The list of tools below that could be potentially misused by threat actors such as APT and Human-Operated Ransomware (HumOR). If you want to contribute to this list send me a pull request."*

## General

[infosecn1nja/red-team-scripts - sliver](https://github.com/infosecn1nja/red-team-scripts/blob/main/sliver.md) also provides instructions for hosting a clone of HTTPS site for various Red Team needs
```bash
# Install Letsencrypt
apt install letsencrypt -y
# Setup Letsencrypt
apt install apache2 -y
certbot certonly --non-interactive --quiet --register-unsafely-without-email --agree-tos -a webroot --webroot-path=/var/www/html -d <domain>
# Create a New Website by Cloning a website with wget. Pick something sensible!
wget --mirror --convert-links --html-extension <target>
# Add content to HTTP(S) C2 websites to make them look more legit.
websites add-content --website <name> --web-path <path> --content ./public --recursive
```
