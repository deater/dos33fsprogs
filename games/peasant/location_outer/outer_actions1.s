	;=======================================
	;=======================================
	;=======================================
	; Trogdor Cave Outer -- Keeper 1
	;=======================================
	;=======================================
	;=======================================

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
;	ldx	#<cave_outer_quiz1_1
;	ldy	#>cave_outer_quiz1_1
	jmp	keeper1_quiz_common

keeper1_quiz2:
	lda	#1
;	ldx	#<cave_outer_quiz1_2
;	ldy	#>cave_outer_quiz1_2
	jmp	keeper1_quiz_common

keeper1_quiz3:
	lda	#2
;	ldx	#<cave_outer_quiz1_3
;	ldy	#>cave_outer_quiz1_3
keeper1_quiz_common:
	sta	WHICH_QUIZ
	rts
;	jmp	finish_parse_message_nowait


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
	bne	parse_quiz_unknown

cave_outer_give_sub:
cave_outer_give_sandwich:

	ldx	#<cave_outer_give_sub_message
	ldy	#>cave_outer_give_sub_message
	jsr	finish_parse_message

	jsr	cave_outer_get_shield

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

	; re-set up the verb table

	jsr	setup_outer_verb_table

	; actually get the shield

	lda	INVENTORY_2
	ora	#INV2_TROGSHIELD        ; get the shield
	sta	INVENTORY_2

	; score points
        lda     #5
        jsr     score_points

	;=================================
        ; load new peasant sprite with shield

	lda	#PEASANT_OUTFIT_SHIELD
	jsr	load_peasant_sprites

	;==================
	; back out the keeper

	jsr	keeper1_retreat


	;==========================================
	; exit quiz last so we keep drawing keeper

	lda	#0
	sta	IN_QUIZ

	rts

.include "../text/dialog_outer1.inc"
