# UPX
UPX is the Ultimate Packer for eXecutables: 

*"UPX is an advanced executable file compressor. UPX will typically reduce the file size of programs and DLLs by around 50%-70%, thus reducing disk space, network load times, download times and
other distribution and storage costs.* 

*Programs and libraries compressed by UPX are completely self-contained and run exactly as before, with no runtime or memory penalty for most of the supported formats. UPX supports a number of different executable formats, including Windows 95/98/ME/NT/2000/XP/CE programs and DLLs, DOS programs,and Linux executables and kernels.*

*UPX is free software distributed under the term of the GNU General
Public License. Full source code is available.*

*UPX may be distributed and used freely, even with commercial applications.
See the UPX License Agreement for details.*

*UPX is rated number one in the well known Archive Comparison Test. Visit
[http://compression.ca/](http://compression.ca/) .*

*UPX aims to be Commercial Quality Freeware."*

## Overview

UPX achieves an **excellent compression ratio** and offers **very fast decompression**. Your executables suffer no memory overhead or other drawbacks for most of the formats supported, because of in-place decompression. UPX strengths in a nutshell:

-   **excellent compression ratio**: typically compresses better than WinZip/zip/gzip, use UPX to decrease the size of your distribution!
-   **very fast decompression**: ~10 MB/sec on an ancient Pentium 133, ~200 MB/sec on an Athlon XP 2000+.
-   **no memory overhead** for your compressed executables because of in-place decompression.
-   **safe**: you can list, test and unpack your executables. Also, a checksum of both the compressed and uncompressed file is maintained internally.
-   **universal**: UPX can pack a number of executable formats.
-   **portable**: UPX is written in portable endian-neutral C++.
-   **extendable**: because of the class layout it's very easy to add new executable formats or new compression algorithms.
-   **free**: UPX is distributed with full source code under the GNU General Public License v2+, with special exceptions granting the free usage for commercial programs as stated in the [UPX License Agreement](https://upx.github.io/upx-license.html).

You probably understand now why we call UPX the "Ultimate Packer for eXecutables".

## References
[Github IO](https://upx.github.io/)
[Git Repo](https://github.com/upx/upx)