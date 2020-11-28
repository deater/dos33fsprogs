move_duke:
	rts


	; draw duke

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

