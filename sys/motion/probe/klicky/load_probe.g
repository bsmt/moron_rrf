; pick up the klicky probe from the dock

; go to the klicky loading position
M98 P"/sys/motion/positioning/klicky.g"

G91  ; relative
G1 Y50 F{global.klicky_load_speed}
G1 Y-50 F{global.klicky_load_speed}
G90  ; absolute

M98 P"/sys/motion/probe/klicky/poll_klicky.g"