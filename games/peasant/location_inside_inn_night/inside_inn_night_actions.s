.include "../tokens.inc"

	;=======================
	;=======================
	;=======================
	; Inside Inn (night)
	;=======================
	;=======================
	;=======================

inside_inn_night_verb_table:
	.byte VERB_LOOK
	.word inside_inn_look-1
	.byte VERB_TALK
	.word inside_inn_talk-1
	.byte VERB_GIVE
	.word inside_inn_give-1
	.byte VERB_USE
	.word inside_inn_give-1
	.byte VERB_GET
	.word inside_inn_get-1
	.byte VERB_ASK
	.word inside_inn_ask-1
	.byte VERB_RING
	.word inside_inn_ring-1
	.byte VERB_SLEEP
	.word inside_inn_sleep-1
	.byte VERB_LIGHT
	.word inside_inn_light-1
	.byte 0

	;=================
	; look
	;=================

inside_inn_look:

	jmp	inside_inn_look_night

inn_look_at_window:
	ldx	#<inside_inn_look_window_message
	ldy	#>inside_inn_look_window_message
	jmp	finish_parse_message

inn_look_at_painting:
	ldx	#<inside_inn_look_painting_message
	ldy	#>inside_inn_look_painting_message
	jmp	finish_parse_message

inn_look_at_paper:
	ldx	#<inside_inn_look_paper_message
	ldy	#>inside_inn_look_paper_message
	jmp	finish_parse_message

inn_look_at_pillow:
	ldx	#<inside_inn_look_pillow_message
	ldy	#>inside_inn_look_pillow_message
	jmp	finish_parse_message

inn_look_at_rug:
	ldx	#<inside_inn_look_rug_message
	ldy	#>inside_inn_look_rug_message
	jmp	finish_parse_message

inn_look_at_bed:
	ldx	#<inside_inn_look_bed_message
	ldy	#>inside_inn_look_bed_message
	jmp	finish_parse_message

inn_look_at_bell:
	ldx	#<inside_inn_look_bell_message
	ldy	#>inside_inn_look_bell_message
	jmp	finish_parse_message

inside_inn_look_night:
	lda	CURRENT_NOUN

	cmp	#NOUN_PILLOW
	beq	inn_look_at_pillow
	cmp	#NOUN_PARCHMENT
	beq	inn_look_at_paper
	cmp	#NOUN_NOTE
	beq	inn_look_at_paper
	cmp	#NOUN_PAPER
	beq	inn_look_at_paper
	cmp	#NOUN_PAINTING
	beq	inn_look_at_painting
	cmp	#NOUN_DUDE
	beq	inn_look_at_man_night
	cmp	#NOUN_GUY
	beq	inn_look_at_man_night
	cmp	#NOUN_MAN
	beq	inn_look_at_man_night
	cmp	#NOUN_WINDOW
	beq	inn_look_at_window
	cmp	#NOUN_PILLOW
	beq	inn_look_at_pillow
	cmp	#NOUN_RUG
	beq	inn_look_at_rug
	cmp	#NOUN_CARPET
	beq	inn_look_at_rug
	cmp	#NOUN_BED
	beq	inn_look_at_bed
	cmp	#NOUN_MATTRESS
	beq	inn_look_at_bed
	cmp	#NOUN_BELL
	beq	inn_look_at_bell
	cmp	#NOUN_DESK
	beq	inn_look_at_desk_night
	cmp	#NOUN_POT
	beq	inn_look_at_pot_night
	cmp	#NOUN_CANDLE
	beq	inn_look_at_candle_night

	cmp	#NOUN_NONE
	beq	inn_look_at_night

	jmp	parse_common_look

inn_look_at_night:
	ldx	#<inside_inn_look_night_message
	ldy	#>inside_inn_look_night_message
	jmp	finish_parse_message

inn_look_at_man_night:
	ldx	#<inside_inn_look_man_night_message
	ldy	#>inside_inn_look_man_night_message
	jmp	finish_parse_message

inn_look_at_pot_night:
	ldx	#<inside_inn_look_pot_night_message
	ldy	#>inside_inn_look_pot_night_message
	jmp	finish_parse_message

inn_look_at_desk_night:
	ldx	#<inside_inn_look_desk_night_message
	ldy	#>inside_inn_look_desk_night_message
	jmp	finish_parse_message

inn_look_at_candle_night:
	ldx	#<inside_inn_look_candle_night_message
	ldy	#>inside_inn_look_candle_night_message
	jmp	finish_parse_message



	;=================
	; talk
	;=================

inside_inn_talk:

	; no talking at night
inn_talk_no_one:
	jmp	parse_common_talk


	;=================
	; give
	;=================

inside_inn_give:

	; no giving at night

inn_give_no_one:
	jmp	parse_common_give


	;=================
	; get
	;=================

inside_inn_get:

	lda	CURRENT_NOUN

	cmp	#NOUN_PAPER
	beq	inn_get_paper
	cmp	#NOUN_NOTE
	beq	inn_get_paper
	cmp	#NOUN_PARCHMENT
	beq	inn_get_paper
	cmp	#NOUN_PAINTING
	beq	inn_get_painting
	cmp	#NOUN_RUG
	beq	inn_get_rug
	cmp	#NOUN_CARPET
	beq	inn_get_rug
;	cmp	#NOUN_DOING_SPROINGS
;	beq	inn_get_doing
	cmp	#NOUN_PILLOW
	beq	inn_get_pillow
	cmp	#NOUN_BELL
	beq	inn_get_bell
;	cmp	#NOUN_BED
;	beq	inn_get_bed
	cmp	#NOUN_POT
	beq	inn_get_pot
	cmp	#NOUN_GREASE
	beq	inn_get_grease
	cmp	#NOUN_CANDLE
	beq	inn_get_candle
	cmp	#NOUN_RUB
	beq	inn_get_rub

;	cmp	#NOUN_ROOM
;	beq	inn_get_room

	jmp	parse_common_get

inn_get_paper:
	ldx	#<inside_inn_get_paper_message
	ldy	#>inside_inn_get_paper_message
	jmp	finish_parse_message

inn_get_painting:
	ldx	#<inside_inn_get_painting_message
	ldy	#>inside_inn_get_painting_message
	jmp	finish_parse_message

inn_get_rug:
	ldx	#<inside_inn_get_rug_message
	ldy	#>inside_inn_get_rug_message
	jmp	finish_parse_message

;inn_get_doing:
;	ldx	#<inside_inn_get_doing_message
;	ldy	#>inside_inn_get_doing_message
;	jmp	finish_parse_message

inn_get_pillow:
	ldx	#<inside_inn_get_pillow_message
	ldy	#>inside_inn_get_pillow_message
	jmp	finish_parse_message

inn_get_bell:
	ldx	#<inside_inn_get_bell_message
	ldy	#>inside_inn_get_bell_message
	jmp	finish_parse_message

;inn_get_bed:
;	ldx	#<inside_inn_get_bed_message
;	ldy	#>inside_inn_get_bed_message
;	jmp	finish_parse_message

inn_get_pot:
inn_get_grease:
	lda	GAME_STATE_1
	and	#NIGHT
	bne	inn_do_get_grease
	jmp	parse_common_get

inn_do_get_grease:
	lda	GAME_STATE_2
	and	#GREASE_ON_HEAD
	beq	inn_finally_get_grease

inn_grease_already:
	ldx	#<inside_inn_grease_already_message
	ldy	#>inside_inn_grease_already_message
	jmp	finish_parse_message

inn_finally_get_grease:

	;============================
	; grab the pot
	;============================

	;====================
	; walk to location

	ldx	#26			; 182 / 7 = 26
	ldy	#68
	jsr	peasant_walkto

	lda	#PEASANT_DIR_UP
	sta	PEASANT_DIR

	;==============================
	; print "you reach way up"...

	ldx	#<inside_inn_get_grease_message
	ldy	#>inside_inn_get_grease_message
	jsr	partial_message_step

	;==============================
	; update points

	lda	#2
	jsr	score_points

	;================================
	; put grease and pot on head

	lda	GAME_STATE_2
	ora	#GREASE_ON_HEAD
	sta	GAME_STATE_2

	lda	GAME_STATE_1
	ora	#POT_ON_HEAD
	sta	GAME_STATE_1

	;=============================
	; animate pot falling

	jsr	animate_falling_pot

	; flat feet
	; right hand up
	; right hand up higher
	; right hand up to top of head
	; stand on tiptoes
	; down
	; up
	; down
	; up for a while
	;	pot tilts right/center/left/center
	;	pot tilts right
	;	falls a bit
	;	falls more rotating
	;	falls just above head
	;	falls on head, arms up
	;	wiggle arms up and down 4 times

	;=================================
	; print message "oh great..."

	ldx	#<inside_inn_get_grease_message2
	ldy	#>inside_inn_get_grease_message2
	jmp	finish_parse_message

inn_get_candle:
	ldx	#<inside_inn_get_candle_message
	ldy	#>inside_inn_get_candle_message
	jmp	finish_parse_message

inn_get_rub:
	ldx	#<inside_inn_get_rub_message
	ldy	#>inside_inn_get_rub_message
	jmp	finish_parse_message


	;=================
	; ask about
	;=================

inside_inn_ask:
	; no asking at night

	jmp	parse_common_ask


	;=================
	; ring
	;=================

inside_inn_ring:

	lda	CURRENT_NOUN

	cmp	#NOUN_BELL
	beq	inn_ring_bell

	jmp	parse_common_unknown

inn_ring_bell:
	ldx	#<inside_inn_ring_bell_message
	ldy	#>inside_inn_ring_bell_message
	jmp	finish_parse_message

	;=================
	; sleep
	;=================

inside_inn_sleep:

	; no sleeping at night

inn_sleep_no_one:
	jmp	parse_common_unknown


	;=================
	; open
	;=================
.if 0
inside_inn_open:

	lda	CURRENT_NOUN

	cmp	#NOUN_DOOR
	beq	inn_open_door

	jmp	parse_common_unknown

inn_open_door:
	ldx	#<inside_inn_open_door_message
	ldy	#>inside_inn_open_door_message
	jmp	finish_parse_message
.endif
	;=================
	; light
	;=================

inside_inn_light:

	lda	CURRENT_NOUN

	cmp	#NOUN_CANDLE
	beq	inn_light_candle
	jmp	parse_common_unknown

inn_light_candle:
	ldx	#<inside_inn_get_candle_message
	ldy	#>inside_inn_get_candle_message
	jmp	finish_parse_message


.include "../text/dialog_inside_inn_night.inc"
