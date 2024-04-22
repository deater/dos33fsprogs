; Level 14 (Secret City)

.include "enemies.inc"

; at $6000

level14_data:
.byte	116	;MAX_TILE_X 		= 116	; 116 wide
.byte	20	;MAX_TILE_Y 		= 16	; 20 tall

.byte	4	;START_KEEN_TILEX	= 4
.byte	16	;START_KEEN_TILEY	= 16

.byte	0	;START_TILEMAP_X	= 0
.byte	8	;START_TILEMAP_Y	= 8

.byte	0	;NUM_ENEMIES		= 8

.byte	32	;HARDTOP_TILES   	= 32	; start at 32
.byte	40	;ALLHARD_TILES   	= 40	; start at 40


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

; FIXME: this is not correct
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
.byte $0

.align $100

; at $6300
level14_data_zx02:
        .incbin         "maps/level14_map.zx02"
