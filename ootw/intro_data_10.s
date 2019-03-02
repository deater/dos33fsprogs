; background graphics

.include "intro_graphics/10_gone/intro_zappo.inc"
.include "intro_graphics/10_gone/intro_gone.inc"

	;=======================
	; Zappo Sequence
	;=======================
zappo_sequence:

	.byte 50
	.word white_rle

	.byte 2
	.word zappo01_rle				; B

	.byte 128+2	;	.word zappo02_rle	; B
	.byte 128+2	;	.word zappo03_rle	; A
	.byte 128+2	;	.word zappo04_rle	; B
	.byte 128+2	;	.word zappo05_rle	; B

	.byte 255
	.word zappo03_rle	; load A
	.byte 2
	.word zappo06_rle	; A

	.byte 255
	.word blue_zappo_rle	; load b
	.byte 2
	.word zappo07_rle	; B

	.byte 2
	.word zappo08_rle	; B

	.byte 255
	.word zappo03_rle	; load A
	.byte 2
	.word zappo09_rle	; A

	.byte 255
	.word blue_zappo_rle	; load b
	.byte 2
	.word zappo10_rle	; B

	.byte 255
	.word zappo03_rle	; load A
	.byte 2
	.word zappo11_rle	; A

	.byte 255
	.word blue_zappo_rle	; load b
	.byte 2
	.word zappo12_rle	; B
	.byte 128+2	;	.word zappo13_rle	; B
	.byte 128+2	;	.word zappo14_rle	; B

	.byte 255
	.word zappo03_rle	; load A
	.byte 2
	.word zappo15_rle	; A

	.byte 255
	.word blue_zappo_rle	; load b
	.byte 2
	.word zappo16_rle	; B
	.byte 128+2	;	.word zappo17_rle	; B
	.byte 2
	.word white_rle
	.byte 128+5	;	.word black_rle
	.byte 5
	.word white_rle
	.byte 128+5	;	.word black_rle
;	.byte 5
;	.word white_rle
;	.byte 1
;	.word black_rle
;	.byte 1
;	.word white_rle
;	.byte 1
;	.word black_rle
;	.byte 1
;	.word white_rle
;	.byte 1
;	.word black_rle
	.byte 0
	.word nothing_rle


	;=======================
	; Gone Sequence
	;=======================
gone_sequence:

	.byte 50
	.word white_rle

	.byte 7
	.word gone01_rle				; B

	.byte 128+7	;	.word gone02_rle	; B
	.byte 128+7	;	.word gone03_rle	; B
	.byte 128+7	;	.word gone04_rle	; B
	.byte 128+7	;	.word gone05_rle	; B
	.byte 128+7	;	.word gone06_rle	; B
	.byte 128+7	;	.word gone07_rle	; B
	.byte 128+7	;	.word gone08_rle	; B
	.byte 128+7	;	.word gone09_rle	; LB
	.byte 128+7	;	.word gone10_rle	; CY

	.byte 255
	.word gone09_rle	; LB into $c00
	.byte 7
	.word gone11_rle	; LB

	.byte 255
	.word gone_rle		; B back into $c00
	.byte 7
	.word gone02_rle	; B (12 is dupe of 2)

	.byte 7
	.word gone13_rle	; B

	.byte 255
	.word gone09_rle	; LB into $c00
	.byte 7
	.word gone14_rle	; LB

	.byte 255
	.word gone_rle		; B back into $c00 + plain
	.byte 7
	.word nothing_rle

	.byte 7
	.word gone16_rle	; B

	.byte 7
	.word nothing_rle	; B (plain?)

	.byte 7
	.word gone18_rle	; B
	.byte 128+7	;	.word gone19_rle	; B
	.byte 128+7	;	.word gone20_rle	; B
	.byte 128+7	;	.word gone21_rle	; B

	.byte 7
	.word nothing_rle	; B (plain?)

	.byte 7
	.word gone23_rle	; B
	.byte 128+7	;	.word gone24_rle	; B
	.byte 128+7	;	.word gone25_rle	; B
	.byte 128+7	;	.word gone26_rle	; B
	.byte 128+7	;	.word gone27_rle	; B

	.byte 255
	.word gone09_rle	; LB into $c00
	.byte 7
	.word gone28_rle	; LB

;	.byte 255
;	.word gone10_rle	; CY into $c00
	.byte 7
	.word gone10_rle	; CY (same as 10)

	.byte 255
	.word gone09_rle	; LB into $c00
	.byte 7
	.word gone28_rle	; LB (30 same as 28)

	.byte 255
	.word gone_rle		; B back into $c00 + plain
	.byte 7
	.word gone31_rle	; B

	.byte 255
	.word gone09_rle	; LB into $c00
	.byte 7
	.word gone32_rle	; LB

	.byte 255
	.word gone_rle		; B back into $c00 + plain
	.byte 7
	.word nothing_rle	; B (plain?)

	.byte 7
	.word gone34_rle	; B

	.byte 128+7	;	.word gone35_rle	; B
	.byte 128+7	;	.word gone36_rle	; B
	.byte 128+7	;	.word gone37_rle	; B
	.byte 128+7	;	.word gone38_rle	; B

	.byte 255
	.word gone09_rle	; LB into $c00
	.byte 7
	.word gone39_rle	; LB

	.byte 255
	.word gone10_rle	; CY into $c00
	.byte 7
	.word gone40_rle	; CY

	.byte 7
	.word gone10_rle	; CY (same as 10)

	.byte 255
	.word gone09_rle	; LB into $c00
	.byte 7
	.word gone42_rle	; LB

	.byte 255
	.word gone_rle		; B back into $c00 + plain
	.byte 7
	.word gone43_rle	; B

	.byte 7
	.word nothing_rle
	.byte 0


