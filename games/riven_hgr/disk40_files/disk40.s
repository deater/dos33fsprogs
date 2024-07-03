.include "../zp.inc"

which_disk:
	.byte	$40		; BCD

load_address_array:
	.byte	$40,$40,$40,$40	; TITLE, MAGLEV, OUTSIDE, TUNNEL
	.byte	$40,$00,$00,$00 ; ORB

track_array:
	.byte	 0, 2,10,15	; TITLE, MAGLEV, OUTSIDE, TUNNEL
	.byte	21, 0, 0, 0	; ORB

sector_array:
	.byte	8, 0, 0, 0	; TITLE, MAGLEV, OUTSIDE, TUNNEL
	.byte	0,0,0,0		; ORB

length_array:
	.byte	8, 128, 80, 96	; TITLE, MAGLEV, OUTSIDE, TUNNEL
	.byte	64,0,0,0	; ORB

disk_exit_disk:	; note: BCD (yes I'm lazy)
	.byte	$41		; Tunnel (DISK41)
	.byte	$00
	.byte	$00
	.byte	$00

disk_exit_dni_h:
	.byte	$01	; 41 = 1*25 + 3*5 + 1
	.byte	$00
	.byte	$00
	.byte	$00

disk_exit_dni_l:
	.byte	$31
	.byte	$00
	.byte	$00
	.byte	$00

	; load_tunnel / tunnel5 / s
disk_exit_load:
	.byte	1			; LOAD_TUNNEL
	.byte	0
	.byte	0
	.byte	0

disk_exit_level:
	.byte	$00			; Tunnel 5
	.byte	$00
	.byte	$00
	.byte	$00

disk_exit_direction:
	.byte	DIRECTION_S		; facing south
	.byte	$00
	.byte	$00
	.byte	$00
