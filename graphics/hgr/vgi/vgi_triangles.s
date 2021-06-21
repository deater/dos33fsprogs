; VGI Triangles


	;========================
	; VGI vertical triangle
	;========================

	VGI_TCOLOR	= P0
	VGI_VX		= P1
	VGI_VY		= P2
	VGI_TXL		= P3
	VGI_TXR		= P4
	VGI_TYB		= P5

vgi_vertical_triangle:

	ldx	VGI_TCOLOR
	lda	COLORTBL,X
	sta	HGR_COLOR

vtri_loop:
	ldy	#0
	ldx	VGI_VX
	lda	VGI_VY

	jsr	HPLOT0		; plot at (Y,X), (A)


	ldx	#0
	ldy	VGI_TYB
	lda	VGI_TXL

	jsr	HGLIN		; line to (X,A),(Y)

	inc	VGI_TXL
	lda	VGI_TXL
	cmp	VGI_TXR
	bcc	vtri_loop

done_vtri:
	jmp	vgi_loop


vgi_horizontal_triangle:
	jmp	vgi_loop
