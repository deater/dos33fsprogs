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

	.byte VERB_LOOK
	.word inside_cottage_look-1
	.byte VERB_TALK
	.word inside_cottage_talk-1
	.byte VERB_GET
	.word inside_cottage_get-1
	.byte VERB_TAKE
	.word inside_cottage_get-1
	.byte VERB_STEAL
	.word inside_cottage_get-1
	.byte VERB_GIVE
	.word inside_cottage_give-1
	.byte VERB_ASK
	.word inside_cottage_ask-1
	.byte VERB_SLEEP
	.word inside_cottage_sleep-1
	.byte 0

	;=================
	; give
	;=================

inside_cottage_give:

	lda	CURRENT_NOUN

	cmp	#NOUN_RICHES
	beq	inside_cottage_give_riches
	cmp	#NOUN_TRINKET
	beq	inside_cottage_give_trinket

	lda	GAME_STATE_0
	and	#LADY_GONE
	bne	default_nolady

	ldx	#<inside_cottage_give_default_message
	ldy	#>inside_cottage_give_default_message
	jmp	finish_parse_message

default_nolady:
	jmp	parse_common_give

inside_cottage_give_riches:

	lda	INVENTORY_2_GONE
	and	#INV2_RICHES
	bne	inside_cottage_give_riches_already

	lda	INVENTORY_2
	and	#INV2_RICHES
	beq	inside_cottage_give_riches_notyet

	; Give the riches

	ldx	#<inside_cottage_give_riches_message
	ldy	#>inside_cottage_give_riches_message
	jsr	partial_message_step

	; add 5 points to score

	lda	#5
	jsr	score_points

	; get baby

	lda	INVENTORY_1
	ora	#INV1_BABY
	sta	INVENTORY_1

	ldx	#<inside_cottage_give_riches2_message
	ldy	#>inside_cottage_give_riches2_message
	jmp	finish_parse_message


inside_cottage_give_riches_notyet:
	ldx	#<inside_cottage_give_riches_notyet_message
	ldy	#>inside_cottage_give_riches_notyet_message
	jmp	finish_parse_message

inside_cottage_give_riches_already:
	ldx	#<inside_cottage_give_riches_already_message
	ldy	#>inside_cottage_give_riches_already_message
	jmp	finish_parse_message

inside_cottage_give_trinket:

	lda	INVENTORY_2
	and	#INV2_TRINKET
	beq	inside_cottage_give_trinket_nothave

	; Give the trinket
inside_cottage_give_the_trinket:
	ldx	#<inside_cottage_give_trinket_message
	ldy	#>inside_cottage_give_trinket_message
	jmp	finish_parse_message


inside_cottage_give_trinket_nothave:
	lda	GAME_STATE_0
	and	#LADY_GONE
	bne	inside_cottage_give_trinket_nolady

	ldx	#<inside_cottage_give_trinket_nohave_message
	ldy	#>inside_cottage_give_trinket_nohave_message
	jsr	partial_message_step


	ldx	#<inside_cottage_give_trinket_nohave2_message
	ldy	#>inside_cottage_give_trinket_nohave2_message
	jmp	finish_parse_message

inside_cottage_give_trinket_nolady:
	ldx	#<inside_cottage_give_trinket_nolady_message
	ldy	#>inside_cottage_give_trinket_nolady_message
	jmp	finish_parse_message



	;=================
	; get/take/steal
	;=================

inside_cottage_get:

	lda	CURRENT_NOUN

	cmp	#NOUN_FEED
	beq	inside_cottage_get_feed
	cmp	#NOUN_BABY
	beq	inside_cottage_get_baby
	cmp	#NOUN_CHAIR
	beq	inside_cottage_get_chair
	cmp	#NOUN_GOLD
	beq	inside_cottage_get_gold
	cmp	#NOUN_MONEY
	beq	inside_cottage_get_gold
	cmp	#NOUN_HAY
	beq	inside_cottage_get_hay
	cmp	#NOUN_FOOD
	beq	inside_cottage_get_food
	cmp	#NOUN_STUFF
	beq	inside_cottage_get_food
	cmp	#NOUN_PILLOW
	beq	inside_cottage_get_pillow

	jmp	parse_common_get

inside_cottage_get_feed:
	lda	INVENTORY_1
	and	#INV1_CHICKEN_FEED
	bne	inside_cottage_get_feed_already

	lda	INVENTORY_1_GONE
	and	#INV1_CHICKEN_FEED
	bne	inside_cottage_get_feed_already

	; get the feed
	lda	INVENTORY_1
	ora	#INV1_CHICKEN_FEED
	sta	INVENTORY_1

	; add 1 point to score

        lda     #1
        jsr     score_points

	ldx	#<inside_cottage_get_feed_message
	ldy	#>inside_cottage_get_feed_message
	jmp	finish_parse_message

inside_cottage_get_feed_already:
	ldx	#<inside_cottage_get_feed_already_message
	ldy	#>inside_cottage_get_feed_already_message
	jmp	finish_parse_message


inside_cottage_get_baby:
	lda	GAME_STATE_0
	and	#LADY_GONE
	beq	inside_cottage_get_baby_notgone

	jmp	parse_common_get

inside_cottage_get_baby_notgone:

	ldx	#<inside_cottage_get_baby_message
	ldy	#>inside_cottage_get_baby_message
	jmp	finish_parse_message

inside_cottage_get_chair:
	lda	GAME_STATE_0
	and	#LADY_GONE
	beq	inside_cottage_get_chair_notgone

	ldx	#<inside_cottage_get_chair_gone_message
	ldy	#>inside_cottage_get_chair_gone_message
	jmp	finish_parse_message

inside_cottage_get_chair_notgone:

	ldx	#<inside_cottage_get_chair_message
	ldy	#>inside_cottage_get_chair_message
	jmp	finish_parse_message

inside_cottage_get_gold:
	ldx	#<inside_cottage_get_gold_message
	ldy	#>inside_cottage_get_gold_message
	jmp	finish_parse_message

inside_cottage_get_hay:
	ldx	#<inside_cottage_get_hay_message
	ldy	#>inside_cottage_get_hay_message
	jmp	finish_parse_message

inside_cottage_get_food:
	ldx	#<inside_cottage_get_food_message
	ldy	#>inside_cottage_get_food_message
	jmp	finish_parse_message

inside_cottage_get_pillow:
	ldx	#<inside_cottage_get_pillow_message
	ldy	#>inside_cottage_get_pillow_message
	jmp	finish_parse_message


	;=================
	; talk
	;=================

inside_cottage_talk:

	lda	CURRENT_NOUN

	cmp	#NOUN_BABY
	beq	inside_cottage_talk_baby
	cmp	#NOUN_PEASANT
	beq	inside_cottage_talk_lady
	cmp	#NOUN_LADY
	beq	inside_cottage_talk_lady
	cmp	#NOUN_WOMAN
	beq	inside_cottage_talk_lady
	cmp	#NOUN_NONE
	beq	inside_cottage_talk_lady

	jmp	parse_common_talk

inside_cottage_talk_lady:
	lda	GAME_STATE_0
	and	#LADY_GONE
	bne	inside_cottage_look_at_lady_gone

	ldx	#<inside_cottage_talk_lady_message
	ldy	#>inside_cottage_talk_lady_message
	jsr	partial_message_step

	ldx	#<inside_cottage_talk_lady2_message
	ldy	#>inside_cottage_talk_lady2_message
	jmp	finish_parse_message

inside_cottage_talk_lady_gone:
	ldx	#<inside_cottage_talk_lady_gone_message
	ldy	#>inside_cottage_talk_lady_gone_message
	jmp	finish_parse_message

inside_cottage_talk_baby:
	ldx	#<inside_cottage_talk_baby_message
	ldy	#>inside_cottage_talk_baby_message
	jmp	finish_parse_message

	;=================
	; look
	;=================

inside_cottage_look:

	lda	CURRENT_NOUN

	cmp	#NOUN_BABY
	beq	inside_cottage_look_at_baby
	cmp	#NOUN_CHAIR
	beq	inside_cottage_look_at_chair
	cmp	#NOUN_FEED
	beq	inside_cottage_look_at_feed
	cmp	#NOUN_HAY
	beq	inside_cottage_look_at_hay
	cmp	#NOUN_PEASANT
	beq	inside_cottage_look_at_lady
	cmp	#NOUN_LADY
	beq	inside_cottage_look_at_lady
	cmp	#NOUN_WOMAN
	beq	inside_cottage_look_at_lady
	cmp	#NOUN_PILLOW
	beq	inside_cottage_look_at_pillow
	cmp	#NOUN_SHELF
	beq	inside_cottage_look_at_shelf

	cmp	#NOUN_NONE
	beq	inside_cottage_look_at

	jmp	parse_common_look

inside_cottage_look_at_shelf:
	ldx	#<inside_cottage_look_at_shelf_message
	ldy	#>inside_cottage_look_at_shelf_message
	jmp	finish_parse_message

inside_cottage_look_at_pillow:
	ldx	#<inside_cottage_look_at_pillow_message
	ldy	#>inside_cottage_look_at_pillow_message
	jmp	finish_parse_message

inside_cottage_look_at_lady:
	lda	GAME_STATE_0
	and	#LADY_GONE
	bne	inside_cottage_look_at_lady_gone

	ldx	#<inside_cottage_look_at_lady_message
	ldy	#>inside_cottage_look_at_lady_message
	jmp	finish_parse_message

inside_cottage_look_at_lady_gone:
	ldx	#<inside_cottage_look_at_lady_gone_message
	ldy	#>inside_cottage_look_at_lady_gone_message

	jsr	partial_message_step

	ldx	#<inside_cottage_look_at_lady_gone2_message
	ldy	#>inside_cottage_look_at_lady_gone2_message

	jmp	finish_parse_message


inside_cottage_look_at_hay:
	ldx	#<inside_cottage_look_at_hay_message
	ldy	#>inside_cottage_look_at_hay_message
	jmp	finish_parse_message

inside_cottage_look_at_feed:
	ldx	#<inside_cottage_look_at_feed_message
	ldy	#>inside_cottage_look_at_feed_message
	jmp	finish_parse_message

inside_cottage_look_at_chair:
	ldx	#<inside_cottage_look_at_chair_message
	ldy	#>inside_cottage_look_at_chair_message
	jmp	finish_parse_message

inside_cottage_look_at_baby:
	lda	GAME_STATE_0
	and	#LADY_GONE
	beq	inside_cottage_look_at_baby_there

	; if baby/lady gone, call common code
	jmp	parse_common_look

inside_cottage_look_at_baby_there:

	ldx	#<inside_cottage_look_at_baby_message
	ldy	#>inside_cottage_look_at_baby_message
	jmp	finish_parse_message

inside_cottage_look_at:
	lda	GAME_STATE_0
	and	#LADY_GONE
	bne	inside_cottage_look_at_gone

	ldx	#<inside_cottage_look_at_message
	ldy	#>inside_cottage_look_at_message
	jmp	finish_parse_message

inside_cottage_look_at_gone:
	ldx	#<inside_cottage_look_at_gone_message
	ldy	#>inside_cottage_look_at_gone_message
	jmp	finish_parse_message


	;=================
	; ask about
	;=================

inside_cottage_ask:

	lda	GAME_STATE_0
	and	#LADY_GONE
	beq	inside_cottage_ask_lady

	jmp	parse_common_ask

inside_cottage_ask_lady:
	lda	CURRENT_NOUN

	cmp	#NOUN_BABY
	beq	inside_cottage_ask_baby
	cmp	#NOUN_FIRE
	beq	inside_cottage_ask_fire
	cmp	#NOUN_JHONKA
	beq	inside_cottage_ask_jhonka
	cmp	#NOUN_NED
	beq	inside_cottage_ask_ned
	cmp	#NOUN_ROBE
	beq	inside_cottage_ask_robe
	cmp	#NOUN_SMELL
	beq	inside_cottage_ask_smell
	cmp	#NOUN_TROGDOR
	beq	inside_cottage_ask_trogdor

	ldx	#<inside_cottage_ask_unknown_message
	ldy	#>inside_cottage_ask_unknown_message
	jmp	finish_parse_message

inside_cottage_ask_baby:
	ldx	#<inside_cottage_ask_baby_message
	ldy	#>inside_cottage_ask_baby_message
	jmp	finish_parse_message

inside_cottage_ask_fire:
	ldx	#<inside_cottage_ask_fire_message
	ldy	#>inside_cottage_ask_fire_message
	jsr	partial_message_step

	ldx	#<inside_cottage_ask_fire2_message
	ldy	#>inside_cottage_ask_fire2_message
	jsr	partial_message_step

	ldx	#<inside_cottage_ask_fire3_message
	ldy	#>inside_cottage_ask_fire3_message
	jmp	finish_parse_message

inside_cottage_ask_jhonka:
	ldx	#<inside_cottage_ask_jhonka_message
	ldy	#>inside_cottage_ask_jhonka_message
	jsr	partial_message_step

	ldx	#<inside_cottage_ask_jhonka2_message
	ldy	#>inside_cottage_ask_jhonka2_message
	jsr	partial_message_step

	ldx	#<inside_cottage_ask_jhonka3_message
	ldy	#>inside_cottage_ask_jhonka3_message
	jmp	finish_parse_message

inside_cottage_ask_ned:
	ldx	#<inside_cottage_ask_ned_message
	ldy	#>inside_cottage_ask_ned_message
	jmp	finish_parse_message

inside_cottage_ask_robe:
	ldx	#<inside_cottage_ask_robe_message
	ldy	#>inside_cottage_ask_robe_message
	jmp	finish_parse_message

inside_cottage_ask_smell:
	ldx	#<inside_cottage_ask_smell_message
	ldy	#>inside_cottage_ask_smell_message
	jsr	partial_message_step

	ldx	#<inside_cottage_ask_smell2_message
	ldy	#>inside_cottage_ask_smell2_message
	jmp	finish_parse_message

inside_cottage_ask_trogdor:
	ldx	#<inside_cottage_ask_trogdor_message
	ldy	#>inside_cottage_ask_trogdor_message
	jmp	finish_parse_message

	;=================
	; sleep
	;=================

inside_cottage_sleep:
	ldx	#<inside_cottage_sleep_message
	ldy	#>inside_cottage_sleep_message
	jmp	finish_parse_message

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
