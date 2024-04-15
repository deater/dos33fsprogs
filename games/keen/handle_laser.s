	; draw/move laser

	; o/~ carrying a laser, down the road that I must travel o/~
	; o/~ carrying a laser, in the darkness of the night o/~

	;====================
	; move laser
	;====================
move_laser:
	lda	LASER_OUT
	beq	done_move_laser


	lda	LASER_TILEX
	clc
	adc	LASER_DIRECTION
	sta	LASER_TILEX

laser_check_tiles:

	; collision detect with tiles

	clc
	lda	LASER_TILEY
	tay

	lda	tilemap_lookup_high,Y
	sta	INH
	lda	tilemap_lookup_low,Y
	clc
	adc	LASER_TILEX
	sta	INL


;        adc	#>big_tilemap
 ;       sta	INH
;	lda	LASER_TILEX
;	sta	INL

	ldy	#0
	lda	(INL),Y
	cmp	#ALLHARD_TILES
	bcs	destroy_laser


laser_check_enemies:
	; collision detect with enemies

;	jsr laser_enemies


	; detect if off screen
laser_check_right:
	sec
	lda	LASER_TILEX
	sbc	TILEMAP_X
	cmp	#21
	bcc	laser_check_left	; not_too_far_right
	bcs	destroy_laser

laser_check_left:
	sec
	lda	LASER_TILEX
	sbc	TILEMAP_X
	bpl	done_move_laser
;	bmi	destroy_laser

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

	sec
	lda	LASER_TILEY
	sbc	TILEMAP_Y
	asl
	asl
	sta	YPOS

	sec
	lda	LASER_TILEX
	sbc	TILEMAP_X
	asl
	sta	XPOS

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



	;=======================
	; laser enemies
	;=======================
	; see if laser hits any enemies

	; FIXME: this is broken

laser_enemies:

	ldy	#0				; which enemy
laser_enemies_loop:

	; see if out

	lda	enemy_data_out,Y
	beq	done_laser_enemy

	; get local tilemap co-ord
	sec
	lda	enemy_data_tilex,Y
	sbc	TILEMAP_X			; compare enemy size?

	sta	TILE_TEMP

	sec
	lda	enemy_data_tiley,Y
	sbc	TILEMAP_Y
	asl
	asl
	asl
	asl
	clc
	adc	TILE_TEMP

	cmp	LASER_TILE
	bne	done_laser_enemy

; hit something
hit_something:
	lda	#0
	sta	LASER_OUT
	sta	FRAMEL
;	sta	enemy_data+ENEMY_DATA_OUT,Y
	lda	#1
	sta	enemy_data_exploding,Y

;	jsr	enemy_noise

;	jsr	inc_score_by_10

	jmp	exit_laser_enemy

done_laser_enemy:
	iny
	cpy	#NUM_ENEMIES
	bne	laser_enemies_loop

exit_laser_enemy:
	rts


