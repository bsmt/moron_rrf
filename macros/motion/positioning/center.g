;M98 P"/macros/motion/positioning/zhop_up.g"

G90  ; absolute positioning
G1 X{(global.x_max - global.x_min) / 2} Y{(global.y_max - global.y_min) / 2} F{global.fast_move_feed}