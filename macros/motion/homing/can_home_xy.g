if global.z_probe_type == "inductive"
    set global.can_home = true
elif global.z_probe_type == "klicky"
    M98 P"/macros/motion/probe/klicky/poll_klicky.g"
    if global.klicky_attached == true
        set global.can_home = false
    else
        set global.can_home = true