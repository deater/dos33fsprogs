	;====================================
	; scrolls large font
	; right to left, at 168

	; scroll by half

	; even frames, like normal
	; odd frames, start with odd

	; X6543210 XDCBA987

	; 0123456 789ABCD	X		Y	Z
	; 	lda X, sta Y  lda X+1, sta Y+1
	; 2345678 9ABCDef	X<<2 | Y<<2
	;	lda X, sta Y  lda X+1 and #$fc lda Y+1, and #$3 ora, sta Y+1
	; 456789A BCDefgh	X<<4 | Y<<4
	;	lda X, sta Y  lda X+1 and #$fc lda Y+1, and #$3 ora, sta Y+1
	; 6789ABC Defghij	X<<6 | Y<<6
	; 89ABCDe fghijkl	Y<<1 | Z<<1
	; ABCDefg hijklmn	Y<<3 | Z<<3
	; CDefghi jklmnop	Y<<5 | Z<<6
	; efghijk lmnopqr	Z



do_scroll:
	lda	#0
	sta	SCROLL_START
	sta	SCROLL_ODD


do_scroll_again:
	ldy	#0		; Y is column on screen currently drawing

	lda	SCROLL_START	; reset string offset to current start
	sta	SCROLL_OFFSET

	lda	SCROLL_ODD	; check if odd/even inside of char
	beq	do_scroll_loop	; if even, normal scroll

	ldx	SCROLL_OFFSET	; load offset into string
	lda	scroll_text,X	; get the character
	sec
	sbc	#'@'		; convert from ASCII
	asl
	tax
	inx			; point to second half of char

	jmp	do_scroll_col_loop


do_scroll_loop:
	ldx	SCROLL_OFFSET	; load offset into string
	lda	scroll_text,X	; get the character
	sec
	sbc	#'@'		; convert from ASCII
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

skip_first_col:
	inx
	iny

	txa				; see if done char
	and	#1
	bne	do_scroll_col_loop	; if not, draw second half

	inc	SCROLL_OFFSET		; point to next char

	cpy	#40			; see if Y edge of screen
	bcc	do_scroll_loop

	;=====================
	; check keyboard

	lda	KEYPRESS
	bmi	do_scroll_done

	lda	#150
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
