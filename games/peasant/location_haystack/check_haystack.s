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



	;====================================
	; do the blow hay away animation

	; be sure to set BLOWN_AWAY_OFFSET to offset in custom_sprite table

blow_hay_away:

	; exit hay bale

	lda	GAME_STATE_1
	and	#<(~IN_HAY_BALE)
	sta	GAME_STATE_1

	; no longer muddy
	lda	GAME_STATE_2
	and	#<(~COVERED_IN_MUD)
	sta	GAME_STATE_2

	;===============================
	; animation

	lda	#0
	sta	BLOWN_AWAY_COUNT

	lda	#SUPPRESS_PEASANT
	sta	SUPPRESS_DRAWING

blown_away_loop:

	jsr	update_screen

	lda	BLOWN_AWAY_COUNT
	lsr
	tax

	clc
	lda	PEASANT_X
	adc	blown_x,X
	sta	CURSOR_X

	clc
	lda	PEASANT_Y
	adc	blown_y,X
	sta	CURSOR_Y

	clc
	txa
	adc	#BLOWN_AWAY_OFFSET
	tax

	jsr	hgr_sprite_custom_bg_mask

	jsr	hgr_page_flip

;	jsr	wait_until_keypress

	inc	BLOWN_AWAY_COUNT
	lda	BLOWN_AWAY_COUNT
	cmp	#10
	bne	blown_away_loop


done_blown_away:

	jsr	stop_walking

	; unsuppress drawing peasant

	lda	SUPPRESS_DRAWING
	and	#<(~SUPPRESS_PEASANT)
	sta	SUPPRESS_DRAWING

	; change back to normal clothes

	lda	#PEASANT_OUTFIT_SHORTS
	jsr	load_peasant_sprites

	; print message
	ldx	#<hay_blown_away_message
	ldy	#>hay_blown_away_message
	jsr	partial_message_step

	rts


; x offset for animation

blown_x:
	.byte 2+0,2+2,2+2,2+4,2+6

; y offset for animation

blown_y:
	.byte 0,+1,<(-3),<(-10),<(-14)


