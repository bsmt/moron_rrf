; check that we can home XY
; this mostly applies to klicky, as we don't want to home with it attached

if global.z_probe_type == "inductive"
    set global.can_home_xy = true
elif global.z_probe_type == "klicky"
    M98 P"/sys/motion/probe/klicky/poll_klicky.g"
    if global.klicky_attached == true
        set global.can_home_xy = false
    else
        set global.can_home_xy = true
else
    echo "ERROR: Unknown probe type"
    echo global.z_probe_type
