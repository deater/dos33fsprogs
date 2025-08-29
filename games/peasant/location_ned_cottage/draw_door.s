	;===================
	; draw door
	;===================
	;	default is door closed
	;	door is open if INVENTORY_1_GONE has INV1_BABY


draw_door:

	;============================
	; update bg
	;	solid green, a waste to use a sprite here

	lda	DRAW_PAGE
	sta	DRAW_PAGE_SAVE
	lda	#$40
	sta	DRAW_PAGE		; draw to $6000


	;============================
	; see if door open

	lda	INVENTORY_1_GONE
	and	#INV1_BABY
	beq	done_draw_door

draw_door_open:

	lda	#<door_open_top_sprite
	sta	INL
	lda	#>door_open_top_sprite
	sta	INH

	lda	#12			; 84/7=12
	sta	CURSOR_X
	lda	#98
	sta	CURSOR_Y

	jsr	hgr_draw_sprite

	lda	#<door_open_bottom_sprite
	sta	INL
	lda	#>door_open_bottom_sprite
	sta	INH

	lda	#12			; 84/7=12
	sta	CURSOR_X
	lda	#115
	sta	CURSOR_Y

	jsr	hgr_draw_sprite

done_draw_door:

	lda	DRAW_PAGE_SAVE
	sta	DRAW_PAGE

	rts



	;============================
	; common as we do this a lot
walk_to_drawer:

	ldx	#24		; 168/7 = 24
	ldy	#130
	jsr	peasant_walkto

	lda	#PEASANT_DIR_RIGHT
	sta	PEASANT_DIR

	rts
