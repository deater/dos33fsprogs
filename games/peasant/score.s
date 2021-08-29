	;========================
	; print score
	;========================
print_score:
	lda	#<score_text
	sta	OUTL
	lda	#>score_text
	sta	OUTH

	jmp	hgr_put_string

	; tail call does rts for us


	;==========================
	; update score
	;==========================

	; we have to handle 1, 2 or 3 digits
update_score:
	ldx	#9		; offset of first digit in string
	sed			; set decimal mode

update_hundreds:
	lda	SCORE_HUNDREDS
	beq	update_tens
	clc
	adc	#'0'
	sta	score_text,X
	inx

update_tens:
	lda	SCORE_TENS
	beq	update_ones
	clc
	adc	#'0'
	sta	score_text,X
	inx

update_ones:
	lda	SCORE_ONES
	clc
	adc	#'0'
	sta	score_text,X
	inx

	ldy	#0
copy_tail_loop:
	lda	score_tail,Y
	sta	score_text,X
	beq	done_copy_tail_loop
	inx
	iny
	jmp	copy_tail_loop

done_copy_tail_loop:
	cld			; clear decimal mode
	rts





score_text:
	.byte 0,2,"Score: 0 of 150",0,0,0


score_tail:
	.byte " of 150",0
