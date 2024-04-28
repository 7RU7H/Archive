# Useful Go

TODO list
```
go routines
chans
interfaces
errors
```



```go
package main // 
// comments 

import (
	fmt
	strings
	// generally there is a newline between imported library packages and project packages and external depencies

	// These are stored in the GOPATH Environment variable under a src directory 
	// $GOPATH/src/github.com/[username]/[projectname]/firstlibrary
	"github.com/[username]/[projectname]/firstlibrary"

)

// Upper case is Globally scoped, lowercase is scope to the { block }
type GopherShape struct {
	
}

// Upper case is Globally scoped
const ImportantNumber int = 69 

// Example of a method that requires a instance of gopherShape
// Domenstrated named return types 
func (g *gopherShape) () (result string, err error) { 

	return result, nil
}

func main() {
	var hackingString string 
	hackingString = "hacking"
	happyString := "Happy"

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