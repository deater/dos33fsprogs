.include "../zp.inc"
.include "../disk38_files/disk38_defines.inc"
.include "../disk00_files/disk00_defines.inc"

which_disk_bcd:
	.byte	$01		; BCD

which_disk_bin:
	.byte	1

load_address_array:
	.byte	$40,$40,$40,$40	; TITLE, ARRIVAL, ARRIVAL2, TELESCOPE
	.byte	$00,$00,$00,$00

track_array:
        .byte	0, 2, 9,16	; TITLE, ARRIVAL, ARRIVAL2, TELESCOPE
	.byte	0,0,0,0

sector_array:
        .byte	8, 0, 0, 0	; TITLE, ARRIVAL, ARRIVAL2, TELESCOPE
	.byte	0,0,0,0
length_array:
        .byte	8, 112,112, 112	; TITLE, ARRIVAL, ARRIVAL2, TELESCOPE
	.byte	0,0,0,0


disk_exit_disk: ; note: not BCD anymore
	.byte 38		; zap to temple for now
	.byte 0
	.byte 0
	.byte 0			; story
disk_exit_disk_bcd:
	.byte $38		; zap to temple for now
	.byte 0
	.byte 0
	.byte 0
disk_exit_dni_h:
	.byte $01		; 38 = 1*25 + 2*5 + 3
	.byte 0
	.byte 0
	.byte 0
disk_exit_dni_l:
	.byte $23
	.byte 0
	.byte 0
	.byte 0

	; want to go to disk38, LOAD_PROJECTOR, RIVEN_PROJECTOR, W

disk_exit_load:
	.byte LOAD_PROJECTOR	; LOAD_PROJECTOR
	.byte 0
	.byte 0
	.byte LOAD_CYAN
disk_exit_level:
	.byte RIVEN_PROJECTOR	; RIVEN_PROJECTOR
	.byte 0
	.byte 0
	.byte 0
disk_exit_direction:
	.byte DIRECTION_W
	.byte 0
	.byte 0
	.byte 0
