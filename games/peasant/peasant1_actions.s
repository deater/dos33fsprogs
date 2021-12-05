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
	jmp	gary_kick_stump

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
	lda	GAME_STATE_0
	and	#GARY_SCARED
	beq	gary_climb_fence_there

gary_climb_fence_gone:

	ldx	#<gary_climb_fence_gone_message
	ldy	#>gary_climb_fence_gone_message
	jmp	finish_parse_message

gary_climb_fence_there:

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
	lda	GAME_STATE_0
	and	#GARY_SCARED
	beq	gary_feed_horse_there
	jmp	parse_common_unknown

gary_feed_horse_there:
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
	lda	GAME_STATE_0
	and	#GARY_SCARED
	beq	get_flies_there
	jmp	parse_common_get
get_flies_there:
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
	beq	gary_kick_stump

	jmp	parse_common_unknown

kick_gary:
	lda	GAME_STATE_0
	and	#GARY_SCARED
	beq	kick_gary_there
	jmp	gary_scare_horse_gone

kick_gary_there:

	ldx	#<gary_kick_horse_message
	ldy	#>gary_kick_horse_message
	jsr	partial_message_step

	; this kills you
	lda	#LOAD_GAME_OVER
	sta	WHICH_LOAD

	lda	#NEW_FROM_DISK
	sta	LEVEL_OVER

	ldx	#<gary_kick_horse_message2
	ldy	#>gary_kick_horse_message2
	jmp	finish_parse_message

kick_flies:
	lda	GAME_STATE_0
	and	#GARY_SCARED
	beq	kick_flies_there
	jmp	parse_common_unknown
kick_flies_there:
	ldx	#<gary_kick_flies_message
	ldy	#>gary_kick_flies_message
	jmp	finish_parse_message

gary_kick_stump:
	ldx	#<gary_kick_stump_message
	ldy	#>gary_kick_stump_message
	jmp	finish_parse_message

	;=================
	; look
	;=================

gary_look:

	lda	GAME_STATE_0
	and	#GARY_SCARED
	beq	gary_look_pre_scare

gary_look_post_scare:

	lda	CURRENT_NOUN
	cmp	#NOUN_FENCE
	beq	gary_look_at_fence_post
	cmp	#NOUN_STUMP
	beq	gary_look_at_stump
	cmp	#NOUN_NONE			; same
	beq	gary_look_at

	jmp	parse_common_look

gary_look_at_fence_post:
	ldx	#<gary_look_fence_after_scare_message
	ldy	#>gary_look_fence_after_scare_message
	jmp	finish_parse_message

	;=================
	; pre scare
gary_look_pre_scare:
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

	; look at
gary_look_at:
	ldx	#<gary_look_message
	ldy	#>gary_look_message
	jmp	finish_parse_message

	; look at fence
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


	;===================
	; wear mask
	;===================

gary_wear:

	lda	CURRENT_NOUN

	cmp	#NOUN_MASK
	beq	wear_mask

	jmp	parse_common_unknown

wear_mask:
	; if no have mask, unknown
	; otherwise, same as if we did "scare gary"
	lda	INVENTORY_1
	and	#INV1_MONSTER_MASK
	bne	gary_scare_horse

	jmp	parse_common_unknown


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


gary_scare_horse:
	lda	GAME_STATE_0
	and	#GARY_SCARED
	bne	gary_scare_horse_gone

	lda	INVENTORY_1
	and	#INV1_MONSTER_MASK
	beq	gary_scare_horse_nomask

gary_scare_horse_mask:

	ldx	#<gary_scare_message
	ldy	#>gary_scare_message
	jsr	partial_message_step

	; get points

	lda	#2
	jsr	score_points

	lda	GAME_STATE_0
	ora	#GARY_SCARED
	sta	GAME_STATE_0

	; TODO: break fence

	ldx	#<gary_scare_message2
	ldy	#>gary_scare_message2
	jmp	finish_parse_message


gary_scare_horse_nomask:

	jsr	random16
	and	#$3		; 0..4
	beq	gary_scare_try2
	cmp	#$1
	beq	gary_scare_try3

gary_scare_try1:
	ldx	#<gary_scare_horse_message1
	ldy	#>gary_scare_horse_message1
	jmp	finish_parse_message

gary_scare_try2:
	ldx	#<gary_scare_horse_message2
	ldy	#>gary_scare_horse_message2
	jmp	finish_parse_message

gary_scare_try3:
	ldx	#<gary_scare_horse_message3
	ldy	#>gary_scare_horse_message3
	jmp	finish_parse_message

gary_scare_horse_gone:
	ldx	#<gary_gone_message
	ldy	#>gary_gone_message
	jsr	partial_message_step

	ldx	#<gary_gone_message2
	ldy	#>gary_gone_message2
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
	lda	GAME_STATE_0
	and	#GARY_SCARED
	beq	pet_horse_there
	jmp	parse_common_unknown
pet_horse_there:
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
	lda	GAME_STATE_0
	and	#GARY_SCARED
	beq	ride_horse_there
	jmp	parse_common_unknown

ride_horse_there:
	ldx	#<gary_ride_horse_message
	ldy	#>gary_ride_horse_message
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
	beq	gary_talk_stump
	cmp	#NOUN_NONE
	beq	gary_talk_horse

	jmp	parse_common_talk

gary_talk_horse:
	lda	GAME_STATE_0
	and	#GARY_SCARED
	beq	gary_talk_there
	jmp	parse_common_talk
gary_talk_there:
	ldx	#<gary_talk_message
	ldy	#>gary_talk_message
	jmp	finish_parse_message

gary_talk_stump:
	jmp	gary_kick_stump






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
	.byte VERB_USE
	.word well_use-1
	.byte VERB_DROP
	.word well_use-1
	.byte VERB_DEPLOY
	.word well_use-1
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

	lda	INVENTORY_1
	and	#INV1_MONSTER_MASK
	bne	well_look_had_mask

	ldx	#<well_look_at_well_message2
	ldy	#>well_look_at_well_message2
well_look_had_mask:
	jmp	finish_parse_message

well_look_at_crank:
	lda	INVENTORY_1_GONE
	and	#INV1_PEBBLES	; see if pebbles are gone (in bucket)
	beq	crank_no_pebbles

	ldx	#<well_look_at_crank_pebbles_message
	ldy	#>well_look_at_crank_pebbles_message
	jmp	finish_parse_message

crank_no_pebbles:
	ldx	#<well_look_at_crank_message
	ldy	#>well_look_at_crank_message
	jmp	finish_parse_message

	; look in well
well_look_in_well:
	lda	INVENTORY_1
	and	#INV1_MONSTER_MASK
	bne	look_in_well_after_mask

look_in_well_before_mask:
	ldx	#<well_look_in_well_message
	ldy	#>well_look_in_well_message
	jmp	finish_parse_message

look_in_well_after_mask:
	ldx	#<well_look_in_well_message2
	ldy	#>well_look_in_well_message2
	jmp	finish_parse_message

	; look at tree
well_look_at_tree:
	ldx	#<well_look_at_tree_message
	ldy	#>well_look_at_tree_message
	jmp	finish_parse_message

	; look at bucket
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
	; use
	;================
well_use:

	lda	CURRENT_NOUN

	cmp	#NOUN_PEBBLES
	beq	well_use_pebbles
	cmp	#NOUN_STONE
	beq	well_use_pebbles
	cmp	#NOUN_ROCK
	beq	well_use_pebbles
	cmp	#NOUN_BABY
	beq	well_use_baby

	jmp	parse_common_unknown

well_use_pebbles:
	ldx	#<well_use_pebbles_message
	ldy	#>well_use_pebbles_message
	jmp	finish_parse_message

well_use_baby:
	ldx	#<well_use_baby_message
	ldy	#>well_use_baby_message
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
	; first see if have baby

	lda	INVENTORY_1
	and	#INV1_BABY
	beq	well_throw_baby_none

	; next see if still have baby
	lda	INVENTORY_1_GONE
	and	#INV1_BABY
	bne	well_throw_baby_none

well_throw_baby_have:

	ldx	#<well_throw_baby_have_message
	ldy	#>well_throw_baby_have_message
	jmp	finish_parse_message

well_throw_baby_none:
	ldx	#<well_throw_baby_none_message
	ldy	#>well_throw_baby_none_message
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
	; check if close enough

	lda	PEASANT_X
	cmp	#25
	bcs	well_turn_crank_too_far

	; we are close enough

	; check in baby in
	lda	GAME_STATE_0
	and	#BABY_IN_WELL
	bne	well_turn_crank_baby_in

	; check if have mask

	lda	INVENTORY_1
	and	#INV1_MONSTER_MASK
	bne	well_play_with_well

	; check if pebbles in

	lda	INVENTORY_1_GONE
	and	#INV1_PEBBLES
	bne	well_turn_crank_pebbles_in

	; check if you have pebbles but not put in yet
;	lda	INVENTORY_1
;	and	#INV1_PEBBLES
	jmp	well_turn_crank_pebbles_not_in


well_play_with_well:
	lda	GAME_STATE_0
	and	#BUCKET_DOWN_WELL
	bne	well_bucket_go_up

well_bucket_go_down:
	lda	GAME_STATE_0
	eor	#BUCKET_DOWN_WELL
	sta	GAME_STATE_0

	ldx	#<well_bucket_down_message
	ldy	#>well_bucket_down_message
	jmp	finish_parse_message

well_bucket_go_up:
	lda	GAME_STATE_0
	eor	#BUCKET_DOWN_WELL
	sta	GAME_STATE_0

	ldx	#<well_bucket_up_message
	ldy	#>well_bucket_up_message
	jmp	finish_parse_message

well_turn_crank_baby_in:
	ldx	#<well_turn_crank_baby_message
	ldy	#>well_turn_crank_baby_message
	jsr	partial_message_step

	; get points

	lda	#2
	jsr	score_points

	; get sub

	lda	INVENTORY_2
	ora	#INV2_MEATBALL_SUB
	sta	INVENTORY_2

	; take baby from well

	lda	GAME_STATE_0
	and	#<(~BABY_IN_WELL)
	sta	GAME_STATE_0

	ldx	#<well_turn_crank_baby2_message
	ldy	#>well_turn_crank_baby2_message
	jmp	finish_parse_message



well_turn_crank_pebbles_in:

	ldx	#<well_turn_crank_pebbles_message
	ldy	#>well_turn_crank_pebbles_message
	jsr	partial_message_step

	; get mask

	lda	INVENTORY_1
	ora	#INV1_MONSTER_MASK
	sta	INVENTORY_1

	ldx	#<well_turn_crank_pebbles2_message
	ldy	#>well_turn_crank_pebbles2_message
	jmp	finish_parse_message

well_turn_crank_pebbles_not_in:

	ldx	#<well_turn_crank_no_pebbles_message
	ldy	#>well_turn_crank_no_pebbles_message
	jmp	finish_parse_message

	;=====================
	; turn crank, too far

well_turn_crank_too_far:

	lda	INVENTORY_1
	and	#INV1_MONSTER_MASK
	beq	well_turn_crank_too_far_before_mask

well_turn_crank_too_far_after_mask:

	ldx	#<well_turn_crank_too_far_after_message
	ldy	#>well_turn_crank_too_far_after_message
	jmp	finish_parse_message

well_turn_crank_too_far_before_mask:
	ldx	#<well_turn_crank_too_far_message
	ldy	#>well_turn_crank_too_far_message
	jmp	finish_parse_message


	;================
	; put
	;================
	; need special support for object
	;	put baby (in well, in bucket)
	;	put pebbles (in well, in bucket?)
well_put:

	lda	CURRENT_NOUN

	cmp	#NOUN_BABY
	beq	well_put_baby
	cmp	#NOUN_PEBBLES
	beq	well_put_pebbles
	cmp	#NOUN_STONE
	beq	well_put_pebbles
	cmp	#NOUN_ROCK
	beq	well_put_pebbles

well_put_anything_else:
	ldx	#<well_put_anything_message
	ldy	#>well_put_anything_message
	jmp	finish_parse_message


	;=============
	; put baby

well_put_baby:

	jsr	get_noun_again

	lda	CURRENT_NOUN

	cmp	#NOUN_BUCKET
	beq	well_put_baby_in_bucket
	cmp	#NOUN_WELL
	beq	well_put_baby_in_well
	cmp	#NOUN_IN_WELL
	beq	well_put_baby_in_well

	; put general message

	ldx	#<well_put_baby_message
	ldy	#>well_put_baby_message
	jmp	finish_parse_message

	;=================
	; baby in bucket

well_put_baby_in_bucket:

	lda	INVENTORY_1
	and	#INV1_BABY
	beq	well_put_baby_in_bucket_no_baby

well_put_baby_in_bucket_yes_baby:
	lda	PEASANT_X
	cmp	#25
	bcc	well_put_baby_bucket_close_enough

	ldx	#<well_put_baby_in_bucket_too_far_message
	ldy	#>well_put_baby_in_bucket_too_far_message
	jmp	finish_parse_message

well_put_baby_bucket_close_enough:
	; see if have sub

	lda	INVENTORY_2
	and	#INV2_MEATBALL_SUB
	bne	well_put_baby_in_bucket_already_done

	; actually do it

	lda	#3
	jsr	score_points

	; put baby in bucket

	lda	GAME_STATE_0
	ora	#BABY_IN_WELL
	sta	GAME_STATE_0

	ldx	#<well_put_baby_in_bucket_message
	ldy	#>well_put_baby_in_bucket_message
	jmp	finish_parse_message

well_put_baby_in_bucket_already_done:
	ldx	#<well_put_baby_in_bucket_already_done_message
	ldy	#>well_put_baby_in_bucket_already_done_message
	jmp	finish_parse_message

well_put_baby_in_bucket_no_baby:
	ldx	#<well_put_baby_none_message
	ldy	#>well_put_baby_none_message
	jmp	finish_parse_message

	;=================
	; baby in well

well_put_baby_in_well:

	; check if have baby

	; first check if gone
	lda	INVENTORY_1_GONE
	and	#INV1_BABY
	bne	well_put_baby_in_well_but_gone

	; next check if we have baby
	lda	INVENTORY_1
	and	#INV1_BABY
	beq	well_put_baby_in_well_but_gone

well_put_baby_in_well_but_have:
	ldx	#<well_put_baby_in_well_message
	ldy	#>well_put_baby_in_well_message
	jmp	finish_parse_message

well_put_baby_in_well_but_gone:
	ldx	#<well_put_baby_none_message
	ldy	#>well_put_baby_none_message
	jmp	finish_parse_message


	;=============
	; put pebbles
well_put_pebbles:

	jsr	get_noun_again

	lda	CURRENT_NOUN

	cmp	#NOUN_BUCKET
	beq	well_put_pebbles_in_bucket
	cmp	#NOUN_WELL
	beq	well_put_pebbles_in_well
	cmp	#NOUN_IN_WELL
	beq	well_put_pebbles_in_well

	; put general message

	ldx	#<well_put_pebbles_message
	ldy	#>well_put_pebbles_message
	jmp	finish_parse_message

well_put_pebbles_in_bucket:

	; check if have pebbles

	; first check if gone
	lda	INVENTORY_1_GONE
	and	#INV1_PEBBLES
	bne	well_put_pebbles_in_bucket_but_gone

	; next check if we have them
	lda	INVENTORY_1
	and	#INV1_PEBBLES
	bne	well_put_pebbles_in_bucket_have_them

well_put_pebbles_in_bucket_no_pebbles:
	ldx	#<well_put_pebbles_in_bucket_before_message
	ldy	#>well_put_pebbles_in_bucket_before_message
	jmp	finish_parse_message

well_put_pebbles_in_bucket_but_gone:
	ldx	#<well_put_pebbles_in_bucket_gone_message
	ldy	#>well_put_pebbles_in_bucket_gone_message
	jmp	finish_parse_message

well_put_pebbles_in_bucket_have_them:

	; add 2 points to score

	lda	#2
	jsr	score_points

	; mark pebbles as gone

	lda	INVENTORY_1_GONE
	ora	#INV1_PEBBLES
	sta	INVENTORY_1_GONE

	ldx	#<well_put_pebbles_in_bucket_message
	ldy	#>well_put_pebbles_in_bucket_message
	jmp	finish_parse_message

	;=========================
	; pebbles in well

well_put_pebbles_in_well:

	; check if have pebbles

	; first check if gone
	lda	INVENTORY_1_GONE
	and	#INV1_PEBBLES
	bne	well_put_pebbles_in_well_but_gone

	; next check if we have them
	lda	INVENTORY_1
	and	#INV1_PEBBLES
	beq	well_put_pebbles_in_well_but_gone

well_put_pebbles_in_well_but_have:
	ldx	#<well_put_pebbles_in_well_message
	ldy	#>well_put_pebbles_in_well_message
	jmp	finish_parse_message

well_put_pebbles_in_well_but_gone:
	ldx	#<well_put_pebbles_in_well_gone_message
	ldy	#>well_put_pebbles_in_well_gone_message
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
