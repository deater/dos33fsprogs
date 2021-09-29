	; parse input

parse_input:
;	jsr	hgr_save

	lda	input_buffer		; get first char FIXME
	and	#$DF			; make uppercase 0110 0001 -> 0100 0001

parse_copy:
	cmp	#'C'
	bne	parse_inventory

	; want copy
	lda	#NEW_FROM_DISK
	sta	GAME_OVER

	lda     #LOAD_COPY_CHECK
	sta	WHICH_LOAD

	jmp	done_parse_message


parse_inventory:
	cmp	#'I'
	bne	parse_l

	jsr	show_inventory

	jmp	restore_parse_message

parse_l:
	cmp	#'L'
        bne     parse_talk

	lda	input_buffer+2
	and	#$DF			; make uppercase 0110 0001 -> 0100 0001
	cmp	#'O'
	beq	parse_look
parse_load:
	jsr	load_menu

	jmp	restore_parse_message

parse_look:

        lda     #<fake_error1
        sta     OUTL
        lda     #>fake_error1
	jmp	finish_parse_message


parse_talk:
	cmp	#'T'
        bne     parse_show

        lda     #<fake_error2
        sta     OUTL
        lda     #>fake_error2
	jmp	finish_parse_message

parse_show:
	cmp	#'S'
        bne     parse_version

;	bit	LORES
;	bit	PAGE1

;	jsr	wait_until_keypress

;	bit	PAGE2
;	bit	HIRES

;	jmp	done_parse_message

	jsr	save_menu

	jmp	restore_parse_message

parse_version:
	cmp	#'V'
        bne     parse_help

        lda     #<version_message
        sta     OUTL
        lda     #>version_message
	jmp	finish_parse_message

parse_help:
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
