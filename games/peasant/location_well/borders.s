
	; special case if leaving with baby in well

	; trouble though, by this point MAP_LOCATION is the new one?

	lda	PREVIOUS_LOCATION
	cmp	#LOCATION_OLD_WELL
	bne	skip_level_specific

at_old_well:
	lda	GAME_STATE_0
	and	#BABY_IN_WELL
	beq	skip_level_specific

	ldx	#<well_leave_baby_in_well_message
	ldy	#>well_leave_baby_in_well_message
	jsr	finish_parse_message

	lda	#LOAD_GAME_OVER
	sta	WHICH_LOAD

	lda	#NEW_FROM_DISK	; needed?
	sta	LEVEL_OVER
	jmp	level_over

skip_level_specific:



