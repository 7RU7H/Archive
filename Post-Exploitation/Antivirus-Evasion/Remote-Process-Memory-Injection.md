# Remote Process Memory Injection

Remote Process Memory Injection leverages the Windows API to inject in to a legitimate process a payload. `OpenProcess` ([Documentation](https://docs.microsoft.com/en-us/windows/win32/api/processthreadsapi/nf-processthreadsapi-openprocess)) Opens an existing local process object to find a legitimate [Handle](https://en.wikipedia.org/wiki/Handle_(computing)) process to target, allocate memory given contextual restraints with `VirtualAllocEx`([Documentation](https://docs.microsoft.com/en-us/windows/win32/api/memoryapi/nf-memoryapi-virtualallocex)). `VirtualAllocEx` reserves, commits, or changes the state of a region of memory within the virtual address space of a specified process, initializes the memory it allocates to zero. Then writing payload to this newly allocated memory with `WriteProcessMemory`([Documentation](https://docs.microsoft.com/en-us/windows/win32/api/memoryapi/nf-memoryapi-writeprocessmemory))which writes data to an area of memory in a specified process.


## References

[OpenProcess Documentation](https://docs.microsoft.com/en-us/windows/win32/api/processthreadsapi/nf-processthreadsapi-openprocess)
[Handle Wiki](https://en.wikipedia.org/wiki/Handle_(computing))
[VirtualAllocEx](https://docs.microsoft.com/en-us/windows/win32/api/memoryapi/nf-memoryapi-virtualallocex)
[WriteProcessMemory](https://docs.microsoft.com/en-us/windows/win32/api/memoryapi/nf-memoryapi-writeprocessmemory)