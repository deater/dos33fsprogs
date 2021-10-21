.include "tokens.inc"

.if 0
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
.endif

	;=======================
	;=======================
	;=======================
	; outside Inn
	;=======================
	;=======================
	;=======================

inn_verb_table:
	.byte VERB_GET
	.word outside_inn_get-1
	.byte VERB_KNOCK
	.word outside_inn_knock-1
	.byte VERB_LOOK
	.word outside_inn_look-1
	.byte VERB_OPEN
	.word outside_inn_open-1
	.byte VERB_READ
	.word outside_inn_read-1
	.byte 0


	;================
	; get
	;================
outside_inn_get:
	lda	CURRENT_NOUN

	cmp	#NOUN_NOTE
	beq	inn_note_get

	jmp	parse_common_get

inn_note_get:
	ldx	#<outside_inn_note_get_message
	ldy	#>outside_inn_note_get_message
	jmp	finish_parse_message

	;================
	; knock
	;================
outside_inn_knock:
	lda	CURRENT_NOUN

	cmp	#NOUN_DOOR
	beq	inn_door_knock
	cmp	#NOUN_NONE
	beq	inn_door_knock

	jmp	parse_common_unknown

inn_door_knock:
	ldx	#<outside_inn_door_knock_locked_message
	ldy	#>outside_inn_door_knock_locked_message
	jmp	finish_parse_message

	;================
	; open
	;================
outside_inn_open:
	lda	CURRENT_NOUN

	cmp	#NOUN_DOOR
	beq	inn_door_open
	cmp	#NOUN_NONE
	beq	inn_door_open

	jmp	parse_common_unknown

inn_door_open:
	ldx	#<outside_inn_door_open_locked_message
	ldy	#>outside_inn_door_open_locked_message
	jmp	finish_parse_message


	;================
	; read
	;================
outside_inn_read:
	lda	CURRENT_NOUN
	cmp	#NOUN_NOTE
	beq	inn_note_look

	jmp	parse_common_unknown

	;=================
	; look
	;=================

outside_inn_look:

	lda	CURRENT_NOUN

	cmp	#NOUN_DOOR
	beq	inn_door_look
	cmp	#NOUN_INN
	beq	inn_inn_look
	cmp	#NOUN_SIGN
	beq	inn_sign_look
	cmp	#NOUN_WINDOW
	beq	inn_window_look
	cmp	#NOUN_NOTE
	beq	inn_note_look

	cmp	#NOUN_NONE
	beq	inn_look

	jmp	parse_common_look

inn_inn_look:
	ldx	#<outside_inn_inn_look_message
	ldy	#>outside_inn_inn_look_message
	jmp	finish_parse_message

inn_look:
	ldx	#<outside_inn_look_message
	ldy	#>outside_inn_look_message
	jmp	finish_parse_message

inn_door_look:
	ldx	#<outside_inn_door_look_message
	ldy	#>outside_inn_door_look_message
	jmp	finish_parse_message

inn_sign_look:
	ldx	#<outside_inn_sign_look_message
	ldy	#>outside_inn_sign_look_message
	jmp	finish_parse_message

inn_window_look:
	ldx	#<outside_inn_window_look_message
	ldy	#>outside_inn_window_look_message
	jmp	finish_parse_message

inn_note_look:
	ldx	#<outside_inn_note_look_message
	ldy	#>outside_inn_note_look_message
	jmp	finish_parse_message


.include "dialog_peasant3.inc"

