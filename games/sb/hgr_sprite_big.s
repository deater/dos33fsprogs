	;===========================================
	; hgr draw sprite (only at 7-bit boundaries)
	;===========================================
	; can handle sprites bigger than a 256 byte page

	; SPRITE in INL/INH
	; Location at SPRITE_X SPRITE_Y

	; xsize, ysize  in first two bytes

	; sprite AT INL/INH


	; orange = color5  1 101 0101   1 010 1010

hgr_draw_sprite:
	lda	SPRITE_X
	ror
	bcs	hgr_draw_sprite_odd

hgr_draw_sprite_even:
	ldy	#0
	lda	(INL),Y			; load xsize
	clc
	adc	SPRITE_X
	sta	sprite_width_end_smc+1	; self modify for end of line

	iny				; load ysize
	lda	(INL),Y
	sta	sprite_ysize_smc+1	; self modify

	; point smc to sprite
	lda	INL			; 16-bit add
	sta	sprite_smc1+1
	lda	INH
	sta	sprite_smc1+2


	ldx	#0			; X is pointer offset
	stx	CURRENT_ROW		; actual row

	ldx	#2

hgr_sprite_yloop:

	lda	CURRENT_ROW		; row

	clc
	adc	SPRITE_Y		; add in cursor_y

	; calc GBASL/GBASH

	tay				; get output ROW into GBASL/H
	lda	hposn_low,Y
	sta	GBASL
	lda	hposn_high,Y

	; eor	#$00 draws on page2
	; eor	#$60 draws on page1
;hgr_sprite_page_smc:
;	eor	#$00
	clc
	adc	DRAW_PAGE
	sta	GBASH
;	eor	#$60
;	sta	INH

	ldy	SPRITE_X

sprite_inner_loop:


sprite_smc1:
        lda	$f000,X			; load sprite data
	sta	(GBASL),Y		; store to screen

	inx				; increment sprite offset

	; if > 1 page
	bne	sprite_no_page_cross
	inc	sprite_smc1+2

sprite_no_page_cross:
	iny				; increment output position


sprite_width_end_smc:
	cpy	#6			; see if reached end of row
	bne	sprite_inner_loop	; if not, loop


	inc	CURRENT_ROW		; row
	lda	CURRENT_ROW		; row

sprite_ysize_smc:
	cmp	#31			; see if at end
	bne	hgr_sprite_yloop	; if not, loop

	rts



hgr_draw_sprite_odd:
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

