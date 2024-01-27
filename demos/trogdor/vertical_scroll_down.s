	;=======================================
	; hgr_vertical scroll_down
	;=======================================
	; scrolls from $6000 to page1
	; 	jumps increments of 8 for speed
	;=======================================

hgr_vertical_scroll_down_left:
;	lda	#0
;	beq	hgr_vertical_scroll_down_common
hgr_vertical_scroll_down_right:
;	lda	#20
hgr_vertical_scroll_down_common:
;	sta	vscroll_down_offset_smc+1

hgr_vertical_scroll_down:

	ldx	#183				; start at bottom

outer_vscroll_down_loop:
	lda	hposn_low,X			; get page1 address
	sta	INL				; set as output
	lda	hposn_high,X
	sta	INH

	txa					; get address of X+8
	clc					; and set as output
	adc	#8
	tay
	lda	hposn_low,y
	sta	OUTL
	lda	hposn_high,Y
	sta	OUTH

	ldy	#29				; only scroll from 9..29
inner_vscroll_down_loop:
	lda	(INL),Y
	sta	(OUTL),Y
	dey
	cpy	#9
	bpl	inner_vscroll_down_loop

	dex
	cpx	#$FF
	bne	outer_vscroll_down_loop


	;================================
	; copy in off screen
	; for now assume all white


	ldx	#7			; start at top

outer_vscroll_down_loop2:
	lda	hposn_low,X
	sta	OUTL
	lda	hposn_high,X
	sta	OUTH

	ldy	#39
	lda	#$7f
inner_vscroll_down_loop2:
	sta	(OUTL),Y
	dey
	bpl	inner_vscroll_down_loop2

	dex
	bpl	outer_vscroll_down_loop2

	rts

