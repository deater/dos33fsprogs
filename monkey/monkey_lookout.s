
	; if 28<x<35 and y>=24 and direction==down
	;	goto MONKEY_POSTER
	;	at location 4,20
	; if 28<x<35 and y<10 and direction==down
	;	goto MONKEY_MAP
	;	at location 20,20
lookout_check_exit:
	lda	GUYBRUSH_X
	cmp	#28
	bcc	lookout_no_exit
	cmp	#35
	bcs	lookout_no_exit

lookout_check_stairs:
	lda	GUYBRUSH_Y
	cmp	#24
	bcc	lookout_check_arch
	lda	GUYBRUSH_DIRECTION
	cmp	#DIR_DOWN
	bne	lookout_no_exit

	lda	#MONKEY_POSTER
	sta	LOCATION
	lda	#4
	sta	GUYBRUSH_X
	sta	DESTINATION_X
	lda	#20
	sta	GUYBRUSH_Y
	sta	DESTINATION_Y
	jsr	change_location
	jmp	lookout_no_exit

lookout_check_arch:

	lda	GUYBRUSH_Y
	cmp	#12
	bcs	lookout_no_exit
	lda	GUYBRUSH_DIRECTION
	cmp	#DIR_UP
	bne	lookout_no_exit

	lda	#MONKEY_MAP
	sta	LOCATION
	lda	#4
	sta	GUYBRUSH_X
	sta	DESTINATION_X
	lda	#20
	sta	GUYBRUSH_Y
	sta	DESTINATION_Y
	jsr	change_location
	jmp	lookout_no_exit

lookout_no_exit:
	rts

lookout_adjust_destination:

ld_check_x:
	lda	DESTINATION_X
	cmp	#19
	bcc	ld_x_too_small
	cmp	#34
	bcs	ld_x_too_big
	jmp	ld_check_y

ld_x_too_big:
	lda	#34
	sta	DESTINATION_X
	bne	ld_check_y

ld_x_too_small:
	lda	#18
	sta	DESTINATION_X

ld_check_y:
	; if x < 28, Y must be between 16 and 18
	; if x < 35, Y must be between  8 and 28

	lda	DESTINATION_X
	cmp	#28
	bcc	ld_narrow_y

ld_wide_y:
;	lda	DESTINATON_Y
	jmp	done_ld_adjust

ld_narrow_y:
	lda	DESTINATION_Y
	cmp	#16
	bcc	ld_y_too_small

	rts

ld_y_too_small:
	lda	#16
	sta	DESTINATION_Y

done_ld_adjust:
	rts




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

