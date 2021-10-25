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






	;=======================
	;=======================
	;=======================
	; Kerrek
	;=======================
	;=======================
	;=======================

.include "kerrek_actions.s"



	;=======================
	;=======================
	;=======================
	; Wishing Well
	;=======================
	;=======================
	;=======================

wishing_well_verb_table:
	.byte VERB_CLIMB
	.word well_climb-1
	.byte VERB_GET
	.word well_get-1
	.byte VERB_LOOK
	.word well_look-1
	.byte VERB_MAKE
	.word well_make-1
	.byte VERB_PUT
	.word well_put-1
	.byte VERB_STEAL
	.word well_get-1
	.byte VERB_TAKE
	.word well_get-1
	.byte VERB_TALK
	.word well_talk-1
	.byte VERB_THROW
	.word well_throw-1
	.byte VERB_TURN
	.word well_turn-1
	.byte 0


	;=================
	; look
	;=================

well_look:

	lda	CURRENT_NOUN

	cmp	#NOUN_IN_WELL
	beq	well_look_in_well
	cmp	#NOUN_WELL
	beq	well_look_at_well
	cmp	#NOUN_TREE
	beq	well_look_at_tree
	cmp	#NOUN_CRANK
	beq	well_look_at_crank
	cmp	#NOUN_BUCKET
	beq	well_look_at_bucket
	cmp	#NOUN_NONE
	beq	well_look_at

	jmp	parse_common_look

well_look_at:
	ldx	#<well_look_at_message
	ldy	#>well_look_at_message
	jmp	finish_parse_message

well_look_at_well:
	ldx	#<well_look_at_well_message
	ldy	#>well_look_at_well_message
	jsr	partial_message_step

	ldx	#<well_look_at_well_message2
	ldy	#>well_look_at_well_message2
	jmp	finish_parse_message

well_look_at_crank:
	ldx	#<well_look_at_crank_message
	ldy	#>well_look_at_crank_message
	jmp	finish_parse_message

well_look_in_well:
	ldx	#<well_look_in_well_message
	ldy	#>well_look_in_well_message
	jmp	finish_parse_message

well_look_at_tree:
	ldx	#<well_look_at_tree_message
	ldy	#>well_look_at_tree_message
	jmp	finish_parse_message

well_look_at_bucket:
	ldx	#<well_look_at_bucket_message
	ldy	#>well_look_at_bucket_message
	jmp	finish_parse_message

	;================
	; make
	;================
well_make:

	lda	CURRENT_NOUN

	cmp	#NOUN_WISH
	beq	well_make_wish

	jmp	parse_common_unknown

well_make_wish:
	ldx	#<well_make_wish_message
	ldy	#>well_make_wish_message
	jmp	finish_parse_message

	;================
	; climb
	;================
well_climb:

	lda	CURRENT_NOUN

	cmp	#NOUN_BUCKET
	beq	well_climb_bucket
	cmp	#NOUN_WELL
	beq	well_climb_well
	cmp	#NOUN_IN_WELL
	beq	well_climb_well

	jmp	parse_common_climb

well_climb_bucket:
	ldx	#<well_climb_bucket_message
	ldy	#>well_climb_bucket_message
	jmp	finish_parse_message

well_climb_well:
	ldx	#<well_climb_well_message
	ldy	#>well_climb_well_message
	jmp	finish_parse_message


	;================
	; get
	;================
well_get:

	lda	CURRENT_NOUN

	cmp	#NOUN_BUCKET
	beq	well_get_bucket

	jmp	parse_common_get

well_get_bucket:
	ldx	#<well_get_bucket_message
	ldy	#>well_get_bucket_message
	jmp	finish_parse_message

	;================
	; talk
	;================
well_talk:

	lda	CURRENT_NOUN

	cmp	#NOUN_WELL
	beq	well_talk_well

	jmp	parse_common_unknown

well_talk_well:
	ldx	#<well_talk_message
	ldy	#>well_talk_message
	jmp	finish_parse_message


	;================
	; throw
	;================
well_throw:

	lda	CURRENT_NOUN

	cmp	#NOUN_BABY
	beq	well_throw_baby

	jmp	parse_common_unknown

well_throw_baby:
	ldx	#<well_throw_baby_message
	ldy	#>well_throw_baby_message
	jmp	finish_parse_message


	;================
	; turn
	;================
well_turn:

	lda	CURRENT_NOUN

	cmp	#NOUN_CRANK
	beq	well_turn_crank

	jmp	parse_common_unknown

well_turn_crank:
	ldx	#<well_turn_crank_message
	ldy	#>well_turn_crank_message
	jmp	finish_parse_message


	;================
	; put
	;================
	; FIXME: need to find object here
	;	put baby (where)?
	;	put pebbles (in well, in bucket?)
well_put:

	lda	CURRENT_NOUN

	cmp	#NOUN_BABY
	beq	well_throw_baby

	bne	well_put_anything_else

	; do we need to check for bucket at end?
well_put_anything_else:
	ldx	#<well_put_anything_message
	ldy	#>well_put_anything_message
	jmp	finish_parse_message




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


	;=======================
	;=======================
	;=======================
	; waterfall
	;=======================
	;=======================
	;=======================

waterfall_verb_table:
	.byte VERB_LOOK
	.word waterfall_look-1
	.byte VERB_SWIM
	.word waterfall_swim-1
	.byte 0

	;=================
	; look
	;=================

waterfall_look:

	lda	CURRENT_NOUN

	cmp	#NOUN_TREE
	beq	waterfall_look_tree
	cmp	#NOUN_WATERFALL
	beq	waterfall_look_waterfall

	cmp	#NOUN_NONE
	beq	waterfall_look_at

	jmp	parse_common_look

waterfall_look_at:
	ldx	#<waterfall_look_at_message
	ldy	#>waterfall_look_at_message
	jmp	finish_parse_message

waterfall_look_tree:
	ldx	#<waterfall_look_tree_message
	ldy	#>waterfall_look_tree_message
	jmp	finish_parse_message

waterfall_look_waterfall:
	ldx	#<waterfall_look_waterfall_message
	ldy	#>waterfall_look_waterfall_message
	jmp	finish_parse_message

	;=================
	; swim
	;=================

waterfall_swim:

	lda	CURRENT_NOUN

	cmp	#NOUN_WATER
	beq	waterfall_swim_water
	cmp	#NOUN_WATERFALL
	beq	waterfall_swim_water
	cmp	#NOUN_NONE
	beq	waterfall_swim_water

	jmp	parse_common_unknown

waterfall_swim_water:
	ldx	#<waterfall_swim_message
	ldy	#>waterfall_swim_message
	jmp	finish_parse_message



.include "dialog_peasant1.inc"
