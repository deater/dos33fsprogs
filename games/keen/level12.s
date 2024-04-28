; Level 12 (Fifth Shrine)

.include "enemies.inc"

; at $6000

level12_data:
.byte	40	;MAX_TILE_X
.byte	36	;MAX_TILE_Y

.byte	1	;START_KEEN_TILEX
.byte	32	;START_KEEN_TILEY

.byte	0	;START_TILEMAP_X
.byte	24	;START_TILEMAP_Y

.byte	8	;NUM_ENEMIES

.byte	40	;HARDTOP_TILES
.byte	48	;ALLHARD_TILES


.align	$100

; at $6100
enemy_data:

enemy_data_out:         .byte 1,     0,   0,    0,    0,    0,   0,    0
enemy_data_exploding:   .byte 0,     0,   0,    0,    0,    0,   0,    0
enemy_data_type:        .byte YORP,  YORP, YORP, YORP, YORP, YORP,YORP,YORP
enemy_data_direction:   .byte LEFT, LEFT, RIGHT, LEFT, LEFT, LEFT,RIGHT,RIGHT
enemy_data_tilex:       .byte 32,    27,   33,   30,   24,   10,  13,  11
enemy_data_tiley:       .byte 28,    25,   22,    22,   18,   8,  10,  15
enemy_data_x:           .byte 0,     0,    0,    0,    0,    0,   0,   0
enemy_data_y:           .byte 0,     0,    0,    0,    0,    0,   0,   0
enemy_data_state:       .byte 0,     0,    0,    0,    0,    0,   0,   0
enemy_data_count:       .byte 8,     8,    8,    8,    8,    8,   8,   8


; enemy0: yorp @32,28, left
; enemy1: yorp @27,25, left
; enemy2: yorp @33,22, right
; enemy3: yorp @30,22, left
; enemy4: yorp @24,18, left
; enemy5: yorp @10,8, left
; enemy6: yorp @13,10, right
; enemy7: yorp @11,15, right
; enemy8: yorp @13,24, right
; enemy9: yorp @13,28, right

; butler @11,4 left
; butler @5,8 left
; butler @12,12 left
; butler @14,16 right
; butler @6,20 right
; butler @4,24 right
; butler @11,28 right



;	garg @32,32 right

.align	$100

; at $6200
oracle_message:
	;      0123456789012345678901234567890123456789
	.byte 2,20,"A YORPISH WHISPER SAYS:",0
	.byte 2,21,"LOOK FOR DARK, HIDDEN BRICKS.",0
	.byte 2,22,"YOU CAN SEE NAUGHT BUT THEIR",0
	.byte 2,23,"UPPER LEFT CORNER.",0

.align $100

; at $6300
level12_data_zx02:
        .incbin         "maps/level12_map.zx02"
