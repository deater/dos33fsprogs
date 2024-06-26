.include "../zp.inc"

which_disk:
	.byte	$43		; BCD


load_address_array:
	.byte	$40,$40,$40,$40	; TITLE, CART, BRIDGE,LOGGED
	.byte	$40,$00,$00,$00 ; LOGGED2

track_array:
	.byte	1, 2, 9,16	; TITLE, CART, BRIDGE,LOGGED
	.byte	22,0,0,0	; LOGGED2

sector_array:
	.byte	10, 0, 0, 0	; TITLE, CART, BRIDGE,LOGGED
	.byte	0,0,0,0		; LOGGED2

length_array:
	.byte	8, 96,84, 96	; TITLE, CART, BRIDGE,LOGGED
	.byte	80,0,0,0

	; disk 41

disk_exit_disk: ; note: BCD (yes I'm lazy)
	.byte	$41,0,0,0
disk_exit_dni_h:
	.byte	$01,0,0,0		; 41 = 1*25 + 3*5 + 1
disk_exit_dni_l:
	.byte	$31,0,0,0
disk_exit_load:
	.byte	4,0,0,0			; STAIRS2, RIVEN_UP4, E
disk_exit_level:
	.byte	2,0,0,0
disk_exit_direction:
	.byte	DIRECTION_E,0,0,0
