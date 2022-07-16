; setup motion: drives, endstops, etc.

; feedrate to use for any fast moves
global fast_move_feed = (150 * 60)  ; 150 mm/s in mm/min

M669 K1  ; CoreXY mode

;;;;; Map drives to motor connectors
; M584 commands must occur before M350, M906, probe setup
; or any other commands that deal with the axis
M584 X{global.a_motor}
M584 Y{global.b_motor}
M584 E{global.e0_motor}
M584 Z{global.z0_motor, global.z1_motor, global.z2_motor, global.z3_motor}

;;;;; Set axis min/max
; mins
M208 X{global.x_min} S1
M208 Y{global.y_min} S1
M208 Z{global.z_min} S1
; max
M208 X{global.x_max} S0
M208 Y{global.y_max} S0
M208 Z{global.z_max} S0

;;;;; set microstepping factors
; this must be done before the M92 steps/mm commands
M350 X{global.a_microsteps}
M350 Y{global.b_microsteps}
M350 Z{global.z_microsteps}
M350 E{global.e0_microsteps}

;;;;; Set steps per mm
; GT2 is 2mm pitch
; 20 tooth pulley on a/b
; simple steps/mm formula is: (steps_per_revolution * microstepping_factor) / (belt_pitch * pulley_teeth)
var x_steps_per_mm = ((360 / global.a_step_angle) * global.a_microsteps) / (2.0 * 20)
var y_steps_per_mm = ((360 / global.b_step_angle) * global.b_microsteps) / (2.0 * 20)
; Z is "geared down" with a ratio of 5:1 or 80:16
; 16 tooth on motor shaft, connected to an 80 tooth
; I don't think this formula is 100% correct, as there is no 20 tooth pulley on the V2.4 Z axis
; but it does get the right result /shrug
var z_ratio        = 80 / 16
var z_steps_per_mm = ((360 / global.z_step_angle) * var.z_ratio * global.z_microsteps) / (2.0 * 20)
; I can't be bothered to figure out the extruder formula, so we'll adjust the known-good baseline instead
var e_steps_per_mm = 416.67 * (global.e0_microsteps / 16) * (1.8 / global.e0_step_angle) * global.e0_calibration_factor

M92 X{var.x_steps_per_mm}
M92 Y{var.y_steps_per_mm}
M92 Z{var.z_steps_per_mm}
M92 E{var.e_steps_per_mm}

;;;;; Motor directions
if global.invert_a
    M569 P{global.a_motor} S0
else
    M569 P{global.a_motor} S1

if global.invert_b
    M569 P{global.b_motor} S0
else
    M569 P{global.b_motor} S1

; z motors are mirrored so right half needs to be inverted
if global.invert_z0
    M569 P{global.z0_motor} S1
else
    M569 P{global.z0_motor} S0
if global.invert_z1
    M569 P{global.z1_motor} S0
else
    M569 P{global.z1_motor} S1
if global.invert_z2
    M569 P{global.z2_motor} S1
else
    M569 P{global.z2_motor} S0
if global.invert_z3
    M569 P{global.z3_motor} S0
else
    M569 P{global.z3_motor} S1

if global.invert_e0
    M569 P{global.e0_motor} S0
else
    M569 P{global.e0_motor} S1

;;;;; Set motor current/speed limits
M98 P"/sys/motion/power/xy_high.g"
M98 P"/sys/motion/power/z_high.g"
M98 P"/sys/motion/power/e_high.g"
; Motor idle time and current
; This could go in settings.g
M84 S30   ; idle after N seconds
M906 I30  ; idle current %

;;;;; Set endstops
; X/Y endstops being min/max could be configurable
; but i don't think any Vorons have the endstops in the min position
; X/Y/Z2 = high end, X/Y/Z1 = low end
M574 X2 P{global.x_endstop_pin} 
M574 Y2 P{global.y_endstop_pin}
M574 Z1 P{global.z_endstop_pin}

; init probe subsystem
M98 P"/sys/motion/probe/init.g"

; init homing subsystem. call after probe init because it can need probe globals
M98 P"/sys/motion/homing/init.g"

; setup QGL z leadscrew offsets
; redefining values to fit line length requirement
var z0x = global.z0_x_pos
var z0y = global.z0_y_pos
var z1x = global.z1_x_pos 
var z1y = global.z1_y_pos
var z2x = global.z2_x_pos
var z2y = global.z2_y_pos
var z3x = global.z3_x_pos
var z3y = global.z3_y_pos
M671 X{var.z0x, var.z1x, var.z2x, var.z3x} Y{var.z0y, var.z1y, var.z2y, var.z3y} S20
