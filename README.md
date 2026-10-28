# Lenovo TB311FU UEFI

EDK2-based ARM64 UEFI firmware for the **Lenovo TB311FU** tablet, with UEFI Shell, USB serial console, and framebuffer graphics.

## Build

Requires GCC/G++, Make, Python 3, NASM, IASL, and `aarch64-linux-gnu-gcc`.

```sh
git clone --recurse-submodules https://github.com/soumarcelino/lenovo-TB311FU-UEFI.git
cd lenovo-TB311FU-UEFI
./build.sh
```

Output: `Build/TB311FU/DEBUG_GCC5/FV/TB311FU.fd`.
