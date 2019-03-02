; background graphics

.include "intro_graphics/07_soda/intro_open_soda.inc"
.include "intro_graphics/07_soda/intro_drinking.inc"

; Soda sequence

soda_sequence:
	.byte	1
	.word	soda01_rle
	.byte	128+30	;	.word	soda02_rle
	.byte	128+15	;	.word	soda03_rle
	.byte	128+15	;	.word	soda04_rle
	.byte	128+15	;	.word	soda05_rle
	.byte	128+15	;	.word	soda06_rle
	.byte	128+15	;	.word	soda07_rle
	.byte	128+15	;	.word	soda08_rle
	.byte	128+15	;	.word	soda09_rle
	.byte	20
	.word	soda09_rle
	.byte	0


drinking_sequence:
	.byte 30
	.word drinking02_rle
	.byte 128+30	;	.word drinking03_rle
	.byte 128+30	;	.word drinking04_rle
	.byte 128+30	;	.word drinking05_rle
	.byte 0


