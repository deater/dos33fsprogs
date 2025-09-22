.include "../tokens.inc"

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
	; primary message

	ldx	#<well_look_at_well_message
	ldy	#>well_look_at_well_message
	jsr	partial_message_step

	lda	INVENTORY_1
	and	#INV1_MONSTER_MASK
	bne	well_look_had_mask

	ldx	#<well_look_at_well_message2
	ldy	#>well_look_at_well_message2
	jsr	finish_parse_message
well_look_had_mask:
	rts

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
	cmp	#NOUN_STONES
	beq	well_use_pebbles
	cmp	#NOUN_ROCKS
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

	jsr	check_close_to_well

	bcs	walk_to_well			; carry set if close enough

	jmp	well_turn_crank_too_far

walk_to_well:
	; walk to well
	ldx	#14
	ldy	#92
	jsr	peasant_walkto

	lda	#PEASANT_DIR_LEFT
	sta	PEASANT_DIR

	; check if baby in
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

	; toggle well state (well marked down)

	lda	GAME_STATE_0
	eor	#BUCKET_DOWN_WELL
	sta	GAME_STATE_0

	; run lower bucket animation

	jsr	lower_bucket

	; make sarcastic comment

	ldx	#<well_bucket_down_message
	ldy	#>well_bucket_down_message
	jmp	finish_parse_message

well_bucket_go_up:

	; toggle well state (to up)

	lda	GAME_STATE_0
	eor	#BUCKET_DOWN_WELL
	sta	GAME_STATE_0

	; animate bucket coming up

	jsr	raise_bucket

	; print sarcastic message

	ldx	#<well_bucket_up_message
	ldy	#>well_bucket_up_message
	jmp	finish_parse_message

well_turn_crank_baby_in:

	; raise bucket with baby in animation

	jsr	raise_bucket_baby

	ldx	#<well_turn_crank_baby_message
	ldy	#>well_turn_crank_baby_message
	jsr	partial_message_step

	; get points

	lda	#2
	jsr	score_points

	; here?

	jsr	raise_bucket_baby

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

	; raise bucket with mask in animation

	jsr	raise_bucket_mask

	; print message about finding mask

	ldx	#<well_turn_crank_pebbles_message
	ldy	#>well_turn_crank_pebbles_message
	jsr	partial_message_step

	; put mask into inventory

	lda	INVENTORY_1
	ora	#INV1_MONSTER_MASK
	sta	INVENTORY_1

	; print message about mask scaring horse

	ldx	#<well_turn_crank_pebbles2_message
	ldy	#>well_turn_crank_pebbles2_message
	jmp	finish_parse_message

well_turn_crank_pebbles_not_in:

	ldx	#<well_turn_crank_no_pebbles_message
	ldy	#>well_turn_crank_no_pebbles_message
	jmp	finish_parse_message

	;=========================
	; turn crank, too far away

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
	cmp	#NOUN_STONES
	beq	well_put_pebbles
	cmp	#NOUN_ROCKS
	beq	well_put_pebbles

well_put_anything_else:
	ldx	#<well_put_anything_message
	ldy	#>well_put_anything_message
	jmp	finish_parse_message


	;=============
	; put pebbles
	;=============

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

	; does *not* check to see if you are close

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

	; walk to well
	ldx	#14
	ldy	#92
	jsr	peasant_walkto

	jsr	lower_bucket

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

	;=================================
	; pebbles in well (not the bucket)

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

	;=============
	; put baby
	;=============
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

	jsr	check_close_to_well
	bcs	well_put_baby_bucket_close_enough

	ldx	#<well_put_baby_in_bucket_too_far_message
	ldy	#>well_put_baby_in_bucket_too_far_message
	jmp	finish_parse_message

	; note, it doesn't check if bucket is up you can
	;	put baby in if bucket up or down
	; also actual game you can but baby in bucket
	;	even if it already is in bucket

well_put_baby_bucket_close_enough:

	; walk to well

	ldx	#14
	ldy	#92
	jsr	peasant_walkto

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

	jsr	lower_bucket_baby

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




.include "../text/dialog_well.inc"

	;===============================
	; see if close enough to well
	; to mess with it
	;===============================
	; if X >30 or X <12 or Y > 128 not close enough
	;===============================
	; carry set if close enough
	; carry clear if not

check_close_to_well:

	lda	PEASANT_Y
	cmp	#128
	bcs	well_too_far

	lda	PEASANT_X
	cmp	#30
	bcs	well_too_far
	cmp	#12
	bcs	well_close_enough

well_too_far:
	clc
	rts

well_close_enough:
	sec
	rts
