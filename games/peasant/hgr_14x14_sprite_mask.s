	;===============================
	; hgr 14x14 draw sprite with mask
	;===============================
	; SPRITE in INL/INH
	; Location at CURSOR_X CURSOR_Y

	; sprite AT INL/INH
	; mask at INL/INH + 28

hgr_draw_sprite_14x14:

	; set up sprite pointers
	lda	INL
	sta	h1414_smc1+1
	sta	h1414_smc2+1
	lda	INH
	sta	h1414_smc1+2
	sta	h1414_smc2+2

;	clc
;	lda	INL
;	adc	#1
;	sta	h1414_smc2+1
;	lda	INH
;	adc	#0
;	sta	h1414_smc2+2

	; set up mask pointers
	clc
	lda	INL
	adc	#28
	sta	h1414_smc3+1
	sta	h1414_smc4+1
	lda	INH
	adc	#0
	sta	h1414_smc3+2
	sta	h1414_smc4+2

;	clc
;	lda	INL
;	adc	#29
;	sta	h1414_smc4+1
;	lda	INH
;	adc	#0
;	sta	h1414_smc4+2



	ldx	#0			; X is pointer offset
	stx	MASK			; actually counter

hgr_14x14_sprite_yloop:

	lda	MASK

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
h1414_smc3:
	and	$d000,X		; mask with sprite mask
h1414_smc1:
	ora	$d000,X		; or in sprite
	sta	(GBASL),Y	; store out

	inx
	iny

	lda	(GBASL),Y	; load background
h1414_smc4:
	and	$d000,X		; mask with sprite mask
h1414_smc2:
	ora	$d000,X		; or in sprite
	sta	(GBASL),Y	; store out

	inx

	inc	MASK
	lda	MASK

	cmp	#14
	bne	hgr_14x14_sprite_yloop

	rts


	;======================
	; save bg 14x14
	;======================

save_bg_14x14:

	ldx	#0
save_yloop:
	txa
	pha

	lsr

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
	sta	save_sprite_14x14,X

	iny
	inx

	lda	(GBASL),Y
	sta	save_sprite_14x14,X

	inx

	cpx	#28
	bne	save_yloop

	rts

	;======================
	; restore bg 14x14
	;======================

restore_bg_14x14:

	ldx	#0
restore_yloop:
	txa				; current row
	lsr
	clc
	adc	CURSOR_Y		; add in y start point

	; calc GBASL/GBASH using lookup table

	tay
	lda	hposn_low,Y
	sta	GBASL
	lda	hposn_high,Y
	sta	GBASH

	ldy	CURSOR_X

	lda	save_sprite_14x14,X
	sta	(GBASL),Y

	inx
	iny

	lda	save_sprite_14x14,X
	sta	(GBASL),Y

	inx
	cpx	#28
	bne	restore_yloop

	rts

;====================
; save area
;====================

save_sprite_14x14:
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00
.byte $00,$00,$00,$00,$00,$00,$00,$00


