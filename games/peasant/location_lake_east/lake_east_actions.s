.include "../tokens.inc"

	;=======================
	;=======================
	;=======================
	; Pebble Lake East
	;=======================
	;=======================
	;=======================

lake_east_verb_table:
        .byte VERB_LOOK
        .word lake_east_look-1
        .byte VERB_TALK
        .word lake_east_talk-1
        .byte VERB_THROW
        .word lake_east_throw-1
        .byte VERB_SKIP
        .word lake_east_skip-1
	.byte 0

	;=================
	; look
	;=================

lake_east_look:

	lda	CURRENT_NOUN

	cmp	#NOUN_BOAT
	beq	lake_east_look_at_boat
	cmp	#NOUN_DINGHY
	beq	lake_east_look_at_boat
	cmp	#NOUN_DUDE
	beq	lake_east_look_at_man
	cmp	#NOUN_GUY
	beq	lake_east_look_at_man
	cmp	#NOUN_LAKE
	beq	lake_east_look_at_lake
	cmp	#NOUN_MAN
	beq	lake_east_look_at_man
	cmp	#NOUN_NONE
	beq	lake_east_look_at_lake
	cmp	#NOUN_SAND
	beq	lake_east_look_at_sand
	cmp	#NOUN_PEASANT
	beq	lake_east_look_at_man

	jmp	parse_common_look

lake_east_look_at_lake:
	lda	GAME_STATE_1
	and	#FISH_FED
	beq	look_at_lake_man_there

	ldx	#<lake_east_look_at_lake_message_man_gone
	ldy	#>lake_east_look_at_lake_message_man_gone
	jmp	finish_parse_message

look_at_lake_man_there:
	ldx	#<lake_east_look_at_lake_message
	ldy	#>lake_east_look_at_lake_message
	jmp	finish_parse_message


lake_east_look_at_man:
	lda	GAME_STATE_1
	and	#FISH_FED
	beq	look_at_man_hes_there

	; not there, so can't see him

	jmp	parse_common_look

look_at_man_hes_there:
	ldx	#<lake_east_look_at_man_message
	ldy	#>lake_east_look_at_man_message
	jmp	finish_parse_message

lake_east_look_at_sand:
	ldx	#<lake_east_look_at_sand_message
	ldy	#>lake_east_look_at_sand_message
	jsr	partial_message_step

	ldx	#<lake_east_look_at_sand_message2
	ldy	#>lake_east_look_at_sand_message2
	jmp	finish_parse_message

lake_east_look_at_boat:
	lda	GAME_STATE_1
	and	#FISH_FED
	beq	look_at_boat_hes_there

	; not there, so can't see him

	ldx	#<lake_east_look_at_boat_gone_message
	ldy	#>lake_east_look_at_boat_gone_message
	jmp	finish_parse_message

look_at_boat_hes_there:
	ldx	#<lake_east_look_at_boat_message
	ldy	#>lake_east_look_at_boat_message
	jmp	finish_parse_message


	;=================
	; talk
	;=================

lake_east_talk:

	lda	CURRENT_NOUN

	cmp	#NOUN_DUDE
	beq	lake_east_talk_to_man
	cmp	#NOUN_GUY
	beq	lake_east_talk_to_man
	cmp	#NOUN_MAN
	beq	lake_east_talk_to_man
	cmp	#NOUN_PEASANT
	beq	lake_east_talk_to_man

	jmp	parse_common_talk

lake_east_talk_to_man:

	lda	GAME_STATE_1
	and	#FISH_FED
	beq	talk_hes_there

	ldx	#<lake_east_talk_man_after_message
	ldy	#>lake_east_talk_man_after_message
	jmp	finish_parse_message

talk_hes_there:
	ldx	#<lake_east_talk_man_message
	ldy	#>lake_east_talk_man_message
	jmp	finish_parse_message

	;=================
	; skip
	;=================

lake_east_skip:

	lda	CURRENT_NOUN

	cmp	#NOUN_STONE
	beq	lake_east_skip_stones
	cmp	#NOUN_STONES
	beq	lake_east_skip_stones
	cmp	#NOUN_ROCK
	beq	lake_east_skip_stones
	cmp	#NOUN_ROCKS
	beq	lake_east_skip_stones

	jmp	parse_common_unknown

lake_east_skip_stones:
	ldx	#<lake_east_skip_stones_message
	ldy	#>lake_east_skip_stones_message
	jmp	finish_parse_message

	;=================
	; throw
	;=================

lake_east_throw:

	lda	CURRENT_NOUN

	cmp	#NOUN_FEED
	beq	lake_east_throw_feed
	cmp	#NOUN_STONE
	beq	lake_east_skip_stones
	cmp	#NOUN_STONES
	beq	lake_east_skip_stones
	cmp	#NOUN_ROCK
	beq	lake_east_skip_stones
	cmp	#NOUN_ROCKS
	beq	lake_east_skip_stones

	bne	lake_east_throw_default

lake_east_throw_feed:
	; check if have feed
	lda	INVENTORY_1
	and	#INV1_CHICKEN_FEED
	bne	do_have_feed

dont_have_feed:
	ldx	#<lake_east_throw_feed_none_message
	ldy	#>lake_east_throw_feed_none_message
	jmp	finish_parse_message

do_have_feed:

	; check if too far up/down
	;	#$34 52 -> 120

	lda	PEASANT_Y
	cmp	#52
	bcc	throw_feed_too_south	; blt
	cmp	#120
	bcs	throw_feed_too_south	; bge

	; check if man still there

	lda	GAME_STATE_1
	and	#FISH_FED
	beq	throw_feed_hes_there

	; he's not there

	ldx	#<lake_east_throw_feed_already_message
	ldy	#>lake_east_throw_feed_already_message
	jmp	finish_parse_message

throw_feed_hes_there:

	;=============================
	; walk to location

	ldx	#27
	ldy	#64
	jsr	peasant_walkto

	lda	#PEASANT_DIR_LEFT
	sta	PEASANT_DIR

	;============================
	; actually throw feed

	ldx	#<lake_east_throw_feed_message
	ldy	#>lake_east_throw_feed_message
	jsr	partial_message_step


	; animate feed+fish

	jsr	animate_throw

	; feed fish
	; (do this after or boat won't be drawn)
	lda	GAME_STATE_1
	ora	#FISH_FED
	sta	GAME_STATE_1

	; no longer have feed
	lda	INVENTORY_1_GONE
	ora	#INV1_CHICKEN_FEED
	sta	INVENTORY_1_GONE


	ldx	#<lake_east_throw_feed2_message
	ldy	#>lake_east_throw_feed2_message
	jsr	finish_parse_message

	; add 2 points to score
	; this happens after message

	lda	#2
	jmp	score_points




throw_feed_too_south:
	ldx	#<lake_east_throw_feed_too_south_message
	ldy	#>lake_east_throw_feed_too_south_message
	jmp	finish_parse_message

	; throw anything but feed
lake_east_throw_default:
	lda	GAME_STATE_1
	and	#FISH_FED
	beq	lake_east_throw_feed_man_default

	; not there

	ldx	#<lake_east_throw_default_gone_message
	ldy	#>lake_east_throw_default_gone_message
	jmp	finish_parse_message

lake_east_throw_feed_man_default:
	ldx	#<lake_east_throw_default_message
	ldy	#>lake_east_throw_default_message
	jmp	finish_parse_message

.include "../text/dialog_lake_east.inc"

