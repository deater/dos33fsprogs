.include "tokens.inc"

	;=======================
	;=======================
	;=======================
	; Hidden Glen
	;=======================
	;=======================
	;=======================

hidden_glen_verb_table:
        .byte VERB_SAY
        .word hidden_glen_say-1
        .byte VERB_TALK
        .word hidden_glen_talk-1
        .byte VERB_HALDO
        .word hidden_glen_haldo-1
        .byte VERB_GET
        .word hidden_glen_get-1
        .byte VERB_TAKE
        .word hidden_glen_get-1
        .byte VERB_CLIMB
        .word hidden_glen_climb-1
        .byte VERB_JUMP
        .word hidden_glen_climb-1
        .byte VERB_LOOK
        .word hidden_glen_look-1
	.byte 0

	;=================
	; say
	;=================

hidden_glen_say:
	; only say HALDO.  Wastes noun slot

	lda	CURRENT_NOUN

	cmp	#NOUN_HALDO
	beq	hidden_glen_say_haldo

	jmp	parse_common_unknown

	;=================
	; haldo
	;=================

hidden_glen_haldo:

	lda	CURRENT_NOUN

	cmp	#NOUN_NONE
	beq	hidden_glen_say_haldo

	jmp	parse_common_unknown

	;=================
	; haldo
hidden_glen_say_haldo:
	lda	GAME_STATE_0
	and	#HALDO_TO_DONGOLEV
	beq	hidden_glen_say_haldo_dongolev_there

hidden_glen_say_haldo_no_dongolev:
	ldx	#<hidden_glen_say_haldo_no_dongolev_message
	ldy	#>hidden_glen_say_haldo_no_dongolev_message
	jmp	finish_parse_message

hidden_glen_say_haldo_dongolev_there:
	; check if talked to mendelev first
	lda	GAME_STATE_0
	and	#TALKED_TO_MENDELEV
	beq	hidden_glen_say_haldo_skip_mendelev

hidden_glen_say_haldo_hooray:
	; add 3 points to score
	lda	#3
	jsr	score_points

	; set that we talked to him
	lda	GAME_STATE_0
	ora	#HALDO_TO_DONGOLEV
	sta	GAME_STATE_0

	ldx	#<hidden_glen_say_haldo_message
	ldy	#>hidden_glen_say_haldo_message
	jmp	finish_parse_message


hidden_glen_say_haldo_skip_mendelev:
	ldx	#<hidden_glen_say_haldo_skip_mendelev_message
	ldy	#>hidden_glen_say_haldo_skip_mendelev_message
	jmp	finish_parse_message

	;=================
	; look
	;=================

hidden_glen_look:

	lda	CURRENT_NOUN

	cmp	#NOUN_BUSH
	beq	hidden_glen_look_at_bushes
	cmp	#NOUN_ARROW
	beq	hidden_glen_look_at_arrow
	cmp	#NOUN_FENCE
	beq	hidden_glen_look_at_fence
	cmp	#NOUN_TREE
	beq	hidden_glen_look_at_tree

	cmp	#NOUN_ARCHER
	beq	hidden_glen_look_at_archer
	cmp	#NOUN_DONGOLEV
	beq	hidden_glen_look_at_archer

	cmp	#NOUN_NONE
	beq	hidden_glen_look_at

	jmp	parse_common_look

	;=================
	; look
hidden_glen_look_at:
	lda	GAME_STATE_0
	and	#HALDO_TO_DONGOLEV
	beq	hidden_glen_look_at_dongolev_yes

hidden_glen_look_at_dongolev_no:
	ldx	#<hidden_glen_look_no_dongolev_message
	ldy	#>hidden_glen_look_no_dongolev_message
	jmp	finish_parse_message

hidden_glen_look_at_dongolev_yes:
	ldx	#<hidden_glen_look_message
	ldy	#>hidden_glen_look_message
	jmp	finish_parse_message

	;=============
	; look at archer
hidden_glen_look_at_archer:
	lda	GAME_STATE_0
	and	#HALDO_TO_DONGOLEV
	beq	hidden_glen_look_at_archer_dongolev_yes

hidden_glen_look_at_archer_dongolev_no:
	jmp	parse_common_look

hidden_glen_look_at_archer_dongolev_yes:
	ldx	#<hidden_glen_look_at_archer_message
	ldy	#>hidden_glen_look_at_archer_message
	jmp	finish_parse_message

	;=============
	; look at arrow
hidden_glen_look_at_arrow:
	lda	INVENTORY_1
	and	#INV1_ARROW
	beq	hidden_glen_look_at_arrow_arrow_no

hidden_glen_look_at_arrow_arrow_yes:
	jmp	parse_common_look

hidden_glen_look_at_arrow_arrow_no:
	ldx	#<hidden_glen_look_at_arrow_message
	ldy	#>hidden_glen_look_at_arrow_message
	jmp	finish_parse_message

	;===============
	; look at bushes
hidden_glen_look_at_bushes:
	ldx	#<hidden_glen_look_at_bushes_message
	ldy	#>hidden_glen_look_at_bushes_message
	jmp	finish_parse_message

	;==============
	; look at fence
hidden_glen_look_at_fence:
	ldx	#<hidden_glen_look_at_fence_message
	ldy	#>hidden_glen_look_at_fence_message
	jmp	finish_parse_message

	;==============
	; look at tree
hidden_glen_look_at_tree:
	ldx	#<hidden_glen_look_at_tree_message
	ldy	#>hidden_glen_look_at_tree_message
	jmp	finish_parse_message

	;=================
	; climb
	;=================

hidden_glen_climb:

	lda	CURRENT_NOUN

	cmp	#NOUN_TREE
	beq	hidden_glen_climb_tree
	cmp	#NOUN_FENCE
	beq	hidden_glen_climb_fence

	jmp	parse_common_unknown

hidden_glen_climb_tree:
	ldx	#<hidden_glen_climb_tree_message
	ldy	#>hidden_glen_climb_tree_message
	jmp	finish_parse_message

hidden_glen_climb_fence:
	ldx	#<hidden_glen_climb_fence_message
	ldy	#>hidden_glen_climb_fence_message
	jmp	finish_parse_message


	;=================
	; get
	;=================

hidden_glen_get:

	lda	CURRENT_NOUN

	cmp	#NOUN_ARROW
	beq	hidden_glen_get_arrow

	jmp	parse_common_get


hidden_glen_get_arrow:
	lda	GAME_STATE_0
	and	#HALDO_TO_DONGOLEV
	bne	hidden_glen_get_arrow_dongolev_gone

hidden_glen_get_arrow_dongolev_shooting:
	; walk on over
	ldx	#<hidden_glen_active_range_message
	ldy	#>hidden_glen_active_range_message
	jsr	partial_message_step

	; this kills you
	lda	#LOAD_GAME_OVER
	sta	WHICH_LOAD

	lda	#NEW_FROM_DISK
	sta	LEVEL_OVER

	ldx	#<hidden_glen_active_range_message2
	ldy	#>hidden_glen_active_range_message2
	jsr	partial_message_step

	ldx	#<hidden_glen_active_range_message3
	ldy	#>hidden_glen_active_range_message3
	jmp	finish_parse_message



hidden_glen_get_arrow_dongolev_gone:
	; see if already have arrow
	lda	INVENTORY_1
	and	#INV1_ARROW
	beq	hidden_glen_yes_get_arrow

	; see if have arrow but it is gone
	lda	INVENTORY_1_GONE
	and	#INV1_ARROW
	bne	hidden_glen_get_another

hidden_glen_all_full_up:
	ldx	#<hidden_glen_get_arrow_full_message
	ldy	#>hidden_glen_get_arrow_full_message
	jmp	finish_parse_message

hidden_glen_get_another:
	ldx	#<hidden_glen_get_arrow_another_message
	ldy	#>hidden_glen_get_arrow_another_message
	jmp	finish_parse_message

hidden_glen_yes_get_arrow:
	; add 2 points to score
	lda	#2
	jsr	score_points

	; get arrow
	lda	INVENTORY_1
	ora	#INV1_ARROW
	sta	INVENTORY_1

	ldx	#<hidden_glen_get_arrow_message
	ldy	#>hidden_glen_get_arrow_message
	jmp	finish_parse_message


	;=================
	; talk
	;=================

hidden_glen_talk:
	; only say HALDO.  Wastes noun slot

	lda	CURRENT_NOUN

	cmp	#NOUN_ARCHER
	beq	hidden_glen_talk_archer
	cmp	#NOUN_DONGOLEV
	beq	hidden_glen_talk_archer
	cmp	#NOUN_NONE
	beq	hidden_glen_talk_archer

	jmp	parse_common_talk

hidden_glen_talk_archer:

	lda	GAME_STATE_0
	and	#HALDO_TO_DONGOLEV
	beq	hidden_glen_talk_archer_there

	jmp	parse_common_talk

hidden_glen_talk_archer_there:
	ldx	#<hidden_glen_talk_archer_message
	ldy	#>hidden_glen_talk_archer_message
	jmp	finish_parse_message


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
	.byte VERB_LOOK
	.word inside_nn_look-1
	.byte VERB_OPEN
	.word inside_nn_open-1
	.byte VERB_CLOSE
	.word inside_nn_close-1
	.byte VERB_GET
	.word inside_nn_get-1
	.byte VERB_TAKE
	.word inside_nn_take-1
	.byte VERB_STEAL
	.word inside_nn_steal-1
	.byte 0

	;================
	; get
	;================
inside_nn_get:
inside_nn_steal:
inside_nn_take:
	lda	CURRENT_NOUN

	cmp	#NOUN_ROBE
	beq	inside_nn_get_robe
	cmp	#NOUN_DRESSER
	beq	inside_nn_get_dresser
	cmp	#NOUN_DRAWER
	beq	inside_nn_get_drawer
	cmp	#NOUN_BROOM
	beq	inside_nn_get_broom

	; else "probably wish" message

	jmp	parse_common_get

inside_nn_get_robe:
	; first see if drawer closed

	lda	GAME_STATE_2
	and	#DRESSER_OPEN
	beq	inside_nn_get_robe_drawer_closed

	; next see if already have it

	lda	INVENTORY_2
	and	#INV2_ROBE
	beq	inside_nn_actually_get_robe

inside_nn_get_robe_already_have:
	ldx	#<inside_nn_get_robe_already_message
	ldy	#>inside_nn_get_robe_already_message
	jmp	finish_parse_message

inside_nn_get_robe_drawer_closed:
	ldx	#<inside_nn_get_robe_drawer_closed_message
	ldy	#>inside_nn_get_robe_drawer_closed_message
	jmp	finish_parse_message


inside_nn_actually_get_robe:

	; get 10 pts

	lda	#$10
	jsr	score_points

	; get robe

	lda	INVENTORY_2
	ora	#INV2_ROBE
	sta	INVENTORY_2

	ldx	#<inside_nn_get_robe_message
	ldy	#>inside_nn_get_robe_message
	jmp	finish_parse_message


inside_nn_get_dresser:
inside_nn_get_drawer:
	ldx	#<inside_nn_get_dresser_message
	ldy	#>inside_nn_get_dresser_message
	jmp	finish_parse_message

inside_nn_get_broom:
	ldx	#<inside_nn_get_broom_message
	ldy	#>inside_nn_get_broom_message
	jmp	finish_parse_message


	;=================
	; look
	;=================

inside_nn_look:

	lda	CURRENT_NOUN

	cmp	#NOUN_BROOM
	beq	inside_nn_look_broom
	cmp	#NOUN_DRAWER
	beq	inside_nn_look_drawer
	cmp	#NOUN_DRESSER
	beq	inside_nn_look_dresser

	cmp	#NOUN_NONE
	beq	inside_nn_look_at

	jmp	parse_common_look

inside_nn_look_at:
	ldx	#<inside_nn_look_at_message
	ldy	#>inside_nn_look_at_message
	jmp	finish_parse_message

inside_nn_look_broom:
	ldx	#<inside_nn_look_brook_message
	ldy	#>inside_nn_look_brook_message
	jmp	finish_parse_message

inside_nn_look_dresser:
inside_nn_look_drawer:
	lda	GAME_STATE_2
	and	#DRESSER_OPEN
	bne	inside_nn_look_drawer_open

inside_nn_look_drawer_closed:

	ldx	#<inside_nn_look_closed_drawer_message
	ldy	#>inside_nn_look_closed_drawer_message
	jmp	finish_parse_message

inside_nn_look_drawer_open:
	lda	INVENTORY_2
	and	#INV2_ROBE
	bne	inside_nn_look_drawer_open_norobe

inside_nn_look_drawer_open_robe:
	ldx	#<inside_nn_look_open_drawer_message
	ldy	#>inside_nn_look_open_drawer_message
	jmp	finish_parse_message

inside_nn_look_drawer_open_norobe:
	ldx	#<inside_nn_look_norobe_drawer_message
	ldy	#>inside_nn_look_norobe_drawer_message
	jmp	finish_parse_message



	;================
	; open
	;================
inside_nn_open:
	lda	CURRENT_NOUN

	cmp	#NOUN_DRAWER
	beq	inside_nn_open_drawer
	cmp	#NOUN_DRESSER
	beq	inside_nn_open_drawer

	jmp	parse_common_unknown

inside_nn_open_drawer:
	; first check to see if it's already open

	lda	GAME_STATE_2
	and	#DRESSER_OPEN
	bne	inside_nn_open_drawer_already_open

	; see if robe has been taken

	lda	INVENTORY_2
	and	#INV2_ROBE
	beq	inside_nn_open_drawer_closed_full

inside_nn_open_drawer_closed_empty:
	ldx	#<inside_nn_open_empty_drawer_message
	ldy	#>inside_nn_open_empty_drawer_message
	jmp	finish_parse_message

inside_nn_open_drawer_closed_full:
	; open the drawer

	lda	GAME_STATE_2
	ora	#DRESSER_OPEN
	sta	GAME_STATE_2

	ldx	#<inside_nn_open_closed_drawer_message
	ldy	#>inside_nn_open_closed_drawer_message
	jmp	finish_parse_message

inside_nn_open_drawer_already_open:
	ldx	#<inside_nn_open_open_drawer_message
	ldy	#>inside_nn_open_open_drawer_message
	jmp	finish_parse_message

	;================
	; close
	;================
inside_nn_close:
	lda	CURRENT_NOUN

	cmp	#NOUN_DRAWER
	beq	inside_nn_close_drawer
	cmp	#NOUN_DRESSER
	beq	inside_nn_close_drawer

	jmp	parse_common_unknown

inside_nn_close_drawer:
	; first check to see if it's open

	lda	GAME_STATE_2
	and	#DRESSER_OPEN
	bne	inside_nn_close_drawer_open

inside_nn_close_drawer_closed:
	ldx	#<inside_nn_close_closed_drawer_message
	ldy	#>inside_nn_close_closed_drawer_message
	jmp	finish_parse_message

inside_nn_close_drawer_open:

	; regardless, we close the drawer

	lda	GAME_STATE_2
	and	#<(~DRESSER_OPEN)
	sta	GAME_STATE_2

	; see if robe has been taken

	lda	INVENTORY_2
	and	#INV2_ROBE
	beq	inside_nn_close_drawer_full

inside_nn_close_drawer_empty:
	; get 1 pt

	lda	#1
	jsr	score_points

	ldx	#<inside_nn_close_empty_drawer_message
	ldy	#>inside_nn_close_empty_drawer_message
	jmp	finish_parse_message

inside_nn_close_drawer_full:

	ldx	#<inside_nn_close_full_drawer_message
	ldy	#>inside_nn_close_full_drawer_message
	jmp	finish_parse_message




.include "dialog_inside.inc"
