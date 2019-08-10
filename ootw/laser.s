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
laser0_length:		.byte $0
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

	lda	PHYSICIST_X
	sec
	sbc	#10
	sta	laser0_start

	lda	#10
	sta	laser0_length

	jmp	done_fire_laser

laser_right:

	lda	PHYSICIST_X
	clc
	adc	#5
	sta	laser0_start

	lda	#10
	sta	laser0_length

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
	ldx	laser0_length
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
	and	#$fe
	beq	still_shooting_left

continue_shooting_left:
	lda	laser0_start
	sec
	sbc	#20
	sta	laser0_start

still_shooting_left:
	lda	#20
	sta	laser0_length

laser_edge_detect_left:

	lda	laser0_start
	clc
	adc	laser0_length
	bmi	disable_laser

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
	lda	#20
	sta	laser0_length

still_starting_right:

laser_edge_detect_right:

	; detect if totally off screen
	lda	laser0_start
	cmp	#40
	bcs	disable_laser

	clc
	adc	laser0_length
	cmp	#40
	bcc	no_move_laser

	lda	#39
	sec
	sbc	laser0_start
	sta	laser0_length

no_move_laser:
	inc	laser0_count

done_move_laser:

	rts

disable_laser:
	lda	#0
	sta	laser0_out
	rts

