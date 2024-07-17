.include "../zp.inc"

which_disk_bcd:
	.byte	$40		; BCD

which_disk_bin:
	.byte	40

load_address_array:
	.byte	$40,$40,$40,$40	; TITLE, MAGLEV, OUTSIDE, TUNNEL
	.byte	$40,$40,$40,$00 ; ORB, MOVIE_FLIP, MOVIE_MAGLEV

track_array:
	.byte	 0,  2, 10,15	; TITLE, MAGLEV, OUTSIDE, TUNNEL
	.byte	21, 25, 27, 0	; ORB, MOVIE_FLIP, MOVIE_MAGLEV

sector_array:
	.byte	8, 0, 0, 0	; TITLE, MAGLEV, OUTSIDE, TUNNEL
	.byte	0, 0, 0, 0	; ORB, MOVIE_FLIP, MOVIE_MAGLEV

length_array:
	.byte	8, 127, 80, 96	; TITLE, MAGLEV, OUTSIDE, TUNNEL
	.byte	64, 32,127,  0	; ORB, MOVIE_FLIP, MOVIE_MAGLEV

disk_exit_disk:	; note: not BCD anymore
	.byte	41		; Tunnel (DISK41)
	.byte	39		; Temple Maglev (DISK39)
	.byte	$00
	.byte	$00

disk_exit_disk_bcd:
	.byte	$41		; Tunnel (DISK41)
	.byte	$39		; Temple Maglev (DISK39)
	.byte	$00
	.byte	$00

disk_exit_dni_h:
	.byte	$01	; 41 = 1*25 + 3*5 + 1
	.byte	$01	; 38 = 1*25 + 2*5 + 3
	.byte	$00
	.byte	$00

disk_exit_dni_l:
	.byte	$31
	.byte	$23
	.byte	$00
	.byte	$00

	; load_tunnel / tunnel5 / s
disk_exit_load:
	.byte	1			; LOAD_TUNNEL
	.byte	4			; LOAD_MAGLEV
	.byte	0
	.byte	0

disk_exit_level:
	.byte	$00			; Tunnel 5
	.byte	1			; RIVEN_INSEAT
	.byte	$00
	.byte	$00

disk_exit_direction:
	.byte	DIRECTION_S		; facing south
	.byte	DIRECTION_W		; facing west
	.byte	$00
	.byte	$00
