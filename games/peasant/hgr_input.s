	;====================
	; hgr input
	;====================
	; TODO: save to string
	; TODO: arbitrary Y location
	; TODO: when backspacing, erase old char not XOR

hgr_input:
	bit	KEYRESET

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

	cmp	#13			; if return, then done
	beq	done_hgr_input

	cmp	#$7f			; check if backspace
	beq	hgr_input_backspace
	cmp	#8
	beq	hgr_input_backspace

	ldx	INPUT_X
	sta	input_buffer-1,X	; store to buffer

	ldy	#184			; print char
	ldx	INPUT_X
	jsr	hgr_put_char

	ldx	INPUT_X
	cpx	#38
	bcs	input_too_big		; FIXME this is a hack
	inc	INPUT_X
input_too_big:
	jmp	hgr_input_loop

hgr_input_backspace:
	ldx	INPUT_X
	cpx	#1		; don't backspace too far
	beq	hgr_input_loop

	dec	INPUT_X
	ldx	INPUT_X

	lda	input_buffer-1,X	; load old char
	ldy	#184
	jsr	hgr_put_char		; xor it on top

	jmp	hgr_input_loop

done_hgr_input:

	ldx	INPUT_X			; NUL terminate
	lda	#0
	sta	input_buffer-1,X

	rts

input_buffer:
	.byte 0,0,0,0,0,0,0,0,0,0
	.byte 0,0,0,0,0,0,0,0,0,0
	.byte 0,0,0,0,0,0,0,0,0,0
	.byte 0,0,0,0,0,0,0,0,0,0
