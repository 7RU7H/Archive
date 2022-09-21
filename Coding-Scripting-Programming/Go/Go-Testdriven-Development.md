# Test Driven Development in Go



## Template Code

```go
package main

import (
	"fmt"
	"testing"
	)

func main() {
	
}
     

func Test(t *testing.T) {
	input := //
	expected := //

	result := fn-parent(input)
	if !test-result(expected, result) {
		t.Fatalf(`fn-parent Result - %v - Expected - %v`, result, expected)
	}
}

func tableTesting(t *testing.T) {
		tests := []struct {
		name  string
		input []int
		want  []int
	}{
		{
			name:  "testname",
			input: //
			want:  //
		},
	}
	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			if got := fn-parent(tt.input); !test-result(got, tt.want) {
				t.Errorf("fn-parent() = %v, want %v", got, tt.want)
			}
		}
			  }
	

```