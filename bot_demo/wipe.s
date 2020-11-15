; for x=0 to 39
; then 79 down to 40
; then 80 to 119

do_wipe:

	ldx	#0
top_line_loop:

	lda	$c00,X
	sta	$400,X
	lda	$c80,X
	sta	$480,X
	lda	$d00,X
	sta	$500,X
	lda	$d80,X
	sta	$580,X
	lda	$e00,X
	sta	$600,X
	lda	$e80,X
	sta	$680,X
	lda	$f00,X
	sta	$700,X
	lda	$f80,X
	sta	$780,X

	lda	#80
	jsr	WAIT

	cpx	#40
	bcc	count_up	; blt
	cpx	#80
	bcc	count_down	; blt

count_up:
	inx
	cpx	#120
	beq	done_wipe
	cpx	#40
	bne	continue_wipe

	; switch direction
	ldx	#80
count_down:
	dex
	cpx	#39
	bne	continue_wipe

	ldx	#80

continue_wipe:
	jmp	top_line_loop

done_wipe:
	rts
