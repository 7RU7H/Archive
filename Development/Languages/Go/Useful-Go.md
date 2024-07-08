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
	fmt
	strings
	flag // -h is a default flag for help!
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
		default:
	
	} 


	defer fmt.Printf("%s %s!\n", hackingString)
}

func calculateTotalHack() {
	needToHack := true
	if needToHack {
	
	} else if {
	
	} else {
	
	}
}

```


## References

[learnxinyminutes - Go](https://learnxinyminutes.com/docs/go/)
[adrianhesketh dividing-a-go-project-into-multiple-packages blog](https://adrianhesketh.com/2016/04/19/dividing-a-go-project-into-multiple-packages/)
[GitHub Chris Pritchard GO-SCRIPTING.md](https://github.com/ChrisPritchard/ctf-writeups/blob/master/GO-SCRIPTING.md)