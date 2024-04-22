; Level 11 (Fourth Shrine)

; at $6000

level11_data:
.byte	20	;MAX_TILE_X 		= 20	; 20 wide
.byte	26	;MAX_TILE_Y 		= 26	; 26 tall

.byte	1	;START_KEEN_TILEX	= 1
.byte	13	;START_KEEN_TILEY	= 13

.byte	0	;START_TILEMAP_X	= 0
.byte	5	;START_TILEMAP_Y	= 5

.byte	0	;NUM_ENEMIES		= 8

.byte	32	;HARDTOP_TILES   	= 32	; start at 32
.byte	40	;ALLHARD_TILES   	= 40	; start at 40


.align	$100

; at $6100
enemy_data:
.byte $0

.align	$100

; at $6200
oracle_message:
	;      012345678901234567890123456789012345678
	.byte 2,21,"YOU HEAR IN YOUR MIND:",0
	.byte 2,22,"IT IS TOO BAD THAT YOU CANNOT READ",0
	.byte 2,23,"THE STANDARD GALACTIC ALPHABET, HUMAN",0

.align $100

; at $6300
level11_data_zx02:
        .incbin         "maps/level11_map.zx02"
