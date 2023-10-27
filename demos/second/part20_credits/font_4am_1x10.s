;license:MIT
;(c) 2023 by 4am
;
; drawing routines for Million Perfect Tiles Condensed
;
; Public functions:
; - draw_font_1x10
;

; VMW: commented, reformatted, minor changes, ca65 assembly

FONT_OFFSET10 = $19

;------------------------------------------------------------------------------
; draw_font_1x10
;
; in:    A/Y points to zero terminated string, with x-pos and y-pos at start
; out:   clobbers all registers & flags
;------------------------------------------------------------------------------
draw_font_1x10:

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
	sta	dcb_1x10_loop+1
	lda	#0
	adc	OUTH
	sta	dcb_1x10_loop+2

	; row0

	lda	hposn_low, Y			; get low memory offset
	clc
	adc	CH				; add in x-coord
	sta	dcb_1x10_row0+4
	clc
	lda	hposn_high, Y			; get high memory offset
	adc	DRAW_PAGE
	sta	dcb_1x10_row0+5			; save it out
	iny					; go to next row

	; row1

	lda	hposn_low, Y
	adc	CH
	sta	dcb_1x10_row1+4
	clc
	lda	hposn_high, Y
	adc	DRAW_PAGE
	sta	dcb_1x10_row1+5
	iny

	; row2

	lda	hposn_low, Y
	adc	CH
	sta	dcb_1x10_row2+4
	clc
	lda	hposn_high, Y
	adc	DRAW_PAGE
	sta	dcb_1x10_row2+5
	iny

	; row3

	lda	hposn_low, Y
	adc	CH
	sta	dcb_1x10_row3+4
	clc
	lda	hposn_high, Y
	adc	DRAW_PAGE
	sta	dcb_1x10_row3+5
	iny

	; row4

	lda	hposn_low, Y
	adc	CH
	sta	dcb_1x10_row4+4
	clc
	lda	hposn_high, Y
	adc	DRAW_PAGE
	sta	dcb_1x10_row4+5
	iny

	; row5

	lda	hposn_low, Y
	adc	CH
	sta	dcb_1x10_row5+4
	clc
	lda	hposn_high, Y
	adc	DRAW_PAGE
	sta	dcb_1x10_row5+5
	iny

	; row6

	lda	hposn_low, Y
	adc	CH
	sta	dcb_1x10_row6+4
	clc
	lda	hposn_high, Y
	adc	DRAW_PAGE
	sta	dcb_1x10_row6+5
	iny

	; row7

	lda	hposn_low, Y
	adc	CH
	sta	dcb_1x10_row7+4
	clc
	lda	hposn_high, Y
	adc	DRAW_PAGE
	sta	dcb_1x10_row7+5
	iny

	; row8

	lda	hposn_low, Y
	adc	CH
	sta	dcb_1x10_row8+4
	clc
	lda	hposn_high, Y
	adc	DRAW_PAGE
	sta	dcb_1x10_row8+5
	iny

	; row9

	lda	hposn_low, Y
	adc	CH
	sta	dcb_1x10_row9+4
	clc
	lda	hposn_high, Y
	adc	DRAW_PAGE
	sta	dcb_1x10_row9+5

	ldx	#0
dcb_1x10_loop:
dcb_1x10_loop_smc:
	ldy	$FDFD, X		; load next char into Y
	beq	dcb_1x10_done

	cpy	#13
	beq	dcb_1x10_done

not_linefeed_1x10:
	; unrolled loop to write out each line

dcb_1x10_row0:
	lda	font_1x10_row0-FONT_OFFSET10, Y	; get 1-byte font row
	sta	$FDFD, X		; write out to graphics mem
dcb_1x10_row1:
	lda	font_1x10_row1-FONT_OFFSET10, Y
	sta	$FDFD, X
dcb_1x10_row2:
	lda	font_1x10_row2-FONT_OFFSET10, Y
	sta	$FDFD, X
dcb_1x10_row3:
	lda	font_1x10_row3-FONT_OFFSET10, Y
	sta	$FDFD, X
dcb_1x10_row4:
	lda	font_1x10_row4-FONT_OFFSET10, Y
	sta	$FDFD, X
dcb_1x10_row5:
	lda	font_1x10_row5-FONT_OFFSET10, Y
	sta	$FDFD, X
dcb_1x10_row6:
	lda	font_1x10_row6-FONT_OFFSET10, Y
	sta	$FDFD, X
dcb_1x10_row7:
	lda	font_1x10_row7-FONT_OFFSET10, Y
	sta	$FDFD, X
dcb_1x10_row8:
	lda	font_1x10_row8-FONT_OFFSET10, Y
	sta	$FDFD, X
dcb_1x10_row9:
	lda	font_1x10_row9-FONT_OFFSET10, Y
	sta	$FDFD, X

	inx				; move to next
	bpl   dcb_1x10_loop

dcb_1x10_done:

	rts


draw_font_1x10_multiple:

draw_font_1x10_multiple_loop:
	jsr	draw_font_1x10

	; Y is 13 if keep going
	cpy	#0
	beq	done_draw_font_1x10_multiple

	; want OUTL/OUTH+X+1 in A/Y

	inx			; point past the carriage return
	inx			; original code doesn't adjust for x/y
	inx

	clc
	txa
	adc	OUTL
	sta	OUTL
	lda	#0
	adc	OUTH
	tay

	lda	OUTL


	jmp	draw_font_1x10_multiple_loop

done_draw_font_1x10_multiple:
	rts
