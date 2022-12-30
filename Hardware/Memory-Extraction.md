
# Memory Extraction

The act of dumping memory from host's hardware or software memory. 


## Bare-metal machine dumping 


-   FTK Imager - [Link](https://accessdata.com/product-download/ftk-imager-version-4-2-0)
-   Redline - [Link](https://www.fireeye.com/services/freeware/redline.html) _*Requires registration but Redline has a very nice GUI_
-   DumpIt.exe
-   win32dd.exe / win64dd.exe - _*Has fantastic psexec support, great for IT departments if your EDR solution doesn't support this_
-   Memoryze
-   FastDump

## Virtualised dumping 
Collect these files from host's drives:
-   VMWare - .vmem
-   Hyper-V - .bin
-   Parallels - .mem
-   VirtualBox - .sav file *_this is only a partial memory file_ You'll need to dump memory like a normal bare-metal system for this hypervisor_
