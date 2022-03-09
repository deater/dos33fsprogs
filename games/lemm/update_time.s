
	; updates the time left
update_time:
	sed

	sec
	lda	TIME_SECONDS
	sbc	#1
	cmp	#$99
	bne	no_time_uflo
	lda	#$59
	dec	TIME_MINUTES

no_time_uflo:
	sta	TIME_SECONDS

	cld

	lda	TIME_MINUTES
	bne	not_over
	lda	TIME_SECONDS
	bne	not_over

	inc	LEVEL_OVER


not_over:


draw_time:

	; draw minute
	ldy	TIME_MINUTES

	lda	bignums_l,Y
	sta	INL
	lda	bignums_h,Y
	sta	INH

	; 246, 152

	ldx	#35		; 245
        stx     XPOS
	lda	#152
	sta	YPOS

	jsr	hgr_draw_sprite_autoshift

	; draw seconds
	lda	TIME_SECONDS
	lsr
	lsr
	lsr
	lsr
	tay

	lda	bignums_l,Y
	sta	INL
	lda	bignums_h,Y
	sta	INH

	ldx	#37
        stx     XPOS
	lda	#152
	sta	YPOS

	jsr	hgr_draw_sprite_autoshift


	; draw seconds
	lda	TIME_SECONDS
	and	#$f
	tay

	lda	bignums_l,Y
	sta	INL
	lda	bignums_h,Y
	sta	INH

	ldx	#38
        stx     XPOS
	lda	#152
	sta	YPOS

	jsr	hgr_draw_sprite_autoshift

	rts


bignums_l:
.byte	<big0_sprite,<big1_sprite,<big2_sprite,<big3_sprite,<big4_sprite
.byte	<big5_sprite,<big6_sprite,<big7_sprite,<big8_sprite,<big9_sprite

bignums_h:
.byte	>big0_sprite,>big1_sprite,>big2_sprite,>big3_sprite,>big4_sprite
.byte	>big5_sprite,>big6_sprite,>big7_sprite,>big8_sprite,>big9_sprite
