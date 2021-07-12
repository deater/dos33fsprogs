
	;======================
	; hgr 14x14 draw sprite
	;======================
	; SPRITE in OUTL/OUTH
	; Location at CURSOR_X CURSOR_Y

	; left sprite AT OUTL/OUTH
	; right sprite at OUTL/OUTH + 14
	; left mask at OUTL/OUTH + 28
	; right mask at OUTL/OUTH + 42

hgr_draw_sprite_14x14:

	; set up pointers
	lda	OUTL
	sta	hds_smc1+1
	lda	OUTH
	sta	hds_smc1+2

	clc
	lda	OUTL
	adc	#14
	sta	hds_smc2+1
	lda	OUTH
	adc	#0
	sta	hds_smc2+2

	clc
	lda	OUTL
	adc	#28
	sta	hds_smc3+1
	lda	OUTH
	adc	#0
	sta	hds_smc3+2

	clc
	lda	OUTL
	adc	#42
	sta	hds_smc4+1
	lda	OUTH
	adc	#0
	sta	hds_smc4+2


	ldx	#0
hgr_14x14_sprite_yloop:
	txa
	pha

	clc
	adc	CURSOR_Y

	ldx	#0
	ldy	#0

	; calc GBASL/GBASH
	jsr	HPOSN	; (Y,X),(A)  (values stored in HGRX,XH,Y)

	pla
	tax

	ldy	CURSOR_X

	lda	(GBASL),Y
hds_smc3:
	and	point_mask_l,X
hds_smc1:
	ora	point_sprite_l,X
	sta	(GBASL),Y

	iny

	lda	(GBASL),Y
hds_smc4:
	and	point_mask_r,X
hds_smc2:
	ora	point_sprite_r,X
	sta	(GBASL),Y

	inx
	cpx	#14
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

	clc
	adc	CURSOR_Y

	ldx	#0
	ldy	#0

	; calc GBASL/GBASH
	jsr	HPOSN	; (Y,X),(A)  (values stored in HGRX,XH,Y)

	pla
	tax

	ldy	CURSOR_X

	lda	(GBASL),Y
	sta	save_left_14x14,X

	iny

	lda	(GBASL),Y
	sta	save_right_14x14,X

	inx
	cpx	#14
	bne	save_yloop

	rts

	;======================
	; restore bg 14x14
	;======================

restore_bg_14x14:

	ldx	#0
restore_yloop:
	txa
	pha

	clc
	adc	CURSOR_Y

	ldx	#0
	ldy	#0

	; calc GBASL/GBASH
	jsr	HPOSN	; (Y,X),(A)  (values stored in HGRX,XH,Y)

	pla
	tax

	ldy	CURSOR_X

	lda	save_left_14x14,X
	sta	(GBASL),Y

	iny

	lda	save_right_14x14,X
	sta	(GBASL),Y


	inx
	cpx	#14
	bne	restore_yloop

	rts


;====================
; save area
;====================

save_right_14x14:
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00

save_left_14x14:
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
