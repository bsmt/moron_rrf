; position klicky over the Z endstop

; the actual switch of klicky is in line with the nozzle
; that means the switch tip will be touching the endstop, which may screw up our numbers
; if we move to the left a little, we can make sure just the switch body touches the endstop
var klicky_x_offset = 7  ; mm

G90  ; absolute
G1 X{global.z_endstop_x - global.probe_x_offset - var.klicky_x_offset} Y{global.z_endstop_y - global.probe_y_offset} F{global.fast_move_feed}