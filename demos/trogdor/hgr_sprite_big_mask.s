	;===========================================
	; hgr draw sprite (only at 14-bit boundaries)
	;===========================================
	; can handle sprites bigger than a 256 byte page

	; flames are 8x142 or so

	; SPRITE in INL/INH
	; MASK in MASKL/MASKH

	; Location at SPRITE_X SPRITE_Y

	; xsize, ysize  in first two bytes

hgr_draw_sprite_big_mask:
;	lda	SPRITE_X

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

	; point to mask
	lda	MASKL
	sta	big_sprite_mask_smc1+1
	lda	MASKH
	sta	big_sprite_mask_smc1+2

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


	lda	(GBASL),Y
big_sprite_mask_smc1:
	and	$f000,X

big_sprite_smc1:
	ora	$f000,X			; load sprite data

	sta	(GBASL),Y		; store to screen

	inx				; increment sprite offset

	; if > 1 page
	bne	big_sprite_no_page_cross
	inc	big_sprite_smc1+2
	inc	big_sprite_mask_smc1+2

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


