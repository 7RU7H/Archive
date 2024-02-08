# Firmware Reversing

[Firmware](https://en.wikipedia.org/wiki/Firmware)  is class of software that provides low-level control for device specific hardware. Ascher Opler coined the term _firmware_ in a 1967 _[Datamation](https://en.wikipedia.org/wiki/Datamation "Datamation")_ article as an intermediary term between hardware and software. Firmware is held in non-volatile memory such as ROM, EPROM, EEPROM and flash memory. 

Motherboard and GPU BIOS, Storage Drives (HDD,SSD ODD), Embedded devices, IoT devices, Autombile computers

[[IoT-Device-Hacking]]

Firmware reverse engineering is extracting the original code from the firmware binary file for analysis. 

Potential Steps:

- Obtain firmware from vendor's website
- Enumerate whether firmware is bare metal or OS based
- Verify if the firmware is either encryption or packed
	- Encrypted? Hardware Attacks:
		- Find another version that is not
		- [Side Channel Attacks](https://en.wikipedia.org/wiki/Side-channel_attack) - fetch encryption keys 
	- Decrypt
	- Reverse Engineer firmware with tool relative to type of firmware extracted


## Types of Firmware 
- Static Analysis
	- **[BinWalk](https://github.com/ReFirmLabs/binwalk):** A firmware extraction tool that extracts code snippets inside any binary by searching for signatures against many standard binary file.
	- **[Firmware ModKit (FMK)](https://www.kali.org/tools/firmware-mod-kit/)**: FMK is widely used for firmware reverse engineering that uses `binwalk`.
		- `extract-firmware.sh`
	- **[FirmWalker](https://github.com/craigz28/firmwalker)**: Searches through the extracted firmware file system for unique strings and directories for keywords and vulnerable binaries
- Dynamic Analysis
	- **[Qemu](https://www.qemu.org/)**: Qemu is a free and open-source emulator and enables working on cross-platform environments for aiding in full-system emulation or a single binary emulation.
	- **[Gnu DeBugger (GDB)](https://www.sourceware.org/gdb/)**[:](https://www.sourceware.org/gdb/) GDB is a dynamic debugging tool for emulating a binary and inspecting its memory and registers - supports remote debugging.

## Cheatsheet - Begins... 

Is firmware encrypted? 
```bash
# Output entropy edge
binwalk -E -N $encryptedFirmware.gpg
```

Find Encryption Keys Post-Firmware-Extraction
```bash
grep -ir key
grep -ir paraphase # and other keys relative to encryptiong software
```

GPG?
```bash
# import keys
gpg --import $path/public.key 
gpg --import $path/private.key 
# list keys
gpg --list-secret-keys 
gpg $firmware.gpg
```

## [[Firmware-Extraction]]

## References

[Wikipedia Firmware](https://en.wikipedia.org/wiki/Firmware)
[Wikipedia Side Channel Attacks](https://en.wikipedia.org/wiki/Side-channel_attack)
