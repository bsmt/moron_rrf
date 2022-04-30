; check if we can home Z
; if we are homing with endstop, we can't have klicky attached

if global.z_probe_type == "inductive"
    set global.can_home_z = true
elif global.z_probe_type == "klicky"
    ; we can't have klicky attached in any case when Z homing
    M98 P"/sys/motion/probe/klicky/poll_klicky.g"
    if global.klicky_attached == true
        M402  ; try to put it back
        M98 P"/sys/motion/probe/klicky/poll_klicky.g"
        if global.klicky_attached == true  ; we still couldn't put it back
            ; not aborting here, callers can do that
            set global.can_home_z = false
        else  ; okay that worked. cool
            set global.can_home_z = true
    else
        set global.can_home_z = true
; old pre-calibration method. obsolete but i'm leaving it for now
elif global.z_probe_type == "klicky" && global.z_home_method == "probe_old"
    ; we want klicky attached if we're homing with it
    M98 P"/sys/motion/probe/klicky/poll_klicky.g"
    if global.klicky_attached == true
        set global.can_home_z = true
    else
        set global.can_home_z = false
else
    abort "ERROR: Unknown probe type: ", global.z_probe_type
