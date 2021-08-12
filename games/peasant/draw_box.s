
	;========================
	; draw dialog box
	;========================

draw_box:

	; draw rectangle

	lda	#$33
	sta	VGI_RCOLOR

	lda	#53
	sta	VGI_RX1
	lda	#24
	sta	VGI_RY1
	lda	#200
	sta	VGI_RXRUN
	lda	#58
	sta	VGI_RYRUN

	jsr	vgi_simple_rectangle

	; draw lines

	ldx	#2			; purple
	lda     COLORTBL,X
        sta     HGR_COLOR

	ldy	#0
	ldx	#59
	lda	#29
	jsr     HPLOT0          ; plot at (Y,X), (A)

	ldx	#0
	lda	#59
	ldy	#78
	jsr     HGLIN           ; line to (X,A),(Y)

	ldy	#0
	ldx	#247
	lda	#29
	jsr     HPLOT0          ; plot at (Y,X), (A)

	ldx	#0
	lda	#247
	ldy	#78
	jsr     HGLIN           ; line to (X,A),(Y)



	ldy	#0
	ldx	#57
	lda	#29
	jsr     HPLOT0          ; plot at (Y,X), (A)

	ldx	#0
	lda	#249
	ldy	#29
	jsr     HGLIN           ; line to (X,A),(Y)

	ldx	#0
	lda	#249
	ldy	#78
	jsr     HGLIN           ; line to (X,A),(Y)

	ldx	#0
	lda	#57
	ldy	#78
	jsr     HGLIN           ; line to (X,A),(Y)

	ldx	#0
	lda	#57
	ldy	#29
	jsr     HGLIN           ; line to (X,A),(Y)



	ldy	#0
	ldx	#58
	lda	#30
	jsr     HPLOT0          ; plot at (Y,X), (A)

	ldx	#0
	lda	#248
	ldy	#30
	jsr     HGLIN           ; line to (X,A),(Y)

	ldx	#0
	lda	#248
	ldy	#77
	jsr     HGLIN           ; line to (X,A),(Y)

	ldx	#0
	lda	#58
	ldy	#77
	jsr     HGLIN           ; line to (X,A),(Y)

	ldx	#0
	lda	#58
	ldy	#30
	jsr     HGLIN           ; line to (X,A),(Y)


	rts
