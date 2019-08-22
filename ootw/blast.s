; Handle blast

blast0_out:		.byte $0
blast0_start:		.byte $0
blast0_end:		.byte $0
blast0_y:		.byte $0
blast0_direction:	.byte $0
blast0_count:		.byte $0

	;=========================
	; fire blast
	;=========================

fire_blast:

	lda	blast0_out
	bne	done_fire_blast

	lda	PHYSICIST_X
	sta	COLLISION_X
	lda	PHYSICIST_Y
	sta	COLLISION_Y

	; activate blast slot

	inc	blast0_out

	; reduce gun charge
	; FIXME: don't shoot if too low
	lda	GUN_CHARGE
	sec
	sbc	#10
	sta	GUN_CHARGE

	; reset blast count

	lda	#0
	sta	blast0_count

	; set y

	lda	PHYSICIST_Y
	clc
	adc	#4

	ldx	PHYSICIST_STATE
	cpx	#P_CROUCH_SHOOTING
	bne	blast_ypos_done

blast_crouch:
	clc
	adc	#4
blast_ypos_done:

	sta	blast0_y

	; set direction

	lda	DIRECTION
	sta	blast0_direction

	beq	blast_left
	bne	blast_right

	; set x

blast_left:
	jsr	calc_gun_left_collision

	ldx	PHYSICIST_X
	dex
	stx	blast0_end

	txa
	sec
	sbc	#10
	sta	blast0_start

	jmp	done_fire_blast

blast_right:
	jsr	calc_gun_right_collision

	lda	PHYSICIST_X
	clc
	adc	#5
	sta	blast0_start

	clc
	adc	#10
	sta	blast0_end

done_fire_blast:
	rts


	;====================
	; draw blast
	;====================

draw_blast:

	lda	blast0_out
	beq	done_draw_blast

	lda	#$fe
	sta	hlin_color_smc+1

	lda	#$00
	sta	hlin_mask_smc+1

	ldy	blast0_y

	sec
	lda	blast0_end
	sbc	blast0_start
	tax

	lda	blast0_start

	jsr	hlin

	ldy	blast0_y
	sty	YPOS

	lda	blast0_direction
	beq	blast_going_left
	ldy	blast0_end
	jmp	blast_going_done
blast_going_left:
	ldy	blast0_start
blast_going_done:
	sty	XPOS

	lda	#<gun_charge_sprite8
	sta	INL
	lda	#>gun_charge_sprite8
	sta	INH

	jsr	put_sprite_crop

done_draw_blast:

	rts



	;===================
	; move blast
	;===================
move_blast:
	lda	blast0_out
	beq	done_move_blast

	; slow down blast
	lda	blast0_count
	and	#$3
	bne	no_move_blast

	lda	blast0_direction
	bne	move_blast_right

move_blast_left:

	lda	blast0_count
	cmp	#4
	bcc	still_starting_blast_left
	cmp	#8
	bcc	still_shooting_blast_left

continue_shooting_blast_left:
still_shooting_blast_left:

	lda	blast0_end
	sec
	sbc	#10
	sta	blast0_end

still_starting_blast_left:

	lda	blast0_start
	sec
	sbc	#10
	sta	blast0_start

blast_edge_detect_left:

	lda	blast0_end
	cmp	LEFT_SHOOT_LIMIT
	bmi	disable_blast_left

	lda	blast0_start
	cmp	LEFT_SHOOT_LIMIT
	bpl	no_move_blast

	lda	LEFT_SHOOT_LIMIT
	sta	blast0_start

	jmp	no_move_blast


move_blast_right:

	lda	blast0_count
	cmp	#4
	bcc	still_starting_blast_right
	cmp	#8
	bcc	still_shooting_blast_right

continue_shooting_blast_right:
	lda	blast0_start
	clc
	adc	#10
	sta	blast0_start

still_shooting_blast_right:
	lda	blast0_end
	clc
	adc	#10
	sta	blast0_end

still_starting_blast_right:

blast_edge_detect_right:

	; detect if totally off screen
	lda	blast0_start
	cmp	RIGHT_SHOOT_LIMIT
	bcs	disable_blast_right

	lda	blast0_end
	cmp	RIGHT_SHOOT_LIMIT
	bcc	no_move_blast

	lda	RIGHT_SHOOT_LIMIT
	sta	blast0_end

no_move_blast:
	inc	blast0_count

done_move_blast:

	rts

	;=====================
	; hit something, left
	;=====================
disable_blast_left:
	lda	LEFT_SHOOT_TARGET
	jmp	blast_something_common

	;==================
	; hit something, right
	;==================
disable_blast_right:

	lda	RIGHT_SHOOT_TARGET


	;=========================
	; blash something, common
	;=========================
blast_something_common:

	ldx	#0
	stx	blast0_out
	tax
	and	#$f0

	cmp	#TARGET_DOOR
	beq	blast_door

	cmp	#TARGET_ALIEN
	beq	blast_alien

	cmp	#TARGET_FRIEND
	beq	blast_friend

	cmp	#TARGET_SHIELD
	beq	blast_shield

	jmp	done_blasting_common


blast_alien:
	txa
	and	#$f
	tax

	lda	#A_DISINTEGRATING
	sta	alien_state,X

	lda	#0
	sta	alien_gait,X

	jmp	done_blasting_common

blast_friend:

	lda	#F_DISINTEGRATING
	sta	friend_state

	lda	#FAI_DISINTEGRATING
	sta	friend_ai_state

	lda	#0
	sta	friend_gait

	jmp	done_blasting_common

blast_shield:

	; FIXME: need animation for this

	txa
	and	#$f
	tax

	lda	#0
	sta	shield_out,X

	dec	SHIELD_OUT

	jmp	done_blasting_common

blast_door:

	; FIXME: change direction based on blast
	txa
	and	#$f
	tay

	lda	#DOOR_STATUS_EXPLODING1
	sta	(DOOR_STATUS),Y

	jsr	recalc_walk_collision


done_blasting_common:

	rts


