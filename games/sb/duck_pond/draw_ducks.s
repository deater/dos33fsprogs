

	;====================
	; draw duck1
	;====================
draw_duck1:

	lda	D1_XPOS
	sta	XPOS
	lda	D1_YPOS
	sta	YPOS

	lda	D1_STATE
	beq	done_draw_duck1
	bmi	duck1_draw_right

duck1_draw_left:
	lda	#<d1_left1_mask
	sta	MASKL
	lda	#>d1_left1_mask
	sta	MASKH

	lda	#<d1_left1_sprite
	sta	INL
	lda	#>d1_left1_sprite
	jmp	do_draw_duck1

duck1_draw_right:
	lda	#<d1_right1_mask
	sta	MASKL
	lda	#>d1_right1_mask
	sta	MASKH

	lda	#<d1_right1_sprite
	sta	INL
	lda	#>d1_right1_sprite

do_draw_duck1:
	sta	INH
	jsr	gr_put_sprite_mask

done_draw_duck1:
	rts





	;====================
	; draw duck2
	;====================
draw_duck2:

	lda	D2_XPOS
	sta	XPOS
	lda	D2_YPOS
	sta	YPOS

	lda	D2_STATE
	beq	done_draw_duck2
	bmi	duck2_draw_right

duck2_draw_left:
	lda	#<d2_left1_mask
	sta	MASKL
	lda	#>d2_left1_mask
	sta	MASKH

	lda	#<d2_left1_sprite
	sta	INL
	lda	#>d2_left1_sprite
	jmp	do_draw_duck2

duck2_draw_right:
	lda	#<d2_right1_mask
	sta	MASKL
	lda	#>d2_right1_mask
	sta	MASKH

	lda	#<d2_right1_sprite
	sta	INL
	lda	#>d2_right1_sprite

do_draw_duck2:
	sta	INH
	jsr	gr_put_sprite_mask

done_draw_duck2:
	rts

