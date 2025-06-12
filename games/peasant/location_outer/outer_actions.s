.include "../tokens.inc"

	;=======================
	;=======================
	;=======================
	; Trogdor Cave Outer
	;=======================
	;=======================
	;=======================

cave_outer_verb_table:
	.byte VERB_CLIMB
	.word cave_outer_climb-1
	.byte VERB_LOOK
	.word cave_outer_look-1
	.byte 0

	;=================
	; look
	;=================

cave_outer_look:

	lda	CURRENT_NOUN

	cmp	#NOUN_BEADS
	beq	cave_outer_look_at_curtain
	cmp	#NOUN_CURTAIN
	beq	cave_outer_look_at_curtain
	cmp	#NOUN_DOOR
	beq	cave_outer_look_at_door
	cmp	#NOUN_SKELETON
	beq	cave_outer_look_at_skeleton
	cmp	#NOUN_OPENINGS
	beq	cave_outer_look_at_openings
	cmp	#NOUN_NONE
	beq	cave_outer_look_at

	jmp	parse_common_look

cave_outer_look_at:
	ldx	#<cave_outer_look_message
	ldy	#>cave_outer_look_message
	jmp	finish_parse_message

cave_outer_look_at_curtain:
	ldx	#<cave_outer_look_curtain_message
	ldy	#>cave_outer_look_curtain_message
	jmp	finish_parse_message

cave_outer_look_at_door:
	ldx	#<cave_outer_look_door_message
	ldy	#>cave_outer_look_door_message
	jmp	finish_parse_message

cave_outer_look_at_openings:
	ldx	#<cave_outer_look_openings_message
	ldy	#>cave_outer_look_openings_message
	jmp	finish_parse_message

cave_outer_look_at_skeleton:
	ldx	#<cave_outer_look_skeleton_message
	ldy	#>cave_outer_look_skeleton_message
	jmp	finish_parse_message


	;================
	; climb
	;================
cave_outer_climb:

	lda	CURRENT_NOUN

	cmp	#NOUN_CLIFF
	beq	cave_outer_do_climb
	cmp	#NOUN_NONE
	beq	cave_outer_do_climb

	jmp	parse_common_unknown

cave_outer_do_climb:
	ldx	#<cave_outer_climb_message
	ldy	#>cave_outer_climb_message
	jmp	finish_parse_message


	;=======================
	;=======================
	;=======================
	; Trogdor Cave Outer -- Keeper 1
	;=======================
	;=======================
	;=======================

keeper1_verb_table:
	.byte VERB_TAKE
	.word keeper1_take-1
	.byte VERB_GIVE
	.word keeper1_give-1
	.byte 0

	;=============================
	; take
	;=============================
	; can only take quiz
	;

keeper1_take:
;	lda	IN_QUIZ
;	bne	actual_quiz
;	; it not being quizzed, can't try to take it??
;	jmp	parse_common_get	; is this the right path

actual_quiz:

	lda	CURRENT_NOUN

	cmp	#NOUN_QUIZ
	beq	cave_outer_take_quiz

	; if not say quiz, give hint

cave_outer_hint:
	ldx	#<cave_outer_keeper_wants_message
	ldy	#>cave_outer_keeper_wants_message
	jmp	finish_parse_message

cave_outer_take_quiz:
	inc	IN_QUIZ		; make it 2 which means wait for answer

	jsr	random8
	cmp	#85
	bcc	keeper1_quiz3
	cmp	#170
	bcc	keeper1_quiz2
keeper1_quiz1:
	lda	#0
	ldx	#<cave_outer_quiz1_1
	ldy	#>cave_outer_quiz1_1
	jmp	keeper1_quiz_common

keeper1_quiz2:
	lda	#1
	ldx	#<cave_outer_quiz1_2
	ldy	#>cave_outer_quiz1_2
	jmp	keeper1_quiz_common

keeper1_quiz3:
	lda	#2
	ldx	#<cave_outer_quiz1_3
	ldy	#>cave_outer_quiz1_3
keeper1_quiz_common:
	sta	WHICH_QUIZ
	jmp	finish_parse_message_nowait


	;=============================
	; give
	;=============================
	; can only give sub/sandwich

keeper1_give:

	lda	CURRENT_NOUN

	cmp	#NOUN_SUB
	beq	cave_outer_give_sub
	cmp	#NOUN_SANDWICH
	beq	cave_outer_give_sandwich

cave_outer_give_sub:
cave_outer_give_sandwich:

	ldx	#<cave_outer_give_sub_message
	ldy	#>cave_outer_give_sub_message
	jsr	finish_parse_message

	jsr	cave_outer_get_shield

	; FIXME: back out the keeper

	rts

parse_quiz_unknown:
	ldx     #<cave_outer_keeper_wants_message
        ldy     #>cave_outer_keeper_wants_message
        jmp     finish_parse_message


setup_quiz_verb_table:
	ldx     #0
unknown_loop:
        lda     #<(parse_quiz_unknown-1)
        sta     verb_table,X
        lda     #>(parse_quiz_unknown-1)
        sta     verb_table+1,X
        inx
        inx
        cpx     #(VERB_ALL_DONE*2)
        bne     unknown_loop

	rts

	;=============================
	; you got the shield somehow
	;=============================
cave_outer_get_shield:

	lda	#0
	sta	IN_QUIZ

	; re-set up the verb table (why?)

;	jsr	setup_outer_verb_table

	; actually get the shield

	lda	INVENTORY_2
	ora	#INV2_TROGSHIELD        ; get the shield
	sta	INVENTORY_2

	; score points
        lda     #5
        jsr     score_points

        ; FIXME: load new peasant sprite with shield

	rts


.include "../text/dialog_outer.inc"
