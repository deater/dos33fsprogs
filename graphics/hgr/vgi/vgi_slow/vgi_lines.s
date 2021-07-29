; VGI Lines

	;========================
	; VGI point
	;========================
vgi_point:
	jsr	vgi_point_common
	jmp	vgi_loop


	;========================
	; VGI point common
	;========================

	VGI_PCOLOR	= P0	; if high bit set, then PX=PX+256
	VGI_PX		= P1
	VGI_PY		= P2

vgi_point_common:
	ldy	#0

	lda	VGI_PCOLOR
	bpl	vgi_point_color
	iny
vgi_point_color:
	and	#$7f
	tax
	lda	COLORTBL,X
	sta	HGR_COLOR

	ldx	VGI_PX
	lda	VGI_PY

	jsr	HPLOT0		; plot at (Y,X), (A)

	rts




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


	;========================
	; VGI LINE
	;========================
;	VGI_LX	= P0
;	VGI_LY	= P1
	VGI_LX2 = P3
	VGI_LY2	= P4

vgi_line:
	jsr	vgi_point_common

	ldx	#0
	ldy	VGI_LY2
	lda	VGI_LX2

	jsr	HGLIN		; line to (X,A),(Y)

	jmp	vgi_loop

	;========================
	; VGI LINE FAR
	;========================
	; assume second x-coord is > 256
;	VGI_LX	= P0
;	VGI_LY	= P1
;	VGI_LX2 = P3
;	VGI_LY2	= P4

vgi_line_far:
	jsr	vgi_point_common

	ldx	#1
	ldy	VGI_LY2
	lda	VGI_LX2

	jsr	HGLIN		; line to (X,A),(Y)

	jmp	vgi_loop

