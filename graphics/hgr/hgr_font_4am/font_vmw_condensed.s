;license:MIT
;(c) 2023 by 4am
;
; drawing routines for Million Perfect Tiles Condensed
;
; Public functions:
; - DrawCondensedString
;

; VMW: commented, reformatted, minor changes, ca65 assembly

;------------------------------------------------------------------------------
; DrawCondensedString
;
; in:    A/Y points to zero terminated string, with x-pos and y-pos at start
; out:   clobbers all registers & flags
;------------------------------------------------------------------------------
DrawCondensedString:

	; store the string location

	sta	OUTL
	sty	OUTH

	ldy	#0
	lda	(OUTL), Y		; get xpos
	sta	CH			; save the X column offset
	iny

	lda	(OUTL),Y		; get ypos
	tay

	; add two to string pointer
	clc
	lda	OUTL
	adc	#2
	sta	dcb_loop+1
	lda	#0
	adc	OUTH
	sta	dcb_loop+2

	; row0

	lda	hposn_low, Y			; get low memory offset
	clc
	adc	CH				; add in x-coord
	sta	dcb_row0+4
	lda	hposn_high, Y			; get high memory offset
	sta	dcb_row0+5			; save it out
	iny					; go to next row

	; row1

	lda	hposn_low, Y
	adc	CH
	sta	dcb_row1+4
	lda	hposn_high, Y
	sta	dcb_row1+5
	iny

	; row2

	lda	hposn_low, Y
	adc	CH
	sta	dcb_row2+4
	lda	hposn_high, Y
	sta	dcb_row2+5
	iny

	; row3

	lda	hposn_low, Y
	adc	CH
	sta	dcb_row3+4
	lda	hposn_high, Y
	sta	dcb_row3+5
	iny

	; row4

	lda	hposn_low, Y
	adc	CH
	sta	dcb_row4+4
	lda	hposn_high, Y
	sta	dcb_row4+5
	iny

	; row5

	lda	hposn_low, Y
	adc	CH
	sta	dcb_row5+4
	lda	hposn_high, Y
	sta	dcb_row5+5
	iny

	; row6

	lda	hposn_low, Y
	adc	CH
	sta	dcb_row6+4
	lda	hposn_high, Y
	sta	dcb_row6+5
	iny

	; row7

	lda	hposn_low, Y
	adc	CH
	sta	dcb_row7+4
	lda	hposn_high, Y
	sta	dcb_row7+5
	iny

	; row8

	lda	hposn_low, Y
	adc	CH
	sta	dcb_row8+4
	lda	hposn_high, Y
	sta	dcb_row8+5
	iny

	; row9

	lda	hposn_low, Y
	adc	CH
	sta	dcb_row9+4
	lda	hposn_high, Y
	sta	dcb_row9+5

	ldx	#0
dcb_loop:
dcb_loop_smc:
	ldy	$FDFD, X		; load next char into Y
	beq	dcb_done

	; unrolled loop to write out each line

dcb_row0:
	lda	CondensedRow0-$19, Y	; get 1-byte font row
	sta	$FDFD, X		; write out to graphics mem
dcb_row1:
	lda	CondensedRow1-$19, Y
	sta	$FDFD, X
dcb_row2:
	lda	CondensedRow2-$19, Y
	sta	$FDFD, X
dcb_row3:
	lda	CondensedRow3-$19, Y
	sta	$FDFD, X
dcb_row4:
	lda	CondensedRow4-$19, Y
	sta	$FDFD, X
dcb_row5:
	lda	CondensedRow5-$19, Y
	sta	$FDFD, X
dcb_row6:
	lda	CondensedRow6-$19, Y
	sta	$FDFD, X
dcb_row7:
	lda	CondensedRow7-$19, Y
	sta	$FDFD, X
dcb_row8:
	lda	CondensedRow8-$19, Y
	sta	$FDFD, X
dcb_row9:
	lda	CondensedRow9-$19, Y
	sta	$FDFD, X

	inx				; move to next
	bpl   dcb_loop

dcb_done:

	rts

