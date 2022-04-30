if global.z_probe_type == "klicky"
    M98 P"/sys/motion/positioning/zhop_up.g"

    M98 P"/sys/motion/probe/klicky/load_probe.g"

    if global.klicky_attached == false
        abort "ERROR: Klicky not loaded"