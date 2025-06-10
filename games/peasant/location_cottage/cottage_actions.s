.include "../tokens.inc"

	;=======================
	;=======================
	;=======================
	; Cottage
	;=======================
	;=======================
	;=======================

cottage_verb_table:
	.byte VERB_GET
	.word cottage_get-1
	.byte VERB_TAKE
	.word cottage_take-1
	.byte VERB_STEAL
	.word cottage_steal-1
	.byte VERB_LOOK
	.word cottage_look-1
	.byte 0


	;================
	; get
	;================
cottage_get:
cottage_steal:
cottage_take:
	lda	CURRENT_NOUN

	cmp	#NOUN_MAP
	beq	cottage_get_map
	cmp	#NOUN_PAPER
	beq	cottage_get_map

	; else "probably wish" message

	jmp	parse_common_get

cottage_get_map:
	lda	INVENTORY_3
	and	#INV3_MAP
	beq	actually_get_map

already_have_map:
	ldx	#<cottage_get_map_already_message
	ldy	#>cottage_get_map_already_message
	jmp	finish_parse_message


actually_get_map:
	; actually get map
	lda	INVENTORY_3
	ora	#INV3_MAP
	sta	INVENTORY_3

	ldx	#<cottage_get_map_message
	ldy	#>cottage_get_map_message
	jmp	finish_parse_message

	;=================
	; look
	;=================

cottage_look:

	lda	CURRENT_NOUN

	cmp	#NOUN_PAPER
	beq	cottage_look_at_ground
	cmp	#NOUN_GROUND
	beq	cottage_look_at_ground
	cmp	#NOUN_COTTAGE
	beq	cottage_look_at_cottage
	cmp	#NOUN_NONE
	beq	cottage_look_at

	jmp	parse_common_look

cottage_look_at:
	ldx	#<cottage_look_at_message
	ldy	#>cottage_look_at_message
	jmp	finish_parse_message

cottage_look_at_cottage:
	ldx	#<cottage_look_at_cottage_message
	ldy	#>cottage_look_at_cottage_message

	jsr	partial_message_step

	lda	INVENTORY_3
	and	#INV3_MAP
	beq	cottage_look_map_still_there
	rts

cottage_look_map_still_there:
	ldx	#<cottage_look_at_cottage_message_map
	ldy	#>cottage_look_at_cottage_message_map

	jmp	finish_parse_message

cottage_look_at_ground:
cottage_look_at_paper:
	ldx	#<cottage_look_at_map_message
	ldy	#>cottage_look_at_map_message
	jmp	finish_parse_message

.include "../text/dialog_cottage.inc"

