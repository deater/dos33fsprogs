.include "../zp.inc"
.include "../disk40_files/disk40_defines.inc"
.include "../disk43_files/disk43_defines.inc"

which_disk_bcd:
	.byte	$41		; BCD

which_disk_bin:
	.byte	41

load_address_array:
	.byte	$40,$40,$40,$40	; TITLE, TUNNEL, STAIRS, COVE
	.byte	$40,$20,$00,$00 ; STAIRS2,MOVIE_COVE

track_array:
	.byte	 0, 2,10,17	; TITLE, TUNNEL, STAIRS, COVE
	.byte	24, 31, 0, 0	; STAIRS2,MOVIE_COVE

sector_array:
	.byte	 8, 0, 0, 0	; TITLE, TUNNEL, STAIRS, COVE
	.byte	0,0,0,0		; STAIRS2,MOVIE_COVE

length_array:
	.byte	8, 128,128,116	; TITLE, TUNNEL, STAIRS, COVE
	.byte	112,48,0,0	; STAIRS2,MOVIE_COVE

disk_exit_disk:	; note: not BCD anymore
	.byte	40		; TUNNEL (DISK40)
	.byte	43		; CART   (DISK43)
	.byte	$00
	.byte	$00

disk_exit_disk_bcd:
	.byte	$40		; TUNNEL (DISK40)
	.byte	$43		; CART   (DISK43)
	.byte	$00
	.byte	$00

disk_exit_dni_h:
	.byte	$01	; 40 = 25*1 + 3*5 + 0
	.byte	$01	; 43 = 24*1 + 3*5 + 3
	.byte	$00
	.byte	$00

disk_exit_dni_l:
	.byte	$30
	.byte	$33
	.byte	$00
	.byte	$00

	; load_tunnel / tunnel_4 / n
	; load bridge / mid_bridge / w
disk_exit_load:
	.byte	LOAD_TUNNEL		; LOAD_TUNNEL
	.byte	LOAD_BRIDGE		; LOAD_BRIDGE
	.byte	0
	.byte	0

disk_exit_level:
	.byte	RIVEN_TUNNEL4		; TUNNEL_4
	.byte	RIVEN_MID_BRIDGE	; MID_BRIDGE
	.byte	$00
	.byte	$00

disk_exit_direction:
	.byte	DIRECTION_N		;
	.byte	DIRECTION_W
	.byte	$00
	.byte	$00
