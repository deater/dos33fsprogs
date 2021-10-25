.include "tokens.inc"


	;=======================
	;=======================
	;=======================
	; Jhonka Cave
	;=======================
	;=======================
	;=======================

jhonka_cave_verb_table:
	.byte VERB_CLIMB
	.word jhonka_climb-1
	.byte VERB_GET
	.word jhonka_get-1
	.byte VERB_JUMP
	.word jhonka_jump-1
	.byte VERB_LOOK
	.word jhonka_look-1
	.byte VERB_OPEN
	.word jhonka_open-1
	.byte VERB_READ
	.word jhonka_read-1
	.byte VERB_KNOCK
	.word jhonka_knock-1
	.byte 0


	;================
	; climb
	;================
jhonka_jump:
jhonka_climb:
	lda	CURRENT_NOUN

	cmp	#NOUN_FENCE
	beq	jhonka_climb_fence

	jmp	parse_common_unknown

jhonka_climb_fence:
	ldx	#<jhonka_climb_fence_message
	ldy	#>jhonka_climb_fence_message
	jmp	finish_parse_message


	;================
	; get
	;================
jhonka_get:
	lda	CURRENT_NOUN

	cmp	#NOUN_NOTE
	beq	jhonka_get_note

	; else "probably wish" message

	jmp	parse_common_get

jhonka_get_note:
	ldx	#<jhonka_get_note_message
	ldy	#>jhonka_get_note_message
	jmp	finish_parse_message


	;=================
	; look
	;=================

jhonka_look:

	lda	CURRENT_NOUN

	cmp	#NOUN_FENCE
	beq	jhonka_look_at_fence
	cmp	#NOUN_CAVE
	beq	jhonka_look_at_cave
	cmp	#NOUN_NOTE
	beq	jhonka_read_note

	cmp	#NOUN_NONE
	beq	jhonka_look_at

	jmp	parse_common_look

jhonka_look_at:
	ldx	#<jhonka_look_at_message
	ldy	#>jhonka_look_at_message
	jmp	finish_parse_message

jhonka_look_at_cave:
	ldx	#<jhonka_look_at_cave_message
	ldy	#>jhonka_look_at_cave_message
	jmp	finish_parse_message

jhonka_look_at_fence:
	ldx	#<jhonka_look_at_fence_message
	ldy	#>jhonka_look_at_fence_message
	jmp	finish_parse_message


	;================
	; read
	;================
jhonka_read:
	lda	CURRENT_NOUN

	cmp	#NOUN_NOTE
	beq	jhonka_read_note

	jmp	parse_common_unknown

jhonka_read_note:
	ldx	#<jhonka_read_note_message
	ldy	#>jhonka_read_note_message
	jmp	finish_parse_message


	;================
	; open
	;================
jhonka_open:
	lda	CURRENT_NOUN

	cmp	#NOUN_DOOR
	beq	jhonka_open_door
	cmp	#NOUN_NONE
	beq	jhonka_open_door

	jmp	parse_common_unknown

jhonka_open_door:
	ldx	#<jhonka_open_door_message
	ldy	#>jhonka_open_door_message
	jmp	finish_parse_message


	;================
	; knock
	;================
jhonka_knock:
	lda	CURRENT_NOUN

	cmp	#NOUN_DOOR
	beq	jhonka_knock_door
	cmp	#NOUN_NONE
	beq	jhonka_knock_door

	jmp	parse_common_unknown

jhonka_knock_door:
	ldx	#<jhonka_knock_message1
	ldy	#>jhonka_knock_message1
	jmp	finish_parse_message






	;=======================
	;=======================
	;=======================
	; Cottage
	;=======================
	;=======================
	;=======================

cottage_verb_table:
	.byte VERB_GET
	.word cottage_get-1
	.byte VERB_TAKE
	.word cottage_take-1
	.byte VERB_STEAL
	.word cottage_steal-1
	.byte VERB_LOOK
	.word cottage_look-1
	.byte 0


	;================
	; get
	;================
cottage_get:
cottage_steal:
cottage_take:
	lda	CURRENT_NOUN

	cmp	#NOUN_MAP
	beq	cottage_get_map
	cmp	#NOUN_PAPER
	beq	cottage_get_map

	; else "probably wish" message

	jmp	parse_common_get

cottage_get_map:
	ldx	#<cottage_get_map_message
	ldy	#>cottage_get_map_message
	jmp	finish_parse_message

	;=================
	; look
	;=================

cottage_look:

	lda	CURRENT_NOUN

	cmp	#NOUN_PAPER
	beq	cottage_look_at_ground
	cmp	#NOUN_GROUND
	beq	cottage_look_at_ground
	cmp	#NOUN_COTTAGE
	beq	cottage_look_at_cottage
	cmp	#NOUN_NONE
	beq	cottage_look_at

	jmp	parse_common_look

cottage_look_at:
	ldx	#<cottage_look_at_message
	ldy	#>cottage_look_at_message
	jmp	finish_parse_message

cottage_look_at_cottage:
	ldx	#<cottage_look_at_cottage_message
	ldy	#>cottage_look_at_cottage_message

	jsr	partial_message_step

	ldx	#<cottage_look_at_cottage_message_map
	ldy	#>cottage_look_at_cottage_message_map

	jmp	finish_parse_message

cottage_look_at_ground:
cottage_look_at_paper:
	ldx	#<cottage_look_at_map_message
	ldy	#>cottage_look_at_map_message
	jmp	finish_parse_message


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
	cmp	#NOUN_STONE
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
	ldx	#<lake_west_get_pebbles_message
	ldy	#>lake_west_get_pebbles_message
	jmp	finish_parse_message


	;=================
	; look
	;=================

lake_west_look:

	lda	CURRENT_NOUN

	cmp	#NOUN_LAKE
	beq	lake_west_look_at_lake
	cmp	#NOUN_SAND
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
	ldx	#<lake_west_look_at_sand_message
	ldy	#>lake_west_look_at_sand_message
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

	cmp	#NOUN_STONE
	beq	lake_west_skip_stones
	cmp	#NOUN_PEBBLES
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

	cmp	#NOUN_BABY
	beq	lake_west_throw_baby

	jmp	parse_common_unknown

lake_west_throw_baby:
	ldx	#<lake_west_throw_baby_message
	ldy	#>lake_west_throw_baby_message
	jmp	finish_parse_message






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
	ldx	#<lake_east_look_at_lake_message
	ldy	#>lake_east_look_at_lake_message
	jmp	finish_parse_message

lake_east_look_at_man:
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
	ldx	#<lake_east_talk_man_message
	ldy	#>lake_east_talk_man_message
	jmp	finish_parse_message


	;=================
	; throw
	;=================

lake_east_throw:

	lda	CURRENT_NOUN

	cmp	#NOUN_FEED
	beq	lake_east_throw_feed

	bne	lake_east_throw_default

lake_east_throw_feed:
	ldx	#<lake_east_throw_feed_message
	ldy	#>lake_east_throw_feed_message
	jmp	finish_parse_message

lake_east_throw_default:
	ldx	#<lake_east_throw_default_message
	ldy	#>lake_east_throw_default_message
	jmp	finish_parse_message



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

