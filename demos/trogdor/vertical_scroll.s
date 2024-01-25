
	;=======================================
	; hgr_vertical scroll
	;=======================================
	; scrolls from $6000 to page1
	; 	jumps increments of 8 for speed
	;=======================================
	; offset line in $6000 to copy in from in COUNT

hgr_vertical_scroll_left:
	lda	#0
	beq	hgr_vertical_scroll_common
hgr_vertical_scroll_right:
	lda	#20
hgr_vertical_scroll_common:
	sta	vscroll_offset_smc+1

hgr_vertical_scroll:
	ldx	#0				; start at top

outer_vscroll_loop:
	lda	hposn_low,X			; get page1 address
	sta	OUTL				; set as output
	lda	hposn_high,X
	sta	OUTH

	txa					; get address of X+8
	clc					; and set as input
	adc	#8
	tay
	lda	hposn_low,y
	sta	INL
	lda	hposn_high,Y
	sta	INH

	ldy	#29				; only scroll from 9..29
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
	ldx	#184			; start 8 from bottom

outer_vscroll_loop2:
	lda	hposn_low,X
	clc
	adc	#10			; copy to middle of screen
	sta	OUTL

	lda	hposn_high,X
	sta	OUTH

	ldy	COUNT
	lda	hposn_low,Y
	clc
vscroll_offset_smc:
	adc	#$0
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

