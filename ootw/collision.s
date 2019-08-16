TARGET_NONE	= $00
TARGET_DOOR	= $10
TARGET_SHIELD	= $20
TARGET_FRIEND	= $30
TARGET_ALIEN	= $40

; FIXME!!!!
; if doors/aliens/shields then stop check if X passing them.  URGH.



	;=============================
	;=============================
	; recalc_walk_collision
	;=============================
	;=============================
	; far left limit is LEVEL_LEFT limit
	; far right limit is LEVEL_RIGHT limit
	; any LOCKED doors in the way also stop things
	; FIXME: only door collision if on same level
recalc_walk_collision:

	lda	RIGHT_LIMIT
	sta	RIGHT_WALK_LIMIT

	lda	LEFT_LIMIT
	sta	LEFT_WALK_LIMIT

	lda	NUM_DOORS
	beq	done_recalc_walk_right_collision

recalc_walk_left:

	lda	PHYSICIST_X

	ldy	NUM_DOORS
	dey
recalc_walk_left_loop:

	cmp	door_x,Y
	bcc	recalc_walk_left_continue	; bcs

	lda	(DOOR_STATUS),Y
	cmp	#DOOR_STATUS_LOCKED
	bne	recalc_walk_left_continue

	; early exit
	lda	door_x,Y
	ora	#$80
	sta	LEFT_WALK_LIMIT
	jmp	done_recalc_walk_left_collision

recalc_walk_left_continue:
	dey
	bpl	recalc_walk_left_loop

done_recalc_walk_left_collision:

	lda	PHYSICIST_X

	ldy	#0
recalc_walk_right_loop:

	cmp	door_x,Y
	bcs	recalc_walk_right_continue	; bge

	lda	(DOOR_STATUS),Y
	cmp	#DOOR_STATUS_LOCKED
	bne	recalc_walk_right_continue

	; early exit
	lda	door_x,Y
	sec
	sbc	#4
	ora	#$80
	sta	RIGHT_WALK_LIMIT
	jmp	done_recalc_walk_right_collision

recalc_walk_right_continue:
	iny
	cpy	NUM_DOORS
	bne	recalc_walk_right_loop

done_recalc_walk_right_collision:


	rts





	;=============================
	;=============================
	; calc_gun_right_collision
	;=============================
	;=============================
	; far right limit is LEVEL_RIGHT
	; any LOCKED or CLOSED doors stop things
	; any shield stops things
	; our friend stops things
	; any enemies stop things

calc_gun_right_collision:

	lda	#$00
	sta	RIGHT_SHOOT_TARGET

	lda	RIGHT_LIMIT
	and	#$7f
	sta	RIGHT_SHOOT_LIMIT

	;===========================
	; stop if hit door

calc_gun_right_door:
	lda	NUM_DOORS
	beq	done_calc_gun_right_door_collision

calc_gun_right_doors:


	ldy	#0
calc_gun_right_door_loop:

	lda	PHYSICIST_X

	cmp	door_x,Y
	bcs	calc_gun_right_door_continue		; bge

	lda	(DOOR_STATUS),Y
	cmp	#DOOR_STATUS_LOCKED
	beq	calc_gun_right_door_there
	cmp	#DOOR_STATUS_CLOSED
	bne	calc_gun_right_door_continue

calc_gun_right_door_there:
	; early exit
	lda	door_x,Y
	sta	RIGHT_SHOOT_LIMIT

	tya			; set target if hit
	ora	#TARGET_DOOR
	sta	RIGHT_SHOOT_TARGET

	jmp	done_calc_gun_right_door_collision

calc_gun_right_door_continue:
	iny
	cpy	NUM_DOORS
	bne	calc_gun_right_door_loop

done_calc_gun_right_door_collision:


	;==========================
	; adjust for alien

calc_gun_right_alien:

	lda	ALIEN_OUT
	beq	done_calc_gun_right_alien_collision

	ldx	#0
calc_gun_right_alien_loop:

	lda	alien_out,X
	beq	calc_gun_right_alien_continue

	lda	PHYSICIST_X

	cmp	alien_x,X
	bcs	calc_gun_right_alien_continue		; bge

	lda	alien_state,X
	cmp	#A_DISINTEGRATING
	beq	calc_gun_right_alien_continue

calc_gun_right_alien_there:
	; early exit
	lda	alien_x,X
	sta	RIGHT_SHOOT_LIMIT

	txa			; set target if hit
	ora	#TARGET_ALIEN
	sta	RIGHT_SHOOT_TARGET

	jmp	done_calc_gun_right_alien_collision

calc_gun_right_alien_continue:
	inx
	cpx	#MAX_ALIENS
	bne	calc_gun_right_alien_loop

done_calc_gun_right_alien_collision:
	rts



	;=============================
	;=============================
	; calc_gun_left_collision
	;=============================
	;=============================
	; far right limit is LEVEL_LEFT
	; any LOCKED or CLOSED doors stop things
	; any shield stops things
	; our friend stops things
	; any enemies stop things

calc_gun_left_collision:

	lda	#0
	sta	LEFT_SHOOT_TARGET

	lda	LEFT_LIMIT
	sec
	sbc	#$80
	bpl	left_limit_ok
	lda	#0

left_limit_ok:
	sta	LEFT_SHOOT_LIMIT

	lda	NUM_DOORS
	beq	done_calc_gun_left_door_collision

calc_gun_left_doors:


	ldy	NUM_DOORS
	dey
calc_gun_left_door_loop:
	lda	PHYSICIST_X

	cmp	door_x,Y
	bcc	calc_gun_left_door_continue		; blt

	lda	(DOOR_STATUS),Y
	cmp	#DOOR_STATUS_LOCKED
	beq	calc_gun_left_door_there
	cmp	#DOOR_STATUS_CLOSED
	bne	calc_gun_left_door_continue

calc_gun_left_door_there:
	; early exit
	lda	door_x,Y
	sta	LEFT_SHOOT_LIMIT

	tya			; set target if hit
	ora	#TARGET_DOOR
	sta	LEFT_SHOOT_TARGET

	jmp	done_calc_gun_left_door_collision

calc_gun_left_door_continue:
	dey
	bpl	calc_gun_left_door_loop

done_calc_gun_left_door_collision:


	;==========================
	; adjust for alien

calc_gun_left_alien:

	lda	ALIEN_OUT
	beq	done_calc_gun_left_alien_collision

	ldx	#MAX_ALIENS
	dex

calc_gun_left_alien_loop:

	lda	alien_out,X
	beq	calc_gun_left_alien_continue

	lda	PHYSICIST_X

	cmp	alien_x,X
	bcc	calc_gun_left_alien_continue		; blt

	lda	alien_state,X
	cmp	#A_DISINTEGRATING
	beq	calc_gun_left_alien_continue

calc_gun_left_alien_there:
	; early exit
	lda	alien_x,X
	sta	LEFT_SHOOT_LIMIT

	txa			; set target if hit
	ora	#TARGET_ALIEN
	sta	LEFT_SHOOT_TARGET

	jmp	done_calc_gun_left_alien_collision

calc_gun_left_alien_continue:
	dex
	bpl	calc_gun_left_alien_loop

done_calc_gun_left_alien_collision:

	rts


