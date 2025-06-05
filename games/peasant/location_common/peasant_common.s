; some common actions that are needed in all the peasantry levels

; + exiting hastack
; + kerrek body countdown
; + night-time count down
; + rain-storm count down


	;======================================================
	; if start level and not in JHONKA_CAVE or HAY_BALE
	; then exit the hay bale, print message, do animation

check_haystack_exit:

	; fist see if in hay bale

	lda	GAME_STATE_1
	and	#IN_HAY_BALE
	beq	hay_bale_good

	lda	MAP_LOCATION
	cmp	#LOCATION_JHONKA_CAVE
	beq	hay_bale_good
	cmp	#LOCATION_HAY_BALE
	bne	must_exit_hay

hay_bale_good:
	rts


must_exit_hay:

	; exit hay bale

	lda	GAME_STATE_1
	and	#<(~IN_HAY_BALE)
	sta	GAME_STATE_1

	; no longer muddy
	lda	GAME_STATE_2
	and	#<(~COVERED_IN_MUD)
	sta	GAME_STATE_2

	; print message
	ldx	#<hay_blown_away_message
	ldy	#>hay_blown_away_message
	jsr	partial_message_step

	; TODO: show animation

	rts


