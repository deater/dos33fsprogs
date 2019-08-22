
; Handle alien laser

; uses laser1 slot

; should handle multiple at once?

;laser1_out:		.byte $0
;laser1_start:		.byte $0
;laser1_end:		.byte $0
;laser1_y:		.byte $0
;laser1_direction:	.byte $0
;laser1_count:		.byte $0

	;=========================
	; fire alien laser
	;=========================
	; which alien in X

fire_alien_laser:

	lda	laser1_out
	bne	done_fire_alien_laser

	lda	alien_x,X
	sta	COLLISION_X
	lda	alien_y,X
	sta	COLLISION_Y

	; activate laser slot

	inc	laser1_out

	; reset count

	lda	#0
	sta	laser1_count

	; set y

	; assume for now no crouching

	lda	alien_y,X
	clc
	adc	#4
	sta	laser1_y

	; set direction

	lda	alien_direction,X
	sta	laser1_direction

	beq	alien_laser_left
	bne	alien_laser_right

	; set x

alien_laser_left:
	stx	LASER_TEMP

	jsr	calc_gun_left_collision

	ldx	LASER_TEMP

	lda	alien_x,X
	sec
	sbc	#2
	sta	laser1_end

	sec
	sbc	#10
	sta	laser1_start

	jmp	done_fire_alien_laser

alien_laser_right:

	stx	LASER_TEMP

	jsr	calc_gun_right_collision

	ldx	LASER_TEMP

	lda	alien_x,X
	clc
	adc	#5
	sta	laser1_start

	clc
	adc	#10
	sta	laser1_end

done_fire_alien_laser:
	rts


