	;=============================
	; kerrek got ya!
	;=============================

KERREK_SMASH_SPARK1 = 11
KERREK_SMASH_SPARK2 = 12
KERREK_SMASH_IN_GROUND = 13
KERREK_MAX_SMASH = 33	; one previous so lookups still work at 34

; skip first one is ignored
kerrek_smash_progress:
.byte	0,0,1,2,3,4,5,6,6,6,6	; (hand moving up in air)
.byte	7			; (smash, makes noise, splat1 over tall peasant)
.byte	7			; (in ground, splat2, possibly peasant squished)
.byte	7,7			; (in ground, no sparks)
.byte	4,3,2
.byte	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0

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
	; if frame 11,12 draw sparks

	lda	KERREK_SMASH_COUNT
	cmp	#KERREK_SMASH_SPARK1
	beq	draw_splat1
	cmp	#KERREK_SMASH_SPARK2
	bne	no_draw_splat

draw_splat2:

	ldx	#KERREK_SMASH2_OFFSET

	bne	draw_splat_common_start		; bra

draw_splat1:

	jsr	mud_splat_sound

	ldx	#KERREK_SMASH1_OFFSET

draw_splat_common_start:

	lda	KERREK_STATE
	and	#KERREK_DIRECTION		; 0=LEFT
	beq	draw_splat_left
draw_splat_right:

	clc
	lda	KERREK_X
	adc	#2

	jmp	draw_splat_common

draw_splat_left:

	sec
	lda	KERREK_X
	sbc	#3

draw_splat_common:

	sta	SPRITE_X
	clc
	lda	KERREK_Y
	adc	#24
	sta	SPRITE_Y

	jsr	hgr_draw_sprite_mask


no_draw_splat:

	;===================================================
	; if frame >12 disable peasant+put head in ground
check_in_ground:
	lda	KERREK_SMASH_COUNT
	cmp	#12
	bcc	peasant_still_above_ground

	lda	#SUPPRESS_PEASANT
	ora	SUPPRESS_DRAWING
	sta	SUPPRESS_DRAWING

	; draw peasant_head

	lda	PEASANT_X
	sta	SPRITE_X
	clc
	lda	KERREK_Y
	adc	#34
	sta	SPRITE_Y

	ldx	#KERREK_SMASHED_PEASANT_OFFSET

	jsr	hgr_draw_sprite_mask

peasant_still_above_ground:

	;==========================
	; don't increment if at end


	lda	KERREK_SMASH_COUNT
	cmp	#KERREK_MAX_SMASH
	beq	smash_done_first
	bcs	dks_just_return

	; increment count

	inc	KERREK_SMASH_COUNT

dks_just_return:

	rts


smash_done_first:

	;==========================
	; print message
	;==========================
	; note: did to stop the smash increment in this case
	; as update_screen is called which possibly calls here

	inc	KERREK_SMASH_COUNT	; don't call this twice

	ldx	#<kerrek_pound_message
	ldy	#>kerrek_pound_message
	jsr	partial_message_step

	lda	#LOAD_GAME_OVER
	sta	WHICH_LOAD

	lda	#NEW_FROM_DISK
	sta	LEVEL_OVER

	rts

