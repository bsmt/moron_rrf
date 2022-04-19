if global.z_probe_type == "inductive"
    var fast_feed   = 13   ; mm/s
    var slow_feed   = 1    ; mm/s
    var move_speed  = 12   ; mm/s
    var start_height = 10  ; mm
    var settle_time = 0.5  ; s
    var repeat      = 3    ; will do one fast probe followed by N slow probes
    var tolerance   = 0.02 ; mm
    var trigger     = 1000
    var x_offset    = 0    ; mm
    var y_offset    = 25   ; mm

    ; breaking up the variables to meet line length requirements (160 char)
    var slow = var.probe_slow_feed * 60
    var fast = var.probe_fast_feed * 60
    M558 P5 C{global.z_probe_pin} H{var.start_height} F{var.fast}:{var.slow} T{var.move_speed * 60} R{var.settle_time} A{var.repeat} S{var.tolerance} B1 K0

    ; probe z offset configured in settings.g
    ; TODO: G31 temp compensation (S and T params)
    G31 P{var.trigger} X{var.x_offset} Y{var.y_offset} Z{global.z_probe_offset}
elif global.z_probe_type == "klicky"
    var feed = 1  ; mm/s
    var move_speed = 12  ; mm/s
    var start_height = 1.45  ; mm
    var settle_time = 0.1  ; s
    var repeat = 5
    var tolerance = 0.01  ; mm
    var x_offset = 0  ; mm
    var y_offset = 25  ; mm
    
    global klicky_triggered_val = 1000
    global klicky_idle_val = 0

    M98 P"/macros/motion/probe/klicky/init.g"
    
    M558 P5 C{global.z_probe_pin} H{var.start_height} R{var.settle_time} F{var.feed * 60} T{var.move_speed * 60} A{var.repeat} S{var.tolerance} B1 K0
    G31 P{global.klicky_triggered_val} X{var.x_offset} Y{var.y_offset}
    echo "TODO: klicky z probe init"
else
    echo "Unknown probe type"