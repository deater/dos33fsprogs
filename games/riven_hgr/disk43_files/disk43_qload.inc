load_address_array:
	.byte $40,$40,$40,$40	; TITLE, CART

track_array:
	.byte  1, 2, 9,17	; TITLE, CART

sector_array:
	.byte  8, 0, 0, 0	; TITLE, CART

length_array:
	.byte  16, 96,123, 64	; TITLE, CART

disk_exit_disk: ; note: BCD (yes I'm lazy)
disk_exit_dni_h:
disk_exit_dni_l:
disk_exit_load:
disk_exit_level:
disk_exit_direction:

