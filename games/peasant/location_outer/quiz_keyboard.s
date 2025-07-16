	;==============================
	; check_keyboard_answer
	;==============================
	; for when in quiz
	; looking for just A, B, or C

check_keyboard_answer:


quiz_drain_keyboard_buffer:
	ldx	KEY_OFFSET
	beq	skip_quiz_drain_keyboard

	; TODO: should look at whole buffer, not just first?

	ldx	#0
	stx	KEY_OFFSET		; reset
	lda	keyboard_buffer,X
	jmp	skip_kb_read

skip_quiz_drain_keyboard:

	lda	KEYPRESS
	bpl	no_answer

	bit	KEYRESET
skip_kb_read:

	pha
	jsr	restore_parse_message

	pla

	and	#$7f	; strip high bit
	and	#$df	; convert to lowercase $61 -> $41  0110 -> 0100

	cmp	#'A'
	bcc	invalid_answer		; blt
	cmp	#'D'
	bcs	invalid_answer		; bge

	ldx	WHICH_QUIZ

	cmp	quiz_answers,X
	bne	do_wrong_answer

do_right_answer:
	jmp	right_answer

do_wrong_answer:
	jmp	wrong_answer

no_answer:
	rts

