; Level 9 (Third Shrine)

; at $6000

level9_data:
.byte	40	;MAX_TILE_X
.byte	36	;MAX_TILE_Y

.byte	3	;START_KEEN_TILEX
.byte	32	;START_KEEN_TILEY

.byte	0	;START_TILEMAP_X
.byte	20	;START_TILEMAP_Y

.byte	0	;NUM_ENEMIES

.byte	40	;HARDTOP_TILES
.byte	48	;ALLHARD_TILES


.align	$100

; at $6100
enemy_data:
.byte $0

; enemy0: garg @6,15,right

.align	$100

; at $6200
oracle_message:
	;           012345678901234567890123456789012345678
	.byte 2,20,"A VOICE BUZZES IN YOUR MIND:",0
	.byte 2,21,"THERE IS A HIDDEN CITY.",0
	.byte 2,22,"LOOK IN THE DARK AREA OF THE ",0
	.byte 2,23,"CITY TO THE SOUTH.",0

.align $100

; at $6300
level9_data_zx02:
        .incbin         "maps/level9_map.zx02"
