; Level 6 (Second Shrine)

; at $6000

level6_data:
.byte	24	;MAX_TILE_X
.byte	40	;MAX_TILE_Y

.byte	1	;START_KEEN_TILEX
.byte	32	;START_KEEN_TILEY

.byte	0	;START_TILEMAP_X
.byte	24	;START_TILEMAP_Y

.byte	0	;NUM_ENEMIES

.byte	40	;HARDTOP_TILES
.byte	48	;ALLHARD_TILES


.align	$100

; at $6100
enemy_data:
.byte $0

.align	$100

; at $6200
oracle_message:
	;      0123456789012345678901234567890123456789
	.byte 2,21,"A MESSAGE ECHOES IN YOUR HEAD:",0
	.byte 2,22,"THE TELEPORTER IN THE ICE WILL",0
	.byte 2,23,"SEND YOU TO THE DARK SIDE OF MARS.",0

.align $100

; at $6300
level6_data_zx02:
        .incbin         "maps/level6_map.zx02"
