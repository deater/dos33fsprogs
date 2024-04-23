; Level 7 (Emerald City)

.include "enemies.inc"

; at $6000

level7_data:
.byte	124	;MAX_TILE_X
.byte	60	;MAX_TILE_Y

.byte	2	;START_KEEN_TILEX
.byte	48	;START_KEEN_TILEY

.byte	0	;START_TILEMAP_X
.byte	40	;START_TILEMAP_Y

.byte	8	;NUM_ENEMIES

.byte	40	;HARDTOP_TILES
.byte	48	;ALLHARD_TILES


.align	$100

; at $6100
enemy_data:

enemy_data_out:         .byte 1,     0,   0,    0,    0,    0,   0,    0
enemy_data_exploding:   .byte 0,     0,   0,    0,    0,    0,   0,    0
enemy_data_type:        .byte YORP,  YORP, YORP, YORP, YORP, YORP,YORP,YORP
enemy_data_direction:   .byte LEFT, LEFT, LEFT, LEFT, LEFT, LEFT,RIGHT,LEFT
enemy_data_tilex:       .byte 61,    78,   16,   63,   31,   28, 112,  36
enemy_data_tiley:       .byte 4,     4,    15,   15,   28,   27,  54,  56
enemy_data_x:           .byte 0,     0,    0,    0,    0,    0,   0,   0
enemy_data_y:           .byte 0,     0,    0,    0,    0,    0,   0,   0
enemy_data_state:       .byte 0,     0,    0,    0,    0,    0,   0,   0
enemy_data_count:       .byte 8,     8,    8,    8,    8,    8,   8,   8

; enemy0: yorp @61,4, left
; enemy1: yorp @78,4  left
; enemy2: yorp @16,15 left
; enemy3: yorp @63,15 left
; enemy4: yorp @31,28 left
; enemy5: yorp @28,27 left
; enemy6: yorp @112,54 right
; enemy7: yorp @36,56 left

; enemy8: garg  @36,4 right
; enemy9: garg @39,4 right
; enemy10: garg @105,2 left
; enemy11: garg @102,11 right
; enemy12: garg @105,17 left
; enemy13: garg @96,21 left
; enemy14: garg @22,33 right
; enemy15: garg @34,34 right
; enemy16: garg @52,49 right

; enemy17: butler robot@91,39 right
; enemy18: butler robot@86,39 right
; enemy19: butler robot@31,39 left

; enemy?: big robot@93,56 right


.align	$100

; at $6200
oracle_message:
.byte $0

.align $100

; at $6300
level7_data_zx02:
        .incbin         "maps/level7_map.zx02"
