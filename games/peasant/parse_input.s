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

check_copy:

	cmp	#VERB_COPY
	bne	check_inventory

	; want copy
	lda	#NEW_FROM_DISK
	sta	GAME_OVER

	lda     #LOAD_COPY_CHECK
	sta	WHICH_LOAD

	jmp	done_parse_message

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

        lda     #<fake_error1
        sta     OUTL
        lda     #>fake_error1
	jmp	finish_parse_message


check_talk:
	cmp	#VERB_TALK
	bne	check_save

	lda	#<fake_error2
	sta	OUTL
	lda	#>fake_error2
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
	bne	check_help

        lda     #<version_message
        sta     OUTL
        lda     #>version_message
	jmp	finish_parse_message

check_help:
	lda	#<help_message
	sta	OUTL
	lda	#>help_message

finish_parse_message:
        sta     OUTH
        jsr     hgr_text_box

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
.byte "COPY",VERB_COPY|$80
.byte "INV",VERB_INVENTORY|$80
.byte "LOAD",VERB_LOAD|$80
.byte "LOOK",VERB_LOOK|$80
.byte "TALK",VERB_TALK|$80
.byte "SAVE",VERB_SAVE|$80
.byte "SHOW",VERB_SHOW|$80
.byte "VER",VERB_VERSION|$80
.byte $00
