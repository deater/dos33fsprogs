load_address_array:
	.byte $40,$40,$40,$40	; TITLE, OUTSIDE, PROJECTOR, MAGSTEPS
	.byte $40,$40,$40	; MAGLEV, MOVIE1, MOVIE2

track_array:
        .byte  1, 9, 2,17	; TITLE, OUTSIDE, PROJECTOR, MAGSTEPS
	.byte  21,25,27		; MAGLEV, MOVIE1, MOVIE2

sector_array:
        .byte  8, 0, 0, 0	; TITLE, OUTSIDE, PROJECTOR, MAGSTEPS
	.byte  0, 0, 0		; MAGLEV, MOVIE1, MOVIE2

length_array:
        .byte  16, 123,123, 64	; TITLE, OUTSIDE, PROJECTOR, MAGSTEPS
	.byte  64, 32, 128	; MAGLEV, MOVIE1, MOVIE2

disk_exit_disk: ; note: BCD (yes I'm lazy)
disk_exit_dni_h:
disk_exit_dni_l:
disk_exit_load:
disk_exit_level:
disk_exit_direction:
