	;=======================
	;=======================
	;=======================
	; Kerrek
	;=======================
	;=======================
	;=======================

kerrek_verb_table:
	.byte VERB_LOOK
	.word kerrek_look-1
	.byte 0

	;=================
	; look
	;=================

kerrek_look:

	lda	CURRENT_NOUN

	cmp	#NOUN_NONE
	beq	kerrek_look_at

	jmp	parse_common_look

kerrek_look_at:
	ldx	#<kerrek_look_at_message
	ldy	#>kerrek_look_at_message
	jmp	finish_parse_message

