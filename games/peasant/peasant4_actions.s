.include "tokens.inc"

	;=======================
	;=======================
	;=======================
	; Ned's Cottage
	;=======================
	;=======================
	;=======================

ned_cottage_verb_table:
	.byte VERB_CLIMB
	.word ned_cottage_climb-1
	.byte VERB_DEPLOY
	.word ned_cottage_deploy-1
	.byte VERB_DROP
	.word ned_cottage_drop-1
	.byte VERB_GET
	.word ned_cottage_get-1
	.byte VERB_JUMP
	.word ned_cottage_jump-1
	.byte VERB_KNOCK
	.word ned_cottage_knock-1
	.byte VERB_LOOK
	.word ned_cottage_look-1
	.byte VERB_MOVE
	.word ned_cottage_move-1
	.byte VERB_OPEN
	.word ned_cottage_open-1
	.byte VERB_USE
	.word ned_cottage_use-1
	.byte 0

	;================
	; climb/jump
	;================
ned_cottage_jump:
ned_cottage_climb:
	lda	CURRENT_NOUN

	cmp	#NOUN_FENCE
	beq	ned_cottage_climb_fence

	jmp	parse_common_unknown

ned_cottage_climb_fence:
	ldx	#<ned_cottage_climb_fence_message
	ldy	#>ned_cottage_climb_fence_message
	jmp	finish_parse_message

	;================
	; knock
	;================
ned_cottage_knock:
	lda	CURRENT_NOUN

	cmp	#NOUN_BLEED
	beq	ned_cottage_knock_door_bleed
	cmp	#NOUN_DOOR
	beq	ned_cottage_knock_door
	cmp	#NOUN_NONE
	beq	ned_cottage_knock_door

	jmp	parse_common_unknown

ned_cottage_knock_door:
	ldx	#<ned_cottage_knock_door_message
	ldy	#>ned_cottage_knock_door_message
	jmp	finish_parse_message

ned_cottage_knock_door_bleed:
	lda	GAME_STATE_2
	and	#KNUCKLES_BLEED
	beq	not_bleeding
bleeding:

	ldx	#<ned_cottage_knock_door_bleed_message2
	ldy	#>ned_cottage_knock_door_bleed_message2
	jmp	finish_parse_message


not_bleeding:
	lda	GAME_STATE_2
	ora	#KNUCKLES_BLEED
	sta	GAME_STATE_2

	ldx	#<ned_cottage_knock_door_bleed_message
	ldy	#>ned_cottage_knock_door_bleed_message
	jmp	finish_parse_message


	;================
	; open
	;================
ned_cottage_open:
	lda	CURRENT_NOUN

	cmp	#NOUN_DOOR
	beq	ned_cottage_open_door
	cmp	#NOUN_NONE
	beq	ned_cottage_open_door

	jmp	parse_common_unknown

ned_cottage_open_door:
	ldx	#<ned_cottage_open_door_message
	ldy	#>ned_cottage_open_door_message
	jmp	finish_parse_message

	;================
	; push/pull
	;================
ned_cottage_push:
ned_cottage_pull:
	lda	CURRENT_NOUN

	cmp	#NOUN_DOOR
	beq	ned_cottage_push_door

	jmp	parse_common_unknown

ned_cottage_push_door:
	ldx	#<ned_cottage_push_door_message
	ldy	#>ned_cottage_push_door_message
	jmp	finish_parse_message



	;================
	; get
	;================
ned_cottage_get:
ned_cottage_move:
	lda	CURRENT_NOUN

	cmp	#NOUN_ROCK
	beq	ned_cottage_rock

	; else "probably wish" message

	jmp	parse_common_get

ned_cottage_rock:
	ldx	#<ned_cottage_get_rock_message
	ldy	#>ned_cottage_get_rock_message
	jmp	finish_parse_message

	;================
	; deploy/drop/use baby
	;================
ned_cottage_deploy:
ned_cottage_drop:
ned_cottage_use:
	lda	CURRENT_NOUN

	cmp	#NOUN_BABY
	beq	ned_cottage_baby

	jmp	parse_common_unknown

ned_cottage_baby:
	ldx	#<ned_cottage_baby_before_message
	ldy	#>ned_cottage_baby_before_message
	jmp	finish_parse_message


	;===================
	; break/kick/punch
	;===================
ned_cottage_break:
ned_cottage_kick:
ned_cottage_punch:

	lda	CURRENT_NOUN

	cmp	#NOUN_DOOR
	beq	kick_cottage

	jmp	parse_common_unknown

kick_cottage:
	ldx	#<ned_cottage_break_door_message
	ldy	#>ned_cottage_break_door_message
	jmp	finish_parse_message


	;=================
	; look
	;=================

ned_cottage_look:

	lda	CURRENT_NOUN

	cmp	#NOUN_FENCE
	beq	ned_cottage_look_at_fence
	cmp	#NOUN_COTTAGE
	beq	ned_cottage_look_at_cottage
	cmp	#NOUN_ROCK
	beq	ned_cottage_look_at_rock
	cmp	#NOUN_HOLE
	beq	ned_cottage_look_at_hole

	cmp	#NOUN_NONE
	beq	ned_cottage_look_at

	jmp	parse_common_look

ned_cottage_look_at:
	ldx	#<ned_cottage_look_message
	ldy	#>ned_cottage_look_message
	jmp	finish_parse_message

ned_cottage_look_at_cottage:
	ldx	#<ned_cottage_look_cottage_message
	ldy	#>ned_cottage_look_cottage_message
	jmp	finish_parse_message

ned_cottage_look_at_fence:
	ldx	#<ned_cottage_look_fence_message
	ldy	#>ned_cottage_look_fence_message
	jmp	finish_parse_message

ned_cottage_look_at_rock:
	ldx	#<ned_cottage_look_rock_message
	ldy	#>ned_cottage_look_rock_message
	jmp	finish_parse_message

ned_cottage_look_at_hole:
	ldx	#<ned_cottage_look_hole_message
	ldy	#>ned_cottage_look_hole_message
	jmp	finish_parse_message



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
.endif

	;=======================
	;=======================
	;=======================
	; burninated / crooked tree
	;=======================
	;=======================
	;=======================

crooked_tree_verb_table:
        .byte VERB_GET
        .word crooked_tree_get-1
        .byte VERB_LIGHT
        .word crooked_tree_light-1
        .byte VERB_LOOK
        .word crooked_tree_look-1
	.byte 0


	;================
	; get
	;================
crooked_tree_get:
	lda	CURRENT_NOUN

	cmp	#NOUN_FIRE
	beq	crooked_get_fire
	cmp	#NOUN_LANTERN
	beq	crooked_get_lantern
	cmp	#NOUN_PLAGUE
	beq	crooked_get_plague
	cmp	#NOUN_PLAQUE
	beq	crooked_get_plaque

	jmp	parse_common_get

crooked_get_fire:
	; only at night
	jmp	parse_common_get

crooked_get_lantern:
	ldx	#<crooked_tree_get_lantern_message
	ldy	#>crooked_tree_get_lantern_message
	jmp	finish_parse_message

crooked_get_plague:
	ldx	#<crooked_tree_get_plague_message
	ldy	#>crooked_tree_get_plague_message
	jmp	finish_parse_message

crooked_get_plaque:
	ldx	#<crooked_tree_get_plaque_message
	ldy	#>crooked_tree_get_plaque_message
	jmp	finish_parse_message


	;================
	; light
	;================
crooked_tree_light:
	lda	CURRENT_NOUN
	cmp	#NOUN_LANTERN
	beq	light_lantern

	jmp	parse_common_unknown

light_lantern:
	ldx	#<crooked_tree_light_lantern_message
	ldy	#>crooked_tree_light_lantern_message
	jmp	finish_parse_message


	;=================
	; look
	;=================

crooked_tree_look:

	lda	CURRENT_NOUN

	cmp	#NOUN_LANTERN
	beq	crooked_look_lantern
	cmp	#NOUN_STUMP
	beq	crooked_look_stump
	cmp	#NOUN_TREE
	beq	crooked_look_tree
	cmp	#NOUN_NONE
	beq	crooked_look

	jmp	parse_common_look

crooked_look:
	ldx	#<crooked_look_day_message
	ldy	#>crooked_look_day_message
	jmp	finish_parse_message

crooked_look_lantern:
	ldx	#<crooked_look_lantern_message
	ldy	#>crooked_look_lantern_message
	jmp	finish_parse_message

crooked_look_stump:
	ldx	#<crooked_look_stump_message
	ldy	#>crooked_look_stump_message
	jmp	finish_parse_message

crooked_look_tree:
	ldx	#<crooked_look_tree_message
	ldy	#>crooked_look_tree_message
	jmp	finish_parse_message


.include "dialog_peasant4.inc"
