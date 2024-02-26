# GDB

My `gdb` is [[GEF]] or [[pwndbg]].

## This is  work in progress as I need some baseline for a project at some point - see references for better lists

Add debug information into a C binary `-g` for `gcc` and `clang`
```bash
gcc -o main main.c -g
clang -o main main.c -g 
```

```bash
# Run a program within GDB
gdb ./$binary
# Run a program within GDB passing arguements to the binary
gdb --args ./$binary <args>
# Attach to a process with GDB  
gdb --pid <pid>
```

Help
```c
// list command classes
(gdb) help 
// list commands in one command class
(gdb) help <class> 
 // bottom-level help for a command "run" 
(gdb) help run
 // list info commands (running program state)
(gdb) help info
 // help for a particular info command
(gdb) help info line
 // list show commands (gdb state)
(gdb) help show
// specific help for a show command
(gdb) help show commands
```

General
```c
// Useful if you have debug information  
// 
// Display source code and asm 
(gdb) lay next 

// Running within GBD
//
// attach to running program
(gdb) attach <pid>
// detach from running program
(gdb) detach        
// finish current function's execution
(gdb) finish        
// Quit gbd
(gdb) quit

// execute binary
(gdb) run
// kill the program
(gdb) kill
// SIGINT - stop current execution of program
(gdb) CTRL-C

// Breakpoints and controlling the flow
//
// Continue program after breakpoint
(gdb) cont
// Add break point at label - a function name like main()
(gdb) break main
// Add break point at line number
(gdb) break 69 
// Show breakpoints
(gdb) info breakpoints
// Delete a breakpoint
(gdb) delete 
// Delete breakpoint by number
(gdb) delete 69
// Delete all breakpoints
(gdb) clear
// Enable a breakpoint
(gdb) enable 
// Disable a breakpoint
(gdb) disable 
// Step into next instruction
(gdb) step 
// Go to the next assembly instruction
(gdb) nexti
// Jump over next instruction in source 
(gdb) next 


// Stack backtrace
// 
// 
// Print stack backtrace
(gdb) bt
// Show current execution position
(gdb) frame
// Move up stack trace (towards main)
(gdb) up 
// Move down stack trace (away from main)
(gdb) down 
// Print automatic variables in frame
(gdb) info locals
// Print function parameters
(gdb) info args


// Set a new watchpoint.
(gdb) watch <where>
// control watchpoint
(gdb) delete/enable/disable <watchpoint#>

// Information
//
//
(gdb) info args
//
(gdb) info breakpoints
//
(gdb) info display
//
(gdb) info locals
//
(gdb) info signal
//
(gdb) info sharedlibrary
//
(gdb) info watchpoints
//
(gdb) info function $regex
//
(gdb) info variable $regex
//
(gdb) info line 9001
// 
(gdb) info line *0x1337
// print registers sans floats
(gdb) info registers
// print all registers
(gdb) info all-registers        

// History
//
// print command history (>= gdb 4.0)
(gdb) show commands 
// print command history (gdb 3.5)
(gdb) info editing       	
```

#### Formatting Output

[sourceware - GDB output formats](https://sourceware.org/gdb/current/onlinedocs/gdb.html/Output-Formats.html): *By default, GDB prints a value according to its data type. Sometimes this is not what you want. For example, you might want to print a number in hex, or a pointer in decimal. Or you might want to view data in memory at a certain address as a character string or as an instruction. To do these things, specify an `output format` when you print a value. The simplest use of output formats is to say how to print a value already computed. This is done by starting the arguments of the `print` command with a slash and a format letter. The format letters supported are:*

| Format Character | Denotation |
| ---- | ---- |
| a | Pointer. |
| c | Read as integer, print as character. |
| d | Integer, signed decimal. |
| f | Floating point number. |
| o | Integer, print as octal. |
| s | Try to treat as C string. |
| t | Integer, print as binary (t = „two“). |
| u | Integer, unsigned decimal. |
| x | Integer, print as hexadecimal |
## References

[Low Level Learning - YouTube - GDB is REALLY easy! Find Bugs in Your Code with Only A Few Command](https://www.youtube.com/watch?v=Dq8l1_-QgAc)
[marc@darkdust.net's GDB Cheatsheet](https://darkdust.net/files/GDB%20Cheat%20Sheet.pdf)
[sourceware - GDB output formats](https://sourceware.org/gdb/current/onlinedocs/gdb.html/Output-Formats.html)
[visualgdb](https://visualgdb.com/gdbreference/commands/set_disassemble-next-line)
[rkubik GDB cheatsheet](https://gist.githubusercontent.com/rkubik/b96c23bd8ed58333de37f2b8cd052c30/raw/ead6be96ed4dd4a9fc0bd318adcfa9d3a3afb109/cheat_sheet.txt)
[cs.brown.edu - pdf](https://cs.brown.edu/courses/cs033/docs/guides/gdb.pdf)