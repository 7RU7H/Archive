# Windows API

Not to be confused with the [[Windows-Runtime]], [Win32 API](https://learn.microsoft.com/en-us/windows/win32/apiindex/api-index-portal) *"(also called the Windows API) is the native platform for Windows apps. This API is best for desktop apps that require direct access to system features and hardware. The Windows API can be used in all desktop apps, and the same functions are generally supported on 32-bit and 64-bit Windows."*

[Windows API Index](https://learn.microsoft.com/en-us/windows/win32/apiindex/windows-api-list)

## Overview

[Wikipedia](https://en.wikipedia.org/wiki/Windows_API) article groups the functions provided by the Windows API into eigth catergories:
- Base Services
- Advanced Services
- Graphics DEvice Interface
- User Interface
- Common Dialog Box Library
- Common Control Library
- Windows Shell
- Network Services

## Subsystem and Hardware Interaction 

User application calls API to modify Kernel Components: Physical memory or Hardware
```
			User Mode                                                                       
User Application -> Win32 API -> (Boundary-Between-Modes) -> System Calls -> Kernel ->...										
																Kernel Mode
```

Windows distinguishes hardware access by two distinct modes:
**User mode** | **Kernel mode**
--- | ---
No direct hardware access | Direct hardware access  
Access to "owned" memory locations | Access to entire physical memory
For information about the kernel see [[Windows-Kernel]] and memory see [[Windows-VirtualMemory]]. When looking at how languages interact with the Win32 API, this process can become further warped; the application will go through the language runtime before going through the API. See [[Windows-Runtime-Detection-Evasion]].

## Windows API Components 

API top-down approach to typology, API is the top layer and parameter part of specific calls are the bottom layer. The parent header file that contains all other required child and core header files is, also known as the Windows loader; the Window header file  [windows.h](https://en.wikipedia.org/wiki/Windows.h) (this link contain a listing of Child Header files and macros), which *is a Windows-specific header file for C and C++ programming languages, which contain declaration for all the function in the Windows API"*. 
**Layer** | **Explanation**
--- | ---
API  | A top-level/general term or theory used to describe any call found in the win32 API structure.  
Header files or imports | Defines libraries to be imported at run-time, defined by header files or library imports. Uses pointers to obtain the function address.  
Core DLLs  | A group of four DLLs that define call structures. (KERNEL32, USER32, and ADVAPI32). These DLLs define kernel and user services that are not contained in a single subsystem.  
Supplemental DLLs | Other DLLs defined as part of the Windows API. Controls separate subsystems of the Windows OS. ~36 other defined DLLs. (NTDLL, COM, FVEAPI, etc.)  
Call Structures | Defines the API call itself and parameters of the call.  
API Calls | The API call used within a program, with function addresses obtained from pointers.  
In/Out Parameters | The parameter values that are defined by the call structures.


## OS Libraries 

Each API call of the Win32 library resides in memory and requires a pointer to a memory address. The process of obtaining pointers to these functions is obscured because of **ASLR** (**A**ddress **S**pace **L**ayout **R**andomization) implementations; each language or package has a unique procedure to overcome ASLR. Given ASLR associated problems, windows.h will determine what calls are being made and create a thunk table to obtain function addresses or pointers.


#### P/Invoke
Microsoft describes [P/Invoke](https://learn.microsoft.com/en-us/dotnet/standard/native-interop/pinvoke) or platform invoke as *“a technology that allows you to access structs, callbacks, and functions in unmanaged libraries from your managed code.”* It is used handle the entire  process of invoking an unmanaged function from managed code, by importing DLLs that contains the unmanaged function or Win32 API call *"Most of the P/Invoke API is contained in two namespaces: `System` and `System.Runtime.InteropServices`. Using these two namespaces give you the tools to describe how you want to communicate with the native component."*

```csharp
using System;
using System.Runtime.InteropServices;

public class Program
{
[DllImport("user32.dll", CharSet = CharSet.Unicode, SetLastError = true)]
...
// extern keyword will informthe runtime of specific DLL previous imported
private static extern int MessageBox(IntPtr hWnd, string lpText, string lpCaption, uint uType);
} 
```

## API Call Structure 

#### Structure
Wind32 API are documented [Windows API Documentation](https://docs.microsoft.com/en-us/windows/win32/apiindex/windows-api-list) and [pinvoke.net](http://pinvoke.net/). Each API call has a pre-defined structure to define its in/out parameters. API call functionality can be extended by modifying the naming scheme and appending a representational character:
**Character** | **Explanation**
--- | --- 
A | Represents an 8-bit character set with ANSI encoding  
W | Represents a Unicode encoding  
Ex | Provides extended functionality or in/out parameters to the API call
[More info on the above concept](https://docs.microsoft.com/en-us/windows/win32/learnwin32/working-with-strings)

## Implementations

Generally low-level languages like a C and C++ make it very easy to define an API call quickly, by including the windows.h header file.

Defining an API call in Powershell or .NET is almost identical in its implementation, create a external method instead of a class and  PowerShell requires a new type for the pointer of each Win32 DLL within the method definition.

## Commonly Abused API Calls
[SANs](https://www.sans.org/white-papers/33649/) and [MalAPI.io](http://malapi.io/)
**API Call** | **Explanation**
--- | ---
LoadLibraryA | Maps a specified DLL  into the address space of the calling process  
GetUserNameA | Retrieves the name of the user associated with the current thread  
GetComputerNameA | Retrieves a NetBIOS or DNS  name of the local computer  
GetVersionExA | Obtains information about the version of the operating system currently running  
GetModuleFileNameA | Retrieves the fully qualified path for the file of the specified module and process  
GetStartupInfoA | Retrieves contents of STARTUPINFO structure (window station, desktop, standard handles, and appearance of a process)  
GetModuleHandle | Returns a module handle for the specified module if mapped into the calling process's address space  
GetProcAddress | Returns the address of a specified exported DLL  function  
VirtualProtect  | Changes the protection on a region of memory in the virtual address space of the calling process


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
	0, // Ran immediately after creation[SANs](https://www.sans.org/white-papers/33649/) and [MalAPI.io](http://malapi.io/)
	NULL
); 
```


## References
[Windows API Index](https://learn.microsoft.com/en-us/windows/win32/apiindex/windows-api-list)
[Windows API Portal](https://learn.microsoft.com/en-us/windows/win32/apiindex/api-index-portal)
[Wikipedia Windows API](https://en.wikipedia.org/wiki/Windows_API)
[THM Windows Internals Room](https://tryhackme.com/room/windowsinternals)
[THM Windows API Room](https://tryhackme.com/room/windowsapi)
[Wikipedia windows.h](https://en.wikipedia.org/wiki/Windows.h)
[P/Invoke](https://learn.microsoft.com/en-us/dotnet/standard/native-interop/pinvoke)
[Windows API Documentation](https://docs.microsoft.com/en-us/windows/win32/apiindex/windows-api-list)
[pinvoke.net](http://pinvoke.net/)
[Windows API Call naming scheme extensions](https://docs.microsoft.com/en-us/windows/win32/learnwin32/working-with-strings)
[SANs Whitepaper](https://www.sans.org/white-papers/33649/)
[MalAPI.io](http://malapi.io/)
