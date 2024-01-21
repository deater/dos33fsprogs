
	;=======================================
	; scrolls to PAGE1
	;	relies on going off the edge...
	;=======================================

hgr_vertical_scroll:
	ldx	#0

outer_vscroll_loop:
	lda	hposn_low,X
	sta	OUTL
	lda	hposn_high,X
	sta	OUTH

	txa
	clc
	adc	#8
	tay
	lda	hposn_low,y
	sta	INL
	lda	hposn_high,Y
	sta	INH

	ldy	#29
inner_vscroll_loop:
	lda	(INL),Y
	sta	(OUTL),Y
	dey
	cpy	#9
	bpl	inner_vscroll_loop

	inx
	cpx	#184
	bne	outer_vscroll_loop


	;================================
	; copy in off screen

	; for now from 0..19

hgr_vertical_scroll2:
	ldx	#184

outer_vscroll_loop2:
	lda	hposn_low,X
	clc
	adc	#10
	sta	OUTL

	lda	hposn_high,X
	sta	OUTH

	ldy	COUNT
	lda	hposn_low,Y
	sta	INL
	lda	hposn_high,Y
	clc
	adc	#$40			; load from $6000
	sta	INH

	ldy	#19
inner_vscroll_loop2:
	lda	(INL),Y
	sta	(OUTL),Y
	dey
	bpl	inner_vscroll_loop2

	inc	COUNT

	inx
	cpx	#192
	bne	outer_vscroll_loop2



	rts

