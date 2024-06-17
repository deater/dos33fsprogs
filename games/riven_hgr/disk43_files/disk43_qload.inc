which_disk_array:
	.byte 1,1,1,1		; TITLE, CART

load_address_array:
	.byte $40,$40,$40,$40	; TITLE, CART

track_array:
	.byte  1, 2, 9,17	; TITLE, CART

sector_array:
	.byte  8, 0, 0, 0	; TITLE, CART

length_array:
	.byte  16, 96,123, 64	; TITLE, CART
