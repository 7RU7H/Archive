

Windows kernel will control all programs and processes and bridge all software and hardware interactions.
An aplication cannot interact with the kernel or modify physical hardware and requires an interface.
A windows processor has auser and kernel mode, the processor will switch between modes depending on access and request.

User mode						Kernel Mode
No direct hardware access				Direct hardware access
Creates a process in a private virtual address space	Ran in a single shared virtual address space
Access to "owned memory locations"			Access to entire physical memory

										
										
USER APPLICATION -> API (WIN32 API) ----switching_point---> system calls -> Kernel:(Physical Memory | Hardware)

We will inject a message box into our local process to demonstrate a proof-of-concept to interact with memory.

The steps to write a message box to memory are outlined below,

    Allocate local process memory for the message box.
    Write/copy the message box to allocated memory.
    Execute the message box from local process memory.

At step one, we can use OpenProcess to obtain the handle of the specified process.

HANDLE hProcess = OpenProcess(
	PROCESS_ALL_ACCESS, // Defines access rights
	FALSE, // Target handle will not be inhereted
	DWORD(atoi(argv[1])) // Local process supplied by command-line arguments 
);

At step two, we can use VirtualAllocEx to allocate a region of memory with the payload buffer.

remoteBuffer = VirtualAllocEx(
	hProcess, // Opened target process
	NULL, 
	sizeof payload, // Region size of memory allocation
	(MEM_RESERVE | MEM_COMMIT), // Reserves and commits pages
	PAGE_EXECUTE_READWRITE // Enables execution and read/write access to the commited pages
);

At step three, we can use WriteProcessMemory to write the payload to the allocated region of memory.

WriteProcessMemory(
	hProcess, // Opened target process
	remoteBuffer, // Allocated memory region
	payload, // Data to write
	sizeof payload, // byte size of data
	NULL
);

At step four, we can use CreateRemoteThread to execute our payload from memory.

remoteThread = CreateRemoteThread(
	hProcess, // Opened target process
	NULL, 
	0, // Default size of the stack
	(LPTHREAD_START_ROUTINE)remoteBuffer, // Pointer to the starting address of the thread
	NULL, 
	0, // Ran immediately after creation
	NULL
); 

