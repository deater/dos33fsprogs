	;===========================================
	; hgr draw sprite (only at 7-bit boundaries)
	;===========================================
	; SPRITE in INL/INH
	; Location at SPRITE_X SPRITE_Y

	; xsize, ysize  in first two bytes

	; sprite AT INL/INH

hgr_draw_sprite:

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

