; parameter for Z offset calibration (klicky auto-Z)
var calibrate = 0
if exists(param.C)
    set var.calibrate = param.C

M290 R0 S0  ; reset babystepping
if global.z_home_method == "endstop"
    M98 P"/sys/motion/homing/home_z_endstop.g" C{var.calibrate}
elif global.z_home_method == "probe"
    M98 P"/sys/motion/homing/home_z_probe.g" C{var.calibrate}
else
    echo "ERROR: Unknown Z home method: ", global.z_home_method
