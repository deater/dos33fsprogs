;license:MIT
;
; originally based on code by 4am but completely changed
;	by vince `deater` weaver

;------------------------------------------------------------------------------
; font_putchar
;
; draw to DRAW_PAGE
;
; in:	A char to print
;	Y = xpos (note X/7)
;	X = ypos
;------------------------------------------------------------------------------

font_putchar:

	sty	CH			; save the X column offset

	tay

	; row0

	lda	hposn_low, X		; get low memory offset
	clc
	adc	CH			; add in x-coord
	sta	dcb2_row0+1
	lda	hposn_high, X		; get high memory offset
	clc
	adc	DRAW_PAGE
	sta	dcb2_row0+2		; save it out

	lda	CondensedRow0-$19, Y	; get 1-byte font row
dcb2_row0:
	sta	$8888

	inx				; go to next row

	; row1

	lda	hposn_low, X		; get low memory offset
	clc
	adc	CH			; add in x-coord
	sta	dcb2_row1+1
	lda	hposn_high, X		; get high memory offset
	clc
	adc	DRAW_PAGE
	sta	dcb2_row1+2		; save it out

	lda	CondensedRow1-$19, Y	; get 1-byte font row
dcb2_row1:
	sta	$8888

	inx				; go to next row

	; row2

	lda	hposn_low, X		; get low memory offset
	clc
	adc	CH			; add in x-coord
	sta	dcb2_row2+1
	lda	hposn_high, X		; get high memory offset
	clc
	adc	DRAW_PAGE
	sta	dcb2_row2+2		; save it out

	lda	CondensedRow2-$19, Y	; get 1-byte font row
dcb2_row2:
	sta	$8888

	inx				; go to next row

	; row3

	lda	hposn_low, X		; get low memory offset
	clc
	adc	CH			; add in x-coord
	sta	dcb2_row3+1
	lda	hposn_high, X		; get high memory offset
	clc
	adc	DRAW_PAGE
	sta	dcb2_row3+2		; save it out

	lda	CondensedRow3-$19, Y	; get 1-byte font row
dcb2_row3:
	sta	$8888

	inx				; go to next row

	; row4

	lda	hposn_low, X		; get low memory offset
	clc
	adc	CH			; add in x-coord
	sta	dcb2_row4+1
	lda	hposn_high, X		; get high memory offset
	clc
	adc	DRAW_PAGE
	sta	dcb2_row4+2		; save it out

	lda	CondensedRow4-$19, Y	; get 1-byte font row
dcb2_row4:
	sta	$8888

	inx				; go to next row

	; row5

	lda	hposn_low, X		; get low memory offset
	clc
	adc	CH			; add in x-coord
	sta	dcb2_row5+1
	lda	hposn_high, X		; get high memory offset
	clc
	adc	DRAW_PAGE
	sta	dcb2_row5+2		; save it out

	lda	CondensedRow5-$19, Y	; get 1-byte font row
dcb2_row5:
	sta	$8888

	inx				; go to next row

	; row6

	lda	hposn_low, X		; get low memory offset
	clc
	adc	CH			; add in x-coord
	sta	dcb2_row6+1
	lda	hposn_high, X		; get high memory offset
	clc
	adc	DRAW_PAGE
	sta	dcb2_row6+2		; save it out

	lda	CondensedRow6-$19, Y	; get 1-byte font row
dcb2_row6:
	sta	$8888

	inx				; go to next row

	; row7

	lda	hposn_low, X		; get low memory offset
	clc
	adc	CH			; add in x-coord
	sta	dcb2_row7+1
	lda	hposn_high, X		; get high memory offset
	clc
	adc	DRAW_PAGE
	sta	dcb2_row7+2		; save it out

	lda	CondensedRow7-$19, Y	; get 1-byte font row
dcb2_row7:
	sta	$8888

	rts

