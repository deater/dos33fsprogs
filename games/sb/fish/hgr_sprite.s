	;================================================
	; hgr draw sprite (only at 7-bit boundaries)
	;================================================
	; just plain draw the sprite
	; no masking or transparency
	; draws to page DRAWPAGE
	; SPRITE in INL/INH
	; Location at SPRITE_X SPRITE_Y
	; xsize, ysize  in first two bytes

hgr_draw_sprite:

	ldy	#0
	lda	(INL),Y			; load xsize
	clc
	adc	SPRITE_X
	sta	hds_sprite_width_end_smc+1	; self modify for end of line

	iny				; load ysize
	lda	(INL),Y
	sta	hds_sprite_ysize_smc+1	; self modify

	; point smc to sprite
	lda	INL			; 16-bit add
	sta	hds_sprite_smc1+1
	lda	INH
	sta	hds_sprite_smc1+2

	ldx	#0			; X is pointer offset
	stx	CURRENT_ROW		; actual row

	ldx	#2

hgr_ds_yloop:

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

hgr_ds_inner_loop:


hds_sprite_smc1:
	lda	$f000,X			; load sprite data
	sta	(GBASL),Y		; store to screen

	inx				; increment sprite offset
	iny				; increment output position


hds_sprite_width_end_smc:
	cpy	#6			; see if reached end of row

	bne	hgr_ds_inner_loop	; if not, loop

	inc	CURRENT_ROW		; row
	lda	CURRENT_ROW		; row

hds_sprite_ysize_smc:
	cmp	#31			; see if at end

	bne	hgr_ds_yloop		; if not, loop

	rts
