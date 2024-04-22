; Level 1 (Border Town)

.include "enemies.inc"

; at $6000

level1_data:
.byte	116	;MAX_TILE_X 		= 116	; 116 wide
.byte	16	;MAX_TILE_Y 		= 16	; 16 tall

.byte	1	;START_KEEN_TILEX	= 1
.byte	13	;START_KEEN_TILEY	= 13

.byte	0	;START_TILEMAP_X	= 0
.byte	5	;START_TILEMAP_Y	= 5

.byte	8	;NUM_ENEMIES		= 8

.byte	40	;HARDTOP_TILES   	= 40
.byte	48	;ALLHARD_TILES   	= 48


.align	$100

; at $6100
enemy_data:

enemy_data_out:		.byte 1,     0,	  0,    0,    0,    0,   0,    0
enemy_data_exploding:	.byte 0,     0,	  0,    0,    0,    0,   0,    0
enemy_data_type:	.byte YORP,  YORP, YORP, YORP, YORP, YORP,YORP,YORP
enemy_data_direction:	.byte RIGHT, LEFT, LEFT, LEFT, LEFT, RIGHT,RIGHT,LEFT
enemy_data_tilex:	.byte 19,    38,   45,   69,   81,   89,  92,  100
enemy_data_tiley:	.byte 13,    4,    4,    13,   4,    4,   13,  10
enemy_data_x:		.byte 0,     0,    0,    0,    0,    0,   0,   0
enemy_data_y:		.byte 0,     0,    0,    0,    0,    0,   0,   0
enemy_data_state:	.byte 0,     0,    0,    0,    0,    0,   0,   0
enemy_data_count:	.byte 8,     8,    8,    8,    8,    8,   8,   8

.align	$100

; at $6200
oracle_message:
.byte $FF		; no message

.align $100

; at $6300
level1_data_zx02:
        .incbin         "maps/level1_map.zx02"



