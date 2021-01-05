	;================================
	; plot routine
	;================================
	; Xcoord in X
	; Ycoord in A
	; color in COLOR
plot:
	stx	XPOS
	lsr			; shift bottom bit into carry		; 2

	bcc	plot_even						; 2nt/3
plot_odd:
	ldx	#$f0							; 2
	bcs	plot_c_done						; 2nt/3
plot_even:
	ldx	#$0f							; 2
plot_c_done:
	stx	MASK							; 3

	asl			; shift back (now even)			; 2
	tay

	lda	gr_offsets,Y	; lookup low-res memory address		; 4
        clc								; 2
        adc	XPOS							; 3
        sta	GBASL							; 3
        iny								; 2

        lda	gr_offsets,Y                                            ; 4
        adc	DRAW_PAGE	; add in draw page offset		; 3
        sta	GBASH							; 3

	ldy	#0							; 2

plot_write:
	lda	MASK							; 3
	eor	#$ff							; 2

	and	(GBASL),Y						; 5
	sta	COLOR_MASK						; 3

	lda	COLOR							; 3
	and	MASK							; 3
	ora	COLOR_MASK						; 3
	sta	(GBASL),Y						; 5

	rts								; 6
