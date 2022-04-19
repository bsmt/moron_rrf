; determine if we are ready to do a probing operation
; sets global.probe_ready (bool)

if global.z_probe_type == "inductive"
    set global.probe_ready = true
elif global.z_probe_type == "klicky"
    M98 P"/macros/motion/probe/klicky/poll_klicky.g"  ; update klicky_attached
    if global.klicky_attached
        set global.probe_ready = true
    else
        set global.probe_ready = false