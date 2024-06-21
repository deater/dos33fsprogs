.include "../zp.inc"

which_disk:
	.byte	$01		; BCD

load_address_array:
	.byte	$40,$40,$40,$40	; TITLE, ARRIVAL
	.byte	$00,$00,$00,$00

track_array:
        .byte	1, 2, 2,17	; TITLE, ARRIVAL
	.byte	0,0,0,0

sector_array:
        .byte	9, 0, 0, 0	; TITLE, ARRIVAL
	.byte	0,0,0,0
length_array:
        .byte	8, 128,123, 64	; TITLE, ARRIVAL
	.byte	0,0,0,0


disk_exit_disk: ; note: BCD (yes I'm lazy)
	.byte 0,0,0,0
disk_exit_dni_h:
	.byte 0,0,0,0
disk_exit_dni_l:
	.byte 0,0,0,0
disk_exit_load:
	.byte 0,0,0,0
disk_exit_level:
	.byte 0,0,0,0
disk_exit_direction:
	.byte 0,0,0,0
