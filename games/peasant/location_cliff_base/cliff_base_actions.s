.include "../tokens.inc"

	;=======================
	;=======================
	;=======================
	; cliff base
	;=======================
	;=======================
	;=======================

cliff_base_verb_table:
        .byte VERB_LOOK
        .word cliff_base_look-1
        .byte VERB_CLIMB
        .word cliff_base_climb-1
	.byte 0

	;=================
	; look
	;=================

cliff_base_look:

	lda	CURRENT_NOUN
	cmp	#NOUN_NONE
	beq	cliff_base_look_at

	jmp	parse_common_look

cliff_base_look_at:
	ldx	#<cliff_base_look_message
	ldy	#>cliff_base_look_message
	jmp	finish_parse_message


	;=================
	; climb
	;=================

cliff_base_climb:

	lda	CURRENT_NOUN
	cmp	#NOUN_CLIFF
	beq	cliff_base_do_climb
	cmp	#NOUN_NONE
	beq	cliff_base_do_climb

	jmp	parse_common_unknown

cliff_base_do_climb:

	lda	#LOAD_CLIMB
	sta	WHICH_LOAD

	lda	#LOCATION_CLIMB
	sta	MAP_LOCATION

	lda	#NEW_FROM_DISK
	sta	LEVEL_OVER

	ldx	#<cliff_base_climb_message
	ldy	#>cliff_base_climb_message
	jsr	partial_message_step

	ldx	#<cliff_base_climb2_message
	ldy	#>cliff_base_climb2_message
	jmp	finish_parse_message



.include "../text/dialog_cliff_base.inc"
