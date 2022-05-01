; Z normal power mode

M913 Z100                 ; current %
M906 Z{global.z_current}  ; current value

; max speed/accel
; configure values in settings.g
M203 Z{global.z_max_speed * 60}  ; max feedrate
M201 Z{global.z_max_accel}       ; max accel
M566 Z{global.z_max_jerk * 60}   ; max jerk

; configure stall detection
; R2 = pause print when stall detected
; R3 will execute /sys/rehome.g, which we could use
; The S (sensitivity) value hasn't been tuned
; TODO: sensitivity should probably go in settings.g F1 R2
;M915 P{global.z0_motor}:{global.z1_motor}:{global.z2_motor}:{global.z3_motor} S3 F1 R2

; TODO use M201.1 (new in RRF3.4) to set accel for probe moves?
