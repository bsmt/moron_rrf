; quick QGL variant for gantry deracking

M558 A1 H30  ; only probe once and start higher

M98 P"/macros/motion/probe/derack_points.g"

M98 P"/macros/motion/probe/init.g"  ; reset probe settings
set global.need_derack = false  ; finalize need_derack flag after init