# Moron

A mostly from-scratch Voron 2.4 configuration for RepRapFirmware 3.3 or newer.
It takes advantage of RRF 3.3's new GCode meta commands, which lets us write cleaner code and helps streamline procedures.
There is still a good amount of influence and inspiration taken from prior configurations.

Features:
* Configuration via variables in a single settings.g file.

## TODO:

* homing scripts
* Use low current modes as appropriate
** Z hops, homing
* Mesh
* Klicky stuff
** deployprobe.g, retractprobe.g
** init.g
** "autoz"
* DAA/input shaping
* nozzle wiping
* nevermore stuff
* chamber thermistor/heating stuff  
* cleanup once everything is done-ish

## Development

There are a few janky scripts provided to ease development, under the util directory.

duet_fw_backup.py will backup your SD card over the HTTP interface, so you don't lose your prior configuration.
It usually works fine, but you should double check that every thing is accounted for.

duet_fw_upload.py will (optionally) wipe your old gcode configs and upload this one.

lint.py will check the gcode for some common errors. It's by no means exhaustive, but it can still save a lot of time.

### Resources

Duet Gcode dictionary: https://docs.duet3d.com/en/User_manual/Reference/Gcodes

Duet GCode meta commands: https://docs.duet3d.com/User_manual/Reference/Gcode_meta_commands

Duet object model: https://github.com/Duet3D/RepRapFirmware/wiki/Object-Model-Documentation

Duet best practices: https://forum.duet3d.com/assets/uploads/files/1589979002114-conditional-g-code-best-practice.pdf