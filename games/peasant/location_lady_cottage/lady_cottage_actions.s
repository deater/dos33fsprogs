.include "../tokens.inc"

	;=======================
	;=======================
	;=======================
	; Baby Lady Cottage
	;=======================
	;=======================
	;=======================

lady_cottage_verb_table:
	.byte VERB_LOOK
	.word lady_cottage_look-1
	.byte VERB_KNOCK
	.word lady_cottage_knock-1
	.byte VERB_OPEN
	.word lady_cottage_open-1
	.byte VERB_GET
	.word lady_cottage_get-1
	.byte VERB_TAKE
	.word lady_cottage_get-1
	.byte VERB_SEARCH
	.word lady_cottage_search-1
	.byte 0

	;=================
	; look
	;=================

lady_cottage_look:

	lda	CURRENT_NOUN

	cmp	#NOUN_BERRIES
	beq	lady_cottage_look_at_berries
	cmp	#NOUN_BUSH
	beq	lady_cottage_look_at_bushes
	cmp	#NOUN_COTTAGE
	beq	lady_cottage_look_at_cottage
	cmp	#NOUN_DOOR
	beq	lady_cottage_look_at_door
	cmp	#NOUN_NONE
	beq	lady_cottage_look_at

	jmp	parse_common_look

lady_cottage_look_at:
	ldx	#<lady_cottage_look_at_message
	ldy	#>lady_cottage_look_at_message
	jmp	finish_parse_message

lady_cottage_look_at_cottage:
	ldx	#<lady_cottage_look_at_cottage_message
	ldy	#>lady_cottage_look_at_cottage_message
	jmp	finish_parse_message

lady_cottage_look_at_door:
	ldx	#<lady_cottage_look_at_door_message
	ldy	#>lady_cottage_look_at_door_message
	jmp	finish_parse_message

lady_cottage_look_at_berries:
	ldx	#<lady_cottage_look_at_berries_message
	ldy	#>lady_cottage_look_at_berries_message
	jmp	finish_parse_message

lady_cottage_look_at_bushes:
	ldx	#<lady_cottage_look_at_bushes_message
	ldy	#>lady_cottage_look_at_bushes_message
	jmp	finish_parse_message


	;================
	; knock
	;================
lady_cottage_knock:
	lda	CURRENT_NOUN

	cmp	#NOUN_DOOR
	beq	lady_cottage_knock_door
	cmp	#NOUN_NONE
	beq	lady_cottage_knock_door

	jmp	parse_common_unknown

lady_cottage_knock_door:

	lda	GAME_STATE_0
	and	#LADY_GONE
	bne	lady_cottage_knock_door_gone

	ldx	#<lady_cottage_knock_door_message
	ldy	#>lady_cottage_knock_door_message
	jmp	finish_parse_message

lady_cottage_knock_door_gone:
	ldx	#<lady_cottage_knock_door_gone_message
	ldy	#>lady_cottage_knock_door_gone_message
	jmp	finish_parse_message


	;================
	; open
	;================
lady_cottage_open:
	lda	CURRENT_NOUN

	cmp	#NOUN_DOOR
	beq	lady_cottage_open_door
	cmp	#NOUN_NONE
	beq	lady_cottage_open_door

	jmp	parse_common_unknown

lady_cottage_open_door:

	; walk to door
	ldx	#23
	ldy	#116
	jsr	peasant_walkto

	; print message

	ldx	#<lady_cottage_open_door_message
	ldy	#>lady_cottage_open_door_message

	jsr	partial_message_step

	; walk on in

	lda	#LOCATION_INSIDE_LADY
	jsr	update_map_location

	rts

	;================
	; get
	;================
lady_cottage_get:
	lda	CURRENT_NOUN

	cmp	#NOUN_BERRIES
	beq	lady_cottage_handle_berries

	jmp	parse_common_get

	;================
	; search
	;================
lady_cottage_search:
	lda	CURRENT_NOUN

	cmp	#NOUN_BUSH
	beq	lady_cottage_handle_berries

	jmp	parse_common_unknown


	;===================
	; handle the bushes
	;===================
lady_cottage_handle_berries:

	lda	BUSH_STATUS
	cmp	#$f
	bne	try_bushes
already_got_trinket:

	ldx	#<lady_cottage_already_trinket_message
	ldy	#>lady_cottage_already_trinket_message
	jmp	finish_parse_message

try_bushes:
	; sort of a quadrant
	; walks you over to the one in the quadrant

	lda	PEASANT_X
	cmp	#15
	bcc	left_bush
right_bush:
	lda	PEASANT_Y
	cmp	#$6D
	bcc	handle_bush4
	bcs	handle_bush3

left_bush:
	lda	PEASANT_Y
	cmp	#$6D
	bcc	handle_bush2
	bcs	handle_bush1

	; bottom left
handle_bush1:
	lda	BUSH_STATUS
	and	#BUSH_1_SEARCHED
	bne	bush_already_searched

	lda	BUSH_STATUS
	ora	#BUSH_1_SEARCHED
	bne	actually_search_bush	; bra

	; top left
handle_bush2:
	lda	BUSH_STATUS
	and	#BUSH_2_SEARCHED
	bne	bush_already_searched

	lda	BUSH_STATUS
	ora	#BUSH_2_SEARCHED
	bne	actually_search_bush	; bra

	; bottom right
handle_bush3:
	lda	BUSH_STATUS
	and	#BUSH_3_SEARCHED
	bne	bush_already_searched

	lda	BUSH_STATUS
	ora	#BUSH_3_SEARCHED
	bne	actually_search_bush	; bra

	; top right
handle_bush4:
	lda	BUSH_STATUS
	and	#BUSH_4_SEARCHED
	bne	bush_already_searched

	lda	BUSH_STATUS
	ora	#BUSH_4_SEARCHED
;	bne	actually_search_bush	; bra


actually_search_bush:
	sta	BUSH_STATUS
	tax
	lda	bush_count_lookup,X
	cmp	#1
	beq	searched_1_bush
	cmp	#2
	beq	searched_2_bush
	cmp	#3
	beq	searched_3_bush

searched_4_bush:

	; add 2 points to score

	lda	#2
	jsr	score_points

	; get trinket

	lda	INVENTORY_2
	ora	#INV2_TRINKET
	sta	INVENTORY_2

	ldx	#<lady_cottage_searched_4_bushes_message
	ldy	#>lady_cottage_searched_4_bushes_message
	jmp	finish_parse_message

searched_1_bush:
	ldx	#<lady_cottage_searched_1_bush_message
	ldy	#>lady_cottage_searched_1_bush_message
	jmp	finish_parse_message

searched_2_bush:
	ldx	#<lady_cottage_searched_2_bushes_message
	ldy	#>lady_cottage_searched_2_bushes_message
	jmp	finish_parse_message

searched_3_bush:
	ldx	#<lady_cottage_searched_3_bushes_message
	ldy	#>lady_cottage_searched_3_bushes_message
	jmp	finish_parse_message

bush_already_searched:
	ldx	#<lady_cottage_already_searched_message
	ldy	#>lady_cottage_already_searched_message
	jmp	finish_parse_message



	; probably a better way to do this?
bush_count_lookup:
	.byte $00	; 0000
	.byte $01	; 0001
	.byte $01	; 0010
	.byte $02	; 0011
	.byte $01	; 0100
	.byte $02	; 0101
	.byte $02	; 0110
	.byte $03	; 0111
	.byte $01	; 1000
	.byte $02	; 1001
	.byte $02	; 1010
	.byte $03	; 1011
	.byte $02	; 1100
	.byte $03	; 1101
	.byte $03	; 1110
	.byte $04	; 1111


.include "../text/dialog_lady_cottage.inc"
