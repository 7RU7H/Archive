# Android-Hacking




#### APK

`AndroidManifest.xml`: the manifest file in binary XML format.
- Every APK file includes an `AndroidManifest.xml` file, Attributes found in table below:

|Attributes|Notes|
|---|---|
|Manifest tag|contains android installation mode, package name, build versions|
|Permissions|custom permission and protection level|
|uses-permissions|requests a permission that must be granted in order for it to operate, full list of permission api can refer [here](https://developer.android.com/reference/android/Manifest.permission.html).|
|uses-feature|Declares a single hardware or software feature that is used by the application.|
|Application|The declaration of the application. Will contains all the activity|
|Activity|Declares an activity that implements part of the application visual user interface.|
|intent-filter|Specifies the types of intents that an activity, service, or broadcast receiver can respond to.|
|service|Declare a service as one of the application components.|
|receiver|Broadcast receivers enable applications to receive intents that are broadcast by the system or by other applications, even when other components of the application are not running.|
|provider|Declares a content provider component. A content provider is a subclass of ContentProvider that supplies structured access to data managed by the application.|


`classes.dex` application code compiled in the dex format.
- file containing binary Dalvik bytecode
`resources.arsc` file containing precompiled application resources, in binary XML.
`res/`: directory containing resources not compiled into `resources.arsc`
`assets/`: optional directory containing applications assets, which can be retrieved by AssetManager.
`lib/`: optional directory containing compiled code 
- i.e. native code libraries.
`META-INF/`: directory containing the MANIFEST.MF file
- stores meta data about the contents of the JAR. 
- Sometimes will be stored in a directory named `original`.
- The signature of the APK is stored in this directory.
#### Smali

[GitHub JesusFreke/smali/wiki](https://github.com/JesusFreke/smali/wiki) *"smali/baksmali is an assembler/disassembler for the dex format used by dalvik, Android's Java VM implementation. The syntax is loosely based on Jasmin's/dedexer's syntax, and supports the full functionality of the dex format (annotations, debug info, line info, etc.) The names "smali" and "baksmali" are the Icelandic equivalents of "assembler" and "disassembler" respectively. Why Icelandic you ask? Because dalvik was named for an Icelandic fishing village."*

For disambiguation regarding dalvik being replaced by ART: [Wikipedia - Android Runtime](https://en.wikipedia.org/wiki/Android_Runtime): *"ART uses the same input bytecode as Dalvik, supplied through standard [.dex](https://en.wikipedia.org/wiki/.dex ".dex") files as part of [APK files](https://en.wikipedia.org/wiki/APK_(file_format) "APK (file format)"), while the [.odex](https://en.wikipedia.org/wiki/.odex ".odex") files are replaced with [Executable and Linkable Format](https://en.wikipedia.org/wiki/Executable_and_Linkable_Format "Executable and Linkable Format") (ELF) executables"*

[Tanuphat Tin Medium: Unveiling the Power of Smali Code in Android Hacking](https://tanuphattin.medium.com/unveiling-the-power-of-smali-code-in-android-hacking-6780bd303e35) - read
https://github.com/JesusFreke/smali/wiki

Smali Syntax: Types 
```java
// .method private doSomething() TYPEFROMBELOWHEREASCHAR
V void 
Z boolean
B byte
S short
C char
F float
I int
J long // are 64 bit values, and require 2 registers.
D double // are 64 bit values, and require 2 registers
[ array
```


Register Properties:
- Always of 32 bits in length
- Can hold any type 
- Two registers are used to hold 64 bits types (Long and Double)


Register names
- Naming scheme:
	- normal `v` naming scheme
	- `p` naming scheme parameter registers (naming scheme for practicalities of edit smali code)
		- By default baksmali will use the _p_ naming scheme for parameter registers.
			- `-p` or `--no-parameter-registers`  option to disable `p` naming scheme
		- The first register in the _p_ naming scheme is the first parameter register in the method
		- Due to method parameters are stored in the last registers in the method, using this naming scheme prevents having to change the `.registers` directive and renumber every parameter register.


You can reference parameter registers by either name

|Local|Param| 
|---|---|---|
|v0||the first local register|
|v1||the second local register|
|v2|p0|the first parameter register|
|v3|p1|the second parameter register|
|v4|p2|the third parameter register|
Doubles and Longs are 64 bit values, and require 2 registers, remember to reference 2 registers!

Register Directives:
- Specifying availability:
	- `.registers` directive specifies the total number of registers in the method
	- `.locals` directive specifies the number of non-parameter registers in the method

Methods:
- Method Parameters are placed in the last `n` registers, methods are invoked
	- The first parameter to a non-static methods is always the object that the method is being invoked on
	- Static methods is always the object that the method is being invoked on, except there isn't an implicit `this` argument.
 


## References

[THM Room Android Hacking 101](https://tryhackme.com/r/room/androidhacking101)
[Tanuphat Tin Medium: Unveiling the Power of Smali Code in Android Hacking](https://tanuphattin.medium.com/unveiling-the-power-of-smali-code-in-android-hacking-6780bd303e35)
[GitHub JesusFreke/smali/wiki](https://github.com/JesusFreke/smali/wiki)
[Wikipedia - Android Runtime](https://en.wikipedia.org/wiki/Android_Runtime)
