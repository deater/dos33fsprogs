	;====================================
	; scrolls large font
	; right to left, at 168

do_scroll:
	lda	#0
	sta	SCROLL_START
do_scroll_again:
	ldy	#0
	lda	SCROLL_START
	sta	SCROLL_OFFSET	; FIXME: SCROLL_OFFSET
do_scroll_loop:
	ldx	SCROLL_OFFSET
	lda	scroll_text,X
	sec
	sbc	#'@'
	asl
	tax
do_scroll_col_loop:
	; row1
	lda	large_font_row0,X
	sta	$22D0,Y
	; row2
	lda	large_font_row1,X
	sta	$26D0,Y
	; row3
	lda	large_font_row2,X
	sta	$2AD0,Y
	; row4
	lda	large_font_row3,X
	sta	$2ED0,Y
	; row5
	lda	large_font_row4,X
	sta	$32D0,Y
	; row6
	lda	large_font_row5,X
	sta	$36D0,Y
	; row7
	lda	large_font_row6,X
	sta	$3AD0,Y
	; row8
	lda	large_font_row7,X
	sta	$3ED0,Y
	; row9
	lda	large_font_row8,X
	sta	$2350,Y
	; row10
	lda	large_font_row9,X
	sta	$2750,Y
	; row11
	lda	large_font_row10,X
	sta	$2B50,Y
	; row12
	lda	large_font_row11,X
	sta	$2F50,Y
	; row13
	lda	large_font_row12,X
	sta	$3350,Y
	; row14
	lda	large_font_row13,X
	sta	$3750,Y
	; row15
	lda	large_font_row14,X
	sta	$3B50,Y
	; row16
	lda	large_font_row15,X
	sta	$3F50,Y

	inx
	iny
	tya
	and	#1
	bne	do_scroll_col_loop

	inc	SCROLL_OFFSET
	cpy	#40
	bne	do_scroll_loop

	; FIXME: also check keyboard

	lda	#200
	jsr	wait

	inc	SCROLL_START
	lda	SCROLL_START
	cmp	#80
	beq	do_scroll_done

	jmp	do_scroll_again

do_scroll_done:

	rts

scroll_text:  ;0123456789012345678901234567890123456789
	.byte "@@@@@@@@@@@@@@@@@@@@\]^_THE@QUICK@BROWN@"
	.byte "FOX@JUMPED@OVER@THE@LAZY@DOG@PACK@MY@BOX"
	.byte "@WITH@FIVE@DOZEN@LIQOUR@JUGS"
