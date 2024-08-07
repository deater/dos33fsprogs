.include "../zp.inc"
.include "../disk41_files/disk41_defines.inc"
.include "../disk50_files/disk50_defines.inc"
.include "../disk44_files/disk44_defines.inc"
.include "../disk00_files/disk00_defines.inc"

which_disk_bcd:
	.byte	$43		; BCD

which_disk_bin:
	.byte	43

load_address_array:
	.byte	$40,$40,$40,$40	; TITLE, CART, BRIDGE,LOGGED
	.byte	$40,$40,$40,$40 ; LOGGED3,LOGGED4,LOGGED5,MOVIE_CART

track_array:
	.byte	0, 2, 8,13	; TITLE, CART, BRIDGE,LOGGED
	.byte	18,23,26,31	; LOGGED3,LOGGED4,LOGGED5,MOVIE_CART

sector_array:
	.byte	8, 0, 0, 0	; TITLE, CART, BRIDGE,LOGGED
	.byte	0,0,0,0		; LOGGED3,LOGGED4,LOGGED5,MOVIE_CART

length_array:
	.byte	8, 96,80, 80	; TITLE, CART, BRIDGE,LOGGED
	.byte	80,48,80, 32	; LOGGED3,LOGGED4,LOGGED5,MOVIE_CART

	; disk 41

disk_exit_disk: ; note: not BCD anymore
	.byte	41
	.byte	50
	.byte	44
	.byte	0
	.byte	0
	.byte	0

disk_exit_disk_bcd:
	.byte	$41
	.byte	$50
	.byte	$44
	.byte	0
	.byte	0
	.byte	0


disk_exit_dni_h:
	.byte	$01		; 41 = 1*25 + 3*5 + 1
	.byte	$02		; 50 = 2*25 + 0
	.byte	$01		; 43 = 1*25 + 3*5 + 3
	.byte	0
	.byte	0
	.byte	0

disk_exit_dni_l:
	.byte	$31
	.byte	$00
	.byte	$33
	.byte	0
	.byte	0
	.byte	0

			; STAIRS2, RIVEN_UP4, E
disk_exit_load:
	.byte	LOAD_STAIRS2
	.byte	LOAD_CHIPPER
	.byte	LOAD_PATH
	.byte	0
	.byte	0
	.byte	LOAD_CYAN
disk_exit_level:
	.byte	RIVEN_UP4
	.byte	RIVEN_CHIPPER
	.byte	RIVEN_PATH
	.byte	0
	.byte	0
	.byte	0
disk_exit_direction:
	.byte	DIRECTION_E
	.byte	DIRECTION_N
	.byte	DIRECTION_E
	.byte	0
	.byte	0
	.byte	0

