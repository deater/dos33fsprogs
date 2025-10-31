;license:MIT
;(c) 2023 by 4am
;
; drawing routines for Million Perfect Tiles Condensed
;
; Public functions:
; - draw_condensed_1x8
;

; VMW: commented, reformatted, minor changes, ca65 assembly

FONT_OFFSET = $13


;------------------------------------------------------------------------------
; draw_condensed_1x8
;
; in:    A/Y points to zero terminated string, with x-pos and y-pos at start
;	X is which line
;	if line>7 then just print 0
; out:   clobbers all registers & flags
;------------------------------------------------------------------------------

draw_condensed_1x8:

	; store the string location

	sta	OUTL
	sty	OUTH

draw_condensed_1x8_again:

	ldy	#0		; get X position before string
	lda	(OUTL),Y
	sta	CH
	bpl	still_good

demo_demo_done:

	cmp	#$ff			; only really done if $FF
	beq	really_done

	jsr	peasant_interlude

	lda	#20
	sta	CH
	sta	peasant_smc

	jmp	still_good

really_done:
	inc	SCROLL_DONE
	rts


still_good:
	clc				; increment font pointer
	lda	#1
	adc	OUTL
	sta	OUTL
	sta	dcb_loop_1x8_smc+1
	sta	dcb_loop_1x8b_smc+1

	lda	#0			; 16 bits
	adc	OUTH
	sta	OUTH
	sta	dcb_loop_1x8_smc+2
	sta	dcb_loop_1x8b_smc+2

	ldy	CV			; get ypos


	cpx	#8
	bcs	draw_blank_line		; if row>7 draw blank line

draw_font_line:
	; point to proper row of font (row in X)

	lda	font_rows_l,X
	sta	dcb_row_1x8_0+1
	lda	font_rows_h,X
	sta	dcb_row_1x8_0+2

	;===================================
	; setup output pointer to hgr area

	lda	hposn_low, Y			; get low memory offset
	clc
	adc	CH				; add in x-coord
	sta	dcb_row_1x8_0+4
	lda	hposn_high, Y			; get high memory offset
	adc	DRAW_PAGE
	sta	dcb_row_1x8_0+5			; save it out
;	iny					; go to next row

	;=========================
	; loop across string

	ldx	#0
dcb_loop_1x8:
dcb_loop_1x8_smc:
	ldy	$FDFD, X		; load next char into Y
	beq	dcb_done_1x8


dcb_row_1x8_0:
	lda	font_1x8_row0-FONT_OFFSET, Y	; get 1-byte font row
	sta	$FDFD, X		; write out to graphics mem

	inc	CH
	inx				; move to next

	bne	dcb_loop_1x8		; bra (well, as long as string
					;	is less than 255 chars)

dcb_done_1x8:

	rts



draw_blank_line:

	;===================================
	; setup output pointer to hgr area

	lda	hposn_low, Y			; get low memory offset
	clc
	adc	CH				; add in x-coord
	sta	dcb_row_1x8_b+3
	lda	hposn_high, Y			; get high memory offset
	adc	DRAW_PAGE
	sta	dcb_row_1x8_b+4			; save it out
;	iny					; go to next row

	;=========================
	; loop across string

	ldx	#0
dcb_loop_1x8b:
dcb_loop_1x8b_smc:
	ldy	$FDFD, X		; load next char into Y
	beq	dcb_done_1x8b

dcb_row_1x8_b:
	lda	#0
	sta	$FDFD, X		; write out to graphics mem

	inc	CH
	inx				; move to next

	bne	dcb_loop_1x8b		; bra (well, as long as string
					;	is less than 255 chars)

dcb_done_1x8b:

	rts



font_rows_l:
	.byte <(font_1x8_row0-FONT_OFFSET)
	.byte <(font_1x8_row1-FONT_OFFSET)
	.byte <(font_1x8_row2-FONT_OFFSET)
	.byte <(font_1x8_row3-FONT_OFFSET)
	.byte <(font_1x8_row4-FONT_OFFSET)
	.byte <(font_1x8_row5-FONT_OFFSET)
	.byte <(font_1x8_row6-FONT_OFFSET)
	.byte <(font_1x8_row7-FONT_OFFSET)

font_rows_h:
	.byte >(font_1x8_row0-FONT_OFFSET)
	.byte >(font_1x8_row1-FONT_OFFSET)
	.byte >(font_1x8_row2-FONT_OFFSET)
	.byte >(font_1x8_row3-FONT_OFFSET)
	.byte >(font_1x8_row4-FONT_OFFSET)
	.byte >(font_1x8_row5-FONT_OFFSET)
	.byte >(font_1x8_row6-FONT_OFFSET)
	.byte >(font_1x8_row7-FONT_OFFSET)



