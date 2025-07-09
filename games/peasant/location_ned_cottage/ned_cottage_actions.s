.include "../tokens.inc"

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
	.byte VERB_PUT
	.word ned_cottage_put-1
	.byte VERB_CLOSE
	.word ned_cottage_close-1
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
	; close
	;================
ned_cottage_close:
	lda	CURRENT_NOUN

	cmp	#NOUN_DOOR
	beq	ned_cottage_close_door

	jmp	parse_common_unknown

ned_cottage_close_door:
	; see if baby gone
	lda	INVENTORY_1_GONE
	and	#INV1_BABY
	bne	ned_cottage_close_door_after

ned_cottage_close_door_before:
	ldx	#<ned_cottage_close_door_before_message
	ldy	#>ned_cottage_close_door_before_message
	jmp	finish_parse_message

ned_cottage_close_door_after:
	ldx	#<ned_cottage_close_door_after_message
	ldy	#>ned_cottage_close_door_after_message
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
	; see if baby was deployed
	lda	INVENTORY_1_GONE
	and	#INV1_BABY
	bne	ned_cottage_open_door_after_baby

ned_cottage_open_door_before_baby:
	ldx	#<ned_cottage_open_door_message
	ldy	#>ned_cottage_open_door_message
	jmp	finish_parse_message

ned_cottage_open_door_after_baby:
	ldx	#<ned_cottage_open_door_after_baby_message
	ldy	#>ned_cottage_open_door_after_baby_message
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
	cmp	#NOUN_STONE		; not sure ifthis is canon
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

;	jsr	restore_bg_1x28

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

;	jsr	save_bg_1x28

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
ned_cottage_put:
	lda	CURRENT_NOUN

	cmp	#NOUN_BABY
	beq	ned_cottage_baby

	jmp	parse_common_unknown

ned_cottage_baby:
	; see if have baby
	lda	INVENTORY_1
	and	#INV1_BABY
	beq	ned_cottage_baby_nobaby

	; see if baby gone
	lda	INVENTORY_1_GONE
	and	#INV1_BABY
	bne	ned_cottage_baby_gone

	; check_if_rock_moved
	lda	GAME_STATE_2
	and	#COTTAGE_ROCK_MOVED
	beq	ned_cottage_baby_before

	; see if baby was deployed
	lda	INVENTORY_1_GONE
	and	#INV1_BABY
	bne	ned_cottage_baby_gone

ned_cottage_baby_deploy:
	; actually deploy baby

	ldx	#<ned_cottage_deploy_baby_message
	ldy	#>ned_cottage_deploy_baby_message
	jsr	partial_message_step

	; add points
	lda	#5
	jsr	score_points

	; baby is gone
	lda	INVENTORY_1_GONE
	ora	#INV1_BABY
	sta	INVENTORY_1_GONE


	ldx	#<ned_cottage_deploy_baby_message2
	ldy	#>ned_cottage_deploy_baby_message2
	jsr	partial_message_step

	ldx	#<ned_cottage_deploy_baby_message3
	ldy	#>ned_cottage_deploy_baby_message3
	jmp	finish_parse_message


ned_cottage_baby_before:	; before rock
	ldx	#<ned_cottage_baby_before_message
	ldy	#>ned_cottage_baby_before_message
	jmp	finish_parse_message

ned_cottage_baby_nobaby:
	ldx	#<ned_cottage_baby_nobaby_message
	ldy	#>ned_cottage_baby_nobaby_message
	jmp	finish_parse_message

ned_cottage_baby_gone:
	ldx	#<ned_cottage_baby_gone_message
	ldy	#>ned_cottage_baby_gone_message
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
	cmp	#NOUN_STONE
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
	; check to see if it has been moved
	lda	GAME_STATE_2
	and	#COTTAGE_ROCK_MOVED
	beq	ned_cottage_look_at_rock_unmoved

ned_cottage_look_at_rock_moved:
	ldx	#<ned_cottage_look_rock_moved_message
	ldy	#>ned_cottage_look_rock_moved_message
	jmp	finish_parse_message

ned_cottage_look_at_rock_unmoved:
	ldx	#<ned_cottage_look_rock_message
	ldy	#>ned_cottage_look_rock_message
	jmp	finish_parse_message

ned_cottage_look_at_hole:

	; see if baby was deployed
	lda	INVENTORY_1_GONE
	and	#INV1_BABY
	bne	ned_cottage_look_at_hole_after

ned_cottage_look_at_hole_before:
	ldx	#<ned_cottage_look_hole_message
	ldy	#>ned_cottage_look_hole_message
	jmp	finish_parse_message

ned_cottage_look_at_hole_after:
	ldx	#<ned_cottage_look_hole_after_message
	ldy	#>ned_cottage_look_hole_after_message
	jmp	finish_parse_message


.include "../text/dialog_ned_cottage.inc"
