; lower power motor settings to mitigate damage in the event of a crash during movement procedures
var low_current = 800  ; mA
M906 X{var.low_current} Y{var.low_current}

; lower speeds/accel to compensate for lower power
var low_speed = 100  ; mm/s
var low_accel = 800  ; mm/s^2 
var low_jerk  = 2    ; mm/s
M203 X{var.low_speed * 60} Y{var.low_speed * 60}   ; max speed
M201 X{var.low_accel} Y{var.low_accel}             ; maximum accel
M566 X{var.low_jerk * 60} Y{var.low_jerk * 60}     ; instantaneous speed change (mm/min)

; stall detection doesn't need to be configured here, since xy_high is already called by motion init