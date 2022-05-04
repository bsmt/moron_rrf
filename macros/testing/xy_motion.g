; performs a bunch of XY moves across the whole range, while ramping up speed

var offset = 25  ; mm, subtracted from X/Y max. may need to be increased if you run into klicky

var start_speed = 100  ; mm/s
var end_speed   = 300  ; mm/s
var interval    = 100   ; mm/s
var iterations  = 1   ; number of cycles per-speed


M98 P"/sys/motion/positioning/zhop_up.g"  ; safety hop

G90

var current_speed = var.start_speed
while var.current_speed <= var.end_speed
    var iter = 0
    while var.iter < var.iterations
        ; trying to do moves in all possible up/down/left/right and diagonal directions
        ; front left
        G1 X{global.x_min + var.offset} Y{global.y_min + var.offset} F{var.current_speed * 60}
        ; back right (/+)
        G1 X{global.x_max - var.offset} Y{global.y_max - var.offset} F{var.current_speed * 60}
        ; back left (<-)
        G1 X{global.x_min + var.offset} Y{global.y_max - var.offset} F{var.current_speed * 60}
        ; front left (V)
        G1 X{global.x_min + var.offset} Y{global.y_min + var.offset} F{var.current_speed * 60}
        ; front right (->)
        G1 X{global.x_max - var.offset} Y{global.y_min + var.offset} F{var.current_speed * 60}
        ; back right (^)
        G1 X{global.x_max - var.offset} Y{global.y_max - var.offset} F{var.current_speed * 60}
        ; front left (+/)
        G1 X{global.x_min + var.offset} Y{global.y_min + var.offset} F{var.current_speed * 60}
        ; back left (^)
        G1 X{global.x_min + var.offset} Y{global.y_max - var.offset} F{var.current_speed * 60}
        ; front right (\+)
        G1 X{global.x_max - var.offset} Y{global.y_min + var.offset} F{var.current_speed * 60}
        ; back left (+\)
        G1 X{global.x_min + var.offset} Y{global.y_max - var.offset} F{var.current_speed * 60}
        ; return to front left on next iter (V)
        set var.iter = var.iter + 1
    set var.current_speed = var.current_speed + var.interval

M98 P"/sys/motion/positioning/center.g"

M400