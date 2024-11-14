;license:MIT
;(c) 2019 by 4am
;
; vmw: re-formatted and moved to ca65 syntax and un-macroed a bit

; Wipe from page1 to what's on page2 toward the center

; Make sure these are in the "wipe range" in zp.inc

; also uses WIPEL / GBASL?

COPYMASK1	= $C2
COPYMASK2	= $C3
SKIPCOUNTER	= $C7
TOP		= $C9
BOTTOM		= $CA
COUNTER		= $CB
MASKINDEX	= $CC
ROW		= $CD
COL1		= $CE
COL2		= $CF


do_wipe_center:
	lda	#44
	sta	SKIPCOUNTER
	lda	#$5F
	sta	COUNTER
	lda	#0
	sta	TOP
	lda	#$BF
	sta	BOTTOM
	lda	#0
	sta	COL1
	lda	#39
	sta	COL2
ColLoop:
	lda	#6
	sta	MASKINDEX
	jsr	wait_vblank
MaskLoop:
	ldx	MASKINDEX
	lda	copymasks1,X
	sta	COPYMASK1
	lda	copymasks2,X
	sta	COPYMASK2

	lda	#23
	sta	ROW
RowLoop:
	lda	ROW

	jsr	hgr_row_calc	;	HGR_ROW_CALC
	ldx	#8
BlockLoop:
	ldy	COL1
	lda	(GBASL),Y
	eor	(WIPEL),Y
	and	COPYMASK1
	eor	(GBASL),Y
	sta	(GBASL),Y

	ldy	COL2
	lda	(GBASL),Y
	eor	(WIPEL),Y
	and	COPYMASK2
	eor	(GBASL),Y
	sta	(GBASL),Y

	clc
	jsr	hgr_inc_within_block	; HGR_INC_WITHIN_BLOCK
	dex
	bne	BlockLoop

	dec	ROW
	bpl	RowLoop

	dec	SKIPCOUNTER

	bmi	skip1			; LBPL SkipTopAndBottom
	jmp	SkipTopAndBottom
skip1:

	lda	TOP

	jsr	hgr_calc		;	HGR_CALC

	ldy	#39
cbpm:
	lda	(WIPEL),Y
	sta	(GBASL),Y
	dey
	bpl	cbpm
	inc	TOP

	lda	BOTTOM

	jsr	hgr_calc		;	HGR_CALC
	ldy	#39
cbpm2:
	lda	(WIPEL),Y
	sta	(GBASL),Y
	dey
	bpl	cbpm2
	dec	BOTTOM

	dec	COUNTER
	bmi	cExit
SkipTopAndBottom:
	lda	$c000
	bmi	cExit
	dec	MASKINDEX

				; LBPL	MaskLoop

	bmi	skip2
	jmp	MaskLoop
skip2:

	inc	COL1
	dec	COL2
				; LBNE	ColLoop

	beq	skip3
	jmp	ColLoop
skip3:

cExit:
	;    jmp   UnwaitForVBL
	rts

copymasks1:
         .byte %11111111
         .byte %10111111
         .byte %10011111
         .byte %10001111
         .byte %10000111
         .byte %10000011
         .byte %10000001
copymasks2:
         .byte %11111111
         .byte %11111110
         .byte %11111100
         .byte %11111000
         .byte %11110000
         .byte %11100000
         .byte %11000000

hgr_row_calc:
	asl
	asl
	asl

hgr_calc:
; in:    A = HGR row (0x00..0xBF)
; out:   A/X clobbered
;        Y preserved
;        (GBASL) points to first byte of given HGR row on hi-res page 1
;        (WIPEL) points to same byte on hi-res page 2

	tax
	lda	hposn_low,X
	sta	GBASL
	sta	WIPEL
	lda	hposn_high,X
	sta	GBASH
	eor	#$60
	sta	WIPEH

	rts


; /!\ C must be clear before using this macro

hgr_inc_within_block:
	lda	GBASH
	adc	#$04
	sta	GBASH
	eor	#$60
	sta	WIPEH
	rts
