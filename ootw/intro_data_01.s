;=================================
;=================================
; Intro Segment 01 Data (Building)
;=================================
;=================================

.include "intro_graphics/01_building/intro_building.inc"
.include "intro_graphics/01_building/intro_car.inc"
.include "intro_graphics/01_building/intro_building_car.inc"

;========================
; Car driving up sequence

building_sequence:
	.byte	255
	.word	building_rle
	.byte	1
	.word	building_rle
	.byte	128+126	;	.word	intro_car1
	.byte	128+2	;	.word	intro_car2
	.byte	128+2	;	.word	intro_car3
	.byte	128+2	;	.word	intro_car4
	.byte	128+2	;	.word	intro_car5
	.byte	128+2	;	.word	intro_car6
	.byte	128+2	;	.word	intro_car7
	.byte	128+2	;	.word	intro_car8
	.byte	128+2	;	.word	intro_car9
	.byte	128+126	;	.word	intro_car10
;	.byte	0

;========================
; Getting out of car sequence

outtacar_sequence:
	.byte	255
	.word	building_car_rle
	.byte	1
	.word	building_car_rle
	.byte	100
	.word	intro_car12
	.byte	128+50	;	.word	intro_car13
	.byte	128+125	;	.word	intro_car14
	.byte	125
	.word	intro_car14
	.byte	0


;=================================
;=================================
; Intro Segment 02 Data (Door)
;=================================
;=================================

; background graphics

.include "intro_graphics/02_outer_door/outer_door.inc"
.include "intro_graphics/02_outer_door/feet.inc"
.include "intro_graphics/08_lightning/nothing.inc"

;=============================
; Feet going in door sequence

feet_sequence:
	.byte	255
	.word	outer_door_rle
	.byte	1
	.word	outer_door_rle
	.byte	128+100	;	.word	feet01_rle
	.byte	128+10	;	.word	feet02_rle
	.byte	128+10	;	.word	feet03_rle
	.byte	128+10	;	.word	feet04_rle
	.byte	128+10	;	.word	feet05_rle
	.byte	128+10	;	.word	feet06_rle
	.byte	128+10	;	.word	feet07_rle
	.byte	128+10	;	.word	feet08_rle
	.byte	128+30	;	.word	feet09_rle
	.byte	128+10	;	.word	feet10_rle
	.byte	128+10	;	.word	feet11_rle
	.byte	128+10	;	.word	feet12_rle
	.byte	128+10	;	.word	feet13_rle
	.byte	128+10	;	.word	feet14_rle
	.byte	128+10	;	.word	feet15_rle
	.byte	10
	.word	nothing_rle
	.byte	100
	.word	nothing_rle
	.byte	0


;=================================
;=================================
; Intro Segment 03 Data (Elevator)
;=================================
;=================================

.include "intro_graphics/03_elevator/intro_elevator.inc"
.include "intro_graphics/03_elevator/intro_off_elevator.inc"
.include "intro_graphics/03_elevator/intro_walking.inc"


	; Elevator light co-ordinates
	; we load them backwards
indicators:
	.byte 	18,4	; 4
	.byte	16,3	; 3
	.byte 	14,2	; 2
	.byte	18,2	; 1
	.byte	16,1	; 0

; Walking off elevator sequence

walking_sequence:
	.byte	20
	.word	walking01_rle
	.byte	128+20	;	.word	walking02_rle
	.byte	128+20	;	.word	walking03_rle
	.byte	128+20	;	.word	walking04_rle
	.byte	128+20	;	.word	walking05_rle
	.byte	128+20	;	.word	walking06_rle
	.byte	128+20	;	.word	walking07_rle
	.byte	128+20	;	.word	walking08_rle
	.byte	20
	.word	walking08_rle
	.byte	0
