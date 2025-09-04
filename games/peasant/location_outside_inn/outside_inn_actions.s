.include "../tokens.inc"

	;=======================
	;=======================
	;=======================
	; outside Inn
	;=======================
	;=======================
	;=======================

inn_verb_table:
	.byte VERB_GET
	.word outside_inn_get-1
	.byte VERB_KNOCK
	.word outside_inn_knock-1
	.byte VERB_LOOK
	.word outside_inn_look-1
	.byte VERB_OPEN
	.word outside_inn_open-1
	.byte VERB_READ
	.word outside_inn_read-1
	.byte 0


	;================
	; get
	;================
outside_inn_get:
	lda	CURRENT_NOUN

	cmp	#NOUN_NOTE
	beq	inn_note_get

	jmp	parse_common_get

inn_note_get:
	lda	GAME_STATE_1
	and	#FISH_FED
	bne	inn_get_note_no_note

	ldx	#<outside_inn_note_get_message
	ldy	#>outside_inn_note_get_message
	jmp	finish_parse_message

inn_get_note_no_note:

	jmp	inn_note_no_note

	;================
	; knock
	;================
outside_inn_knock:
	lda	CURRENT_NOUN

	cmp	#NOUN_DOOR
	beq	inn_door_knock
	cmp	#NOUN_NONE
	beq	inn_door_knock

	jmp	parse_common_unknown

inn_door_knock:

	lda	GAME_STATE_1
	and	#FISH_FED
	beq	inn_knock_locked

	ldx	#<outside_inn_door_knock_message
	ldy	#>outside_inn_door_knock_message
	jmp	finish_parse_message

inn_knock_locked:
	ldx	#<outside_inn_door_knock_locked_message
	ldy	#>outside_inn_door_knock_locked_message
	jmp	finish_parse_message

	;================
	; open
	;================
outside_inn_open:
	lda	CURRENT_NOUN

	cmp	#NOUN_DOOR
	beq	inn_door_open
	cmp	#NOUN_NONE
	beq	inn_door_open

	jmp	parse_common_unknown

inn_door_open:

	; check if door unlocked

	lda	GAME_STATE_1
	and	#FISH_FED
	beq	inn_open_locked

	; walk to door

	ldx	#9
	ldy	#116
	jsr	peasant_walkto

	lda	#PEASANT_DIR_UP
	sta	PEASANT_DIR

	; check if night

	lda	GAME_STATE_1
	and	#NIGHT
	beq	inn_open_day

inn_open_night:
	lda	#LOCATION_INSIDE_INN_NIGHT
	bne	inn_open_common		; bra
inn_open_day:
	lda	#LOCATION_INSIDE_INN
inn_open_common:
	jsr	update_map_location

	ldx	#<outside_inn_door_open_message
	ldy	#>outside_inn_door_open_message
	jmp	finish_parse_message

inn_open_locked:
	ldx	#<outside_inn_door_open_locked_message
	ldy	#>outside_inn_door_open_locked_message
	jmp	finish_parse_message


	;================
	; read
	;================
outside_inn_read:
	lda	CURRENT_NOUN
	cmp	#NOUN_NOTE
	beq	inn_note_look

	jmp	parse_common_unknown

	;=================
	; look
	;=================

outside_inn_look:

	lda	CURRENT_NOUN

	cmp	#NOUN_DOOR
	beq	inn_door_look
	cmp	#NOUN_INN
	beq	inn_inn_look
	cmp	#NOUN_SIGN
	beq	inn_sign_look
	cmp	#NOUN_WINDOW
	beq	inn_window_look
	cmp	#NOUN_NOTE
	beq	inn_note_look

	cmp	#NOUN_NONE
	beq	inn_look

	jmp	parse_common_look

inn_inn_look:
	ldx	#<outside_inn_inn_look_message
	ldy	#>outside_inn_inn_look_message
	jmp	finish_parse_message

inn_look:
	ldx	#<outside_inn_look_message
	ldy	#>outside_inn_look_message
	jmp	finish_parse_message

inn_door_look:
	lda	GAME_STATE_1
	and	#FISH_FED
	bne	inn_door_no_note

	ldx	#<outside_inn_door_look_note_message
	ldy	#>outside_inn_door_look_note_message
	jmp	finish_parse_message

inn_door_no_note:

	ldx	#<outside_inn_door_look_message
	ldy	#>outside_inn_door_look_message
	jmp	finish_parse_message

inn_sign_look:
	ldx	#<outside_inn_sign_look_message
	ldy	#>outside_inn_sign_look_message
	jmp	finish_parse_message

inn_window_look:
	ldx	#<outside_inn_window_look_message
	ldy	#>outside_inn_window_look_message
	jmp	finish_parse_message

inn_note_look:
	lda	GAME_STATE_1
	and	#FISH_FED
	bne	inn_note_no_note

	ldx	#<outside_inn_note_look_message
	ldy	#>outside_inn_note_look_message
	jmp	finish_parse_message

inn_note_no_note:
	ldx	#<outside_inn_note_look_gone_message
	ldy	#>outside_inn_note_look_gone_message
	jmp	finish_parse_message


.include "../text/dialog_outside_inn.inc"
