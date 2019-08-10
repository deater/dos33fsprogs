; Handle laser



draw_laser:

	lda	#$10
	sta	hlin_color_smc+1

	lda	#$0f
	sta	hlin_mask_smc+1

	lda	PHYSICIST_Y
	clc
	adc	#4
	tay

	lda	DIRECTION
	beq	laser_left
	bne	laser_right

laser_left:

	ldx	PHYSICIST_X
	dex
	lda	#0

	jmp	laser_hlin

laser_right:

	lda	PHYSICIST_Y
	clc
	adc	#4
	tay

	lda	PHYSICIST_X
	clc
	adc	#5
	sta	TEMP

	sec
	lda	#39
	sbc	TEMP
	tax

	lda	TEMP

laser_hlin:

	jsr	hlin

	rts
