	;=====================
	; make the sky grey
	;	page $A000
	;	make $FF/$7F to be black/white pattern?

	;	$55/$2A = purple?
	;		need $55 to be in even column?

grey_sky:

	ldx	#0			; 12 on normal
grey_outer:
	lda	hposn_low,X
	sta	GBASL
	lda	hposn_high,X
	clc
	adc	#($A0-$20)
	sta	GBASH

	ldy	#0
grey_loop:
	tya
	lsr
	lda	#$55
	bcc	skip_col
	lsr
skip_col:

	cmp	(GBASL),Y
;	cmp	#$7F
;	cmp	#$55
;	beq	grey_swap
;	cmp	#$ff
;	cmp	#$2A
	bne	grey_continue
grey_swap:

	tya
	pha
	and	#$3
	tay
	txa
	and	#$1
	bne	oog

	iny
	iny
	tya
	and	#$3
	tay
oog:

	lda	grey_lookup,Y
	sta	TEMP
	pla
	tay

	lda	(GBASL),Y
	eor	TEMP			; 0 011 0011	$33
					; 0 110 0110	$66
					; 0 100 1100	$4C
					; 0 001 1001	$19
	sta	(GBASL),Y
grey_continue:
	iny
	cpy	#40
	bne	grey_loop

	inx
	cpx	#24
	bne	grey_outer

	rts


grey_lookup:
	.byte $33,$66,$4C,$19
