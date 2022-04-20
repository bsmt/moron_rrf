; quick QGL variant for gantry deracking

; if you have A1 it will use the slow feedrate, if you supply multiple
var derack_feed = 13  ; mm/s
M558 A1 H30 F{var.derack_feed * 60} K0  ; only probe once and start higher.

M98 P"/macros/motion/probe/qgl/derack_points.g"

; TODO: FIX THIS!!!!
; this re-runs M558 with a P and C arg
; this causes the internal zprobe object to get reinitialized
; which makes reprapfirmware forget that it's deployed
; instead we should maybe make init a two-step process
; or backup the old values
M98 P"/macros/motion/probe/init.g"  ; reset probe settings
set global.need_derack = false  ; finalize need_derack flag after init