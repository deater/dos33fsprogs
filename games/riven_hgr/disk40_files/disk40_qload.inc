which_disk_array:
	.byte 1,1,1,1		; TITLE, MAGLEV

load_address_array:
	.byte $40,$40,$40,$40	; TITLE, MAGLEV

track_array:
	.byte  1, 2, 9,17	; TITLE, MAGLEV

sector_array:
	.byte  8, 0, 0, 0	; TITLE, MAGLEV

length_array:
	.byte  16, 96,123, 64	; TITLE, MAGLEV
