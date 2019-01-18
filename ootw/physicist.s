;======================================
; draw physicist
;======================================

draw_physicist:

	lda	GAIT
	and	#$f
	sta	GAIT
	tax

	lda	phys_walk_progression,X
	sta	INL

	lda	phys_walk_progression+1,X
	sta	INH

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

