# Process Hollowing
Lauching of non-malicious process in a suspended state, then *hollowing* the image of process and replaced with malicious executable image.  From [n0n0ph1](https://github.com/m0n0ph1/Process-Hollowing) *"..a bootstrap application creates a seemingly innocent process in a suspended state. The legitimate image is then unmapped and replaced with the image that is to be hidden. If the preferred image base of the new image does not match that of the old image, the new image must be rebased. Once the new image is loaded in memory the EAX register of the suspended thread is set to the entry point. The process is then resumed and the entry point of the new image is executed."*

## References
[n0n0ph1 explaination of Process Hollowing](https://github.com/m0n0ph1/Process-Hollowing) 
[iredtem](https://www.ired.team/offensive-security/code-injection-process-injection/process-hollowing-and-pe-image-relocations)