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

_makemkvcon_ - Command-line interface for MakeMKV

# SYNOPSIS

_makemkvcon_ [switches/options] `command` [parameters]

# DESCRIPTION

_makemkvcon_q is a command-line interface for MakeMKV, a software application that converts video files from proprietary formats to more common formats. It allows users to perform various tasks such as ripping DVDs and Blu-rays, managing disc drives, and controlling the MakeMKV application through the command line. This tool is particularly useful for automation and scripting purposes, enabling users to integrate MakeMKV functionality into their workflows without the need for a graphical user interface.

# OPTIONS

## General options

`--progress`=file
: Output all progress messages to file. The same special file names as in --messages are recognized with additional value "-same" to output to the same file as messages. Naturally --progress should follow --messages in this case. Default is no output.

`--debug`[=file]
: Enables debug messages and optionally changes the location of debug file. Default: program preferences.

`--directio`=true/false
: Enables or disables direct disc access. Default: program preferences.

`--noscan`
: Don't access any media during disc scan and do not check for media insertion and removal. Helpful when other applications already accessing discs in other drives.

`--cache`=size
: Specifies size of read cache in megabytes used by MakeMKV. By default program uses huge amount of memory. About 128 MB is recommended for streaming and backup, 512MB for DVD conversion and 1024MB for Blu-ray conversion.

## Streaming options

`--upnp`=true/false
: Enable or disable UPNP streaming. Default: program preferences.

`--bindip`=address string
: Specify IP address to bind. Default: None, UPNP server binds to the first available address and web server listens on all available addresses.

`--bindport`=port
: Specify web server port to bind. Default: 51000.

## Backup options

: Decrypt stream files during backup. Default: no decryption.

Conversion options:

`--minlength`=seconds
: Specify minimum title length. Default: program preferences.

## Automation options

`-r`, `--robot`
: Enables automation mode. Program will output more information in a format that is easier to parse. All output is line-based and output is flushed on line end. All strings are quoted, all control characters and quotes are backlash-escaped. If you automate this program it is highly recommended to use this option. Some options make reference to apdefs.h file that can be found in MakeMKV open-source package, included with version for Linux. These values will not change in future versions.

# Message formats

Message output

    MSG:code,flags,count,message,format,param0,param1,...

    code - unique message code, should be used to identify particular string in language-neutral way.

    flags - message flags, see AP_UIMSG_xxx flags in apdefs.h

    count - number of parameters

    message - raw message string suitable for output

    format - format string used for message. This string is localized and subject to change, unlike message code.

    paramX - parameter for message

Current and total progress title

- PRGC:code,id,name
  - PRGT:code,id,name
  - code - unique message code
  - id - operation sub-id
  - name - name string

Progress bar values for current and total progress

- PRGV:current,total,max
  - current - current progress value
  - total - total progress value
  - max - maximum possible value for a progress bar, constant

Drive scan messages

- DRV:index,visible,enabled,flags,drive name,disc name
  - index - drive index
  - visible - set to 1 if drive is present
  - enabled - set to 1 if drive is accessible
  - flags - media flags, see AP_DskFsFlagXXX in apdefs.h
  - drive name - drive name string
  - disc name - disc name string

Disc information output messages

- TCOUT:count
  - count - titles count

Disc, title and stream information

- CINFO:id,code,value
- TINFO:id,code,value
- SINFO:id,code,value

- id - attribute id, see AP_ItemAttributeId in apdefs.h
- code - message code if attribute value is a constant string
- value - attribute value

Examples:

Copy all titles from first disc and save as MKV files:
_makemkvcon_ mkv disc:0 all c:\folder

List all available drives

    makemkvcon -r --cache=1 info disc:9999

Backup first disc decrypting all video files in automation mode with progress output

    makemkvcon backup --decrypt --cache=16 --noscan -r --progress=-same disc:0 /path/to/backup

Start streaming server with all output suppressed on a specific address and port

    makemkvcon stream --upnp=1 --cache=128 --bindip=192.168.1.102 --bindport=51000 --messages=-none

# LICENSE

EULA (End User License Agreement) Copyright (C) 2007-2024 GuinpinSoft inc All rights reserved.
