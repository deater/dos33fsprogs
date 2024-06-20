load_address_array:
	.byte $40,$40,$40,$40	; TITLE, ARRIVAL

track_array:
        .byte  1, 2, 2,17	; TITLE, ARRIVAL

sector_array:
        .byte  8, 0, 0, 0	; TITLE, ARRIVAL

length_array:
        .byte  16, 128,123, 64	; TITLE, ARRIVAL


disk_exit_disk: ; note: BCD (yes I'm lazy)
disk_exit_dni_h:
disk_exit_dni_l:
disk_exit_load:
disk_exit_level:
disk_exit_direction:
