; Level 8 (Ice City)

.include "enemies.inc"

; at $6000

level8_data:
.byte	76	;MAX_TILE_X
.byte	56	;MAX_TILE_Y

.byte	66	;START_KEEN_TILEX
.byte	52	;START_KEEN_TILEY

.byte	55	;START_TILEMAP_X
.byte	43	;START_TILEMAP_Y

.byte	0	;NUM_ENEMIES

.byte	40	;HARDTOP_TILES
.byte	48	;ALLHARD_TILES


.align	$100

; at $6100
enemy_data:

.byte	$0

; enemy0: robot @22,5 left
; enemy1: robot @9,5 right
; enemy1: robot @70,22 left
; enemy1: robot @56,52 left

; enemy: butler robot @9,9 right
; enemy: butler robot @23,12 right
; enemy: butler robot @21,24 right
; enemy: butler robot @7,18 left
; enemy: butler robot @6,30 right
; enemy: butler robot @67,44 left
; enemy: butler robot @69,44 left

; enemy?: vorticon  @56,13 left

; enemy?: cannon @64,22,left
; enemy?: cannon @55,22,right
; enemy?: cannon @18,47,right

; enemy9: garg @54,35 right
; enemy10: garg @37,42 right


.align	$100

; at $6200
oracle_message:
.byte $0

.align $100

; at $6300
level8_data_zx02:
        .incbin         "maps/level8_map.zx02"
