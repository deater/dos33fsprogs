.include "../zp.inc"
.include "../disk38_files/disk38_defines.inc"
.include "../disk40_files/disk40_defines.inc"
.include "../disk00_files/disk00_defines.inc"

which_disk_bcd:
	.byte	$39		; BCD

which_disk_bin:
	.byte	39

load_address_array:
	.byte $40,$40,$40,$40	; TITLE, OUTSIDE, PROJECTOR, MAGSTEPS
	.byte $40,$40,$40,$00	; MAGLEV, MOVIE1, MOVIE2

track_array:
        .byte  0, 9, 2,17	; TITLE, OUTSIDE, PROJECTOR, MAGSTEPS
	.byte  21,25,27,0	; MAGLEV, MOVIE1, MOVIE2

sector_array:
        .byte  8, 0, 0, 0	; TITLE, OUTSIDE, PROJECTOR, MAGSTEPS
	.byte  0, 0, 0, 0	; MAGLEV, MOVIE1, MOVIE2

length_array:
        .byte  8, 123,123, 64	; TITLE, OUTSIDE, PROJECTOR, MAGSTEPS
	.byte  64, 32, 127, 0	; MAGLEV, MOVIE1, MOVIE2

disk_exit_disk: ; note: not BCD anymore
	.byte 40
	.byte 38
	.byte 0
	.byte 0

disk_exit_disk_bcd:
	.byte $40
	.byte $38
	.byte 0
	.byte 0

disk_exit_dni_h:
	.byte $01	; 1*25+3*5+0*1
	.byte $01	; 1*25+2*5+3*1
	.byte 0
	.byte 0
disk_exit_dni_l:
	.byte $30
	.byte $23
	.byte 0
	.byte 0
disk_exit_load:			; disk40, LOAD_MAGLEV, INSEAT, W
	.byte LOAD_MAGLEV			; LOAD_MAGLEV
	.byte LOAD_PROJECTOR
	.byte 0
	.byte LOAD_CYAN
disk_exit_level:
	.byte RIVEN_INSEAT		; riven INSEAT
	.byte RIVEN_PROJECTOR
	.byte 0
	.byte 0
disk_exit_direction:
	.byte DIRECTION_W
	.byte DIRECTION_S
	.byte 0
	.byte 0
