.include "tokens.inc"

	;=======================
	;=======================
	;=======================
	; Gary the Horse
	;=======================
	;=======================
	;=======================

gary_verb_table:
	.byte VERB_BREAK
	.word gary_break-1
	.byte VERB_CLIMB
	.word gary_climb-1
	.byte VERB_FEED
	.word gary_feed-1
	.byte VERB_GET
	.word gary_get-1
	.byte VERB_JUMP
	.word gary_jump-1
	.byte VERB_KICK
	.word gary_kick-1
	.byte VERB_KILL
	.word gary_kill-1
	.byte VERB_LOOK
	.word gary_look-1
	.byte VERB_PET
	.word gary_pet-1
	.byte VERB_PUNCH
	.word gary_punch-1
	.byte VERB_SIT
	.word gary_sit-1
	.byte VERB_RIDE
	.word gary_ride-1
	.byte VERB_SCARE
	.word gary_scare-1
	.byte VERB_TALK
	.word gary_talk-1
	.byte VERB_WEAR
	.word gary_wear-1
	.byte 0

	;================
	; break
	;================
gary_sit:
gary_break:
	lda	CURRENT_NOUN

	cmp	#NOUN_STUMP
	beq	gary_sit_stump

	jmp	parse_common_unknown

gary_sit_stump:
	jmp	gary_look_at_stump

	;================
	; climb
	;================
gary_jump:
gary_climb:
	lda	CURRENT_NOUN

	cmp	#NOUN_FENCE
	beq	gary_climb_fence

	jmp	parse_common_unknown

gary_climb_fence:
	ldx	#<gary_climb_fence_message
	ldy	#>gary_climb_fence_message
	jmp	finish_parse_message


	;================
	; feed
	;================
gary_feed:
	lda	CURRENT_NOUN

	cmp	#NOUN_GARY
	beq	gary_feed_horse
	cmp	#NOUN_HORSE
	beq	gary_feed_horse

	jmp	parse_common_unknown

gary_feed_horse:
	ldx	#<gary_feed_horse_message
	ldy	#>gary_feed_horse_message
	jmp	finish_parse_message


	;================
	; get
	;================
gary_get:
	lda	CURRENT_NOUN

	cmp	#NOUN_FLIES
	beq	gary_get_flies

	; else "probably wish" message

	jmp	parse_common_get

gary_get_flies:
	ldx	#<gary_get_flies_message
	ldy	#>gary_get_flies_message
	jmp	finish_parse_message

	;===================
	; kick/kill/punch
	;===================

gary_kick:
gary_kill:
gary_punch:

	lda	CURRENT_NOUN

	cmp	#NOUN_GARY
	beq	kick_gary
	cmp	#NOUN_HORSE
	beq	kick_gary

	cmp	#NOUN_FLIES
	beq	kick_flies

	cmp	#NOUN_STUMP
	beq	kick_stump

	jmp	parse_common_unknown

kick_gary:
	; TODO: this kills you
	ldx	#<gary_kick_horse_message
	ldy	#>gary_kick_horse_message
	jsr	partial_message_step

	ldx	#<gary_kick_horse_message2
	ldy	#>gary_kick_horse_message2
	jmp	finish_parse_message

kick_flies:
	ldx	#<gary_kick_flies_message
	ldy	#>gary_kick_flies_message
	jmp	finish_parse_message

kick_stump:
	ldx	#<gary_kick_stump_message
	ldy	#>gary_kick_stump_message
	jmp	finish_parse_message

	;=================
	; look
	;=================

gary_look:

	lda	CURRENT_NOUN

	cmp	#NOUN_FENCE
	beq	gary_look_at_fence
	cmp	#NOUN_FLIES
	beq	gary_look_at_flies
	cmp	#NOUN_GARY
	beq	gary_look_at_horse
	cmp	#NOUN_HORSE
	beq	gary_look_at_horse
	cmp	#NOUN_STUMP
	beq	gary_look_at_stump

	cmp	#NOUN_NONE
	beq	gary_look_at

	jmp	parse_common_look

gary_look_at:
	ldx	#<gary_look_message
	ldy	#>gary_look_message
	jmp	finish_parse_message

gary_look_at_fence:
	ldx	#<gary_look_fence_message
	ldy	#>gary_look_fence_message
	jmp	finish_parse_message

gary_look_at_flies:
	ldx	#<gary_look_flies_message
	ldy	#>gary_look_flies_message
	jmp	finish_parse_message

gary_look_at_gary:
gary_look_at_horse:
	ldx	#<gary_look_horse_message
	ldy	#>gary_look_horse_message
	jmp	finish_parse_message

gary_look_at_stump:
	ldx	#<gary_look_stump_message
	ldy	#>gary_look_stump_message
	jmp	finish_parse_message

	;================
	; pet
	;================
gary_pet:
	lda	CURRENT_NOUN

	cmp	#NOUN_GARY
	beq	gary_pet_horse
	cmp	#NOUN_HORSE
	beq	gary_pet_horse

	jmp	parse_common_unknown

gary_pet_horse:
	ldx	#<gary_pet_horse_message
	ldy	#>gary_pet_horse_message
	jmp	finish_parse_message


	;================
	; ride
	;================
gary_ride:
	lda	CURRENT_NOUN

	cmp	#NOUN_GARY
	beq	gary_ride_horse
	cmp	#NOUN_HORSE
	beq	gary_ride_horse

	jmp	parse_common_unknown

gary_ride_horse:
	ldx	#<gary_ride_horse_message
	ldy	#>gary_ride_horse_message
	jmp	finish_parse_message

	;================
	; scare
	;================
gary_scare:
	lda	CURRENT_NOUN

	cmp	#NOUN_GARY
	beq	gary_scare_horse
	cmp	#NOUN_HORSE
	beq	gary_scare_horse

	jmp	parse_common_unknown

	; FIXME: randomly pick from 3 choices
gary_scare_horse:
	ldx	#<gary_scare_horse_message1
	ldy	#>gary_scare_horse_message1
	jmp	finish_parse_message



	;================
	; talk
	;================
gary_talk:
	lda	CURRENT_NOUN

	cmp	#NOUN_GARY
	beq	gary_talk_horse
	cmp	#NOUN_HORSE
	beq	gary_talk_horse
	cmp	#NOUN_STUMP
	beq	gary_look_at_stump
	cmp	#NOUN_NONE
	beq	gary_talk_horse

	jmp	parse_common_talk

gary_talk_horse:
	ldx	#<gary_talk_message
	ldy	#>gary_talk_message
	jmp	finish_parse_message


	;===================
	; wear mask
	;===================

gary_wear:

	lda	CURRENT_NOUN

	cmp	#NOUN_MASK
	beq	wear_mask

	jmp	parse_common_unknown

wear_mask:
	jmp	parse_common_unknown





.if 0
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

	; add 1 point to score
	; make noise
	; but after the below somehow?

	ldx	#<archery_talk_mendelev3_message
	ldy	#>archery_talk_mendelev3_message
	jmp	finish_parse_message


archery_talk_too_far:
	ldx	#<archery_talk_far_message
	ldy	#>archery_talk_far_message
	jmp	finish_parse_message



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
.endif

.include "dialog_peasant1.inc"
