; pre-print procedure, called before a print starts

; turn on fans
; TODO: don't hardcode fan numbers
if exists(global.chamber_fan_pin)
    M106 P2 S{global.chamber_fan_speed}

if exists(global.nevermore_fan_pin)
    M106 P5 S{global.nevermore_fan_speed}

M98 P"/sys/motion/positioning/zhop_up.g"

; Home X/Y
M98 P"/sys/motion/homing/home_x.g"
M98 P"/sys/motion/homing/home_y.g"

; move forward a bit
G91
G1 Y-25

; manual QGL so we don't have to get the probe again
M401
; manually move to first point
; we're hardcoding a guess at the offset, which should be close enough
; if we don't move XY first, G30 will move Z too low and crush the probe
; TODO: we may be able to fix this by increasing probe start height
G90
G1 X{global.x_min + 25} Y{global.y_max - 25}
M98 P"/sys/motion/probe/qgl/qgl_points.g"
M98 P"/sys/motion/probe/qgl/qgl_points.g"
M402

; IMPORTANT: for klicky auto-z, QGL will screw up the Z offset
; so we need to re-home to get it corrected again
; this will grab klicky again when appropriate
; TODO: we can probably optimize this
M98 P"/sys/motion/homing/home_z.g" C1  ; home Z with offset calibration

; TODO: load mesh height map