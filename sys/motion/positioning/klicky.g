; XY position in front of the klicky dock
; from here, you should be able to do simple Y axis moves to pick up klicky
; or one Y and one X move to put it in the dock
; uses positions from sys/settings.g:
; global.probe_dock_x, global.probe_dock_y

G90  ; absolute
; move X and Y separately
G1 X{global.probe_dock_x} F{global.fast_move_feed}
G1 Y{global.probe_dock_y} F{global.fast_move_feed}