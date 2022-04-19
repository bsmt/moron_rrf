global machine_name = "Moron"

;;;;; printer dimensions
global x_min = 0
global x_max = 350
global y_min = 0
global y_max = 350
global z_min = 0
global z_max = 350

;;;;; endstops/hoping
; These are duet pin names, so you can still use ! and ^
global x_endstop_pin = "xstop"
global y_endstop_pin = "ystop"
global z_endstop_pin = "zstop"
; how the Z axis is homed
; options are:
; - "endstop" (homes with the normal z endstop)
; - "probe"   (uses your Z probe to home)
global z_home_style = "endstop"

;;;;; z probe
; Z probe type options are:
; - klicky
; - inductive
global z_probe_type   = "klicky"
global z_probe_pin    = "^zprobe.in"
; z_probe_offset is straightforward for inductive sensors
; for klicky, it is roughly the distance between the switch tip and the switch body
global z_probe_offset = 0.47  ; mm

;;;;; motors
; For CoreXY, RepRapFirmware assumes the "X" motor will move in +X and +Y directions
; This should be A on the Voron

; A motor
global a_motor      = 1
global invert_a     = false
global a_microsteps = 16
global a_step_angle = 1.8
global a_current    = 1200  ; mA

; B motor
global b_motor      = 0
global invert_b     = false
global b_microsteps = 16
global b_step_angle = 1.8
global b_current    = 1200  ; mA

; Z motors
; Z drive map (looking down)
;
;   B__back___A
;   | Z1 | Z2 |
;   |---------|
;   | Z0 | Z3 |
;   ---front---
; 
global z0_motor      = 5
global invert_z0     = false
global z1_motor      = 6
global invert_z1     = false
global z2_motor      = 7
global invert_z2     = false
global z3_motor      = 8
global invert_z3     = false
global z_microsteps  = 16
global z_step_angle  = 1.8
global z_current     = 1000  ; mA
; Z QGL "lead screw" position parameters
; measure from nozzle at min and max positions to each belt
global z0_x_pos = -43
global z0_y_pos = -5
global z1_x_pos = -43
global z1_y_pos = 420
global z2_x_pos = 393
global z2_y_pos = 420
global z3_x_pos = 393
global z3_y_pos = -5

; E motor
global e0_motor              = 3
global invert_e0             = false
global e0_microsteps          = 16
global e0_step_angle         = 1.8
; adjust extruder calibration
; supply desired extrusion distance over measured extrusion distance
global e0_calibration_factor = 50.0 / 50.0
global e0_current            = 400  ; mA


;;;;; speed/acceleration maximums
; WARNING: these units are in millimeters per *SECOND*
; normal duet commands take millimeters per *MINUTE* (except for M201)
; you cannot simply copy/paste speeds from other RRF configs here
; everything is automatically converted to the correct unit
global x_max_speed = 750   ; mm/s
global x_max_accel = 3000  ; mm/s^2 
global x_max_jerk  = 4     ; mm/s
global y_max_speed = 750   ; mm/s
global y_max_accel = 3000  ; mm/s^2
global y_max_jerk  = 4     ; mm/s
global z_max_speed = 130   ; mm/s
global z_max_accel = 1000  ; mm/s^2
global z_max_jerk  = 4     ; mm/s
global e_max_speed = 130   ; mm/s
global e_max_accel = 5000  ; mm/s^2
global e_max_jerk  = 20    ; mm/s

;;;;; important positions and offsets
; default toolhead position
; placing it in the front helps with sag when using spherical bearing Z joints
global park_x = (global.x_max / 2)
global park_y = 50

; probe dock setup location
; this should be the same X position as the probe dock, but with some subtracted from the Y
; such that the toolhead will be sat in front of the dock, ready to pick up the probe
global probe_dock_x = 17
global probe_dock_y = (global.y_max - 20)

global z_hop_distance = 10  ; mm

; Z endstop location
global z_endstop_x = 228
global z_endstop_y = global.y_max

; nozzle brush location (approximate center point)
global nozzle_brush_installed = false
global brush_x = 97
global brush_y = global.y_max

;;;;; heaters/thermistors
; hotend
global hotend_heater_pin = "e0heat"
global hotend_sensor = 1
global hotend_sensor_pin = "e0temp"
global hotend_sensor_type = "thermistor"
global hotend_sensor_name = "Hotend Temp"
global hotend_sensor_beta = 4375
global hotend_max_temp     = 275  ; degrees C

; bed
global bed_heater_pin = "bedheat"
global bed_sensor = 0
global bed_sensor_pin   = "bedtemp"
global bed_sensor_type  = "thermistor"
global bed_sensor_name  = "Bed Temp"
global bed_sensor_beta = 4700
global bed_max_temp    = 120  ; degrees C

; chamber
global chamber_sensor_installed = true
global chamber_sensor = 2
global chamber_sensor_pin = "e1temp"
global chamber_sensor_type = "thermistor"
global chamber_sensor_name = "Chamber"
global chamber_sensor_beta = 4700


;;;;; fans
; part fan
global part_fan_pin         = "fan0"
global part_fan_name        = "Part Fan"

; hotend fan
global hotend_fan_pin       = "fan1"
global hotend_fan_name      = "Hotend Fan"
global hotend_fan_temp      = 50  ; activation temp, degrees C
global hotend_fan_speed     = 0.6  ; 0.0 to 1.0, speed %

; chamber fan
global chamber_fan_pin      = "duex.fan5"
global chamber_fan_name     = "Enclosure Fan"

; electronics fans
global electronics_fan0_pin = "duex.fan3"
global electronics_fan1_pin = "duex.fan4"
global electronics_fan_temp = 38  ; activation MCU/driver temp, degrees C
