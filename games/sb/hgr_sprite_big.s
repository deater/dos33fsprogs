	;===========================================
	; hgr draw sprite (only at 7-bit boundaries)
	;===========================================
	; can handle sprites bigger than a 256 byte page

	; SPRITE in INL/INH
	; Location at SPRITE_X SPRITE_Y

	; xsize, ysize  in first two bytes

	; sprite AT INL/INH


	; orange = color5  1 101 0101   1 010 1010

hgr_draw_sprite_big:
	lda	SPRITE_X
	ror
	bcs	hgr_draw_sprite_big_odd

hgr_draw_sprite_big_even:
	ldy	#0
	lda	(INL),Y			; load xsize
	clc
	adc	SPRITE_X
	sta	big_sprite_width_end_smc+1	; self modify for end of line

	iny				; load ysize
	lda	(INL),Y
	sta	big_sprite_ysize_smc+1	; self modify

	; point smc to sprite
	lda	INL			; 16-bit add
	sta	big_sprite_smc1+1
	lda	INH
	sta	big_sprite_smc1+2


	ldx	#0			; X is pointer offset
	stx	CURRENT_ROW		; actual row

	ldx	#2

hgr_big_sprite_yloop:

	lda	CURRENT_ROW		; row

	clc
	adc	SPRITE_Y		; add in cursor_y

	; calc GBASL/GBASH

	tay				; get output ROW into GBASL/H
	lda	hposn_low,Y
	sta	GBASL
	lda	hposn_high,Y

	clc
	adc	DRAW_PAGE
	sta	GBASH

	ldy	SPRITE_X

big_sprite_inner_loop:


big_sprite_smc1:
        lda	$f000,X			; load sprite data
	sta	(GBASL),Y		; store to screen

	inx				; increment sprite offset

	; if > 1 page
	bne	big_sprite_no_page_cross
	inc	big_sprite_smc1+2

big_sprite_no_page_cross:
	iny				; increment output position


big_sprite_width_end_smc:
	cpy	#6			; see if reached end of row
	bne	big_sprite_inner_loop	; if not, loop


	inc	CURRENT_ROW		; row
	lda	CURRENT_ROW		; row

big_sprite_ysize_smc:
	cmp	#31			; see if at end
	bne	hgr_big_sprite_yloop	; if not, loop

	rts



hgr_draw_sprite_big_odd:
	ldy	#0
	lda	(INL),Y			; load xsize
	clc
	adc	SPRITE_X
	sta	osprite_width_end_smc+1	; self modify for end of line

	iny				; load ysize
	lda	(INL),Y
	sta	osprite_ysize_smc+1	; self modify

	; point smc to sprite
	lda	INL			; 16-bit add
	sta	osprite_smc1+1
	lda	INH
	sta	osprite_smc1+2


	ldx	#0			; X is pointer offset
	stx	CURRENT_ROW		; actual row

	ldx	#2

ohgr_sprite_yloop:

	lda	CURRENT_ROW		; row

	clc
	adc	SPRITE_Y		; add in cursor_y

	; calc GBASL/GBASH

	tay				; get output ROW into GBASL/H
	lda	hposn_low,Y
	sta	GBASL
	lda	hposn_high,Y

	clc
	adc	DRAW_PAGE
	sta	GBASH

	ldy	SPRITE_X

	clc
	php				; store 0 carry on stack

osprite_inner_loop:


osprite_smc1:
        lda	$f000,X			; load sprite data

	plp				; restore carry from last
	rol				; rotate in carry
	asl				; one more time, bit6 in carry
	php				; save on stack
	sec				; assume blur/orange
	ror				; rotate it back down

	sta	(GBASL),Y		; store to screen

	inx				; increment sprite offset

	; if > 1 page
	bne	osprite_no_page_cross
	inc	osprite_smc1+2

osprite_no_page_cross:

	iny				; increment output position



osprite_width_end_smc:
	cpy	#6			; see if reached end of row
	bne	osprite_inner_loop	; if not, loop


	plp				; restore stack

	inc	CURRENT_ROW		; row
	lda	CURRENT_ROW		; row

osprite_ysize_smc:
	cmp	#31			; see if at end
	bne	ohgr_sprite_yloop	; if not, loop

	rts

