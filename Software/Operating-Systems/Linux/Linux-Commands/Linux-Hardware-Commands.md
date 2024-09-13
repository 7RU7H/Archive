# Linux Hardware Commands

The kernel export detail about hardware through `/proc/` and `/sys/` 

```bash
lspci # list pci devices
lsusb # list usb devices
lspcmcia # list PCMCIA cards - apt install pcmciautils
lsdev # procinfo package list communication resources used by devices
lsblk # list block devices
lsusb # list usb devices
```

Get readings from all sensor chips
```bash
sensors
```