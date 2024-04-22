; Level 4 (Capital City)

.include "enemies.inc"

; at $6000

level4_data:
.byte	116	;MAX_TILE_X 		= 116	; 116 wide
.byte	20	;MAX_TILE_Y 		= 16	; 20 tall

.byte	4	;START_KEEN_TILEX	= 4
.byte	16	;START_KEEN_TILEY	= 16

.byte	0	;START_TILEMAP_X	= 0
.byte	8	;START_TILEMAP_Y	= 8

.byte	8	;NUM_ENEMIES		= 8

.byte	40	;HARDTOP_TILES   	= 40
.byte	48	;ALLHARD_TILES   	= 48


.align	$100

; at $6100
enemy_data:

enemy_data_out:         .byte 1,     0,   0,    0,    0,    0,   0,    0
enemy_data_exploding:   .byte 0,     0,   0,    0,    0,    0,   0,    0
enemy_data_type:        .byte YORP,  YORP, YORP, YORP, YORP, YORP,YORP,YORP
enemy_data_direction:   .byte LEFT, LEFT, LEFT, LEFT, RIGHT, RIGHT,RIGHT,RIGHT
enemy_data_tilex:       .byte 18,    31,   18,   43,   17,   32,  105, 103
enemy_data_tiley:       .byte 3,     3,    7,    7 ,   16,   16,  11,  16
enemy_data_x:           .byte 0,     0,    0,    0,    0,    0,   0,   0
enemy_data_y:           .byte 0,     0,    0,    0,    0,    0,   0,   0
enemy_data_state:       .byte 0,     0,    0,    0,    0,    0,   0,   0
enemy_data_count:       .byte 8,     8,    8,    8,    8,    8,   8,   8


; enemy1: yorp @18,3, leftt
; enemy2: yorp @31,3  left
; enemy3: yorp @18,7  left
; enemy4: yorp @43,7  left
; enemy5: yorp @17,16 right
; enemy6: yorp @32,16 right
; enemy7: yorp @105,11 right
; enemy8: yorp @103,16 right

; enemy9: garg @63,16 right


; enemy?: vorticon  @97,4 right

.align	$100

; at $6200
oracle_message:
.byte $FF		; no message

.align $100

; at $6300
level4_data_zx02:
        .incbin         "maps/level4_map.zx02"
