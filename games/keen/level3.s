; Level 3 (Treasury)

.include "enemies.inc"

; at $6000

level3_data:
.byte	116	;MAX_TILE_X 		= 116	; 116 wide
.byte	44	;MAX_TILE_Y 		= 16	; 44 tall

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

enemy_data_out:         .byte 1,     0,   0,    0,    0,    0,   0,    0
enemy_data_exploding:   .byte 0,     0,   0,    0,    0,    0,   0,    0
enemy_data_type:        .byte YORP,  YORP, YORP, YORP, YORP, YORP,YORP,YORP
enemy_data_direction:   .byte RIGHT, LEFT, LEFT, RIGHT, LEFT, RIGHT,LEFT,LEFT
enemy_data_tilex:       .byte 16,    19,   23,   14,   14,   16,  42,  70
enemy_data_tiley:       .byte 9,     9,    9,    45,   38,   43,  44,  34
enemy_data_x:           .byte 0,     0,    0,    0,    0,    0,   0,   0
enemy_data_y:           .byte 0,     0,    0,    0,    0,    0,   0,   0
enemy_data_state:       .byte 0,     0,    0,    0,    0,    0,   0,   0
enemy_data_count:       .byte 8,     8,    8,    8,    8,    8,   8,   8


; enemy1: yorp @16,9, right
; enemy2: yorp @19,9  left
; enemy3: yorp @23,9  left
; enemy4: yorp @14,45 right
; enemy5: yorp @14,38 left
; enemy6: yorp @16,43 right
; enemy7: yorp @42,44 left
; enemy8: yorp @70,34 left

; enemy9: garg @50,31 right
; enemy10: garg @63,45 right

; enemy?: butler robot@27,7 left
; enemy?: vorticon  @53,8 right

.align	$100

; at $6200
oracle_message:
.byte $FF		; no message

.align $100

; at $6300
level1_data_zx02:
        .incbin         "maps/level3_map.zx02"
