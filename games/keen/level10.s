; Level 10 (Ice Shrine 1)

; at $6000

level10_data:
.byte	50	;MAX_TILE_X
.byte	36	;MAX_TILE_Y

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

; big robot@10,6 left
; butler robot @8,13 left
; garg @15,19 right
; garg @ 17,19 right

.align	$100

; at $6200
oracle_message:
	;      012345678901234567890123456789012345678
	.byte 2,21,"YOU SEE THESE WORDS IN YOUR HEAD:",0
	.byte 2,22,"YOU WILL NEED A RAYGUN IN THE END,",0
	.byte 2,23,"BUT NOT TO SHOOT THE VORTICON...",0

.align $100

; at $6300
level10_data_zx02:
        .incbin         "maps/level10_map.zx02"
