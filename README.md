# Moron

A mostly from-scratch Voron 2.4 configuration for *RepRapFirmware 3.4 or newer*.
There is still a good amount of influence and inspiration taken from prior configurations.
But, we try to integrate everything into a more cohesive config layout.
It makes heavy use of RRF 3.3's new GCode meta commands, which lets us write cleaner code and helps streamline procedures.

## Features
* Configuration via variables in a single config.g file. You don't have to dig through and edit every file to support your printer, unless you want to change the specific behavior of a procedure.
* "Native" support for Klicky probes with automatic Z offset calibration (auto-z). Inductive is also supported with a single config line change.

## Status

All of the core features are working fine. I've been using this config exclusively for about two months now.
It can definitely be polished further, and could use some quality of life improvements.
But, I think it is still a lot easier to work with than other Voron RRF config's I've used in the past.

## TODO

* make move speeds more consistent
* fix stall detection
* make PA calibration macro
* write testing macros
* come up with documentation system for globals created/set by scripts
* DAA/input shaping
* nozzle wiping
* startup script (homing, preheating, leveling, etc)
* cleanup once everything is done-ish
* documentation

## Development

There are a few janky scripts provided to ease development, under the util directory.

duet_fw_backup.py will backup your SD card over the HTTP interface, so you don't lose your prior configuration.
It usually works fine, but you should double check that every thing is accounted for.

duet_fw_upload.py will (optionally) wipe your old gcode configs and upload this one.

lint.py will check all of the gcode for some common errors. It's by no means exhaustive, but it can save a lot of time.

Using a direct serial connection via USB will make debugging early startup code a lot easier. I like to use pyserial, which you can use like so:

```bash
$ pip install pyserial
# figure out where the port is
$ python -m serial.tools.list_ports
COM3
1 ports found
$ python -m serial.tools.miniterm COM3 115200
--- Miniterm on COM3  115200,8,N,1 ---
RepRapFirmware for Duet 2 WiFi/Ethernet version 3.3
Executing config.g... Moron config v0.1 initializing
FTP is enabled on port 21
TELNET is disabled
Warning: Macro file config-override.g not found
Moron initialization done
Done!
RepRapFirmware for Duet 2 WiFi/Ethernet is up and running.
```

Note that when you reset, you will lose the connection. You have to be quick and start it up again right after you reset.

### Resources

Gcode dictionary: https://docs.duet3d.com/en/User_manual/Reference/Gcodes

GCode meta commands: https://docs.duet3d.com/User_manual/Reference/Gcode_meta_commands

Object model: https://github.com/Duet3D/RepRapFirmware/wiki/Object-Model-Documentation

Best practices: https://forum.duet3d.com/assets/uploads/files/1589979002114-conditional-g-code-best-practice.pdf

Printer config guide: https://docs.duet3d.com/User_manual/Machine_configuration