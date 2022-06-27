## C# for Hacking - Defining .Net

C# or as some joke, Microsoft Java, is powerful object oriented programing language that is commonly used in application and utilities built for Windows. It allows developers to interact with the a run-time environment known as the Common Language Runtime (CLR)and Win32 API. You can use any \.NET langauge to compile into the Common Intermediary Language (CIL).  Microsoft: *"\.NET provides a run-time environment, called the common language runtime, that runs the code and provides services that make the development process easier. Compilers and tools expose the common language runtime's functionality and enable you to write code that benefits from this managed execution environment. Code that you develop with a language compiler that targets the runtime is called managed code. Managed code benefits from features such as cross-language integration, cross-language exception handling, enhanced security, versioning and deployment support, a simplified model for component interaction, and debugging and profiling services."* For [[basic_Csharp]] usage and tricks.

Branch | Purpose
--- | --- 
\.NET Framework | Windows only
\.NET Core | Cross-Compatible

## CLR Execution Model

Source Code | Managed Code | CLR (including JIT compiler) | Native Code / Operating System Services
--- | --- | --- | ---
VB -> Compiled -> | Assembly Code -> | CLR -> | Native Code
C# -> Compiled -> | Assembly Code -> | CLR -> | Native Code
C++ -> Compiled(Unmanged Compoent sent to OSS) -> | Assembly Code -> |	CLR ->  | Native Code and Compiler's Unmanaged Component -> OSS

\.NET assemblies are compiled .exes and .dlls that any .NET language can execute. The CLR will compile the CIL into native machine code. Any unmanaged code with .NET you can chose for this to code to be directly compiled from the language into machine code, skipping the CLR.

## \.NET Dynamic Language Runtime (DLR)

\.NET has a [Dynamic Language Runtime (DLR)](https://docs.microsoft.com/en-us/dotnet/framework/reflection-and-codedom/dynamic-language-runtime-overview). 

## Compilers and Offensive Tooling
[VScode compiler](https://code.visualstudio.com/Docs/languages/csharp)
Requires [free, but valid Microsoft account](https://outlook.live.com/owa/).
To create a solution file for .NET Core with VScode:
`Create a new project OR Open a project or solution > Console App (.NET Core)`

Roslyn
GCC
MinGW
LLVM
TCC
MSBuild


## References
[DLR Overview](https://docs.microsoft.com/en-us/dotnet/framework/reflection-and-codedom/dynamic-language-runtime-overview)
[C# Documentation](https://docs.microsoft.com/en-us/dotnet/csharp/)
[THM Holo Room](https://tryhackme.com/room/hololive)
[VScode compiler](https://code.visualstudio.com/Docs/languages/csharp)