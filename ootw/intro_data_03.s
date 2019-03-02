; background graphics

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
	.byte	1
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


