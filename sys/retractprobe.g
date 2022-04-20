if global.z_probe_type == "klicky" && global.klicky_attached == false
    abort "ERROR: Klicky fell off?!"
elif global.z_probe_type == "klicky" && !global.doing_qgl
    M98 P"/macros/motion/positioning/zhop_up.g"

    M98 P"/macros/motion/probe/klicky/dock_probe.g"

    if global.klicky_attached == true
        abort "ERROR: Klicky not docked"