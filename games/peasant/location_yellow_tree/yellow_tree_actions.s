.include "../tokens.inc"

	;=======================
	;=======================
	;=======================
	; Yellow Tree
	;=======================
	;=======================
	;=======================

yellow_tree_verb_table:
        .byte VERB_LOOK
        .word yellow_tree_look-1
	.byte 0

	;=================
	; look
	;=================

yellow_tree_look:

	lda	CURRENT_NOUN

	cmp	#NOUN_TREE
	beq	yellow_tree_look_tree
	cmp	#NOUN_COTTAGE
	beq	yellow_tree_look_cottage
	cmp	#NOUN_NONE
	beq	yellow_tree_look_at

	jmp	parse_common_look

yellow_tree_look_at:
	ldx	#<yellow_tree_look_message
	ldy	#>yellow_tree_look_message
	jmp	finish_parse_message

yellow_tree_look_cottage:
	ldx	#<yellow_tree_look_cottage_message
	ldy	#>yellow_tree_look_cottage_message
	jmp	finish_parse_message

yellow_tree_look_tree:
	ldx	#<yellow_tree_look_tree_message
	ldy	#>yellow_tree_look_tree_message
	jmp	finish_parse_message



.include "../text/dialog_yellow_tree.inc"
