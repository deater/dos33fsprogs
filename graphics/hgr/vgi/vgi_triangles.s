; VGI Triangles

	;========================
	; VGI vertical triangle
	;========================

	VGI_TCOLOR	= P0
	VGI_VX		= P1
	VGI_VY		= P2
	VGI_TX1		= P3
	VGI_TX2		= P4

vgi_vertical_triangle:

	ldx	VGI_TCOLOR
	lda	COLORTBL,X
	sta	HGR_COLOR

	ldy	#0
	ldx	VGI_VX
	lda	VGI_VY

	jsr	HPLOT0		; plot at (Y,X), (A)


;	ldx	#0
;	ldy	VGI_LY
;	lda	VGI_LX

;	jsr	HGLIN		; line to (X,A),(Y)

;	jmp	vgi_loop


	jmp	vgi_loop


vgi_horizontal_triangle:
	jmp	vgi_loop
