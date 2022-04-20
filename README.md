# Moron

A mostly from-scratch Voron 2.4 configuration for RepRapFirmware 3.3 or newer.
It takes advantage of RRF 3.3's new GCode meta commands, which lets us write cleaner code and helps streamline procedures.
There is still a good amount of influence and inspiration taken from prior configurations.

Features:
* Configuration via variables in a single settings.g file.

## TODO:

* come up with documentation system for globals created/set by scripts
* Use low current modes as appropriate
** Z hops, homing
* Mesh
* DAA/input shaping
* nozzle wiping
* nevermore stuff
* inductive everything
* startup script (homing, preheating, leveling, etc)
* print start script
* cleanup once everything is done-ish

## Development

There are a few janky scripts provided to ease development, under the util directory.

duet_fw_backup.py will backup your SD card over the HTTP interface, so you don't lose your prior configuration.
It usually works fine, but you should double check that every thing is accounted for.

duet_fw_upload.py will (optionally) wipe your old gcode configs and upload this one.

lint.py will check the gcode for some common errors. It's by no means exhaustive, but it can still save a lot of time.

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