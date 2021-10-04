.include "tokens.inc"

	;==========================
	; parse input
	;==========================
	; input is in input_buffer

parse_input:

	; uppercase buffer

	ldx	#0
upcase_loop:
	lda	input_buffer,X
	beq	done_upcase_loop
	and	#$DF
	sta	input_buffer,X
	inx
	jmp	upcase_loop
done_upcase_loop:

	;=====================
	; get the verb

	jsr	get_verb

	;=====================
	; get the noun

;	jsr	get_noun


	;=============================
	; handle room-specific actions

;	jsr	local_parser

	;================================
	; fall through to default actions

	lda	CURRENT_VERB

check_cheat:

	cmp	#VERB_CHEAT
	bne	check_copy

	lda	#<cheat_message
	sta	OUTL
	lda	#>cheat_message
	jmp	finish_parse_message

check_copy:

	cmp	#VERB_COPY
	bne	check_dance

	; want copy
	lda	#NEW_FROM_DISK
	sta	GAME_OVER

	lda     #LOAD_COPY_CHECK
	sta	WHICH_LOAD

	jmp	done_parse_message

check_dance:

	cmp	#VERB_DANCE
	bne	check_drink

	lda	#<dance_message
	sta	OUTL
	lda	#>dance_message
	jmp	finish_parse_message

check_drink:

	cmp	#VERB_DRINK
	bne	check_inventory

	lda	#<drink_message
	sta	OUTL
	lda	#>drink_message
        sta     OUTH
	jsr	print_text_message

	jsr	wait_until_keypress

	jsr	hgr_partial_restore

	lda	#<drink_message2
	sta	OUTL
	lda	#>drink_message2
        sta     OUTH

	jmp	finish_parse_message



check_inventory:
	cmp	#VERB_INVENTORY
	bne	check_load

	jsr	show_inventory

	jmp	restore_parse_message

check_load:
	cmp	#VERB_LOAD
	bne     check_look

	jsr	load_menu

	jmp	restore_parse_message

check_look:
	cmp	#VERB_LOOK
	bne     check_talk

	lda	#<look_irrelevant_message
	sta	OUTL
	lda	#>look_irrelevant_message
	jmp	finish_parse_message


check_talk:
	cmp	#VERB_TALK
	bne	check_save

	lda	#<talk_noone_message
	sta	OUTL
	lda	#>talk_noone_message
	jmp	finish_parse_message

check_save:
	cmp	#VERB_SAVE
        bne     check_show

	jsr	save_menu

	jmp	restore_parse_message


check_show:
	cmp	#VERB_SHOW
	bne	check_version

	bit	LORES
	bit	PAGE1

	jsr	wait_until_keypress

	bit	PAGE2
	bit	HIRES

	jmp	done_parse_message

check_version:
	cmp	#VERB_VERSION
	bne	check_where

        lda     #<version_message
        sta     OUTL
        lda     #>version_message
	jmp	finish_parse_message

check_where:
	cmp	#VERB_WHERE
	bne	check_unknown

where_blargh:
	ldx	MAP_LOCATION
	lda	location_names_l,X
	sta	INL
	lda	location_names_h,X
	sta	INH

        lda     #<(where_message+22)
        sta     OUTL
        lda     #>(where_message+22)
	sta	OUTH

	ldy	#0
where_loop:
	lda	(INL),Y
	sta	(OUTL),Y
	beq	where_done
	iny
	bne	where_loop	; bra

where_done:

        lda     #<where_message
        sta     OUTL
        lda     #>where_message
	jmp	finish_parse_message


check_unknown:
	lda	#<help_message
	sta	OUTL
	lda	#>help_message

finish_parse_message:
        sta     OUTH
	jsr	print_text_message

	jsr	wait_until_keypress


restore_parse_message:

	jsr	hgr_partial_restore

done_parse_message:


	rts



	;===========================
	; get verb
	;===========================
	;
get_verb:
	lda	#VERB_UNKNOWN		; default
	sta	CURRENT_VERB

	lda	#<verb_lookup		; reset verb pointer
	sta	get_verb_loop+1
	lda	#>verb_lookup
	sta	get_verb_loop+2

next_verb_loop:
	ldx	#0
	stx	WORD_MATCH
get_verb_loop:
	lda	verb_lookup
	bmi	done_verb
	beq	done_get_verb_loop
	cmp	input_buffer,X
	beq	verb_char_matched
verb_char_nomatch:
	dec	WORD_MATCH
verb_char_matched:
	jsr	inc_verb_ptr
	inx
	jmp	get_verb_loop

done_verb:
	ldx	WORD_MATCH
	beq	found_verb

no_found_verb:
	jsr	inc_verb_ptr
	jmp	next_verb_loop

found_verb:
	and	#$7f
	sta	CURRENT_VERB

done_get_verb_loop:

	rts

inc_verb_ptr:
	inc	get_verb_loop+1
	bne	inc_verb_ptr_noflo
	inc	get_verb_loop+2
inc_verb_ptr_noflo:

	rts

verb_lookup:
.byte "CHEAT",VERB_CHEAT|$80
.byte "COPY",VERB_COPY|$80
.byte "DANCE",VERB_DANCE|$80
.byte "DRINK",VERB_DRINK|$80
.byte "INV",VERB_INVENTORY|$80
.byte "LOAD",VERB_LOAD|$80
.byte "LOOK",VERB_LOOK|$80
.byte "TALK",VERB_TALK|$80
.byte "SAVE",VERB_SAVE|$80
.byte "SHOW",VERB_SHOW|$80
.byte "VER",VERB_VERSION|$80
.byte "WHERE",VERB_WHERE|$80
.byte $00


.include "text/common.inc"


	;======================
	; print text message

	; OUTL/OUTH point to message

	; first we need to calculate the size of the message (lines)
	; next we need to set up the box

print_text_message:
	jsr	count_message_lines

	ldy	message_len
	dey

        lda     message_x1h,Y
        sta     BOX_X1H

        lda     message_x1l,Y
        sta     BOX_X1L

        lda     message_y1,Y
        sta     BOX_Y1

        lda     message_x2h,Y
        sta     BOX_X2H

        lda     message_x2l,Y
        sta     BOX_X2L

        lda     message_y2,Y
        sta     BOX_Y2

	tya
	pha

	jsr	hgr_partial_save

	jsr	draw_box

	pla
	tay

	lda	message_tx,Y
	sta	CURSOR_X

	lda	message_ty,Y
	sta	CURSOR_Y

	jsr	disp_put_string_cursor

	rts

;.byte   0,43,24, 0,253,82
;.byte   8,41

; alternate 1
;.byte 0,35,34, 0,253,72
;.byte 7,49,"OK go for it.",0

; .byte 0,35,34, 0,253,82
 ;       .byte 7,49


;                       1	2	3	4	5	6	7	8
message_x1h:	.byte	0,	0,	0,	0,	0,	0,	0,	0
message_x1l:	.byte	35,	35,	35,	35,	35,	35,	35,	35
message_y1:	.byte	24,	24,	24,	24,	20,	20,	20,	20
message_x2h:	.byte	0,	0,	0,	0,	0,	0,	0,	0
message_x2l:	.byte	253,	253,	253,	253,	253,	253,	253,	253
message_y2:	.byte	54,	62,	82,	82,	86,	86,	86,	86
message_tx:	.byte	7,	7,	7,	7,	7,	7,	7,	7
message_ty:	.byte	36,	36,	41,	35,	33,	33,	33,	33


	;======================
	; count message lines
	; in OUTL/OUTH
count_message_lines:
	ldy	#0
	sty	message_len
count_message_lines_loop:
	lda	(OUTL),Y
	beq	count_message_done
	cmp	#13
	bne	count_message_not_cr
	inc	message_len
count_message_not_cr:
	iny
	bne	count_message_lines_loop	; bra

count_message_done:
	inc	message_len	; increment for end of message too

	rts

message_len:
	.byte $0
