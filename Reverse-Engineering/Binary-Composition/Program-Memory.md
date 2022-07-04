# Program Memory


## The Stack
The stack is as LIFO(Last-In-First-Out) data area for short-term storage for functions, local variables, and program control information. Each thread has of a program has its own stack. Data is *pushed* onto the stack and *popped* off it with the corresponding assembly instructions `PUSH` and `POP`. When a function's `Return address` and `Parameters` are stored on the stack as a colelction of data associated with the **ONE** function(recursive function calls get there own stackframes) are stored in stack frame. When a function ends the return address is popped from the stack to resume execution flow back to calling function or main.

## Program Image

## Global offset table(GOT)
Section of the program inside the program that holds the addresses of dynamically linked function. Common functions are linked to the program by the linker during compilation `.got.plt`; real addresses are stored after there they are called for the first time.



