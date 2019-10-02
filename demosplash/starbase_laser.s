
; FIXME: merge a lot of the target code

; Handle laser

; should handle multiple at once?

; when pressed, find empty slot?
; initially 10 wide, from gun to right or left
; expand to 20 wide
; stop when encounter door, enemy, or edge of screen
; should bounds check carefully

; should handle shooting while crouching

MAX_LASERS	=	2

laser_out:
laser0_out:		.byte $0
laser1_out:		.byte $0

laser_start:
laser0_start:		.byte $0
laser1_start:		.byte $0

laser_end:
laser0_end:		.byte $0
laser1_end:		.byte $0

laser_y:
laser0_y:		.byte $0
laser1_y:		.byte $0

laser_direction:
laser0_direction:	.byte $0
laser1_direction:	.byte $0

laser_count:
laser0_count:		.byte $0
laser1_count:		.byte $0

	;=========================
	; fire laser
	;=========================

fire_laser:
	lda	PHYSICIST_X
	sta	COLLISION_X
	lda	PHYSICIST_Y
	sta	COLLISION_Y

	lda	laser0_out
	bne	done_fire_laser

	; activate laser slot

	inc	laser0_out

	; reset count

	lda	#0
	sta	laser0_count

	; set y

	lda	PHYSICIST_Y
	clc
	adc	#4

	ldx	PHYSICIST_STATE
	cpx	#P_CROUCH_SHOOTING
	bne	laser_crouch_done
laser_crouch:
	clc
	adc	#4
laser_crouch_done:
	sta	laser0_y

	; set direction

	lda	DIRECTION
	sta	laser0_direction

	beq	laser_left
	bne	laser_right

	; set x

laser_left:

	jsr	calc_gun_left_collision

	ldx	PHYSICIST_X
	dex
	stx	laser0_end

	txa
	sec
	sbc	#10
	sta	laser0_start

	jmp	done_fire_laser

laser_right:

	jsr	calc_gun_right_collision

	lda	PHYSICIST_X
	clc
	adc	#5
	sta	laser0_start

	clc
	adc	#10
	sta	laser0_end

done_fire_laser:
	rts




	;====================
	; draw laser
	;====================

draw_laser:

	ldx	#0
draw_laser_loop:
	lda	laser_out,X
	beq	done_draw_laser

	txa
	pha				; save X on stack

	lda	#$10
	sta	hlin_color_smc+1

	lda	#$0f
	sta	hlin_mask_smc+1

	ldy	laser_y,X

	sec
	lda	laser_end,X
	sbc	laser_start,X
	sta	LASER_TEMP

	lda	laser_start,X

	ldx	LASER_TEMP

	jsr	hlin

	pla				; restore X from stack
	tax

done_draw_laser:
	inx
	cpx	#MAX_LASERS
	bne	draw_laser_loop

	rts



	;===================
	; move laser
	;===================
move_laser:
	ldx	#0

move_laser_loop:
	lda	laser_out,X
	beq	done_move_laser

	; slow down laser
	lda	laser_count,X
	and	#$3
	bne	no_move_laser

	lda	laser_direction,X
	bne	move_laser_right

move_laser_left:

	lda	laser_count,X
	cmp	#4
	bcc	still_starting_left
	cmp	#8
	bcc	still_shooting_left

continue_shooting_left:
still_shooting_left:

	lda	laser_end,X
	sec
	sbc	#10
	sta	laser_end,X

still_starting_left:

	lda	laser_start,X
	sec
	sbc	#10
	sta	laser_start,X

laser_edge_detect_left:

	lda	laser_end,X
	cmp	LEFT_SHOOT_LIMIT
	bmi	disable_laser_left

	lda	laser_start,X
	cmp	LEFT_SHOOT_LIMIT
	bpl	no_move_laser

	lda	LEFT_SHOOT_LIMIT
	sta	laser_start,X

	jmp	no_move_laser


move_laser_right:

	lda	laser_count,X
	cmp	#4
	bcc	still_starting_right
	cmp	#8
	bcc	still_shooting_right

continue_shooting_right:
	lda	laser_start,X
	clc
	adc	#10
	sta	laser_start,X

still_shooting_right:
	lda	laser_end,X
	clc
	adc	#10
	sta	laser_end,X

still_starting_right:

laser_edge_detect_right:

	; detect if totally off screen
	lda	laser_start,X
	cmp	RIGHT_SHOOT_LIMIT
	bcs	disable_laser_right

	lda	laser_end,X
	cmp	RIGHT_SHOOT_LIMIT
	bcc	no_move_laser

	lda	RIGHT_SHOOT_LIMIT
	sta	laser_end,X

no_move_laser:
	inc	laser_count,X

done_move_laser:
	inx
	cpx	#MAX_LASERS
	bne	move_laser_loop

	rts

	;===================
	; hit something, left
	;===================
disable_laser_left:
	lda	LEFT_SHOOT_TARGET
	jmp	hit_something_common

	;====================
	; hit something, right
	;====================
disable_laser_right:

	lda	RIGHT_SHOOT_TARGET


	;======================
	; hit something, common
	;======================
hit_something_common:
	pha

	; disable laser
	lda	#0
	sta	laser_out,X

	pla

	tay
	and	#$f0

	cmp	#TARGET_ALIEN
	beq	laser_hit_alien

	cmp	#TARGET_FRIEND
	beq	laser_hit_friend

	cmp	#TARGET_PHYSICIST
	beq	laser_hit_physicist

	; FIXME: reduce shields if hit them?

	jmp	done_hit_something

laser_hit_alien:

	tya
	and	#$f
	tay

        lda	#A_DISINTEGRATING
        sta	alien_state,Y

        lda	#0
        sta	alien_gait,Y

	jmp	done_hit_something

laser_hit_friend:

	lda	#F_DISINTEGRATING
	sta	friend_state

	lda	#FAI_DISINTEGRATING
	sta	friend_ai_state

	lda	#0
	sta	friend_gait

	jmp	done_hit_something

laser_hit_physicist:

        lda	#P_DISINTEGRATING
        sta	PHYSICIST_STATE

        lda	#0
        sta	GAIT

done_hit_something:
	jmp	done_move_laser
;	rts




