
	;=======================
	;=======================
	;=======================
	; Kerrek
	;=======================
	;=======================
	;=======================

kerrek_verb_table:
	.byte VERB_GET
	.word kerrek_get-1
	.byte VERB_LOAD
	.word kerrek_load-1
	.byte VERB_SAVE
	.word kerrek_save-1
	.byte VERB_LOOK
	.word kerrek_look-1
	.byte VERB_SHOOT
	.word kerrek_shoot-1
	.byte VERB_USE
	.word kerrek_use-1
	.byte VERB_KILL
	.word kerrek_kill-1
	.byte VERB_ATTACK		; also SMOTE and SMITE?
	.word kerrek_kill-1
	.byte VERB_TALK
	.word kerrek_talk-1
	.byte VERB_MAKE
	.word kerrek_make-1
	.byte VERB_BUY
	.word kerrek_buy-1
	.byte 0

	;=================
	; get
	;=================
kerrek_get:

	lda	CURRENT_NOUN

	cmp	#NOUN_KERREK
	beq	kerrek_get_kerrek
	cmp	#NOUN_MONSTER
	beq	kerrek_get_kerrek
	cmp	#NOUN_ARROW
	beq	kerrek_get_arrow
	cmp	#NOUN_BELT		; also includes BUCKLE and SHINY
	beq	kerrek_get_belt

kerrek_cant_get:
	jmp	parse_common_get

kerrek_get_kerrek:
	ldx	#<kerrek_get_kerrek_message
	ldy	#>kerrek_get_kerrek_message
	jmp	finish_parse_message

kerrek_get_arrow:
	; only if kerrek dead and on screen

	lda	KERREK_STATE		; skip if not onscreen
	bpl	kerrek_cant_get

	lda	GAME_STATE_3
	and	#KERREK_DEAD
	beq	kerrek_cant_get		; skip if not dead

	ldx	#<kerrek_get_arrow_message
	ldy	#>kerrek_get_arrow_message
	jmp	finish_parse_message

kerrek_get_belt:

	; only if kerrek dead and on screen

	lda	KERREK_STATE
	bpl	kerrek_cant_get

	lda	GAME_STATE_3
	and	#KERREK_DEAD
	beq	kerrek_cant_get		; skip if not dead

	lda	INVENTORY_1
	and	#INV1_KERREK_BELT
	bne	kerrek_get_belt_already

kerrek_get_belt_finally:
	; get belt
	; add 10 to score

	lda	INVENTORY_1
	ora	#INV1_KERREK_BELT
	sta	INVENTORY_1

	lda	#$10		; it's BCD
	jsr	score_points

	ldx	#<kerrek_get_belt_message
	ldy	#>kerrek_get_belt_message
	jmp	finish_parse_message

kerrek_get_belt_already:
	ldx	#<kerrek_get_belt_already_message
	ldy	#>kerrek_get_belt_already_message
	jmp	finish_parse_message


	;=================
	; buy
	;=================
kerrek_buy:

	lda	CURRENT_NOUN
	cmp	#NOUN_KERREK
	bne	kerrek_buy_not_there

	lda	KERREK_STATE
	bpl	kerrek_buy_not_there

	lda	GAME_STATE_3
	and	#KERREK_DEAD
	bne	kerrek_buy_not_there

	; increase speed.  actual games goes to 8????
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

	lda	GAME_STATE_3
	and	#KERREK_DEAD
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

	lda	GAME_STATE_3
	and	#KERREK_DEAD
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
	bpl	kerrek_load_not_there

	lda	GAME_STATE_3
	and	#KERREK_DEAD
	bne	kerrek_load_not_there

kerrek_load_there:
	ldx	#<kerrek_load_save_message
	ldy	#>kerrek_load_save_message
	jmp	finish_parse_message

kerrek_load_not_there:
	jmp	parse_common_load


kerrek_save:
	lda	KERREK_STATE
	bpl	kerrek_save_not_there

	lda	GAME_STATE_3
	and	#KERREK_DEAD
	bne	kerrek_save_not_there

kerrek_save_there:
	jmp	kerrek_load_there

kerrek_save_not_there:
	jmp	parse_common_save



	;=================
	; use
	;=================
kerrek_use:
	lda	CURRENT_NOUN
	cmp	#NOUN_ARROW
	beq	kerrek_kill_kerrek
	cmp	#NOUN_BOW
	beq	kerrek_kill_kerrek

	jmp	parse_common_unknown	; should this be use?


	;===================
	; kill/shoot/attack
	;===================
	; shoot arrow/bow/kerrek/monster
	; kill/smote/smite/attack kerrek/monster

kerrek_kill:
kerrek_shoot:
	; check we are trying to kill kerrek?
	lda	CURRENT_NOUN
	cmp	#NOUN_KERREK
	beq	kerrek_kill_kerrek
	cmp	#NOUN_MONSTER
	beq	kerrek_kill_kerrek
	cmp	#NOUN_ARROW
	beq	kerrek_kill_kerrek
	cmp	#NOUN_BOW
	beq	kerrek_kill_kerrek

	jmp	parse_common_unknown

kerrek_kill_kerrek:

	; first check if Kerrek is alive
	lda	GAME_STATE_3
	and	#KERREK_DEAD
	beq	kerrek_kill_still_alive

kerrek_kill_hes_dead:
	ldx	#<kerrek_kill_kerrek_dead_message
	ldy	#>kerrek_kill_kerrek_dead_message
	jmp	finish_parse_message

kerrek_kill_still_alive:

	; next check if he's on screen
	lda	KERREK_STATE
	bmi	kerrek_kill_on_screen

kerrek_kill_off_screen:
	ldx	#<kerrek_kill_kerrek_not_there_message
	ldy	#>kerrek_kill_kerrek_not_there_message
	jmp	finish_parse_message

kerrek_kill_on_screen:
	; he's alive and on screen

	; check if have bow and arrow

	lda	INVENTORY_1
	and	#(INV1_BOW | INV1_ARROW)
	beq	kerrek_kill_no_bow_no_arrow
	cmp	#INV1_BOW
	beq	kerrek_kill_only_bow
	cmp	#INV1_ARROW
	beq	kerrek_kill_only_arrow

kerrek_actually_kill:
	ldx	#<kerrek_kill_message
	ldy	#>kerrek_kill_message
	jsr	partial_message_step

	ldx	#<kerrek_kill_message2
	ldy	#>kerrek_kill_message2
	jsr	partial_message_step

	lda	#5
	jsr	score_points

	; make kerrek dead

	lda	GAME_STATE_3
	ora	#KERREK_DEAD
	sta	GAME_STATE_3

	; draw body on background

	jsr	kerrek_draw_body

	; make it rain, make the puddle wet

	lda	GAME_STATE_1
	ora	#(PUDDLE_WET)
	sta	GAME_STATE_1

	lda	#6			; should this be 5?
	sta	RAIN_COUNT

	ldx	#<kerrek_kill_message3
	ldy	#>kerrek_kill_message3
	jmp	finish_parse_message


kerrek_kill_only_bow:
	ldx	#<kerrek_kill_only_bow_message
	ldy	#>kerrek_kill_only_bow_message
	jmp	finish_parse_message

kerrek_kill_only_arrow:
	ldx	#<kerrek_kill_only_arrow_message
	ldy	#>kerrek_kill_only_arrow_message
	jmp	finish_parse_message

kerrek_kill_no_bow_no_arrow:
	ldx	#<kerrek_kill_no_bow_no_arrow_message
	ldy	#>kerrek_kill_no_bow_no_arrow_message
	jmp	finish_parse_message


	;=================
	; look
	;=================

kerrek_look:

	; first see if kerrek is on screen

	lda	KERREK_STATE
	bmi	kerrek_look_there
	jmp	kerrek_look_not_there	; jump too far

kerrek_look_there:

	; check if there and alive

	lda	GAME_STATE_3
	and	#KERREK_DEAD
	bne	kerrek_look_there_dead

kerrek_look_there_alive:

	; see what we're looking at

	lda	CURRENT_NOUN

	cmp	#NOUN_BELT
	beq	kerrek_look_belt_alive

	; kerrek was there and alive
kerrek_look_there_alive_everything_else:
	ldx	#<kerrek_look_kerrek_message
	ldy	#>kerrek_look_kerrek_message
	jmp	finish_parse_message

kerrek_look_belt_alive:
	ldx	#<kerrek_look_belt_alive_message
	ldy	#>kerrek_look_belt_alive_message
	jmp	finish_parse_message


kerrek_look_there_dead:

	; kerrek was there and dead

	lda	KERREK_STATE
	and	#KERREK_SCREENS_POST_BELT_MASK

	cmp	#10					; <10 dead body
	bcc	kerrek_look_there_dead_dead
	cmp	#15
	bcc	kerrek_look_there_dead_decomposing	; <15 decompsing
;	cmp	#KERREK_SKELETON			; else, skeleton


	;============================
	; look, kerrek is a skeleton
	;============================

	; here is kerrek a skeleton
kerrek_look_there_dead_bones:
	lda	CURRENT_NOUN
	cmp	#NOUN_BONE
	beq	kerrek_look_there_dead_bones_bones
	cmp	#NOUN_KERREK
	beq	kerrek_look_there_dead_bones_kerrek
	cmp	#NOUN_MONSTER
	beq	kerrek_look_there_dead_bones_kerrek
	cmp	#NOUN_NONE
	beq	kerrek_look_there_dead_bones_default

	jmp	parse_common_look

kerrek_look_there_dead_bones_default:
	; typed "look" after kerrek a skeleton
	ldx	#<kerrek_look_kerrek_bones_message
	ldy	#>kerrek_look_kerrek_bones_message
	jmp	finish_parse_message

kerrek_look_there_dead_bones_kerrek:
	; typed "look kerrek" after kerrek a skeleton

	ldx	#<kerrek_look_bones_kerrek_message
	ldy	#>kerrek_look_bones_kerrek_message
	jmp	finish_parse_message

kerrek_look_there_dead_bones_bones:
	; typed "look bones" after kerrek a skeleton

	ldx	#<kerrek_look_bones_message
	ldy	#>kerrek_look_bones_message
	jmp	finish_parse_message


	;==============================
	; look, kerrek is freshly dead
	;==============================

kerrek_look_there_dead_dead:
	lda	CURRENT_NOUN
	cmp	#NOUN_KERREK
	beq	kerrek_look_there_dead_look_kerrek
	cmp	#NOUN_MONSTER
	beq	kerrek_look_there_dead_look_kerrek
	cmp	#NOUN_NONE
	beq	kerrek_look_there_dead_look
	jmp	parse_common_look

	; typed "look" when kerrek just killed
kerrek_look_there_dead_look:
	ldx	#<kerrek_look_dead_message
	ldy	#>kerrek_look_dead_message
	jmp	finish_parse_message


	; typed "look kerrek" when kerrek just killed
kerrek_look_there_dead_look_kerrek:

	; see if belt there

	lda	INVENTORY_1
	and	#INV1_KERREK_BELT
	bne	kerrek_look_there_dead_look_kerrek_no_belt

kerrek_look_there_dead_look_kerrek_belt:
	ldx	#<kerrek_look_kerrek_dead_message
	ldy	#>kerrek_look_kerrek_dead_message
	jmp	finish_parse_message

kerrek_look_there_dead_look_kerrek_no_belt:
	ldx	#<kerrek_look_kerrek_dead_nobelt_message
	ldy	#>kerrek_look_kerrek_dead_nobelt_message
	jmp	finish_parse_message


	;==============================
	; look, kerrek is decomposing
	;==============================

	; here if kerrek is in decompsing state
kerrek_look_there_dead_decomposing:
	lda	CURRENT_NOUN
	cmp	#NOUN_KERREK
	beq	kerrek_look_there_dead_decomposing_kerrek
	cmp	#NOUN_MONSTER
	beq	kerrek_look_there_dead_decomposing_kerrek
	cmp	#NOUN_NONE
	beq	kerrek_look_dead_decomposing

	jmp	parse_common_look

kerrek_look_dead_decomposing:

	; here if "look" when decomposing
	ldx	#<kerrek_look_decomposing_message
	ldy	#>kerrek_look_decomposing_message
	jmp	finish_parse_message

kerrek_look_there_dead_decomposing_kerrek:
	; here if "look kerrek" when decomposing

	ldx	#<kerrek_look_kerrek_decomposing_message
	ldy	#>kerrek_look_kerrek_decomposing_message
	jmp	finish_parse_message


	;==============================
	; look, kerrek is not there
	;==============================

kerrek_look_not_there:

	lda	CURRENT_NOUN

	cmp	#NOUN_FOOTPRINTS
	beq	kerrek_look_footprints
	cmp	#NOUN_TRACKS
	beq	kerrek_look_footprints
	cmp	#NOUN_NONE
	beq	kerrek_look_not_there_none

	jmp	parse_common_look

kerrek_look_not_there_none:

	; check if alive elsewhere

	lda	GAME_STATE_3
	and	#KERREK_DEAD
	bne	kerrek_look_not_there_dead

kerrek_look_not_there_alive:

	ldx	#<kerrek_look_no_kerrek_message
	ldy	#>kerrek_look_no_kerrek_message
	jmp	finish_parse_message

kerrek_look_not_there_dead:

	ldx	#<kerrek_look_no_dead_kerrek_message
	ldy	#>kerrek_look_no_dead_kerrek_message
	jmp	finish_parse_message

kerrek_look_tracks:
kerrek_look_footprints:
	ldx	#<kerrek_look_footprints_message
	ldy	#>kerrek_look_footprints_message
	jmp	finish_parse_message


