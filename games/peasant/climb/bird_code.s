	;=====================
	; draw bird
	;=====================
draw_bird:

	; erase the bird if needed

;	ldy	#0			; always in erase slot 0
;	jsr	hgr_partial_restore_by_num

	; only draw bird if it's out

	lda	bird_out
	beq	done_draw_bird


	; load in X/Y co-ords

	lda	bird_x
	sta	SPRITE_X
	lda	bird_y
	sta	SPRITE_Y

	; get wing flapping (which sprite) based on frame count

	lda	FRAME
	and	#1
	tax

	ldy	#0			; bird always erase slot #0

;	jsr	hgr_draw_sprite_save
	jsr	hgr_draw_sprite_mask

done_draw_bird:

	rts


	;=====================
	;=====================
	; move bird
	;=====================
	;=====================
move_bird:

	lda	bird_out
	bne	skip_new_bird
maybe_new_bird:

	jsr	random8
bird_freq_smc:
	and	#$1f		; 1/32 of time start new bird?
	bne	move_bird_done

	; bird on base level,	12 .. 76	(MAP_LOCATION==0)
	; bird on other levels, 12 .. 140

	jsr	random8

	ldx	MAP_LOCATION
	bne	new_bird_wider

	and	#$3f		; 0... 64
new_bird_wider:
	and	#$7f		; 0... 128

	clc
	adc	#12		; skip top bar
	sta	bird_y

	lda	#37
	sta	bird_x
	inc	bird_out
	jmp	move_bird_done

skip_new_bird:

	;=========================
	; collision detect here

	jsr	bird_collide
	bcc	no_bird_collision

	; collision happened!

	lda	#1
	sta	PEASANT_FALLING

no_bird_collision:

	dec	bird_x
	bpl	move_bird_done

	; off screen here

	lda	#0
	sta	bird_out

move_bird_done:

	rts



	;===========================
	; check for bird collisions

bird_collide:

	; bird is 3x16
	; peasant is 3x30

	; doing a sort of Minkowski Sum collision detection here
	; with the rectangular regions

	; might be faster to set it up so you can subtract, but that leads
	;	to issues when we go negative and bcc/bcs are unsigned compares

	; if (bird_x+1<PEASANT_X-1) no_collide
	;	equivalent, if (bird_x+2<PEASANT_X)
	;	equivalent, if (PEASANT_X-1 >= bird_x+1)

	lda	bird_x
	sta	TEMP_CENTER
	inc	TEMP_CENTER	; bird_x+1

	sec
	lda	PEASANT_X
	sbc	#1			; A is PEASANT_X-1
	cmp	TEMP_CENTER		; compare with bird_x+1
	bcs	bird_no_collide		; bge

	; if (bird_x+1>=PEASANT_X+3) no collide
	;	equivalent, if (bird_x-2>=PEASANT_X)
	;	equivalent, if (PEASANT_X+3<bird_x+1)

	; carry clear here
	adc	#4			; A is now PEASANT_X+3
	cmp	TEMP_CENTER
	bcc	bird_no_collide		; blt

	; if (bird_y+8<PEASANT_Y-8) no_collide
	;	equivalent, if (bird_y+16<PEASANT_Y)
	;	equivalent, if (PEASANT_Y-8>=bird_y+8)

	lda	bird_y
	clc
	adc	#8
	sta	TEMP_CENTER

	lda	PEASANT_Y
	sec
	sbc	#8			; A is now PEASANT_Y-8
	cmp	TEMP_CENTER
	bcs	bird_no_collide		; blt

	; if (bird_Y+8>=PEASANT_Y+38) no collide
	;	equivalent, if (bird_y-30>=PEASANT_Y)
	;	equivalent, if (PEASANT_Y+38<bird_y+8)

	; carry clead here
	adc	#38			; A is now bird_y+30
	cmp	TEMP_CENTER
	bcc	bird_no_collide		; blt

bird_yes_collide:
	sec
	rts

bird_no_collide:
	clc
	rts


