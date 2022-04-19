; lower power motor settings to mitigate damage in the event of a crash during movement procedures
var low_current = 600 ; mA
M906 Z{var.low_current}

var low_speed = 25   ; mm/s 
var low_accel = 400  ; mm/s^2
var low_jerk  = 0    ; mm/s

M203 Z{var.low_speed * 60} 
M201 Z{var.low_accel}
M566 Z{var.low_jerk * 60}

; stall detection is already configured in z_high