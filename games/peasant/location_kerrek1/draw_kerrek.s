
	;=======================
	;=======================
	; kerrek draw
	;=======================
	;=======================
kerrek_draw:

	; first, only if kerrek out

	lda	KERREK_STATE
	bpl	kerrek_no_draw

	; check if kerrek smashing

	lda	KERREK_SMASH_COUNT
	beq	kerrek_no_smash

	jmp	draw_kerrek_smash

kerrek_no_smash:
	; next, see if kerrek alive
	lda	GAME_STATE_3
	and	#KERREK_DEAD
	bne	kerrek_no_draw
	beq	kerrek_actually_draw

kerrek_no_draw:
	rts

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



