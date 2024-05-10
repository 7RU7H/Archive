# Python Tooling Libraries
## 2to3 Python Tool or AI

[2to3](https://docs.python.org/3/library/2to3.html)
[[AI-ChatBots-Whispering]]

## Python Circles of Hell -  [Blackhillinfosec](https://www.blackhillsinfosec.com/wp-content/uploads/2020/08/SLIDES_PrettyLittlePythonSecretsEpisode1.pdf)

- Don't cross the streams `apt-get` and `pip` variants - use only one
- Use `VirtualEnvs` - `pyenv` for [Kali is official EOL](https://www.kali.org/docs/general-use/using-eol-python-versions/)
- `pipx`
	- *“... `pipx` is made specifically for application installation, as it adds isolation yet still makes the apps available in your shell: `pipx` creates an isolated environment for each application and its associated packages.”*  https://github.com/pipxproject/pipx
```bash
python3 -m pip install pipx
pipx ensurepath
pipx install x
```

- zipapp creation: ```
```bash
python -m pip install -r requirements.txt --target myapp  
python -m zipapp -p "/usr/bin/env python3" myapp -m "myapp:main"
```


- Docker?
- Python is not Go. People usually say the Alpine base image is the best cause it produces smaller  
images. This is not the case for Python.  
- Stick with Python 3 images based on Debian (e.g. python:latest or python:3.8-slim-buster as  
of writing) 

- The “bible” of Packaging Python apps in Docker:  
- https://pythonspeed.com/docker/


# BEWARE AS OF 2024 THE BELOW DOES NOT WORK

## Python2, 3 Exploit scripts and Hell itself

Many hours of head banging of keyboard and searching for best answer for the future it seems `Python2` lives on the virtual environments - dead but virtualised. This has probably been the most annoying thing to deal with as the world has moved on but exploit scripts don't and neither do the vulnerabilities really in a historic context `Python2` is nightmare also - i.e what if in 50 years we are stumped by this problem. 

```bash
#!/bin/bash

sudo apt install -y build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev python3-openssl git
wait
curl https://pyenv.run | bash
wait
echo '' >> ~/.zshrc
echo '# Python 2.7 required!' >> ~/.zshrc
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.zshrc
echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.zshrc
echo -e 'if command -v pyenv 1>/dev/null 2>&1; then\n  eval "$(pyenv init --path)"\nfi' >> ~/.zshrc
echo '' >> ~/.zshrc

exec $SHELL
pyenv install 2.7.18
wait
pyenv global 2.7.18
exit
```

The below is the work of [ben leeyr](https://benleeyr.wordpress.com/2022/01/30/pyenv-installation-on-kali/) . Only changes is to use `pip2` to get `impacket` and `init`
```bash
pyenv global 2.7.18
pyenv global system
pyenv init
```
add to your shell's `.rc` the below is for `zsh`'s `.zshrc`
```bash
# Load pyenv automatically by appending
# the following to 
~/.profile (for login shells)
and ~/.zshrc (for interactive shells) :

export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
```
Then  
```bash
pyenv shell 2.7.18
wget https://bootstrap.pypa.io/pip/2.7/get-pip.py
sudo python2 get-pip.py
sudo pip2 install -U setuptools
sudo pip2 install impacket
```




## References

[Blackhillinfosec](https://www.blackhillsinfosec.com/wp-content/uploads/2020/08/SLIDES_PrettyLittlePythonSecretsEpisode1.pdf)
[Kali is official EOL](https://www.kali.org/docs/general-use/using-eol-python-versions/)
[Github- pipx](https://github.com/pipxproject/pipx)
[ben leeyr](https://benleeyr.wordpress.com/2022/01/30/pyenv-installation-on-kali/)
[2to3](https://docs.python.org/3/library/2to3.html)