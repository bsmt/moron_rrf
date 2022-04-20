; we end up calling this multiple times during QGL, so we need these guards
if !exists(global.klicky_attached)
    global klicky_attached = false  ; tracking if the klicky is attached to the toolhead

if !exists(global.klicky_triggered_val)
    global klicky_triggered_val = 1000
if !exists(global.klicky_idle_val)
    global klicky_idle_val = 0

if !exists(global.klicky_load_speed)
    global klicky_load_speed = (50 * 60)  ; 50 mm/s in mm/min

var fast_feed = 13  ; mm/s
var slow_feed = 1  ; mm/s
var move_speed = 50  ; mm/s
;var start_height = 1.45  ; mm
var start_height = 3  ; mm
var settle_time = 0.1  ; s
var repeat = 5
var tolerance = 0.01  ; mm
var x_offset = 0  ; mm
var y_offset = 25  ; mm

; breaking up the variables to meet line length requirements (160 char)
var fast = (var.fast_feed * 60)
var slow = (var.slow_feed * 60)
M558 P5 C{global.z_probe_pin} H{var.start_height} R{var.settle_time} F{var.fast}:{var.slow} T{var.move_speed * 60} A{var.repeat} S{var.tolerance} B1 K0
G31 P{global.klicky_triggered_val} X{var.x_offset} Y{var.y_offset} Z0

M98 P"/macros/motion/probe/klicky/poll_klicky.g"  ; update klicky_attached so it's actually valid