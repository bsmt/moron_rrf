; declare any probe globals here
if !exists(global.klicky_attached)
    global klicky_attached = false  ; tracking if the klicky is attached to the toolhead
if !exists(global.klicky_triggered_val)
    global klicky_triggered_val = 1000
if !exists(global.klicky_idle_val)
    global klicky_idle_val = 0
if !exists(global.klicky_load_speed)
    global klicky_load_speed = (50 * 60)  ; 50 mm/s in mm/min

; on power-on we can't necessarily trust that the gantry is level enough to the bed
; so we need to make sure it at least gets somewhat parallel first before we can do QGL
if !exists(global.need_derack)
    global need_derack = true

; forward-declare the probe object
; any time you call M558 with P or C args, the internal ZProbe object gets reinitialized
; this will reset things like the "user deployed" state
; and can make QGL operations deploy and retract the probe a bunch of times
if #sensors.probes == 0  ; only declare if it doesn't already exist
    M558 P5 C{global.z_probe_pin} K0

if global.z_probe_type == "inductive"
    M98 P"/macros/motion/probe/inductive/init.g"
elif global.z_probe_type == "klicky"
    M98 P"/macros/motion/probe/klicky/init.g"
else
    echo "Unknown probe type", global.z_probe_type