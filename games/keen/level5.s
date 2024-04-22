; Level 5 (Pogo Shrine)

; at $6000

level5_data:
.byte	24	;MAX_TILE_X
.byte	37	;MAX_TILE_Y

.byte	1	;START_KEEN_TILEX
.byte	29	;START_KEEN_TILEY

.byte	0	;START_TILEMAP_X
.byte	21	;START_TILEMAP_Y

.byte	0	;NUM_ENEMIES

.byte	40	;HARDTOP_TILES
.byte	48	;ALLHARD_TILES


.align	$100

; at $6100
enemy_data:
.byte $0

; enemy0: garg at 7,7, right


.align	$100

; at $6200
oracle_message:
.byte $FF		; no message
	;      012345678901234567890123456789012345678

.align $100

; at $6300
level5_data_zx02:
        .incbin         "maps/level5_map.zx02"
