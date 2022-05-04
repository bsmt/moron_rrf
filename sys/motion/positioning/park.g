; a safe parking location
; this is distinct from the center point because GE5C Z joints tend to sag
; unless you park the toolhead in the front of the printer
; uses coordinates from sys/settings.g:
; global.park_x, global.park_y

G90  ; absolute
G1 X{global.park_x} Y{global.park_y} F{global.fast_move_feed}