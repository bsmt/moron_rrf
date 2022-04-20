; go to the klicky loading position
M98 P"/macros/motion/positioning/klicky.g"

G91  ; relative
G1 Y50 F{global.klicky_load_speed}
G1 X{global.klicky_wipe_distance} F{global.klicky_load_speed}
G1 Y-50 F{global.klicky_load_speed}
G90  ; absolute

M98 P"/macros/motion/probe/klicky/poll_klicky.g"