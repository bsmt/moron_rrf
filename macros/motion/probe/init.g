; we keep track of qgl state because G30 wants to M401/M402 every time
; this means with klicky it will get/store klicky for every probe move
; so we have a doing_qgl check in deployprobe and retractprobe to fix it
if !exists(global.doing_qgl)
    global doing_qgl = false

if global.z_probe_type == "inductive"
    M98 P"/macros/motion/probe/inductive/init.g"
elif global.z_probe_type == "klicky"
    M98 P"/macros/motion/probe/klicky/init.g"
else
    echo "Unknown probe type", global.z_probe_type