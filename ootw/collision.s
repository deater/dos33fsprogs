TARGET_NONE	= $00
TARGET_DOOR	= $10
TARGET_SHIELD	= $20
TARGET_FRIEND	= $30
TARGET_ALIEN	= $40
TARGET_PHYSICIST= $80

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

	; note the limits have $80 added to them :(

	lda	RIGHT_LIMIT
	sta	RIGHT_WALK_LIMIT

	lda	LEFT_LIMIT
	sta	LEFT_WALK_LIMIT

	lda	NUM_DOORS
	beq	done_recalc_walk_right_collision

recalc_walk_left:

	ldy	NUM_DOORS
	dey
recalc_walk_left_loop:

	lda	PHYSICIST_X
	cmp	(DOOR_X),Y
	bcc	recalc_walk_left_continue	; blt

	; only if on same level
	lda	(DOOR_Y),Y
	clc
	adc	#4
	cmp	PHYSICIST_Y
	bne	recalc_walk_left_continue

	; only if closer than previous found
	lda	(DOOR_X),Y
	ora	#$80
	cmp	LEFT_WALK_LIMIT

	bcc	recalc_walk_left_continue	; blt

	lda	(DOOR_STATUS),Y
	cmp	#DOOR_STATUS_LOCKED
	bne	recalc_walk_left_continue

	; early exit
	lda	(DOOR_X),Y
	ora	#$80
	sta	LEFT_WALK_LIMIT
;	jmp	done_recalc_walk_left_collision

recalc_walk_left_continue:
	dey
	bpl	recalc_walk_left_loop

done_recalc_walk_left_collision:


	ldy	#0
recalc_walk_right_loop:

	; only if on same level
	lda	(DOOR_Y),Y
	clc
	adc	#4
	cmp	PHYSICIST_Y
	bne	recalc_walk_right_continue

	lda	PHYSICIST_X
	cmp	(DOOR_X),Y
	bcs	recalc_walk_right_continue	; bge

	; only if closer than previous found
	lda	(DOOR_X),Y
	ora	#$80
	cmp	RIGHT_WALK_LIMIT

	bcs	recalc_walk_right_continue	; bge

	lda	(DOOR_STATUS),Y
	cmp	#DOOR_STATUS_LOCKED
	bne	recalc_walk_right_continue

	; early exit
	lda	(DOOR_X),Y
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
	; any LOCKED or CLOSED doors with SAME_Y to left of LEVEL_RIGHT
	; any shield stops things
	; our friend stops things
	; any enemies stop things

calc_gun_right_collision:

	lda	#$00
	sta	RIGHT_SHOOT_TARGET

	;=====================================================================
	; by default set it to left limit (which is often but not always a wall)

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

	; only if on same level
	lda	(DOOR_Y),Y
	clc
	adc	#4
	cmp	COLLISION_Y
	bne	calc_gun_right_door_continue

	lda	COLLISION_X
	cmp	(DOOR_X),Y
	bcs	calc_gun_right_door_continue		; bge

	lda	(DOOR_STATUS),Y
	cmp	#DOOR_STATUS_LOCKED
	beq	calc_gun_right_door_there
	cmp	#DOOR_STATUS_CLOSED
	bne	calc_gun_right_door_continue

calc_gun_right_door_there:
	; early exit
	lda	(DOOR_X),Y
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
	; adjust for shield

calc_gun_right_shield:

	lda	SHIELD_OUT
	beq	done_calc_gun_right_shield_collision

	ldx	#0
calc_gun_right_shield_loop:

	; FIXME: check for on same level?

	lda	shield_out,X
	beq	calc_gun_right_shield_continue

	lda	COLLISION_X
	cmp	shield_x,X
	bcs	calc_gun_right_shield_continue		; bge

	; be sure closer than current max limit
	lda	RIGHT_SHOOT_LIMIT
	cmp	shield_x,X
	bcc	calc_gun_right_shield_continue		; blt

calc_gun_right_shield_there:

	lda	shield_x,X
	sta	RIGHT_SHOOT_LIMIT

	txa			; set target if hit
	ora	#TARGET_SHIELD
	sta	RIGHT_SHOOT_TARGET

	; can't early exit

calc_gun_right_shield_continue:
	inx
	cpx	#MAX_SHIELDS
	bne	calc_gun_right_shield_loop

done_calc_gun_right_shield_collision:


	;==========================
	; adjust for friend

calc_gun_right_friend:

	lda	friend_room
	cmp	WHICH_ROOM
	bne	done_calc_gun_right_friend_collision

	lda	COLLISION_X
	cmp	friend_x
	bcs	calc_gun_right_friend_continue		; bge

	; only if closer than previous found
	lda	RIGHT_SHOOT_LIMIT
	cmp	friend_x
	bcc	calc_gun_right_friend_continue		; blt

	lda	friend_state
	cmp	#F_DISINTEGRATING
	beq	calc_gun_right_friend_continue

calc_gun_right_friend_there:
	; early exit
	lda	friend_x
	sta	RIGHT_SHOOT_LIMIT

				; set target if hit
	lda	#TARGET_FRIEND
	sta	RIGHT_SHOOT_TARGET

calc_gun_right_friend_continue:

done_calc_gun_right_friend_collision:


	;==========================
	; adjust for physicist

calc_gun_right_physicist:

	lda	COLLISION_X
	cmp	PHYSICIST_X
	bcs	calc_gun_right_physicist_continue	; bge

	; only if closer than previous found
	lda	RIGHT_SHOOT_LIMIT
	cmp	PHYSICIST_X
	bcc	calc_gun_right_physicist_continue	; blt

	lda	PHYSICIST_STATE
	cmp	#P_DISINTEGRATING
	beq	calc_gun_right_physicist_continue

calc_gun_right_physicist_there:

	lda	PHYSICIST_X
	sta	RIGHT_SHOOT_LIMIT

				; set target if hit
	lda	#TARGET_PHYSICIST
	sta	RIGHT_SHOOT_TARGET

calc_gun_right_physicist_continue:
done_calc_gun_right_physicist_collision:



	;==========================
	; adjust for alien

calc_gun_right_alien:

	lda	ALIEN_OUT
	beq	done_calc_gun_right_alien_collision

	ldx	#0
calc_gun_right_alien_loop:

	lda	alien_room,X
	cmp	WHICH_ROOM
	bne	calc_gun_right_alien_continue

	; only if on same level
	lda	alien_y,X
	cmp	COLLISION_Y
	bne	calc_gun_right_alien_continue

	lda	COLLISION_X
	cmp	alien_x,X
	bcs	calc_gun_right_alien_continue		; bge

	; only if closer than previous found
	lda	RIGHT_SHOOT_LIMIT
	cmp	alien_x,X
	bcc	calc_gun_right_alien_continue		; blt

	lda	alien_state,X
	cmp	#A_DISINTEGRATING
	beq	calc_gun_right_alien_continue

calc_gun_right_alien_there:
	lda	alien_x,X
	sta	RIGHT_SHOOT_LIMIT

	txa			; set target if hit
	ora	#TARGET_ALIEN
	sta	RIGHT_SHOOT_TARGET

	; can't early exit

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

	;=============================
	; by default set to left limit
	; tricky as LEFT_LIMIT does some hacks to put it up above $80

	lda	LEFT_LIMIT
	sec
	sbc	#$80
	bpl	left_limit_ok
	lda	#0

left_limit_ok:
	sta	LEFT_SHOOT_LIMIT

	;==========================
	; stop if hit door

calc_gun_left_door:
	lda	NUM_DOORS
	beq	done_calc_gun_left_door_collision

calc_gun_left_doors:


	ldy	NUM_DOORS
	dey
calc_gun_left_door_loop:

	; only if on same level
	lda	(DOOR_Y),Y
	clc
	adc	#4
	cmp	COLLISION_Y
	bne	calc_gun_left_door_continue

	lda	COLLISION_X
	cmp	(DOOR_X),Y
	bcc	calc_gun_left_door_continue		; blt

	lda	(DOOR_STATUS),Y
	cmp	#DOOR_STATUS_LOCKED
	beq	calc_gun_left_door_there
	cmp	#DOOR_STATUS_CLOSED
	bne	calc_gun_left_door_continue

calc_gun_left_door_there:
	; early exit
	lda	(DOOR_X),Y
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
	; adjust for shield

calc_gun_left_shield:

	lda	SHIELD_OUT
	beq	done_calc_gun_left_shield_collision

	ldx	#0

calc_gun_left_shield_loop:

	lda	shield_out,X
	beq	calc_gun_left_shield_continue

	lda	COLLISION_X
	cmp	shield_x,X
	bcc	calc_gun_left_shield_continue		; blt

	; be sure closer than current max limit
	lda	LEFT_SHOOT_LIMIT
	cmp	shield_x,X
	bcs	calc_gun_left_shield_continue		; bge

calc_gun_left_shield_there:

	lda	shield_x,X
	sta	LEFT_SHOOT_LIMIT

	txa			; set target if hit
	ora	#TARGET_SHIELD
	sta	LEFT_SHOOT_TARGET

	; can't early exit

calc_gun_left_shield_continue:
	inx
	cpx	#MAX_SHIELDS
	bne	calc_gun_left_shield_loop


done_calc_gun_left_shield_collision:


	;==========================
	; adjust for friend

calc_gun_left_friend:

	lda	friend_room
	cmp	WHICH_ROOM
	bne	done_calc_gun_left_friend_collision

	lda	COLLISION_X
	cmp	friend_x
	bcc	calc_gun_left_friend_continue		; blt

	; only if closer than previous found
	lda	LEFT_SHOOT_LIMIT
	cmp	friend_x
	bcs	calc_gun_left_friend_continue		; bge

	lda	friend_state
	cmp	#F_DISINTEGRATING
	beq	calc_gun_left_friend_continue

calc_gun_left_friend_there:

	lda	friend_x
	sta	LEFT_SHOOT_LIMIT
				; set target if hit
	lda	#TARGET_FRIEND
	sta	LEFT_SHOOT_TARGET

calc_gun_left_friend_continue:
done_calc_gun_left_friend_collision:



	;==========================
	; adjust for physicist

calc_gun_left_physicist:

	lda	COLLISION_X
	cmp	PHYSICIST_X
	beq	calc_gun_left_physicist_continue	; ble (not w self)
	bcc	calc_gun_left_physicist_continue	; blt

	; only if closer than previous found
	lda	LEFT_SHOOT_LIMIT
	cmp	PHYSICIST_X
	bcs	calc_gun_left_physicist_continue	; bge

	lda	PHYSICIST_STATE
	cmp	#P_DISINTEGRATING
	beq	calc_gun_left_physicist_continue

calc_gun_left_physicist_there:

	lda	PHYSICIST_X
	sta	LEFT_SHOOT_LIMIT
				; set target if hit
	lda	#TARGET_PHYSICIST
	sta	LEFT_SHOOT_TARGET

calc_gun_left_physicist_continue:
done_calc_gun_left_physicist_collision:




	;==========================
	; adjust for alien

calc_gun_left_alien:

	lda	ALIEN_OUT
	beq	done_calc_gun_left_alien_collision

	ldx	#MAX_ALIENS
	dex

calc_gun_left_alien_loop:

	lda	alien_room,X
	cmp	WHICH_ROOM
	bne	calc_gun_left_alien_continue

	; only if on same level
	lda	alien_y,X
	cmp	COLLISION_Y
	bne	calc_gun_left_alien_continue

	lda	COLLISION_X
	cmp	alien_x,X
	beq	calc_gun_left_alien_continue		; if exact equal
							; might be ourselves
	bcc	calc_gun_left_alien_continue		; blt

	; only if closer than previous found
	lda	LEFT_SHOOT_LIMIT
	cmp	alien_x,X
	bcs	calc_gun_left_alien_continue		; bge

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


