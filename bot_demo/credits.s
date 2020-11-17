display_credits:
	; display music bars

	lda	A_VOLUME
	asl
	asl
	sta	draw_a_bar_loop+1

	ldx	#4
	lda	#' '
draw_a_bar_loop:
	cpx	#$4
	beq	skip_a_bar
	eor	#$80
	sta	$A50,X
skip_a_bar:
	dex
	bpl	draw_a_bar_loop

	lda	B_VOLUME
	asl
	asl
	tax
draw_b_bar_loop:
	lda	#' '
	sta	$Ad0,X
	dex
	bpl	draw_b_bar_loop

	lda	C_VOLUME
	asl
	asl
	tax
draw_c_bar_loop:
	lda	#' '
	sta	$B50,X
	dex
	bpl	draw_c_bar_loop

	; write credits

	lda	ticks
	cmp	#25
	bne	done_credits

	lda	seconds

	cmp	#0
	beq	next_credit
	cmp	#4
	beq	next_credit
	cmp	#8
	beq	next_credit
	cmp	#12
	beq	next_credit
	cmp	#16
	beq	next_credit
	bne	done_credits

next_credit:
write_credits:
	lda	which_credit
	asl
	tay

write_credit_1_loop:
	lda	$dede,Y
	beq	done_credit1_loop
	sta	$Ad0+20,Y
	iny
	jmp	write_credit_1_loop

done_credit1_loop:

	inc	which_credit
done_credits:
	rts

credits_table:
	.word credits1
	.word credits2
	.word credits3
	.word credits4
	.word credits5


credits1:
	.byte "Code:",0
	.byte " ",0
	.byte "Deater",0

credits2:
	.byte "Music:",0
	.byte " ",0
	.byte "mAZE",0

credits3:
	.byte "Algorithms:",0
	.byte " ",0
	.byte "Hellmood",0

credits4:
	.byte "Apple II bot",0
	.byte " ",0
	.byte "Kay Savetz",0

credits5:
	.byte "    _    ",0
	.byte " _|(_   _",0
	.byte "(_| _) | ",0

which_credit:
	.byte	$0
