; Extruder normal power mode

M913 E100  ; current %
M906 E{global.e0_current}  ; current value

; max speed/accel
; configure values in settings.g
M203 E{global.e_max_speed * 60}
M201 E{global.e_max_accel}
M566 E{global.e_max_jerk * 60}

; stall detection
; R2 = pause print when stall detected
; R3 will execute /sys/rehome.g, which we could use
; The S (sensitivity) value hasn't been tuned
; TODO: sensitivity should probably go in settings.g
;M915 P{global.e0_motor} F0 S3 R2