
draw_fire:
	lda	FRAMEL
	and	#$18
	lsr
	lsr
	tay
	lda	fire_sprites,Y
	sta	INL
	lda	fire_sprites+1,Y
	sta	INH

	lda	#16
	sta	XPOS
	lda	#18
	sta	YPOS

	jsr	put_sprite_crop

	rts





fire_sprites:
	.word fire1_sprite
	.word fire2_sprite
	.word fire3_sprite
	.word fire2_sprite

fire1_sprite:
	.byte 2,4
	.byte $dA,$AA
	.byte $dd,$9A
	.byte $99,$dd
	.byte $dd,$dd

fire2_sprite:
	.byte 2,4
	.byte $AA,$AA
	.byte $dd,$dd
	.byte $9d,$99
	.byte $dd,$dd

fire3_sprite:
	.byte 2,4
	.byte $AA,$aa
	.byte $9A,$dd
	.byte $d9,$9d
	.byte $dd,$dd



draw_wall:

	lda	#<wall_sprite
	sta	INL
	lda	#>wall_sprite
	sta	INH

	lda	#18
	sta	XPOS
	lda	#22
	sta	YPOS

	jsr	put_sprite_crop

	rts

wall_sprite:
	.byte	9,6
	.byte	$AA,$AA,$8A,$0A,$5A,$AA,$AA,$AA,$AA
	.byte	$AA,$8A,$50,$05,$60,$AA,$AA,$6A,$6A
	.byte	$58,$08,$55,$60,$60,$AA,$AA,$66,$60
	.byte	$06,$66,$26,$00,$66,$AA,$AA,$66,$00
	.byte	$06,$05,$65,$60,$50,$5A,$5A,$66,$00
	.byte	$00,$60,$00,$60,$06,$60,$06,$06,$06

