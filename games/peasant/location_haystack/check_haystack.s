	;======================================================
	; if start level and not in JHONKA_CAVE or HAY_BALE
	; then exit the hay bale, print message, do animation

	; we only include this in the 4 locations it can happen
	;	POOR_GARY
	;	NED_HUT
	;	PUDDLE
	;	OUR_COTTAGE

check_haystack_exit:

	; first see if in hay bale

	lda	GAME_STATE_1
	and	#IN_HAY_BALE
	beq	done_not_in_hay_bale

must_exit_hay:

	jsr	blow_hay_away

done_not_in_hay_bale:
	rts




blow_hay_away:

	; exit hay bale

	lda	GAME_STATE_1
	and	#<(~IN_HAY_BALE)
	sta	GAME_STATE_1

	; no longer muddy
	lda	GAME_STATE_2
	and	#<(~COVERED_IN_MUD)
	sta	GAME_STATE_2

	; TODO: show animation

	; change back to normal clothes

	lda	#PEASANT_OUTFIT_SHORTS
	jsr	load_peasant_sprites

	; print message
	ldx	#<hay_blown_away_message
	ldy	#>hay_blown_away_message
	jsr	partial_message_step

	rts
