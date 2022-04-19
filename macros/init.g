echo "Moron config v0.1 initializing"

M111 S0  ; debug off
M550 P{global.machine_name}  ; set machine name

M552 S1                                           ; start network module
M586 P1 S1                                        ; disable FTP
M586 P2 S0                                        ; disable Telnet

M555 P2					    ; Set output to look like Marlin
G21					    	; Work in millimetres
G90					    	; Send absolute coordinates...
M83						    ; ...but relative extruder moves

; call subsystem initializers
M98 P"/macros/motion/init.g"
M98 P"/macros/heat/init.g"

M501  ; load overrides

echo "Moron initialization done"