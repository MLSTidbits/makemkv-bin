---
title: MAKEMKVCON
section: 1
date: 2026-03-28
header: Command-line interface for MakeMKV
footer: MAKEMKVCON
author:
  MLS Tidbits <contact@mlstidbits.com>
version: 1.0
---

# NAME

_sdftool_ - Command-line interface for flashing LibreDrive firmware to compatible optical drives.

# SYNOPSIS

_sdftool_ [switches/options] `command` [parameters]

# DESCRIPTION

_sdftool_ is a command-line interface for flashing LibreDrive firmware to compatible optical drives. It allows users to perform various tasks such as listing available drives, flashing firmware, and managing drive settings through the command line. This tool is particularly useful for automation and scripting purposes, enabling users to integrate LibreDrive functionality into their workflows without the need for a graphical user interface.

# OPTIONS

## Built-in Commands

`-l`, `--list`
: List all compatible optical drives connected to the system.

`--tips`[=addr]
: Start the built-in web server to provide flashing tips and instructions. Optionally specify the address to bind the server to (default is localhost).

`--info`
: Print detailed information about the connected optical drive, including model, firmware version, and compatibility status.

`--help`
: Display this help message and exit.

`--version`
: Print the version of _sdftool_ and exit.

## Switches

`-d` drive, `--drive`=drive
: Specify the target optical drive for the operation.

`-n`, `--no-drive`
: Use a dummy drive for testing purposes, without requiring an actual optical drive to be connected.

`-i` /path/to/firmware, `--input`=/path/to/firmware
: Specify input firmware file to be flashed to the drive. May be used multiple times.

`-o` /path/to/output, `--output`=/path/to/output
: Specify directory for output files such as logs or backup firmware. Default is the current working directory.

`--verbose`
: Enable verbose output for debugging and detailed information during operations.

`--all-yes`
: Anser "yes" to all prompts, allowing for non-interactive operation. Use with caution as this may lead to unintended consequences.

`-f` /path/to/SDF.bin, `--sdf-file`=/path/to/SDF.bin
: Specify the path to the SDF file to be used during the operation.

`sdf-version`=version
: Specify the version of the SDF file being used. This may be required for compatibility checks and to ensure the correct flashing process is followed.
