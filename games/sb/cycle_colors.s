
; used for title of strongbadzone

cycle_colors:

	lda	FRAME
	lsr
	lsr
	lsr
	and	#$3
	tax

	lda	color_opcodes,X
	sta	color_change1_smc
	sta	color_change2_smc

	lda	color_mask_odd,X
	sta	color_change1_smc+1

	lda	color_mask_even,X
	sta	color_change2_smc+1


	ldx	#50
color_loop:

	lda	hposn_high,X
	sta	OUTH
	eor	#$60
	sta	INH

	lda	hposn_low,X
	sta	OUTL
	sta	INL

	ldy	#39

color_inner_loop:


	lda	(INL),Y
color_change1_smc:
	and	#$AA
	sta	(OUTL),Y
	dey

	lda	(INL),Y
color_change2_smc:
	and	#$55
	sta	(OUTL),Y
	dey


	bpl	color_inner_loop

	dex
	bne	color_loop


	rts



color_opcodes:
	.byte	$29,$29,$09,$29		; and = $29  ora=$09
color_mask_odd:
	.byte	$AA,$7f,$00,$D5
color_mask_even:
	.byte	$D5,$7f,$00,$AA
