M98 P"/macros/motion/positioning/zhop_up.g"

M98 P"/macros/motion/probe/klicky/dock_probe.g"

if global.klicky_attached == false
    echo "Klicky docked!"
else
    echo "ERROR: Klicky not docked"