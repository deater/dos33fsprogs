
	;=====================================
	; walk to
	;	go one step from PEASANT_X, PEASANT_Y
	;	to WALK_DEST_X, WALK_DEST_Y
	; if PEASANT_X>WALK_DEST_X face left
	; else WALK_DEST_X face right
	; if PEASANT_X==WALK_DEST_X
	;    if PEASANT_Y>WALK_DEST_Y face up
	;    else WALK_DEST_Y face down

	;
	; TODO: facing (which has priority?)
	;	sub-pixel co-ords
	;	what if overshoot?  should go to final dest


	; carry set = at final destination

walk_to:
	; check over
	lda	PEASANT_X
	cmp	WALK_DEST_X
	bne	walk_to_done_check
	lda	PEASANT_Y
	cmp	WALK_DEST_Y
	bne	walk_to_done_check
	sec				; say we're at end
	rts


walk_to_done_check:

walk_to_step:

walk_check_x:
	lda	PEASANT_X
	cmp	WALK_DEST_X
	beq	walk_check_y
	bcc	walk_to_right
walk_to_left:
	sec
	lda	PEASANT_X
	sbc	PEASANT_XADD
	sta	PEASANT_X
	jmp	walk_check_y
walk_to_right:
	clc
	lda	PEASANT_X
	adc	PEASANT_XADD
	sta	PEASANT_X

	; fallthrough

walk_check_y:
	lda	PEASANT_Y
	cmp	WALK_DEST_Y
	beq	done_walk_to_step
	bcc	walk_to_down
walk_to_up:
	sec
	lda	PEASANT_Y
	sbc	PEASANT_YADD
	sta	PEASANT_Y
	jmp	done_walk_to_step

walk_to_down:
	clc
	lda	PEASANT_Y
	adc	PEASANT_YADD
	sta	PEASANT_Y

done_walk_to_step:

	clc
	rts
