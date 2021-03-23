;=================================
;=================================
; Intro Segment 07 Data (Soda)
;=================================
;=================================

.include "graphics/07_soda/intro_open_soda.inc"
.include "graphics/07_soda/intro_drinking.inc"

; Soda sequence

soda_sequence:
	.byte	1
	.word	soda01_lzsa
	.byte	128+30	;	.word	soda02_lzsa
	.byte	128+15	;	.word	soda03_lzsa
	.byte	128+15	;	.word	soda04_lzsa
	.byte	128+15	;	.word	soda05_lzsa
	.byte	128+15	;	.word	soda06_lzsa
	.byte	128+15	;	.word	soda07_lzsa
	.byte	128+15	;	.word	soda08_lzsa
	.byte	128+15	;	.word	soda09_lzsa
	.byte	20
	.word	soda09_lzsa
	.byte	0


drinking_sequence:
	.byte 30
	.word drinking02_lzsa
	.byte 128+30	;	.word drinking03_lzsa
	.byte 128+30	;	.word drinking04_lzsa
	.byte 128+30	;	.word drinking05_lzsa
	.byte 0
