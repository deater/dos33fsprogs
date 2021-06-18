; VGI Lines

	;========================
	; VGI point
	;========================

	VGI_PCOLOR	= P0
	VGI_PX		= P1
	VGI_PY		= P2

vgi_point:
	ldx	VGI_PCOLOR
	lda	COLORTBL,X
	sta	HGR_COLOR

	ldy	#0
	ldx	VGI_PX
	lda	VGI_PY

	jsr	HPLOT0		; plot at (Y,X), (A)

	jmp	vgi_loop




	;========================
	; VGI line to
	;========================
	VGI_LX	= P0
	VGI_LY	= P1

vgi_lineto:
	ldx	#0
	ldy	VGI_LY
	lda	VGI_LX

	jsr	HGLIN		; line to (X,A),(Y)

	jmp	vgi_loop
