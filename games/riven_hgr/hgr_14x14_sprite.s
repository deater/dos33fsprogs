
	;======================
	; hgr 14x14 draw sprite
	;======================
	; SPRITE in INL/INH
	; Location at CURSOR_X CURSOR_Y

	; sprite at INL/INH
	; mask at INL/INH + 28

hgr_draw_sprite_14x14:

	; set up pointers for sprite
	lda	INL
	sta	hds_smc1+1
	sta	hds_smc2+1
	lda	INH
	sta	hds_smc1+2
	sta	hds_smc2+2

	; setup pointers for mask

	clc
	lda	INL
	adc	#28
	sta	hds_smc3+1
	sta	hds_smc4+1
	lda	INH
	adc	#0
	sta	hds_smc3+2
	sta	hds_smc4+2


	ldx	#0
hgr_14x14_sprite_yloop:
	txa

	lsr			; get Ypos from X

	clc
	adc	CURSOR_Y

	tay			; point GBASL/GBASH to Ypos row
	lda	hposn_high,Y
	sta	GBASH
	lda	hposn_low,Y
	sta	GBASL

;	pla
;	tax

	ldy	CURSOR_X		; point to Xpos

	lda	(GBASL),Y		; load background color
hds_smc3:
	and	point_mask,X
hds_smc1:
	ora	point_sprite,X
	sta	(GBASL),Y

	iny
	inx

	lda	(GBASL),Y
hds_smc4:
	and	point_mask,X
hds_smc2:
	ora	point_sprite,X
	sta	(GBASL),Y

	inx
	cpx	#28
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

;	ldx	#0
;	ldy	#0

	tax
	lda	hposn_high,X
	sta	GBASH
	lda	hposn_low,X
	sta	GBASL

	; calc GBASL/GBASH
;	jsr	HPOSN	; (Y,X),(A)  (values stored in HGRX,XH,Y)

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

;	ldx	#0
;	ldy	#0

	tax
	lda	hposn_high,X
	sta	GBASH
	lda	hposn_low,X
	sta	GBASL

	; calc GBASL/GBASH
;	jsr	HPOSN	; (Y,X),(A)  (values stored in HGRX,XH,Y)

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
