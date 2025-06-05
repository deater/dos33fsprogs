.include "../tokens.inc"


	;=======================
	;=======================
	;=======================
	; Puddle
	;=======================
	;=======================
	;=======================

puddle_verb_table:
	.byte VERB_GET
	.word puddle_get-1
	.byte VERB_TAKE
	.word puddle_take-1
	.byte VERB_STEAL
	.word puddle_steal-1
	.byte VERB_LOOK
	.word puddle_look-1
	.byte 0


	;================
	; get
	;================
puddle_get:
puddle_steal:
puddle_take:
	lda	CURRENT_NOUN

	cmp	#NOUN_ROCK
	beq	puddle_get_rock
	cmp	#NOUN_STONE
	beq	puddle_get_rock
	cmp	#NOUN_MUD
	beq	puddle_get_mud
	cmp	#NOUN_PUDDLE
	beq	puddle_get_mud


	; else "probably wish" message

	jmp	parse_common_get

puddle_get_rock:
	ldx	#<puddle_get_rock_message
	ldy	#>puddle_get_rock_message
	jmp	finish_parse_message

puddle_get_mud:
	lda	GAME_STATE_1
	and	#PUDDLE_WET
	bne	puddle_get_mud_wet

	jmp	parse_common_get

puddle_get_mud_wet:
	lda	GAME_STATE_2
	and	#COVERED_IN_MUD
	bne	puddle_get_mud_wet_dirty

puddle_get_mud_wet_clean:
	ldx	#<puddle_get_mud_wet_clean_message
	ldy	#>puddle_get_mud_wet_clean_message
	jmp	finish_parse_message

puddle_get_mud_wet_dirty:
	ldx	#<puddle_get_mud_wet_dirty_message
	ldy	#>puddle_get_mud_wet_dirty_message
	jmp	finish_parse_message

	;=================
	; look
	;=================

puddle_look:

	lda	CURRENT_NOUN

	cmp	#NOUN_ROCK
	beq	puddle_look_at_rock
	cmp	#NOUN_STONE
	beq	puddle_look_at_rock
	cmp	#NOUN_MUD
	beq	puddle_look_at_mud
	cmp	#NOUN_PUDDLE
	beq	puddle_look_at_mud
	cmp	#NOUN_NONE
	beq	puddle_look_at

	jmp	parse_common_look

puddle_look_at:
	lda	GAME_STATE_1
	and	#PUDDLE_WET
	bne	puddle_look_at_wet

puddle_look_at_dry:
	ldx	#<puddle_look_at_dry_message
	ldy	#>puddle_look_at_dry_message
	jmp	finish_parse_message

puddle_look_at_wet:
	ldx	#<puddle_look_at_wet_message
	ldy	#>puddle_look_at_wet_message
	jmp	finish_parse_message

puddle_look_at_mud:
	lda	GAME_STATE_1
	and	#PUDDLE_WET
	bne	puddle_look_at_mud_wet
puddle_look_at_mud_dry:
	ldx	#<puddle_look_mud_dry_message
	ldy	#>puddle_look_mud_dry_message
	jmp	finish_parse_message

puddle_look_at_mud_wet:
	ldx	#<puddle_look_mud_wet_message
	ldy	#>puddle_look_mud_wet_message
	jmp	finish_parse_message

puddle_look_at_rock:
	ldx	#<puddle_get_rock_message
	ldy	#>puddle_get_rock_message
	jmp	finish_parse_message


.include "../text/dialog_puddle.inc"
