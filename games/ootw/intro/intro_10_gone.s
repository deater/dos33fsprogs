;==========================
; OOTW -- Intro -- Zapped
;==========================

intro_10_gone:

;===============================
;===============================
; Zappo / Gone
;===============================
;===============================

	;=========================
	; zappo

	lda	#<(blue_zappo_lzsa)
        sta     getsrc_smc+1    ; LZSA_SRC_LO
	lda	#>(blue_zappo_lzsa)
	sta     getsrc_smc+2    ; LZSA_SRC_HI

	lda	#$c			; load to off-screen $c00
	jsr	decompress_lzsa2_fast

	jsr	gr_copy_to_current
	jsr	page_flip

	lda	#<zappo_sequence
	sta	INTRO_LOOPL
	lda	#>zappo_sequence
	sta	INTRO_LOOPH

	jsr	run_sequence

	;======================
	; gone

	lda	#<(gone_lzsa)
        sta     getsrc_smc+1    ; LZSA_SRC_LO
	lda	#>(gone_lzsa)
	sta     getsrc_smc+2    ; LZSA_SRC_HI

	lda	#$c			; load to off-screen $c00
	jsr	decompress_lzsa2_fast

	jsr	gr_copy_to_current
	jsr	page_flip

	lda	#<gone_sequence
	sta	INTRO_LOOPL
	lda	#>gone_sequence
	sta	INTRO_LOOPH


	jsr	run_sequence

	;======================
	; Pause a bit

	ldx	#180
	jsr	long_wait

	rts






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


