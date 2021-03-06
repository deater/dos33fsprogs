
	;=========================
	; draw duke
	;=========================
draw_duke:

	lda	DUKE_X
	sta	XPOS
	lda	DUKE_Y
	sta	YPOS

	lda	DUKE_DIRECTION
	bmi	duke_facing_left

	;=========================
	; facing right

duke_facing_right:

check_falling_right:
	lda	DUKE_FALLING
	beq	check_jumping_right
draw_falling_right:
	ldx	#<duke_sprite_falling_right
	lda	#>duke_sprite_falling_right
	jmp	actually_draw_duke

check_jumping_right:
	lda	DUKE_JUMPING
	beq	check_shooting_right
draw_jumping_right:
	ldx	#<duke_sprite_jumping_right
	lda	#>duke_sprite_jumping_right
	jmp	actually_draw_duke

check_shooting_right:
	lda	DUKE_SHOOTING
	beq	check_walking_right
draw_shooting_right:
	ldx	#<duke_sprite_shooting_right
	lda	#>duke_sprite_shooting_right
	dec	DUKE_SHOOTING
	jmp	actually_draw_duke

check_walking_right:
	lda	DUKE_WALKING
	beq	draw_standing_right
draw_walking_right:
	lda	FRAMEL
	and	#$02
	beq	draw_standing_right

	ldx	#<duke_sprite_walking_right
	lda	#>duke_sprite_walking_right
	jmp	actually_draw_duke

draw_standing_right:
	ldx	#<duke_sprite_stand_right
	lda	#>duke_sprite_stand_right
	jmp	actually_draw_duke


	;==================
	; facing left
duke_facing_left:

check_falling_left:
	lda	DUKE_FALLING
	beq	check_jumping_left
draw_falling_left:
	ldx	#<duke_sprite_falling_left
	lda	#>duke_sprite_falling_left
	jmp	actually_draw_duke

check_jumping_left:
	lda	DUKE_JUMPING
	beq	check_shooting_left
draw_jumping_left:
	ldx	#<duke_sprite_jumping_left
	lda	#>duke_sprite_jumping_left
	jmp	actually_draw_duke

check_shooting_left:
	lda	DUKE_SHOOTING
	beq	check_walking_left
draw_shooting_left:
	ldx	#<duke_sprite_shooting_left
	lda	#>duke_sprite_shooting_left
	dec	DUKE_SHOOTING
	jmp	actually_draw_duke

check_walking_left:
	lda	DUKE_WALKING
	beq	draw_standing_left
draw_walking_left:
	lda	FRAMEL
	and	#$02
	beq	draw_standing_left

	ldx	#<duke_sprite_walking_left
	lda	#>duke_sprite_walking_left
	jmp	actually_draw_duke

draw_standing_left:
	ldx	#<duke_sprite_stand_left
	lda	#>duke_sprite_stand_left
	jmp	actually_draw_duke


	;====================
	; actually draw

actually_draw_duke:
	stx	INL
	sta	INH
	jsr	put_sprite_crop

	rts


