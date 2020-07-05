	; turn on double high point at CH,CV
plot_point:
	lda	CV		; y
	lsr
	lsr
	and	#$fe		; make even
	tax
	lda	gr_offsets,X
	sta	OUTL

	lda	gr_offsets+1,X
	clc
	adc	DRAW_PAGE
	sta	OUTH

	lda	CH		; X * 2
	lsr
	tay

plot_color:
	lda	#$77
	sta	(OUTL),Y

	rts

