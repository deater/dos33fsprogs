.include "../tokens.inc"

	;=======================
	;=======================
	;=======================
	; Trogdor Cave Outer
	;=======================
	;=======================
	;=======================

cave_outer_verb_table:
	.byte VERB_CLIMB
	.word cave_outer_climb-1
	.byte VERB_LOOK
	.word cave_outer_look-1
	.byte 0

	;=================
	; look
	;=================

cave_outer_look:

	lda	CURRENT_NOUN

	cmp	#NOUN_BEADS
	beq	cave_outer_look_at_curtain
	cmp	#NOUN_CURTAIN
	beq	cave_outer_look_at_curtain
	cmp	#NOUN_DOOR
	beq	cave_outer_look_at_door
	cmp	#NOUN_SKELETON
	beq	cave_outer_look_at_skeleton
	cmp	#NOUN_BONE			; note "BONES" should also work
	beq	cave_outer_look_at_skeleton
	cmp	#NOUN_SKULL
	beq	cave_outer_look_at_skeleton
	cmp	#NOUN_OPENINGS
	beq	cave_outer_look_at_openings
	cmp	#NOUN_NONE
	beq	cave_outer_look_at

	jmp	parse_common_look

cave_outer_look_at:
	ldx	#<cave_outer_look_message
	ldy	#>cave_outer_look_message
	jmp	finish_parse_message

cave_outer_look_at_curtain:
	ldx	#<cave_outer_look_curtain_message
	ldy	#>cave_outer_look_curtain_message
	jmp	finish_parse_message

cave_outer_look_at_door:
	ldx	#<cave_outer_look_door_message
	ldy	#>cave_outer_look_door_message
	jmp	finish_parse_message

cave_outer_look_at_openings:
	ldx	#<cave_outer_look_openings_message
	ldy	#>cave_outer_look_openings_message
	jmp	finish_parse_message

cave_outer_look_at_skeleton:
	ldx	#<cave_outer_look_skeleton_message
	ldy	#>cave_outer_look_skeleton_message
	jmp	finish_parse_message


	;================
	; climb
	;================
cave_outer_climb:

	lda	CURRENT_NOUN

	cmp	#NOUN_CLIFF
	beq	cave_outer_do_climb
	cmp	#NOUN_NONE
	beq	cave_outer_do_climb

	jmp	parse_common_unknown

cave_outer_do_climb:
	ldx	#<cave_outer_climb_message
	ldy	#>cave_outer_climb_message
	jmp	finish_parse_message

