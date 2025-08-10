#  64-bit Operating System

32-bit operating system (transitioning to 64-bit) built using NASM and grub.
Designed to boot via GRUB2 and run in QEMU for simulation


## Overview

- 64-bit bootable kernel (NASM-based)
- GRUB multiboot2 
- ELF64 binary output
- Bootable ISO image generation
- QEMU for virtualization support



## Current stage
- Working on : auto printing features

---

## Structure

| File / Folder     | Description |
|------------------|-------------|
| `header.asm`     | Define the Multiboot2 header to make the kernel bootable via GRUB. |
| `main.asm`       | Kernel entry point. Writing directly to VGA memory. |
| `linker.ld`      | Custom GNU LD linker script. Format kernel sections in ELF64 standards. |
| `Makefile`       | Build automation, ISO creation, and QEMU run. |
| `boot/grub.cfg`  | GRUB2 configuration file to locate and load the kernel. |


---

## Dependencies 

All required system packages are listed in [`packages.txt`](./packages.txt).

<details>
<summary><strong> Debian / Ubuntu</strong></summary>

```bash
sudo xargs -a packages.txt apt install -y
```

</details> <details> <summary><strong> Arch Linux / Manjaro</strong></summary>

```bash
sudo pacman -S --needed $(< packages.txt)
```
</details> <details> <summary><strong> MacOs </strong></summary>

```bash
xargs brew install < packages.txt

NOTE: GRUB is not officially supported via Homebrew.
For ISO generation, consider using a Linux VM or Docker container
```
---

## Build

Enter build environment: 

- Windows(PowerShell): docker run --rm -it -v "C:\Users\<username>\<filepath>\C-OS:/root/env" <buildenv_name>
- MacOS: docker run --rm -it -v /Users/<username>/<filepath>/C-OS:/root/env <buildenv_name>
- Linux: docker run --rm -it -v /home/<username>/<filepath>/C-OS:/root/env <buildenv_name>

Build for x86 architecture: 

- make build-x86_64

NOTE: To leave build environment, type 'exit' in terminal.

Emulate the system using Qemu: 

-  qemu-system-x86_64 -cdrom dist/x86_64/kernel.iso         

Qemu must be added to file path.
 
---