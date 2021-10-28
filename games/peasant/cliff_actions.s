.include "tokens.inc"

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
	ldx	#<cliff_base_climb_message
	ldy	#>cliff_base_climb_message
	jsr	partial_message_step

	ldx	#<cliff_base_climb2_message
	ldy	#>cliff_base_climb2_message
	jmp	finish_parse_message


	;=======================
	;=======================
	;=======================
	; Cliff Heights
	;=======================
	;=======================
	;=======================

cliff_heights_verb_table:
	.byte VERB_GET
	.word cliff_heights_get-1
	.byte VERB_TAKE
	.word cliff_heights_get-1
	.byte VERB_STEAL
	.word cliff_heights_get-1
	.byte VERB_CLIMB
	.word cliff_heights_climb-1
	.byte VERB_LOOK
	.word cliff_heights_look-1
	.byte 0

	;================
	; climb
	;================
cliff_heights_climb:

	lda	CURRENT_NOUN

	cmp	#NOUN_CLIFF
	beq	cliff_heights_do_climb
	cmp	#NOUN_NONE
	beq	cliff_heights_do_climb

	jmp	parse_common_unknown

cliff_heights_do_climb:
	ldx	#<cliff_heights_climb_message
	ldy	#>cliff_heights_climb_message
	jmp	finish_parse_message


	;================
	; get
	;================
cliff_heights_get:
cliff_heights_steal:
cliff_heights_take:
	lda	CURRENT_NOUN

	cmp	#NOUN_BONE
	beq	cliff_heights_get_bone
	cmp	#NOUN_SKULL
	beq	cliff_heights_get_bone

	; else "probably wish" message

	jmp	parse_common_get

cliff_heights_get_bone:
	ldx	#<cliff_heights_get_bone_message
	ldy	#>cliff_heights_get_bone_message
	jmp	finish_parse_message

	;=================
	; look
	;=================

cliff_heights_look:

	lda	CURRENT_NOUN

	cmp	#NOUN_LIGHTNING
	beq	cliff_heights_look_at_lightning
	cmp	#NOUN_CAVE
	beq	cliff_heights_look_at_cave
	cmp	#NOUN_BONE
	beq	cliff_heights_look_at_bone
	cmp	#NOUN_SKULL
	beq	cliff_heights_look_at_bone
	cmp	#NOUN_NONE
	beq	cliff_heights_look_at

	jmp	parse_common_look

cliff_heights_look_at:
	ldx	#<cliff_heights_look_at_message
	ldy	#>cliff_heights_look_at_message
	jmp	finish_parse_message

cliff_heights_look_at_bone:
	ldx	#<cliff_heights_look_bone_message
	ldy	#>cliff_heights_look_bone_message
	jmp	finish_parse_message

cliff_heights_look_at_cave:
	ldx	#<cliff_heights_look_cave_message
	ldy	#>cliff_heights_look_cave_message
	jmp	finish_parse_message

cliff_heights_look_at_lightning:
	ldx	#<cliff_heights_look_lightning_message
	ldy	#>cliff_heights_look_lightning_message
	jmp	finish_parse_message


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



.include "dialog_cliff.inc"
