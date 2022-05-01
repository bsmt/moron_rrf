G91  ; relative positioning mode
G1 Z50  ; move up 50mm

M98 P"/sys/motion/positioning/center.g"

; turn off heaters
M104 S0
M140 S0