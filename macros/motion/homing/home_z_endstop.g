; home Z axis using the endstop switch

var fast_speed = 10  ; mm/s
var slow_speed = 1  ; mm/s

; lower power in case we screw up and ram into something
M98 P"/macros/motion/power/z_low.g"

; move to Z endstop XY position
M98 P"/macros/motion/positioning/z_endstop.g"

G91  ; relative

; first fast homing operation
G1 H1 Z{global.z_max * -1} F{var.fast_speed * 60}
G1 H0 Z3

; we're safe to use full power now
M98 P"/macros/motion/power/z_high.g"

; follow-up slow home
G1 H1 Z-5 F{var.slow_speed * 60}
G1 H0 Z10 F{var.fast_speed * 60}

; TODO: do we need to set an offset?