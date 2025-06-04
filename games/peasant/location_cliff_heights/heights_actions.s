.include "../tokens.inc"

	;=======================
	;=======================
	;=======================
	; Cliff Heights
	;=======================
	;=======================
	;=======================

	; This one is complex, should we have multiple verb tables
	;	for when taking quiz?


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


.include "../text/dialog_cliff_heights.inc"
