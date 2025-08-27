.include "../tokens.inc"


	;=======================
	;=======================
	;=======================
	; Jhonka Cave
	;=======================
	;=======================
	;=======================

jhonka_cave_verb_table:
	.byte VERB_CLIMB
	.word jhonka_climb-1
	.byte VERB_GET
	.word jhonka_get-1
	.byte VERB_TAKE
	.word jhonka_get-1
	.byte VERB_STEAL
	.word jhonka_get-1
	.byte VERB_JUMP
	.word jhonka_jump-1
	.byte VERB_LOOK
	.word jhonka_look-1
	.byte VERB_OPEN
	.word jhonka_open-1
	.byte VERB_READ
	.word jhonka_read-1
	.byte VERB_KNOCK
	.word jhonka_knock-1
	.byte VERB_ASK
	.word jhonka_ask-1
	.byte VERB_TALK
	.word jhonka_talk-1
	.byte VERB_GIVE
	.word jhonka_give-1
	.byte VERB_KILL
	.word jhonka_kill-1
	.byte 0


jhonka_cave_quiz_verb_table:
	.byte VERB_YES
	.word jhonka_verb_yes-1
	.byte VERB_NO
	.word jhonka_verb_no-1
	.byte 0



	;================
	; climb
	;================
jhonka_jump:
jhonka_climb:
	lda	CURRENT_NOUN

	cmp	#NOUN_FENCE
	beq	jhonka_climb_fence

	jmp	parse_common_unknown

jhonka_climb_fence:
	ldx	#<jhonka_climb_fence_message
	ldy	#>jhonka_climb_fence_message
	jmp	finish_parse_message


	;================
	; get
	;================
jhonka_get:
	; check if alive
	jsr	check_kerrek_dead
	bcs	jhonka_get_kerrek_dead

jhonka_get_kerrek_alive:

	lda	CURRENT_NOUN

	cmp	#NOUN_NOTE
	beq	jhonka_get_note

	; else "probably wish" message
	jmp	parse_common_get

jhonka_get_note:
	ldx	#<jhonka_get_note_message
	ldy	#>jhonka_get_note_message
	jmp	finish_parse_message


jhonka_get_kerrek_dead:

	lda	CURRENT_NOUN

	cmp	#NOUN_RICHES
	beq	jhonka_get_riches
	cmp	#NOUN_CLUB
	beq	jhonka_get_club
	cmp	#NOUN_LEG
	beq	jhonka_get_club
	cmp	#NOUN_NOTE
	beq	jhonka_get_note

	; else "probably wish" message
	jmp	parse_common_get

jhonka_get_club:
	ldx	#<jhonka_get_club_message
	ldy	#>jhonka_get_club_message
	jmp	finish_parse_message

jhonka_get_riches:

	; check if in hay bale

	lda	GAME_STATE_1
	and	#IN_HAY_BALE
	bne	jhonka_get_riches_in_hay

jhonka_get_riches_no_hay:
	ldx	#<jhonka_get_riches_no_hay_message
	ldy	#>jhonka_get_riches_no_hay_message
	jmp	finish_parse_message

jhonka_get_riches_in_hay:

	; walk to the riches

	ldx	#15			; 105/7 = 15
	ldy	#77
	jsr	peasant_walkto

	; face downward

	lda	#PEASANT_DIR_DOWN
	sta	PEASANT_DIR

	; get riches

	lda	GAME_STATE_3
	ora	#GOT_RICHES
	sta	GAME_STATE_3

	lda	INVENTORY_2
	ora	#INV2_RICHES
	sta	INVENTORY_2

	jsr	remove_riches

	; exit hay bale
	jsr	blow_away_hay_no_message

	ldx	#<jhonka_steal_riches_message
	ldy	#>jhonka_steal_riches_message
	jsr	partial_message_step


;	lda	GAME_STATE_1
;	and	#<(~IN_HAY_BALE)
;	sta	GAME_STATE_1

	; no longer muddy
;	lda	GAME_STATE_2
;	and	#<(~COVERED_IN_MUD)
;	sta	GAME_STATE_2

	; change back to street clothes

;	lda	#PEASANT_OUTFIT_SHORTS
;	jsr	load_peasant_sprites


jhonka_wait_for_answer:
	; this is like the quizzes at the end
	; you can't move, only answer question

	inc	IN_QUIZ			; being quizzed

	lda	#<jhonka_cave_quiz_verb_table
	sta	INL
	lda	#>jhonka_cave_quiz_verb_table
	sta	INH

	jsr	clear_default_verb_table	; clear out defaults
						; so only want yes/no
	jsr	load_custom_verb_table

	lda	#<jhonka_answer_him_message
	sta	parse_unknown_smc1+1
	lda	#>jhonka_answer_him_message
	sta	parse_unknown_smc2+1


;	lda	#$60			; modify parse input to return
;	sta	parse_input_smc		; rather than verb-jump

;	jsr	clear_bottom
;	jsr	hgr_input

;	jsr	parse_input

;	lda	CURRENT_VERB
;	cmp	#VERB_NO
;	beq	jhonka_verb_no
;	cmp	#VERB_YES
;	beq	jhonka_verb_yes

;	ldx	#<jhonka_answer_him_message
;	ldy	#>jhonka_answer_him_message
;	jsr	partial_message_step

;	jmp	jhonka_wait_for_answer

	rts

jhonka_verb_no:
	; cancel quiz

	lda	#0
	sta	IN_QUIZ

	; restore original verb table

	jsr	setup_default_verb_table

	lda	#<jhonka_cave_verb_table
	sta	INL
	lda	#>jhonka_cave_verb_table
	sta	INH

	jsr	load_custom_verb_table

	lda	#<unknown_message
	sta	parse_unknown_smc1+1
	lda	#>unknown_message
	sta	parse_unknown_smc2+1

	; dry up the mud
	lda	GAME_STATE_1
	and	#<(~PUDDLE_WET)
	sta	GAME_STATE_1

	; add 7 points
	lda	#7
	jsr	score_points

	ldx	#<jhonka_no_message
	ldy	#>jhonka_no_message
	jmp	finish_parse_message

jhonka_verb_yes:

	; we don't need to restore verb table because we're dying?


	ldx	#<jhonka_yes_message
	ldy	#>jhonka_yes_message
	jsr	partial_message_step

	jsr	jhonka_beat

	ldx	#<jhonka_yes_message2
	ldy	#>jhonka_yes_message2
	jsr	finish_parse_message

	; this kills you
	lda	#LOAD_GAME_OVER
	sta	WHICH_LOAD

	lda	#NEW_FROM_DISK
	sta	LEVEL_OVER

	rts


	;=================
	; look
	;=================

jhonka_look:

	; first check if in hay

	lda	GAME_STATE_1
	and	#IN_HAY_BALE
	beq	not_in_hay_bale

	ldx	#<hay_look_while_in_hay_message
	ldy	#>hay_look_while_in_hay_message
	jmp	finish_parse_message

not_in_hay_bale:

	; check if kerrek alive
	jsr	check_kerrek_dead
	bcc	jhonka_look_kerrek_alive


jhonka_look_kerrek_dead:
	lda	CURRENT_NOUN

	cmp	#NOUN_DOOR
	beq	jhonka_look_at_door_out
	cmp	#NOUN_JHONKA
	beq	jhonka_look_at_jhonka_out
	cmp	#NOUN_RICHES
	beq	jhonka_look_at_riches
	cmp	#NOUN_CLUB
	beq	jhonka_look_at_club
	cmp	#NOUN_LEG
	beq	jhonka_look_at_leg

	cmp	#NOUN_NONE
	beq	jhonka_look_at_out

	; these are same as kerrek alive
	cmp	#NOUN_FENCE
	beq	jhonka_look_at_fence
	cmp	#NOUN_CAVE
	beq	jhonka_look_at_cave

jhonka_look_not_there:
	jmp	parse_common_look

jhonka_look_at_out:
	; see if riches still there

	lda	INVENTORY_2
	and	#INV2_RICHES
	bne	jhonka_look_at_no_riches

jhonka_look_at_with_riches:
	ldx	#<jhonka_look_at_with_riches_message
	ldy	#>jhonka_look_at_with_riches_message
	jmp	finish_parse_message

jhonka_look_at_no_riches:
	ldx	#<jhonka_look_at_no_riches_message
	ldy	#>jhonka_look_at_no_riches_message
	jmp	finish_parse_message


jhonka_look_at_riches:
	; see if riches still there

	lda	INVENTORY_2
	and	#INV2_RICHES
	bne	jhonka_look_not_there

	ldx	#<jhonka_look_at_riches_message
	ldy	#>jhonka_look_at_riches_message
	jmp	finish_parse_message

jhonka_look_at_club:
jhonka_look_at_leg:
	ldx	#<jhonka_look_at_club_message
	ldy	#>jhonka_look_at_club_message
	jmp	finish_parse_message

jhonka_look_at_door_out:
	ldx	#<jhonka_look_at_door_out_message
	ldy	#>jhonka_look_at_door_out_message
	jmp	finish_parse_message

jhonka_look_at_jhonka_out:
	ldx	#<jhonka_look_at_jhonka_out_message
	ldy	#>jhonka_look_at_jhonka_out_message
	jmp	finish_parse_message


jhonka_look_kerrek_alive:
	lda	CURRENT_NOUN

	cmp	#NOUN_FENCE
	beq	jhonka_look_at_fence
	cmp	#NOUN_CAVE
	beq	jhonka_look_at_cave
	cmp	#NOUN_NOTE
	beq	jhonka_read_note
	cmp	#NOUN_DOOR
	beq	jhonka_look_at_door

	cmp	#NOUN_NONE
	beq	jhonka_look_at

	jmp	parse_common_look

jhonka_look_at:
	ldx	#<jhonka_look_at_message
	ldy	#>jhonka_look_at_message
	jmp	finish_parse_message

jhonka_look_at_cave:
	ldx	#<jhonka_look_at_cave_message
	ldy	#>jhonka_look_at_cave_message
	jmp	finish_parse_message

jhonka_look_at_door:
	ldx	#<jhonka_look_at_door_message
	ldy	#>jhonka_look_at_door_message
	jmp	finish_parse_message

jhonka_look_at_fence:
	ldx	#<jhonka_look_at_fence_message
	ldy	#>jhonka_look_at_fence_message
	jmp	finish_parse_message


	;================
	; read
	;================
jhonka_read:

	; check if kerrek alive
	jsr	check_kerrek_dead
	bcs	jhonka_cant_read_note

	lda	CURRENT_NOUN

	cmp	#NOUN_NOTE
	beq	jhonka_read_note

jhonka_cant_read_note:
	jmp	parse_common_unknown

jhonka_read_note:
	ldx	#<jhonka_read_note_message
	ldy	#>jhonka_read_note_message
	jmp	finish_parse_message


	;================
	; open
	;================
jhonka_open:
	; check if kerrek alive
	jsr	check_kerrek_dead
	bcs	jhonka_cant_open_door

	lda	CURRENT_NOUN

	cmp	#NOUN_DOOR
	beq	jhonka_open_door
	cmp	#NOUN_NONE
	beq	jhonka_open_door

jhonka_cant_open_door:
	jmp	parse_common_unknown

jhonka_open_door:
	ldx	#<jhonka_open_door_message
	ldy	#>jhonka_open_door_message
	jmp	finish_parse_message


	;================
	; knock
	;================
jhonka_knock:
	; check if kerrek alive
	jsr	check_kerrek_dead
	bcs	jhonka_cant_knock_door

	lda	CURRENT_NOUN

	cmp	#NOUN_DOOR
	beq	jhonka_knock_door
	cmp	#NOUN_NONE
	beq	jhonka_knock_door

jhonka_cant_knock_door:
	jmp	parse_common_unknown

jhonka_knock_door:
	jsr	random8
	and	#$7

	beq	jhonka_knock5
	cmp	#$1
	beq	jhonka_knock4
	cmp	#$2
	beq	jhonka_knock3
	cmp	#$3
	beq	jhonka_knock2

	cmp	#$4
	beq	jhonka_knock5
	cmp	#$5
	beq	jhonka_knock4

jhonka_knock1:
	ldx	#<jhonka_knock_message1
	ldy	#>jhonka_knock_message1
	jmp	finish_parse_message

jhonka_knock2:
	ldx	#<jhonka_knock_message2
	ldy	#>jhonka_knock_message2
	jmp	finish_parse_message

jhonka_knock3:
	ldx	#<jhonka_knock_message3
	ldy	#>jhonka_knock_message3
	jmp	finish_parse_message

jhonka_knock4:
	ldx	#<jhonka_knock_message4
	ldy	#>jhonka_knock_message4
	jmp	finish_parse_message

jhonka_knock5:
	ldx	#<jhonka_knock_message5
	ldy	#>jhonka_knock_message5
	jmp	finish_parse_message




	;================
	; ask
	;================
jhonka_ask:
	; check if alive
	jsr	check_kerrek_dead
	bcc	jhonka_ask_kerrek_alive

	lda	CURRENT_NOUN

	cmp	#NOUN_FIRE
	beq	jhonka_ask_fire
	cmp	#NOUN_JHONKA
	beq	jhonka_ask_jhonka
	cmp	#NOUN_NED
	beq	jhonka_ask_ned
	cmp	#NOUN_ROBE
	beq	jhonka_ask_ned
	cmp	#NOUN_SMELL
	beq	jhonka_ask_smell
	cmp	#NOUN_TROGDOR
	beq	jhonka_ask_smell

jhonka_ask_unknown:
	ldx	#<jhonka_ask_about_unknown_message
	ldy	#>jhonka_ask_about_unknown_message
	jmp	finish_parse_message

jhonka_ask_fire:
	ldx	#<jhonka_ask_about_fire_message
	ldy	#>jhonka_ask_about_fire_message
	jmp	finish_parse_message

jhonka_ask_jhonka:
	ldx	#<jhonka_ask_about_jhonka_message
	ldy	#>jhonka_ask_about_jhonka_message
	jmp	finish_parse_message

jhonka_ask_ned:
	ldx	#<jhonka_ask_about_ned_message
	ldy	#>jhonka_ask_about_ned_message
	jmp	finish_parse_message

jhonka_ask_smell:
	ldx	#<jhonka_ask_about_smell_message
	ldy	#>jhonka_ask_about_smell_message
	jmp	finish_parse_message

jhonka_ask_trogdor:
	ldx	#<jhonka_ask_about_trogdor_message
	ldy	#>jhonka_ask_about_trogdor_message
	jmp	finish_parse_message

jhonka_ask_kerrek_alive:
	jmp	parse_common_ask



	;================
	; talk
	;================
jhonka_talk:

	; check if kerrek alive
	jsr	check_kerrek_dead
	bcc	jhonka_cant_talk

	lda	CURRENT_NOUN

	cmp	#NOUN_JHONKA
	beq	jhonka_talk_to
	cmp	#NOUN_NONE
	beq	jhonka_talk_to

jhonka_cant_talk:
	jmp	parse_common_talk

jhonka_talk_to:
	; check if in hay

	lda	GAME_STATE_1
	and	#IN_HAY_BALE
	beq	jhonka_ask_jhonka	; same as ask about jhonka

jhonka_talk_in_hay:
	ldx	#<jhonka_talk_in_hay_message
	ldy	#>jhonka_talk_in_hay_message
	jmp	finish_parse_message


	;================
	; give
	;================
jhonka_give:

	; check if kerrek alive
	jsr	check_kerrek_dead
	bcs	jhonka_do_give

	jmp	parse_common_give

jhonka_do_give:
	ldx	#<jhonka_give_message
	ldy	#>jhonka_give_message
	jmp	finish_parse_message

	;================
	; kill
	;================
jhonka_kill:

	; check if kerrek alive
	jsr	check_kerrek_dead
	bcs	jhonka_do_kill

	jmp	parse_common_unknown

jhonka_do_kill:
	ldx	#<jhonka_kill_message
	ldy	#>jhonka_kill_message
	jmp	finish_parse_message



	;====================
	; check if kerrek dead
	;	Carry Set = yes
	;	Carry Clear = no

	; FIXME: we can check GAME_STATE_3 KERREK_DEAD too
check_kerrek_dead:
	sec
	lda	KERREK_STATE
	and	#$f
	bne	done_check_kerrek_dead
	clc
done_check_kerrek_dead:
	rts

.include "../text/dialog_jhonka.inc"


