	;====================
	; hgr input
	;====================
	; TODO: save to string
	; TODO: arbitrary Y location
	; TODO: when backspacing, erase old char not XOR

	; INPUT_X points to next char
	;	we print to chars to right

hgr_input:

	; current keypress in A

	ldx	DRAW_PAGE
	stx	DRAW_PAGE_SAVE

	ldx	#$40			; all writing goes to $6000
	stx	DRAW_PAGE


input_currently_happening:

	; check for backspace
	;	actually DELETE (on Apple IIe) or ^B (II+)
	;	we can't use backspace/^H as maps to left arrow
	;	and the game assumes that means you want to walk left
	; this does mean it's hard to backspace on some emulators,
	;	but that's an eternal challenge with Apple II emulators

	cmp	#$7f			; check if DELETE (backspace)
	beq	hgr_input_backspace
	cmp	#2			; ^B, option for Apple II+
	beq	hgr_input_backspace

	ldx	INPUT_X
	sta	input_buffer,X		; store to buffer

	ldy	#184			; print char
	ldx	INPUT_X
	inx				; print two to the right
	inx				; because of prompt
	jsr	hgr_put_char

	ldx	INPUT_X
	cpx	#37
	bcs	input_too_big		; FIXME this is a hack
	inc	INPUT_X
input_too_big:

	jmp	hgr_input_exit

hgr_input_backspace:
	ldx	INPUT_X
	beq	done_backspace		; don't backspace too far

	dec	INPUT_X
	ldx	INPUT_X

	lda	input_buffer,X		; load old char
	inx
	inx
	ldy	#184
	jsr	hgr_put_char		; xor it on top


done_backspace:

hgr_input_exit:

	lda	DRAW_PAGE_SAVE
	sta	DRAW_PAGE

	rts

	;===================================
	; only called by enter_pressed(?)

done_hgr_input:

	ldx	INPUT_X			; NUL terminate
	lda	#0
	sta	input_buffer,X
	rts


input_buffer:
	.byte 0,0,0,0,0,0,0,0,0,0
	.byte 0,0,0,0,0,0,0,0,0,0
	.byte 0,0,0,0,0,0,0,0,0,0
	.byte 0,0,0,0,0,0,0,0,0,0
