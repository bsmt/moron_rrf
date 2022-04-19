M98 P"/macros/motion/homing/can_home_z.g"

; TODO: if we're using klicky and can_home_z is false, we can try putting klicky back
if global.can_home_z == true
    M290 R0 S0  ; reset babystepping
    if global.z_home_style == "endstop"
        M98 P"/macros/motion/homing/home_z_endstop.g"
    elif global.z_home_style == "probe"
        M98 P"/macros/motion/homing/home_z_probe.g"
    else
        echo "ERROR: Unknown Z home method: ", global.z_home_style
else
    echo "Cannot home Z. Check probe"