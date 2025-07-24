

	;==========================================================
	; be sure on DRAW_PAGE=$20 when leaving as we load to PAGE2

	; HACK!  skip if sleeping (wiped)

	lda	DRAW_PAGE
	bne	on_proper_page

	lda	GAME_STATE_3
	and	#ASLEEP
	bne	skip_last_update

	jsr	update_screen
skip_last_update:

	jsr	hgr_page_flip

on_proper_page:

	;===============================
	; handle end of level
	;===============================
	; 3 cases:
	;  + left level by walking (in this case
	;	XYZ
	;  + left level by walking but still in same disk file
	;    (this is no longer possible with new game engine)
	;  + left level by loading from a savegame.  in that
	;	case skip all the end of level stuff

	lda	LEVEL_OVER
	cmp	#NEW_FROM_LOAD		; skip to end if loading save game
	beq	really_level_over

	;=======================================
	; update our Y location to the new one

	lda	PEASANT_NEWY
	sta	PEASANT_Y

