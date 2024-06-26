.include "../zp.inc"

which_disk:
	.byte	$39		; BCD

load_address_array:
	.byte $40,$40,$40,$40	; TITLE, OUTSIDE, PROJECTOR, MAGSTEPS
	.byte $40,$40,$40,$00	; MAGLEV, MOVIE1, MOVIE2

track_array:
        .byte  1, 9, 2,17	; TITLE, OUTSIDE, PROJECTOR, MAGSTEPS
	.byte  21,25,27,0	; MAGLEV, MOVIE1, MOVIE2

sector_array:
        .byte  10, 0, 0, 0	; TITLE, OUTSIDE, PROJECTOR, MAGSTEPS
	.byte  0, 0, 0, 0	; MAGLEV, MOVIE1, MOVIE2

length_array:
        .byte  8, 123,123, 64	; TITLE, OUTSIDE, PROJECTOR, MAGSTEPS
	.byte  64, 32, 128, 0	; MAGLEV, MOVIE1, MOVIE2

disk_exit_disk: ; note: BCD (yes I'm lazy)
	.byte $40,0,0,0
disk_exit_dni_h:
	.byte $01,0,0,0	; 1*25+3*5+0*1
disk_exit_dni_l:
	.byte $30,0,0,0
disk_exit_load:			; disk40, LOAD_MAGLEV, INSEAT, W
	.byte 1,0,0,0		; LOAD_MAGLEV
disk_exit_level:
	.byte 1,0,0,0		; riven INSEAT
disk_exit_direction:
	.byte DIRECTION_W,0,0,0
