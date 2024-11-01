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
;	X is which line
; out:   clobbers all registers & flags
;------------------------------------------------------------------------------
draw_condensed_1x8:

	; store the string location

	sta	OUTL
	sty	OUTH

draw_condensed_1x8_again:

	ldy	#0
	lda	(OUTL),Y
	sta	CH
	bpl	still_good

demo_demo_done:
	; FIXME: stop music?

	jmp	demo_demo_done


still_good:
	clc
	lda	#1
	adc	OUTL
	sta	OUTL
	sta	dcb_loop_1x8_smc+1

	lda	#0
	adc	OUTH
	sta	OUTH
	sta	dcb_loop_1x8_smc+2


	ldy	CV

	lda	font_rows_l,X
	sta	dcb_row_1x8_0+1
	lda	font_rows_h,X
	sta	dcb_row_1x8_0+2

	; row0

	lda	hposn_low, Y			; get low memory offset
	clc
	adc	CH				; add in x-coord
	sta	dcb_row_1x8_0+4
	lda	hposn_high, Y			; get high memory offset
	sta	dcb_row_1x8_0+5			; save it out
	iny					; go to next row


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



