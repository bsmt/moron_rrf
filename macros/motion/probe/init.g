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
    M558 P5 C{global.z_probe_pin} H{var.start_height} F{var.fast}:{var.slow} T{var.move_speed * 60} K0 R{var.settle_time} A{var.repeat} S{var.tolerance} B1

    ; probe z offset configured in settings.g
    ; TODO: G31 temp compensation (S and T params)
    G31 P{var.probe_trigger} X{var.probe_x_offset} Y{var.probe_y_offset} Z{global.z_probe_offset}
    
    global probe_ready = true
elif global.z_probe_type == "klicky"
    global probe_idle_val = 1000
    global probe_triggered_val = 0

    M98 P"/macros/motion/probe/klicky/init.g"
    
    global probe_ready = false

    echo "TODO: klicky z probe init"
else
    echo "Unknown probe type"