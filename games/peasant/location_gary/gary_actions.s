.include "../tokens.inc"

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

	; walk to location

	ldx	#15
	ldy	#119
	jsr	peasant_walkto

	lda	#PEASANT_DIR_LEFT
	sta	PEASANT_DIR

	; print message

	ldx	#<gary_kick_horse_message
	ldy	#>gary_kick_horse_message
	jsr	partial_message_step

	; do animation

	jsr	draw_gary_revenge

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

	;============================
	; first move peasant to 105,119 (15,119)

	ldx	#15
	ldy	#119
	jsr	peasant_walkto

	lda	#PEASANT_DIR_LEFT
	sta	PEASANT_DIR

	; print mask message

	ldx	#<gary_scare_message
	ldy	#>gary_scare_message
	jsr	partial_message_step

	; set this here to suppress drawing gary through the whole sequence

	lda	GAME_STATE_0
	ora	#GARY_SCARED
	sta	GAME_STATE_0

	;========================
	; draw sequence where we scare gary
	;	and break fence

	jsr	draw_gary_scare

	; get points

	lda	#2
	jsr	score_points

	ldx	#<gary_scare_message2
	ldy	#>gary_scare_message2
	jmp	finish_parse_message


gary_scare_horse_nomask:

	jsr	random8
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


.include "../text/dialog_gary.inc"
