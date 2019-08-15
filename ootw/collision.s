	;=============================
	;=============================
	; recalc_walk_collision
	;=============================
	;=============================
	; far left limit is LEVEL_LEFT limit
	; far right limit is LEVEL_RIGHT limit
	; any LOCKED doors in the way also stop things
recalc_walk_collision:

	lda	RIGHT_LIMIT
	sta	RIGHT_WALK_LIMIT

	lda	LEFT_LIMIT
	sta	LEFT_WALK_LIMIT

	lda	NUM_DOORS
	beq	done_recalc_walk_right_collision

recalc_walk_left:

	lda	PHYSICIST_X

	ldx	NUM_DOORS
	dex
recalc_walk_left_loop:

	cmp	door_x,X
	bcc	recalc_walk_left_continue	; bcs

	lda	door_status,X
	cmp	#DOOR_STATUS_LOCKED
	bne	recalc_walk_left_continue

	; early exit
	lda	door_x,X
	ora	#$80
	sta	LEFT_WALK_LIMIT
	jmp	done_recalc_walk_left_collision

recalc_walk_left_continue:
	dex
	bpl	recalc_walk_left_loop

done_recalc_walk_left_collision:

	lda	PHYSICIST_X

	ldx	#0
recalc_walk_right_loop:

	cmp	door_x,X
	bcs	recalc_walk_right_continue	; bge

	lda	door_status,X
	cmp	#DOOR_STATUS_LOCKED
	bne	recalc_walk_right_continue

	; early exit
	lda	door_x,X
	sec
	sbc	#4
	ora	#$80
	sta	RIGHT_WALK_LIMIT
	jmp	done_recalc_walk_right_collision

recalc_walk_right_continue:
	inx
	cpx	NUM_DOORS
	bne	recalc_walk_right_loop

done_recalc_walk_right_collision:


	rts
