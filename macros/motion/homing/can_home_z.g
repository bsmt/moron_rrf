; check if we can home Z
; if we are homing with endstop, we can't have klicky attached

if global.z_probe_type == "inductive"
    set global.can_home_z = true
elif global.z_probe_type == "klicky" && global.z_home_style == "endstop"
    ; we can't have klicky attached if we're homing with the endstop
    M98 P"/macros/motion/probe/klicky/poll_klicky.g"
    if global.klicky_attached == true
        set global.can_home_z = false
    else
        set global.can_home_z = true
elif global.z_probe_type == "klicky" && global.z_home_style == "probe"
    echo "TODO: Z probe homing"
else
    echo "ERROR: Unknown probe type"
    echo global.z_probe_type
