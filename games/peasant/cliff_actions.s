.include "tokens.inc"

	;=======================
	;=======================
	;=======================
	; Hidden Glen
	;=======================
	;=======================
	;=======================

hidden_glen_verb_table:
.if 0
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
.endif
	.byte 0
.if 0

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


	;===================
	; enter hay
	;===================

hay_bale_enter:
hay_bale_jump:
hay_bale_hide:

	lda	CURRENT_NOUN

	cmp	#NOUN_HAY
	beq	enter_hay

	jmp	parse_common_unknown

enter_hay:
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
.endif


	;=======================
	;=======================
	;=======================
	; Inside Lady Cottage
	;=======================
	;=======================
	;=======================

inside_cottage_verb_table:
.if 0
	.byte VERB_GET
	.word puddle_get-1
	.byte VERB_TAKE
	.word puddle_take-1
	.byte VERB_STEAL
	.word puddle_steal-1
	.byte VERB_LOOK
	.word puddle_look-1
.endif
	.byte 0
.if 0

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


	; else "probably wish" message

	jmp	parse_common_get

puddle_get_rock:
	ldx	#<puddle_get_rock_message
	ldy	#>puddle_get_rock_message
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
	ldx	#<puddle_look_at_message
	ldy	#>puddle_look_at_message
	jmp	finish_parse_message

puddle_look_at_mud:
	ldx	#<puddle_look_mud_message
	ldy	#>puddle_look_mud_message
	jmp	finish_parse_message

puddle_look_at_rock:
	ldx	#<puddle_get_rock_message
	ldy	#>puddle_get_rock_message
	jmp	finish_parse_message

.endif
	;=======================
	;=======================
	;=======================
	; Inside Ned Cottage
	;=======================
	;=======================
	;=======================

inside_nn_verb_table:
.if 0
	.byte VERB_ASK
	.word archery_ask-1
	.byte VERB_GET
	.word archery_get-1
	.byte VERB_GIVE
	.word archery_give-1
	.byte VERB_HALDO
	.word archery_haldo-1
	.byte VERB_LOOK
	.word archery_look-1
	.byte VERB_PLAY
	.word archery_play-1
	.byte VERB_STEAL
	.word archery_steal-1
	.byte VERB_TALK
	.word archery_talk-1
	.byte VERB_TAKE
	.word archery_take-1
.endif
	.byte 0
.if 0

	;================
	; ask
	;================
archery_ask:

	; TODO

	jmp	parse_common_ask


	;================
	; get
	;================
archery_get:
archery_steal:
archery_take:
	lda	CURRENT_NOUN

	cmp	#NOUN_TARGET
	beq	archery_get_target
	cmp	#NOUN_ARROW
	beq	archery_get_arrow

	; else "probably wish" message

	jmp	parse_common_get

archery_get_target:
	ldx	#<archery_get_target_message
	ldy	#>archery_get_target_message
	jmp	finish_parse_message

archery_get_arrow:
	ldx	#<archery_get_arrow_message
	ldy	#>archery_get_arrow_message
	jmp	finish_parse_message

	;================
	; give
	;================
archery_give:

	; TODO

	jmp	parse_common_give

	;================
	; haldo
	;================
archery_haldo:

	; TODO

	jmp	parse_common_haldo



	;=================
	; look
	;=================

archery_look:

	lda	CURRENT_NOUN

	cmp	#NOUN_DESK
	beq	archery_look_at_desk
	cmp	#NOUN_TARGET
	beq	archery_look_at_target
	cmp	#NOUN_ARCHER
	beq	archery_look_at_archer
	cmp	#NOUN_NONE
	beq	archery_look_at

	jmp	parse_common_look

archery_look_at:
	ldx	#<archery_look_message
	ldy	#>archery_look_message
	jmp	finish_parse_message

archery_look_at_archer:
	ldx	#<archery_look_at_archer_message
	ldy	#>archery_look_at_archer_message
	jmp	finish_parse_message

archery_look_at_target:
	ldx	#<archery_look_at_target_message
	ldy	#>archery_look_at_target_message
	jmp	finish_parse_message

archery_look_at_desk:
	ldx	#<archery_look_at_desk_message
	ldy	#>archery_look_at_desk_message
	jmp	finish_parse_message


	;================
	; play
	;================
archery_play:
	lda	CURRENT_NOUN

	cmp	#NOUN_GAME
	beq	archery_play_game

	jmp	parse_common_unknown

archery_play_game:
	ldx	#<archery_play_game_message
	ldy	#>archery_play_game_message
	jmp	finish_parse_message

	;================
	; talk
	;================
archery_talk:

	; only talk if close
	lda	PEASANT_X
	cmp	#23
	bcc	archery_talk_too_far
	; check Y too?
	; probably less than $7D?
	; actual game will walk you in if close
	; will it work from beind?

	lda	CURRENT_NOUN

	cmp	#NOUN_MAN
	beq	archery_talk_mendelev
	cmp	#NOUN_GUY
	beq	archery_talk_mendelev
	cmp	#NOUN_DUDE
	beq	archery_talk_mendelev
	cmp	#NOUN_MENDELEV
	beq	archery_talk_mendelev
	cmp	#NOUN_ARCHER
	beq	archery_talk_mendelev

	jmp	parse_common_unknown

archery_talk_mendelev:
	ldx	#<archery_talk_mendelev_message
	ldy	#>archery_talk_mendelev_message
	jsr	partial_message_step

	ldx	#<archery_talk_mendelev2_message
	ldy	#>archery_talk_mendelev2_message
	jsr	partial_message_step

	ldx	#<archery_talk_mendelev3_message
	ldy	#>archery_talk_mendelev3_message
	jsr	finish_parse_message

	; add 1 point to score if don't have mask or trinket
	; add 2 points otherwise

	lda	INVENTORY_2
	and	#INV2_TRINKET
	bne	archer_2_points

	lda	INVENTORY_1
	and	#INV1_MONSTER_MASK
	bne	archer_2_points

archer_1_point:
	lda	#1
	bne	archer_score_points	; bra
archer_2_points:
	lda	#2
archer_score_points:
	jsr	score_points

	rts

archery_talk_too_far:
	ldx	#<archery_talk_far_message
	ldy	#>archery_talk_far_message
	jmp	finish_parse_message

.endif


.include "dialog_inside.inc"
