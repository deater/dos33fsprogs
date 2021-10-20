;.include "tokens.inc"


	;=======================
	;=======================
	;=======================
	; mountain pass
	;=======================
	;=======================
	;=======================

mountain_pass_verb_table:
        .byte VERB_ASK
        .word mountain_pass_ask-1
        .byte VERB_ATTACK
        .word mountain_pass_attack-1
        .byte VERB_BREAK
        .word mountain_pass_break-1
        .byte VERB_LOOK
        .word mountain_pass_look-1
        .byte VERB_TALK
        .word mountain_pass_talk-1
	.byte 0


	;================
	; ask
	;================
mountain_pass_ask:
	lda	CURRENT_NOUN

	cmp	#NOUN_FIRE
	beq	ask_about_fire
	cmp	#NOUN_JHONKA
	beq	ask_about_jhonka
	cmp	#NOUN_KERREK
	beq	ask_about_kerrek
	cmp	#NOUN_NED
	beq	ask_about_ned
	cmp	#NOUN_ROBE
	beq	ask_about_robe
	cmp	#NOUN_SMELL
	beq	ask_about_smell
	cmp	#NOUN_TROGDOR
	beq	ask_about_trogdor

	; else ask about unknown

ask_about_unknown:
	ldx	#<knight_ask_unknown_message
	ldy	#>knight_ask_unknown_message
	jmp	finish_parse_message

ask_about_fire:
	ldx	#<knight_ask_fire_message
	ldy	#>knight_ask_fire_message
	jmp	finish_parse_message

ask_about_jhonka:
	ldx	#<knight_ask_jhonka_message
	ldy	#>knight_ask_jhonka_message
	jmp	finish_parse_message

ask_about_kerrek:
	ldx	#<knight_ask_kerrek_message
	ldy	#>knight_ask_kerrek_message
	jmp	finish_parse_message

ask_about_ned:
	ldx	#<knight_ask_ned_message
	ldy	#>knight_ask_ned_message
	jmp	finish_parse_message

ask_about_robe:
	ldx	#<knight_ask_robe_message
	ldy	#>knight_ask_robe_message
	jmp	finish_parse_message

ask_about_smell:
	ldx	#<knight_ask_smell_message
	ldy	#>knight_ask_smell_message
	jmp	finish_parse_message

ask_about_trogdor:
	ldx	#<knight_ask_trogdor_message
	ldy	#>knight_ask_trogdor_message
	jmp	finish_parse_message



	;================
	; attack
	;================
mountain_pass_break:
mountain_pass_attack:
	lda	CURRENT_NOUN
	cmp	#NOUN_SIGN
	beq	attack_sign

	jmp	parse_common_unknown

attack_sign:
	ldx	#<attack_sign_message
	ldy	#>attack_sign_message
	jmp	finish_parse_message


	;=================
	; look
	;=================

mountain_pass_look:

	lda	CURRENT_NOUN

	cmp	#NOUN_KNIGHT
	beq	knight_look
	cmp	#NOUN_MAN
	beq	knight_look
	cmp	#NOUN_DUDE
	beq	knight_look
	cmp	#NOUN_GUY
	beq	knight_look

	cmp	#NOUN_SIGN
	beq	sign_look
	cmp	#NOUN_TROGDOR
	beq	trogdor_look
	cmp	#NOUN_NONE
	beq	pass_look

	jmp	parse_common_look

knight_look:
	ldx	#<knight_look_message
	ldy	#>knight_look_message
	jmp	finish_parse_message

pass_look:
	ldx	#<pass_look_message
	ldy	#>pass_look_message
	jmp	finish_parse_message

sign_look:
	ldx	#<sign_look_message
	ldy	#>sign_look_message
	jmp	finish_parse_message

trogdor_look:
	ldx	#<trogdor_look_message
	ldy	#>trogdor_look_message
	jmp	finish_parse_message


	;===================
	; talk
	;===================

mountain_pass_talk:

	lda	CURRENT_NOUN
	cmp	#NOUN_KNIGHT
	beq	talk_to_knight
	cmp	#NOUN_GUY
	beq	talk_to_knight
	cmp	#NOUN_MAN
	beq	talk_to_knight
	cmp	#NOUN_DUDE
	beq	talk_to_knight

	; else, no one
	jmp	parse_common_talk

talk_to_knight:

	lda	GAME_STATE_2
	and	#TALKED_TO_KNIGHT
	bne	knight_skip_text

	; first time only
	ldx	#<talk_knight_first_message
	ldy	#>talk_knight_first_message
	jsr	partial_message_step

	; first time only
	ldx	#<talk_knight_second_message
	ldy	#>talk_knight_second_message
	jsr	partial_message_step

knight_skip_text:
	ldx	#<talk_knight_third_message
	ldy	#>talk_knight_third_message
	jsr	partial_message_step

	ldx	#<talk_knight_stink_message
	ldy	#>talk_knight_stink_message
	jsr	partial_message_step

	ldx	#<talk_knight_dress_message
	ldy	#>talk_knight_dress_message
	jsr	partial_message_step

	ldx	#<talk_knight_fire_message
	ldy	#>talk_knight_fire_message
	jsr	partial_message_step

	ldx	#<talk_knight_fourth_message
	ldy	#>talk_knight_fourth_message

	lda	GAME_STATE_2
	and	#TALKED_TO_KNIGHT
	bne	knight_skip_text2

	jsr	partial_message_step

	; first time only
	ldx	#<talk_knight_fifth_message
	ldy	#>talk_knight_fifth_message

	lda	GAME_STATE_2
	ora	#TALKED_TO_KNIGHT
	sta	GAME_STATE_2

knight_skip_text2:
	jmp	finish_parse_message


.include "dialog_peasant2.inc"
