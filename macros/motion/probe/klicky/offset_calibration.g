; Klicky Z probe offset calibration. Also known as "auto-z".
; The idea is to use the Z endstop as a reference to calculate the distance between the nozzle tip and the klicky probe.
; First home the nozzle on the endstop to set a base Z = 0, then get the height klicky triggers the endstop at. This is the offset.
; Then, we probe the height klicky triggers on the bed.
; Finally, subtract the offset from the current klicky bed height and we get a final Z = 0

; WARNING: You must home Z first with the nozzle on the endstop

var probe_fast = (10 * 60)  ; 10 mm/s as mm/min
var probe_slow = (1 * 60)   ; 1 mm/s as mm/min
var n_measurements = 4
var measurement_accumulator = 0.0

; load klicky
M401

; do initial endstop probe with klicky
M98 P"/macros/motion/positioning/z_endstop_klicky.g"

G91  ; relative

; instead of switching the Z probe to use the endstop and doing G30,
; we can use the new (RRF 3.3+) G1 H4 command, which just stops when we hit an endstop
G1 H4 Z-99999 F{var.probe_fast}
G1 Z2 F{var.probe_fast}

; now do the actual slow measurements
var measure_ctr = 0
while var.measure_ctr < var.n_measurements
    G1 H4 Z-99999 F{var.probe_slow}
    var current_offset = move.axes[2].machinePosition  ; current Z position
    set var.measurement_accumulator = var.measurement_accumulator + var.current_offset
    G1 Z2 F{var.probe_fast}
    set var.measure_ctr = var.measure_ctr + 1
; calculate the average offset
set global.z_offset = var.measurement_accumulator / var.n_measurements
set global.z_offset = global.z_offset + global.probe_z_offset  ; add the small switch offset
echo "Calibrated Z offset: ", global.z_offset

; final klicky probe on the bed
M98 P"/macros/motion/positioning/zhop_up.g"

M98 P"/macros/motion/positioning/center.g"

G30

; the toolhead will move up by the sensor's dive height (H parameter)
var dive_height = sensors.probes[0].diveHeight
var final_height = global.z_offset + var.dive_height
; set the current Z height and we're done!
G92 Z{var.final_height}

; put klicky back
M402