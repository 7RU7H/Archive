# Golang 
## Installing GO

## Compiling Go
[Official Compilation Tutorial](https://go.dev/doc/tutorial/compile-install)
```bash
go build 
```

Specifying Architecture
```bash
go env GOOS GOARCH # current system as target
go tool dist list
GOOS=<os> GOARCH=<arch> go build
```


Minimisation effort with [[UPX]]
```bash
# To mimise binary size
# -s strip binary of debug info
# -w strip of dwarf infomation
go build -ldflags="-s -w"
upx brute <binary>
```

## Effective Go
[Effective Go is a great article to write idiomatic Go Code](https://go.dev/doc/effective_go)

## Test Driven Development Template
[[Go-Testdriven-Development]]

## References
[Official Compilation Tutorial](https://go.dev/doc/tutorial/compile-install)
[Effective Go is a great article to write idiomatic Go Code](https://go.dev/doc/effective_go)
[Building for specific archs and oses](https://www.digitalocean.com/community/tutorials/building-go-applications-for-different-operating-systems-and-architectures)