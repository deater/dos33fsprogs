
	;===============================================
	; hgr 7x28 draw sprite
	;===============================================
	; SPRITE in INL/INH
	; Location at CURSOR_X CURSOR_Y

	; left sprite AT INL/INH
	; right sprite at INL/INH + 14
	; left mask at INL/INH + 28
	; right mask at INL/INH + 42

hgr_draw_sprite_7x28:

	; set up pointers
	lda	INL
	sta	h728_smc1+1
	lda	INH
	sta	h728_smc1+2

	clc
	lda	INL
	adc	#28
	sta	h728_smc3+1
	lda	INH
	adc	#0
	sta	h728_smc3+2

	ldx	#0			; X is row counter
hgr_7x28_sprite_yloop:
	txa				; X is current row

	clc
	adc	CURSOR_Y		; add in cursor_y

	; calc GBASL/GBASH

	tay				; get output ROW into GBASL/H
	lda	hposn_low,Y
	sta	GBASL
	lda	hposn_high,Y
	sta	GBASH

	ldy	CURSOR_X

	lda	(GBASL),Y	; load background
h728_smc3:
	and	$d000,X		; mask with sprite mask
h728_smc1:
	ora	$d000,X		; or in sprite
	sta	(GBASL),Y	; store out

	inx
	cpx	#28
	bne	hgr_7x28_sprite_yloop

	rts


	;======================
	; save bg 7x28
	;======================

save_bg_7x28:

	ldx	#0
save_yloop:
	txa
	pha

	clc
	adc	CURSOR_Y


	; calc GBASL/GBASH

	tax
	lda	hposn_low,X
	sta	GBASL
	lda	hposn_high,X
	sta	GBASH

	pla
	tax

	ldy	CURSOR_X

	lda	(GBASL),Y
	sta	save_sprite_7x28,X

	inx
	cpx	#28
	bne	save_yloop

	rts

	;======================
	; restore bg 7x28
	;======================

restore_bg_7x28:

	ldx	#0
restore_yloop:
	txa				; current row
	clc
	adc	CURSOR_Y		; add in y start point

	; calc GBASL/GBASH using lookup table

	tay
	lda	hposn_low,Y
	sta	GBASL
	lda	hposn_high,Y
	sta	GBASH

	ldy	CURSOR_X

	lda	save_sprite_7x28,X
	sta	(GBASL),Y

	inx
	cpx	#28
	bne	restore_yloop

	rts


;====================
; save area
;====================

save_sprite_7x28:
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
