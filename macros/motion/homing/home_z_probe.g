; home z axis using the z probe
; when using klicky, this will do Z offset calibration

if global.z_probe_type == "klicky"
    ; do "autoz" style homing/calibration
    
    ; first we need to home with nozzle on the endstop
    M98 P"/macros/motion/homing/home_z_endstop.g"
    G91  ; relative
    G1 Y-50  ; otherwise we're in-line with klicky and we can pick it up too early
    ; now we have a baseline. we can do offset calibration now
    M98 P"/macros/motion/probe/klicky/offset_calibration.g"
elif global.z_probe_type == "inductive"
    ; TODO: test this
    M98 P"/macros/motion/homing/can_home_z.g"
    if global.can_home_z == true
        ; lower power in case we screw up and ram into something
        M98 P"/macros/motion/power/z_low.g"

        ; go to center to home, as good a place as any
        M98 P"/macros/motion/positioning/center.g"

        ; do probing operation
        G30

        ; back to high power
        M98 P"/macros/motion/power/z_high.g"

        M98 P"/macros/motion/positioning/zhop_up.g"
    else
        echo "Cannot home"
else
    abort "Unknown Z probe type: ", global.z_probe_type