.include "../tokens.inc"

	;=======================
	;=======================
	;=======================
	; That Hay Bale
	;=======================
	;=======================
	;=======================

hay_bale_verb_table:
        .byte VERB_ENTER
        .word hay_bale_enter-1
        .byte VERB_GET
        .word hay_bale_get-1
        .byte VERB_JUMP
        .word hay_bale_jump-1
        .byte VERB_HIDE
        .word hay_bale_hide-1
        .byte VERB_HUG
        .word hay_bale_hug-1
        .byte VERB_LOOK
        .word hay_bale_look-1
        .byte VERB_STEAL
        .word hay_bale_steal-1
        .byte VERB_TAKE
        .word hay_bale_take-1
	.byte VERB_CLIMB
	.word hay_bale_climb-1
	.byte 0


	;================
	; get
	;================
hay_bale_get:
hay_bale_steal:
hay_bale_take:
	lda	CURRENT_NOUN

	cmp	#NOUN_HAY
	beq	hay_get_hay

	; else "probably wish" message

	jmp	parse_common_get

hay_get_hay:
	ldx	#<hay_get_hay_message
	ldy	#>hay_get_hay_message
	jmp	finish_parse_message




	;=================
	; look
	;=================

hay_bale_look:
	; first check if in hay

	lda	GAME_STATE_1
	and	#IN_HAY_BALE
	beq	not_in_hay_bale

	ldx	#<hay_look_while_in_hay_message
	ldy	#>hay_look_while_in_hay_message
	jmp	finish_parse_message

not_in_hay_bale:
	lda	CURRENT_NOUN

	cmp	#NOUN_HAY
	beq	hay_look_at_hay
	cmp	#NOUN_IN_HAY
	beq	hay_look_in_hay
	cmp	#NOUN_TREE
	beq	hay_look_at_tree
	cmp	#NOUN_FENCE
	beq	hay_look_at_fence


	cmp	#NOUN_NONE
	beq	hay_look_at

	jmp	parse_common_look

hay_look_at:
	ldx	#<hay_look_message
	ldy	#>hay_look_message
	jmp	finish_parse_message

hay_look_at_hay:
	ldx	#<hay_look_at_hay_message
	ldy	#>hay_look_at_hay_message
	jmp	finish_parse_message

hay_look_in_hay:
	ldx	#<hay_look_in_hay_message
	ldy	#>hay_look_in_hay_message
	jmp	finish_parse_message

hay_look_at_tree:
	ldx	#<hay_look_at_tree_message
	ldy	#>hay_look_at_tree_message
	jmp	finish_parse_message

hay_look_at_fence:
	ldx	#<hay_look_at_fence_message
	ldy	#>hay_look_at_fence_message
	jmp	finish_parse_message


	;================
	; climb
	;================
hay_bale_climb:
	lda	CURRENT_NOUN

	cmp	#NOUN_FENCE
	beq	hay_climb_fence

	jmp	parse_common_unknown

hay_climb_fence:
	ldx	#<hay_climb_fence_message
	ldy	#>hay_climb_fence_message
	jmp	finish_parse_message


	;===================
	; enter hay
	;===================

hay_bale_enter:
hay_bale_jump:
hay_bale_hide:

	lda	CURRENT_NOUN

	cmp	#NOUN_FENCE
	beq	hay_climb_fence
	cmp	#NOUN_HAY
	beq	enter_hay

	jmp	parse_common_unknown

enter_hay:

	lda	GAME_STATE_2
	and	#COVERED_IN_MUD
	beq	enter_hay_no_mud

enter_hay_muddy:
	; check if in range
	lda	PEASANT_X
	cmp	#15
	bcs	really_enter_hay_muddy

enter_hay_too_far:
	ldx	#<hay_enter_hay_clean_message
	ldy	#>hay_enter_hay_clean_message
	jmp	finish_parse_message

really_enter_hay_muddy:
	ldx	#<hay_enter_hay_muddy_message
	ldy	#>hay_enter_hay_muddy_message
	jsr	partial_message_step

	; add 3 points to score

	lda	#3
	jsr	score_points

	; get in hay
	lda	GAME_STATE_1
	ora	#IN_HAY_BALE
	sta	GAME_STATE_1

	ldx	#<hay_enter_hay_muddy_message2
	ldy	#>hay_enter_hay_muddy_message2
	jmp	finish_parse_message

enter_hay_no_mud:
	ldx	#<hay_enter_hay_clean_message
	ldy	#>hay_enter_hay_clean_message
	jmp	finish_parse_message

	;===================
	; hug tree
	;===================

hay_bale_hug:

	lda	CURRENT_NOUN

	cmp	#NOUN_TREE
	beq	hug_tree

	jmp	parse_common_unknown

hug_tree:
	ldx	#<hay_hug_tree_message
	ldy	#>hay_hug_tree_message
	jmp	finish_parse_message

.include "../text/dialog_haystack.inc"
