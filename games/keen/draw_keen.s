
	;=========================
	; draw keen
	;=========================
draw_keen:

	sec
	lda	KEEN_TILEX
	sbc	TILEMAP_X
	asl
	clc
	adc	KEEN_X
	sta	XPOS

	sec
	lda	KEEN_TILEY
	sbc	TILEMAP_Y
	asl
	asl
	clc
	adc	KEEN_Y
	sta	YPOS

	lda	KEEN_DIRECTION
	bmi	keen_facing_left

	;=========================
	; facing right

keen_facing_right:

check_falling_right:
	lda	KEEN_FALLING
	beq	check_jumping_right
draw_falling_right:
	ldx	#<keen_sprite_falling_right
	lda	#>keen_sprite_falling_right
	jmp	actually_draw_keen

check_jumping_right:
	lda	KEEN_JUMPING
	beq	check_shooting_right
draw_jumping_right:
	ldx	#<keen_sprite_jumping_right
	lda	#>keen_sprite_jumping_right
	jmp	actually_draw_keen

check_shooting_right:
	lda	KEEN_SHOOTING
	beq	check_walking_right
draw_shooting_right:
	ldx	#<keen_sprite_shooting_right
	lda	#>keen_sprite_shooting_right
	dec	KEEN_SHOOTING
	jmp	actually_draw_keen

check_walking_right:
	lda	KEEN_WALKING
	beq	draw_standing_right
draw_walking_right:
	lda	FRAMEL
	and	#$02
	beq	draw_standing_right

	ldx	#<keen_sprite_walking_right
	lda	#>keen_sprite_walking_right
	jmp	actually_draw_keen

draw_standing_right:
	ldx	#<keen_sprite_stand_right
	lda	#>keen_sprite_stand_right
	jmp	actually_draw_keen


	;==================
	; facing left
keen_facing_left:

check_falling_left:
	lda	KEEN_FALLING
	beq	check_jumping_left
draw_falling_left:
	ldx	#<keen_sprite_falling_left
	lda	#>keen_sprite_falling_left
	jmp	actually_draw_keen

check_jumping_left:
	lda	KEEN_JUMPING
	beq	check_shooting_left
draw_jumping_left:
	ldx	#<keen_sprite_jumping_left
	lda	#>keen_sprite_jumping_left
	jmp	actually_draw_keen

check_shooting_left:
	lda	KEEN_SHOOTING
	beq	check_walking_left
draw_shooting_left:
	ldx	#<keen_sprite_shooting_left
	lda	#>keen_sprite_shooting_left
	dec	KEEN_SHOOTING
	jmp	actually_draw_keen

check_walking_left:
	lda	KEEN_WALKING
	beq	draw_standing_left
draw_walking_left:
	lda	FRAMEL
	and	#$02
	beq	draw_standing_left

	ldx	#<keen_sprite_walking_left
	lda	#>keen_sprite_walking_left
	jmp	actually_draw_keen

draw_standing_left:
	ldx	#<keen_sprite_stand_left
	lda	#>keen_sprite_stand_left
	jmp	actually_draw_keen


	;====================
	; actually draw

actually_draw_keen:
	stx	INL
	sta	INH
	jsr	put_sprite_crop

	rts
