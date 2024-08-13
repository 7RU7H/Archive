# NASA Power Of Ten 

For a video explanation see [Low Level Learning - YouTune: how NASA writes space-proof code](https://www.youtube.com/watch?v=GWYhtksrmhE)


1. Simple Control Flow
	1. No `goto`
	2. No `setjmp`
	3. No `longjmp`
	4. No recursive functions
1. Bound Loops to Upper bound break condition 
	1. If a tool cannot prove a loop is bound statically, then the rule is consider violated
1. Do not you the Heap, only use stack memory 
1. Limit the size and purpose of functions - Unix-like does one thing well 
3. Declare variables at the lowest scope possible
4. Check all return types 
	1. If returns `void` then typecast to `void` in the function call: `(void)printf("SPACE!\n");`  
5. No C Preprocessor Macros - avoid the n to the power of builds possible
6. Restrict Pointers to a maximum one level of dereferencing
7. No function pointers
8. Be pedantic at compilation `gcc -Wall -Werror -Wpedantic`
9. Analyses code with multiple static analysers with multiple multiple rulesets
## References

[Low Level Learning - YouTune: how NASA writes space-proof code](https://www.youtube.com/watch?v=GWYhtksrmhE)