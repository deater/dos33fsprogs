; VGI Triangles

SKIP	= $70

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
	lda	VGI_TCOLOR
	lsr
	lsr
	lsr
	lsr
	sta	SKIP

	lda	VGI_TCOLOR
	and	#$f
	tax
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

	lda	VGI_TXL
	clc
	adc	SKIP
	sta	VGI_TXL
;	inc	VGI_TXL
;	lda	VGI_TXL
	cmp	VGI_TXR
	bcc	vtri_loop

done_vtri:
	jmp	vgi_loop	; bra



	;========================
	; VGI horizontal triangle
	;========================

;	VGI_TCOLOR	= P0
;	VGI_VX		= P1
;	VGI_VY		= P2
	VGI_THYT	= P3
	VGI_THYB	= P4
	VGI_THXR	= P5

vgi_horizontal_triangle:

	ldx	VGI_TCOLOR
	lda	COLORTBL,X
	sta	HGR_COLOR

htri_loop:
	ldy	#0
	ldx	VGI_VX
	lda	VGI_VY

	jsr	HPLOT0		; plot at (Y,X), (A)


	ldx	#0
	ldy	VGI_THYT
	lda	VGI_THXR

	jsr	HGLIN		; line to (X,A),(Y)

	inc	VGI_THYT
	lda	VGI_THYT
	cmp	VGI_THYB
	bcc	htri_loop

done_htri:
	jmp	vgi_loop

