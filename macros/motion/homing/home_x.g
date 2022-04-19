; movement for x homing

var homing_speed      = 100  ; mm/s
var homing_speed_slow = 2.5    ; mm/s 

; check if there is anything preventing us from homing (probe namely)
M98 P"/macros/motion/homing/can_home_xy.g"

if global.can_home == true
    M98 P"/macros/motion/positioning/zhop_up.g"

    G91  ; relative

    M98 P"/macros/motion/power/xy_low.g"
    G1 H1 X{global.x_max + 10} F{var.homing_speed * 60}  ; initial fast home
    G1 H2 X-10 F{var.homing_speed * 60}  ; move back
    G1 H1 X11 F{var.homing_speed_slow * 60}
    G1 H2 X-10 F{var.homing_speed * 60}
    M98 P"/macros/motion/power/xy_high.g"

    M98 P"/macros/motion/positioning/zhop_down.g"

    G90  ; absolute
else
    echo "Cannot home. Check probe."