var z_hop_feed = 25  ; mm/s

M98 P"/macros/motion/power/z_low.g"
G91    ; relative coordinates
G1 H2 Z{global.z_hop_distance} F{var.z_hop_feed * 60}  ; move up, ignoring endstops
G90
M98 P"/macros/motion/power/z_high.g"