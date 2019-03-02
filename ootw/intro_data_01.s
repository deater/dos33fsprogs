; background graphics

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

