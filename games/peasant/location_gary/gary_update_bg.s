	;=========================
	; update bg based on gary

	; FIXME: draw broken fence if necessary
	; FIXME: update fence in collision layer if necessary

	; see if gary out
	lda	GAME_STATE_0
	and	#GARY_SCARED
	bne	no_draw_gary

	; save current draw page

	lda	DRAW_PAGE
	sta	DRAW_PAGE_SAVE

	lda	#$40			; means draw to $6000
	sta	DRAW_PAGE

	; draw gary in background before copying

	lda	#9
	sta	CURSOR_X
	lda	#120
	sta	CURSOR_Y

	lda	#<gary_base_sprite
	sta	INL
	lda	#>gary_base_sprite
	sta	INH

	jsr	hgr_draw_sprite

	; restore draw page

	lda	DRAW_PAGE_SAVE
	sta	DRAW_PAGE

no_draw_gary:

no_update_gary:

