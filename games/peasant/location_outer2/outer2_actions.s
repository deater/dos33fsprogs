	;==================================
	;==================================
	;==================================
	; Trogdor Cave Outer -- Keeper 2
	;==================================
	;==================================
	;==================================

keeper2_verb_table:
	.byte VERB_TAKE
	.word keeper2_take-1
	.byte VERB_GIVE
	.word keeper2_give-1
	.byte 0

	;=============================
	; take
	;=============================
	; can only take quiz
	;

keeper2_take:
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
	bcc	keeper2_quiz3
	cmp	#170
	bcc	keeper2_quiz2
keeper2_quiz1:
	lda	#0
	jmp	keeper2_quiz_common

keeper2_quiz2:
	lda	#1
	jmp	keeper2_quiz_common

keeper2_quiz3:
	lda	#2
keeper2_quiz_common:
	sta	WHICH_QUIZ
	rts


	;=============================
	; give
	;=============================
	; can only give soda

keeper2_give:

	lda	CURRENT_NOUN

	cmp	#NOUN_SODA
	beq	cave_outer_give_soda
	bne	parse_quiz_unknown

cave_outer_give_soda:

	ldx	#<cave_outer_give_soda_message
	ldy	#>cave_outer_give_soda_message
	jsr	finish_parse_message

	;============================
	; take soda out of inventory

	lda	INVENTORY_2_GONE
	ora	#INV2_SODA
	sta	INVENTORY_2_GONE

	jsr	cave_outer_get_helm

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
	; you got the helm somehow
	;=============================
cave_outer_get_helm:

	; re-set up the verb table

	jsr	setup_outer_verb_table

	; actually get the helm

	lda	INVENTORY_2
	ora	#INV2_TROGHELM		; get the helm
	sta	INVENTORY_2

	; score points
        lda     #5
        jsr     score_points

	;=====================================
        ; load new peasant sprite with shield

	lda	#PEASANT_OUTFIT_HELM
	jsr	load_peasant_sprites

	;==================
	; back out the keeper

	jsr	keeper2_retreat


	;==========================================
	; exit quiz last so we keep drawing keeper

	lda	#0
	sta	IN_QUIZ



	rts


.include "../text/dialog_outer2.inc"
