	;==================================
	;==================================
	;==================================
	; Trogdor Cave Outer -- Keeper 3
	;==================================
	;==================================
	;==================================

keeper3_verb_table:
	.byte VERB_TAKE
	.word keeper3_take-1
	.byte VERB_GIVE
	.word keeper3_give-1
	.byte 0

	;=============================
	; take
	;=============================
	; can only take quiz
	;

keeper3_take:
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
	bcc	keeper3_quiz3
	cmp	#170
	bcc	keeper3_quiz2
keeper3_quiz1:
	lda	#0
	jmp	keeper3_quiz_common

keeper3_quiz2:
	lda	#1
	jmp	keeper3_quiz_common

keeper3_quiz3:
	lda	#2
keeper3_quiz_common:
	sta	WHICH_QUIZ
	rts


	;=============================
	; give
	;=============================
	; can only give pills

keeper3_give:

	lda	CURRENT_NOUN

	cmp	#NOUN_PILLS
	beq	cave_outer_give_pills
	bne	parse_quiz_unknown

cave_outer_give_pills:

	ldx	#<cave_outer_give_pills_message
	ldy	#>cave_outer_give_pills_message
	jsr	finish_parse_message

	;============================
	; take pills out of inventory

	lda	INVENTORY_1_GONE
	ora	#INV1_PILLS
	sta	INVENTORY_1_GONE

	jsr	cave_outer_get_sword

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
	; you got the sword somehow
	;=============================
cave_outer_get_sword:

	; re-set up the verb table

	jsr	setup_outer_verb_table

	; actually get the sword

	lda	INVENTORY_2
	ora	#INV2_TROGSWORD		; get the sword
	sta	INVENTORY_2

	; score points
        lda     #5
        jsr     score_points

	;=====================================
        ; load new peasant sprite with shield

	lda	#PEASANT_OUTFIT_SWORD
	jsr	load_peasant_sprites


	;=================================
	; print sword message

	ldx	#<cave_outer_quiz3_correct_part4
	ldy	#>cave_outer_quiz3_correct_part4
	jsr	finish_parse_message

	;==============================================
	; get sword, back out the keeper, open curtain

	jsr	get_sword


	;==========================================
	; exit quiz last so we keep drawing keeper

	lda	#0
	sta	IN_QUIZ



	rts


.include "../text/dialog_outer3.inc"
