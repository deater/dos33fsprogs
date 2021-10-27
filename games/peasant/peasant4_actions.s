.include "tokens.inc"

	;=======================
	;=======================
	;=======================
	; Ned's Cottage
	;=======================
	;=======================
	;=======================

ned_cottage_verb_table:
	.byte VERB_BREAK
	.word ned_cottage_break-1
	.byte VERB_CLIMB
	.word ned_cottage_climb-1
	.byte VERB_CUT
	.word ned_cottage_cut-1
	.byte VERB_DEPLOY
	.word ned_cottage_deploy-1
	.byte VERB_DROP
	.word ned_cottage_drop-1
	.byte VERB_GET
	.word ned_cottage_get-1
	.byte VERB_JUMP
	.word ned_cottage_jump-1
	.byte VERB_KICK
	.word ned_cottage_kick-1
	.byte VERB_KNOCK
	.word ned_cottage_knock-1
	.byte VERB_LOOK
	.word ned_cottage_look-1
	.byte VERB_MOVE
	.word ned_cottage_move-1
	.byte VERB_OPEN
	.word ned_cottage_open-1
	.byte VERB_PUSH
	.word ned_cottage_push-1
	.byte VERB_PULL
	.word ned_cottage_pull-1
	.byte VERB_PUNCH
	.word ned_cottage_punch-1
	.byte VERB_USE
	.word ned_cottage_use-1
	.byte VERB_TRY
	.word ned_cottage_try-1
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
	lda	GAME_STATE_2
	and	#COTTAGE_ROCK_MOVED
	bne	ned_cottage_rock_moved

ned_cottage_rock_not_moved:
	; move rock

	lda	PEASANT_X
	sta	CURSOR_X
	lda	PEASANT_Y
	sta	CURSOR_Y

	jsr	restore_bg_1x28

	; 161,117
	lda	#23
	sta	CURSOR_X
	lda	#117
	sta	CURSOR_Y

	lda	#<rock_moved_sprite
	sta	INL
	lda	#>rock_moved_sprite
	sta	INH

	jsr	hgr_draw_sprite

	lda	PEASANT_X
	sta	CURSOR_X
	lda	PEASANT_Y
	sta	CURSOR_Y

	jsr	save_bg_1x28

	jsr	draw_peasant


	; make rock moved


	lda	GAME_STATE_2
	ora	#COTTAGE_ROCK_MOVED
	sta	GAME_STATE_2

	ldx	#<ned_cottage_get_rock_message
	ldy	#>ned_cottage_get_rock_message

	jsr	finish_parse_message

	; add 2 points to score

	lda	#2
	jsr	score_points

	rts



ned_cottage_rock_moved:

	ldx	#<ned_cottage_get_rock_already_message
	ldy	#>ned_cottage_get_rock_already_message
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


	;===================
	; cut
	;===================
ned_cottage_cut:

	lda	CURRENT_NOUN

	cmp	#NOUN_ARMS
	beq	cut_off_arms

	jmp	parse_common_unknown

cut_off_arms:
	ldx	#<ned_cottage_cut_arms_message
	ldy	#>ned_cottage_cut_arms_message
	jmp	finish_parse_message

	;===================
	; try
	;===================
ned_cottage_try:

;	lda	CURRENT_NOUN
;	cmp	#NOUN_NONE

	; you die

	lda	#LOAD_GAME_OVER
	sta	WHICH_LOAD

	lda	#NEW_FROM_DISK
	sta	LEVEL_OVER

	ldx	#<ned_cottage_try_message
	ldy	#>ned_cottage_try_message
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


	;=======================
	;=======================
	;=======================
	; Ned Tree
	;=======================
	;=======================
	;=======================

ned_verb_table:
	.byte VERB_CLIMB
	.word ned_tree_climb-1
	.byte VERB_LOOK
	.word ned_tree_look-1
	.byte VERB_TALK
	.word ned_tree_talk-1
	.byte 0


	;================
	; climb
	;================
ned_tree_climb:
	lda	CURRENT_NOUN

	cmp	#NOUN_TREE
	beq	ned_tree_climb_tree

	jmp	parse_common_unknown

ned_tree_climb_tree:
	ldx	#<ned_tree_climb_tree_message
	ldy	#>ned_tree_climb_tree_message
	jmp	finish_parse_message

	;================
	; talk
	;================
ned_tree_talk:
	lda	CURRENT_NOUN

	cmp	#NOUN_TREE
	beq	ned_tree_talk_tree

	jmp	parse_common_talk

ned_tree_talk_tree:
	ldx	#<ned_tree_talk_tree_message
	ldy	#>ned_tree_talk_tree_message
	jmp	finish_parse_message

	;=================
	; look
	;=================

ned_tree_look:

	lda	CURRENT_NOUN

	cmp	#NOUN_TREE
	beq	ned_tree_look_at_tree
	cmp	#NOUN_NONE
	beq	ned_tree_look_at

	jmp	parse_common_look

ned_tree_look_at:
	ldx	#<ned_tree_look_at_message
	ldy	#>ned_tree_look_at_message
	jmp	finish_parse_message

ned_tree_look_at_tree:
	ldx	#<ned_tree_look_at_tree_message
	ldy	#>ned_tree_look_at_tree_message
	jmp	finish_parse_message


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
	; Baby Lady Cottage
	;=======================
	;=======================
	;=======================

lady_cottage_verb_table:
	.byte VERB_LOOK
	.word lady_cottage_look-1
	.byte VERB_KNOCK
	.word lady_cottage_knock-1
	.byte VERB_OPEN
	.word lady_cottage_open-1
	.byte 0

	;=================
	; look
	;=================

lady_cottage_look:

	lda	CURRENT_NOUN

	cmp	#NOUN_BERRIES
	beq	lady_cottage_look_at_berries
	cmp	#NOUN_BUSH
	beq	lady_cottage_look_at_bushes
	cmp	#NOUN_COTTAGE
	beq	lady_cottage_look_at_cottage
	cmp	#NOUN_DOOR
	beq	lady_cottage_look_at_door
	cmp	#NOUN_NONE
	beq	lady_cottage_look_at

	jmp	parse_common_look

lady_cottage_look_at:
	ldx	#<lady_cottage_look_at_message
	ldy	#>lady_cottage_look_at_message
	jmp	finish_parse_message

lady_cottage_look_at_cottage:
	ldx	#<lady_cottage_look_at_cottage_message
	ldy	#>lady_cottage_look_at_cottage_message
	jmp	finish_parse_message

lady_cottage_look_at_door:
	ldx	#<lady_cottage_look_at_door_message
	ldy	#>lady_cottage_look_at_door_message
	jmp	finish_parse_message

lady_cottage_look_at_berries:
	ldx	#<lady_cottage_look_at_berries_message
	ldy	#>lady_cottage_look_at_berries_message
	jmp	finish_parse_message

lady_cottage_look_at_bushes:
	ldx	#<lady_cottage_look_at_bushes_message
	ldy	#>lady_cottage_look_at_bushes_message
	jmp	finish_parse_message


	;================
	; knock
	;================
lady_cottage_knock:
	lda	CURRENT_NOUN

	cmp	#NOUN_DOOR
	beq	lady_cottage_knock_door
	cmp	#NOUN_NONE
	beq	lady_cottage_knock_door

	jmp	parse_common_unknown

lady_cottage_knock_door:

	lda	GAME_STATE_0
	and	#LADY_GONE
	bne	lady_cottage_knock_door_gone

	ldx	#<lady_cottage_knock_door_message
	ldy	#>lady_cottage_knock_door_message
	jmp	finish_parse_message

lady_cottage_knock_door_gone:
	ldx	#<lady_cottage_knock_door_gone_message
	ldy	#>lady_cottage_knock_door_gone_message
	jmp	finish_parse_message


	;================
	; open
	;================
lady_cottage_open:
	lda	CURRENT_NOUN

	cmp	#NOUN_DOOR
	beq	lady_cottage_open_door
	cmp	#NOUN_NONE
	beq	lady_cottage_open_door

	jmp	parse_common_unknown

lady_cottage_open_door:

	ldx	#<lady_cottage_open_door_message
	ldy	#>lady_cottage_open_door_message

	jsr	partial_message_step

	lda	#LOCATION_INSIDE_LADY
	jsr	update_map_location

	rts




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
