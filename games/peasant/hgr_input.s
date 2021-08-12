	;====================
	; hgr input
	;====================
	; TODO: save to string
	; TODO: arbitrary Y location
	; TODO: when backspacing, erase old char not XOR

hgr_input:

	ldx	#0
	ldy	#184
	lda	#'>'
	jsr	hgr_put_char

	ldx	#1
	stx	INPUT_X

hgr_input_loop:
	lda	KEYPRESS
	bpl	hgr_input_loop

	bit	KEYRESET

	and	#$7f			; trim off top?

	cmp	#13
	beq	done_hgr_input

	cmp	#$7f
	beq	hgr_input_backspace
	cmp	#8
	beq	hgr_input_backspace

	ldy	#184
	ldx	INPUT_X
	jsr	hgr_put_char

	inc	INPUT_X

	jmp	hgr_input_loop

hgr_input_backspace:
	ldx	INPUT_X
	cpx	#1		; don't backspace too far
	beq	hgr_input_loop

	lda	#' '
	ldy	#184
	jsr	hgr_put_char

	dec	INPUT_X
	jmp	hgr_input_loop

done_hgr_input:
	rts
