M290 R0 S0  ; reset babystepping
if global.z_home_method == "endstop"
    M98 P"/sys/motion/homing/home_z_endstop.g"
elif global.z_home_method == "probe"
    M98 P"/sys/motion/homing/home_z_probe.g"
else
    echo "ERROR: Unknown Z home method: ", global.z_home_method
