if global.z_probe_type == "inductive"
    M98 P"/macros/motion/probe/inductive/init.g"
elif global.z_probe_type == "klicky"
    M98 P"/macros/motion/probe/klicky/init.g"
else
    echo "Unknown probe type", global.z_probe_type