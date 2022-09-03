# Linux Kernel

## Hardware

The kernel exports data about detected hardware through the `/proc/` and `/sys/` virtual file systems. Applications often access devices by way of files created within `/dev/`. Specific files represent disk drives (for instance, `/dev/sda`), partitions (`/dev/sda1`), mice (`/dev/input/mouse0`), keyboards (`/dev/input/event0`), sound cards (`/dev/snd/*`), serial ports (`/dev/ttyS*`), and other components.

Types of device files avaliable are block and character.
Block device files types have a finite size, and you can access bytes at any position in the block. 
Character can read and write characters, but you cannot seek to a given position and change arbitrary bytes. To find out the type of a given device file, inspect the first letter in the output of `ls -l` as it is either `b`, for block devices, or `c`, for character devices.

## File System

The kernel role regarding the [[Linux-File-System]] is to translate between this naming system and the storage location on a disk. 

## Processes

On single core system the kernel is in charge of creating and tracking processes. It divides the CPUs resources to running each process, although seemingly in parellel it is similar to a human brain in the linearly switch between tasks, but rapidly for short intervals of each process. It is adjust its scheduling mechanisms to maintaince system integrity, while maximising global system performance. If the intervals are too long it makes the system seem inresponsive and too short will increase the time switch between processes. On a multicore system the cores of the cpu are divide up on the same abstraction to perform parallelism not achievable with a single core. 

For each Process the Kernel wil:
1. Allocate memory
2. Loads executable into that assign allocation of memory
3. Starts the code
4. Then retain information about the running process, like PID

For more see [[Linux-Processes]]

## Rights Management
[[Linux-Permissions-and-Rights]]


## References


https://www.kernel.org/
https://en.wikipedia.org/wiki/Linux_kernel