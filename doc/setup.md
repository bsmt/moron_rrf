# Moron Setup

This is a rough procedure to *safely* get your printer running with this configuration.

## SD/Wifi Setup

If this is a fresh install, you'll need to setup the SD card with RepRapFirmware first.

Follow this guide: https://duet3d.dozuki.com/Wiki/SD_Card.

And this guide: https://duet3d.dozuki.com/Wiki/Installing_and_Updating_Firmware

You can use the (configtool)[https://configtool.reprapfirmware.org/] to get an initial directory. Just select whatever base config, make sure you select the correct base board and firmware version, and then click next until you can download a zip. Note that this configuration requires 3.4 or newer. We're going to overwrite everything in /sys and /macros anyways, so the config doesn't matter. Extract the zip and copy over the firmware and www directories to your SD card. Then, copy the sys and macros directories from this repository to your SD card.

If the firmware version provided by configtool is not new enough, or if you just want to update to the latest, download the Duet2And3Firmware-*.zip file from https://github.com/Duet3D/RepRapFirmware/releases. Then, open the Duet web panel, go to Settings/Machine-Specific and click Install Update. Then upload the zip and wait for it to finish. Now you should be at the latest version.

## Initial Config Changes

Go through sys/config.g and edit the basic machine-specific variables. For now, you should adjust the following at a minimum:

* Min/Max sizes. `x_min`, `x_max`, `y_min`, `y_max`, etc.
* Endstop pins. `x_endstop_pin`, `y_endstop_pin`, `z_endstop_pin`.
* Motor pins. `a_motor`, `b_motor`, `z0_motor`, `z1_motor`, `z2_motor`, `z3_motor`, `e0_motor`.

Don't worry about Z probe stuff for now. We'll get to the rest once we know X and Y are good.

## Verifying Endstops and X/Y Movement

Once you're satisfied with changes, push them to the printer and reset. Don't home anything just yet, we want the motors to be unpowered.

We can use the `M119` code to query endstop and probe state. Go to the console in the Duet web UI and test it out. You should manually actuate your endstops and run `M119` a few times to make sure they're behaving as expected. It needs to say say "at max stop" for X and Y endstops when they are engaged. If things aren't working correctly, double check your endstop pin configuration and make sure the endstop itself is fine.

Once the endstops themselves are working, we want to make sure the printhead engages with them correctly. With the A and B motors unpowered, *slowly* move the printhead towards the right side of the X axis. Once it reaches the maximum, run `M119` again and make sure the endstop is triggering. Do the same for the Y axis. It is *extremely* important that you move the printhead slowly. Driving the motors manually causes current to be generated, and Duet boards cannot handle a significant amount of back-current. If you go slow, it should be fine. If you want to be safe, power everything off and disconnect the motors. *NEVER* disconnect motors when the printer is powered on.

Alright, endstops are done, time for X and Y movement. Make sure the printhead is in a safe place with a good amount of room. Now, manually set the X and Y coordinates with `G92`. For instance, if the printhead is close to the center, you could do `G92 X150 Y150` to force the controller to think we are in the center. Now, move the printhead 10mm or so in the positive direction. A positive X move should move the printhead to the *right*, toward the endstop. A positive Y move should move the printhead *back*. If this is not happening, consult the official Voron motor config guide [here](https://docs.vorondesign.com/build/startup/#motor-configuration-guides).

At this point we should have *verified* working endstops and X/Y motion. Now you can test homing. Just click the "Home X" and "Home Y" buttons and make sure everything goes smoothly. If you want to be cool, you can run `G28 XY` from the console to home X and Y.

## Setting Positions

