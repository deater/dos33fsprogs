.include "../zp.inc"

which_disk:
	.byte	$00		; BCD

load_address_array:
	.byte	$40,$40,$40,$60	; TITLE, CYAN, ATRUS, CAPTURED
	.byte	$40,$00,$00,$00	; CHO

track_array:
        .byte	0, 2, 10,18	; TITLE, CYAN, ATRUS, CAPTURED
	.byte	26,0,0,0	; CHO

sector_array:
        .byte	8, 0, 0, 0	; TITLE, CYAN, ATRUS, CAPTURED
	.byte	0,0,0,0		; CHO
length_array:
        .byte	8, 127,127,80	; TITLE, CYAN, ATRUS, CAPTURED
	.byte	127,0,0,0	; CHO


disk_exit_disk: ; note: BCD (yes I'm lazy)
	.byte $01		; start of game
	.byte 0,0,0
disk_exit_dni_h:
	.byte $00		; 01 = 1
	.byte 0,0,0
disk_exit_dni_l:
	.byte $01
	.byte 0,0,0

	; want to go to disk01, LOAD_ARRIVAL, RIVEN_ARRIVAL, N

disk_exit_load:
	.byte 1			; LOAD_ARRIVAL
	.byte 0,0,0
disk_exit_level:
	.byte 0			; RIVEN_ARRIVAL
	.byte 0,0,0
disk_exit_direction:
	.byte DIRECTION_N
	.byte 0,0,0
