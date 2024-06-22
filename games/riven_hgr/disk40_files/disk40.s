.include "../zp.inc"

which_disk:
	.byte	$40		; BCD

load_address_array:
	.byte	$40,$40,$40,$40	; TITLE, MAGLEV, OUTSIDE, TUNNEL
	.byte	$40,$00,$00,$00 ; ORB

track_array:
	.byte	 1, 2,10,15	; TITLE, MAGLEV, OUTSIDE, TUNNEL
	.byte	21, 0, 0, 0	; ORB

sector_array:
	.byte	9, 0, 0, 0	; TITLE, MAGLEV, OUTSIDE, TUNNEL
	.byte	0,0,0,0		; ORB

length_array:
	.byte	8, 128, 80, 64	; TITLE, MAGLEV, OUTSIDE, TUNNEL
	.byte	64,0,0,0	; ORB

disk_exit_disk:	; note: BCD (yes I'm lazy)
	.byte	$43		; CART (DISK43)
	.byte	$00
	.byte	$00
	.byte	$00

disk_exit_dni_h:
	.byte	$01	; 43 = 25 + 15 + 3
	.byte	$00
	.byte	$00
	.byte	$00

disk_exit_dni_l:
	.byte	$33
	.byte	$00
	.byte	$00
	.byte	$00

	; load_cart / outside_cart / s
disk_exit_load:
	.byte	1			; LOAD_CART
	.byte	0
	.byte	0
	.byte	0
	.byte	0

disk_exit_level:
	.byte	$00			; OUTSIDE_CART
	.byte	$00
	.byte	$00
	.byte	$00

disk_exit_direction:
	.byte	DIRECTION_S		; CART
	.byte	$00
	.byte	$00
	.byte	$00
