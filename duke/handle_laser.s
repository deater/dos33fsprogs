	; draw/move laser


	;====================
	; move laser
	;====================
move_laser:
	lda	LASER_OUT
	beq	done_move_laser

	lda	LASER_X
	clc
	adc	LASER_DIRECTION
	sta	LASER_X

	cmp	#31
	bcc	not_too_far_right
	lda	#0
	sta	LASER_OUT
	beq	done_move_laser

not_too_far_right:
	cmp	#6
	bcs	done_move_laser
	lda	#0
	sta	LASER_OUT

done_move_laser:
	rts

	;====================
	; draw laser
	;====================

draw_laser:

	lda	LASER_OUT
	beq	done_draw_laser

	lda	LASER_X
	sta	XPOS
	lda	LASER_Y
	sta	YPOS

;	lda	LASER_DIRECTION


	lda	#<laser_sideways_sprite
	sta	INL
	lda	#>laser_sideways_sprite
	sta	INH
	jsr	put_sprite_crop

done_draw_laser:
	rts

laser_sideways_sprite:
	.byte 4,1
;	.byte $3A,$cA,$3A,$cA
	.byte $A3,$Ac,$A3,$Ac

