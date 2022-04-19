global klicky_attached = false  ; tracking if the klicky is attached to the toolhead

global klicky_triggered_val = 1000
global klicky_idle_val = 0

global klicky_load_speed = (50 * 60)  ; 50 mm/s in mm/min

var feed = 1  ; mm/s
var move_speed = 12  ; mm/s
var start_height = 1.45  ; mm
var settle_time = 0.1  ; s
var repeat = 5
var tolerance = 0.01  ; mm
var x_offset = 0  ; mm
var y_offset = 25  ; mm

M558 P5 C{global.z_probe_pin} H{var.start_height} R{var.settle_time} F{var.feed * 60} T{var.move_speed * 60} A{var.repeat} S{var.tolerance} B1 K0
G31 P{global.klicky_triggered_val} X{var.x_offset} Y{var.y_offset}

M98 P"/macros/motion/probe/klicky/poll_klicky.g"  ; update klicky_attached so it's actually valid