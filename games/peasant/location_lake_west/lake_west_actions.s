.include "../tokens.inc"

	;=======================
	;=======================
	;=======================
	; Pebble Lake West
	;=======================
	;=======================
	;=======================

lake_west_verb_table:
	.byte VERB_GET
	.word lake_west_get-1
	.byte VERB_STEAL
	.word lake_west_steal-1
	.byte VERB_SKIP
	.word lake_west_skip-1
	.byte VERB_TAKE
	.word lake_west_take-1
	.byte VERB_LOOK
	.word lake_west_look-1
	.byte VERB_SWIM
	.word lake_west_swim-1
	.byte VERB_THROW
	.word lake_west_throw-1
	.byte 0



	;================
	; get
	;================
lake_west_get:
lake_west_steal:
lake_west_take:
	lda	CURRENT_NOUN

	cmp	#NOUN_BERRIES
	beq	lake_west_get_berries
	cmp	#NOUN_ROCKS
	beq	lake_west_get_pebbles
	cmp	#NOUN_STONES
	beq	lake_west_get_pebbles
	cmp	#NOUN_PEBBLES
	beq	lake_west_get_pebbles

	; else "probably wish" message

	jmp	parse_common_get

lake_west_get_berries:
	ldx	#<lake_west_get_berries_message
	ldy	#>lake_west_get_berries_message
	jmp	finish_parse_message

lake_west_get_pebbles:
	lda	INVENTORY_1
	and	#INV1_PEBBLES
	bne	lake_west_yes_pebbles

lake_west_no_pebbles:
	; only if standing vaguely near them

	; FIXME: check X as well
	;	also we're supposed to walk to them

	lda	PEASANT_Y
	cmp	#$70
	bcs	pebbles_too_far		; bge

	; pick up pebbles
	lda	INVENTORY_1
	ora	#INV1_PEBBLES
	sta	INVENTORY_1

	; add score

	lda	#1
	jsr	score_points

	jsr	remove_pebbles

	; print message
	ldx	#<lake_west_get_pebbles_message
	ldy	#>lake_west_get_pebbles_message
	jmp	finish_parse_message



pebbles_too_far:
	ldx	#<lake_west_pebbles_too_far_message
	ldy	#>lake_west_pebbles_too_far_message
	jmp	finish_parse_message



lake_west_yes_pebbles:
	jmp	parse_common_get


	;=================
	; look
	;=================

lake_west_look:

	lda	CURRENT_NOUN

	cmp	#NOUN_LAKE
	beq	lake_west_look_at_lake
	cmp	#NOUN_SAND
	beq	lake_west_look_at_sand
	cmp	#NOUN_ROCKS
	beq	lake_west_look_at_sand
	cmp	#NOUN_STONES
	beq	lake_west_look_at_sand
	cmp	#NOUN_PEBBLES
	beq	lake_west_look_at_sand
	cmp	#NOUN_WATER
	beq	lake_west_look_at_lake
	cmp	#NOUN_BUSH
	beq	lake_west_look_at_bush
	cmp	#NOUN_BERRIES
	beq	lake_west_look_at_berries
	cmp	#NOUN_NONE
	beq	lake_west_look_at

	jmp	parse_common_look

lake_west_look_at:
	ldx	#<lake_west_look_at_message
	ldy	#>lake_west_look_at_message
	jmp	finish_parse_message

lake_west_look_at_lake:
	ldx	#<lake_west_look_at_lake_message
	ldy	#>lake_west_look_at_lake_message
	jmp	finish_parse_message

lake_west_look_at_sand:
	lda	INVENTORY_1
	and	#INV1_PEBBLES
	bne	look_sand_pebbles_gone

	lda	INVENTORY_1_GONE
	and	#INV1_PEBBLES
	bne	look_sand_pebbles_gone

look_sand_pebbles_there:
	ldx	#<lake_west_look_at_sand_message
	ldy	#>lake_west_look_at_sand_message
	jmp	finish_parse_message

look_sand_pebbles_gone:
	ldx	#<lake_west_look_at_sand_after_message
	ldy	#>lake_west_look_at_sand_after_message
	jmp	finish_parse_message

lake_west_look_at_bush:
	ldx	#<lake_west_look_at_bush_message
	ldy	#>lake_west_look_at_bush_message
	jmp	finish_parse_message

lake_west_look_at_berries:
	ldx	#<lake_west_look_at_berries_message
	ldy	#>lake_west_look_at_berries_message
	jmp	finish_parse_message


	;================
	; skip
	;================
lake_west_skip:
	lda	CURRENT_NOUN

	cmp	#NOUN_STONES
	beq	lake_west_skip_stones
	cmp	#NOUN_PEBBLES
	beq	lake_west_skip_stones
	cmp	#NOUN_ROCKS
	beq	lake_west_skip_stones

	jmp	parse_common_unknown

lake_west_skip_stones:
	ldx	#<lake_west_skip_stones_message
	ldy	#>lake_west_skip_stones_message
	jmp	finish_parse_message


	;================
	; swim
	;================
lake_west_swim:
	lda	CURRENT_NOUN

	cmp	#NOUN_LAKE
	beq	lake_west_swim_lake
	cmp	#NOUN_WATER
	beq	lake_west_swim_lake
	cmp	#NOUN_NONE
	beq	lake_west_swim_lake

	jmp	parse_common_unknown

lake_west_swim_lake:
	ldx	#<lake_west_swim_message
	ldy	#>lake_west_swim_message
	jmp	finish_parse_message


	;================
	; throw
	;================
lake_west_throw:
	lda	CURRENT_NOUN

	cmp	#NOUN_ROCKS
	beq	lake_west_skip_stones
	cmp	#NOUN_STONES
	beq	lake_west_skip_stones
	cmp	#NOUN_PEBBLES
	beq	lake_west_skip_stones

	cmp	#NOUN_BABY
	beq	lake_west_throw_baby

	cmp	#NOUN_FEED
	beq	lake_west_throw_feed

	jmp	parse_common_unknown

lake_west_throw_baby:

	; first see if have baby

	lda	INVENTORY_1
	and	#INV1_BABY
	beq	lake_west_throw_baby_no_baby

	; next see if baby gone

	lda	INVENTORY_1_GONE
	and	#INV1_BABY
	bne	lake_west_throw_baby_no_baby


	; see if in right spot
	; TODO:
	lda	PEASANT_X
	lda	PEASANT_Y

	; see if have soda

	lda	INVENTORY_2
	and	#INV2_SODA
	bne	lake_west_throw_baby_already

	; throwing for the first time
lake_west_throw_baby_for_reals:
	; do the animation

	ldx	#<lake_west_throw_baby_message
	ldy	#>lake_west_throw_baby_message
	jsr	partial_message_step

	; score points
	lda	#5
	jsr	score_points

	; get soda
	lda	INVENTORY_2
	ora	#INV2_SODA
	sta	INVENTORY_2

	ldx	#<lake_west_throw_baby_message2
	ldy	#>lake_west_throw_baby_message2
	jmp	finish_parse_message


lake_west_throw_baby_already:
	ldx	#<lake_west_throw_baby_already_message
	ldy	#>lake_west_throw_baby_already_message
	jmp	finish_parse_message

lake_west_throw_baby_no_baby:
	ldx	#<lake_west_throw_baby_no_baby_message
	ldy	#>lake_west_throw_baby_no_baby_message
	jmp	finish_parse_message


lake_west_throw_feed:
	ldx	#<lake_west_throw_feed_too_south_message
	ldy	#>lake_west_throw_feed_too_south_message
	jmp	finish_parse_message



.include "../text/dialog_lake_west.inc"

