; bed mesh probing

var mesh_x_offset = 25  ; mm
var mesh_y_offset = 25  ; mm

M561  ; clear bed transform

; setup grid
var x_min = {global.x_min + var.mesh_x_offset}
var x_max = {global.x_max - var.mesh_x_offset}
var y_min = {global.y_min + var.mesh_y_offset}
var y_max = global.y_max - var.mesh_y_offset
M557 X{var.x_min, var.x_max} Y{var.y_min, var.y_max} P{global.n_mesh_points}

G29 S2  ; disable mesh compensation

M401  ; load probe

; we need to manually move to the first XY point first
; otherwise it will do a linear XYZ move, which triggers klicky prematurely
G90
G1 X{var.x_min} Y{var.y_min}
G29 S0  ; do the actual mesh probing

M402  ; put probe back