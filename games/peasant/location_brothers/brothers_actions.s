.include "../tokens.inc"

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



.include "../text/dialog_brothers.inc"
