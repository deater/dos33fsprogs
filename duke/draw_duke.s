
	;=========================
	; move duke
	;=========================
move_duke:

	jsr	check_falling

	jsr	handle_jumping

	lda	DUKE_WALKING
	beq	done_move_duke

	lda	DUKE_DIRECTION
	bmi	move_left

	lda	DUKE_X
	cmp	#22
	bcc	duke_walk_right

duke_scroll_right:

	inc	TILEMAP_X

	jsr	copy_tilemap_subset

	jmp	done_move_duke

duke_walk_right:
	inc	DUKE_X

	jmp	done_move_duke

move_left:

	lda	DUKE_X
	cmp	#14
	bcs	duke_walk_left

duke_scroll_left:

	dec	TILEMAP_X

	jsr	copy_tilemap_subset

	jmp	done_move_duke

duke_walk_left:
	dec	DUKE_X

	jmp	done_move_duke

done_move_duke:

	rts



	;=========================
	; duke collide
	;=========================
	; only check above head if jumping

duke_collide:

	rts


	;=========================
	; check_jumping
	;=========================
handle_jumping:

	lda	DUKE_JUMPING
	beq	done_handle_jumping

	dec	DUKE_Y
	dec	DUKE_Y
	dec	DUKE_JUMPING

done_handle_jumping:
	rts

	;=========================
	; check_falling
	;=========================
check_falling:

	lda	DUKE_JUMPING
	bne	done_check_falling

	; check below feet

	; block index below feet is (y+10)*16/4 + (x/2) + 1

	; if 18,18 -> 28*16/4 = 112 + 9 = 121 = 7R9


	lda	DUKE_Y
	clc
	adc	#10
	asl
	asl
	asl

	clc
	adc	DUKE_X
	lsr			; have location of head

;	clc
;	adc	#1		; point under feet

	tax
	lda	TILEMAP,X

	; if tile# < 32 then we fall
	cmp	#32
	bcs	feet_on_ground		; bge

	;=======================
	; falling

	; scroll but only if Y=18

	lda	DUKE_Y
	cmp	#18
	bne	scroll_fall

	inc	DUKE_Y
	inc	DUKE_Y
	jmp	done_check_falling


scroll_fall:
	inc	TILEMAP_Y

	jsr	copy_tilemap_subset
	jmp	done_check_falling

feet_on_ground:

	; check to see if Y still hi, if so scroll back down

	lda	DUKE_Y
	cmp	#18
	beq	done_check_falling

	inc	DUKE_Y
	inc	DUKE_Y
	dec	TILEMAP_Y		; share w above?
	jsr	copy_tilemap_subset

done_check_falling:
	rts




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

	lda	#<duke_sprite_stand_right
	sta	INL
	lda	#>duke_sprite_stand_right
	jmp	actually_draw_duke
duke_facing_left:

	lda	#<duke_sprite_stand_left
	sta	INL
	lda	#>duke_sprite_stand_left

actually_draw_duke:
	sta	INH
	jsr	put_sprite_crop

	rts

duke_sprite_stand_right:
	.byte 4,5
	.byte $AA,$dA,$dA,$AA
	.byte $AA,$dd,$bb,$AA
	.byte $AA,$b3,$7A,$7A
	.byte $AA,$66,$6b,$AA
	.byte $AA,$56,$65,$AA

duke_sprite_stand_left:
	.byte 4,5
	.byte $AA,$dA,$dA,$AA
	.byte $AA,$bb,$dd,$AA
	.byte $7A,$7A,$b3,$AA
	.byte $AA,$6b,$66,$AA
	.byte $AA,$65,$56,$AA

