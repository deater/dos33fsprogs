.include "../zp.inc"
.include "../disk04_files/disk04_defines.inc"
.include "../disk39_files/disk39_defines.inc"
.include "../disk00_files/disk00_defines.inc"

which_disk_bcd:
	.byte	$38		; BCD

which_disk_bin:
	.byte	38

load_address_array:
	.byte $40,$40,$00,$00	; TITLE, PROJECTOR
	.byte $00,$00,$00,$00	;

track_array:
        .byte  0, 2, 0, 0	; TITLE, PROJECTOR
	.byte  0, 0, 0, 0	;

sector_array:
        .byte  8, 0, 0, 0	; TITLE, PROJECTOR
	.byte  0, 0, 0, 0	;

length_array:
        .byte  8, 123,0,0	; TITLE, PROJECTOR
	.byte  0, 0, 0, 0	;

disk_exit_disk: ; note: not BCD anymore
	.byte 39		; outside maglev
	.byte 4			; hallways
	.byte 0
	.byte 0

disk_exit_disk_bcd:
	.byte $39
	.byte $04
	.byte 0
	.byte 0

disk_exit_dni_h:
	.byte $01	; 1*25+2*5+4*1
	.byte $00
	.byte 0
	.byte 0
disk_exit_dni_l:
	.byte $24
	.byte $04
	.byte 0
	.byte 0

disk_exit_load:			; disk39, LOAD_PROJECTOR, PROJ_DOOR, N
	.byte LOAD_PROJECTOR		; LOAD_PROJECTOR
	.byte LOAD_TUNNEL3		;
	.byte 0
	.byte LOAD_CYAN

disk_exit_level:
	.byte RIVEN_PROJ_DOOR		; riven PROJ_DOOR
	.byte RIVEN_TUNNEL3	;
	.byte 0
	.byte 0
disk_exit_direction:
	.byte DIRECTION_N
	.byte DIRECTION_W
	.byte 0
	.byte 0
