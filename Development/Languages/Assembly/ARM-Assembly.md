
## Computing Euclidean Algorithm in Raw ARM 

[LaurieWired - Computing Euclidean Algorithm in Raw ARM](https://www.youtube.com/watch?v=665rzOSSxWA) - In this video [LaurieWired](https://www.youtube.com/@lauriewired) demonstrates translating C++ into equivalent ARM assembly code to compute the GCD of two numbers (also known as the Euclidean Algorithm). We visualize our completed GCD calculator on a raspberry pi. Laurie like to write the algorithm in a higher level language first before implementing at the lower level. 

The C++ code - this the recursive approach and not the iterative:
```cpp
int gcd(int a, int b) {
	if (b == 0) {
		return a;
	}
	return gcd(b,a % b)
}
// Armv7 does not have modulus so the equivilent c++:
// int divsion = a /b;
// int product = division *b;
// int remainder = a - product;
```

I followed along copying from her using her *"fill-able"* code and then translated the code into [[x86-64-Assembly]], but the project is hosted on [GitHub](https://github.com/LaurieWired/Assembly-Algorithms) - the only part I needed from following along was from `.global main ...` to `ldr r0, =filename`
```asm
.global main
.extern fopen, fprintf, fclose, printf, atoi

.section .data
filename: .asciz "nums.txt"
write_mode: .asciz "w"
format_str: .asciz "%d\n"

.section .text

print_num_to_file:
    push {lr}
    push {r0-r5}
    mov r5, r0
    ldr r0, =filename
    ldr r1, =write_mode
    bl fopen
    mov r4, r0
    
    cmp r4, #0
    beq close_file
    
    mov r0, r4
    ldr r1, =format_st
    mov r2, r4
    bl fprintf

close_file:    
    mov r0, r4
    bl fclose 
    pop {r0-r5}
    pop {pc}


gcd:
    push {lr}
    cmp r1, #0
    beq end_gcd 
    // Armv7 does not have a modulus operator!
    sdiv r2, r0, r1
    mul r3, r2, r1
    sub r4, r0, r3
    mov r0, r1 
    mov r1, r4
    bl gcd

end_gcd:
    pop {pc}

main:
    push {r4-r7, lr}
    
    cmp r0, #3
    blt exit


    push {r1}
    ldr r0, [r1, #4]
    bl atoi
    mov r4, r0
    pop {r1}

    push {r4}
    ldr r0, [r1, #8] 
    bl atoi
    mov r5,r0
    pop {r4}

    mov r0, r4
    mov r1, r5
    bl gcd

    bl print_num_to_file


exit:
    mov r0, #0
    pop {r4-r7, pc}

.section .note.GNU-stack
// Make sure to end with a newline!
```

Beware this code does require an executable stack!
```bash
arm-linux-gnueabi-as gcd.asm -o gcd.o
arm-linux-gnueabi-gcc -static gcd.o -o gcd
```

Fumbling around, but almost done I need to understand syscalls in asm to make print stdout  - Incoming
```asm
section .text
global main


;; print to stdout to be different
print_stdout:
;; https://stackoverflow.com/questions/27594297/how-to-print-a-string-to-the-terminal-in-x86-64-assembly-nasm-without-syscall - baremetal write

;; https://cs.brown.edu/courses/csci1260/spring-2021/lectures/x86-64-assembly-language-reference.html#directives

gcd:
	cmp rax, $0x00
	jne recurse
	ret
	recurse:
	idiv ;; ;; ;; stored in rax
 	mul rax ;;
	sub rax ;;
	gcd

main: 	
	mov rax, ;;  

	print_stdout
	ret

```
## References

[LaurieWired - Computing Euclidean Algorithm in Raw ARM](https://www.youtube.com/watch?v=665rzOSSxWA) 
[LaurieWired](https://www.youtube.com/@lauriewired) 