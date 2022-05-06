; bed/hotend heater setup, and fan setup

;;;;; bed
; set sensor params
if global.bed_sensor_type == "thermistor"
    M308 S{global.bed_sensor} P{global.bed_sensor_pin} Y{global.bed_sensor_type} A{global.bed_sensor_name} B{global.bed_sensor_beta}
; PT1000 probably isn't necessary for a bed
else
    echo "Unknown bed sensor type:"
    echo global.bed_sensor_type

M950 H0 C{global.bed_heater_pin} T{global.bed_sensor}  ; create heater
; we're supposed to use M140 before M143 for bed/chamber heaters
M140 P0 H0  ; bed 0 heater is H0
M143 H0 S{global.bed_max_temp} A0 C0 P1  ; set max temp
M307 H0 B0 S1.00  ; disable bang-bang
; TODO: put PID params in settings.g and configure here

;;;;; hotend
; set sensor params
if global.hotend_sensor_type == "thermistor"
    M308 S{global.hotend_sensor} P{global.hotend_sensor_pin} Y{global.hotend_sensor_type} A{global.hotend_sensor_name} B{global.hotend_sensor_beta}
; TODO: handle PT1000?
else
    echo "Unknown hotend sensor type:"
    echo global.hotend_sensor_type

; M950 must come after M308
; default for first hotend is H1
; bed will be H0
; probably no need to make that configurable
M950 H1 C{global.hotend_heater_pin} T{global.hotend_sensor}  ; create heater
M143 H1 S{global.hotend_max_temp} A0 C0 P1  ; set max temp
M307 H1 B0 S1.00  ; disable bang-bang
; TODO: put PID params in settings.g and configure here

;;;;; chamber
if global.chamber_sensor_installed
    if global.chamber_sensor_type == "thermistor"
        M308 S{global.chamber_sensor} P{global.chamber_sensor_pin} Y{global.chamber_sensor_type} A{global.chamber_sensor_name} B{global.chamber_sensor_beta}
    else
        echo "Unknown chamber sensor type:"
        echo global.chamber_sensor_type

; TODO: support secondary bed thermistor

;;;;;  fans

; TODO: we should probably separate these to another module
; and make macros for turning each fan on/off
; that or parameterize the fan number so we don't have to keep track of them and hardcode constants

; part fan
; we declare the part fan as fan 0 so that it's the default fan for the hotend
; this way g-code can easily adjust it with no slicer config
M950 F0 C{global.part_fan_pin}  ; create fan
M106 P0 H-1 C{global.part_fan_name}  ; disable temp control and set fan name in UI

; hotend fan
M950 F1 C{global.hotend_fan_pin}
M106 P1 H1 T{global.hotend_fan_temp} S{global.hotend_fan_speed} C{global.hotend_fan_name}  ; enable automatic temp control

; chamber fan
if exists(global.chamber_fan_pin)
    M950 F2 C{global.chamber_fan_pin}
    M106 P2 H-1 C{global.chamber_fan_name}  ; disable temp control and set fan name in UI

; electronics fans
if exists(global.electronics_fan0_pin)
    ; Set up sensors for driver overtemp flag and MCU temp
    M308 S10 Y"mcu-temp" A"MCU" ; MCU temp sensor
    M308 S11 Y"drivers" A"Duet Drivers"  ; Main duet stepper drivers
    M308 S12 Y"drivers-duex" A"Duex Drivers"  ; Duex stepper drivers
    ; create individual fans
    M950 F3 C{global.electronics_fan0_pin}
    ; setup temp activation for electronics
    M106 P3 H10:11:12 L0.30 X1.0 B1.0 T{global.electronics_fan_temp}
    ; in case we only have one fan
    if exists(global.electronics_fan1_pin)
        M950 F4 C{global.electronics_fan1_pin}
        M106 P4 H10:11:12 L0.30 X1.0 B1.0 T{global.electronics_fan_temp}

; nevermore fan
if exists(global.nevermore_fan_pin)
    M950 F5 C{global.nevermore_fan_pin}
    M106 P5 H-1 C{global.nevermore_fan_name}  ; disable temp control and set fan name in UI

;;;;; setup hotend tool
M563 P0 D0 H1 F0 S"Hotend"
G10 P0 L1 X0 Y0 Z0  ; zero tool offsets
G10 P0 S0 R0        ; set active and standby temps to zero
T0                  ; select tool 0