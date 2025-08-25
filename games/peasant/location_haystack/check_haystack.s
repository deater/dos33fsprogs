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

.if 0

; x offset

.byte 0,+2,+2,+4,+6

; y offset

.byte 0,+1,-3,-10,-14

custom_sprites_data_l:
        .byte <blown_sprite0,<blown_sprite1,<blown_sprite2
        .byte <blown_sprite3,<blown_sprite4
custom_sprites_data_h:
        .byte >blown_sprite0,>blown_sprite1,>blown_sprite2
        .byte >blown_sprite3,>blown_sprite4

custom_mask_data_l:
        .byte <blown_mask0,<blown_mask1,<blown_mask2
        .byte <blown_mask3,<blown_mask4
custom_mask_data_h:
        .byte >blown_mask0,>blown_mask1,>blown_mask2
        .byte >blown_mask3,>blown_mask4

custom_sprites_xsize:
        .byte  6, 6, 7, 4, 2
custom_sprites_ysize:
        .byte 43,35,32,26,11
.endif
