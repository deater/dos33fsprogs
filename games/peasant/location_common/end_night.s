
	;=======================
	; if it's night, end it

	lda	GAME_STATE_1
	and	#NIGHT
	beq	wasnt_night

	lda	GAME_STATE_1	; clear night bit
	and	#<(~NIGHT)
	sta	GAME_STATE_1

	; print message

	ldx	#<night_over_message
	ldy	#>night_over_message
	jsr	finish_parse_message

wasnt_night:
