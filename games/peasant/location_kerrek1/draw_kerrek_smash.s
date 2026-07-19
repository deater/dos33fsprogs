	;=============================
	; kerrek got ya!
	;=============================



kerrek_smash_progress:
;.byte	0,1,2,3,4,5,6,6,6,6,7	; (smash)
;.byte	8,9,9			; (in ground, no sparks)
;.byte	4,3,2
;.byte	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,$ff

.byte	0,1,2,3,4,5,6,6,6,6,7	; (smash)
.byte	7,7,7			; (in ground, no sparks)
.byte	4,3,2
.byte	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,$ff



draw_kerrek_smash:

	;==============================
	; first, draw baseline kerrek


	lda	KERREK_X
	sta	SPRITE_X
	lda	KERREK_Y
	sta	SPRITE_Y

	ldx	#KERREK_SMASH_BASE_OFFSET_LEFT

	lda	KERREK_STATE
	and	#KERREK_DIRECTION	; 0=LEFT
	beq	kerrek_base_correct_dir

	; switch direction

	ldx	#KERREK_SMASH_BASE_OFFSET_RIGHT

kerrek_base_correct_dir:

	jsr	hgr_draw_sprite_mask


	;==============================
	; next draw appropriate arms



	lda	KERREK_X
	sta	SPRITE_X
	clc
	lda	KERREK_Y
	adc	#10
	sta	SPRITE_Y

	ldx	#KERREK_SMASH_ARM_OFFSET_LEFT

	lda	KERREK_STATE
	and	#KERREK_DIRECTION	; 0=LEFT
	beq	kerrek_arm_correct_dir

	; switch direction

	ldx	#KERREK_SMASH_ARM_OFFSET_RIGHT

kerrek_arm_correct_dir:

	jsr	hgr_draw_sprite_mask

	;==============================
	; if frame X,Y,Z draw sparks






.if 0
	; bonk sound effect
	lda	#96
	sta	speaker_duration
	lda	#NOTE_C4
	sta	speaker_frequency
	jsr	speaker_tone


	; print message

	ldx	#<kerrek_pound_message
	ldy	#>kerrek_pound_message
	jsr	partial_message_step

	lda	#LOAD_GAME_OVER
	sta	WHICH_LOAD

	lda	#NEW_FROM_DISK
	sta	LEVEL_OVER
.endif

	rts

