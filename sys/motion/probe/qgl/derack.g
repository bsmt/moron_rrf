; quick QGL variant for gantry deracking

; if you have A1 it will use the slow feedrate, if you supply multiple
var derack_feed = 13  ; mm/s
M558 A1 H30 F{var.derack_feed * 60} K0  ; only probe once and start higher.

M98 P"/sys/motion/probe/qgl/derack_points.g"

M98 P"/sys/motion/probe/init.g"  ; reset probe settings
set global.need_derack = false  ; finalize need_derack flag after init