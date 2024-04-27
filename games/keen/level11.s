; Level 11 (Fourth Shrine)

; at $6000

level11_data:
.byte	40	;MAX_TILE_X
.byte	36	;MAX_TILE_Y

.byte	1	;START_KEEN_TILEX
.byte	32	;START_KEEN_TILEY

.byte	0	;START_TILEMAP_X
.byte	24	;START_TILEMAP_Y

.byte	0	;NUM_ENEMIES	1

.byte	40	;HARDTOP_TILES
.byte	48	;ALLHARD_TILES


.align	$100

; at $6100
enemy_data:
.byte $0

; garg @ 13,2

.align	$100

; at $6200
oracle_message:
	;      012345678901234567890123456789012345678
	.byte 2,21,"YOU HEAR IN YOUR MIND:",0
	.byte 2,22,"GAAARRRRRGG!",0


.align $100

; at $6300
level11_data_zx02:
        .incbin         "maps/level11_map.zx02"
