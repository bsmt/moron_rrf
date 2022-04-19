var probe_height = 10 ; mm

M561  ; clear bed transform
M290 R0 S0  ; clear babystepping

M401  ; "deploy" Z probe

if global.need_derack
    M98 P"/macros/motion/probe/derack.g"

if global.need_derack == false
    ; TODO: set_iheight.g equivalent?
    M98 P"/macros/motion/probe/qgl_points.g"
    M98 P"/macros/motion/probe/qgl_points.g"
else
    echo "Deracking failed"

M402  ; "retract" Z probe