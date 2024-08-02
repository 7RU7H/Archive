# Parrot

[parrotsec](https://www.parrotsec.org/) states that *"Parrot Security provides a huge arsenal of tools, utilities and libraries that IT and security professionals can use to test and assess the security of their assets in a reliable, compliant and reproducible way. From information gathering to the final report. The Parrot system gets you covered with the most flexible environment."*


Work in progress solution
```bash
# 1. Get Binary from:
# https://www.python.org/downloads/release/python-2716/

curl -L https://www.python.org/downloads/release/python-2716/$whateverCompressionTypeYouWantForInstaller
```

Install Python2.7 on Parrot from [HTB Academy](https://academy.hackthebox.com) - Broken as ParrotOS needs the above python2.7 binary
```bash
sudo wget https://files.pythonhosted.org/packages/28/84/27df240f3f8f52511965979aad7c7b77606f8fe41d4c90f2449e02172bb1/setuptools-2.0.tar.gz
sudo tar -xf setuptools-2.0.tar.gz
cd setuptools-2.0/
sudo python2.7 setup.py install

sudo wget https://files.pythonhosted.org/packages/42/85/25caf967c2d496067489e0bb32df069a8361e1fd96a7e9f35408e56b3aab/xlrd-1.0.0.tar.gz
sudo tar -xf xlrd-1.0.0.tar.gz
cd xlrd-1.0.0/
sudo python2.7 setup.py install
```


## References

[parrotsec](https://www.parrotsec.org/)
[HTB Academy](https://academy.hackthebox.com)