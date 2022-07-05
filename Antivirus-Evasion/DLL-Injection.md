# DLL Injection
Similar to [[Reflective-DLL-Injection]] but the loaded on disk. More information on DLL avalible here: [[Dynamic-Link-Libraries]]. This technique leverages the [[Windows-API]]'s `LoadLibrary`([Documentation](https://docs.microsoft.com/en-us/windows/win32/api/libloaderapi/nf-libloaderapi-loadlibrarya)) to load a DLL from disk.