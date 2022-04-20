M561  ; clear bed transform
M290 R0 S0  ; clear babystepping

M401  ; "deploy" Z probe

set global.doing_qgl = true

if global.need_derack
    M98 P"/macros/motion/probe/qgl/derack.g"

if global.need_derack == false
    ; TODO: set_iheight.g equivalent?
    M98 P"/macros/motion/probe/qgl/qgl_points.g"
    M98 P"/macros/motion/probe/qgl/qgl_points.g"
else
    echo "Deracking failed"

set global.doing_qgl = false

M402  ; "retract" Z probe