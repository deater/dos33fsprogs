.include "tokens.inc"

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



	;=======================
	;=======================
	;=======================
	; Puddle
	;=======================
	;=======================
	;=======================

puddle_verb_table:
	.byte VERB_GET
	.word puddle_get-1
	.byte VERB_TAKE
	.word puddle_take-1
	.byte VERB_STEAL
	.word puddle_steal-1
	.byte VERB_LOOK
	.word puddle_look-1
	.byte 0


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
	cmp	#NOUN_MUD
	beq	puddle_get_mud
	cmp	#NOUN_PUDDLE
	beq	puddle_get_mud


	; else "probably wish" message

	jmp	parse_common_get

puddle_get_rock:
	ldx	#<puddle_get_rock_message
	ldy	#>puddle_get_rock_message
	jmp	finish_parse_message

puddle_get_mud:
	lda	GAME_STATE_1
	and	#PUDDLE_WET
	bne	puddle_get_mud_wet

	jmp	parse_common_get

puddle_get_mud_wet:
	lda	GAME_STATE_2
	and	#COVERED_IN_MUD
	bne	puddle_get_mud_wet_dirty

puddle_get_mud_wet_clean:
	ldx	#<puddle_get_mud_wet_clean_message
	ldy	#>puddle_get_mud_wet_clean_message
	jmp	finish_parse_message

puddle_get_mud_wet_dirty:
	ldx	#<puddle_get_mud_wet_dirty_message
	ldy	#>puddle_get_mud_wet_dirty_message
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
	lda	GAME_STATE_1
	and	#PUDDLE_WET
	bne	puddle_look_at_wet

puddle_look_at_dry:
	ldx	#<puddle_look_at_dry_message
	ldy	#>puddle_look_at_dry_message
	jmp	finish_parse_message

puddle_look_at_wet:
	ldx	#<puddle_look_at_wet_message
	ldy	#>puddle_look_at_wet_message
	jmp	finish_parse_message

puddle_look_at_mud:
	lda	GAME_STATE_1
	and	#PUDDLE_WET
	bne	puddle_look_at_mud_wet
puddle_look_at_mud_dry:
	ldx	#<puddle_look_mud_dry_message
	ldy	#>puddle_look_mud_dry_message
	jmp	finish_parse_message

puddle_look_at_mud_wet:
	ldx	#<puddle_look_mud_wet_message
	ldy	#>puddle_look_mud_wet_message
	jmp	finish_parse_message

puddle_look_at_rock:
	ldx	#<puddle_get_rock_message
	ldy	#>puddle_get_rock_message
	jmp	finish_parse_message


	;=======================
	;=======================
	;=======================
	; Archery
	;=======================
	;=======================
	;=======================

archery_verb_table:
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
	.byte 0


	;================
	; ask
	;================
archery_ask:
	lda	GAME_STATE_0
	and	#HALDO_TO_DONGOLEV
	bne	archery_ask_after_haldo

	jmp	parse_common_ask

archery_ask_after_haldo:
	lda	CURRENT_NOUN

	cmp	#NOUN_FIRE
	beq	archery_ask_about_fire
	cmp	#NOUN_NED
	beq	archery_ask_about_ned
	cmp	#NOUN_SMELL
	beq	archery_ask_about_smell
	cmp	#NOUN_ROBE
	beq	archery_ask_about_robe
	cmp	#NOUN_TROGDOR
	beq	archery_ask_about_trogdor

archery_ask_about_unknown:
	ldx	#<archery_ask_about_unknown_message
	ldy	#>archery_ask_about_unknown_message
	jmp	finish_parse_message

archery_ask_about_fire:
	ldx	#<archery_ask_about_fire_message
	ldy	#>archery_ask_about_fire_message
	jsr	partial_message_step

	ldx	#<archery_ask_about_fire_message2
	ldy	#>archery_ask_about_fire_message2
	jsr	partial_message_step

	ldx	#<archery_ask_about_fire_message3
	ldy	#>archery_ask_about_fire_message3
	jsr	partial_message_step

	ldx	#<archery_ask_about_fire_message4
	ldy	#>archery_ask_about_fire_message4
	jmp	finish_parse_message

archery_ask_about_ned:
	ldx	#<archery_ask_about_ned_message
	ldy	#>archery_ask_about_ned_message
	jmp	finish_parse_message

archery_ask_about_robe:
	ldx	#<archery_ask_about_robe_message
	ldy	#>archery_ask_about_robe_message
	jmp	finish_parse_message

archery_ask_about_smell:
	ldx	#<archery_ask_about_smell_message
	ldy	#>archery_ask_about_smell_message
	jmp	finish_parse_message

archery_ask_about_trogdor:
	ldx	#<archery_ask_about_trogdor_message
	ldy	#>archery_ask_about_trogdor_message
	jsr	partial_message_step

	ldx	#<archery_ask_about_trogdor_message2
	ldy	#>archery_ask_about_trogdor_message2
	jsr	partial_message_step

	ldx	#<archery_ask_about_trogdor_message3
	ldy	#>archery_ask_about_trogdor_message3
	jsr	partial_message_step

	ldx	#<archery_ask_about_trogdor_message4
	ldy	#>archery_ask_about_trogdor_message4
	jsr	partial_message_step

	ldx	#<archery_ask_about_trogdor_message5
	ldy	#>archery_ask_about_trogdor_message5
	jsr	partial_message_step

	ldx	#<archery_ask_about_trogdor_message6
	ldy	#>archery_ask_about_trogdor_message6
	jmp	finish_parse_message


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

	lda	CURRENT_NOUN

	cmp	#NOUN_TRINKET
	beq	archery_give_trinket

	jmp	parse_common_give

archery_give_trinket:
	; only if dongolev there
	lda	GAME_STATE_0
	and	#HALDO_TO_DONGOLEV
	beq	archery_no_give

	; check if already gave it
	lda	GAME_STATE_0
	and	#TRINKET_GIVEN
	bne	archery_give_trinket_again

	; be sure we have it
	lda	INVENTORY_2
	and	#INV2_TRINKET
	bne	archery_give_trinket_first

	; otherwise, default
archery_no_give:
	jmp	parse_common_give

archery_give_trinket_first:

	; score 2 points
	lda	#2
	jsr	score_points

	; set trinket given game state
	lda	GAME_STATE_0
	ora	#TRINKET_GIVEN
	sta	GAME_STATE_0

	; mark us no longer having it
	lda	INVENTORY_2_GONE
	ora	#INV2_TRINKET
	sta	INVENTORY_2_GONE

	ldx	#<archery_give_trinket_message
	ldy	#>archery_give_trinket_message
	jsr	partial_message_step

	jmp	archery_play_game2


archery_give_trinket_again:
	ldx	#<archery_give_trinket_again_message
	ldy	#>archery_give_trinket_again_message
	jmp	finish_parse_message


	;================
	; haldo
	;================
archery_haldo:

	lda	GAME_STATE_0
	and	#HALDO_TO_DONGOLEV
	bne	archery_haldo_after_haldo

	jmp	parse_common_haldo

archery_haldo_after_haldo:
	ldx	#<archery_haldo_message
	ldy	#>archery_haldo_message
	jmp	finish_parse_message

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
	; first check if we've talked to mendelev
	lda	GAME_STATE_0
	and	#TALKED_TO_MENDELEV
	beq	archery_look_at_archer_before

	lda	GAME_STATE_0
	and	#HALDO_TO_DONGOLEV
	beq	archery_look_at_archer_after

archery_look_at_otherwise:
	ldx	#<archery_look_at_archer_otherwise_message
	ldy	#>archery_look_at_archer_otherwise_message
	jmp	finish_parse_message

archery_look_at_archer_before:
	ldx	#<archery_look_at_archer_message
	ldy	#>archery_look_at_archer_message
	jmp	finish_parse_message

archery_look_at_archer_after:
	ldx	#<archery_look_at_archer_sponge_message
	ldy	#>archery_look_at_archer_sponge_message
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
	beq	archery_check_play_game

	jmp	parse_common_unknown

archery_check_play_game:

	lda	GAME_STATE_0
	and	#ARROW_BEATEN
	bne	archery_play_game_arrow_beaten

	lda	GAME_STATE_0
	and	#TRINKET_GIVEN
	bne	archery_play_game

archery_play_game_closed:
	ldx	#<archery_play_game_closed_message
	ldy	#>archery_play_game_closed_message
	jmp	finish_parse_message

archery_play_game_arrow_beaten:
	jmp	archery_after_minigame

archery_play_game:

	ldx	#<archery_play_game_message
	ldy	#>archery_play_game_message
	jsr	partial_message_step

archery_play_game2:
	ldx	#<archery_play_game_message2
	ldy	#>archery_play_game_message2
	jsr	partial_message_step

	; play game

	lda     #LOCATION_ARCHERY_GAME
	jsr	update_map_location

	; FIXME: make random
	lda	#$30
	sta	ARROW_SCORE

	rts


	;================
	; talk
	;================
archery_talk:
	; before talk, only will talk if close enough
	; after talk mendelev, gives talk to brother message
	; after dongolev back, ???


	; only talk if close
	lda	PEASANT_X
	cmp	#23
	bcs	archery_talk_close
	; check Y too?
	; probably less than $7D?
	; actual game will walk you in if close
	; will it work from beind?

archery_talk_too_far:
	ldx	#<archery_talk_far_message
	ldy	#>archery_talk_far_message
	jmp	finish_parse_message

archery_talk_close:
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
	cmp	#NOUN_DONGOLEV
	beq	archery_talk_dongolev
	cmp	#NOUN_NONE
	beq	archery_talk_mendelev

	jmp	parse_common_unknown

archery_talk_dongolev:
	lda	GAME_STATE_0
	and	#HALDO_TO_DONGOLEV
	bne	archery_yes_dongolev

	jmp	parse_common_talk

archery_talk_mendelev:
	lda	GAME_STATE_0
	and	#TALKED_TO_MENDELEV
	beq	archery_no_mendelev_yet
	lda	GAME_STATE_0
	and	#HALDO_TO_DONGOLEV
	beq	archery_yes_mendelev_no_dongolev

archery_yes_dongolev:
	; three options, before trinket, after trinket, after minigame
	lda	GAME_STATE_0
	and	#ARROW_BEATEN
	bne	archery_after_minigame

	lda	GAME_STATE_0
	and	#TRINKET_GIVEN
	bne	archery_after_trinket

archery_before_trinket:
	ldx	#<archery_talk_before_minigame_message
	ldy	#>archery_talk_before_minigame_message
	jmp	finish_parse_message

archery_after_trinket:
	jmp	archery_play_game

archery_after_minigame:
	ldx	#<archery_talk_after_minigame_message
	ldy	#>archery_talk_after_minigame_message
	jmp	finish_parse_message


archery_yes_mendelev_no_dongolev:
	ldx	#<archery_talk_mendelev_between_message
	ldy	#>archery_talk_mendelev_between_message
	jmp	finish_parse_message


archery_no_mendelev_yet:

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




	;=======================
	;=======================
	;=======================
	; River and Stone
	;=======================
	;=======================
	;=======================

river_stone_verb_table:
        .byte VERB_GET
        .word river_stone_get-1
        .byte VERB_LOOK
        .word river_stone_look-1
        .byte VERB_STEAL
        .word river_stone_steal-1
        .byte VERB_SWIM
        .word river_stone_swim-1
        .byte VERB_TAKE
        .word river_stone_take-1
	.byte 0


	;================
	; get
	;================
river_stone_steal:
river_stone_take:
river_stone_get:
	lda	CURRENT_NOUN

	cmp	#NOUN_ROCK
	beq	river_get_rock
	cmp	#NOUN_STONE
	beq	river_get_rock

	; else "probably wish" message

	jmp	parse_common_get

river_get_rock:
	ldx	#<river_get_rock_message
	ldy	#>river_get_rock_message
	jmp	finish_parse_message

	;=================
	; look
	;=================

river_stone_look:

	lda	CURRENT_NOUN

	cmp	#NOUN_ROCK
	beq	river_look_at_rock
	cmp	#NOUN_STONE
	beq	river_look_at_rock
	cmp	#NOUN_WATER
	beq	river_look_at_water
	cmp	#NOUN_RIVER
	beq	river_look_at_water
	cmp	#NOUN_NONE
	beq	river_look_at

	jmp	parse_common_look

river_look_at:
	ldx	#<river_look_message
	ldy	#>river_look_message
	jmp	finish_parse_message

river_look_at_rock:
	ldx	#<river_look_at_rock_message
	ldy	#>river_look_at_rock_message
	jmp	finish_parse_message

river_look_at_water:
	ldx	#<river_look_at_water_message
	ldy	#>river_look_at_water_message
	jmp	finish_parse_message



	;===================
	; swim
	;===================

river_stone_swim:

	lda	CURRENT_NOUN

	cmp	#NOUN_WATER
	beq	river_swim
	cmp	#NOUN_RIVER
	beq	river_swim
	cmp	#NOUN_ROCK
	beq	river_swim
	cmp	#NOUN_STONE
	beq	river_swim

	jmp	parse_common_unknown

river_swim:
	ldx	#<river_swim_message
	ldy	#>river_swim_message
	jmp	finish_parse_message

	;=======================
	;=======================
	;=======================
	; mountain pass
	;=======================
	;=======================
	;=======================

mountain_pass_verb_table:
        .byte VERB_ASK
        .word mountain_pass_ask-1
        .byte VERB_ATTACK
        .word mountain_pass_attack-1
        .byte VERB_BREAK
        .word mountain_pass_break-1
        .byte VERB_LOOK
        .word mountain_pass_look-1
        .byte VERB_TALK
        .word mountain_pass_talk-1
	.byte 0


	;================
	; ask
	;================
mountain_pass_ask:
	lda	CURRENT_NOUN

	cmp	#NOUN_FIRE
	beq	ask_about_fire
	cmp	#NOUN_JHONKA
	beq	ask_about_jhonka
	cmp	#NOUN_KERREK
	beq	ask_about_kerrek
	cmp	#NOUN_NED
	beq	ask_about_ned
	cmp	#NOUN_ROBE
	beq	ask_about_robe
	cmp	#NOUN_SMELL
	beq	ask_about_smell
	cmp	#NOUN_TROGDOR
	beq	ask_about_trogdor

	; else ask about unknown

ask_about_unknown:
	ldx	#<knight_ask_unknown_message
	ldy	#>knight_ask_unknown_message
	jmp	finish_parse_message

ask_about_fire:
	ldx	#<knight_ask_fire_message
	ldy	#>knight_ask_fire_message
	jmp	finish_parse_message

ask_about_jhonka:
	ldx	#<knight_ask_jhonka_message
	ldy	#>knight_ask_jhonka_message
	jmp	finish_parse_message

ask_about_kerrek:
	ldx	#<knight_ask_kerrek_message
	ldy	#>knight_ask_kerrek_message
	jmp	finish_parse_message

ask_about_ned:
	ldx	#<knight_ask_ned_message
	ldy	#>knight_ask_ned_message
	jmp	finish_parse_message

ask_about_robe:
	ldx	#<knight_ask_robe_message
	ldy	#>knight_ask_robe_message
	jmp	finish_parse_message

ask_about_smell:
	ldx	#<knight_ask_smell_message
	ldy	#>knight_ask_smell_message
	jmp	finish_parse_message

ask_about_trogdor:
	ldx	#<knight_ask_trogdor_message
	ldy	#>knight_ask_trogdor_message
	jmp	finish_parse_message



	;================
	; attack
	;================
mountain_pass_break:
mountain_pass_attack:
	lda	CURRENT_NOUN
	cmp	#NOUN_SIGN
	beq	attack_sign

	jmp	parse_common_unknown

attack_sign:
	ldx	#<attack_sign_message
	ldy	#>attack_sign_message
	jmp	finish_parse_message


	;=================
	; look
	;=================

mountain_pass_look:

	lda	CURRENT_NOUN

	cmp	#NOUN_KNIGHT
	beq	knight_look
	cmp	#NOUN_MAN
	beq	knight_look
	cmp	#NOUN_DUDE
	beq	knight_look
	cmp	#NOUN_GUY
	beq	knight_look

	cmp	#NOUN_SIGN
	beq	sign_look
	cmp	#NOUN_TROGDOR
	beq	trogdor_look
	cmp	#NOUN_NONE
	beq	pass_look

	jmp	parse_common_look

knight_look:
	ldx	#<knight_look_message
	ldy	#>knight_look_message
	jmp	finish_parse_message

pass_look:
	ldx	#<pass_look_message
	ldy	#>pass_look_message
	jmp	finish_parse_message

sign_look:
	ldx	#<sign_look_message
	ldy	#>sign_look_message
	jmp	finish_parse_message

trogdor_look:
	ldx	#<trogdor_look_message
	ldy	#>trogdor_look_message
	jmp	finish_parse_message


	;===================
	; talk
	;===================

mountain_pass_talk:

	lda	CURRENT_NOUN
	cmp	#NOUN_KNIGHT
	beq	talk_to_knight
	cmp	#NOUN_GUY
	beq	talk_to_knight
	cmp	#NOUN_MAN
	beq	talk_to_knight
	cmp	#NOUN_DUDE
	beq	talk_to_knight

	; else, no one
	jmp	parse_common_talk

talk_to_knight:

	lda	GAME_STATE_2
	and	#TALKED_TO_KNIGHT
	bne	knight_skip_text

	; first time only
	ldx	#<talk_knight_first_message
	ldy	#>talk_knight_first_message
	jsr	partial_message_step

	; first time only
	ldx	#<talk_knight_second_message
	ldy	#>talk_knight_second_message
	jsr	partial_message_step

knight_skip_text:
	; see if have belt
	lda	INVENTORY_1
	and	#INV1_KERREK_BELT
	bne	knight_kerrek_belt

	; see if have robe
	lda	GAME_STATE_1
	and	#WEARING_ROBE
	bne	knight_robe

	; else, have nothing

	ldx	#<talk_knight_third_message
	ldy	#>talk_knight_third_message
	jsr	partial_message_step

	ldx	#<talk_knight_stink_message
	ldy	#>talk_knight_stink_message
	jsr	partial_message_step

	ldx	#<talk_knight_dress_message
	ldy	#>talk_knight_dress_message
	jsr	partial_message_step

	ldx	#<talk_knight_fire_message
	ldy	#>talk_knight_fire_message
	jsr	partial_message_step

	ldx	#<talk_knight_fourth_message
	ldy	#>talk_knight_fourth_message

	lda	GAME_STATE_2
	and	#TALKED_TO_KNIGHT
	bne	knight_skip_text2

	jsr	partial_message_step

	; first time only
	ldx	#<talk_knight_fifth_message
	ldy	#>talk_knight_fifth_message

	lda	GAME_STATE_2
	ora	#TALKED_TO_KNIGHT
	sta	GAME_STATE_2

knight_skip_text2:
	jmp	finish_parse_message

knight_kerrek_belt:
	; see if also have robe
	lda	GAME_STATE_1
	and	#WEARING_ROBE
	bne	knight_belt_robe

	ldx	#<talk_knight_after_belt_message
	ldy	#>talk_knight_after_belt_message
	jmp	finish_parse_message

knight_robe:
	; see if also have belt
	lda	INVENTORY_1
	and	#INV1_KERREK_BELT
	bne	knight_belt_robe

	ldx	#<talk_knight_after_robe_message
	ldy	#>talk_knight_after_robe_message
	jmp	finish_parse_message

knight_belt_robe:
	; see if also on fire
	lda	GAME_STATE_2
	and	#ON_FIRE
	bne	knight_belt_fire

	ldx	#<talk_knight_after_robe_and_belt_message
	ldy	#>talk_knight_after_robe_and_belt_message
	jmp	finish_parse_message

knight_belt_fire:
	; TODO: move knight, open path

	; score points
	lda	#7
	jsr	score_points

	ldx	#<talk_knight_after_robe_belt_fire_message
	ldy	#>talk_knight_after_robe_belt_fire_message
	jsr	partial_message_step

	ldx	#<talk_knight_after_robe_belt_fire_message2
	ldy	#>talk_knight_after_robe_belt_fire_message2
	jmp	finish_parse_message


.include "dialog_peasant2.inc"
