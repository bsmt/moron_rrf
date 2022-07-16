; deracking QGL points
; TODO: this is basically copy-pasta from qgl_points.g
; can we make this generic? perhaps with parameters for x/y offset?

; offsets to add/subtract from axis min/max to calculate points
var qgl_x_offset = 75
var qgl_y_offset = 75
var qgl_move_speed = global.fast_move_feed

var x0 = global.x_min + var.qgl_x_offset
var x1 = global.x_max - var.qgl_x_offset
var x2 = global.x_max - var.qgl_x_offset
var x3 = global.x_min + var.qgl_x_offset

var y0 = global.y_max - var.qgl_y_offset
var y1 = global.y_max - var.qgl_y_offset
var y2 = global.y_min + var.qgl_y_offset
var y3 = global.y_min + var.qgl_y_offset

; probe must be deployed/retracted before/after this macro is called
; use M401 and M402

; back left corner
G30 P0 X{var.x0} Y{var.y0} Z-99999
; back right
G30 P1 X{var.x1} Y{var.y1} Z-99999
; front right
G30 P2 X{var.x2} Y{var.y2} Z-99999
; front left
G30 P3 X{var.x3} Y{var.y3} Z-99999 S4
