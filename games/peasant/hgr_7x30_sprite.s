
	;======================
	; hgr 7x30 draw sprite
	;======================
	; SPRITE in INL/INH
	; Location at CURSOR_X CURSOR_Y

	; left sprite AT INL/INH
	; right sprite at INL/INH + 14
	; left mask at INL/INH + 28
	; right mask at INL/INH + 42

hgr_draw_sprite_7x30:

	; set up pointers
	lda	INL
	sta	h730_smc1+1
	lda	INH
	sta	h730_smc1+2

	clc
	lda	INL
	adc	#30
	sta	h730_smc3+1
	lda	INH
	adc	#0
	sta	h730_smc3+2

	ldx	#0
hgr_7x30_sprite_yloop:
	txa
	pha

	clc
	adc	CURSOR_Y

	ldx	#0
	ldy	#0

	; calc GBASL/GBASH
;	jsr	HPOSN	; (Y,X),(A)  (values stored in HGRX,XH,Y)

	tax
	lda	hposn_low,X
	sta	GBASL
	lda	hposn_high,X
	sta	GBASH

	pla
	tax

	ldy	CURSOR_X

	lda	(GBASL),Y
h730_smc3:
	and	$d000,X		; mask
h730_smc1:
	ora	$d000,X		; sprite
	sta	(GBASL),Y

	inx
	cpx	#30
	bne	hgr_7x30_sprite_yloop

	rts



	;======================
	; save bg 7x30
	;======================

save_bg_7x30:

	ldx	#0
save_yloop:
	txa
	pha

	clc
	adc	CURSOR_Y

	ldx	#0
	ldy	#0

	; calc GBASL/GBASH
;	jsr	HPOSN	; (Y,X),(A)  (values stored in HGRX,XH,Y)

	tax
	lda	hposn_low,X
	sta	GBASL
	lda	hposn_high,X
	sta	GBASH

	pla
	tax

	ldy	CURSOR_X

	lda	(GBASL),Y
	sta	save_sprite_7x30,X

	inx
	cpx	#30
	bne	save_yloop

	rts

	;======================
	; restore bg 7x30
	;======================

restore_bg_7x30:

	ldx	#0
restore_yloop:
	txa
	pha

	clc
	adc	CURSOR_Y

	ldx	#0
	ldy	#0

	; calc GBASL/GBASH
;	jsr	HPOSN	; (Y,X),(A)  (values stored in HGRX,XH,Y)

	tax
	lda	hposn_low,X
	sta	GBASL
	lda	hposn_high,X
	sta	GBASH

	pla
	tax

	ldy	CURSOR_X

	lda	save_sprite_7x30,X
	sta	(GBASL),Y

	inx
	cpx	#30
	bne	restore_yloop

	rts


;====================
; save area
;====================

save_sprite_7x30:
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
