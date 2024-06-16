which_disk_array:
	.byte 1,1,1,1		; TITLE, OUTSIDE, PROJECTOR, MAGSTEPS
	.byte 1,1,1,1		; MAGLEV, MOVIE1, MOVIE2

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
