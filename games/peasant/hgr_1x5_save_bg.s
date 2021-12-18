	;======================
	; save bg 1x5
	;======================

save_bg_1x5:

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
	sta	save_sprite_1x5,X

	inx
	cpx	#5
	bne	save_yloop

	rts

	;======================
	; restore bg 1x5
	;======================

restore_bg_1x5:

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

	lda	save_sprite_1x5,X
	sta	(GBASL),Y

	inx
	cpx	#5
	bne	restore_yloop

	rts


;====================
; save area
;====================

save_sprite_1x5:
.byte $00,$00,$00,$00,$00

;ysave:
;.byte $00
;xsave:
;.byte $00
