
; FIXME: merge a lot of the target code

; Handle laser

; should handle multiple at once?

; when pressed, find empty slot?
; initially 10 wide, from gun to right or left
; expand to 20 wide
; stop when encounter door, enemy, or edge of screen
; should bounds check carefully

; should handle shooting while crouching

laser0_out:		.byte $0
laser0_start:		.byte $0
laser0_end:		.byte $0
laser0_y:		.byte $0
laser0_direction:	.byte $0
laser0_count:		.byte $0

	;=========================
	; fire laser
	;=========================

fire_laser:

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

	lda	laser0_out
	beq	done_draw_laser

	lda	#$10
	sta	hlin_color_smc+1

	lda	#$0f
	sta	hlin_mask_smc+1

	ldy	laser0_y

	sec
	lda	laser0_end
	sbc	laser0_start
	tax

	lda	laser0_start

	jsr	hlin

done_draw_laser:

	rts



	;===================
	; move laser
	;===================
move_laser:
	lda	laser0_out
	beq	done_move_laser

	; slow down laser
	lda	laser0_count
	and	#$3
	bne	no_move_laser

	lda	laser0_direction
	bne	move_laser_right

move_laser_left:

	lda	laser0_count
	cmp	#4
	bcc	still_starting_left
	cmp	#8
	bcc	still_shooting_left

continue_shooting_left:
still_shooting_left:

	lda	laser0_end
	sec
	sbc	#10
	sta	laser0_end

still_starting_left:

	lda	laser0_start
	sec
	sbc	#10
	sta	laser0_start

laser_edge_detect_left:

	lda	laser0_end
	cmp	LEFT_SHOOT_LIMIT
	bmi	disable_laser_left

	lda	laser0_start
	cmp	LEFT_SHOOT_LIMIT
	bpl	no_move_laser

	lda	LEFT_SHOOT_LIMIT
	sta	laser0_start

	jmp	no_move_laser


move_laser_right:

	lda	laser0_count
	cmp	#4
	bcc	still_starting_right
	cmp	#8
	bcc	still_shooting_right

continue_shooting_right:
	lda	laser0_start
	clc
	adc	#10
	sta	laser0_start

still_shooting_right:
	lda	laser0_end
	clc
	adc	#10
	sta	laser0_end

still_starting_right:

laser_edge_detect_right:

	; detect if totally off screen
	lda	laser0_start
	cmp	RIGHT_SHOOT_LIMIT
	bcs	disable_laser_right

	lda	laser0_end
	cmp	RIGHT_SHOOT_LIMIT
	bcc	no_move_laser

	lda	RIGHT_SHOOT_LIMIT
	sta	laser0_end

no_move_laser:
	inc	laser0_count

done_move_laser:

	rts

	;===================
	; hit somthing, left
	;===================
disable_laser_left:
	lda	#0
	sta	laser0_out

	lda	LEFT_SHOOT_TARGET
	beq	done_disable_laser_left

	tax
	and	#$f0

	cmp	#TARGET_ALIEN
	beq	laser_alien_left

	jmp	done_disable_laser_left

laser_alien_left:
	txa
	and	#$f
	tax

        lda	#A_DISINTEGRATING
        sta	alien_state,X

        lda	#0
        sta	alien_gait,X

	jmp	done_lasering_left

done_lasering_left:
done_disable_laser_left:

	rts


	;====================
	; hit somthing, right
	;====================
disable_laser_right:
	lda	#0
	sta	laser0_out

	lda	RIGHT_SHOOT_TARGET
	beq	done_disable_laser_right

	tax
	and	#$f0

	cmp	#TARGET_ALIEN
	beq	laser_alien_right

	jmp	done_disable_laser_right

laser_alien_right:
	txa
	and	#$f
	tax

        lda	#A_DISINTEGRATING
        sta	alien_state,X

        lda	#0
        sta	alien_gait,X

	jmp	done_lasering_right

done_lasering_right:
done_disable_laser_right:

	rts


