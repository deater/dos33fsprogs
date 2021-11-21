; notes
; walk into footprint land
; if kerrek alive
;	odds of kerrek there  are ??? 50/50?
; if kerrek dead
;	if dead on this screen
;	if dead not on this screen


kerrek_setup:
	; first see if Kerrek alive
	lda	KERREK_STATE
	and	#$f
	bne	kerrek_setup_dead

kerrek_setup_alive:
	jsr	random16
	and	#$1
	beq	kerrek_alive_not_there
kerrek_alive_out:

	lda	#20
	sta	KERREK_X
	lda	#100
	sta	KERREK_Y
	lda	#0
	sta	KERREK_DIRECTION
	lda	#1
	sta	KERREK_SPEED

	lda	MAP_LOCATION
	cmp	#LOCATION_KERREK_1
	bne	kerrek_there

	lda	KERREK_STATE
	ora	#KERREK_ROW1
	sta	KERREK_STATE

kerrek_there:
	lda	KERREK_STATE
	ora	#KERREK_ONSCREEN
	sta	KERREK_STATE

	rts

kerrek_alive_not_there:

kerrek_not_there:
	lda	KERREK_STATE
	and	#(~KERREK_ONSCREEN)
	sta	KERREK_STATE
	rts

kerrek_setup_dead:

	; see if on this screen

	lda	KERREK_STATE
	and	#KERREK_ROW1
	beq	kerrek_row4
kerrek_row1:
	lda	MAP_LOCATION
	cmp	#LOCATION_KERREK_1
	beq	kerrek_there
	bne	kerrek_not_there

kerrek_row4:
	lda	MAP_LOCATION
	cmp	#LOCATION_KERREK_2
	beq	kerrek_there
	bne	kerrek_not_there

	rts


	;=======================
	;=======================
	;=======================
	; Kerrek
	;=======================
	;=======================
	;=======================

kerrek_verb_table:
	.byte VERB_LOAD
	.word kerrek_load-1
	.byte VERB_SAVE
	.word kerrek_save-1
	.byte VERB_LOOK
	.word kerrek_look-1
	.byte VERB_SHOOT
	.word kerrek_shoot-1
	.byte VERB_KILL
	.word kerrek_kill-1
	.byte VERB_TALK
	.word kerrek_talk-1
	.byte VERB_MAKE
	.word kerrek_make-1
	.byte VERB_BUY
	.word kerrek_buy-1
	.byte 0

	;=================
	; buy
	;=================
kerrek_buy:

	lda	CURRENT_NOUN
	cmp	#NOUN_KERREK
	bne	kerrek_buy_not_there

	lda	KERREK_STATE
	bpl	kerrek_buy_not_there

	lda	KERREK_STATE
	and	#$f
	bne	kerrek_buy_not_there

	inc	KERREK_SPEED

	ldx	#<kerrek_buy_cold_one_message
	ldy	#>kerrek_buy_cold_one_message
	jmp	finish_parse_message

kerrek_buy_not_there:
	jmp	parse_common_unknown


	;=================
	; make
	;=================
kerrek_make:
	lda	CURRENT_NOUN
	cmp	#NOUN_KERREK
	bne	kerrek_make_not_there

	lda	KERREK_STATE
	bpl	kerrek_make_not_there

	lda	KERREK_STATE
	and	#$f
	bne	kerrek_make_not_there

	ldx	#<kerrek_make_friends_message
	ldy	#>kerrek_make_friends_message
	jmp	finish_parse_message

kerrek_make_not_there:
	jmp	parse_common_unknown

	;=================
	; talk
	;=================
kerrek_talk:
	lda	CURRENT_NOUN
	cmp	#NOUN_KERREK
	bne	kerrek_talk_not_there

	lda	KERREK_STATE
	bpl	kerrek_talk_not_there

	lda	KERREK_STATE
	and	#$f
	bne	kerrek_talk_not_there

kerrek_there_talk:
	ldx	#<kerrek_talk_message
	ldy	#>kerrek_talk_message
	jmp	finish_parse_message

kerrek_talk_not_there:
	jmp	parse_common_talk



	;=================
	; load/save
	;=================
kerrek_load:
	lda	KERREK_STATE
	bmi	kerrek_load_there
	jmp	parse_common_load
kerrek_load_there:
	ldx	#<kerrek_load_save_message
	ldy	#>kerrek_load_save_message
	jmp	finish_parse_message

kerrek_save:
	lda	KERREK_STATE
	bmi	kerrek_load_there
	jmp	parse_common_save

	;=================
	; kill/shoot
	;=================
kerrek_kill:
kerrek_shoot:

	rts


	;=================
	; look
	;=================

kerrek_look:

	lda	CURRENT_NOUN

	cmp	#NOUN_FOOTPRINTS
	beq	kerrek_look_footprints
	cmp	#NOUN_TRACKS
	beq	kerrek_look_tracks

	cmp	#NOUN_NONE
	beq	kerrek_look_at

	jmp	parse_common_look

kerrek_look_at:
	lda	KERREK_STATE
	bmi	kerrek_look_none_kerrek

kerrek_look_none_no_kerrek:
	lda	KERREK_STATE
	and	#$f
	beq	kerrek_look_none_kerrek_alive
kerrek_look_none_kerrek_dead:
	ldx	#<kerrek_look_no_dead_kerrek_message
	ldy	#>kerrek_look_no_dead_kerrek_message
	jmp	finish_parse_message

kerrek_look_none_kerrek_alive:
	ldx	#<kerrek_look_no_kerrek_message
	ldy	#>kerrek_look_no_kerrek_message
	jmp	finish_parse_message

kerrek_look_none_kerrek:
	ldx	#<kerrek_look_kerrek_message
	ldy	#>kerrek_look_kerrek_message
	jmp	finish_parse_message

kerrek_look_tracks:
kerrek_look_footprints:
	lda	KERREK_STATE
	bpl	kerrek_look_none_kerrek

	ldx	#<kerrek_look_footprints_message
	ldy	#>kerrek_look_footprints_message
	jmp	finish_parse_message



