; this just does all of the existing homing routines
; but it tries to optimize a little by only doing one z hop

M98 P"/macros/motion/positioning/zhop_up.g"

M98 P"/macros/motion/homing/home_x.g"
M98 P"/macros/motion/homing/home_y.g"
M98 P"/macros/motion/homing/home_z.g"

; done, move to park location
M98 P"/macros/motion/positioning/park.g"