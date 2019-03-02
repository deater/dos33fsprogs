; background graphics

.include "intro_graphics/02_outer_door/outer_door.inc"
.include "intro_graphics/02_outer_door/feet.inc"

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


