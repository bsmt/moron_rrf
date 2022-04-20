; home z axis using the z probe

M401  ; load probe, if necessary. this won't do anything for inductive

M98 P"/macros/motion/homing/can_home_z.g"

if global.can_home_z == true
    ; do a zhop if we're too low
    if move.axes[2].machinePosition < 10.0  ; TODO: will Z always be move.axes[2]?
        M98 P"/macros/motion/positioning/zhop_up.g"

    ; lower power in case we screw up and ram into something
    M98 P"/macros/motion/power/z_low.g"

    ; go to center to home, as good a place as any
    M98 P"/macros/motion/positioning/center.g"

    ; do probing operation
    G30

    ; back to high power
    M98 P"/macros/motion/power/z_high.g"

    M98 P"/macros/motion/positioning/zhop_up.g"
    M402  ; put probe back
else
    echo "Cannot home"