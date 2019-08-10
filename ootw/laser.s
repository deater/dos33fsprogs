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
	sta	laser0_y

	; set direction

	lda	DIRECTION
	sta	laser0_direction

	beq	laser_left
	bne	laser_right

	; set x

laser_left:

	ldx	PHYSICIST_X
	dex
	stx	laser0_end

	txa
	sec
	sbc	#10
	sta	laser0_start

	jmp	done_fire_laser

laser_right:

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
	bmi	disable_laser

	lda	laser0_start
	bpl	no_move_laser

	lda	#0
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
	cmp	#40
	bcs	disable_laser

	lda	laser0_end
	cmp	#40
	bcc	no_move_laser

	lda	#39
	sta	laser0_end

no_move_laser:
	inc	laser0_count

done_move_laser:

	rts

disable_laser:
	lda	#0
	sta	laser0_out
	rts

