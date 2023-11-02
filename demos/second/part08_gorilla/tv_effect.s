
	;===========================
	; tv turning off effect
	;===========================
tv_effect:

	ldx	#0
	lda	#191
	sta	COUNT			; count = bottom
compact_loop:

	stx	SAVEX			; X = top

	;=======================
	; zero out bottom line

	ldx	COUNT

	lda	hposn_low,X
	sta	GBASL
	lda	hposn_high,X
	sta	GBASH

	lda	#0
	ldy	#39
compact_inner_loop2:
	sta	(GBASL),Y
	dey
	bpl	compact_inner_loop2

	dec	COUNT

	;=======================
	; zero out top line

	ldx	SAVEX

compact_not_even:

	lda	hposn_low,X
	sta	GBASL
	lda	hposn_high,X
	sta	GBASH

	lda	#0
	ldy	#39
compact_inner_loop:
	sta	(GBASL),Y
	dey
	bpl	compact_inner_loop

	lda	#10
	jsr	wait

	inx
	cpx	#95
	bne	compact_loop

	lda	#100
	jsr	wait

	;=================================
	; now close it down horizontally


	ldx	#95
	lda	hposn_low,X
	sta	GBASL
	lda	hposn_high,X
	sta	GBASH
	inx
	lda	hposn_low,X
	sta	OUTL
	lda	hposn_high,X
	sta	OUTH

	lda	#39
	sta	COUNT
	ldy	#0
zappo_outer_loop:

	ldx	#0
zappo_inner_loop:
	lda	pixel_pattern_left,X
	sta	(OUTL),Y
	sta	(GBASL),Y
	tya
	pha

	ldy	COUNT
	lda	pixel_pattern_right,X
	sta	(OUTL),Y
	sta	(GBASL),Y
	pla
	tay

	inx
	cpx	#8
	bne	zappo_inner_loop

	lda	#75
	jsr	wait

	dec	COUNT

	iny
	cpy	#20
	bne	zappo_outer_loop

	rts


pixel_pattern_left:
	.byte	$7f,$7e,$7c,$78,$70,$60,$40,$00

pixel_pattern_right:
	.byte	$7F,$3F,$1F,$0F,$07,$03,$01,$00
