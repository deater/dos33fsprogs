


; Soft Switches
KEYPRESS= $C000
KEYRESET= $C010


test_sound:

	lda	KEYPRESS
	bpl	test_sound
	bit	KEYRESET

	jsr	play_note
	jmp	test_sound




play_note:
	lda	#$83
	sta	smc1+1
	sta	smc2+1
note_loop:
smc2:
	ldx	#$83
smc1:
l86cb:	cpx	#$95
	beq	l86e9
	bcc	l86d8
	lda	$C056		; (lores)
	nop
	jmp	l86dd
l86d8:	lda	$C057		; (hires)
	nop
	nop
l86dd:	inx
	bne	l86f1
	lda	$C030		; speaker
	inc	smc1+1
	bne	note_loop
	rts
l86e9:	lda	$c030		; speaker
	lda	$00
	jmp	l86dd
l86f1:	lda	$ffff
	lda	$ffff
	lda	$00
	jmp	l86cb

