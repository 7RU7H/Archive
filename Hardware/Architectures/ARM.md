# ARM


Thumb mode - [Low Level Learning - YouTube - Computers Have THUMBS and You Didn't Even Notice](https://www.youtube.com/watch?v=rsg_Krh-o1U)
```asm
; ARM instructions are 4 byte aligned so that the last byte of dst brach is always 0
; incremented that by one will enter thumb mode  
ldr r7, =#0x08049445    ; incremented from ldr r7, =#0x08049644 or somelabel+1
blr r7 ; from this point it execute instruction 16 bits at a time 
somelabel: ; cpu will go to somelabel and execute in thumb mode
```



## References

[Low Level Learning - YouTube - Computers Have THUMBS and You Didn't Even Notice](https://www.youtube.com/watch?v=rsg_Krh-o1U)