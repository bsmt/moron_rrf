; check if klicky is attached
; sets global.klicky_attached (bool)

; we use the triggered value because klicky is a normally open switch
; the input is pulled up and the switch turning on pulls it to ground
; so, if it's not connected it will appear triggered
; TODO: we actually have to track this manually in addition, in the docking scripts.
if sensors.probes[0].value[0] == global.klicky_triggered_val
    set global.klicky_attached = false
elif sensors.probes[0].value[0] == global.klicky_idle_val
    set global.klicky_attached = true
else
    set global.klicky_attached = false