;=================================
;=================================
; Intro Segment 09 Data (Tunnel)
;=================================
;=================================



; background graphics

.include "intro_graphics/09_tunnel/intro_tunnel1.inc"
.include "intro_graphics/09_tunnel/intro_tunnel2.inc"
.include "intro_graphics/08_lightning/nothing.inc"
.include "intro_graphics/08_lightning/whiteblack.inc"

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



;=================================
;=================================
; Intro Segment 10 Data (Zappo)
;=================================
;=================================

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


