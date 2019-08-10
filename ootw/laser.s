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


	;=========================
	; fire laser
	;=========================

fire_laser:

	lda	laser0_out
	bne	done_fire_laser

	inc	laser0_out

	; set y

	lda	PHYSICIST_Y
	clc
	adc	#4
	sta	laser0_y

	lda	DIRECTION
	sta	laser0_direction

	beq	laser_left
	bne	laser_right

	; set x


laser_left:

	ldx	PHYSICIST_X
	dex
	stx	laser0_end
	lda	#0
	sta	laser0_start

	jmp	done_fire_laser

laser_right:

	lda	PHYSICIST_X
	clc
	adc	#5
	sta	laser0_start

	sec
	lda	#39
	sbc	TEMP
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
	ldx	laser0_end
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

	lda	laser0_start
	clc
	adc	#10
	sta	laser0_start
	cmp	#39
	bcs	disable_laser

	lda	laser0_start
	clc
	adc	#20
	cmp	#40
	bcc	done_laser_len		; blt

	lda	#39

done_laser_len:
	sta	laser0_end

done_move_laser:

	rts

disable_laser:
	lda	#0
	sta	laser0_out
	rts

