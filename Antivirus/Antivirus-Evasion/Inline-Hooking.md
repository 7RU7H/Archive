# Inline Hooking

Inline hooking is introducing instructions that redirect the code execution to a function that points to malicious code, returning back the modified function and continuing execution disguising the intend malicious rational by flow redirection. [Securehat](https://blog.securehat.co.uk/process-injection/manually-implementing-inline-function-hooking) writes: *Malware and EDR agents commonly hook Win32 API functions so that they can alter and/or monitor calls made to these APIs often to to hook functions that handle credential information (or other sensitive information) so that they can extract credentials entered by a user.* One method [Malwaretech](https://www.malwaretech.com/2015/01/inline-hooking-for-programmers-part-1.html) *would be by intercepting calls to target functions,which is mainly used by antiviruses, sandboxes, and malware*.


## References

[Brain Mariani Exploitdb PDF](https://www.exploit-db.com/docs/english/17802-inline-hooking-in-windows.pdf)
[Securehat](https://blog.securehat.co.uk/process-injection/manually-implementing-inline-function-hooking)
[Malwaretech](https://www.malwaretech.com/2015/01/inline-hooking-for-programmers-part-1.html)