; set normal drive current, speeds, etc. for A/B motors

M913 X100 Y100  ; current %
M906 X{global.a_current} Y{global.b_current}  ; current values

; max speed/accel
; configure values in settings.h
M203 X{global.x_max_speed * 60} Y{global.y_max_speed * 60}  ; max feedrate
M201 X{global.x_max_accel} Y{global.y_max_accel}  ; max accel
M205 X{global.x_max_jerk} Y{global.y_max_jerk}  ; max jerk

; configure stall detection
; R2 = pause print when stall detected
; R3 will execute /sys/rehome.g, which we could use
; The S (sensitivity) value hasn't been tuned
; TODO: sensitivity should probably go in settings.g
M915 X Y S1 F0 R2

; TODO: input shaping

; TODO use M201.1 (new in RRF3.4) to set accel for probe moves?