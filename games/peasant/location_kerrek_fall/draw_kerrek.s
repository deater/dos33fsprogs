
	;=======================
	;=======================
	; kerrek draw
	;=======================
	;=======================
kerrek_draw:


kerrek_actually_draw:

	lda	KERREK_X
	sta	SPRITE_X
	lda	KERREK_Y
	sta	SPRITE_Y

	ldx	KERREK_COUNT

	lda	KERREK_STATE
	and	#KERREK_DIRECTION	; 0=LEFT
	beq	kerrek_correct_dir

	txa				; could just OR with 8?
	clc
	adc	#$8
	tax

kerrek_correct_dir:
	jsr	hgr_draw_sprite_mask

	rts				; tail call?



