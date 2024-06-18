which_disk_array:
	.byte 1,1,1,1		; TITLE, ARRIVAL

load_address_array:
	.byte $40,$40,$40,$40	; TITLE, ARRIVAL

track_array:
        .byte  1, 2, 2,17	; TITLE, ARRIVAL

sector_array:
        .byte  8, 0, 0, 0	; TITLE, ARRIVAL

length_array:
        .byte  16, 128,123, 64	; TITLE, ARRIVAL
