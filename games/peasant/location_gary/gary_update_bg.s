	;=========================
	; update bg based on gary

	; FIXME: draw broken fence if necessary
	; update fence in collision layer if necessary

	; see if gary out
	lda	GAME_STATE_0
	and	#GARY_SCARED
	bne	no_draw_gary

	; draw gary in background before copying

	lda	#9
	sta	CURSOR_X
	lda	#120
	sta	CURSOR_Y

	lda	#<gary_base_sprite
	sta	INL
	lda	#>gary_base_sprite
	sta	INH

	; switch to page1
;	lda	#$60
;	sta	hgr_sprite_page_smc+1

	jsr	hgr_draw_sprite

	; switch back to page2
;	lda	#$00
;	sta	hgr_sprite_page_smc+1

no_draw_gary:

no_update_gary:

