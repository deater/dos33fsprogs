.include "../tokens.inc"


	;=======================
	;=======================
	;=======================
	; Ned Tree
	;=======================
	;=======================
	;=======================

ned_verb_table:
	.byte VERB_CLIMB
	.word ned_tree_climb-1
	.byte VERB_LOOK
	.word ned_tree_look-1
	.byte VERB_TALK
	.word ned_tree_talk-1
	.byte 0


	;================
	; climb
	;================
ned_tree_climb:
	lda	CURRENT_NOUN

	cmp	#NOUN_TREE
	beq	ned_tree_climb_tree

	jmp	parse_common_unknown

ned_tree_climb_tree:
	ldx	#<ned_tree_climb_tree_message
	ldy	#>ned_tree_climb_tree_message
	jmp	finish_parse_message

	;================
	; talk
	;================
ned_tree_talk:
	lda	CURRENT_NOUN

	cmp	#NOUN_TREE
	beq	ned_tree_talk_tree
	cmp	#NOUN_NONE
	beq	ned_tree_talk_at
	cmp	#NOUN_NED
	beq	ned_tree_talk_ned

	jmp	parse_common_talk

ned_tree_talk_tree:
	ldx	#<ned_tree_talk_tree_message
	ldy	#>ned_tree_talk_tree_message
	jmp	finish_parse_message

ned_tree_talk_ned:
	; only if he's out
	lda	NED_STATUS
	bmi	ned_tree_talk_ned_out

	jmp	parse_common_talk

ned_tree_talk_ned_out:

	; scare him away

	lda	#253
	sta	NED_STATUS
	; FIXME: do we need to re-draw?

	ldx	#<ned_tree_talk_ned_message
	ldy	#>ned_tree_talk_ned_message
	jmp	finish_parse_message

ned_tree_talk_at:
	; only if he's out

	lda	NED_STATUS
	bmi	ned_tree_talk_at_out

	jmp	parse_common_talk

ned_tree_talk_at_out:

	; scare him away

	lda	#253
	sta	NED_STATUS
	; FIXME: do we need to re-draw?

	ldx	#<ned_tree_talk_none_message
	ldy	#>ned_tree_talk_none_message
	jmp	finish_parse_message


	;=================
	; look
	;=================

ned_tree_look:

	lda	CURRENT_NOUN

	cmp	#NOUN_TREE
	beq	ned_tree_look_at_tree
	cmp	#NOUN_NONE
	beq	ned_tree_look_at
	cmp	#NOUN_DUDE
	beq	ned_tree_look_guy
	cmp	#NOUN_GUY
	beq	ned_tree_look_guy
	cmp	#NOUN_MAN
	beq	ned_tree_look_guy
	cmp	#NOUN_NED
	beq	ned_tree_look_guy


	jmp	parse_common_look

ned_tree_look_at:
	ldx	#<ned_tree_look_at_message
	ldy	#>ned_tree_look_at_message
	jmp	finish_parse_message

ned_tree_look_at_tree:
	ldx	#<ned_tree_look_at_tree_message
	ldy	#>ned_tree_look_at_tree_message
	jmp	finish_parse_message

ned_tree_look_guy:

	; only if he's visible
	lda	NED_STATUS
	bmi	ned_tree_look_ned_out

	jmp	parse_common_look

ned_tree_look_ned_out:
	ldx	#<ned_tree_look_ned_message
	ldy	#>ned_tree_look_ned_message
	jmp	finish_parse_message


.include "../text/dialog_wavy_tree.inc"
