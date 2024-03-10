	; draw/move laser

	; o/~ carrying a laser, down the road that I must travel o/~
	; o/~ carrying a laser, in the darkness of the night o/~

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

laser_check_tiles:
	; collision detect with tiles

	; laser location is roughly
        ; (y/4)*16 + (x/2) - 2
	lda	LASER_Y
	lsr
	lsr
	asl
	asl
	asl
	asl
	sta	LASER_TILE
	lda	LASER_X
	lsr
	clc
	adc	LASER_TILE
	sec
	sbc	#2
	sta	LASER_TILE

	ldx	LASER_TILE
	lda	TILEMAP,X
	cmp	#HARD_TILES
	bcs	destroy_laser


laser_check_enemies:
	; collision detect with enemies

	jsr laser_enemies


	; detect if off screen
laser_check_right:
	lda	LASER_X
	cmp	#31
	bcc	laser_check_left	; not_too_far_right
	bcs	destroy_laser

laser_check_left:
	cmp	#6
	bcs	done_move_laser
	bcc	destroy_laser

destroy_laser:
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

