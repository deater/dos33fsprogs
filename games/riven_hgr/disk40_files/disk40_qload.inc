which_disk_array:
	.byte 1,1,1,1		; TITLE, MAGLEV, OUTSIDE

load_address_array:
	.byte $40,$40,$40,$40	; TITLE, MAGLEV, OUTSIDE

track_array:
	.byte  1, 2, 9,17	; TITLE, MAGLEV, OUTSIDE

sector_array:
	.byte  8, 0, 0, 0	; TITLE, MAGLEV, OUTSIDE

length_array:
	.byte  16, 96,96, 64	; TITLE, MAGLEV, OUTSIDE
