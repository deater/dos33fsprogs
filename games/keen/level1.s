; Level 1 (Border Town)

; at $6000

level1_data:
.byte	116	;MAX_TILE_X 		= 116	; 116 wide
.byte	16	;MAX_TILE_Y 		= 16	; 16 tall

.byte	1	;START_KEEN_TILEX	= 1
.byte	13	;START_KEEN_TILEY	= 13

.byte	0	;START_TILEMAP_X	= 0
.byte	5	;START_TILEMAP_Y	= 5

.byte	8	;NUM_ENEMIES		= 8

.byte	32	;HARDTOP_TILES   	= 32	; start at 32
.byte	40	;ALLHARD_TILES   	= 40	; start at 40


.align	$100

; at $6100
enemy_data:
.byte $0

.align	$100

; at $6200\
oracle_message:
.byte $0

.align $100

; at $6300
level1_data_zx02:
        .incbin         "maps/level1_map.zx02"
