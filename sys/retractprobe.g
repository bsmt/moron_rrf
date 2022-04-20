if global.z_probe_type == "klicky"
    M98 P"/macros/motion/probe/klicky/poll_klicky.g"
    if global.klicky_attached == false
        abort "ERROR: Klicky fell off?!"
    else
        M98 P"/macros/motion/positioning/zhop_up.g"
        M98 P"/macros/motion/probe/klicky/dock_probe.g"  ; will poll_klicky for us
        if global.klicky_attached == true
            abort "ERROR: Klicky not docked"