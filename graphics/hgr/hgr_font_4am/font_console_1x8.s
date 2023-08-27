;license:MIT
;(c) 2023 by 4am
;
; drawing routines for Million Perfect Tiles Condensed
;
; Public functions:
; - DrawCondensedString
;

; VMW: commented, reformatted, minor changes, ca65 assembly
;	hacked up some more

FONT_OFFSET = $13


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

DrawCondensedStringAgain:

	lda	OUTL
	sta	dcb_loop_smc+1
	lda	OUTH
	sta	dcb_loop_smc+2


	ldy	CV

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

	ldx	#0
dcb_loop:
dcb_loop_smc:
	ldy	$FDFD, X		; load next char into Y
	beq	dcb_done

	cpy	#13
	bne	not_linefeed

	lda	#0
	sta	CH
	clc
	lda	CV
	adc	#8
	sta	CV
	inx

	lda	CV
	cmp	#192
	bcc	dcb_loop

	lda	#184
	sta	CV

	stx	XSAVE
	jsr	scroll_screen
	ldx	XSAVE

	jmp	dcb_loop


not_linefeed:
	; unrolled loop to write out each line

dcb_row0:
	lda	CondensedRow0-FONT_OFFSET, Y	; get 1-byte font row
	sta	$FDFD, X		; write out to graphics mem
dcb_row1:
	lda	CondensedRow1-FONT_OFFSET, Y
	sta	$FDFD, X
dcb_row2:
	lda	CondensedRow2-FONT_OFFSET, Y
	sta	$FDFD, X
dcb_row3:
	lda	CondensedRow3-FONT_OFFSET, Y
	sta	$FDFD, X
dcb_row4:
	lda	CondensedRow4-FONT_OFFSET, Y
	sta	$FDFD, X
dcb_row5:
	lda	CondensedRow5-FONT_OFFSET, Y
	sta	$FDFD, X
dcb_row6:
	lda	CondensedRow6-FONT_OFFSET, Y
	sta	$FDFD, X
dcb_row7:
	lda	CondensedRow7-FONT_OFFSET, Y
	sta	$FDFD, X

	inc	CH
	inx				; move to next

	bne	dcb_loop		; bra (well, as long as string
					;	is less than 255 chars)

dcb_done:

	; point to location after
	sec		; always add 1
	txa
	adc	OUTL
	sta	OUTL
	lda	#0
	adc	OUTH
	sta	OUTH

	rts


	;================================
	;================================
	; scroll_screen
	;================================
	;================================
	; scrolls hgr page1 up by 8, filling with empty space at bottom
	;	trashes A,X,Y

scroll_screen:
	ldx	#8
	stx	SCROLL_IN
	ldx	#0
	stx	SCROLL_OUT

scroll_yloop:
	ldx	SCROLL_IN
	lda	hposn_low,X
	sta	xloop_smc1+1
	lda	hposn_high,X
	sta	xloop_smc1+2

	ldx	SCROLL_OUT
	lda	hposn_low,X
	sta	xloop_smc2+1
	lda	hposn_high,X
	sta	xloop_smc2+2

	ldy	#39
scroll_xloop:
xloop_smc1:
	lda	$2000,Y
xloop_smc2:
	sta	$2000,Y
	dey
	bpl	scroll_xloop

	inc	SCROLL_IN
	inc	SCROLL_OUT

	lda	SCROLL_IN
	cmp	#192
	bne	scroll_yloop

	; blank bottom line


	lda	#$00
	ldy	#39
scroll_hline_xloop:
	sta	$23D0,Y
	sta	$27D0,Y
	sta	$2BD0,Y
	sta	$2FD0,Y
	sta	$33D0,Y
	sta	$37D0,Y
	sta	$3BD0,Y
	sta	$3FD0,Y
	dey
	bpl	scroll_hline_xloop

	rts

