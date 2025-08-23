	;===================
	; haystack update bg
	;===================
	; update bg/collision if haystack being worn
	;	GAME_STATE_1 and IN_HAY_BALE

haystack_update_bg:

	lda	GAME_STATE_1
	and	#IN_HAY_BALE
	beq	done_haystack_update_bg

	; update depth
	;	not needed as always going to be in bale?

	; update collision

	; $BC 08->00
	; $BD 08->00
	; $BE 08->00
	; $BF 08->00
	; $C0 08->00
	; $C1 08->00

	lda	#$00
	sta	collision_location+$BC
	sta	collision_location+$BD
	sta	collision_location+$BE
	sta	collision_location+$BF
	sta	collision_location+$C0
	sta	collision_location+$C1

	;============================
	; update bg
	;	solid green, a waste to use a sprite here

	lda	DRAW_PAGE
	sta	DRAW_PAGE_SAVE
	lda	#$40
	sta	DRAW_PAGE		; draw to $6000

	; haystack empty top

	lda	#27			; 189/7=27
	sta	CURSOR_X
	lda	#104
	sta	CURSOR_Y
	lda	#<hg_sprite0
	sta	INL
	lda	#>hg_sprite0
	sta	INH

	jsr	hgr_draw_sprite

	; haystack empty bottom

	lda	#27			; 189/7=27
	sta	CURSOR_X
	lda	#128
	sta	CURSOR_Y
	lda	#<hg_sprite0
	sta	INL
	lda	#>hg_sprite0
	sta	INH

	jsr	hgr_draw_sprite





	lda	DRAW_PAGE_SAVE
	sta	DRAW_PAGE

done_haystack_update_bg:

	rts




