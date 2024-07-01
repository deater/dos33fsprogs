.include "../zp.inc"

which_disk:
	.byte	$01		; BCD

load_address_array:
	.byte	$40,$40,$40,$40	; TITLE, ARRIVAL, ARRIVAL2, TELESCOPE
	.byte	$00,$00,$00,$00

track_array:
        .byte	1, 2, 2,17	; TITLE, ARRIVAL, ARRIVAL2, TELESCOPE
	.byte	0,0,0,0

sector_array:
        .byte	10, 0, 0, 0	; TITLE, ARRIVAL, ARRIVAL2, TELESCOPE
	.byte	0,0,0,0
length_array:
        .byte	8, 128,123, 64	; TITLE, ARRIVAL, ARRIVAL2, TELESCOPE
	.byte	0,0,0,0


disk_exit_disk: ; note: BCD (yes I'm lazy)
	.byte $39		; zap to temple for now
	.byte 0,0,0
disk_exit_dni_h:
	.byte $01		; 39 = 1*25 + 2*5 + 4
	.byte 0,0,0
disk_exit_dni_l:
	.byte $24
	.byte 0,0,0

	; want to go to disk39, LOAD_PROJECTOR, RIVEN_PROJECTOR, W

disk_exit_load:
	.byte 2			; LOAD_PROJECTOR
	.byte 0,0,0
disk_exit_level:
	.byte 0			; RIVEN_PROJECTOR
	.byte 0,0,0
disk_exit_direction:
	.byte DIRECTION_W
	.byte 0,0,0
