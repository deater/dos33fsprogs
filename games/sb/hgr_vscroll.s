	;================================
	; HGR vscroll
	;================================
	; image to scroll in is in $A000

hgr_vscroll:

	ldx	#191
	stx	SCROLL		; SCROLL = 0

vscroll_loop:

	; for x=0 to 192-SCROLL
	; write 40 bytes of 00

	ldx	#0
vscroll_inner:
	lda	hposn_high,X
	sta	OUTH
	lda	hposn_low,X
	sta	OUTL

	ldy	#39
	lda	#0
vscroll_line:
	sta	(OUTL),Y
	dey
	bpl	vscroll_line

	inx
	cpx	SCROLL
	bne	vscroll_inner

	;====================
	; draw bottom part

	lda	#0
	sta	SCROLL_OFFSET
vscroll_bottom:
	stx	XSAVE

	ldx	SCROLL_OFFSET
	lda	hposn_high,X
	clc
	adc	#$80		; ora instead?
	sta	INH
	lda	hposn_low,X
	sta	INL

	inc	SCROLL_OFFSET

	ldx	XSAVE

	lda	hposn_high,X
	sta	OUTH
	lda	hposn_low,X
	sta	OUTL

	ldy	#39
vscroll_bottom_line:
	lda	(INL),Y
	sta	(OUTL),Y
	dey
	bpl	vscroll_bottom_line

	inx
	cpx	#192
	bne	vscroll_bottom

	;=====================
	; scroll whole screen

	dec	SCROLL
	bne	vscroll_loop

	rts
