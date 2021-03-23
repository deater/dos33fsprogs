;=================================
;=================================
; Intro Segment 09 Data (Tunnel)
;=================================
;=================================



; background graphics

.include "graphics/09_tunnel/intro_tunnel1.inc"
.include "graphics/09_tunnel/intro_tunnel2.inc"
.include "graphics/08_lightning/nothing.inc"
.include "graphics/08_lightning/whiteblack.inc"

	;=======================
	; Tunnel1 Sequence
	;=======================
tunnel1_sequence:
	.byte 10
	.word nothing_lzsa
	.byte 50
	; red blob
	.word tunnel1_01_lzsa
	.byte 128+2	;	.word tunnel1_02_lzsa
	.byte 128+2	;	.word tunnel1_03_lzsa
	.byte 128+2	;	.word tunnel1_04_lzsa
	.byte 128+2	;	.word tunnel1_05_lzsa
	.byte 2

	; lightning blob
	.word nothing_lzsa
	.byte 50
	.word tunnel1_06_lzsa
	.byte 128+2	;	.word tunnel1_07_lzsa
	.byte 2
	.word white_lzsa
	.byte 2
	.word tunnel1_08_lzsa
	.byte 128+2	;	.word tunnel1_09_lzsa
	.byte 128+2	;	.word tunnel1_10_lzsa
	.byte 128+2	;	.word tunnel1_11_lzsa
	.byte 128+2	;	.word tunnel1_12_lzsa
	.byte 128+2	;	.word tunnel1_13_lzsa
	.byte 128+2	;	.word tunnel1_14_lzsa
	.byte 128+2	;	.word tunnel1_15_lzsa
	.byte 128+2	;	.word tunnel1_16_lzsa
	.byte 128+2	;	.word tunnel1_17_lzsa
	.byte 128+2	;	.word tunnel1_18_lzsa
	.byte 128+2	;	.word tunnel1_19_lzsa
	.byte 2
	.word nothing_lzsa
	.byte 0


	;=======================
	; Tunnel2 Sequence
	;=======================
tunnel2_sequence:
	.byte 10
	.word nothing_lzsa
	.byte 50
	; red blob
	.word tunnel2_01_lzsa
	.byte 128+2	;	.word tunnel2_02_lzsa
	.byte 128+2	;	.word tunnel2_03_lzsa
	.byte 128+2	;	.word tunnel2_04_lzsa
	.byte 128+2	;	.word tunnel2_05_lzsa
	.byte 128+2	;	.word tunnel2_06_lzsa
	.byte 128+2	;	.word tunnel2_07_lzsa
	.byte 128+2	;	.word tunnel2_08_lzsa
	.byte 128+2	;	.word tunnel2_09_lzsa
	.byte 2
	.word nothing_lzsa
	.byte 50

	; lightning blob
	.word tunnel2_10_lzsa
	.byte 128+2	;	.word tunnel2_11_lzsa
	.byte 128+2	;	.word tunnel2_12_lzsa
	.byte 128+2	;	.word tunnel2_13_lzsa
	.byte 128+2	;	.word tunnel2_14_lzsa
	.byte 128+2	;	.word tunnel2_15_lzsa
	.byte 128+2	;	.word tunnel2_16_lzsa
	.byte 128+2	;	.word tunnel2_17_lzsa
	.byte 2
	.word nothing_lzsa
	.byte 0



;=================================
;=================================
; Intro Segment 10 Data (Zappo)
;=================================
;=================================

.include "graphics/10_gone/intro_zappo.inc"
.include "graphics/10_gone/intro_gone.inc"

	;=======================
	; Zappo Sequence
	;=======================
zappo_sequence:

	.byte 50
	.word white_lzsa

	.byte 2
	.word zappo01_lzsa				; B

	.byte 128+2	;	.word zappo02_lzsa	; B
	.byte 128+2	;	.word zappo03_lzsa	; A
	.byte 128+2	;	.word zappo04_lzsa	; B
	.byte 128+2	;	.word zappo05_lzsa	; B

	.byte 255
	.word zappo03_lzsa	; load A
	.byte 2
	.word zappo06_lzsa	; A

	.byte 255
	.word blue_zappo_lzsa	; load b
	.byte 2
	.word zappo07_lzsa	; B

	.byte 2
	.word zappo08_lzsa	; B

	.byte 255
	.word zappo03_lzsa	; load A
	.byte 2
	.word zappo09_lzsa	; A

	.byte 255
	.word blue_zappo_lzsa	; load b
	.byte 2
	.word zappo10_lzsa	; B

	.byte 255
	.word zappo03_lzsa	; load A
	.byte 2
	.word zappo11_lzsa	; A

	.byte 255
	.word blue_zappo_lzsa	; load b
	.byte 2
	.word zappo12_lzsa	; B
	.byte 128+2	;	.word zappo13_lzsa	; B
	.byte 128+2	;	.word zappo14_lzsa	; B

	.byte 255
	.word zappo03_lzsa	; load A
	.byte 2
	.word zappo15_lzsa	; A

	.byte 255
	.word blue_zappo_lzsa	; load b
	.byte 2
	.word zappo16_lzsa	; B
	.byte 128+2	;	.word zappo17_lzsa	; B
	.byte 2
	.word white_lzsa
	.byte 128+5	;	.word black_lzsa
	.byte 5
	.word white_lzsa
	.byte 128+5	;	.word black_lzsa
;	.byte 5
;	.word white_lzsa
;	.byte 1
;	.word black_lzsa
;	.byte 1
;	.word white_lzsa
;	.byte 1
;	.word black_lzsa
;	.byte 1
;	.word white_lzsa
;	.byte 1
;	.word black_lzsa
	.byte 0
	.word nothing_lzsa


	;=======================
	; Gone Sequence
	;=======================
gone_sequence:

	.byte 50
	.word white_lzsa

	.byte 7
	.word gone01_lzsa				; B

	.byte 128+7	;	.word gone02_lzsa	; B
	.byte 128+7	;	.word gone03_lzsa	; B
	.byte 128+7	;	.word gone04_lzsa	; B
	.byte 128+7	;	.word gone05_lzsa	; B
	.byte 128+7	;	.word gone06_lzsa	; B
	.byte 128+7	;	.word gone07_lzsa	; B
	.byte 128+7	;	.word gone08_lzsa	; B
	.byte 128+7	;	.word gone09_lzsa	; LB
	.byte 128+7	;	.word gone10_lzsa	; CY

	.byte 255
	.word gone09_lzsa	; LB into $c00
	.byte 7
	.word gone11_lzsa	; LB

	.byte 255
	.word gone_lzsa		; B back into $c00
	.byte 7
	.word gone02_lzsa	; B (12 is dupe of 2)

	.byte 7
	.word gone13_lzsa	; B

	.byte 255
	.word gone09_lzsa	; LB into $c00
	.byte 7
	.word gone14_lzsa	; LB

	.byte 255
	.word gone_lzsa		; B back into $c00 + plain
	.byte 7
	.word nothing_lzsa

	.byte 7
	.word gone16_lzsa	; B

	.byte 7
	.word nothing_lzsa	; B (plain?)

	.byte 7
	.word gone18_lzsa	; B
	.byte 128+7	;	.word gone19_lzsa	; B
	.byte 128+7	;	.word gone20_lzsa	; B
	.byte 128+7	;	.word gone21_lzsa	; B

	.byte 7
	.word nothing_lzsa	; B (plain?)

	.byte 7
	.word gone23_lzsa	; B
	.byte 128+7	;	.word gone24_lzsa	; B
	.byte 128+7	;	.word gone25_lzsa	; B
	.byte 128+7	;	.word gone26_lzsa	; B
	.byte 128+7	;	.word gone27_lzsa	; B

	.byte 255
	.word gone09_lzsa	; LB into $c00
	.byte 7
	.word gone28_lzsa	; LB

;	.byte 255
;	.word gone10_lzsa	; CY into $c00
	.byte 7
	.word gone10_lzsa	; CY (same as 10)

	.byte 255
	.word gone09_lzsa	; LB into $c00
	.byte 7
	.word gone28_lzsa	; LB (30 same as 28)

	.byte 255
	.word gone_lzsa		; B back into $c00 + plain
	.byte 7
	.word gone31_lzsa	; B

	.byte 255
	.word gone09_lzsa	; LB into $c00
	.byte 7
	.word gone32_lzsa	; LB

	.byte 255
	.word gone_lzsa		; B back into $c00 + plain
	.byte 7
	.word nothing_lzsa	; B (plain?)

	.byte 7
	.word gone34_lzsa	; B

	.byte 128+7	;	.word gone35_lzsa	; B
	.byte 128+7	;	.word gone36_lzsa	; B
	.byte 128+7	;	.word gone37_lzsa	; B
	.byte 128+7	;	.word gone38_lzsa	; B

	.byte 255
	.word gone09_lzsa	; LB into $c00
	.byte 7
	.word gone39_lzsa	; LB

	.byte 255
	.word gone10_lzsa	; CY into $c00
	.byte 7
	.word gone40_lzsa	; CY

	.byte 7
	.word gone10_lzsa	; CY (same as 10)

	.byte 255
	.word gone09_lzsa	; LB into $c00
	.byte 7
	.word gone42_lzsa	; LB

	.byte 255
	.word gone_lzsa		; B back into $c00 + plain
	.byte 7
	.word gone43_lzsa	; B

	.byte 7
	.word nothing_lzsa
	.byte 0


