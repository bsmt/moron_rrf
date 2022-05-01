; pre-print procedure

; Home X/Y
;M98 P"/sys/motion/homing/home_x.g"
;M98 P"/sys/motion/homing/home_y.g"

; manual QGL so we don't have to get the probe again
M401
; manually move to first point
; we're hardcoding a guess at the offset, which should be close enough
; if we don't move XY first, G30 will move Z too low and crush the probe
; TODO: we may be able to fix this by increasing probe start height
;G90
;G1 X{global.x_min + 25} Y{global.y_max - 25}
;M98 P"/sys/motion/probe/qgl/qgl_points.g"
; IMPORTANT: for klicky with auto-z, QGL will screw up the Z offset
; so we need to re-home to get it corrected again
;M98 P"/sys/motion/homing/home_z.g" C1  ; home Z with offset calibration

M402