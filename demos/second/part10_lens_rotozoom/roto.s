
do_rotozoom:

	;=================================
	; main loop

	lda	#0
	sta	ANGLE
	sta	SCALE_F
	sta	FRAMEL

	lda	#1
	sta	SCALE_I

main_loop:

	jsr	rotozoom

	jsr	page_flip

	;============================
	; wait for end
	;============================

	lda	#47
	jsr	wait_for_pattern

	bcc	no_keypress

        rts





no_keypress:

	clc
	lda	FRAMEL
	adc	direction
	sta	FRAMEL

	cmp	#$f8
	beq	back_at_zero
	cmp	#33
	beq	at_far_end
	bne	done_reverse

back_at_zero:

at_far_end:

	; change bg color
	lda	roto_color_even_smc+1
	clc
	adc	#$01
	and	#$0f
	sta	roto_color_even_smc+1

	lda	roto_color_odd_smc+1
	clc
	adc	#$10
	and	#$f0
	sta	roto_color_odd_smc+1



	; reverse direction
	lda	direction
	eor	#$ff
	clc
	adc	#1
	sta	direction

	lda	scaleaddl
	eor	#$ff
	clc
	adc	#1
	sta	scaleaddl

	lda	scaleaddh
	eor	#$ff
	adc	#0
	sta	scaleaddh

done_reverse:
	clc
	lda	ANGLE
	adc	direction
	and	#$1f
	sta	ANGLE

	clc
	lda	SCALE_F
	adc	scaleaddl
	sta	SCALE_F
	lda	SCALE_I
	adc	scaleaddh
	sta	SCALE_I

	jmp	main_loop


direction:	.byte	$01
scaleaddl:	.byte	$10
scaleaddh:	.byte	$00


