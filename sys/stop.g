; print stop procedure. called via M0
; note that this won't be automatically called at the end of a print
; so you need your slicer to output an M0 at the end

G91  ; relative positioning mode
G1 Z50  ; move up 50mm

M98 P"/sys/motion/positioning/park.g"

; turn off heaters
M104 S0
M140 S0