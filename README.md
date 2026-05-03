![MakeMKV Logo](images/makemkv.png "MakeMKV ™️")

# makemkvcon — Debian Packaging

Debian packaging for [MakeMKV](https://www.makemkv.com/) CLI tools targeting Ubuntu Noble (24.04). This repository builds and packages the MakeMKV command-line interface and its supporting open-source libraries into four installable `.deb` packages.

## Packages

| Package            | Description                                                               |
| ------------------ | ------------------------------------------------------------------------- |
| `makemkvcon`       | MakeMKV command-line interface binary and runtime data                    |
| `libmakemkv-oss`   | Open-source shared libraries and helper binaries (`mmccextr`, `mmgplsrv`) |
| `makemkv-sdftools` | `sdftool` utility for flashing LibreDrive firmware to compatible drives   |
| `makemkv-firmware` | LibreDrive firmware files for supported internal and slim optical drives  |

## EULA

The `makemkvcon` binary and `sdftool` are **proprietary software** distributed by GuinpinSoft inc. under the [MakeMKV End User License Agreement](doc/eula). The open-source components (`libmakemkv-oss`) are licensed separately under their respective open-source licenses.

Key points from the EULA:

- Use is permitted on personal computers for personal use only.
- You may not sell, rent, lease, or sublicense the software.
- You may not reverse engineer, decompile, or disassemble the software.
- The software may bypass copy protection mechanisms — you are responsible for ensuring your use complies with applicable local laws.
- Redistribution is permitted in original, unmodified form. Distribution-specific repackaging (such as this) is explicitly allowed as a special exception, provided program files and the license remain unchanged.

During installation, `makemkvcon` will prompt you to read and accept the EULA. Acceptance is recorded in `/etc/makemkv/eula.conf`. Installation will abort if the EULA is not accepted.

## Building

### Dependencies

```sh
sudo apt install debhelper libexpat1-dev libavcodec-dev zlib1g-dev boa pandoc
```

### Build packages

```sh
# Compile open-source components
make all

# Build .deb packages
debian/rules binary
```

### Build a single component (for development)

```sh
# Shared libraries and helper binaries only
make _build/libmakemkv.so.1
make _build/libdriveio.so.0
make _build/libmmbd.so.0
make _build/mmccextr
make _build/mmgplsrv

# Debug build (no stripping)
make ENABLE_DEBUG=yes all
```

```sh
# Clean all build artifacts
make clean
```

## Current version

MakeMKV **1.18.3** — see [debian/changelog](debian/changelog) for the full release history.
