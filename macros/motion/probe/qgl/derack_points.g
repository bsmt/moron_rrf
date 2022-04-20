; offsets to add/subtract from axis min/max to calculate points
var derack_x_offset = 75
var derack_y_offset = 75

; probe must be deployed/retracted before/after this macro is called
; use M401 and M402

; back left corner
G30 P0 X{global.x_min + var.derack_x_offset} Y{global.y_max - var.derack_y_offset} Z-99999
; back right
G30 P1 X{global.x_max - var.derack_x_offset} Y{global.y_max - var.derack_y_offset} Z-99999
; front right
G30 P2 X{global.x_max - var.derack_x_offset} Y{global.y_min + var.derack_y_offset} Z-99999
; front left
G30 P3 X{global.x_min + var.derack_x_offset} Y{global.y_min + var.derack_y_offset} Z-99999 S4
