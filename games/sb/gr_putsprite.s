	;===============
	; gr_put_sprite
	;===============
	; Sprite to display in INL/INH
	; MASK (for transparency) on MASKL/MASH
	; Location is XPOS,YPOS
	; Note, only works if YPOS is multiple of two

	; trashes A,X,Y

gr_put_sprite:
	ldy	#0

	lda	(INL),Y			; xsize
	clc
	adc	XPOS
	sta	gps_xmax_smc+1		; store xmas (self-modify)

	iny								; 2

	lda	(INL),Y			; ysize
	asl				; mul by 2
	clc
	adc	YPOS
	sta	gps_ymax_smc+1

	iny

	tya
	tax

	lda	INL
	sta	gps_src_smc+1
	lda	INH
	sta	gps_src_smc+2

gr_put_sprite_loop:
	ldy	YPOS
	lda	gr_offsets,Y
	sta	OUTL
	lda	gr_offsets+1,Y
	clc
	adc	DRAW_PAGE
	sta	OUTH


	ldy	XPOS
gr_put_sprite_row:
	cpy	#40
	bcs	gr_put_sprite_dont_draw		; don't draw if out of bounds

gps_src_smc:
	lda	$f000,X
	sta	(OUTL),Y

gr_put_sprite_dont_draw:
	iny
	inx
gps_xmax_smc:
	cpy	#40
	bne	gr_put_sprite_row

	inc	YPOS
	inc	YPOS
	lda	YPOS
gps_ymax_smc:
	cmp	#40

	bne	gr_put_sprite_loop

gr_put_sprite_done:
	rts				; return			; 6
