# macOS Hub Page

## Introduction

`macOS` is the official term for the operating system used on Apple computers. For a historical view consider the article: [[masOS-OS-X-Timeline]].

Beware: Older Apple Device support Intel chipsets and as of 2022 are move away from them in favour of in-house Apple Silicon 

## Components

#### `Kernel` [XNU](https://github.com/apple/darwin-xnu)

Mach Kernel with additional BSD features of the macOS and iOS `XNU` Kernel architecture

####  `OS Base`: [Darwin](https://github.com/apple/darwin-xnu) 

[[FreeBSD]] Derivative open-sourced by Apple


#### `GUI`: [Aqua](https://en.wikipedia.org/wiki/Aqua_(user_interface)#References)

OS management components that built-in application  

|**Component**|**Description**|
|---|---|
|`Apple Menu`|This is our main point of reference for critical host operations such as System Settings, locking our screen, shutting down the host, etc.|
|`Finder`|Finder is the component of macOS that provides the Desktop experience and File management functions within the OS.|
|`Spotlight`|Spotlight serves as a helper of sorts on your system. It can search the filesystem and your iCloud, perform mathematical conversions, and more.|
|`Dock`|The Dock at the bottom of your screen, by default, acts as the holder for any apps you frequently use and where your currently open apps will appear.|
|`Launchpad`|This is the application menu where you can search for and launch applications.|
|`Control Center`|Control Center is where we can manage our network settings, sound and display options, notification, and more at a glance.|


#### `File Manager`: [Finder](https://support.apple.com/en-us/HT201732) 

- Search for thing as the as the initial desktop experience and workflow of usage
- File management as paired panel in a window
- GUI
	 - The menu bar at the top of your desktop.
	- The sidebars within your windows.

Navigate up and down directories 
- `Finder -> Command` with the `up` and `down` arrows

View Root Directory
- `Finder -> Go -> Computer`
- `Command + Shift + G`, type `/`, and hit `Go`.

Copy and Paste Files and (Directories|Folders)
- `Command + C` and `Command + V`

Cut and Paste (Move) Files and (Directories|Folders)
macOS does not allow *Cut/Paste* of files to avoid potential file loss, it does allow *Cut/Paste* of text through the right-click menu or with the `Command + X` shortcut.
- `Finder -> Right-click $file|$folder -> Copy -> go to location with Finder -> Command + Option + V`
- CLI:
```bash
mv /home/$user/$file /home/$user/folder1/$file
```

View Hidden Files and (Directories|Folders)
-  `Open Folder -> Command + Shift + .`
- CLI:
```bash
# Change the default to view all hidden files
defaults write com.apple.Finder AppleShowAllFiles true
killall Finder
```

Preview Pane



#### `Kernel API` [Cocoa](https://developer.apple.com/library/archive/documentation/macOSX/Conceptual/OSX_Technology_Overview/CocoaApplicationLayer/CocoaApplicationLayer.html): API used with macOS


## HFS and APFS File systems

2001: From MacOS 9 was replaced by MacOS X, a Unix-like operating system derived from the NeXTSTEP OS from NeXT Computer. This caused issues with the HFS+ file system (no permissions or hard linking)

2017: APFS replaces HFS

HFS:
- 512 byte sectors
- 32 addresses to access blocks
- maximum number of allocation blocks is 2^32
- boot volume resides in sectors 0 and 1
- allocation file keeps track of the used and the unused allocation blocks
- The catalogue file contains a catalogue of all the files and directories stored in the volume in a [B-tree](https://en.wikipedia.org/wiki/B-tree#:~:text=A%20B%2Dtree%20index%20creates,pages%20at%20the%20lowest%20level.) format
- Attributes of the files are stored in the attributes file
- File names are encoded in [UTF-16](https://en.wikipedia.org/wiki/UTF-16) and can be up to 255 UTF-16 code unit lengths
- File permissions and hard links were not present in HFS
- Dates beyond 6 February 2040 are unsupported
- Maximum resolution of timestamps to the second
- Snapshot capability was unavailable

APFS (Apple File System container):
- APFS supports timestamps up to 1 nanosecond.
- Dates beyond 6 February 2040 are possible.
- Full disk encryption is supported natively.
- Snapshots are available for creating read-only, point-in-time file system instances.
- Apple introduced redirect-on-write, a crash-protection feature. To avoid data corruption, data is written to new blocks, and the old ones are released once done instead of rewriting existing ones.
- The maximum number of files stored in the system has been increased to 2^63
- APFS uses GUID Partition Table (GPT)
- Each container can contain multiple volumes

`/home`, `/var` , `/opt`, `/etc`, `/tmp`, `/dev`, `/sbin`, `/bin`, etc like Linux are found as they would in a Linux File System:
- `/private` contains `var`, `etc`, and `tmp` - require root permission to modify
- `/Library`
- `/Users`

Domains:
- Local Domain contains resources common to all users of the local computer
- System Domain contains software developed and managed by Apple
- User Domain contains user data and files
- Network Domain contains network resources

## File types

`.plist` or property list files contain system configurations similar to the Windows Registry in Microsoft Windows

`.app` files are application executables often found in the Applications directory

`.dmg` files are macOS disk image files

`.kext` files are kernel extension files **deprecated** - similar to Windows drivers

`.dylib` dynamically loaded library files

`.xar` files are archive files replacing `.pkg` package installer files
## References

[HTB Academy MacOS fundamentals](https://academy.hackthebox.com/module/157/section/1520)
[XNU](https://github.com/apple/darwin-xnu)
[Darwin](https://github.com/apple/darwin-xnu)
[Aqua](https://en.wikipedia.org/wiki/Aqua_(user_interface)#References)
[Cocoa](https://developer.apple.com/library/archive/documentation/macOSX/Conceptual/OSX_Technology_Overview/CocoaApplicationLayer/CocoaApplicationLayer.html) 
[Finder](https://support.apple.com/en-us/HT201732) 