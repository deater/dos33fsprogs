; background graphics

.include "intro_graphics/09_tunnel/intro_tunnel1.inc"
.include "intro_graphics/09_tunnel/intro_tunnel2.inc"

	;=======================
	; Tunnel1 Sequence
	;=======================
tunnel1_sequence:
	.byte 10
	.word nothing_rle
	.byte 50
	; red blob
	.word tunnel1_01_rle
	.byte 128+2	;	.word tunnel1_02_rle
	.byte 128+2	;	.word tunnel1_03_rle
	.byte 128+2	;	.word tunnel1_04_rle
	.byte 128+2	;	.word tunnel1_05_rle
	.byte 2

	; lightning blob
	.word nothing_rle
	.byte 50
	.word tunnel1_06_rle
	.byte 128+2	;	.word tunnel1_07_rle
	.byte 2
	.word white_rle
	.byte 2
	.word tunnel1_08_rle
	.byte 128+2	;	.word tunnel1_09_rle
	.byte 128+2	;	.word tunnel1_10_rle
	.byte 128+2	;	.word tunnel1_11_rle
	.byte 128+2	;	.word tunnel1_12_rle
	.byte 128+2	;	.word tunnel1_13_rle
	.byte 128+2	;	.word tunnel1_14_rle
	.byte 128+2	;	.word tunnel1_15_rle
	.byte 128+2	;	.word tunnel1_16_rle
	.byte 128+2	;	.word tunnel1_17_rle
	.byte 128+2	;	.word tunnel1_18_rle
	.byte 128+2	;	.word tunnel1_19_rle
	.byte 2
	.word nothing_rle
	.byte 0


	;=======================
	; Tunnel2 Sequence
	;=======================
tunnel2_sequence:
	.byte 10
	.word nothing_rle
	.byte 50
	; red blob
	.word tunnel2_01_rle
	.byte 128+2	;	.word tunnel2_02_rle
	.byte 128+2	;	.word tunnel2_03_rle
	.byte 128+2	;	.word tunnel2_04_rle
	.byte 128+2	;	.word tunnel2_05_rle
	.byte 128+2	;	.word tunnel2_06_rle
	.byte 128+2	;	.word tunnel2_07_rle
	.byte 128+2	;	.word tunnel2_08_rle
	.byte 128+2	;	.word tunnel2_09_rle
	.byte 2
	.word nothing_rle
	.byte 50

	; lightning blob
	.word tunnel2_10_rle
	.byte 128+2	;	.word tunnel2_11_rle
	.byte 128+2	;	.word tunnel2_12_rle
	.byte 128+2	;	.word tunnel2_13_rle
	.byte 128+2	;	.word tunnel2_14_rle
	.byte 128+2	;	.word tunnel2_15_rle
	.byte 128+2	;	.word tunnel2_16_rle
	.byte 128+2	;	.word tunnel2_17_rle
	.byte 2
	.word nothing_rle
	.byte 0


