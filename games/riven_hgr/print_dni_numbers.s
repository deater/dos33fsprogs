	;========================
	; location at XPOS, YPOS ?

draw_full_dni_number:


	lda	NUMBER_HIGH
	beq	draw_only_low_dni_number

	; drawing high number

	jsr	draw_dni_number

	; adjust for right number
	lda	#14
	bne	draw_low_dni_number	; bra

draw_only_low_dni_number:

	lda	#7
draw_low_dni_number:
	clc
	adc	XPOS
	sta	XPOS

	lda	NUMBER_LOW



	;=====================
	; number in A

draw_dni_number:

	sta	DRAW_NUMBER

	; draw frame

	lda	#<frame_sprite
	sta	INL
	lda	#>frame_sprite
	sta	INH

	jsr	put_number_sprite

	; adjust to be inside frame

	inc	YPOS
	inc	XPOS
	inc	XPOS
	inc	XPOS

	; draw ones values

	lda	DRAW_NUMBER
	bne	regular_number

;	lda	LEADING_ZERO		; if 0 then regular
;	beq	regular_number

	; if all zeros, then draw special zero char

	lda	#<zero_sprite
	sta	INL
	lda	#>zero_sprite
	jmp	finally_draw


regular_number:
	and	#$f
	tax

	lda	ones_sprites_l,X
	sta	INL
	lda	ones_sprites_h,X
finally_draw:
	sta	INH

	jsr	put_number_sprite

	lda	DRAW_NUMBER
	lsr
	lsr
	lsr
	lsr
	tax

	lda	fives_sprite_l,X
	sta	INL
	lda	fives_sprite_h,X
	sta	INH

	jsr	put_number_sprite


	; restore

	dec	YPOS
	dec	XPOS
	dec	XPOS
	dec	XPOS

	rts



	;=====================

put_number_sprite:

	ldy	#0
	lda	(INL),Y
	sta	pns_xsize_smc+1
	iny
	lda	(INL),Y
	sta	pns_ysize_smc+1
	iny

	lda	#0
	sta	SPRITEY
pns_yloop:

	lda	SPRITEY
	clc
	adc	YPOS
	asl
	tax
	lda	gr_offsets,X
;	clc
	adc	XPOS
	sta	pns_out_smc+1

	lda	gr_offsets+1,X
;	clc
	adc	DRAW_PAGE
	sta	pns_out_smc+2

	lda	#0
	sta	SPRITEX
pns_xloop:

	ldx	#8			; rotate through 8 bits
	lda	(INL),Y
	sta	COLOR
pns_inner_loop:
	asl	COLOR
	bcc	pns_transparent
	lda	#$FF
pns_out_smc:
	sta	$400
pns_transparent:
	inc	pns_out_smc+1
	dex
	bne	pns_inner_loop

	iny

	inc	SPRITEX
	lda	SPRITEX
pns_xsize_smc:
	cmp	#3
	bne	pns_xloop

	inc	SPRITEY
pns_ysize_smc:
	cpy	#39
	bcc	pns_yloop	; blt

	rts

ones_sprites_l:
	.byte <empty_sprite,<one_sprite,<two_sprite,<three_sprite,<four_sprite
ones_sprites_h:
	.byte >empty_sprite,>one_sprite,>two_sprite,>three_sprite,>four_sprite

fives_sprite_l:
	.byte <empty_sprite,<five_sprite,<ten_sprite,<fifteen_sprite,<twenty_sprite
fives_sprite_h:
	.byte >empty_sprite,>five_sprite,>ten_sprite,>fifteen_sprite,>twenty_sprite


