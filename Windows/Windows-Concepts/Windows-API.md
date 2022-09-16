# Windows API


## THM Internals Message Box Example

From: [THM Windows Internals Room](https://tryhackme.com/room/windowsinternals) *We will inject a message box into our local process to demonstrate a proof-of-concept to interact with memory.

*The steps to write a message box to memory are outlined below,
- *Allocate local process memory for the message box.*
- *Write/copy the message box to allocated memory.*
- *Execute the message box from local process memory.*

*At step one, we can use OpenProcess to obtain the handle of the specified process.*
```cpp
HANDLE hProcess = OpenProcess(
	PROCESS_ALL_ACCESS, // Defines access rights
	FALSE, // Target handle will not be inhereted
	DWORD(atoi(argv[1])) // Local process supplied by command-line arguments 
);
```

*At step two, we can use VirtualAllocEx to allocate a region of memory with the payload buffer.*
```cpp
remoteBuffer = VirtualAllocEx(
	hProcess, // Opened target process
	NULL, 
	sizeof payload, // Region size of memory allocation
	(MEM_RESERVE | MEM_COMMIT), // Reserves and commits pages
	PAGE_EXECUTE_READWRITE // Enables execution and read/write access to the commited pages
);
```

*At step three, we can use WriteProcessMemory to write the payload to the allocated region of memory.*
```cpp
WriteProcessMemory(
	hProcess, // Opened target process
	remoteBuffer, // Allocated memory region
	payload, // Data to write
	sizeof payload, // byte size of data
	NULL
);
```

*At step four, we can use CreateRemoteThread to execute our payload from memory.*
```cpp
remoteThread = CreateRemoteThread(
	hProcess, // Opened target process
	NULL, 
	0, // Default size of the stack
	(LPTHREAD_START_ROUTINE)remoteBuffer, // Pointer to the starting address of the thread
	NULL, 
	0, // Ran immediately after creation
	NULL
); 
```


## References

[THM Windows Internals Room](https://tryhackme.com/room/windowsinternals)
[THM Windows API Room](https://tryhackme.com/room/windowsapi)