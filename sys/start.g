; pre-print procedure, called before a print starts

; Home X/Y
;M98 P"/sys/motion/homing/home_x.g"
;M98 P"/sys/motion/homing/home_y.g"

; TODO: fix this!
; we get a stack overflow on the home_z macro call
; https://github.com/Duet3D/RepRapFirmware/blob/0a1b2ee0cfc7c344a9fa5f27be45fd30b7b9d54b/src/GCodes/GCodes.cpp#L1452
; https://github.com/Duet3D/RepRapFirmware/blob/873b5056cba92eb4514d8b8256c7c9e25fe315ab/src/Config/Configuration.h#L249
; I *think* if we update to 3.4 and make it the minimum, we'll be fine?
; It sounds like the gcode macro call stack is too big

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