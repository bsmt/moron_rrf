var fast_feed   = 13   ; mm/s
var slow_feed   = 1    ; mm/s
var move_speed  = 12   ; mm/s
var start_height = 10  ; mm
var settle_time = 0.5  ; s
var repeat      = 3    ; will do one fast probe followed by N slow probes
var tolerance   = 0.02 ; mm
var trigger     = 1000
var x_offset    = 0    ; mm
var y_offset    = 25   ; mm

; breaking up the variables to meet line length requirements (160 char)
var slow = var.slow_feed * 60
var fast = var.fast_feed * 60
M558 P5 C{global.z_probe_pin} H{var.start_height} F{var.fast}:{var.slow} T{var.move_speed * 60} R{var.settle_time} A{var.repeat} S{var.tolerance} B1 K0

; probe z offset configured in settings.g
; TODO: G31 temp compensation (S and T params)
G31 P{var.trigger} X{var.x_offset} Y{var.y_offset} Z{global.z_probe_offset}
