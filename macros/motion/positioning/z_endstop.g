; move XY to be directly over the Z switch
; positions are defined in sys/settings.g as:
; global.z_endstop_x, global.z_endstop_y

G90  ; absolute

G1 X{global.z_endstop_x} Y{global.z_endstop_y} F{global.fast_move_feed}