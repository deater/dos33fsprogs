;======================================
; draw physicist
;======================================

draw_physicist:

	; FIXME: what happens if crouch+kick
	;	or crouch+walk?

check_if_still_kicking:
	lda	KICKING
	beq	check_crouching
kicking:
	lda	#<kick1
	sta	INL

	lda	#>kick1
	sta	INH

	dec	KICKING

	jmp	finally_draw_him

check_crouching:
	lda	CROUCHING
	beq	walking

crouching:

	; FIXME: we have an animation?

	lda	#<crouch2
	sta	INL

	lda	#>crouch2
	sta	INH

	jmp	finally_draw_him

walking:
	lda	GAIT
	cmp	#40
	bcc	gait_fine	; blt

	lda	#0
	sta	GAIT

gait_fine:
	lsr
	and	#$fe

	tax

	lda	phys_walk_progression,X
	sta	INL

	lda	phys_walk_progression+1,X
	sta	INH

finally_draw_him:
	lda	PHYSICIST_X
	sta	XPOS

	lda	PHYSICIST_Y
	sec
	sbc	EARTH_OFFSET	; adjust for earthquakes
	sta	YPOS

	lda	DIRECTION
	bne	facing_right

facing_left:
        jmp	put_sprite

facing_right:
	jmp	put_sprite_flipped

