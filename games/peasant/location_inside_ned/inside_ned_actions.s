.include "../tokens.inc"


	;=======================
	;=======================
	;=======================
	; Inside Ned Cottage
	;=======================
	;=======================
	;=======================

inside_nn_verb_table:
	.byte VERB_LOOK
	.word inside_nn_look-1
	.byte VERB_OPEN
	.word inside_nn_open-1
	.byte VERB_CLOSE
	.word inside_nn_close-1
	.byte VERB_GET
	.word inside_nn_get-1
	.byte VERB_TAKE
	.word inside_nn_take-1
	.byte VERB_STEAL
	.word inside_nn_steal-1
	.byte 0

	;================
	; get
	;================
inside_nn_get:
inside_nn_steal:
inside_nn_take:
	lda	CURRENT_NOUN

	cmp	#NOUN_ROBE
	beq	inside_nn_get_robe
	cmp	#NOUN_DRESSER
	beq	inside_nn_get_dresser
	cmp	#NOUN_DRAWER
	beq	inside_nn_get_drawer
	cmp	#NOUN_BROOM
	beq	inside_nn_get_broom

	; else "probably wish" message

	jmp	parse_common_get

inside_nn_get_robe:
	; first see if drawer closed

	lda	GAME_STATE_2
	and	#DRESSER_OPEN
	beq	inside_nn_get_robe_drawer_closed

	; next see if already have it

	lda	INVENTORY_2
	and	#INV2_ROBE
	beq	inside_nn_actually_get_robe

inside_nn_get_robe_already_have:
	ldx	#<inside_nn_get_robe_already_message
	ldy	#>inside_nn_get_robe_already_message
	jmp	finish_parse_message

inside_nn_get_robe_drawer_closed:
	ldx	#<inside_nn_get_robe_drawer_closed_message
	ldy	#>inside_nn_get_robe_drawer_closed_message
	jmp	finish_parse_message


inside_nn_actually_get_robe:

	; walk to drawer

	jsr	walk_to_drawer

	; get 10 pts

	lda	#$10
	jsr	score_points

	; get robe

	lda	INVENTORY_2
	ora	#INV2_ROBE
	sta	INVENTORY_2

	; update image

	jsr	draw_drawer


	ldx	#<inside_nn_get_robe_message
	ldy	#>inside_nn_get_robe_message
	jmp	finish_parse_message


inside_nn_get_dresser:
inside_nn_get_drawer:
	ldx	#<inside_nn_get_dresser_message
	ldy	#>inside_nn_get_dresser_message
	jmp	finish_parse_message

inside_nn_get_broom:
	ldx	#<inside_nn_get_broom_message
	ldy	#>inside_nn_get_broom_message
	jmp	finish_parse_message


	;=================
	; look
	;=================

inside_nn_look:

	lda	CURRENT_NOUN

	cmp	#NOUN_BROOM
	beq	inside_nn_look_broom
	cmp	#NOUN_DRAWER
	beq	inside_nn_look_drawer
	cmp	#NOUN_DRESSER
	beq	inside_nn_look_dresser

	cmp	#NOUN_NONE
	beq	inside_nn_look_at

	jmp	parse_common_look

inside_nn_look_at:
	ldx	#<inside_nn_look_at_message
	ldy	#>inside_nn_look_at_message
	jmp	finish_parse_message

inside_nn_look_broom:
	ldx	#<inside_nn_look_brook_message
	ldy	#>inside_nn_look_brook_message
	jmp	finish_parse_message

inside_nn_look_dresser:
inside_nn_look_drawer:
	lda	GAME_STATE_2
	and	#DRESSER_OPEN
	bne	inside_nn_look_drawer_open

inside_nn_look_drawer_closed:

	ldx	#<inside_nn_look_closed_drawer_message
	ldy	#>inside_nn_look_closed_drawer_message
	jmp	finish_parse_message

inside_nn_look_drawer_open:
	lda	INVENTORY_2
	and	#INV2_ROBE
	bne	inside_nn_look_drawer_open_norobe

inside_nn_look_drawer_open_robe:
	ldx	#<inside_nn_look_open_drawer_message
	ldy	#>inside_nn_look_open_drawer_message
	jmp	finish_parse_message

inside_nn_look_drawer_open_norobe:
	ldx	#<inside_nn_look_norobe_drawer_message
	ldy	#>inside_nn_look_norobe_drawer_message
	jmp	finish_parse_message



	;================
	; open
	;================
inside_nn_open:
	lda	CURRENT_NOUN

	cmp	#NOUN_DRAWER
	beq	inside_nn_open_drawer
	cmp	#NOUN_DRESSER
	beq	inside_nn_open_drawer

	jmp	parse_common_unknown

inside_nn_open_drawer:
	; first check to see if it's already open

	lda	GAME_STATE_2
	and	#DRESSER_OPEN
	bne	inside_nn_open_drawer_already_open

	; see if robe has been taken

	lda	INVENTORY_2
	and	#INV2_ROBE
	beq	inside_nn_open_drawer_closed_full

inside_nn_open_drawer_closed_empty:
	ldx	#<inside_nn_open_empty_drawer_message
	ldy	#>inside_nn_open_empty_drawer_message
	jmp	finish_parse_message

inside_nn_open_drawer_closed_full:

	; walk to drawer

	jsr	walk_to_drawer

	; open the drawer

	lda	GAME_STATE_2
	ora	#DRESSER_OPEN
	sta	GAME_STATE_2

	; update image

	jsr	draw_drawer

	ldx	#<inside_nn_open_closed_drawer_message
	ldy	#>inside_nn_open_closed_drawer_message
	jmp	finish_parse_message

inside_nn_open_drawer_already_open:
	ldx	#<inside_nn_open_open_drawer_message
	ldy	#>inside_nn_open_open_drawer_message
	jmp	finish_parse_message

	;================
	; close
	;================
inside_nn_close:
	lda	CURRENT_NOUN

	cmp	#NOUN_DRAWER
	beq	inside_nn_close_drawer
	cmp	#NOUN_DRESSER
	beq	inside_nn_close_drawer

	jmp	parse_common_unknown

inside_nn_close_drawer:
	; first check to see if it's open

	lda	GAME_STATE_2
	and	#DRESSER_OPEN
	bne	inside_nn_close_drawer_open

inside_nn_close_drawer_closed:
	ldx	#<inside_nn_close_closed_drawer_message
	ldy	#>inside_nn_close_closed_drawer_message
	jmp	finish_parse_message

inside_nn_close_drawer_open:

	; walk to drawer

	jsr	walk_to_drawer

	; regardless, we close the drawer

	lda	GAME_STATE_2
	and	#<(~DRESSER_OPEN)
	sta	GAME_STATE_2

	; update image

	jsr	draw_drawer

	; see if robe has been taken

	lda	INVENTORY_2
	and	#INV2_ROBE
	beq	inside_nn_close_drawer_full

inside_nn_close_drawer_empty:
	; get 1 pt

	lda	#1
	jsr	score_points

	ldx	#<inside_nn_close_empty_drawer_message
	ldy	#>inside_nn_close_empty_drawer_message
	jmp	finish_parse_message

inside_nn_close_drawer_full:

	ldx	#<inside_nn_close_full_drawer_message
	ldy	#>inside_nn_close_full_drawer_message
	jmp	finish_parse_message




.include "../text/dialog_inside_ned.inc"
