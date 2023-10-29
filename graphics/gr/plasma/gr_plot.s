	;================================
	; plot_setup
	;================================
	; sets up GBASL/GBASH and MASK
	; Ycoord in A
	; trashes Y/A

plot_setup:

	lsr			; shift bottom bit into carry		; 2

	bcc	plot_even						; 2nt/3
plot_odd:
	ldy	#$f0							; 2
	bcs	plot_c_done						; 2nt/3
plot_even:
	ldy	#$0f							; 2
plot_c_done:
	sty	MASK							; 3

	asl			; shift back (now even)			; 2
	tay								; 2

	lda	gr_offsets,Y	; lookup low-res memory address		; 4
 ;       clc								; 2
;        adc	XPOS							; 3
        sta	GBASL							; 3

        lda	gr_offsets+1,Y						; 4
	clc
        adc	DRAW_PAGE	; add in draw page offset		; 3
        sta	GBASH							; 3

	rts


	;================================
	; plot1
	;================================
	; plots pixel of COLOR at GBASL/GBASH:Y
	; Xcoord in Y

plot1:
	lda	MASK							; 3
	eor	#$ff							; 2

	and	(GBASL),Y						; 5+
	sta	COLOR_MASK						; 3

	lda	COLOR							; 3
	and	MASK							; 3
	ora	COLOR_MASK						; 3
	sta	(GBASL),Y						; 6

	rts								; 6
