.include "tokens.inc"

	;=======================
	;=======================
	;=======================
	; Inside Inn
	;=======================
	;=======================
	;=======================

inside_inn_verb_table:
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
        .byte VERB_OPEN
        .word inside_inn_open-1
        .byte VERB_LIGHT
        .word inside_inn_light-1
	.byte 0

	;=================
	; look
	;=================

inside_inn_look:
	lda	GAME_STATE_1
	and	#NIGHT
	beq	inside_inn_look_day

	jmp	inside_inn_look_night

inside_inn_look_day:
	lda	CURRENT_NOUN

	cmp	#NOUN_PILLOW
	beq	inn_look_at_pillow
	cmp	#NOUN_NOTE
	beq	inn_look_at_paper
	cmp	#NOUN_PAPER
	beq	inn_look_at_paper
	cmp	#NOUN_PAINTING
	beq	inn_look_at_painting
	cmp	#NOUN_DUDE
	beq	inn_look_at_man
	cmp	#NOUN_GUY
	beq	inn_look_at_man
	cmp	#NOUN_MAN
	beq	inn_look_at_man
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
	beq	inn_look_at_desk
	cmp	#NOUN_DOOR
	beq	inn_look_at_door

	cmp	#NOUN_NONE
	beq	inn_look_at

	jmp	parse_common_look

inn_look_at:
	ldx	#<inside_inn_look_message
	ldy	#>inside_inn_look_message
	jmp	finish_parse_message

inn_look_at_window:
	ldx	#<inside_inn_look_window_message
	ldy	#>inside_inn_look_window_message
	jmp	finish_parse_message

inn_look_at_man:
	ldx	#<inside_inn_look_man_message
	ldy	#>inside_inn_look_man_message
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

inn_look_at_desk:
	ldx	#<inside_inn_look_desk_message
	ldy	#>inside_inn_look_desk_message
	jmp	finish_parse_message

inn_look_at_door:
	ldx	#<inside_inn_open_door_message
	ldy	#>inside_inn_open_door_message
	jmp	finish_parse_message


inside_inn_look_night:
	lda	CURRENT_NOUN

	cmp	#NOUN_PILLOW
	beq	inn_look_at_pillow
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
	beq	inn_look_at_desk
	cmp	#NOUN_POT
	beq	inn_look_at_pot_night

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

	lda	GAME_STATE_1
	and	#NIGHT
	bne	inn_talk_no_one

	lda	CURRENT_NOUN

	cmp	#NOUN_NONE
	beq	inn_talk_man
	cmp	#NOUN_MAN
	beq	inn_talk_man
	cmp	#NOUN_GUY
	beq	inn_talk_man
	cmp	#NOUN_DUDE
	beq	inn_talk_man
inn_talk_no_one:
	jmp	parse_common_talk

inn_talk_man:
	ldx	#<inside_inn_talk_man_message
	ldy	#>inside_inn_talk_man_message
	jmp	finish_parse_message

	;=================
	; give
	;=================

inside_inn_give:

	; no giving at night

	lda	GAME_STATE_1
	and	#NIGHT
	bne	inn_give_no_one

	lda	CURRENT_NOUN

	cmp	#NOUN_BABY
	beq	inn_give_baby
inn_give_no_one:
	jmp	parse_common_give

inn_give_baby:

	lda	INVENTORY_1
	and	#INV1_PILLS	; check if have pills
	bne	inn_give_baby_have_pills

	lda	INVENTORY_1
	and	#INV1_BABY
	bne	inn_give_baby_have_baby

inn_give_baby_no_baby:
	ldx	#<inside_inn_give_baby_before_message
	ldy	#>inside_inn_give_baby_before_message
	jmp	finish_parse_message

inn_give_baby_have_baby:
	ldx	#<inside_inn_give_baby_message
	ldy	#>inside_inn_give_baby_message
	jsr	partial_message_step

	; add 5 points to score

	lda	#5
	jsr	score_points

	; get pills

	lda	INVENTORY_1
	ora	#INV1_PILLS
	sta	INVENTORY_1

	ldx	#<inside_inn_give_baby2_message
	ldy	#>inside_inn_give_baby2_message
	jmp	finish_parse_message

inn_give_baby_have_pills:

	ldx	#<inside_inn_give_baby_already_message
	ldy	#>inside_inn_give_baby_already_message
	jmp	finish_parse_message

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
	cmp	#NOUN_DOING_SPROINGS
	beq	inn_get_doing
	cmp	#NOUN_PILLOW
	beq	inn_get_pillow
	cmp	#NOUN_BELL
	beq	inn_get_bell
	cmp	#NOUN_BED
	beq	inn_get_bed
	cmp	#NOUN_POT
	beq	inn_get_pot
	cmp	#NOUN_GREASE
	beq	inn_get_grease
	cmp	#NOUN_CANDLE
	beq	inn_get_candle
	cmp	#NOUN_RUB
	beq	inn_get_rub

	cmp	#NOUN_ROOM
	beq	inn_get_room

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

inn_get_doing:
	ldx	#<inside_inn_get_doing_message
	ldy	#>inside_inn_get_doing_message
	jmp	finish_parse_message

inn_get_pillow:
	ldx	#<inside_inn_get_pillow_message
	ldy	#>inside_inn_get_pillow_message
	jmp	finish_parse_message

inn_get_bell:
	ldx	#<inside_inn_get_bell_message
	ldy	#>inside_inn_get_bell_message
	jmp	finish_parse_message

inn_get_bed:
	ldx	#<inside_inn_get_bed_message
	ldy	#>inside_inn_get_bed_message
	jmp	finish_parse_message

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
	ldx	#<inside_inn_get_grease_message
	ldy	#>inside_inn_get_grease_message
	jsr	partial_message_step

	lda	#2
	jsr	score_points

	lda	GAME_STATE_2
	ora	#GREASE_ON_HEAD
	sta	GAME_STATE_2

	lda	GAME_STATE_1
	ora	#POT_ON_HEAD
	sta	GAME_STATE_1

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




inn_get_room:
	lda	GAME_STATE_1
	and	#WEARING_ROBE	; check if wearing robe
	bne	inn_get_room_have_robe

inn_get_room_no_robe:
	ldx	#<inside_inn_get_room_no_robe_message
	ldy	#>inside_inn_get_room_no_robe_message
	jmp	finish_parse_message

inn_get_room_on_fire:
	ldx	#<inside_inn_get_room_on_fire_message
	ldy	#>inside_inn_get_room_on_fire_message
	jmp	finish_parse_message

inn_get_room_have_robe:
	lda	GAME_STATE_1
	and	#NIGHT
	beq	inn_get_room_have_room_day

	jmp	parse_common_get

inn_get_room_have_room_day:
	lda	GAME_STATE_2
	and	#ON_FIRE	; check if on fire
	bne	inn_get_room_on_fire

	ldx	#<inside_inn_get_room_message
	ldy	#>inside_inn_get_room_message
	jsr	partial_message_step

	; add 3 points to score
	; only do this once though

	lda	GAME_STATE_1
	and	#ALREADY_GOT_ROOM
	bne	inn_get_room_skip_points

	lda	#3
	jsr	score_points
inn_get_room_skip_points:

	; Make it night
	lda	GAME_STATE_1
	ora	#(NIGHT|ALREADY_GOT_ROOM)
	sta	GAME_STATE_1

	ldx	#<inside_inn_get_room2_message
	ldy	#>inside_inn_get_room2_message
	jsr	partial_message_step

	ldx	#<inside_inn_get_room3_message
	ldy	#>inside_inn_get_room3_message
	jmp	finish_parse_message



	;=================
	; ask about
	;=================

inside_inn_ask:

	lda	GAME_STATE_1
	and	#NIGHT
	beq	inn_ask_day

	jmp	parse_common_ask

inn_ask_day:

	lda	CURRENT_NOUN

	cmp	#NOUN_FIRE
	beq	inn_ask_about_fire
	cmp	#NOUN_NED
	beq	inn_ask_about_ned
	cmp	#NOUN_ROBE
	beq	inn_ask_about_robe
	cmp	#NOUN_SMELL
	beq	inn_ask_about_smell
	cmp	#NOUN_TROGDOR
	beq	inn_ask_about_trogdor

inn_ask_about_unknown:
	ldx	#<inside_inn_ask_about_unknown_message
	ldy	#>inside_inn_ask_about_unknown_message
	jmp	finish_parse_message

inn_ask_about_fire:
	ldx	#<inside_inn_ask_about_fire_message
	ldy	#>inside_inn_ask_about_fire_message
	jmp	finish_parse_message

inn_ask_about_ned:
	ldx	#<inside_inn_ask_about_ned_message
	ldy	#>inside_inn_ask_about_ned_message
	jmp	finish_parse_message

inn_ask_about_robe:
	ldx	#<inside_inn_ask_about_robe_message
	ldy	#>inside_inn_ask_about_robe_message
	jmp	finish_parse_message

inn_ask_about_smell:
	ldx	#<inside_inn_ask_about_smell_message
	ldy	#>inside_inn_ask_about_smell_message
	jmp	finish_parse_message

inn_ask_about_trogdor:
	ldx	#<inside_inn_ask_about_trogdor_message
	ldy	#>inside_inn_ask_about_trogdor_message
	jmp	finish_parse_message


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

	lda	GAME_STATE_1
	and	#NIGHT
	bne	inn_sleep_no_one

	lda	CURRENT_NOUN

	cmp	#NOUN_BED
	beq	inn_sleep_bed
	cmp	#NOUN_NONE
	beq	inn_sleep_bed

inn_sleep_no_one:
	jmp	parse_common_unknown

inn_sleep_bed:
	ldx	#<inside_inn_sleep_bed_message
	ldy	#>inside_inn_sleep_bed_message
	jmp	finish_parse_message

	;=================
	; open
	;=================

inside_inn_open:

	lda	CURRENT_NOUN

	cmp	#NOUN_DOOR
	beq	inn_open_door

	jmp	parse_common_unknown

inn_open_door:
	ldx	#<inside_inn_open_door_message
	ldy	#>inside_inn_open_door_message
	jmp	finish_parse_message

	;=================
	; light
	;=================

inside_inn_light:

	lda	GAME_STATE_1
	and	#NIGHT
	beq	inn_light_day

	lda	CURRENT_NOUN

	cmp	#NOUN_CANDLE
	beq	inn_light_candle
inn_light_day:
	jmp	parse_common_unknown

inn_light_candle:
	ldx	#<inside_inn_get_candle_message
	ldy	#>inside_inn_get_candle_message
	jmp	finish_parse_message







.include "dialog_inn.inc"
