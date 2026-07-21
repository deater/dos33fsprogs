	;=============================
	; kerrek got ya!
	;=============================



kerrek_smash_progress:
;.byte	0,1,2,3,4,5,6,6,6,6,7	; (smash)
;.byte	8,9,9			; (in ground, no sparks)
;.byte	4,3,2
;.byte	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,$ff

; skip first one is ignored
.byte	0,0,1,2,3,4,5,6,6,6,6,7	; (smash)
.byte	7,7,7			; (in ground, no sparks)
.byte	4,3,2
.byte	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,$ff

kerrek_arm_offset_x_left:
.byte 1,0,0,$ff,	$ff,0,0,$FE

kerrek_arm_offset_y_left:
.byte 11,11,11,11,	6,$ff,$ff,11

kerrek_arm_offset_x_right:
.byte 0,0,1,1,	1,1,1,1

; dupe of the other?
kerrek_arm_offset_y_right:
.byte 11,11,11,11,	6,$ff,$ff,11



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

	ldy	KERREK_SMASH_COUNT
	lda	kerrek_smash_progress,Y
	tay

	lda	KERREK_STATE
	and	#KERREK_DIRECTION	; 0=LEFT
	bne	draw_kerrek_arm_right

draw_kerrek_arm_left:

	clc
	lda	KERREK_X
	adc	kerrek_arm_offset_x_left,Y
	sta	SPRITE_X

	clc
	lda	KERREK_Y
	adc	kerrek_arm_offset_y_left,Y
	sta	SPRITE_Y

	clc
	tya
	adc	#KERREK_SMASH_ARM_OFFSET_LEFT

	jmp	draw_kerrek_arm_done


draw_kerrek_arm_right:

	clc
	lda	KERREK_X
	adc	kerrek_arm_offset_x_right,Y
	sta	SPRITE_X

	clc
	lda	KERREK_Y
	adc	kerrek_arm_offset_y_right,Y
	sta	SPRITE_Y

	clc
	tya
	adc	#KERREK_SMASH_ARM_OFFSET_RIGHT

draw_kerrek_arm_done:

	tax

	jsr	hgr_draw_sprite_mask


	;==============================
	; if frame X,Y,Z draw sparks


	;==========================
	; move to next frame

	inc	KERREK_SMASH_COUNT
	ldx	KERREK_SMASH_COUNT

	lda	kerrek_smash_progress,X
	bmi	smash_done

	rts


smash_done:

	; temp debug hack

	lda	#1
	sta	KERREK_SMASH_COUNT	; reset

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

