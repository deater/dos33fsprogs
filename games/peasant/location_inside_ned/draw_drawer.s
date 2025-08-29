	;===================
	; drawer update bg
	;===================
	;	default is drawer closed
	;	if GAME_STATE_2 DRESSER_OPEN then one of two options
	;		dresser open with robe
	;		dressed open with no robe (if in inventory)

draw_drawer:

	;============================
	; update bg
	;	solid green, a waste to use a sprite here

	lda	DRAW_PAGE
	sta	DRAW_PAGE_SAVE
	lda	#$40
	sta	DRAW_PAGE		; draw to $6000


	;============================
	; setup which sprite

	lda	GAME_STATE_2
	and	#DRESSER_OPEN
	bne	draw_dresser_open

draw_dresser_closed:

	lda	#<drawer_closed_sprite
	sta	INL
	lda	#>drawer_closed_sprite
	jmp	draw_dresser_common

draw_dresser_open:

	lda	INVENTORY_2
	and	#INV2_ROBE
	bne	draw_dresser_open_no_robe

draw_dresser_open_robe:

	lda	#<drawer_open_robe_sprite
	sta	INL
	lda	#>drawer_open_robe_sprite
	jmp	draw_dresser_common

draw_dresser_open_no_robe:

	lda	#<drawer_open_no_robe_sprite
	sta	INL
	lda	#>drawer_open_no_robe_sprite

draw_dresser_common:

	sta	INH

	lda	#22			; 154/7=22
	sta	CURSOR_X
	lda	#126
	sta	CURSOR_Y

	jsr	hgr_draw_sprite

	lda	DRAW_PAGE_SAVE
	sta	DRAW_PAGE

done_draw_drawer:

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
