# Volatility

[Volatility](https://github.com/volatilityfoundation/volatility) developers describe the Volatility framework: *"The Volatility Framework is a completely open collection of tools, implemented in Python under the GNU General Public License, for the extraction of digital artifacts from volatile memory (RAM) samples. The extraction techniques are performed completely independent of the system being investigated but offer visibilty into the runtime state of the system. The framework is intended to introduce people to the techniques and complexities associated with extracting digital artifacts from volatile memory samples and provide a platform for further work into
this exciting area of research."*

The Volatility distribution is available from: [http://www.volatilityfoundation.org/#!releases/component_71401](http://www.volatilityfoundation.org/#!releases/component_71401)

## Obtaining Samples

-   FTK Imager - [Link](https://accessdata.com/product-download/ftk-imager-version-4-2-0)
-   Redline - [Link](https://www.fireeye.com/services/freeware/redline.html) _*Requires registration but Redline has a very nice GUI_
-   DumpIt.exe
-   win32dd.exe / win64dd.exe - _*Has fantastic psexec support, great for IT departments if your EDR solution doesn't support this_
  
#### Memory image for different virtual machine hypervisors:

-   VMware - .vmem file
-   Hyper-V - .bin file
-   Parallels - .mem file
-   VirtualBox - .sav file _*This is only a partial memory file. You'll need to dump memory like a normal bare-metal system for this hypervisor_