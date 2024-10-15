.include "../tokens.inc"

	;=======================
	;=======================
	;=======================
	; Cliff Heights
	;=======================
	;=======================
	;=======================

	; This one is complex, should we have multiple verb tables
	;	for when taking quiz?


cliff_heights_verb_table:
	.byte VERB_GET
	.word cliff_heights_get-1
	.byte VERB_TAKE
	.word cliff_heights_get-1
	.byte VERB_STEAL
	.word cliff_heights_get-1
	.byte VERB_CLIMB
	.word cliff_heights_climb-1
	.byte VERB_LOOK
	.word cliff_heights_look-1
	.byte 0

	;================
	; climb
	;================
cliff_heights_climb:

	lda	CURRENT_NOUN

	cmp	#NOUN_CLIFF
	beq	cliff_heights_do_climb
	cmp	#NOUN_NONE
	beq	cliff_heights_do_climb

	jmp	parse_common_unknown

cliff_heights_do_climb:
	ldx	#<cliff_heights_climb_message
	ldy	#>cliff_heights_climb_message
	jmp	finish_parse_message


	;================
	; get
	;================
cliff_heights_get:
cliff_heights_steal:
cliff_heights_take:
	lda	CURRENT_NOUN

	cmp	#NOUN_BONE
	beq	cliff_heights_get_bone
	cmp	#NOUN_SKULL
	beq	cliff_heights_get_bone

	; else "probably wish" message

	jmp	parse_common_get

cliff_heights_get_bone:
	ldx	#<cliff_heights_get_bone_message
	ldy	#>cliff_heights_get_bone_message
	jmp	finish_parse_message

	;=================
	; look
	;=================

cliff_heights_look:

	lda	CURRENT_NOUN

	cmp	#NOUN_LIGHTNING
	beq	cliff_heights_look_at_lightning
	cmp	#NOUN_CAVE
	beq	cliff_heights_look_at_cave
	cmp	#NOUN_BONE
	beq	cliff_heights_look_at_bone
	cmp	#NOUN_SKULL
	beq	cliff_heights_look_at_bone
	cmp	#NOUN_NONE
	beq	cliff_heights_look_at

	jmp	parse_common_look

cliff_heights_look_at:
	ldx	#<cliff_heights_look_at_message
	ldy	#>cliff_heights_look_at_message
	jmp	finish_parse_message

cliff_heights_look_at_bone:
	ldx	#<cliff_heights_look_bone_message
	ldy	#>cliff_heights_look_bone_message
	jmp	finish_parse_message

cliff_heights_look_at_cave:
	ldx	#<cliff_heights_look_cave_message
	ldy	#>cliff_heights_look_cave_message
	jmp	finish_parse_message

cliff_heights_look_at_lightning:
	ldx	#<cliff_heights_look_lightning_message
	ldy	#>cliff_heights_look_lightning_message
	jmp	finish_parse_message


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
	jsr	random8
	cmp	#85
	bcc	keeper1_quiz3
	cmp	#170
	bcc	keeper1_quiz2
keeper1_quiz1:
	ldx	#<cave_outer_quiz1_1
	ldy	#>cave_outer_quiz1_1
	jmp	finish_parse_message

keeper1_quiz2:
	ldx	#<cave_outer_quiz1_2
	ldy	#>cave_outer_quiz1_2
	jmp	finish_parse_message

keeper1_quiz3:
	ldx	#<cave_outer_quiz1_3
	ldy	#>cave_outer_quiz1_3
	jmp	finish_parse_message


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
	; TODO
	;	give points
	;	give shield
	;	change peasant sprites

	ldx	#<cave_outer_give_sub_message
	ldy	#>cave_outer_give_sub_message
	jmp	finish_parse_message

parse_quiz_unknown:
	ldx     #<cave_outer_keeper_wants_message
        ldy     #>cave_outer_keeper_wants_message
        jmp     finish_parse_message

verb_table = $BF00


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


.include "../text/dialog_cliff_heights.inc"
