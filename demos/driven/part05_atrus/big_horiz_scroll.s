	;====================================
	; scrolls large font
	; right to left, at 168

; trying to make it a "smooth" scroll


do_scroll:
	lda	#0
	sta	SCROLL_START		; offset into string
	sta	SCROLL_SUBSCROLL	; 0..13 of current scroll

do_scroll_again:

	lda	#0
	sta	SCROLL_ROW

do_scroll_row:
	clc
	lda	SCROLL_ROW
	adc	#168
	tay
	lda	hposn_low,Y
	sta	out1_smc+1
	sta	out2_smc+1
	lda	hposn_high,Y
	clc
	adc	DRAW_PAGE
	sta	out1_smc+2
	sta	out2_smc+2

	ldy	#0		; Y is column on screen currently drawing
	sty	SCROLL_COL

	lda	SCROLL_START	; reset string offset to current start
	sta	SCROLL_OFFSET	; current char we are scrolling

do_scroll_col:
	ldx	SCROLL_OFFSET	; load offset into string
	lda	scroll_text,X	; get the character
	sec
	sbc	#'@'		; convert from ASCII
	asl

	; A is now pointer to the char to lookup * 2

	tax


do_scroll_loop:
	ldx	SCROLL_OFFSET	; load offset into string
	lda	scroll_text,X	; get the character
	sec
	sbc	#'@'		; convert from ASCII
	asl
	tax

	ldy	SCROLL_SUBSCROLL
	lda	jump_table_h,Y
	pha
	lda	jump_table_l,Y
	pha
	rts

jump_table_l:
	.byte <(handle_offset0-1),<(handle_offset1-1),<(handle_offset2-1)
	.byte <(handle_offset3-1),<(handle_offset4-1),<(handle_offset5-1)
	.byte <(handle_offset6-1)

jump_table_h:
	.byte >(handle_offset0-1),>(handle_offset1-1),>(handle_offset2-1)
	.byte >(handle_offset3-1),>(handle_offset4-1),>(handle_offset5-1)
	.byte >(handle_offset6-1)

handle_offset0:
handle_offset1:
handle_offset2:
handle_offset3:
handle_offset4:
handle_offset5:
handle_offset6:
	lda	#$ff
	sta	FONT1
	lda	#$00
	sta	FONT2
handle_offset_done:

	ldy	SCROLL_COL

	lda	FONT1
out1_smc:
	sta	$22D0,Y
	iny
	lda	FONT2
out2_smc:
	sta	$22D0,Y

	iny
	sty	SCROLL_COL
	cpy	#40
	bne	do_scroll_col


	inc	SCROLL_ROW
	lda	SCROLL_ROW
	cmp	#16
	bne	do_scroll_row

	; done displaying row


blah:
	jmp	blah

	inc	SCROLL_OFFSET		; point to next char

	cpy	#40			; see if Y edge of screen
;	bcc	do_scroll_loop
	bcs	scroll_loop_done
	jmp	do_scroll_loop
scroll_loop_done:

	;=====================
	; check keyboard

	lda	KEYPRESS
	bmi	do_scroll_done


	jsr	wait_vblank
	jsr	hgr_page_flip

	lda	#200
	jsr	wait

	lda	#$1
	eor	SCROLL_ODD
	sta	SCROLL_ODD
	bne	jmp_scroll_again	; skip if odd

	inc	SCROLL_START
	lda	SCROLL_START
	cmp	#193
	beq	do_scroll_done
jmp_scroll_again:
	jmp	do_scroll_again

do_scroll_done:
	bit	KEYRESET
	rts


font_0_row0_s0: .byte $00,$00, $03,$00
font_0_row1_s0: .byte $00,$00, $0f,$00
font_0_row2_s0:	.byte $00,$00, $3f,$00
font_0_row3_s0: .byte $00,$00, $7f,$01
font_0_row4_s0: .byte $00,$00, $7f,$07
font_0_row5_s0: .byte $00,$00, $7f,$1f
font_0_row6_s0: .byte $00,$00, $7f,$7f
font_0_row7_s0: .byte $00,$00, $03,$00
font_0_row8_s0: .byte $00,$00, $03,$00
font_0_row9_s0: .byte $00,$00, $03,$00
font_0_row10_s0: .byte $00,$00, $03,$00
font_0_row11_s0: .byte $00,$00, $03,$00
font_0_row12_s0: .byte $00,$00, $03,$00
font_0_row13_s0: .byte $00,$00, $03,$00
font_0_row14_s0: .byte $00,$00, $03,$00
font_0_row15_s0: .byte $00,$00, $03,$00




scroll_text:  ;0123456789012345678901234567890123456789
;	.byte "@@@@@@@@@@@@@@@@@@@@\]^_THE@QUICK@BROWN@"
;	.byte "FOX@JUMPED@OVER@THE@LAZY@DOG@PACK@MY@BOX"
;	.byte "@WITH@FIVE@DOZEN@LIQOUR@JUGS"


	      ;0123456789012345678901234567890123456789
	.byte "@@@@@@@@@@@@@@@@@@@@\]^_@I@HAVE@FOUND@A@W"
	.byte "AY@TO@GET@YOU@HOME[@YOU@MUST@TRAVEL@TO@R"
	.byte "IVENQ@FREE@THE@PEOPLEQ@SAVE@MY@WIFEQ@AND"
	.byte "@TRAP@MY@DAD[@OH@ALSO@RIVEN@IS@IMPLODING"
	.byte "[@SIGNAL@ME@WHEN@YOU@ARE@DONE[@@@@@@@@@@"
	.byte "@@@@@@@@@@@@@@"
