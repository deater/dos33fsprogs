.include "../tokens.inc"

	;=======================
	;=======================
	;=======================
	; waterfall
	;=======================
	;=======================
	;=======================

waterfall_verb_table:
	.byte VERB_CLIMB
	.word waterfall_climb-1
	.byte VERB_LOOK
	.word waterfall_look-1
	.byte VERB_SWIM
	.word waterfall_swim-1
	.byte 0

	;=================
	; climb
	;=================

waterfall_climb:

	lda	CURRENT_NOUN

	cmp	#NOUN_CLIFF
	beq	waterfall_climb_cliff

	jmp	parse_common_unknown

waterfall_climb_cliff:
	ldx	#<waterfall_climb_cliff_message
	ldy	#>waterfall_climb_cliff_message
	jmp	finish_parse_message


	;=================
	; look
	;=================

waterfall_look:

	lda	CURRENT_NOUN

	cmp	#NOUN_TREE
	beq	waterfall_look_tree
	cmp	#NOUN_WATERFALL
	beq	waterfall_look_waterfall

	cmp	#NOUN_NONE
	beq	waterfall_look_at

	jmp	parse_common_look

waterfall_look_at:
	ldx	#<waterfall_look_at_message
	ldy	#>waterfall_look_at_message
	jmp	finish_parse_message

waterfall_look_tree:
	ldx	#<waterfall_look_tree_message
	ldy	#>waterfall_look_tree_message
	jmp	finish_parse_message

waterfall_look_waterfall:
	ldx	#<waterfall_look_waterfall_message
	ldy	#>waterfall_look_waterfall_message
	jmp	finish_parse_message

	;=================
	; swim
	;=================

waterfall_swim:

	lda	CURRENT_NOUN

	cmp	#NOUN_WATER
	beq	waterfall_swim_water
	cmp	#NOUN_WATERFALL
	beq	waterfall_swim_water
	cmp	#NOUN_NONE
	beq	waterfall_swim_water

	jmp	parse_common_unknown

waterfall_swim_water:
	ldx	#<waterfall_swim_message
	ldy	#>waterfall_swim_message
	jmp	finish_parse_message



.include "../text/dialog_waterfall.inc"
