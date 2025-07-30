.include "../tokens.inc"

	;=======================
	;=======================
	;=======================
	; Hidden Glen
	;=======================
	;=======================
	;=======================

hidden_glen_verb_table:
        .byte VERB_SAY
        .word hidden_glen_say-1
        .byte VERB_TALK
        .word hidden_glen_talk-1
        .byte VERB_HALDO
        .word hidden_glen_haldo-1
        .byte VERB_GET
        .word hidden_glen_get-1
        .byte VERB_TAKE
        .word hidden_glen_get-1
        .byte VERB_CLIMB
        .word hidden_glen_climb-1
        .byte VERB_JUMP
        .word hidden_glen_climb-1
        .byte VERB_LOOK
        .word hidden_glen_look-1
	.byte 0

	;=================
	; say
	;=================

hidden_glen_say:
	; only say HALDO.  Wastes noun slot

	lda	CURRENT_NOUN

	cmp	#NOUN_HALDO
	beq	hidden_glen_say_haldo

	jmp	parse_common_unknown

	;=================
	; haldo
	;=================

hidden_glen_haldo:

	lda	CURRENT_NOUN

	cmp	#NOUN_NONE
	beq	hidden_glen_say_haldo

	jmp	parse_common_unknown

	;=================
	; haldo
hidden_glen_say_haldo:
	lda	GAME_STATE_0
	and	#HALDO_TO_DONGOLEV
	beq	hidden_glen_say_haldo_dongolev_there

hidden_glen_say_haldo_no_dongolev:
	ldx	#<hidden_glen_say_haldo_no_dongolev_message
	ldy	#>hidden_glen_say_haldo_no_dongolev_message
	jmp	finish_parse_message

hidden_glen_say_haldo_dongolev_there:
	; check if talked to mendelev first
	lda	GAME_STATE_0
	and	#TALKED_TO_MENDELEV
	beq	hidden_glen_say_haldo_skip_mendelev

hidden_glen_say_haldo_hooray:
	; add 3 points to score
	lda	#3
	jsr	score_points

	; set that we talked to him
	lda	GAME_STATE_0
	ora	#HALDO_TO_DONGOLEV
	sta	GAME_STATE_0

	ldx	#<hidden_glen_say_haldo_message
	ldy	#>hidden_glen_say_haldo_message
	jsr	finish_parse_message

	; update collision detection
	; do this first as we check background when drawing walking away

	jsr	archer_update_bg

	; dongolev walks away

	jsr	draw_archer_leave

	rts

hidden_glen_say_haldo_skip_mendelev:
	ldx	#<hidden_glen_say_haldo_skip_mendelev_message
	ldy	#>hidden_glen_say_haldo_skip_mendelev_message
	jmp	finish_parse_message

	;=================
	; look
	;=================

hidden_glen_look:

	lda	CURRENT_NOUN

	cmp	#NOUN_BUSH
	beq	hidden_glen_look_at_bushes
	cmp	#NOUN_ARROW
	beq	hidden_glen_look_at_arrow
	cmp	#NOUN_FENCE
	beq	hidden_glen_look_at_fence
	cmp	#NOUN_TREE
	beq	hidden_glen_look_at_tree

	cmp	#NOUN_ARCHER
	beq	hidden_glen_look_at_archer
	cmp	#NOUN_DONGOLEV
	beq	hidden_glen_look_at_archer

	cmp	#NOUN_NONE
	beq	hidden_glen_look_at

	jmp	parse_common_look

	;=================
	; look
hidden_glen_look_at:
	lda	GAME_STATE_0
	and	#HALDO_TO_DONGOLEV
	beq	hidden_glen_look_at_dongolev_yes

hidden_glen_look_at_dongolev_no:
	ldx	#<hidden_glen_look_no_dongolev_message
	ldy	#>hidden_glen_look_no_dongolev_message
	jmp	finish_parse_message

hidden_glen_look_at_dongolev_yes:
	ldx	#<hidden_glen_look_message
	ldy	#>hidden_glen_look_message
	jmp	finish_parse_message

	;=============
	; look at archer
hidden_glen_look_at_archer:
	lda	GAME_STATE_0
	and	#HALDO_TO_DONGOLEV
	beq	hidden_glen_look_at_archer_dongolev_yes

hidden_glen_look_at_archer_dongolev_no:
	jmp	parse_common_look

hidden_glen_look_at_archer_dongolev_yes:
	ldx	#<hidden_glen_look_at_archer_message
	ldy	#>hidden_glen_look_at_archer_message
	jmp	finish_parse_message

	;=============
	; look at arrow
hidden_glen_look_at_arrow:
	lda	INVENTORY_1
	and	#INV1_ARROW
	beq	hidden_glen_look_at_arrow_arrow_no

hidden_glen_look_at_arrow_arrow_yes:
	jmp	parse_common_look

hidden_glen_look_at_arrow_arrow_no:
	ldx	#<hidden_glen_look_at_arrow_message
	ldy	#>hidden_glen_look_at_arrow_message
	jmp	finish_parse_message

	;===============
	; look at bushes
hidden_glen_look_at_bushes:
	ldx	#<hidden_glen_look_at_bushes_message
	ldy	#>hidden_glen_look_at_bushes_message
	jmp	finish_parse_message

	;==============
	; look at fence
hidden_glen_look_at_fence:
	ldx	#<hidden_glen_look_at_fence_message
	ldy	#>hidden_glen_look_at_fence_message
	jmp	finish_parse_message

	;==============
	; look at tree
hidden_glen_look_at_tree:
	ldx	#<hidden_glen_look_at_tree_message
	ldy	#>hidden_glen_look_at_tree_message
	jmp	finish_parse_message

	;=================
	; climb
	;=================

hidden_glen_climb:

	lda	CURRENT_NOUN

	cmp	#NOUN_TREE
	beq	hidden_glen_climb_tree
	cmp	#NOUN_FENCE
	beq	hidden_glen_climb_fence

	jmp	parse_common_unknown

hidden_glen_climb_tree:
	ldx	#<hidden_glen_climb_tree_message
	ldy	#>hidden_glen_climb_tree_message
	jmp	finish_parse_message

hidden_glen_climb_fence:
	ldx	#<hidden_glen_climb_fence_message
	ldy	#>hidden_glen_climb_fence_message
	jmp	finish_parse_message


	;=================
	; get
	;=================

hidden_glen_get:

	lda	CURRENT_NOUN

	cmp	#NOUN_ARROW
	beq	hidden_glen_get_arrow

	jmp	parse_common_get


hidden_glen_get_arrow:
	lda	GAME_STATE_0
	and	#HALDO_TO_DONGOLEV
	bne	hidden_glen_get_arrow_dongolev_gone

hidden_glen_get_arrow_dongolev_shooting:

	; walk in place and have incident

	jsr	range_intrusion_setup

	ldx	#<hidden_glen_active_range_message
	ldy	#>hidden_glen_active_range_message
	jsr	partial_message_step

	jsr	range_intrusion_action

	ldx	#<hidden_glen_active_range_message2
	ldy	#>hidden_glen_active_range_message2
	jsr	partial_message_step

	ldx	#<hidden_glen_active_range_message3
	ldy	#>hidden_glen_active_range_message3
	jmp	finish_parse_message



hidden_glen_get_arrow_dongolev_gone:
	; see if already have arrow
	lda	INVENTORY_1
	and	#INV1_ARROW
	beq	hidden_glen_yes_get_arrow

	; see if have arrow but it is gone
	lda	INVENTORY_1_GONE
	and	#INV1_ARROW
	bne	hidden_glen_get_another

hidden_glen_all_full_up:
	ldx	#<hidden_glen_get_arrow_full_message
	ldy	#>hidden_glen_get_arrow_full_message
	jmp	finish_parse_message

hidden_glen_get_another:
	ldx	#<hidden_glen_get_arrow_another_message
	ldy	#>hidden_glen_get_arrow_another_message
	jmp	finish_parse_message

hidden_glen_yes_get_arrow:

	; walk to tree

	ldx	#15
	ldy	#84
	jsr	peasant_walkto

	; add 2 points to score
	lda	#2
	jsr	score_points

	; get arrow
	lda	INVENTORY_1
	ora	#INV1_ARROW
	sta	INVENTORY_1

	ldx	#<hidden_glen_get_arrow_message
	ldy	#>hidden_glen_get_arrow_message
	jmp	finish_parse_message


	;=================
	; talk
	;=================

hidden_glen_talk:
	; only say HALDO.  Wastes noun slot

	lda	CURRENT_NOUN

	cmp	#NOUN_ARCHER
	beq	hidden_glen_talk_archer
	cmp	#NOUN_DONGOLEV
	beq	hidden_glen_talk_archer
	cmp	#NOUN_NONE
	beq	hidden_glen_talk_archer

	jmp	parse_common_talk

hidden_glen_talk_archer:

	lda	GAME_STATE_0
	and	#HALDO_TO_DONGOLEV
	beq	hidden_glen_talk_archer_there

	jmp	parse_common_talk

hidden_glen_talk_archer_there:
	ldx	#<hidden_glen_talk_archer_message
	ldy	#>hidden_glen_talk_archer_message
	jmp	finish_parse_message


.include "../text/dialog_hidden_glen.inc"
