var fast_feed = 13  ; mm/s
var slow_feed = 2  ; mm/s
var move_speed = 100  ; mm/s
;var start_height = 1.45  ; mm
var start_height = 10  ; mm  TODO: reduce
var settle_time = 0.1  ; s
var repeat = 7  ; this is a max, not a constant number of repetitions
var tolerance = 0.005  ; mm

; breaking up the variables to meet line length requirements (160 char)
var fast = (var.fast_feed * 60)
var slow = (var.slow_feed * 60)
M558 H{var.start_height} R{var.settle_time} F{var.fast, var.slow} T{var.move_speed * 60} A{var.repeat} S{var.tolerance} B1 K0
G31 P{global.klicky_triggered_val} X{global.probe_x_offset} Y{global.probe_y_offset} Z0

M98 P"/sys/motion/probe/klicky/poll_klicky.g"  ; update klicky_attached so it's actually valid