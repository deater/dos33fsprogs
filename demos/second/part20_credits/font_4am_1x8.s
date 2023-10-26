;license:MIT
;(c) 2023 by 4am
;
; drawing routines for Million Perfect Tiles Condensed
;
; Public functions:
; - draw_condensed_1x8
;

; VMW: commented, reformatted, minor changes, ca65 assembly
;	hacked up some more

FONT_OFFSET = $13


;------------------------------------------------------------------------------
; draw_condensed_1x8
;
; in:    A/Y points to zero terminated string, with x-pos and y-pos at start
; out:   clobbers all registers & flags
;------------------------------------------------------------------------------
draw_condensed_1x8:

	; store the string location

	sta	OUTL
	sty	OUTH

draw_condensed_1x8_again:

	lda	OUTL
	sta	dcb_loop_1x8_smc+1
	lda	OUTH
	sta	dcb_loop_1x8_smc+2


	ldy	CV

	; row0

	lda	hposn_low, Y			; get low memory offset
	clc
	adc	CH				; add in x-coord
	sta	dcb_row_1x8_0+4
	lda	hposn_high, Y			; get high memory offset
	sta	dcb_row_1x8_0+5			; save it out
	iny					; go to next row

	; row1

	lda	hposn_low, Y
	adc	CH
	sta	dcb_row_1x8_1+4
	lda	hposn_high, Y
	sta	dcb_row_1x8_1+5
	iny

	; row2

	lda	hposn_low, Y
	adc	CH
	sta	dcb_row_1x8_2+4
	lda	hposn_high, Y
	sta	dcb_row_1x8_2+5
	iny

	; row3

	lda	hposn_low, Y
	adc	CH
	sta	dcb_row_1x8_3+4
	lda	hposn_high, Y
	sta	dcb_row_1x8_3+5
	iny

	; row4

	lda	hposn_low, Y
	adc	CH
	sta	dcb_row_1x8_4+4
	lda	hposn_high, Y
	sta	dcb_row_1x8_4+5
	iny

	; row5

	lda	hposn_low, Y
	adc	CH
	sta	dcb_row_1x8_5+4
	lda	hposn_high, Y
	sta	dcb_row_1x8_5+5
	iny

	; row6

	lda	hposn_low, Y
	adc	CH
	sta	dcb_row_1x8_6+4
	lda	hposn_high, Y
	sta	dcb_row_1x8_6+5
	iny

	; row7

	lda	hposn_low, Y
	adc	CH
	sta	dcb_row_1x8_7+4
	lda	hposn_high, Y
	sta	dcb_row_1x8_7+5

	ldx	#0
dcb_loop_1x8:
dcb_loop_1x8_smc:
	ldy	$FDFD, X		; load next char into Y
	beq	dcb_done_1x8

	cpy	#13
	bne	not_linefeed

	lda	#0
	sta	CH
	clc
	lda	CV
	adc	#8
	sta	CV
	inx

;	lda	CV
;	cmp	#192
;	bcc	dcb_loop_1x8

;	lda	#184
;	sta	CV

;	stx	XSAVE
;	jsr	scroll_screen
;	ldx	XSAVE

	jmp	dcb_loop_1x8


not_linefeed:
	; unrolled loop to write out each line

dcb_row_1x8_0:
	lda	font_1x8_row0-FONT_OFFSET, Y	; get 1-byte font row
	sta	$FDFD, X		; write out to graphics mem
dcb_row_1x8_1:
	lda	font_1x8_row1-FONT_OFFSET, Y
	sta	$FDFD, X
dcb_row_1x8_2:
	lda	font_1x8_row2-FONT_OFFSET, Y
	sta	$FDFD, X
dcb_row_1x8_3:
	lda	font_1x8_row3-FONT_OFFSET, Y
	sta	$FDFD, X
dcb_row_1x8_4:
	lda	font_1x8_row4-FONT_OFFSET, Y
	sta	$FDFD, X
dcb_row_1x8_5:
	lda	font_1x8_row5-FONT_OFFSET, Y
	sta	$FDFD, X
dcb_row_1x8_6:
	lda	font_1x8_row6-FONT_OFFSET, Y
	sta	$FDFD, X
dcb_row_1x8_7:
	lda	font_1x8_row7-FONT_OFFSET, Y
	sta	$FDFD, X

	inc	CH
	inx				; move to next

	bne	dcb_loop_1x8		; bra (well, as long as string
					;	is less than 255 chars)

dcb_done_1x8:

	; point to location after
	sec		; always add 1
	txa
	adc	OUTL
	sta	OUTL
	lda	#0
	adc	OUTH
	sta	OUTH

	rts


