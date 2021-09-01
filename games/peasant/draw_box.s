	;========================
	; draw dialog box
	;========================
	; from X1H:X1L,Y1 to X2H:X2L, Y2
	;   FIXME: X1H/X2H mostly ignored
draw_box:

	; draw rectangle

	lda	#$33		; color is white1
	sta	VGI_RCOLOR

	lda	BOX_X1L
	sta	VGI_RX1
	lda	BOX_Y1
	sta	VGI_RY1

	sec
	lda	BOX_X2L
	sbc	BOX_X1L
	sta	VGI_RXRUN

	sec
	lda	BOX_Y2
	sbc	BOX_Y1
	sta	VGI_RYRUN

	jsr	vgi_simple_rectangle

	; draw lines

	ldx	#2			; color is purple
	lda     colortbl,X
        sta     HGR_COLOR

	; draw outer rectangle, x+6, y+5      x-6, y-5

	clc
	lda	BOX_X1L
	adc	#6
	sta	BOX_X1L

	sec
	lda	BOX_X2L
	sbc	#6
	sta	BOX_X2L

	clc
	lda	BOX_Y1
	adc	#5
	sta	BOX_Y1

	sec
	lda	BOX_Y2
	sbc	#5
	sta	BOX_Y2

	jsr	draw_rectangle

	; draw inner rectangle, x+7, y+6      x-7, y-6

	inc	BOX_X1L
	dec	BOX_X2L
	inc	BOX_Y1
	dec	BOX_Y2

	jsr	draw_rectangle

	; make vertical line extra thick

	inc	BOX_X1L
	dec	BOX_X2L

	jsr	draw_rectangle

	; make vertical line extra thick

	inc	BOX_X1L
	dec	BOX_X2L

	jsr	draw_rectangle


	rts



draw_rectangle:

	ldy	#0
	ldx	BOX_X1L
	lda	BOX_Y1
	jsr     HPLOT0          ; plot at (Y,X), (A)

	ldx	#0
	lda	BOX_X2L
	ldy	BOX_Y1
	jsr     HGLIN           ; line to (X,A),(Y)

	ldx	#0
	lda	BOX_X2L
	ldy	BOX_Y2
	jsr     HGLIN           ; line to (X,A),(Y)

	ldx	#0
	lda	BOX_X1L
	ldy	BOX_Y2
	jsr     HGLIN           ; line to (X,A),(Y)

	ldx	#0
	lda	BOX_X1L
	ldy	BOX_Y1
	jsr     HGLIN           ; line to (X,A),(Y)

	rts

