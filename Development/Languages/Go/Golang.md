# Golang 

## Installing GO

## Compiling Go
[Official Compilation Tutorial](https://go.dev/doc/tutorial/compile-install)
```bash
# Remember if you compile for another system
# On target machine:
ldd --version # linux and windows
go build 
CGO_ENABLED=0 go build # For static without c runtime libraries
```
[Continuing research here at Martin Tournoij (“arp242);](https://www.arp242.net/static-go.html)

Specifying Architecture
```bash
go env GOOS GOARCH # current system as target
go tool dist list
GOOS=<os> GOARCH=<arch> go build

ldd $binary # to check it is static or dynamically compiled and with which C libraries if any
```

Minimisation effort with [[UPX]]
```bash
# To mimise binary size
# -s strip binary of debug info
# -w strip of dwarf infomation
go build -ldflags="-s -w"
upx <binary>
```

## Effective Go

[Effective Go is a great article to write idiomatic Go Code](https://go.dev/doc/effective_go)

## Test Driven Development Template

[[Go-Testdriven-Development]]

## Golang Installation for Linux-Based Hacker Distros

[Install Golang](https://go.dev/doc/install)
```bash
# Careful, <version> and Chip varience
wget https://go.dev/dl/go1.<version>.tar.gz
sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf <go.version.tar.gz>
echo "export PATH=$PATH:/usr/local/go/bin" | sudo tee -a /etc/profile # or $HOME.profile for single user
go version # verify
# Export GOPATH & GOBIN
GOPATH="$HOME/go"
echo "" | tee -a ~/.<rc file of shell> 
echo "# Golang GOPATH and GOBIN" | tee -a ~/.profile
echo "export GOPATH=\"$HOME/go\"" | tee -a ~/.profile
echo "export GOBIN=\"$GOPATH/bin\"" | tee -a ~/.profile
```

#### Useful Golang

```go

func init() // This is a special function in golang - IS THE FIRST FUNCTION THAT WILL RUN IN YOUR PACKAGE
```

## Secure Coding in Go

[OWASP's Go-SCP](https://github.com/OWASP/Go-SCP) is a *"Go programming language secure coding practices guide"*

## Malware 

[[Go-Malware-Writing-For-Windows]]

## References

[Official Compilation Tutorial](https://go.dev/doc/tutorial/compile-install)
[Effective Go is a great article to write idiomatic Go Code](https://go.dev/doc/effective_go)
[Building for specific archs and oses](https://www.digitalocean.com/community/tutorials/building-go-applications-for-different-operating-systems-and-architectures)
[OWASP's Go-SCP](https://github.com/OWASP/Go-SCP)
