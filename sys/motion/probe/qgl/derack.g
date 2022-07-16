; quick QGL variant for gantry deracking

var derack_feed = 5
var derack_height = 30
if global.z_probe_type == "klicky"
    ; if you have A1 it will use the slow feedrate, if you supply multiple
    set var.derack_feed = 13  ; mm/s
    set var.derack_height = 30
elif global.z_probe_type == "inductive"
    set var.derack_feed = 15
    set var.derack_height = 10

M558 A1 H{var.derack_height} F{var.derack_feed * 60} K0  ; only probe once and start higher.

M98 P"/sys/motion/probe/qgl/derack_points.g"

M98 P"/sys/motion/probe/init.g"  ; reset probe settings
set global.need_derack = false  ; finalize need_derack flag after init