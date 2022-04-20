if global.z_probe_type == "klicky" && !global.doing_qgl
    M98 P"/macros/motion/positioning/zhop_up.g"

    M98 P"/macros/motion/probe/klicky/load_probe.g"

    if global.klicky_attached == true
        echo "Klicky loaded!"
    else
        echo "ERROR: Klicky not loaded"