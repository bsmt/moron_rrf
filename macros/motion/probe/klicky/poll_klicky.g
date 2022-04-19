; check if klicky is attached
; sets global.klicky_attached (bool)

if sensors.probes[0].value[0] == 1000
    set global.klicky_attached = false
elif sensors.probes[0].value[0] == 0
    set global.klicky_attached = true
else
    set global.klicky_attached = false