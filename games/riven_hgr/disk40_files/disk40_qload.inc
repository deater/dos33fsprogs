load_address_array:
	.byte $40,$40,$40,$40	; TITLE, MAGLEV, OUTSIDE

track_array:
	.byte  1, 2, 9,17	; TITLE, MAGLEV, OUTSIDE

sector_array:
	.byte  8, 0, 0, 0	; TITLE, MAGLEV, OUTSIDE

length_array:
	.byte  16, 96,96, 64	; TITLE, MAGLEV, OUTSIDE

disk_exit_disk:	; note: BCD (yes I'm lazy)
	.byte	$43		; CART (DISK43)

disk_exit_dni_h:
	.byte	$01

disk_exit_dni_l:
	.byte	$24

	; load_cart / outside_cart / s
disk_exit_load:
	.byte	1			; LOAD_CART

disk_exit_level:
	.byte	$00			; OUTSIDE_CART

disk_exit_direction:
	.byte	DIRECTION_S		; CART





