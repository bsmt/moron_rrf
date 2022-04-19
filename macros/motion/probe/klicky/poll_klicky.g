; check if klicky is attached
; sets global.klicky_attached (bool)

; we use the triggered value because klicky is a normally open switch
; the input is pulled up and the switch activating pulls it to ground
; so, if it's not connected it will appear triggered

; sleep to let things settle
G4 P200  ; sleep 200ms

if sensors.probes[0].value[0] == global.klicky_triggered_val
    set global.klicky_attached = false
elif sensors.probes[0].value[0] == global.klicky_idle_val
    set global.klicky_attached = true
else
    set global.klicky_attached = false
; for whatever reason, can_home_xy will fail if we don't have an echo or sleep here
; i'm wondering if it's a timing issue
;echo "Klicky attached: ", {global.klicky_attached}
G4 P200  ; sleep 200ms