
# Power of 10 Rules

This is just partial mirror of [Wikipedia Power of 10 rules](https://en.m.wikipedia.org/wiki/The_Power_of_10:_Rules_for_Developing_Safety-Critical_Code) for importance stake. 

These are actually really good to know and just do unless you need to break them on regular applications unless you like having meeting about fixing your broken code and getting paid to fix it cycle. If *you* are reading this please go become a stunt person. 

The Power of 10 Rules were created in 2006 by [Gerard J. Holzmann](https://en.m.wikipedia.org/wiki/Gerard_J._Holzmann "Gerard J. Holzmann") of the [NASA/JPL](https://en.m.wikipedia.org/wiki/JPL "JPL") Laboratory for Reliable Software. The rules are intended to eliminate certain [C](https://en.m.wikipedia.org/wiki/C_(programming_language) "C (programming language)") coding practices which make code difficult to review or statically analyze. The ten rules are:

1. Avoid complex flow constructs, such as [goto](https://en.m.wikipedia.org/wiki/Goto "Goto") and [recursion](https://en.m.wikipedia.org/wiki/Recursion_(computer_science) "Recursion (computer science)").
2. All loops must have fixed bounds. This prevents runaway code.
3. Avoid [heap memory allocation](https://en.m.wikipedia.org/wiki/Memory_management#DYNAMIC "Memory management").
4. Restrict functions to a single printed page.
5. Use a minimum of two [runtime assertions](https://en.m.wikipedia.org/wiki/Assertion_(software_development)#Assertions_for_run-time_checking "Assertion (software development)") per function.
6. Restrict the scope of data to the smallest possible.
7. Check the return value of all non-void functions, or cast to void to indicate the return value is useless.
8. Use the [preprocessor](https://en.m.wikipedia.org/wiki/Preprocessor "Preprocessor") sparingly.
9. Limit pointer use to a single [dereference](https://en.m.wikipedia.org/wiki/Dereference_operator "Dereference operator"), and do not use [function pointers](https://en.m.wikipedia.org/wiki/Function_pointer "Function pointer").
10. Compile with all possible warnings active; all warnings should then be addressed before release of the software.

## References

[The Power of 10: Rules for Developing Safety-Critical Code .pdf](http://web.eecs.umich.edu/~imarkov/10rules.pdf)
[Wikipedia Power of 10 rules](https://en.m.wikipedia.org/wiki/The_Power_of_10:_Rules_for_Developing_Safety-Critical_Code)