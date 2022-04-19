; check if we can home Z
; if we are homing with endstop, we can't have klicky attached

if global.z_probe_type == "inductive"
    set global.can_home_z = true
elif global.z_probe_type == "klicky"
    set global.can_home_z = false
else
    echo "ERROR: Unknown probe type"
    echo global.z_probe_type
