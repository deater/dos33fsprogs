	;===========================================
	; hgr draw sprite (only at 7-bit boundaries)
	;===========================================
	; SPRITE in INL/INH
	; Location at CURSOR_X CURSOR_Y

	; xsize, ysize  in first two bytes

	; sprite AT INL/INH

hgr_draw_sprite:

	ldy	#0
	lda	(INL),Y			; load xsize
	clc
	adc	CURSOR_X
	sta	sprite_width_end_smc+1	; self modify for end of line

	iny				; load ysize
	lda	(INL),Y
	sta	sprite_ysize_smc+1	; self modify

	; skip the xsize/ysize and point to sprite
	clc
	lda	INL			; 16-bit add
	adc	#2
	sta	sprite_smc1+1
	lda	INH
	adc	#0
	sta	sprite_smc1+2

	ldx	#0			; X is pointer offset

	stx	MASK			; actual row

hgr_sprite_yloop:

	lda	MASK			; row

	clc
	adc	CURSOR_Y		; add in cursor_y

	; calc GBASL/GBASH

	tay				; get output ROW into GBASL/H
	lda	hposn_low,Y
	sta	GBASL
	lda	hposn_high,Y

	; eor	#$00 draws on page2
	; eor	#$60 draws on page1
hgr_sprite_page_smc:
	eor	#$00
	sta	GBASH

	ldy	CURSOR_X

sprite_inner_loop:

sprite_smc1:
	lda	$d000		; get sprite pattern
	sta	(GBASL),Y	; store out

	inx
	iny


	inc	sprite_smc1+1
	bne	sprite_noflo
	inc	sprite_smc1+2
sprite_noflo:

sprite_width_end_smc:
	cpy	#6
	bne	sprite_inner_loop


	inc	MASK		; row
	lda	MASK		; row

sprite_ysize_smc:
	cmp	#31
	bne	hgr_sprite_yloop

	rts

