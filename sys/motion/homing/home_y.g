; movement for y homing

var homing_speed      = 100  ; mm/s
var homing_speed_slow = 2.5    ; mm/s 

; check if there is anything preventing us from homing (like klicky being attached)
M98 P"/sys/motion/homing/can_home_xy.g"

if global.can_home_xy == true
    G90  ; absolute
    ; move the toolhead to the left so the bowden tube or umbillical doesn't get caught
    ; this also sets us up nicely for z homing right after
    G1 X{global.z_endstop_x} F{var.homing_speed * 60} F{global.fast_move_feed}
    G91  ; relative

    M98 P"/sys/motion/power/xy_low.g"

    G1 H1 Y{global.y_max + 10} F{var.homing_speed * 60}  ; initial fast home
    G1 H0 Y-10 F{var.homing_speed * 60}  ; move back
    G1 H1 Y11 F{var.homing_speed_slow * 60}
    G1 H0 Y-10 F{var.homing_speed * 60}
    
    M98 P"/sys/motion/power/xy_high.g"
else
    echo "Cannot home. Check probe."