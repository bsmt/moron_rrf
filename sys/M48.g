; Probe repeatability test
; use S parameter to customize number of samples

var n_tests = 25
if exists(param.S)
    set var.n_tests = param.S

M401

; move to XY position ahead of time
; otherwise it will do a diagonal XYZ move, which can cause klicky to hit the bed
; this is similar to an issue i had in mesh_scan.g
M98 P"/sys/motion/positioning/center.g"

var max_iter = var.n_tests - 1
while iterations < var.max_iter    
    G30 P{iterations} X{var.x_center} Y{var.y_center} Z-99999
; last probe
G30 P{var.n_tests} X{var.x_center} Y{var.y_center} Z-99999 S-1

M402