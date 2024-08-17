# Big O Notation

Big O Notation describes asymptotic behaviour of functions

- Always think in terms of what the curve is
- Calculation of resource usage 
- Differentiate between: Performance and Complexity
	- Performance - how much of resource used
	- Complexity - resource requirement scaling 
- Big and Small: Bit wise operations have constant amount - can you use one add and, subtraction and flip to more complex operations like `x^n`, which require programmer's insight about the data types at various levels and encodings
- Number of operations to the problem size
- Expressing it over time
- Determine and identify complexity - nesting, recursion, unbounding

| Notation      | Name            |
| ------------- | --------------- |
| O(1)          | constant        |
| O(log(n))     | logarithmic     |
| O((log(n))^c) | polylogarithmic |
| O(n)          | linear          |
| O(n^2)        | quadratic       |
| O(n^c)        | polynomial      |
| O(c^n)        | exponential\    |

source: https://web.mit.edu/16.070/www/lecture/big_o.pdf

## References

[web.mit.edu big O PDF](https://web.mit.edu/16.070/www/lecture/big_o.pdf)