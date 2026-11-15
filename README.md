# Bootysplash

**[Download bootysplash-a67lg1.zip](https://github.com/CyberspaceVii/bootysplash-a67lg1/releases/download/v0.3/bootysplash-a67lg1.zip)**


Custom power-on logo, boot animation and boot sound for the Foxxd A67L Gen 1.

A KernelSU Next module for the **Foxxd A67L Gen 1**. Gen 2 version: [bootysplash-a67lg2](https://github.com/CyberspaceVii/bootysplash-a67lg2).

Built from the Gen 1 stock firmware; not yet tested on Gen 1 hardware. Reports welcome.

Replaces the power-on logo, the boot animation and the boot sound.

## Requirements

- Foxxd A67L Gen 1
- Rooted with KernelSU Next

The installer stops without changing anything if either is missing.

## Install

1. Download [`bootysplash-a67lg1.zip`](https://github.com/CyberspaceVii/bootysplash-a67lg1/releases/latest/download/bootysplash-a67lg1.zip) (latest release).
2. KernelSU Next → Modules → Install from storage → select the zip.
3. Reboot.

## Uninstall

Remove the module in KernelSU Next and reboot.

The boot animation and sound are systemless. The power-on logo isn't: the bootloader reads it straight
from the `logo` and `fbootlogo` partitions. So the installer backs up the originals to
`/data/adb/cyberspacevii/bootysplash-a67lg1/` before writing, and uninstalling writes them back.

## License

[WTFPL](LICENSE).

---

CyberspaceVII · https://www.cyberspace7.org
