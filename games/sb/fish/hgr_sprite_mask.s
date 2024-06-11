	;================================================
	; hgr draw sprite mask (only at 7-bit boundaries)
	;================================================
	; SPRITE in INL/INH
	; MASK in MASKL/MASKH

	; Location at SPRITE_X SPRITE_Y

	; xsize, ysize  in first two bytes

	; sprite AT INL/INH

hgr_draw_sprite_mask:

	ldy	#0
	lda	(INL),Y			; load xsize
	clc
	adc	SPRITE_X
	sta	hsm_sprite_width_end_smc+1	; self modify for end of line

	iny				; load ysize
	lda	(INL),Y
	sta	hsm_sprite_ysize_smc+1	; self modify

	; point smc to sprite
	lda	INL			; 16-bit add
	sta	hsm_sprite_smc1+1
	lda	INH
	sta	hsm_sprite_smc1+2

	lda	MASKL
	sta	hsm_mask_smc1+1
	lda	MASKH
	sta	hsm_mask_smc1+2

	ldx	#0			; X is pointer offset
	stx	CURRENT_ROW		; actual row

	ldx	#2

hgr_sm_sprite_yloop:

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

hgr_sm_sprite_inner_loop:


	lda     (GBASL),Y		; load bg
hsm_sprite_smc1:
        eor     $f000,X			; load sprite data
hsm_mask_smc1:
	and	$f000,X
	eor	(GBASL),Y
	sta	(GBASL),Y		; store to screen

	inx				; increment sprite offset
	iny				; increment output position


hsm_sprite_width_end_smc:
	cpy	#6				; see if reached end of row
	bne	hgr_sm_sprite_inner_loop	; if not, loop


	inc	CURRENT_ROW		; row
	lda	CURRENT_ROW		; row

hsm_sprite_ysize_smc:
	cmp	#31			; see if at end
	bne	hgr_sm_sprite_yloop	; if not, loop

	rts



