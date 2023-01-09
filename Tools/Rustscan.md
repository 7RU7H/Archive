# Rustscan

Due Rustscan not being very compatable

Pull either docker image:
```bash
docker pull rustscan/rustscan:alpine
docker pull rustscan/rustscan:latest
```

```bash
# Create an alias and put in a .rc file
# Recommend you remove the art work for outputting
echo "alias rustscan='docker run -it --rm --name rustscan rustscan/rustscan:latest --accessible '" | tee -a # .Xrc file
```

Flags
```bash 
-h # help information
-V # rustscan version
-a # addresses formats:
# 10.10.10.10 - single IP
# 10.10.10.10,11.11.11.11 - lists 
# domain.tld   -  Domain
# 10.10.10.0/24  -  CIDR
-p # single, comma-delimited list port(s)
-r # Port range: 80-88
-b # Batch size - files openned - 65535 is all ports..
-t # timeout
-g # grep 
-u # ulimit
-n # ignore config file
--accessible # turn off the artwork
```