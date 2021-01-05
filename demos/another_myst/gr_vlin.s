
	;=========================================
	; vlin
	;=========================================
	; X, V2 at Y
	; from x=top, v2=bottom
vlin:

	sty	TEMPY		; save Y (x location)
vlin_loop:

	txa			; a=x	(get first y)
	and	#$fe		; Clear bottom bit
	tay			;
	lda	gr_offsets,Y	; lookup low-res memory address low
	sta	GBASL		; put it into our indirect pointer
	iny
	lda	gr_offsets,Y	; lookup low-res memory address high
	clc
	adc	DRAW_PAGE	; add in draw page offset
	sta	GBASH		; put into top of indirect

	ldy	TEMPY		; load back in y (x offset)

	txa			; load back in x (current y)
	lsr			; check the low bit
	bcc	vlin_low	; if not set, skip to low

vlin_high:
	lda	#$F0		; setup masks
	sta	MASK
	lda	#$0f
	bcs	vlin_too_slow

vlin_low:			; setup masks
	lda	#$0f
	sta	MASK
	lda	#$f0
vlin_too_slow:

	and	(GBASL),Y	; mask current byte
	sta	(GBASL),Y	; and store back

	lda	MASK		; mask the color
	and	COLOR
	ora	(GBASL),Y	; or into the right place
	sta	(GBASL),Y	; store it

	inx			; increment X (current y)
	cpx	V2		; compare to the limit
	bcc	vlin_loop	; if <= then loop

	rts			; return


