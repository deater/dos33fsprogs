switch_to_credits:

	; clear bottom of page2 and set split
	bit	TEXTGR

	ldx	#39
	lda	#' '|$80
clear_bottom_loop:
	sta	$A50,X
	sta	$AD0,X
	sta	$B50,X
	sta	$BD0,X
	dex
	bpl	clear_bottom_loop

	; set "done"

	lda	#DONE
	sta	command

	; clear time

	lda	#0
	sta	seconds
	sta	ticks

	rts


	;======================================
	;======================================
	; display credits
	;======================================
	;======================================

display_credits:

	; display music bars

	; a bar

	lda	A_VOLUME
	lsr
	lsr
	sta	draw_a_bar_left_loop+1
	lda	#3
	sec
	sbc	draw_a_bar_left_loop+1
	sta	draw_a_bar_right_loop+1

	ldx	#4
	lda	#' '|$80
draw_a_bar_left_loop:
	cpx	#$4
	bne	skip_al_bar
	eor	#$80
skip_al_bar:
	sta	$A50,X
	dex
	bpl	draw_a_bar_left_loop

	ldx	#4
	lda	#' '
draw_a_bar_right_loop:
	cpx	#$4
	bne	skip_ar_bar
	eor	#$80
skip_ar_bar:
	sta	$A50+35,X
	dex
	bpl	draw_a_bar_right_loop



	; b bar

	lda	B_VOLUME
	lsr
	lsr
	sta	draw_b_bar_left_loop+1
	lda	#3
	sec
	sbc	draw_b_bar_left_loop+1
	sta	draw_b_bar_right_loop+1

	ldx	#4
	lda	#' '|$80
draw_b_bar_left_loop:
	cpx	#$4
	bne	skip_bl_bar
	eor	#$80
skip_bl_bar:
	sta	$AD0,X
	dex
	bpl	draw_b_bar_left_loop

	ldx	#4
	lda	#' '
draw_b_bar_right_loop:
	cpx	#$4
	bne	skip_br_bar
	eor	#$80
skip_br_bar:
	sta	$AD0+35,X
	dex
	bpl	draw_b_bar_right_loop

	; c

	lda	C_VOLUME
	lsr
	lsr
	sta	draw_c_bar_left_loop+1
	lda	#3
	sec
	sbc	draw_c_bar_left_loop+1
	sta	draw_c_bar_right_loop+1
	ldx	#4
	lda	#' '|$80
draw_c_bar_left_loop:
	cpx	#$4
	bne	skip_cl_bar
	eor	#$80
skip_cl_bar:
	sta	$B50,X
	dex
	bpl	draw_c_bar_left_loop

	ldx	#4
	lda	#' '
draw_c_bar_right_loop:
	cpx	#$4
	bne	skip_cr_bar
	eor	#$80
skip_cr_bar:
	sta	$B50+35,X
	dex
	bpl	draw_c_bar_right_loop



	; write credits
actual_credits:
	lda	ticks
	cmp	#25
	bne	done_credits

	lda	seconds

	; increment on multiples of 4 seconds

	and	#$3
	beq	next_credit
	bne	done_credits

next_credit:

	;========================
	; write the credits

write_credits:
	lda	which_credit
	cmp	#7
	beq	done_credits

	ldx	#4
outer_credit_loop:

	; X is proper line
	; point to start of proper output line

	lda	credits_address,X
	sta	credits_address_smc+1
	lda	credits_address+1,X
	sta	credits_address_smc+2

	; load proper input location

	lda	which_credit
	asl
	tay

	txa
	asl
	asl
	asl	; *16 (already *2)
	clc
	adc	credits_table,Y
	sta	write_credit_1_loop+1
	lda	credits_table+1,Y
	adc	#0
	sta	write_credit_1_loop+2

	ldy	#0
write_credit_1_loop:
	lda	$dede,Y
	ora	#$80
credits_address_smc:
	sta	$dede,Y
	iny
	cpy	#16
	bne	write_credit_1_loop

done_credit1_loop:
	dex
	dex
	bpl	outer_credit_loop


	inc	which_credit

done_credits:
	rts

credits_address:
	.word	$a50+12
	.word	$ad0+12
	.word	$b50+12

credits_table:
	.word credits1
	.word credits2
	.word credits3
	.word credits4
	.word credits5
	.word credits6
	.word credits7


credits1:
	.byte "     Code:      "
	.byte "                "
	.byte "     Deater     "

credits2:
	.byte "     Music:     "
	.byte "                "
	.byte "      mAZE      "

credits3:
	.byte "   Algorithms:  "
	.byte "   F. Sanglard  "
	.byte "    Hellmood    "

credits4:
	.byte "  Apple II bot  "
	.byte "                "
	.byte "   Kay Savetz   "

credits5:
	.byte "    Magic:      "
	.byte "                "
	.byte "    qkumba      "

credits6:
	.byte "    Greets:     "
	.byte "      4am       "
	.byte "  French Touch  "

credits7:
	.byte "       _        "
	.byte "    _|(_   _    "
	.byte "   (_| _) |     "

which_credit:
	.byte	$0
